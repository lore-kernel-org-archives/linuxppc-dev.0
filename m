Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DllQ3t6VzF2ZM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 11:29:22 +1000 (AEST)
Message-ID: <53c7daa6af9a502827e877d04b4a45b7eea5efbe.camel@neuling.org>
Subject: Re: [RFC PATCH 05/11] powerpc/tm: Function that updates the failure
 code
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com
Date: Tue, 18 Sep 2018 11:29:21 +1000
In-Reply-To: <1536781219-13938-6-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-6-git-send-email-leitao@debian.org>
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

On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> Now the transaction reclaims happens very earlier in the trap handler, an=
d
> it is impossible to know precisely, at that early time, what should be se=
t
> as the failure cause for some specific cases, as, if the task will be
> rescheduled, thus, the transaction abort case should be updated from
> TM_CAUSE_MISC to TM_CAUSE_RESCHED, for example.

Please add comments to where this is used (in EXCEPTION_COMMON macro I thin=
k)
that say this might happen.

>=20
> This patch creates a function that will update TEXASR special purpose
> register in the task thread and set the failure code which will be
> moved to the live register afterward.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/process.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 54fddf03b97a..fe063c0142e3 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -85,6 +85,7 @@ extern unsigned long _get_SP(void);
>   * other paths that we should never reach with suspend disabled.
>   */
>  bool tm_suspend_disabled __ro_after_init =3D false;
> +static void tm_fix_failure_cause(struct task_struct *task, uint8_t cause=
);
> =20
>  static void check_if_tm_restore_required(struct task_struct *tsk)
>  {
> @@ -988,6 +989,14 @@ void tm_recheckpoint(struct thread_struct *thread)
>  	local_irq_restore(flags);
>  }
> =20
> +/* Change thread->tm.texasr failure code */
> +static void tm_fix_failure_cause(struct task_struct *task, uint8_t cause=
)
> +{
> +	/* Clear the cause first */
> +	task->thread.tm_texasr &=3D ~TEXASR_FC;
> +	task->thread.tm_texasr |=3D (unsigned long) cause << 56;
> +}
> +
>  static inline void tm_recheckpoint_new_task(struct task_struct *new)
>  {
>  	if (!cpu_has_feature(CPU_FTR_TM))
