Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHVkl3KKGzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 11:52:13 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9J0nbaT046507
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 20:52:11 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpbx58v13-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 20:52:11 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Oct 2017 18:52:10 -0600
Date: Wed, 18 Oct 2017 17:52:03 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 10/25] powerpc: store and restore the pkey state across
 context switches
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-19-git-send-email-linuxram@us.ibm.com>
 <20171018144914.6252f52a@firefly.ozlabs.ibm.com>
 <20171018204705.GF5617@ram.oc3035372033.ibm.com>
 <20171019100038.57ecebc2@MiWiFi-R3-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019100038.57ecebc2@MiWiFi-R3-srv>
Message-Id: <20171019005203.GQ5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 10:00:38AM +1100, Balbir Singh wrote:
> On Wed, 18 Oct 2017 13:47:05 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > On Wed, Oct 18, 2017 at 02:49:14PM +1100, Balbir Singh wrote:
> > > On Fri,  8 Sep 2017 15:44:58 -0700
> > > Ram Pai <linuxram@us.ibm.com> wrote:
> > >   
> > > > Store and restore the AMR, IAMR and UAMOR register state of the task
> > > > before scheduling out and after scheduling in, respectively.
> > > > 
> > > > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > > > ---
> > > >  arch/powerpc/include/asm/pkeys.h     |    4 +++
> > > >  arch/powerpc/include/asm/processor.h |    5 ++++
> > > >  arch/powerpc/kernel/process.c        |   10 ++++++++
> > > >  arch/powerpc/mm/pkeys.c              |   39 ++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 58 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > > > index 7fd48a4..78c5362 100644
> > > > --- a/arch/powerpc/include/asm/pkeys.h
> > > > +++ b/arch/powerpc/include/asm/pkeys.h
> > > > @@ -143,5 +143,9 @@ static inline void pkey_mm_init(struct mm_struct *mm)
> > > >  	mm_pkey_allocation_map(mm) = initial_allocation_mask;
> > > >  }
> > > >  
> > > > +extern void thread_pkey_regs_save(struct thread_struct *thread);
> > > > +extern void thread_pkey_regs_restore(struct thread_struct *new_thread,
> > > > +			struct thread_struct *old_thread);
> > > > +extern void thread_pkey_regs_init(struct thread_struct *thread);
> > > >  extern void pkey_initialize(void);
> > > >  #endif /*_ASM_PPC64_PKEYS_H */
> > > > diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> > > > index fab7ff8..de9d9ba 100644
> > > > --- a/arch/powerpc/include/asm/processor.h
> > > > +++ b/arch/powerpc/include/asm/processor.h
> > > > @@ -309,6 +309,11 @@ struct thread_struct {
> > > >  	struct thread_vr_state ckvr_state; /* Checkpointed VR state */
> > > >  	unsigned long	ckvrsave; /* Checkpointed VRSAVE */
> > > >  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> > > > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > > > +	unsigned long	amr;
> > > > +	unsigned long	iamr;
> > > > +	unsigned long	uamor;
> > > > +#endif
> > > >  #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
> > > >  	void*		kvm_shadow_vcpu; /* KVM internal data */
> > > >  #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
> > > > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > > > index a0c74bb..ba80002 100644
> > > > --- a/arch/powerpc/kernel/process.c
> > > > +++ b/arch/powerpc/kernel/process.c
> > > > @@ -42,6 +42,7 @@
> > > >  #include <linux/hw_breakpoint.h>
> > > >  #include <linux/uaccess.h>
> > > >  #include <linux/elf-randomize.h>
> > > > +#include <linux/pkeys.h>
> > > >  
> > > >  #include <asm/pgtable.h>
> > > >  #include <asm/io.h>
> > > > @@ -1085,6 +1086,9 @@ static inline void save_sprs(struct thread_struct *t)
> > > >  		t->tar = mfspr(SPRN_TAR);
> > > >  	}
> > > >  #endif
> > > > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > > > +	thread_pkey_regs_save(t);
> > > > +#endif  
> > > 
> > > Just define two variants of thread_pkey_regs_save() based on
> > > CONFIG_PPC64_MEMORY_PROTECTION_KEYS and remove the #ifdefs from process.c
> > > Ditto for the lines below  
> > 
> > ok.
> > 
> > >   
> > > >  }
> > > >  
> > > >  static inline void restore_sprs(struct thread_struct *old_thread,
> > > > @@ -1120,6 +1124,9 @@ static inline void restore_sprs(struct thread_struct *old_thread,
> > > >  			mtspr(SPRN_TAR, new_thread->tar);
> > > >  	}
> > > >  #endif
> > > > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > > > +	thread_pkey_regs_restore(new_thread, old_thread);
> > > > +#endif  
> > 
> > ok.
> > 
> > > >  }
> > > >  
> > > >  #ifdef CONFIG_PPC_BOOK3S_64
> > > > @@ -1705,6 +1712,9 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
> > > >  	current->thread.tm_tfiar = 0;
> > > >  	current->thread.load_tm = 0;
> > > >  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> > > > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > > > +	thread_pkey_regs_init(&current->thread);
> > > > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > > >  }
> > > >  EXPORT_SYMBOL(start_thread);
> > > >  
> > > > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > > > index 2282864..7cd1be4 100644
> > > > --- a/arch/powerpc/mm/pkeys.c
> > > > +++ b/arch/powerpc/mm/pkeys.c
> > > > @@ -149,3 +149,42 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> > > >  	init_amr(pkey, new_amr_bits);
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +void thread_pkey_regs_save(struct thread_struct *thread)
> > > > +{
> > > > +	if (!pkey_inited)
> > > > +		return;
> > > > +
> > > > +	/* @TODO skip saving any registers if the thread
> > > > +	 * has not used any keys yet.
> > > > +	 */  
> > > 
> > > Comment style is broken  
> > 
> > ok. this time i will fix them. It misses by radar screen because
> > checkpatch.pl does not complain. 
> >
> 
> Yep, there is an lkml thread on this style of coding. It's
> best avoided.
> 
> > >   
> > > > +
> > > > +	thread->amr = read_amr();
> > > > +	thread->iamr = read_iamr();
> > > > +	thread->uamor = read_uamor();
> > > > +}
> > > > +
> > > > +void thread_pkey_regs_restore(struct thread_struct *new_thread,
> > > > +			struct thread_struct *old_thread)
> > > > +{
> > > > +	if (!pkey_inited)
> > > > +		return;
> > > > +
> > > > +	/* @TODO just reset uamor to zero if the new_thread
> > > > +	 * has not used any keys yet.
> > > > +	 */  
> > > 
> > > Comment style is broken.
> > >   
> > > > +
> > > > +	if (old_thread->amr != new_thread->amr)
> > > > +		write_amr(new_thread->amr);
> > > > +	if (old_thread->iamr != new_thread->iamr)
> > > > +		write_iamr(new_thread->iamr);
> > > > +	if (old_thread->uamor != new_thread->uamor)
> > > > +		write_uamor(new_thread->uamor);  
> > > 
> > > Is this order correct? Ideally, You want to write the uamor first
> > > but since we are in supervisor state, I think we can get away
> > > with this order.   
> > 
> > we could be in hypervisor state too, as is the case when we run
> > a powernv kernel.
> > 
> > But..does it matter in which order they are written? if
> > the thread is in the kernel, it cannot execute any instructions
> > in userspace. So it wont see a intermediate state. right?
> > or am i getting this wrong?
> 
> You are right, since uamor + amor control what can and
> cannot be set, there is a subtle dependency, but it does
> not apply to the kernel doing the context switch. AMR has
> two SPR values, 13 and 29. I presume we are using SPR #29
> here?

it is SPRN_AMR, which is 29 (0x1d)

> 
> > 
> > > Do we want to expose the uamor to user space
> > > for it to modify the AMR directly?  
> > 
> > sorry I did not understand the comment. UAMOR cannot
> > be accessed from usespace. and there are no system calls
> > currently to help userspace to program the UAMOR on its
> > behalf.
> > 
> 
> I was just wondering how two threads can share a key if
> they decide to. They would need uamor to give them permissions
> to the same set of keys and then reuse the key via
> pkey_mprotect(.., pkey). I am missing the bit about how
> uamor's across these threads would be synchronized.

As it stands now, two threads are discouraged to share the same key,
since we dont provide synchronization of keys across threads. A key
allocated in one thread's context has no meaning in the context of
another thread.  I think, it is constraining to the application, but
that is how the semantics were defined and i have implemented it that
way for powerpc.  Yes eventually; one day I am sure, as applications
start exploiting this feature they will demand more flexibility. But
for now that is what it is.  So given the above semantics, there is
no need currently to synchronize umor/amr/iamr across threads.

> 
> 
> > >   
> > > > +}
> > > > +
> > > > +void thread_pkey_regs_init(struct thread_struct *thread)
> > > > +{
> > > > +	write_amr(0x0ul);
> > > > +	write_iamr(0x0ul);
> > > > +	write_uamor(0x0ul);  
> > > 
> > > This is not correct, reserved keys should not be set to 0's  
> > 
> > ok. makes sense. best to not touch reserved key bits here.
> 
> Also this implies that at init time, the thread has access to all
> keys, but it can't modify any of the keys in the AMR/IAMR.

it shouldn't modify the bit corresponding to the reserved keys.

These patches dont touch AMOR. the hypervisor is entirely in control of
the AMOR.

AMOR is the master controller for these keys. If a reserved key is
disabled in AMOR, any changes to the bits corresponding to the
reserved-key in AMR or IAMR or UAMOR will have any effect. 

But if AMOR has enabled a reserved-key, than we will cause bad things by
changing the bits in AMR/IAMR/UAMOR. So you are right. We better not
touch the bits corresponding to the reserved-keys.

RP
