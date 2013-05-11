Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E78722C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 17:01:03 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id p11so3237096pdj.40
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 00:01:00 -0700 (PDT)
Date: Sat, 11 May 2013 15:00:51 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/85xx: enable coreint for all the 64bit boards
Message-ID: <20130511070051.GA29695@pek-khao-d1.corp.ad.wrs.com>
References: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
 <1365643954-20798-3-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <1365643954-20798-3-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2013 at 09:32:34AM +0800, Kevin Hao wrote:
> With the patch 7230c564 (powerpc: Rework lazy-interrupt handling),
> it seems that the coreint works pretty well on the 85xx 64bit kernel.
> So use the coreint by default for these boards.

Hi Kumar,

Since the external proxy works pretty well with the lazy EE without any cha=
nge
to the current kernel, could you please pick this patch up? This has already
been acked by Scott. I also think I got a implicit ack from Benjamin.
I will try to use the PACA_IRQ_EE_EDGE to make the support for external
proxy more better a little later as suggested by Benjamin.

Thanks,
Kevin

>=20
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/platforms/85xx/p5020_ds.c  | 5 -----
>  arch/powerpc/platforms/85xx/p5040_ds.c  | 5 -----
>  arch/powerpc/platforms/85xx/t4240_qds.c | 5 -----
>  3 files changed, 15 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platfo=
rms/85xx/p5020_ds.c
> index 753a42c..39cfa40 100644
> --- a/arch/powerpc/platforms/85xx/p5020_ds.c
> +++ b/arch/powerpc/platforms/85xx/p5020_ds.c
> @@ -75,12 +75,7 @@ define_machine(p5020_ds) {
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
>  #endif
> -/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
> -#ifdef CONFIG_PPC64
> -	.get_irq		=3D mpic_get_irq,
> -#else
>  	.get_irq		=3D mpic_get_coreint_irq,
> -#endif
>  	.restart		=3D fsl_rstcr_restart,
>  	.calibrate_decr		=3D generic_calibrate_decr,
>  	.progress		=3D udbg_progress,
> diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platfo=
rms/85xx/p5040_ds.c
> index 1138185..f70e74c 100644
> --- a/arch/powerpc/platforms/85xx/p5040_ds.c
> +++ b/arch/powerpc/platforms/85xx/p5040_ds.c
> @@ -66,12 +66,7 @@ define_machine(p5040_ds) {
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
>  #endif
> -/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
> -#ifdef CONFIG_PPC64
> -	.get_irq		=3D mpic_get_irq,
> -#else
>  	.get_irq		=3D mpic_get_coreint_irq,
> -#endif
>  	.restart		=3D fsl_rstcr_restart,
>  	.calibrate_decr		=3D generic_calibrate_decr,
>  	.progress		=3D udbg_progress,
> diff --git a/arch/powerpc/platforms/85xx/t4240_qds.c b/arch/powerpc/platf=
orms/85xx/t4240_qds.c
> index 5998e9f..91ead6b 100644
> --- a/arch/powerpc/platforms/85xx/t4240_qds.c
> +++ b/arch/powerpc/platforms/85xx/t4240_qds.c
> @@ -75,12 +75,7 @@ define_machine(t4240_qds) {
>  #ifdef CONFIG_PCI
>  	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
>  #endif
> -/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
> -#ifdef CONFIG_PPC64
> -	.get_irq		=3D mpic_get_irq,
> -#else
>  	.get_irq		=3D mpic_get_coreint_irq,
> -#endif
>  	.restart		=3D fsl_rstcr_restart,
>  	.calibrate_decr		=3D generic_calibrate_decr,
>  	.progress		=3D udbg_progress,
> --=20
> 1.8.1.4
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRjeyjAAoJEJNY7TDerrFxGAAH/3Rs7ggktnEyOCyyaCGa3BS9
iOXnkiFCkkQo6OnbMIM7NopMawIhlQpNsZxewyr9HbHzTumpHO7Z8j+ZeMLKnpT3
ObQYJ1W6zfX1KKI+XgM4kfFkyJ6/udI4zSGJ89/QzzS9ga2thM28WjxEfYY9DWBL
VC2uZvnIEwXCXIC1XLhXPmPxHbtCIbqc7lpVIs0XSuO9VwJRGovsz8ShD3ms8UOG
n+Gc/yaNjOTo9b+9qp/cE63171IsJm6WLR8DYyr+pqOEZxTVlnMzcUm/h/Mpaf9C
UrHyuxInJhLzrCTlVv6UMN7E6H70p7h3wdu6sMYI384bodgDX4A1Gk1MqrDjsrc=
=WrrB
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
