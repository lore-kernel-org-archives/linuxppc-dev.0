Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW0NV3gHWzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 19:44:26 +1100 (AEDT)
Message-ID: <1458809065.23205.106.camel@neuling.org>
Subject: Re: [PATCH 3/5] powerpc: Fix TAR leak across exec() syscalls
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
Date: Thu, 24 Mar 2016 19:44:25 +1100
In-Reply-To: <1458712025-3525-3-git-send-email-cyrilbur@gmail.com>
References: <1458712025-3525-1-git-send-email-cyrilbur@gmail.com>
 <1458712025-3525-3-git-send-email-cyrilbur@gmail.com>
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

On Wed, 2016-03-23 at 16:47 +1100, Cyril Bur wrote:
> Currently start_thread() doesn't sanitise TAR.
>=20
> The TAR SPR register is a register that can be set and branched to, not
> sanitising it presents an information leak to the new executable.
>=20
> Other SPR registers such as the Performance registers used by perf (and a=
re
> managed entirely by perf) as well as the Event Based Branch (EBB) registe=
rs are
> left alone by design as these fall into the same category as leaving file
> descriptors open across exec(), it is up the parent thread to sanitise wh=
at it
> deems necessary.
>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/kernel/process.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index d7a9df5..56444a6 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1577,6 +1577,8 @@ void start_thread(struct pt_regs *regs, unsigned lo=
ng start, unsigned long sp)
>  	current->thread.vr_state.vscr.u[3] =3D 0x00010000; /* Java mode disable=
d */
>  	current->thread.vr_save_area =3D NULL;
>  	current->thread.vrsave =3D 0;
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC))
> +		mtspr(SPRN_VRSAVE, 0);

VRSAVE is not mentioned in the commit message.

>  	current->thread.used_vr =3D 0;
>  #endif /* CONFIG_ALTIVEC */
>  #ifdef CONFIG_SPE
> @@ -1592,6 +1594,18 @@ void start_thread(struct pt_regs *regs, unsigned l=
ong start, unsigned long sp)
>  	current->thread.tm_texasr =3D 0;
>  	current->thread.tm_tfiar =3D 0;
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	/*
> +	 * Zero out the SPRs.
> +	 * Don't touch the ones use by perf, it controls them.
> +	 * Don't touch the EBB regs. This falls into the same category of
> +	 *   responsibly as open file descriptors across exec(), the parent sho=
uld
> +	 *   sanitise if it feels it would be a problem
> +	 */
> +	current->thread.tar =3D 0;
> +	if (cpu_has_feature(CPU_FTR_ARCH_206))
> +		mtspr(SPRN_TAR, 0);
> +#endif /* CONFIG_PPC_BOOK3S_64 */
>  }
>  EXPORT_SYMBOL(start_thread);
> =20
