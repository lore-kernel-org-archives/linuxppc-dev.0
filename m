Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm95v12jhzDqpN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 20:02:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>, cyrilbur@gmail.com <cyrilbur@gmail.com>
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
In-Reply-To: <1467898167.27157.47.camel@kernel.crashing.org>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
 <1467897678.27157.45.camel@kernel.crashing.org>
 <1467898167.27157.47.camel@kernel.crashing.org>
Date: Fri, 08 Jul 2016 20:02:42 +1000
Message-ID: <871t34xxa5.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2016-07-07 at 23:21 +1000, Benjamin Herrenschmidt wrote:
>>=C2=A0
>> I think the right fix is that if a restore_sigcontext() has the MSR
>> bits set,
>> it should set the corresponding used_* flag.
>
> Something like this:
>
> (totally untested)

Simon/Laurent, can you guys test this and let me know if it works for
your usecase.

Cyril, can you give this a review, you've been touching this code the
most lately.

cheers

> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal=
_32.c
> index b6aa378..1bf074e 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -698,6 +698,7 @@ static long restore_user_regs(struct pt_regs *regs,
>  		if (__copy_from_user(&current->thread.vr_state, &sr->mc_vregs,
>  				     sizeof(sr->mc_vregs)))
>  			return 1;
> +		current->thread.used_vr =3D true;
>  	} else if (current->thread.used_vr)
>  		memset(&current->thread.vr_state, 0,
>  		       ELF_NVRREG * sizeof(vector128));
> @@ -724,6 +725,7 @@ static long restore_user_regs(struct pt_regs *regs,
>  		 */
>  		if (copy_vsx_from_user(current, &sr->mc_vsregs))
>  			return 1;
> +		current->thread.used_vsr =3D true;
>  	} else if (current->thread.used_vsr)
>  		for (i =3D 0; i < 32 ; i++)
>  			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] =3D 0;
> @@ -743,6 +745,7 @@ static long restore_user_regs(struct pt_regs *regs,
>  		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
>  				     ELF_NEVRREG * sizeof(u32)))
>  			return 1;
> +		current->thread.used_spe =3D true;
>  	} else if (current->thread.used_spe)
>  		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
>=20=20
> @@ -799,6 +802,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
>  				     &tm_sr->mc_vregs,
>  				     sizeof(sr->mc_vregs)))
>  			return 1;
> +		current->thread.used_vr =3D true;
>  	} else if (current->thread.used_vr) {
>  		memset(&current->thread.vr_state, 0,
>  		       ELF_NVRREG * sizeof(vector128));
> @@ -832,6 +836,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
>  		if (copy_vsx_from_user(current, &sr->mc_vsregs) ||
>  		    copy_transact_vsx_from_user(current, &tm_sr->mc_vsregs))
>  			return 1;
> +		current->thread.used_vsr =3D true;
>  	} else if (current->thread.used_vsr)
>  		for (i =3D 0; i < 32 ; i++) {
>  			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] =3D 0;
> @@ -848,6 +853,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
>  		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
>  				     ELF_NEVRREG * sizeof(u32)))
>  			return 1;
> +		current->thread.used_spe =3D true;
>  	} else if (current->thread.used_spe)
>  		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
>=20=20
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal=
_64.c
> index 2552079..8704269 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -363,9 +363,11 @@ static long restore_sigcontext(struct pt_regs *regs,=
 sigset_t *set, int sig,
>  	if (v_regs && !access_ok(VERIFY_READ, v_regs, 34 * sizeof(vector128)))
>  		return -EFAULT;
>  	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
> -	if (v_regs !=3D NULL && (msr & MSR_VEC) !=3D 0)
> +	if (v_regs !=3D NULL && (msr & MSR_VEC) !=3D 0) {
>  		err |=3D __copy_from_user(&current->thread.vr_state, v_regs,
>  					33 * sizeof(vector128));
> +		current->thread.used_vr =3D true;
> +	}
>  	else if (current->thread.used_vr)
>  		memset(&current->thread.vr_state, 0, 33 * sizeof(vector128));
>  	/* Always get VRSAVE back */
> @@ -385,9 +387,10 @@ static long restore_sigcontext(struct pt_regs *regs,=
 sigset_t *set, int sig,
>  	 * buffer for formatting, then into the taskstruct.
>  	 */
>  	v_regs +=3D ELF_NVRREG;
> -	if ((msr & MSR_VSX) !=3D 0)
> +	if ((msr & MSR_VSX) !=3D 0) {
>  		err |=3D copy_vsx_from_user(current, v_regs);
> -	else
> +		current->thread.used_vsr =3D true;
> +	} else
>  		for (i =3D 0; i < 32 ; i++)
>  			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] =3D 0;
>  #endif
> @@ -482,6 +485,7 @@ static long restore_tm_sigcontexts(struct pt_regs *re=
gs,
>  					33 * sizeof(vector128));
>  		err |=3D __copy_from_user(&current->thread.transact_vr, tm_v_regs,
>  					33 * sizeof(vector128));
> +		current->thread.used_vr =3D true;
>  	}
>  	else if (current->thread.used_vr) {
>  		memset(&current->thread.vr_state, 0, 33 * sizeof(vector128));
> @@ -515,6 +519,7 @@ static long restore_tm_sigcontexts(struct pt_regs *re=
gs,
>  		tm_v_regs +=3D ELF_NVRREG;
>  		err |=3D copy_vsx_from_user(current, v_regs);
>  		err |=3D copy_transact_vsx_from_user(current, tm_v_regs);
> +		current->thread.used_vsr =3D true;
>  	} else {
>  		for (i =3D 0; i < 32 ; i++) {
>  			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] =3D 0;
