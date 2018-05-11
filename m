Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j3fZ0Tw0zF2BW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 18:48:53 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4B8mpqF036555
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 04:48:51 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hw71yafae-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 04:48:50 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Fri, 11 May 2018 09:48:46 +0100
Subject: Re: [PATCH v5 3/7] powerpc: use task_pid_nr() for TID allocation
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180511061303.10728-1-alastair@au1.ibm.com>
 <20180511061303.10728-4-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 10:48:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180511061303.10728-4-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1b90555b-f614-f0a7-2265-54933194a7d9@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/05/2018 à 08:12, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The current implementation of TID allocation, using a global IDR, may
> result in an errant process starving the system of available TIDs.
> Instead, use task_pid_nr(), as mentioned by the original author. The
> scenario described which prevented it's use is not applicable, as
> set_thread_tidr can only be called after the task struct has been
> populated.
> 
> In the unlikely event that 2 threads share the TID and are waiting,
> all potential outcomes have been determined safe.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Thanks for adding the comment. It assumes the reader is aware that the 
TIDR value is only used for the notification using the 'wait' 
instruction, but that's likely to be the case.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   arch/powerpc/include/asm/switch_to.h |   1 -
>   arch/powerpc/kernel/process.c        | 122 ++++++---------------------
>   2 files changed, 28 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> index be8c9fa23983..5b03d8a82409 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -94,6 +94,5 @@ static inline void clear_task_ebb(struct task_struct *t)
>   extern int set_thread_uses_vas(void);
> 
>   extern int set_thread_tidr(struct task_struct *t);
> -extern void clear_thread_tidr(struct task_struct *t);
> 
>   #endif /* _ASM_POWERPC_SWITCH_TO_H */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 3b00da47699b..c5b8e53acbae 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1496,103 +1496,41 @@ int set_thread_uses_vas(void)
>   }
> 
>   #ifdef CONFIG_PPC64
> -static DEFINE_SPINLOCK(vas_thread_id_lock);
> -static DEFINE_IDA(vas_thread_ida);
> -
> -/*
> - * We need to assign a unique thread id to each thread in a process.
> +/**
> + * Assign a TIDR (thread ID) for task @t and set it in the thread
> + * structure. For now, we only support setting TIDR for 'current' task.
>    *
> - * This thread id, referred to as TIDR, and separate from the Linux's tgid,
> - * is intended to be used to direct an ASB_Notify from the hardware to the
> - * thread, when a suitable event occurs in the system.
> + * Since the TID value is a truncated form of it PID, it is possible
> + * (but unlikely) for 2 threads to have the same TID. In the unlikely event
> + * that 2 threads share the same TID and are waiting, one of the following
> + * cases will happen:
>    *
> - * One such event is a "paste" instruction in the context of Fast Thread
> - * Wakeup (aka Core-to-core wake up in the Virtual Accelerator Switchboard
> - * (VAS) in POWER9.
> + * 1. The correct thread is running, the wrong thread is not
> + * In this situation, the correct thread is woken and proceeds to pass it's
> + * condition check.
>    *
> - * To get a unique TIDR per process we could simply reuse task_pid_nr() but
> - * the problem is that task_pid_nr() is not yet available copy_thread() is
> - * called. Fixing that would require changing more intrusive arch-neutral
> - * code in code path in copy_process()?.
> + * 2. Neither threads are running
> + * In this situation, neither thread will be woken. When scheduled, the waiting
> + * threads will execute either a wait, which will return immediately, followed
> + * by a condition check, which will pass for the correct thread and fail
> + * for the wrong thread, or they will execute the condition check immediately.
>    *
> - * Further, to assign unique TIDRs within each process, we need an atomic
> - * field (or an IDR) in task_struct, which again intrudes into the arch-
> - * neutral code. So try to assign globally unique TIDRs for now.
> + * 3. The wrong thread is running, the correct thread is not
> + * The wrong thread will be woken, but will fail it's condition check and
> + * re-execute wait. The correct thread, when scheduled, will execute either
> + * it's condition check (which will pass), or wait, which returns immediately
> + * when called the first time after the thread is scheduled, followed by it's
> + * condition check (which will pass).
>    *
> - * NOTE: TIDR 0 indicates that the thread does not need a TIDR value.
> - *	 For now, only threads that expect to be notified by the VAS
> - *	 hardware need a TIDR value and we assign values > 0 for those.
> - */
> -#define MAX_THREAD_CONTEXT	((1 << 16) - 1)
> -static int assign_thread_tidr(void)
> -{
> -	int index;
> -	int err;
> -	unsigned long flags;
> -
> -again:
> -	if (!ida_pre_get(&vas_thread_ida, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	spin_lock_irqsave(&vas_thread_id_lock, flags);
> -	err = ida_get_new_above(&vas_thread_ida, 1, &index);
> -	spin_unlock_irqrestore(&vas_thread_id_lock, flags);
> -
> -	if (err == -EAGAIN)
> -		goto again;
> -	else if (err)
> -		return err;
> -
> -	if (index > MAX_THREAD_CONTEXT) {
> -		spin_lock_irqsave(&vas_thread_id_lock, flags);
> -		ida_remove(&vas_thread_ida, index);
> -		spin_unlock_irqrestore(&vas_thread_id_lock, flags);
> -		return -ENOMEM;
> -	}
> -
> -	return index;
> -}
> -
> -static void free_thread_tidr(int id)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&vas_thread_id_lock, flags);
> -	ida_remove(&vas_thread_ida, id);
> -	spin_unlock_irqrestore(&vas_thread_id_lock, flags);
> -}
> -
> -/*
> - * Clear any TIDR value assigned to this thread.
> - */
> -void clear_thread_tidr(struct task_struct *t)
> -{
> -	if (!t->thread.tidr)
> -		return;
> -
> -	if (!cpu_has_feature(CPU_FTR_P9_TIDR)) {
> -		WARN_ON_ONCE(1);
> -		return;
> -	}
> -
> -	mtspr(SPRN_TIDR, 0);
> -	free_thread_tidr(t->thread.tidr);
> -	t->thread.tidr = 0;
> -}
> -
> -void arch_release_task_struct(struct task_struct *t)
> -{
> -	clear_thread_tidr(t);
> -}
> -
> -/*
> - * Assign a unique TIDR (thread id) for task @t and set it in the thread
> - * structure. For now, we only support setting TIDR for 'current' task.
> + * 4. Both threads are running
> + * Both threads will be woken. The wrong thread will fail it's condition check
> + * and execute another wait, while the correct thread will pass it's condition
> + * check.
> + *
> + * @t: the task to set the thread ID for
>    */
>   int set_thread_tidr(struct task_struct *t)
>   {
> -	int rc;
> -
>   	if (!cpu_has_feature(CPU_FTR_P9_TIDR))
>   		return -EINVAL;
> 
> @@ -1602,11 +1540,7 @@ int set_thread_tidr(struct task_struct *t)
>   	if (t->thread.tidr)
>   		return 0;
> 
> -	rc = assign_thread_tidr();
> -	if (rc < 0)
> -		return rc;
> -
> -	t->thread.tidr = rc;
> +	t->thread.tidr = (u16)task_pid_nr(t);
>   	mtspr(SPRN_TIDR, t->thread.tidr);
> 
>   	return 0;
> 
