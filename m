Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DsF42cZNzDrTP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 15:36:56 +1000 (AEST)
Message-ID: <743b29dab736700c1b284fabb8fccf7c83ddb3c2.camel@neuling.org>
Subject: Re: [RFC PATCH 08/11] powerpc/tm: Do not reclaim on ptrace
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com
Date: Tue, 18 Sep 2018 15:36:55 +1000
In-Reply-To: <1536781219-13938-9-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-9-git-send-email-leitao@debian.org>
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
> Make sure that we are not suspended on ptrace and that the registers were
> already reclaimed.
>=20
> Since the data was already reclaimed, there is nothing to be done here
> except to restore the SPRs.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 9667666eb18e..cf6ee9154b11 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -136,12 +136,10 @@ static void flush_tmregs_to_thread(struct task_stru=
ct
> *tsk)
>  	if ((!cpu_has_feature(CPU_FTR_TM)) || (tsk !=3D current))
>  		return;
> =20
> -	if (MSR_TM_SUSPENDED(mfmsr())) {
> -		tm_reclaim_current(TM_CAUSE_SIGNAL);
> -	} else {
> -		tm_enable();
> -		tm_save_sprs(&(tsk->thread));
> -	}
> +	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
> +
> +	tm_enable();
> +	tm_save_sprs(&(tsk->thread));

Do we need to check if TM was enabled in the task before saving the TM SPRs=
?

What happens if TM was lazily off and hence we had someone else's TM SPRs i=
n the
CPU currently?  Wouldn't this flush the wrong values to the task_struct?

I think we need to check the processes MSR before doing this.

Mikey

>  }
>  #else
>  static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
