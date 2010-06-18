Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 7F1A41007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 15:46:21 +1000 (EST)
Received: by wyb40 with SMTP id 40so331232wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 22:46:18 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1276838958-28947-3-git-send-email-leoli@freescale.com>
References: <1276838958-28947-1-git-send-email-leoli@freescale.com>
	<1276838958-28947-2-git-send-email-leoli@freescale.com>
	<1276838958-28947-3-git-send-email-leoli@freescale.com>
Date: Fri, 18 Jun 2010 07:46:18 +0200
Message-ID: <AANLkTind1zMrnldhZmeacglmVyfX8VN2qO_JJlkPAe0v@mail.gmail.com>
Subject: Re: [PATCH 3/3] fsl_rio: fix non-standard HID1 register access
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Li Yang <leoli@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 18, 2010 at 07:29, Li Yang <leoli@freescale.com> wrote:
> The access to HID1 register is only legitimate for e500 v1/v2 cores.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> =C2=A0arch/powerpc/sysdev/fsl_rio.c | =C2=A0 =C2=A07 +++++--
> =C2=A01 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.=
c
> index 954a754..785a882 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -1523,9 +1523,12 @@ int fsl_rio_setup(struct of_device *dev)
> =C2=A0#ifdef CONFIG_E500
> =C2=A0 =C2=A0 =C2=A0 =C2=A0saved_mcheck_exception =3D ppc_md.machine_chec=
k_exception;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ppc_md.machine_check_exception =3D fsl_rio_mch=
eck_exception;
> -#endif
> - =C2=A0 =C2=A0 =C2=A0 /* Ensure that RFXE is set */
> +
> +#ifndef CONFIG_E500MC
> + =C2=A0 =C2=A0 =C2=A0 /* Ensure that RFXE is set on e500 v1/v2 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000))=
;
> +#endif /* !E500MC */
> +#endif /* E500 */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0err:

This prevents you from building a kernel for both normal E500 and E500MC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
