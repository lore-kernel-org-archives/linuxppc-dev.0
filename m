Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGy8Z1cKyzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 14:24:13 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id v78so3111551pgb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 20:24:13 -0700 (PDT)
Date: Wed, 18 Oct 2017 14:24:03 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 05/25] powerpc: helper functions to initialize AMR, IAMR
 and UAMOR registers
Message-ID: <20171018142403.653436bb@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-14-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-14-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  8 Sep 2017 15:44:53 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Introduce  helper functions that can initialize the bits in the AMR,
> IAMR and UAMOR register; the bits that correspond to the given pkey.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h |    1 +
>  arch/powerpc/mm/pkeys.c          |   46 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 133f8c4..5a83ed7 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -26,6 +26,7 @@
>  #define arch_max_pkey()  pkeys_total
>  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
>  				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> +#define AMR_BITS_PER_PKEY 2
>  
>  #define pkey_alloc_mask(pkey) (0x1 << pkey)
>  
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index ebc9e84..178aa33 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -59,3 +59,49 @@ void __init pkey_initialize(void)
>  	for (i = 2; i < (pkeys_total - os_reserved); i++)
>  		initial_allocation_mask &= ~(0x1<<i);
>  }
> +
> +#define PKEY_REG_BITS (sizeof(u64)*8)
> +#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
> +
> +static inline void init_amr(int pkey, u8 init_bits)
> +{
> +	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> +	u64 old_amr = read_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> +

Do we need to check for reserved keys or that is at a layer above?

> +	write_amr(old_amr | new_amr_bits);
> +}
> +
> +static inline void init_iamr(int pkey, u8 init_bits)
> +{
> +	u64 new_iamr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> +	u64 old_iamr = read_iamr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> +
> +	write_iamr(old_iamr | new_iamr_bits);

Do we need to check for reserved keys here?

> +}
> +
> +static void pkey_status_change(int pkey, bool enable)
> +{
> +	u64 old_uamor;
> +
> +	/* reset the AMR and IAMR bits for this key */
> +	init_amr(pkey, 0x0);
> +	init_iamr(pkey, 0x0);
> +
> +	/* enable/disable key */
> +	old_uamor = read_uamor();
> +	if (enable)
> +		old_uamor |= (0x3ul << pkeyshift(pkey));
> +	else
> +		old_uamor &= ~(0x3ul << pkeyshift(pkey));
> +	write_uamor(old_uamor);
> +}
> +
> +void __arch_activate_pkey(int pkey)
> +{
> +	pkey_status_change(pkey, true);
> +}
> +
> +void __arch_deactivate_pkey(int pkey)
> +{
> +	pkey_status_change(pkey, false);
> +}


Balbir Singh.
