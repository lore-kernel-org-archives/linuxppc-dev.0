Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsktZ1hKJzDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 09:43:17 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KNdAJg090680
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:43:15 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b76d0hd5r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:43:15 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 20 Jun 2017 17:43:14 -0600
Date: Tue, 20 Jun 2017 16:43:07 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC v2 08/12] powerpc: Handle exceptions caused by violation of
 pkey protection.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-9-git-send-email-linuxram@us.ibm.com>
 <a288b72b-3e9c-7bf9-fff4-e5b08bad0374@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a288b72b-3e9c-7bf9-fff4-e5b08bad0374@linux.vnet.ibm.com>
Message-Id: <20170620234307.GJ17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 12:54:45PM +0530, Anshuman Khandual wrote:
> On 06/17/2017 09:22 AM, Ram Pai wrote:
> > Handle Data and Instruction exceptions caused by memory
> > protection-key.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > (cherry picked from commit a5e5217619a0c475fe0cacc3b0cf1d3d33c79a09)

Sorry. it was residue of a bad cleanup. It got cherry-picked from my own
internal branch, but than i forgot to delete that line.

> 
> To which tree this commit belongs to ?
> 
> > 
> > Conflicts:
> > 	arch/powerpc/include/asm/reg.h
> > 	arch/powerpc/kernel/exceptions-64s.S

same here. these two line are some residues of patching-up my tree with
commits from other internal branches.

> > ---
> >  arch/powerpc/include/asm/mmu_context.h | 12 +++++
> >  arch/powerpc/include/asm/pkeys.h       |  9 ++++
> >  arch/powerpc/include/asm/reg.h         |  7 +--
> >  arch/powerpc/mm/fault.c                | 21 +++++++-
> >  arch/powerpc/mm/pkeys.c                | 90 ++++++++++++++++++++++++++++++++++
> >  5 files changed, 134 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index da7e943..71fffe0 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -175,11 +175,23 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
> >  {
> >  }
> > 
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +bool arch_pte_access_permitted(pte_t pte, bool write);
> > +bool arch_vma_access_permitted(struct vm_area_struct *vma,
> > +		bool write, bool execute, bool foreign);
> > +#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +static inline bool arch_pte_access_permitted(pte_t pte, bool write)
> > +{
> > +	/* by default, allow everything */
> > +	return true;
> > +}
> >  static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> >  		bool write, bool execute, bool foreign)
> >  {
> >  	/* by default, allow everything */
> >  	return true;
> >  }
> 
> Right, these are the two functions the core VM expects the
> arch to provide.
> 
> > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +
> >  #endif /* __KERNEL__ */
> >  #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index 9b6820d..405e7db 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -14,6 +14,15 @@
> >  			VM_PKEY_BIT3 | \
> >  			VM_PKEY_BIT4)
> > 
> > +static inline u16 pte_flags_to_pkey(unsigned long pte_flags)
> > +{
> > +	return ((pte_flags & H_PAGE_PKEY_BIT4) ? 0x1 : 0x0) |
> > +		((pte_flags & H_PAGE_PKEY_BIT3) ? 0x2 : 0x0) |
> > +		((pte_flags & H_PAGE_PKEY_BIT2) ? 0x4 : 0x0) |
> > +		((pte_flags & H_PAGE_PKEY_BIT1) ? 0x8 : 0x0) |
> > +		((pte_flags & H_PAGE_PKEY_BIT0) ? 0x10 : 0x0);
> > +}
> 
> Add defines for the above 0x1, 0x2, 0x4, 0x8 etc ?

hmm...not sure if it will make the code any better.

> 
> > +
> >  #define pkey_to_vmflag_bits(key) (((key & 0x1UL) ? VM_PKEY_BIT0 : 0x0UL) | \
> >  			((key & 0x2UL) ? VM_PKEY_BIT1 : 0x0UL) |	\
> >  			((key & 0x4UL) ? VM_PKEY_BIT2 : 0x0UL) |	\
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index 2dcb8a1..a11977f 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -285,9 +285,10 @@
> >  #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
> >  #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
> >  #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
> > -#define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 | \
> > -				DSISR_PAGEATTR_CONFLT | \
> > -				DSISR_BADACCESS |       \
> > +#define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 |	\
> > +				DSISR_PAGEATTR_CONFLT |	\
> > +				DSISR_BADACCESS |	\
> > +				DSISR_KEYFAULT |	\
> >  				DSISR_BIT43)
> 
> This should have been cleaned up before adding new
> DSISR_KEYFAULT reason code into it. But I guess its
> okay.
> 
> >  #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
> >  #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 3a7d580..c31624f 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -216,9 +216,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
> >  	 * bits we are interested in.  But there are some bits which
> >  	 * indicate errors in DSISR but can validly be set in SRR1.
> >  	 */
> > -	if (trap == 0x400)
> > +	if (trap == 0x400) {
> >  		error_code &= 0x48200000;
> > -	else
> > +		flags |= FAULT_FLAG_INSTRUCTION;
> > +	} else
> >  		is_write = error_code & DSISR_ISSTORE;
> >  #else
> 
> Why adding the FAULT_FLAG_INSTRUCTION here ?

	later in this code, this flag is checked to see if execute-protection was
	violated.
> 
> >  	is_write = error_code & ESR_DST;
> > @@ -261,6 +262,13 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
> >  	}
> >  #endif
> > 
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +	if (error_code & DSISR_KEYFAULT) {
> > +		code = SEGV_PKUERR;
> > +		goto bad_area_nosemaphore;
> > +	}
> > +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +
> >  	/* We restore the interrupt state now */
> >  	if (!arch_irq_disabled_regs(regs))
> >  		local_irq_enable();
> > @@ -441,6 +449,15 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
> >  		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
> >  #endif /* CONFIG_PPC_STD_MMU */
> > 
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
> > +					flags & FAULT_FLAG_INSTRUCTION,
> > +					0)) {
> > +		code = SEGV_PKUERR;
> > +		goto bad_area;
> > +	}
> > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > +
> 
> I am wondering why both the above checks are required ?

Yes good question.  there are two cases here.

a) when a hpte is not yet hashed to pte.

 	in this case the fault is because the hpte is not yet mapped.
	However the access may have also violated the protection
	permissions of the key associated with that address. So we need
	to a software check to determine if a key was violated.

	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,...

	handles this case.


b) when the hpte is hashed to the pte and keys are programmed into
			the hpte.

	in this case the hardware senses the key protection fault
	and we just have to check if that is the case.

	if (error_code & DSISR_KEYFAULT) {....

	handles this case.


> 
> * DSISR should contains DSISR_KEYFAULT
> 
> * VMA pkey values whether they matched the fault cause
> 
> 
> >  	/*
> >  	 * If for any reason at all we couldn't handle the fault,
> >  	 * make sure we exit gracefully rather than endlessly redo
> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > index 11a32b3..439241a 100644
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -27,6 +27,37 @@ static inline bool pkey_allows_readwrite(int pkey)
> >  	return !(read_amr() & ((AMR_AD_BIT|AMR_WD_BIT) << pkey_shift));
> >  }
> > 
> > +static inline bool pkey_allows_read(int pkey)
> > +{
> > +	int pkey_shift = (arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY;
> > +
> > +	if (!(read_uamor() & (0x3ul << pkey_shift)))
> > +		return true;
> > +
> > +	return !(read_amr() & (AMR_AD_BIT << pkey_shift));
> > +}
> 
> Get read_amr() into a local variable and save some cycles if we
> have to do it again.

No. not really. the AMR can be changed by the process in userspace. So anything
that we cache can go stale.
Or maybe i do not understand your comment.


RP.
