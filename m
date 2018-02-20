Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zllWn5hK8zDqNc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 13:52:05 +1100 (AEDT)
Message-ID: <1519095125.7360.54.camel@neuling.org>
Subject: Re: [RFC PATCH 06/12] [WIP] powerpc/tm: Remove dead code from
 __switch_to_tm()
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Feb 2018 13:52:05 +1100
In-Reply-To: <20180220002241.29648-7-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
 <20180220002241.29648-7-cyrilbur@gmail.com>
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

Not sure I understand this.. should it be merged with the last patch?

Needs a comment here.


On Tue, 2018-02-20 at 11:22 +1100, Cyril Bur wrote:
> ---
>  arch/powerpc/kernel/process.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index ea75da0fd506..574b05fe7d66 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1027,27 +1027,13 @@ static inline void __switch_to_tm(struct task_str=
uct *prev,
>  		struct task_struct *new)
>  {
>  	/*
> -	 * So, with the rework none of this code should not be needed.
> -	 * I've left in the reclaim for now. This *should* save us
> -	 * from any mistake in the new code. Also the
> -	 * enabling/disabling logic of MSR_TM really should be
> +	 * The enabling/disabling logic of MSR_TM really should be
>  	 * refactored into a common way with MSR_{FP,VEC,VSX}
>  	 */
> -	if (cpu_has_feature(CPU_FTR_TM)) {
> -		if (tm_enabled(prev) || tm_enabled(new))
> -			tm_enable();
> -
> -		if (tm_enabled(prev)) {
> -			prev->thread.load_tm++;
> -			tm_reclaim_task(prev);
> -			/*
> -			 * The disabling logic may be confused don't
> -			 * disable for now
> -			 *
> -			 * if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm=
 =3D=3D 0)
> -			 *	prev->thread.regs->msr &=3D ~MSR_TM;
> -			 */
> -		}
> +	if (cpu_has_feature(CPU_FTR_TM) && tm_enabled(prev)) {
> +		prev->thread.load_tm++;
> +		if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm =3D=
=3D 0)
> +			prev->thread.regs->msr &=3D ~MSR_TM;
>  	}
>  }
> =20
