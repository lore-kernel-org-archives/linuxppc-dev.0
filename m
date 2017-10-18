Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGyZN6cWNzDrTd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 14:43:08 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id a192so3138568pge.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 20:43:08 -0700 (PDT)
Date: Wed, 18 Oct 2017 14:42:56 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 09/25] powerpc: ability to create execute-disabled pkeys
Message-ID: <20171018144256.72bdd785@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-18-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-18-git-send-email-linuxram@us.ibm.com>
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

On Fri,  8 Sep 2017 15:44:57 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> powerpc has hardware support to disable execute on a pkey.
> This patch enables the ability to create execute-disabled
> keys.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/mman.h |    6 ++++++
>  arch/powerpc/mm/pkeys.c              |   16 ++++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
> index ab45cc2..f272b09 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -45,4 +45,10 @@
>  #define MAP_HUGE_1GB	(30 << MAP_HUGE_SHIFT)	/* 1GB   HugeTLB Page */
>  #define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB  HugeTLB Page */
>  
> +/* override any generic PKEY Permission defines */
> +#define PKEY_DISABLE_EXECUTE   0x4
> +#undef PKEY_ACCESS_MASK
> +#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
> +				PKEY_DISABLE_WRITE  |\
> +				PKEY_DISABLE_EXECUTE)
>  #endif /* _UAPI_ASM_POWERPC_MMAN_H */
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index cc5be6a..2282864 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -24,6 +24,14 @@ void __init pkey_initialize(void)
>  {
>  	int os_reserved, i;
>  
> +	/*
> +	 * we define PKEY_DISABLE_EXECUTE in addition to the arch-neutral
> +	 * generic defines for PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE.
> +	 * Ensure that the bits a distinct.
> +	 */
> +	BUILD_BUG_ON(PKEY_DISABLE_EXECUTE &
> +		     (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));

Will these values every change? It's good to have I guess.

> +
>  	/* disable the pkey system till everything
>  	 * is in place. A patch further down the
>  	 * line will enable it.
> @@ -120,10 +128,18 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  		unsigned long init_val)
>  {
>  	u64 new_amr_bits = 0x0ul;
> +	u64 new_iamr_bits = 0x0ul;
>  
>  	if (!is_pkey_enabled(pkey))
>  		return -EINVAL;
>  
> +	if ((init_val & PKEY_DISABLE_EXECUTE)) {
> +		if (!pkey_execute_disable_support)
> +			return -EINVAL;
> +		new_iamr_bits |= IAMR_EX_BIT;
> +	}
> +	init_iamr(pkey, new_iamr_bits);
> +

Where do we check the reserved keys?

Balbir Singh.
