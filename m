Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHPqK5YP2zDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 08:10:52 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9ILAl13116444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:10:51 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpcwd5hbj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 17:10:50 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Oct 2017 15:10:50 -0600
Date: Wed, 18 Oct 2017 14:10:41 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 13/25] powerpc: implementation for
 arch_override_mprotect_pkey()
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-22-git-send-email-linuxram@us.ibm.com>
 <20171018153635.1ab9765d@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018153635.1ab9765d@firefly.ozlabs.ibm.com>
Message-Id: <20171018211041.GI5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 03:36:35PM +1100, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:45:01 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
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
> > index c705a5d..8e5a87e 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -145,6 +145,11 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
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
> > index f13e913..d2fffef 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -41,6 +41,16 @@ static inline u64 pkey_to_vmflag_bits(u16 pkey)
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
> 
> We don't want pkey_inited to be present in all functions, why do we need
> a conditional branch for all functions. Even if we do, it should be a jump
> label. I would rather we just removed !pkey_inited unless really really
> required.

No. we really really need it.  For example when we build a kernel with
PROTECTION_KEYS config enabled and run that kernel on a older processor
or on a system where the key feature is not enabled in the device tree,
we have fail all the calls that get called-in by the arch-neutral code.

Hence we need this check.

BTW: jump labels are awkward IMHO, unless absolutely needed.

> 
> > +	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
> > +}
> > +
> >  #define arch_max_pkey()  pkeys_total
> >  #define AMR_RD_BIT 0x1UL
> >  #define AMR_WR_BIT 0x2UL
> > @@ -142,11 +152,14 @@ static inline int execute_only_pkey(struct mm_struct *mm)
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
> > index 8a24983..fb1a76a 100644
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -245,3 +245,50 @@ int __execute_only_pkey(struct mm_struct *mm)
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
> 
> What's a plain mprotect call?

there is sys_mprotect() and now there is a sys_pkey_mprotect() call.
The 'plain' one is the former.

> 
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
> If the user specified a key, we always use it? Presumably the user
> got it from pkey_alloc(), in other cases, the user was lazy and used
> -1 in the mprotect call?

in the plain sys_mprotect() key is not specified. In that case this
function gets called with a -1.

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
> 
> Balbir Singh.

-- 
Ram Pai
