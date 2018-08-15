Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41rlFp4zgxzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 21:57:50 +1000 (AEST)
Message-ID: <1cbbde5731af43a5122a2e03656e6fc8e252f9ee.camel@neuling.org>
Subject: Re: [PATCH v2 3/4] powerpc/tm: Adjust tm_reclaim_thread() parameters
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Cyril Bur <cyrilbur@gmail.com>
Date: Thu, 16 Aug 2018 09:48:02 +1000
In-Reply-To: <1529362784-14194-3-git-send-email-leitao@debian.org>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
 <1529362784-14194-3-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-18 at 19:59 -0300, Breno Leitao wrote:
> From: Cyril Bur <cyrilbur@gmail.com>
>=20
> tm_reclaim_thread() doesn't use the parameter anymore, both callers have
> to bother getting it as they have no need for a struct thread_info
> either.
>=20
> It was previously used but became unused in commit
> dc3106690b20 ("powerpc: tm: Always use fp_state and vr_state to store liv=
e
> registers")
>=20
> Just remove it and adjust the callers.
>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Michael Neuling <mikey@neuling.org.>

> ---
>  arch/powerpc/kernel/process.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 9ef4aea9fffe..f8beee03f00a 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -866,8 +866,7 @@ static inline bool tm_enabled(struct task_struct *tsk=
)
>  	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
>  }
> =20
> -static void tm_reclaim_thread(struct thread_struct *thr,
> -			      struct thread_info *ti, uint8_t cause)
> +static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
>  {
>  	/*
>  	 * Use the current MSR TM suspended bit to track if we have
> @@ -914,7 +913,7 @@ static void tm_reclaim_thread(struct thread_struct *t=
hr,
>  void tm_reclaim_current(uint8_t cause)
>  {
>  	tm_enable();
> -	tm_reclaim_thread(&current->thread, current_thread_info(), cause);
> +	tm_reclaim_thread(&current->thread, cause);
>  }
> =20
>  static inline void tm_reclaim_task(struct task_struct *tsk)
> @@ -945,7 +944,7 @@ static inline void tm_reclaim_task(struct task_struct
> *tsk)
>  		 thr->regs->ccr, thr->regs->msr,
>  		 thr->regs->trap);
> =20
> -	tm_reclaim_thread(thr, task_thread_info(tsk), TM_CAUSE_RESCHED);
> +	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
> =20
>  	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
>  		 tsk->pid);
