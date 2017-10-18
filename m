Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHPvm73mqzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 08:14:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9ILEIWg034353
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:14:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpax6cprt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:14:42 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Oct 2017 15:14:42 -0600
Date: Wed, 18 Oct 2017 14:14:33 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 14/25] powerpc: map vma key-protection bits to pte key
 bits.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-23-git-send-email-linuxram@us.ibm.com>
 <20171018153911.3079f0cf@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018153911.3079f0cf@firefly.ozlabs.ibm.com>
Message-Id: <20171018211433.GJ5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 03:39:11PM +1100, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:45:02 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > map  the  key  protection  bits of the vma to the pkey bits in
> > the PTE.
> > 
> > The Pte  bits used  for pkey  are  3,4,5,6  and 57. The  first
> > four bits are the same four bits that were freed up  initially
> > in this patch series. remember? :-) Without those four bits
> > this patch would'nt be possible.
> > 
> > BUT, On 4k kernel, bit 3, and 4 could not be freed up. remember?
> > Hence we have to be satisfied with 5,6 and 7.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/pgtable.h |   25 ++++++++++++++++++++++++-
> >  arch/powerpc/include/asm/mman.h              |    8 ++++++++
> >  arch/powerpc/include/asm/pkeys.h             |   12 ++++++++++++
> >  3 files changed, 44 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > index 73ed52c..5935d4e 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -38,6 +38,7 @@
> >  #define _RPAGE_RSV2		0x0800000000000000UL
> >  #define _RPAGE_RSV3		0x0400000000000000UL
> >  #define _RPAGE_RSV4		0x0200000000000000UL
> > +#define _RPAGE_RSV5		0x00040UL
> >  
> >  #define _PAGE_PTE		0x4000000000000000UL	/* distinguishes PTEs from pointers */
> >  #define _PAGE_PRESENT		0x8000000000000000UL	/* pte contains a translation */
> > @@ -57,6 +58,25 @@
> >  /* Max physical address bit as per radix table */
> >  #define _RPAGE_PA_MAX		57
> >  
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +#ifdef CONFIG_PPC_64K_PAGES
> > +#define H_PAGE_PKEY_BIT0	_RPAGE_RSV1
> > +#define H_PAGE_PKEY_BIT1	_RPAGE_RSV2
> > +#else /* CONFIG_PPC_64K_PAGES */
> > +#define H_PAGE_PKEY_BIT0	0 /* _RPAGE_RSV1 is not available */
> > +#define H_PAGE_PKEY_BIT1	0 /* _RPAGE_RSV2 is not available */
> > +#endif /* CONFIG_PPC_64K_PAGES */
> > +#define H_PAGE_PKEY_BIT2	_RPAGE_RSV3
> > +#define H_PAGE_PKEY_BIT3	_RPAGE_RSV4
> > +#define H_PAGE_PKEY_BIT4	_RPAGE_RSV5
> > +#else /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +#define H_PAGE_PKEY_BIT0	0
> > +#define H_PAGE_PKEY_BIT1	0
> > +#define H_PAGE_PKEY_BIT2	0
> > +#define H_PAGE_PKEY_BIT3	0
> > +#define H_PAGE_PKEY_BIT4	0
> > +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> 
> H_PTE_PKEY_BITX?

ok. makes sense. will do.

> 
> > +
> >  /*
> >   * Max physical address bit we will use for now.
> >   *
> > @@ -120,13 +140,16 @@
> >  #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
> >  			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE |	\
> >  			 _PAGE_SOFT_DIRTY)
> > +
> > +#define H_PAGE_PKEY  (H_PAGE_PKEY_BIT0 | H_PAGE_PKEY_BIT1 | H_PAGE_PKEY_BIT2 | \
> > +			H_PAGE_PKEY_BIT3 | H_PAGE_PKEY_BIT4)
> >  /*
> >   * Mask of bits returned by pte_pgprot()
> >   */
> >  #define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
> >  			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
> >  			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
> > -			 _PAGE_SOFT_DIRTY)
> > +			 _PAGE_SOFT_DIRTY | H_PAGE_PKEY)
> >  /*
> >   * We define 2 sets of base prot bits, one for basic pages (ie,
> >   * cacheable kernel and user pages) and one for non cacheable
> > diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
> > index 067eec2..3f7220f 100644
> > --- a/arch/powerpc/include/asm/mman.h
> > +++ b/arch/powerpc/include/asm/mman.h
> > @@ -32,12 +32,20 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >  }
> >  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> >  
> > +
> >  static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
> >  {
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +	return (vm_flags & VM_SAO) ?
> > +		__pgprot(_PAGE_SAO | vmflag_to_page_pkey_bits(vm_flags)) :
> > +		__pgprot(0 | vmflag_to_page_pkey_bits(vm_flags));
> > +#else
> >  	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
> > +#endif
> >  }
> >  #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
> >  
> > +
> >  static inline bool arch_validate_prot(unsigned long prot)
> >  {
> >  	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index d2fffef..0d2488a 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -41,6 +41,18 @@ static inline u64 pkey_to_vmflag_bits(u16 pkey)
> >  		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
> >  }
> >  
> > +static inline u64 vmflag_to_page_pkey_bits(u64 vm_flags)
> 
> vmflag_to_pte_pkey_bits?

ok. if you insist :). will do.

> 
> > +{
> > +	if (!pkey_inited)
> > +		return 0x0UL;
> > +
> > +	return (((vm_flags & VM_PKEY_BIT0) ? H_PAGE_PKEY_BIT4 : 0x0UL) |
> > +		((vm_flags & VM_PKEY_BIT1) ? H_PAGE_PKEY_BIT3 : 0x0UL) |
> > +		((vm_flags & VM_PKEY_BIT2) ? H_PAGE_PKEY_BIT2 : 0x0UL) |
> > +		((vm_flags & VM_PKEY_BIT3) ? H_PAGE_PKEY_BIT1 : 0x0UL) |
> > +		((vm_flags & VM_PKEY_BIT4) ? H_PAGE_PKEY_BIT0 : 0x0UL));
> > +}
> > +
> >  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> >  				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> >  
> 
> Balbir Singh.

-- 
Ram Pai
