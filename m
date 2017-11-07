Return-Path: <srs0=2suh=cf=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yW9n61GpwzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 11:49:46 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yW9n56qrXz8t3R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 11:49:45 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yW9n54S1Vz9sDB
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2017 11:49:45 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id k7so9632466pga.3
 for <linuxppc-dev@ozlabs.org>; Mon, 06 Nov 2017 16:49:45 -0800 (PST)
Date: Tue, 7 Nov 2017 11:49:34 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, mikey@neuling.org, hbabu@us.ibm.com,
 linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/18] powerpc: Define set_thread_used_vas()
Message-ID: <20171107114918.0200954c@roar.ozlabs.ibm.com>
In-Reply-To: <1507343298-27496-15-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1507343298-27496-15-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Fri,  6 Oct 2017 19:28:14 -0700
Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> wrote:

> A CP_ABORT instruction is required in processes that have mapped a VAS
> "paste address" with the intention of using COPY/PASTE instructions.
> But since CP_ABORT is expensive, we want to restrict it to only processes
> that use/intend to use COPY/PASTE.
> 
> Define an interface, set_thread_used_vas(), that VAS can use to indicate
> that the current process opened a send window. During context switch,
> issue CP_ABORT only for processes that have the flag set.
> 
> Thanks for input from Nick Piggin, Michael Ellerman.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/processor.h |  2 ++
>  arch/powerpc/include/asm/switch_to.h |  2 ++
>  arch/powerpc/kernel/process.c        | 32 ++++++++++++++++++++++----------
>  3 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 58cc212..bdab3b74 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -341,7 +341,9 @@ struct thread_struct {
>  	unsigned long	sier;
>  	unsigned long	mmcr2;
>  	unsigned 	mmcr0;
> +
>  	unsigned 	used_ebb;
> +	unsigned int	used_vas;
>  #endif
>  };
>  
> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> index f5da32f..aeb305b 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -91,6 +91,8 @@ static inline void clear_task_ebb(struct task_struct *t)
>  #endif
>  }
>  
> +extern int set_thread_used_vas(void);
> +
>  extern int set_thread_tidr(struct task_struct *t);
>  extern void clear_thread_tidr(struct task_struct *t);
>  
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index d861fcd..cb5f108 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1234,17 +1234,17 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  		 * The copy-paste buffer can only store into foreign real
>  		 * addresses, so unprivileged processes can not see the
>  		 * data or use it in any way unless they have foreign real
> -		 * mappings. We don't have a VAS driver that allocates those
> -		 * yet, so no cpabort is required.
> +		 * mappings. If the new process has the foreign real address
> +		 * mappings, we must issue a cp_abort to clear any state and
> +		 * prevent a covert channel being setup.
> +		 *
> +		 * DD1 allows paste into normal system memory so we do an
> +		 * unpaired copy, rather than cp_abort, to clear the buffer,
> +		 * since cp_abort is quite expensive.
>  		 */
> -		if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> -			/*
> -			 * DD1 allows paste into normal system memory, so we
> -			 * do an unpaired copy here to clear the buffer and
> -			 * prevent a covert channel being set up.
> -			 *
> -			 * cpabort is not used because it is quite expensive.
> -			 */
> +		if (new_thread->used_vas) {
> +			asm volatile(PPC_CP_ABORT);
> +		} else if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
>  			asm volatile(PPC_COPY(%0, %1)
>  					: : "r"(dummy_copy_buffer), "r"(0));
>  		}

I *think* we're okay with this now, right? If we are switching to a thread
with a foreign address mapping (that could interact with something in the
copy buffer from a previous thread), then we cp_abort to ensure the copy
buffer is clear.

It's not just a covert channel, but also snooping, or accidental or
deliberate corruption .


> @@ -1445,6 +1445,18 @@ void flush_thread(void)
>  #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  }
>  
> +int set_thread_used_vas(void)
> +{

At the risk of nitpicking, I would like to change from used (past
tense) to something else that indicates future tense. We have to set
this before starting to use vas.

I think we should pull in the abort into this function rather than
the caller, and your caller in patch 18 does not check the return
code which it should.

Other than these small bits, it looks much better, thanks!

> +#ifdef CONFIG_PPC_BOOK3S_64
> +	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +		return -EINVAL;
> +
> +	current->thread.used_vas = 1;
> +
> +#endif /* CONFIG_PPC_BOOK3S_64 */
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PPC64
>  static DEFINE_SPINLOCK(vas_thread_id_lock);
>  static DEFINE_IDA(vas_thread_ida);
