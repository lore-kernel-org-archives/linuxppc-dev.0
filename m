Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S8Xn3TFHzF25F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 18:44:09 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3K8hTpO012605
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 04:44:05 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hf9xh7w1j-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 04:44:05 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 20 Apr 2018 09:44:02 +0100
Subject: Re: [PATCH v2 3/7] powerpc: use task_pid_nr() for TID allocation
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-4-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 20 Apr 2018 18:43:55 +1000
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-4-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b088d063-058a-2557-812c-6d5659f9d67b@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+ Sukadev, Christophe]

On 18/04/18 11:08, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The current implementation of TID allocation, using a global IDR, may
> result in an errant process starving the system of available TIDs.
> Instead, use task_pid_nr(), as mentioned by the original author. The
> scenario described which prevented it's use is not applicable, as
> set_thread_tidr can only be called after the task struct has been
> populated.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

So it's too late in the evening for me to completely get my head around 
what's going on here enough to give my Reviewed-by:, but my current 
thinking is:

- In the first version of the patch to add TIDR support 
(https://patchwork.ozlabs.org/patch/799494/), it was originally proposed 
to call assign_thread_id() (as it was then called) from copy_thread()

- The comment block documents the reason why we can't use task_pid_nr() 
but assumes that we're trying to assign a TIDR from within copy_thread()

- The final patch that was accepted 
(https://patchwork.ozlabs.org/patch/835552/, 
ec233ede4c8654894610ea54f4dae7adc954ac62) instead sets the TIDR to 0 
from copy_thread(), so the original reasoning regarding not using 
task_pid_nr() within copy_thread() is no longer applicable.

Sukadev: does this sound right?


Andrew


> ---
>   arch/powerpc/include/asm/switch_to.h |  1 -
>   arch/powerpc/kernel/process.c        | 97 +-----------------------------------
>   2 files changed, 1 insertion(+), 97 deletions(-)
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
> index 3b00da47699b..87f047fd2762 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1496,103 +1496,12 @@ int set_thread_uses_vas(void)
>   }
>   
>   #ifdef CONFIG_PPC64
> -static DEFINE_SPINLOCK(vas_thread_id_lock);
> -static DEFINE_IDA(vas_thread_ida);
> -
> -/*
> - * We need to assign a unique thread id to each thread in a process.
> - *
> - * This thread id, referred to as TIDR, and separate from the Linux's tgid,
> - * is intended to be used to direct an ASB_Notify from the hardware to the
> - * thread, when a suitable event occurs in the system.
> - *
> - * One such event is a "paste" instruction in the context of Fast Thread
> - * Wakeup (aka Core-to-core wake up in the Virtual Accelerator Switchboard
> - * (VAS) in POWER9.
> - *
> - * To get a unique TIDR per process we could simply reuse task_pid_nr() but
> - * the problem is that task_pid_nr() is not yet available copy_thread() is
> - * called. Fixing that would require changing more intrusive arch-neutral
> - * code in code path in copy_process()?.
> - *
> - * Further, to assign unique TIDRs within each process, we need an atomic
> - * field (or an IDR) in task_struct, which again intrudes into the arch-
> - * neutral code. So try to assign globally unique TIDRs for now.
> - *
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
>   /*
>    * Assign a unique TIDR (thread id) for task @t and set it in the thread
>    * structure. For now, we only support setting TIDR for 'current' task.
>    */
>   int set_thread_tidr(struct task_struct *t)
>   {
> -	int rc;
> -
>   	if (!cpu_has_feature(CPU_FTR_P9_TIDR))
>   		return -EINVAL;
>   
> @@ -1602,11 +1511,7 @@ int set_thread_tidr(struct task_struct *t)
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
