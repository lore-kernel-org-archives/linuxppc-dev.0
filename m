Return-Path: <linuxppc-dev+bounces-21681-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00E2CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 07:01:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRZ6C1gqjz2xnK;
	Fri, 29 May 2026 17:01:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780038115;
	cv=pass; b=apXEW8S82A2ge80+ChNKO1b2mSPjVvIuFk4DFxy1h3LkSwXtJ2RPYx7+srSmbJYrYmpQAUqgoNJwMEj52l6gUw9W/d3W0iqa4Bq4icrg9bfM/gfR8aNCL+P0oeIjhmu/+KwsxdgD3TtHxQhkaSKdtNz7j2yXQDYHtjbADntbzwR0kV+58V0u+NccUJwmlAK3ePdEGmh0jeWHw7z0ICRNhmz7pdf1fmXJd7z+jTfgNgmLyniZJLOt+mNPPSlDA/8EYoKO2Pgjv6FoA1OnKo5+eInxNxL8Uctne3w6tLPTynHbRg3R+fL2knp8wGMxcsrpcBBspNGAaREANNIzLY8UjA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780038115; c=relaxed/relaxed;
	bh=t89bnL9txs8rrnZk0wRkeIs3fRkSrv8Tzr4zb4FyARo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COPxJQjMrEspyrl/2bNzinCTDbjuFmjToMNjvwZ+gEodShbd/DRXyFaVWH7AdGW18YS4mI6RTeI+sTNYtAlvLr3HwqUk/nvQUAf8hn7IEckTt6PO6lttvt7OAR8ZCmTOQntD4EwvzLCRsGrPBKb6p+vyOHra3zjZ1uGrnpTqtFD79/Q8FyQC5z1qnR8f/Xnz3k3ZEHZDCSQP8WiKFdw5ispDuv/sKG9JahOCMeKiC6650ft07xnZjkLwJOM/MnyBY2yocqNRgn3giXn7e3EViHXXIld6npkTeJ2/utkqyQllXY5UID8y0YzLcZ63QLG1L49g7Vj2d/dmCTb+5KyMRw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kcsRZgR3; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kcsRZgR3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRZ693vLFz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 17:01:53 +1000 (AEST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso1327767a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 00:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780038110; cv=none;
        d=google.com; s=arc-20240605;
        b=C8LjKVtmWJY/aROJ5feat6H2aRKX/qpVcZfFoAACuvc5f0K/DX4qpCdyOVMpN3sys+
         GaRa9c2OCgjsd+e0xOZUxkWADS8bTPoa/zahiKnvBRyNsurgS17Xr33Jgv2dXdy9WfKw
         6m85iKvIZ5BJrICBdDnELrJ+bZ3QDtJTYHdf1LIcZRzMoCxfjA+fDWT98hiFEd+pr3kT
         gnzTBiLR1qtJyXq9BhXTa4AKdPg1uvxeV0Z4hW2E1M7tYG+giRWLScnGKUcHJB3LdBCG
         8bcy5Hv3gG4ZEQgCUQ78g3ftfEA93tlKsyQOJE/SoYODe7FiBJah8fZI93fDNLUuhWHu
         d2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t89bnL9txs8rrnZk0wRkeIs3fRkSrv8Tzr4zb4FyARo=;
        fh=h2leOhG82C5mlcgdopxnhpBqw+G0VkL8th/i3QeJ4Jk=;
        b=lGVf2dh+060GlcvV9mvoZydEAmHX0U+RaKJ9TZikIOJWNMGSPJKQ312DnU8gt38pdT
         0mOYSUq/vJhsHSlMma4Dq5q2v/qz4Mgd79PHvX9IVJmrwuwwsCA9oiyzomlGGeSjKwmc
         X3jcM+8Y1FG4BFaC+0nuqzlERsru/7w8+sSUGG/LDvWaVDFqU88vWJJy4svfGlWWifou
         +VBxkxJ/EG3ilu7OO2cKkuEGNpVZh7gbwxPSMhTREqlEgNeKWxWbxORlXGBfklxrwc8S
         zYVqOclhtrXgTDqgOxiY5B+EnZZ1plw+AayT9ADHiIpIkU2wL79JpOvuNieXybe5Z9/4
         765Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780038110; x=1780642910; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t89bnL9txs8rrnZk0wRkeIs3fRkSrv8Tzr4zb4FyARo=;
        b=kcsRZgR3zg3ZizQHDODDTQwxrsIBoG10H4d0FldrfXvCDxFMQ4pgARwIUnUNVAXv2/
         SHoJHaxW2aXrfVV2SNSNvt9YJzl7IuaZ0WITDoFCqJl+YvhvuboZurUMBzuQETho2xB+
         xUofqL59KEvnRD/VnZpppYuYP7UKjarMjRJ6K4tbTTE4zFkTpnQu+Uj2sv//6eOCIBnt
         D/qxA9WUtKrk2QI7s6W+ymmgVESAODuQHcCMMLl+FMqm+/ddYIY4CC8ZTqaQhJm8wExM
         3IcykKOejMADFyM2/8LSGChsdTGbxZzg/PsuioX5nPkkSiFRyWSdBaYRgc3A+ZP4eGNM
         SnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038110; x=1780642910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t89bnL9txs8rrnZk0wRkeIs3fRkSrv8Tzr4zb4FyARo=;
        b=V+c3LPNTzc2QRBs5Xx+bVCOhvDB3oqumwS0eBiYm/0R0CCaPjXQ0eV2XfKE+DVj1Sn
         +2J/jJwyE0LbiX7X1aj9vUXJooq5F9H9VhEF7uk217RaNQJ8BNOIphHHBV0StC93Vb0D
         8sjPJwD+CD1jWHE/9uc9tif47DkWzkhg9MX//j24QIggAaG3YYOblo82bmLs+AsQU+Gt
         S5CNsqXU9Fb4cgbzztaozBUUuRJMdHgJMnJUFnOGwazyfHLz8Hah2/5OpNufXmbBl2MD
         azbjmNL8BFOKGu4lVlivBoden1vXwoM7jfiwLNHqppgc5f8XOPeuhrMdX6/4AVZ5/M/v
         9fkg==
X-Gm-Message-State: AOJu0Yx+RdhOTPuY9+Gfstluv0923MgoYraalaY+Ibt7WBKEZVmYYDAK
	099Pix35pKQKbN48P6EY13CGwWrjTtMHqxGuQi+gX96lpDOKY70zv4YEUbmKbbSGqo2UycjB93w
	b3OFX5H1Fsyl1mZjV3iXBW8tA8/bvA2E=
X-Gm-Gg: Acq92OFKcTM/lQVtSr0G9qtUsc+bOKbUC24Hp1VbK3KPT3WGGHsk83ASzKBmhgJ5wBN
	lSF+eEDzQ5zHiDsFJXtSX1f1ZhrlPBYMqBHf77tECv68LbOky5zLkGLhYHO2FaOkMgtBFHXpq1e
	Hu/lxvM0fndPa4pyY95NQQuj0ujhUkg0cCPaqvXXqqJPN0P+83ZlArT2UJHdOLceuOhMcBKfI4q
	B1p7Blt1JIYAa4HccX3x/EoP3Jd3jm2S3uuOvcbbSRfQTht2EAzxQYE+jMzmykYTtiag4zZjBt9
	qa3DiTKUFr2Qv437A/hiL6en99+2773ToKjRGnulIgqZgZ0u8o7Qdg0Y5VqTvzWw0gVS0NxlIJJ
	6eTKKSueguNcX6mFlXqxP5CCW35v9AqVn5I3JGr7OgP4aatyZvqRgsK0YYaCA7XJ5bAVH
X-Received: by 2002:a05:6402:5191:b0:68a:2641:312a with SMTP id
 4fb4d7f45d1cf-68c1290f390mr693755a12.17.1780038103100; Fri, 29 May 2026
 00:01:43 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260528025610.713514-1-rosenp@gmail.com> <cc236562-3967-4361-ad92-05582db82282@kernel.org>
In-Reply-To: <cc236562-3967-4361-ad92-05582db82282@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 29 May 2026 00:01:30 -0700
X-Gm-Features: AVHnY4IKU0fSryaVj01s709ESdvA-IppFByGBTXOMEAy66ZniXN3g5z_mMQtTt8
Message-ID: <CAKxU2N_4i7qfayGnDUrNeAVidYq7_eCoXRNvGeF8bSWUV45uHQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:50=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 28/05/2026 =C3=A0 04:56, Rosen Penev a =C3=A9crit :
> > Move the ppc4xx gpio driver out of arch/powerpc/platforms/44x/ into
> > drivers/gpio/gpio-ppc4xx.c. The driver has no architecture-specific
> > dependencies and follows the same pattern as other PowerPC GPIO
> > drivers already in drivers/gpio/ (e.g. gpio-mpc8xxx, gpio-mpc5200).
> >
> > - Renamed Kconfig symbol from PPC4xx_GPIO to GPIO_PPC4XX
> > - Updated ppc44x_defconfig and warp_defconfig to use the new symbol
> > - Marked the new option as tristate (was bool) since the driver
> >    supports module build via module_platform_driver()
> > - Added COMPILE_TEST support. Needs PPC as clrbits32 is in use.
>
> Not only clrbits32() but also setbits32() and in_be32().
Right. I noted it as an example.
>
> On the long run we want to get rid of PPC specific IO helpers, at least
> outside arch/powerpc/ , so don't add new instances.
>
> Remove that dependency by switching to ioread32be() which has been
> equivalent to in_be32() since commit 894fa235eb4c ("powerpc: inline
> iomap accessors"), then implement a local equivalent of
> clrbits32()/setbits32()
>
> See for instance:
> - qe_setbits_be32() in include/soc/fsl/qe/qe.h
> - tsa_clrbits32() in drivers/soc/fsl/qe/tsa.c
>
> >
> > Assisted-by: OpenCode:BigPickle
> > Signed-off-by: mangix <mangix@disroot.org>
>
> Who is that ?
My computer username. I've since edited AGENTS.md so it always adds --signo=
ff.
>
> > ---
> >   arch/powerpc/configs/44x/warp_defconfig                    | 2 +-
> >   arch/powerpc/configs/ppc44x_defconfig                      | 2 +-
> >   arch/powerpc/platforms/44x/Kconfig                         | 7 ------=
-
> >   arch/powerpc/platforms/44x/Makefile                        | 1 -
> >   drivers/gpio/Kconfig                                       | 7 ++++++=
+
> >   drivers/gpio/Makefile                                      | 1 +
> >   .../platforms/44x/gpio.c =3D> drivers/gpio/gpio-ppc4xx.c     | 0
>
> Not gpio-ppc4xx.c but gpio-ppc44x.c
ACK
>
> >   7 files changed, 10 insertions(+), 10 deletions(-)
> >   rename arch/powerpc/platforms/44x/gpio.c =3D> drivers/gpio/gpio-ppc4x=
x.c (100%)
> >
> > diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/con=
figs/44x/warp_defconfig
> > index 5757625469c4..380fa15af68d 100644
> > --- a/arch/powerpc/configs/44x/warp_defconfig
> > +++ b/arch/powerpc/configs/44x/warp_defconfig
> > @@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=3Dy
> >   # CONFIG_BLK_DEV_BSG is not set
> >   # CONFIG_EBONY is not set
> >   CONFIG_WARP=3Dy
> > -CONFIG_PPC4xx_GPIO=3Dy
> > +CONFIG_GPIO_PPC4XX=3Dy
> >   CONFIG_HZ_1000=3Dy
> >   CONFIG_CMDLINE=3D"ip=3Don"
> >   # CONFIG_PCI is not set
> > diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/confi=
gs/ppc44x_defconfig
> > index 41c930f74ed4..57a7342232d7 100644
> > --- a/arch/powerpc/configs/ppc44x_defconfig
> > +++ b/arch/powerpc/configs/ppc44x_defconfig
> > @@ -22,7 +22,7 @@ CONFIG_GLACIER=3Dy
> >   CONFIG_REDWOOD=3Dy
> >   CONFIG_EIGER=3Dy
> >   CONFIG_YOSEMITE=3Dy
> > -CONFIG_PPC4xx_GPIO=3Dy
> > +CONFIG_GPIO_PPC4XX=3Dy
> >   CONFIG_MATH_EMULATION=3Dy
> >   CONFIG_NET=3Dy
> >   CONFIG_PACKET=3Dy
> > diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platform=
s/44x/Kconfig
> > index fc79f8466933..150813cea945 100644
> > --- a/arch/powerpc/platforms/44x/Kconfig
> > +++ b/arch/powerpc/platforms/44x/Kconfig
> > @@ -227,13 +227,6 @@ config PPC44x_SIMPLE
> >       help
> >         This option enables the simple PowerPC 44x platform support.
> >
> > -config PPC4xx_GPIO
> > -     bool "PPC4xx GPIO support"
> > -     depends on 44x
> > -     select GPIOLIB
> > -     help
> > -       Enable gpiolib support for ppc440 based boards
> > -
> >   # 44x specific CPU modules, selected based on the board above.
> >   config 440EP
> >       bool
> > diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platfor=
ms/44x/Makefile
> > index ca7b1bb442d9..179468a00f5e 100644
> > --- a/arch/powerpc/platforms/44x/Makefile
> > +++ b/arch/powerpc/platforms/44x/Makefile
> > @@ -15,4 +15,3 @@ obj-$(CONFIG_FSP2)  +=3D fsp2.o
> >   obj-$(CONFIG_PCI)           +=3D pci.o
> >   obj-$(CONFIG_PPC4xx_HSTA_MSI)       +=3D hsta_msi.o
> >   obj-$(CONFIG_PPC4xx_CPM)    +=3D cpm.o
> > -obj-$(CONFIG_PPC4xx_GPIO)    +=3D gpio.o
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 020e51e30317..b87d2329900b 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -584,6 +584,13 @@ config GPIO_POLARFIRE_SOC
> >       help
> >         Say yes here to support the GPIO controllers on Microchip FPGAs=
.
> >
> > +config GPIO_PPC4XX
>
> I'd prefer CONFIG_GPIO_PPC44X
>
> That was added by 878e7556bfe7 ("powerpc/4xx: Add PowerPC 4xx GPIO
> driver") but since then 40x is gone with commit 47d13a269bbd
> ("powerpc/40x: Remove 40x platforms.") so only 44x remains as depicted
> by commit 7bf5f0562b62 ("powerpc: Replace CONFIG_4xx with CONFIG_44x")
Agreed.
>
> > +     tristate "PPC4xx GPIO support"
> > +     depends on 44x || (PPC && COMPILE_TEST)
> > +     select GPIO_GENERIC
> > +     help
> > +       Enable gpiolib support for ppc440 based boards.
> > +
> >   config GPIO_PXA
> >       bool "PXA GPIO support"
> >       depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
> > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > index b267598b517d..192242988ecb 100644
> > --- a/drivers/gpio/Makefile
> > +++ b/drivers/gpio/Makefile
> > @@ -145,6 +145,7 @@ obj-$(CONFIG_GPIO_PCIE_IDIO_24)           +=3D gpio=
-pcie-idio-24.o
> >   obj-$(CONFIG_GPIO_PCI_IDIO_16)              +=3D gpio-pci-idio-16.o
> >   obj-$(CONFIG_GPIO_PISOSR)           +=3D gpio-pisosr.o
> >   obj-$(CONFIG_GPIO_PL061)            +=3D gpio-pl061.o
> > +obj-$(CONFIG_GPIO_PPC4XX)            +=3D gpio-ppc4xx.o
> >   obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)    +=3D gpio-pmic-eic-sprd.o
> >   obj-$(CONFIG_GPIO_POLARFIRE_SOC)    +=3D gpio-mpfs.o
> >   obj-$(CONFIG_GPIO_PXA)                      +=3D gpio-pxa.o
> > diff --git a/arch/powerpc/platforms/44x/gpio.c b/drivers/gpio/gpio-ppc4=
xx.c
> > similarity index 100%
> > rename from arch/powerpc/platforms/44x/gpio.c
> > rename to drivers/gpio/gpio-ppc4xx.c
>

