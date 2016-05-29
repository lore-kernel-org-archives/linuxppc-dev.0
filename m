Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rHwYq6Yr5zDqCj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:14:23 +1000 (AEST)
Message-ID: <1464563663.27056.74.camel@neuling.org>
Subject: Re: [PATCH 2/3] powerpc: Avoid load hit store in setup_sigcontext()
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@ozlabs.org>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com,  acsawdey@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 30 May 2016 09:14:23 +1000
In-Reply-To: <1464523432-12605-2-git-send-email-anton@ozlabs.org>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
 <1464523432-12605-2-git-send-email-anton@ozlabs.org>
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

On Sun, 2016-05-29 at 22:03 +1000, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
>=20
> In setup_sigcontext(), we set current->thread.vrsave then use it
> straight after. Since current is hidden from the compiler via inline
> assembly, it cannot optimise this and we end up with a load hit store.

Is setup_sigcontext() really a fast path we need to optimise?

Mikey

> Fix this by using a temporary.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> =C2=A0arch/powerpc/kernel/signal_64.c | 11 ++++++++---
> =C2=A01 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/signal_64.c
> b/arch/powerpc/kernel/signal_64.c
> index 2552079..7e49984 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -104,6 +104,7 @@ static long setup_sigcontext(struct sigcontext __user
> *sc, struct pt_regs *regs,
> =C2=A0	=C2=A0*/
> =C2=A0#ifdef CONFIG_ALTIVEC
> =C2=A0	elf_vrreg_t __user *v_regs =3D sigcontext_vmx_regs(sc);
> +	unsigned long vrsave;
> =C2=A0#endif
> =C2=A0	unsigned long msr =3D regs->msr;
> =C2=A0	long err =3D 0;
> @@ -125,9 +126,13 @@ static long setup_sigcontext(struct sigcontext
> __user *sc, struct pt_regs *regs,
> =C2=A0	/* We always copy to/from vrsave, it's 0 if we don't have or
> don't
> =C2=A0	=C2=A0* use altivec.
> =C2=A0	=C2=A0*/
> -	if (cpu_has_feature(CPU_FTR_ALTIVEC))
> -		current->thread.vrsave =3D mfspr(SPRN_VRSAVE);
> -	err |=3D __put_user(current->thread.vrsave, (u32 __user
> *)&v_regs[33]);
> +	vrsave =3D 0;
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
> +		vrsave =3D mfspr(SPRN_VRSAVE);
> +		current->thread.vrsave =3D vrsave;
> +	}
> +
> +	err |=3D __put_user(vrsave, (u32 __user *)&v_regs[33]);
> =C2=A0#else /* CONFIG_ALTIVEC */
> =C2=A0	err |=3D __put_user(0, &sc->v_regs);
> =C2=A0#endif /* CONFIG_ALTIVEC */
