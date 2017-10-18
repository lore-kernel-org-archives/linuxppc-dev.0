Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHQQM1xwwzDqXt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 08:37:46 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9ILbarX133114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:37:44 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpbrk2dfv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:37:44 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Oct 2017 17:37:43 -0400
Date: Wed, 18 Oct 2017 14:37:38 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mhocko@kernel.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v7 12/25] powerpc: implementation for
 arch_override_mprotect_pkey()
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-13-git-send-email-linuxram@us.ibm.com>
 <94ca6bc3-14da-e171-1ab6-5bea5fb71650@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <94ca6bc3-14da-e171-1ab6-5bea5fb71650@linux.vnet.ibm.com>
Message-Id: <20171018213738.GM5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 05:58:18PM +0200, Laurent Dufour wrote:
> Hi Ram,
> 
> On 31/07/2017 02:12, Ram Pai wrote:
> > arch independent code calls arch_override_mprotect_pkey()
> > to return a pkey that best matches the requested protection.
> > 
> > This patch provides the implementation.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/mmu_context.h |    5 +++
> >  arch/powerpc/include/asm/pkeys.h       |   17 ++++++++++-
> >  arch/powerpc/mm/pkeys.c                |   47 ++++++++++++++++++++++++++++++++
> >  3 files changed, 67 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index 4705dab..7232484 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -185,6 +185,11 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> >  #ifndef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> >  #define pkey_initialize()
> >  #define pkey_mm_init(mm)
> > +
> > +static inline int vma_pkey(struct vm_area_struct *vma)
> > +{
> > +	return 0;
> > +}
> >  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > 
> >  #endif /* __KERNEL__ */
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index a715a08..03f7ea2 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -46,6 +46,16 @@ static inline u64 pkey_to_vmflag_bits(u16 pkey)
> >  		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
> >  }
> > 
> > +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> > +				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> > +
> > +static inline int vma_pkey(struct vm_area_struct *vma)
> > +{
> > +	if (!pkey_inited)
> > +		return 0;
> > +	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
> > +}
> > +
> >  #define arch_max_pkey()  pkeys_total
> >  #define AMR_RD_BIT 0x1UL
> >  #define AMR_WR_BIT 0x2UL
> > @@ -146,11 +156,14 @@ static inline int execute_only_pkey(struct mm_struct *mm)
> >  	return __execute_only_pkey(mm);
> >  }
> > 
> > -
> > +extern int __arch_override_mprotect_pkey(struct vm_area_struct *vma,
> > +		int prot, int pkey);
> >  static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
> >  		int prot, int pkey)
> >  {
> > -	return 0;
> > +	if (!pkey_inited)
> > +		return 0;
> > +	return __arch_override_mprotect_pkey(vma, prot, pkey);
> >  }
> > 
> >  extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > index 25749bf..edcbf48 100644
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -154,3 +154,50 @@ int __execute_only_pkey(struct mm_struct *mm)
> >  		mm->context.execute_only_pkey = execute_only_pkey;
> >  	return execute_only_pkey;
> >  }
> > +
> > +static inline bool vma_is_pkey_exec_only(struct vm_area_struct *vma)
> > +{
> > +	/* Do this check first since the vm_flags should be hot */
> > +	if ((vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)) != VM_EXEC)
> > +		return false;
> > +
> > +	return (vma_pkey(vma) == vma->vm_mm->context.execute_only_pkey);
> > +}
> > +
> > +/*
> > + * This should only be called for *plain* mprotect calls.
> > + */
> > +int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
> > +		int pkey)
> > +{
> > +	/*
> > +	 * Is this an mprotect_pkey() call?  If so, never
> > +	 * override the value that came from the user.
> > +	 */
> > +	if (pkey != -1)
> > +		return pkey;
> 
> This check should be moved in arch_override_mprotect_pkey() in
> arch/powerpc/include/asm/pkeys.h

ok. will do.

> 
> > +
> > +	/*
> > +	 * If the currently associated pkey is execute-only,
> > +	 * but the requested protection requires read or write,
> > +	 * move it back to the default pkey.
> > +	 */
> > +	if (vma_is_pkey_exec_only(vma) &&
> > +	    (prot & (PROT_READ|PROT_WRITE)))
> > +		return 0;
> > +
> > +	/*
> > +	 * the requested protection is execute-only. Hence
> > +	 * lets use a execute-only pkey.
> > +	 */
> > +	if (prot == PROT_EXEC) {
> > +		pkey = execute_only_pkey(vma->vm_mm);
> > +		if (pkey > 0)
> > +			return pkey;
> > +	}
> > +
> > +	/*
> > +	 * nothing to override.
> > +	 */
> > +	return vma_pkey(vma);
> > +}
> > 

Thanks,
-- 
Ram Pai
