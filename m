Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGyjf0jv0zDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 14:49:25 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 17so2922693pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 20:49:25 -0700 (PDT)
Date: Wed, 18 Oct 2017 14:49:14 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 10/25] powerpc: store and restore the pkey state across
 context switches
Message-ID: <20171018144914.6252f52a@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-19-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-19-git-send-email-linuxram@us.ibm.com>
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

On Fri,  8 Sep 2017 15:44:58 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Store and restore the AMR, IAMR and UAMOR register state of the task
> before scheduling out and after scheduling in, respectively.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h     |    4 +++
>  arch/powerpc/include/asm/processor.h |    5 ++++
>  arch/powerpc/kernel/process.c        |   10 ++++++++
>  arch/powerpc/mm/pkeys.c              |   39 ++++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 7fd48a4..78c5362 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -143,5 +143,9 @@ static inline void pkey_mm_init(struct mm_struct *mm)
>  	mm_pkey_allocation_map(mm) = initial_allocation_mask;
>  }
>  
> +extern void thread_pkey_regs_save(struct thread_struct *thread);
> +extern void thread_pkey_regs_restore(struct thread_struct *new_thread,
> +			struct thread_struct *old_thread);
> +extern void thread_pkey_regs_init(struct thread_struct *thread);
>  extern void pkey_initialize(void);
>  #endif /*_ASM_PPC64_PKEYS_H */
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index fab7ff8..de9d9ba 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -309,6 +309,11 @@ struct thread_struct {
>  	struct thread_vr_state ckvr_state; /* Checkpointed VR state */
>  	unsigned long	ckvrsave; /* Checkpointed VRSAVE */
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	unsigned long	amr;
> +	unsigned long	iamr;
> +	unsigned long	uamor;
> +#endif
>  #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
>  	void*		kvm_shadow_vcpu; /* KVM internal data */
>  #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index a0c74bb..ba80002 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -42,6 +42,7 @@
>  #include <linux/hw_breakpoint.h>
>  #include <linux/uaccess.h>
>  #include <linux/elf-randomize.h>
> +#include <linux/pkeys.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
> @@ -1085,6 +1086,9 @@ static inline void save_sprs(struct thread_struct *t)
>  		t->tar = mfspr(SPRN_TAR);
>  	}
>  #endif
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	thread_pkey_regs_save(t);
> +#endif

Just define two variants of thread_pkey_regs_save() based on
CONFIG_PPC64_MEMORY_PROTECTION_KEYS and remove the #ifdefs from process.c
Ditto for the lines below

>  }
>  
>  static inline void restore_sprs(struct thread_struct *old_thread,
> @@ -1120,6 +1124,9 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>  			mtspr(SPRN_TAR, new_thread->tar);
>  	}
>  #endif
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	thread_pkey_regs_restore(new_thread, old_thread);
> +#endif
>  }
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> @@ -1705,6 +1712,9 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
>  	current->thread.tm_tfiar = 0;
>  	current->thread.load_tm = 0;
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	thread_pkey_regs_init(&current->thread);
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>  }
>  EXPORT_SYMBOL(start_thread);
>  
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index 2282864..7cd1be4 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -149,3 +149,42 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  	init_amr(pkey, new_amr_bits);
>  	return 0;
>  }
> +
> +void thread_pkey_regs_save(struct thread_struct *thread)
> +{
> +	if (!pkey_inited)
> +		return;
> +
> +	/* @TODO skip saving any registers if the thread
> +	 * has not used any keys yet.
> +	 */

Comment style is broken

> +
> +	thread->amr = read_amr();
> +	thread->iamr = read_iamr();
> +	thread->uamor = read_uamor();
> +}
> +
> +void thread_pkey_regs_restore(struct thread_struct *new_thread,
> +			struct thread_struct *old_thread)
> +{
> +	if (!pkey_inited)
> +		return;
> +
> +	/* @TODO just reset uamor to zero if the new_thread
> +	 * has not used any keys yet.
> +	 */

Comment style is broken.

> +
> +	if (old_thread->amr != new_thread->amr)
> +		write_amr(new_thread->amr);
> +	if (old_thread->iamr != new_thread->iamr)
> +		write_iamr(new_thread->iamr);
> +	if (old_thread->uamor != new_thread->uamor)
> +		write_uamor(new_thread->uamor);

Is this order correct? Ideally, You want to write the uamor first
but since we are in supervisor state, I think we can get away
with this order. Do we want to expose the uamor to user space
for it to modify the AMR directly?

> +}
> +
> +void thread_pkey_regs_init(struct thread_struct *thread)
> +{
> +	write_amr(0x0ul);
> +	write_iamr(0x0ul);
> +	write_uamor(0x0ul);

This is not correct, reserved keys should not be set to 0's

Balbir Singh.
