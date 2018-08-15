Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41rlFp4ZzyzDqrM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 21:57:50 +1000 (AEST)
Message-ID: <cb89f5cf8d751da3de587b33cc07cc9292f5b324.camel@neuling.org>
Subject: Re: [PATCH v2 4/4] powerpc/tm: Do not recheckpoint non-tm task
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 16 Aug 2018 09:50:05 +1000
In-Reply-To: <1529362784-14194-4-git-send-email-leitao@debian.org>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
 <1529362784-14194-4-git-send-email-leitao@debian.org>
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
> If __switch_to() tries to context switch from task A to task B, and task =
A
>  had task->thread->regs->msr[TM] enabled, then __switch_to_tm() will call
> tm_recheckpoint_new_task(), which will call trecheckpoint, for task B, wh=
ich
>  is clearly wrong since task B might not be an active TM user.
>=20
> This does not cause a lot of damage because tm_recheckpoint() will abort
> the call since it realize that the current task does not have msr[TM] bit
> set.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/process.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index f8beee03f00a..d26a150766ef 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1036,7 +1036,8 @@ static inline void __switch_to_tm(struct task_struc=
t
> *prev,
>  				prev->thread.regs->msr &=3D ~MSR_TM;
>  		}
> =20
> -		tm_recheckpoint_new_task(new);
> +		if (tm_enabled(new))
> +			tm_recheckpoint_new_task(new);

I'm not sure we need this patch as tm_recheckpoint_new_task() does this its=
elf.

---
static inline void tm_recheckpoint_new_task(struct task_struct *new)
{
	if (!cpu_has_feature(CPU_FTR_TM))
		return;

	/* Recheckpoint the registers of the thread we're about to switch to.
	 *
	 * If the task was using FP, we non-lazily reload both the original and
	 * the speculative FP register states.  This is because the kernel
	 * doesn't see if/when a TM rollback occurs, so if we take an FP
	 * unavailable later, we are unable to determine which set of FP regs
	 * need to be restored.
	 */
	if (!tm_enabled(new))
		return;


---
Mikey
