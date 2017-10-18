Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHH6g0KKMzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 03:08:42 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9IG7Yuc147156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 12:08:41 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dp6x8vh43-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 12:08:40 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 18 Oct 2017 17:08:38 +0100
Subject: Re: [RFC v7 16/25] powerpc: helper to validate key-access permissions
 of a pte
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mhocko@kernel.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-17-git-send-email-linuxram@us.ibm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 18:08:34 +0200
MIME-Version: 1.0
In-Reply-To: <1501459946-11619-17-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <50c2a845-93aa-519f-732f-ee0d44be687c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 31/07/2017 02:12, Ram Pai wrote:
> helper function that checks if the read/write/execute is allowed
> on the pte.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |    4 +++
>  arch/powerpc/include/asm/pkeys.h             |   12 +++++++++++
>  arch/powerpc/mm/pkeys.c                      |   28 ++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 060a1b2..2bec0f6 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -477,6 +477,10 @@ static inline void write_uamor(u64 value)
>  	mtspr(SPRN_UAMOR, value);
>  }
> 
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long addr, pte_t *ptep)
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 4b7e3f4..ba7bff6 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -85,6 +85,18 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
>  		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
>  }
> 
> +static inline u16 pte_to_pkey_bits(u64 pteflags)
> +{
> +	if (!pkey_inited)
> +		return 0x0UL;

Is it really needed to make such a check in this low level function ?
The only caller is already checking for pkey_inited before making the call.

> +
> +	return (((pteflags & H_PAGE_PKEY_BIT0) ? 0x10 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT1) ? 0x8 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT2) ? 0x4 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT3) ? 0x2 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT4) ? 0x1 : 0x0UL));
> +}
> +
>  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
>  				VM_PKEY_BIT3 | VM_PKEY_BIT4)
>  #define AMR_BITS_PER_PKEY 2
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index edcbf48..8d756ef 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -201,3 +201,31 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
>  	 */
>  	return vma_pkey(vma);
>  }
> +
> +static bool pkey_access_permitted(int pkey, bool write, bool execute)
> +{
> +	int pkey_shift;
> +	u64 amr;
> +
> +	if (!pkey)
> +		return true;
> +
> +	pkey_shift = pkeyshift(pkey);
> +	if (!(read_uamor() & (0x3UL << pkey_shift)))
> +		return true;
> +
> +	if (execute && !(read_iamr() & (IAMR_EX_BIT << pkey_shift)))
> +		return true;
> +
> +	amr = read_amr(); /* delay reading amr uptil absolutely needed*/
> +	return ((!write && !(amr & (AMR_RD_BIT << pkey_shift))) ||
> +		(write &&  !(amr & (AMR_WR_BIT << pkey_shift))));
> +}
> +
> +bool arch_pte_access_permitted(u64 pte, bool write, bool execute)
> +{
> +	if (!pkey_inited)
> +		return true;
> +	return pkey_access_permitted(pte_to_pkey_bits(pte),
> +			write, execute);
> +}
> 
