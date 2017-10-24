Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLjvS2d2WzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 17:25:56 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9O6P53U008521
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 02:25:53 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dsrrfyyas-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 02:25:53 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 24 Oct 2017 07:25:51 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: Re: [PATCH 05/25] powerpc: helper functions to initialize AMR,
 IAMR and UAMOR registers
In-Reply-To: <1504910713-7094-14-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-14-git-send-email-linuxram@us.ibm.com>
Date: Tue, 24 Oct 2017 11:55:41 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <873769xdsq.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

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
> +	write_amr(old_amr | new_amr_bits);
> +}
> +
> +static inline void init_iamr(int pkey, u8 init_bits)
> +{
> +	u64 new_iamr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> +	u64 old_iamr = read_iamr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> +
> +	write_iamr(old_iamr | new_iamr_bits);
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

That one is confusing, we discussed this outside the list, but want to
bring the list to further discussion. So now the core kernel request
for a key via mm_pkey_alloc(). Why not do the below there

static inline int mm_pkey_alloc(struct mm_struct *mm)
{
	/*
	 * Note: this is the one and only place we make sure
	 * that the pkey is valid as far as the hardware is
	 * concerned.  The rest of the kernel trusts that
	 * only good, valid pkeys come out of here.
	 */
	u32 all_pkeys_mask = (u32)(~(0x0));
	int ret;

	if (!pkey_inited)
		return -1;
	/*
	 * Are we out of pkeys?  We must handle this specially
	 * because ffz() behavior is undefined if there are no
	 * zeros.
	 */
	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
		return -1;

	ret = ffz((u32)mm_pkey_allocation_map(mm));
	mm_set_pkey_allocated(mm, ret);

	return ret;
}

your mm_pkey_allocation_map() should have the keys specified in AMOR and
UAMOR marked as allocatied. It is in use by hypervisor and OS respectively.


There is no need of __arch_activate_key() etc. and by default if the OS
has not requested for a key for its internal use UAMOR should be
0xFFFFFFFF and that AMOR value you derive from the device tree based of
what keys hypervisor has reserved.

-aneesh
