Return-Path: <linuxppc-dev+bounces-21683-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF00CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 07:21:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRZXF1Bjvz2yQH;
	Fri, 29 May 2026 17:21:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780039261;
	cv=pass; b=F15lvAjdFCdW9fQIChnagl2P7WT/3qE3p9JkdWLCS3D4V0dSEmox/XAfp4J88HJunZxSXPMGRzAszGDrFyzUpAIjK6t4ymMX6qfmTsLw0gEJyzfRKgqFTiMDNye4ArUQOAW0mnz22U+QDqSfAf0a+QYyAkZh3GluFzro0SGnSrS4yPAi1QxQBNEI5yb+uv3Kan9qACdd3teWuBBsU1CbeXjyCH7W+b38c7eg4r6vkQngiGT2FbSzNbNU6XxSWoIXB8EZqIbkbYy4FulYGpP1b8tjm4sgdSePLr0uZPJtEwFZBHeX8uBsrA6wXbet9qWyUel8ycwk1FAtLLjcKIclZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780039261; c=relaxed/relaxed;
	bh=a5oOvflUrqsCekGczpulXOV0OnqiPpXa6jJFOATsImI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i68Jm/RpP7hHqHvAupsoTKrVs61jOoPW2+iGbZ/YG+hl/oa7Tj1fAh9AoYB1PBdaOxoifqeD/T0iwJqhKnSBC+8ZsbD9c8LQtaYCMDNjFDLoefPopROims8qlYLweiEaDM3OnWgJcyXle3WSC7uztA2GxlAcSehod8V3PvNplIICLq+tS2HB0ie/RRAMYKd5DZjIRkyRRlimtBfQnsdwrntaflenySIYATVjSGqQ5XIOFblXZ3NHjMyv047OQ5KS60+mYsdV43zRkJm65SWL73C9N6RpXbdYz6G4ANOe7OQImON5LtC3EdLFmBrwoiuCIN/5sEXMzTbZsZCVQUKK5w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HwtPX1Nq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HwtPX1Nq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRZXC5rBNz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 17:20:59 +1000 (AEST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6804e24803bso1195877a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 00:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780039256; cv=none;
        d=google.com; s=arc-20240605;
        b=kFGvmg3Nmr4iVINP9J2jFK+cP7hIwRi2B4nKzU4SDfQLP8tBAMeKZxKKg0CibLmah3
         T0Bx2L1IVMLOLZpA8Y8x/Jv5KTBECCD0EOOEMsM8Ta79JVIBoJ+yqQXOt7TSgHFpYTet
         1GHDKrQVEOuplQGotN2Wq7TsayMdBHameYY2MgX8GJmtVkAmSzl4X85pETqPMIxfsVJo
         t6BJftUQ+Z8dLJ4iU0Rb1b+QbUMgPcETfjdl8ZszrUBsSvfPlRAmYHkBnn2dLj8OGV3k
         ldM96nSDMbbKISVuvz27Pd3v+EKE8fVYONcmB3jAbRJdfdhv6oWERm5latghTIw96viJ
         njtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a5oOvflUrqsCekGczpulXOV0OnqiPpXa6jJFOATsImI=;
        fh=xnT7csdvd1lqvoDEdKtcgw2KBs/DSBxUa77eQV2a8Zw=;
        b=i3JK+A5+CWGHtZ33WgSFXHIUR9l+RjOoLqgFnjy4v3z8vtJNIX11BnkQA8UXuKoPKq
         eMiWqd+i5dN27Cz7BhEXSaAqDmvZUaUWDD9OsZuBDSu9pGrj+iylPVCvkdHO9iGaVNzT
         1ntG1srtqfI0j8OrTQbNlT8Uwc/RIiaxaVnWud4srdS4Ws3BlAzXUtl+joxhy7udeuuc
         G8xhdZEesnObb0/0nQGfQTZkSvhXH89oku7gui82XcB1QQ+rsLmD62y60X2LCWJJp5cE
         y0gl8t4ebLsl6GUCT8Pfv/VCbD6Sn2WGN8za3M1vYjcUVem3YTahwHj3yfzLBnVpvkM8
         kVpw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780039256; x=1780644056; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5oOvflUrqsCekGczpulXOV0OnqiPpXa6jJFOATsImI=;
        b=HwtPX1Nqjk+3H7HK4OzCANgRt61C2sKtU4HLH2cfqii9Gc/G46YwxqZ9ODzaSkGFFq
         YxRSVA2WfiMdOi82uADaOF8JJnA68VND+KW8i5DF7EWKyDBJQGGBCx6xOKv0eaPB/OYv
         mOkNSnQpyqW1o/v7rmXtW4RJfGyfRxFYBvhAugN4EFdzQU1Emxt9wKp80ds1KLE/Epof
         o0uQp9wl+5aOhZurDPF+YneseXxQXXFFCR8WstPvqpOfV4t0HKtWDHEIRhQcrX9bnLNi
         TlrbgQ5p8/BAZKMKnSdnhjtiDnwnzI3At36cr5fmmkOIZnk8wPngFI0nFhaG/ZME6LtH
         ZW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780039256; x=1780644056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5oOvflUrqsCekGczpulXOV0OnqiPpXa6jJFOATsImI=;
        b=E4Hnvl0E50Q2jO6aauJgGcCLzNNns7QlEwdbyu+AJX3iK9SCCdT/pAAaR+YxSOplL9
         mgxUNoi/2LfqofXrMXQ+8wTLUfgEqLY7AX6emLrGSeezuwXF1FO5VJexOBi4X9ODo1+P
         XI5GcWYJyAP9FdqDc2HRT+P9i/R+Mrr5p0Gn/cQORQ5KvYihhD8OxJIdq256rxFGhRZI
         Y+q5/+TsRrDcEUMJISSS5BDm+b60Q2DC+Dc1OOAdgotEd51xSmJbSdeB8cL2OmLNK95z
         iawPGgn2jS8KEw+59NUXC1nNFg+UV1CM0Dm2MqYwpU6h5gTo0/Q65G0RjnGYUbJMKde5
         h2wg==
X-Gm-Message-State: AOJu0YxNGnZ/tfGn8WBDnKsgKXy4evek4Qyms9nfTKiZM9V5K2tVdQm1
	n+rawXWGOgUJ2SG/qadDHCHDGZ7Gj/wTQEyz4+bxIFARV82uaSS/Rm6W/wQbDuqWs09wKikfYZi
	M2zuXcJ1pU7q7lrVxzeOy5zx4NUnB0SKQytgD
X-Gm-Gg: Acq92OFEj9ya7JpvgEQVgO/hY0TcHtLY4Hc+/ncNVwiWfYLjuQ5RLguS93FQWpy932t
	6p2hxnNWkbprm2xvLK3j2XS4zVRsdJGSb6Pa6Yy+ncNEmEUMKPbX14kiICFxX9ttWkxTfQWSai2
	H/BLQeVoCpFzAl7Nkq1ehbPaVSTbow0TPpxYgyVEX4MNcYzugwWzvYFlxSQ26sERimxO3CnIdr6
	qSwkew8dOxEpwcXfClzKZRQ/uyGk4eVZauqHmxWnHaSi0yuDkqyIuVE8vqgcCd/G7qLJYhDF4Xx
	hcIK2pYsO8FnD0EpeP8C+oAK/jxrdoHBovRtXyTq+dFiTVkXn3+IkXcKTWCSYWz3bx/M1CbOCiS
	lEvf2Kw9qsnNGtX5y3dsd+0NP5ZxhrXHpL28CDT9/c1ffF+1s+hSbsVlkNjRzBd+1NQz0
X-Received: by 2002:a05:6402:3604:b0:689:6c2e:6cdf with SMTP id
 4fb4d7f45d1cf-68c1067b1e8mr760728a12.22.1780039256138; Fri, 29 May 2026
 00:20:56 -0700 (PDT)
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
References: <20260529071408.38689-1-rosenp@gmail.com>
In-Reply-To: <20260529071408.38689-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 29 May 2026 00:20:44 -0700
X-Gm-Features: AVHnY4KzNu-hw5nUV0SMX9tCHcBcl5o2JZdOxpALN300KtJOh5-GPDqsUaGk7xQ
Message-ID: <CAKxU2N_CFUaF9kgpg8dWVcVMD8pv-EcGBFRgNswiu0TxDoR3eA@mail.gmail.com>
Subject: Re: [PATCH] gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:14=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Move the ppc4xx gpio driver out of arch/powerpc/platforms/44x/ into
> drivers/gpio/gpio-ppc44x.c. The driver follows the same pattern as
> other PowerPC GPIO drivers already in drivers/gpio/ (e.g.
> gpio-mpc8xxx, gpio-mpc5200).
>
> - Replace PPC-specific clrbits32()/setbits32() with local helpers
>   using ioread32be()/iowrite32be() so the driver can be built on
>   any architecture with COMPILE_TEST
> - Renamed Kconfig symbol from PPC4xx_GPIO to GPIO_PPC44X (40x was
>   removed in 47d13a269bbd, only 44x remains)
> - Rename symbols in the driver with 44x instead of 4xx to reflect the
>   absense of 40x.
> - Changed dependency to depends on 44x || COMPILE_TEST
> - Updated ppc44x_defconfig and warp_defconfig to use the new symbol
> - Marked the new option as tristate (was bool) since the driver
>   supports module build via module_platform_driver()
>
> Assisted-by: OpenCode:BigPickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: COMPILE_TEST everywhere
This was not it either. I forgot I had a bunch of local modifications
that would conflict. Back to the drawing board...
>  arch/powerpc/configs/44x/warp_defconfig       |  2 +-
>  arch/powerpc/configs/ppc44x_defconfig         |  2 +-
>  arch/powerpc/platforms/44x/Kconfig            |  8 --
>  arch/powerpc/platforms/44x/Makefile           |  1 -
>  drivers/gpio/Kconfig                          |  7 ++
>  drivers/gpio/Makefile                         |  1 +
>  .../44x/gpio.c =3D> drivers/gpio/gpio-ppc44x.c  | 88 +++++++++++--------
>  7 files changed, 62 insertions(+), 47 deletions(-)
>  rename arch/powerpc/platforms/44x/gpio.c =3D> drivers/gpio/gpio-ppc44x.c=
 (61%)
>
> diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/confi=
gs/44x/warp_defconfig
> index 5757625469c4..d6014b9c5708 100644
> --- a/arch/powerpc/configs/44x/warp_defconfig
> +++ b/arch/powerpc/configs/44x/warp_defconfig
> @@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=3Dy
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_EBONY is not set
>  CONFIG_WARP=3Dy
> -CONFIG_PPC4xx_GPIO=3Dy
> +CONFIG_GPIO_PPC44X=3Dy
>  CONFIG_HZ_1000=3Dy
>  CONFIG_CMDLINE=3D"ip=3Don"
>  # CONFIG_PCI is not set
> diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs=
/ppc44x_defconfig
> index 41c930f74ed4..b0c7ad8c6d9b 100644
> --- a/arch/powerpc/configs/ppc44x_defconfig
> +++ b/arch/powerpc/configs/ppc44x_defconfig
> @@ -22,7 +22,7 @@ CONFIG_GLACIER=3Dy
>  CONFIG_REDWOOD=3Dy
>  CONFIG_EIGER=3Dy
>  CONFIG_YOSEMITE=3Dy
> -CONFIG_PPC4xx_GPIO=3Dy
> +CONFIG_GPIO_PPC44X=3Dy
>  CONFIG_MATH_EMULATION=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/=
44x/Kconfig
> index d9717bf04a3f..150813cea945 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -227,14 +227,6 @@ config PPC44x_SIMPLE
>         help
>           This option enables the simple PowerPC 44x platform support.
>
> -config PPC4xx_GPIO
> -       bool "PPC4xx GPIO support"
> -       depends on 44x
> -       select GPIO_GENERIC
> -       select GPIOLIB
> -       help
> -         Enable gpiolib support for ppc440 based boards
> -
>  # 44x specific CPU modules, selected based on the board above.
>  config 440EP
>         bool
> diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms=
/44x/Makefile
> index ca7b1bb442d9..179468a00f5e 100644
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -15,4 +15,3 @@ obj-$(CONFIG_FSP2)    +=3D fsp2.o
>  obj-$(CONFIG_PCI)              +=3D pci.o
>  obj-$(CONFIG_PPC4xx_HSTA_MSI)  +=3D hsta_msi.o
>  obj-$(CONFIG_PPC4xx_CPM)       +=3D cpm.o
> -obj-$(CONFIG_PPC4xx_GPIO)      +=3D gpio.o
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 89c77ec6c205..7374f82b7040 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -593,6 +593,13 @@ config GPIO_POLARFIRE_SOC
>         help
>           Say yes here to support the GPIO controllers on Microchip FPGAs=
.
>
> +config GPIO_PPC44X
> +       tristate "PPC44x GPIO support"
> +       depends on 44x || COMPILE_TEST
> +       select GPIO_GENERIC
> +       help
> +         Enable gpiolib support for ppc440 based boards.
> +
>  config GPIO_PXA
>         bool "PXA GPIO support"
>         depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 8ec03c9aec20..9e8c9ca1d3fb 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -146,6 +146,7 @@ obj-$(CONFIG_GPIO_PCIE_IDIO_24)             +=3D gpio=
-pcie-idio-24.o
>  obj-$(CONFIG_GPIO_PCI_IDIO_16)         +=3D gpio-pci-idio-16.o
>  obj-$(CONFIG_GPIO_PISOSR)              +=3D gpio-pisosr.o
>  obj-$(CONFIG_GPIO_PL061)               +=3D gpio-pl061.o
> +obj-$(CONFIG_GPIO_PPC44X)              +=3D gpio-ppc44x.o
>  obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)       +=3D gpio-pmic-eic-sprd.o
>  obj-$(CONFIG_GPIO_POLARFIRE_SOC)       +=3D gpio-mpfs.o
>  obj-$(CONFIG_GPIO_PXA)                 +=3D gpio-pxa.o
> diff --git a/arch/powerpc/platforms/44x/gpio.c b/drivers/gpio/gpio-ppc44x=
.c
> similarity index 61%
> rename from arch/powerpc/platforms/44x/gpio.c
> rename to drivers/gpio/gpio-ppc44x.c
> index 6b4814ed12b5..cc7796e0cfbd 100644
> --- a/arch/powerpc/platforms/44x/gpio.c
> +++ b/drivers/gpio/gpio-ppc44x.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * PPC4xx gpio driver
> + * PPC44x gpio driver
>   *
>   * Copyright (c) 2008 Harris Corporation
>   * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
> @@ -22,7 +22,7 @@
>  #define GPIO_MASK2(gpio)       (0xc0000000 >> ((gpio) * 2))
>
>  /* Physical GPIO register layout */
> -struct ppc4xx_gpio {
> +struct ppc44x_gpio {
>         __be32 or;
>         __be32 tcr;
>         __be32 osrl;
> @@ -43,11 +43,27 @@ struct ppc4xx_gpio {
>         __be32 isr3h;
>  };
>
> -struct ppc4xx_gpio_chip {
> +struct ppc44x_gpio_chip {
>         struct gpio_generic_chip chip;
>         void __iomem *regs;
>  };
>
> +static inline void ppc44x_clrbits32(void __iomem *addr, u32 mask)
> +{
> +       u32 val =3D ioread32be(addr);
> +
> +       val &=3D ~mask;
> +       iowrite32be(val, addr);
> +}
> +
> +static inline void ppc44x_setbits32(void __iomem *addr, u32 mask)
> +{
> +       u32 val =3D ioread32be(addr);
> +
> +       val |=3D mask;
> +       iowrite32be(val, addr);
> +}
> +
>  /*
>   * GPIO LIB API implementation for GPIOs
>   *
> @@ -55,9 +71,9 @@ struct ppc4xx_gpio_chip {
>   */
>
>  static inline void
> -__ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +__ppc44x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
>  {
> -       struct ppc4xx_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       struct ppc44x_gpio_chip *chip =3D gpiochip_get_data(gc);
>         struct gpio_generic_chip *gen_gc =3D &chip->chip;
>
>         if (val)
> @@ -68,29 +84,29 @@ __ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int =
gpio, int val)
>         gpio_generic_write_reg(gen_gc, gen_gc->reg_set, gen_gc->sdata);
>  }
>
> -static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +static int ppc44x_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
>  {
> -       struct ppc4xx_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       struct ppc44x_gpio_chip *chip =3D gpiochip_get_data(gc);
>         struct gpio_generic_chip *gen_gc =3D &chip->chip;
> -       struct ppc4xx_gpio __iomem *regs =3D chip->regs;
> +       struct ppc44x_gpio __iomem *regs =3D chip->regs;
>         unsigned long flags;
>
>         gpio_generic_chip_lock_irqsave(gen_gc, flags);
>
>         /* Disable open-drain function */
> -       clrbits32(&regs->odr, GPIO_MASK(gpio));
> +       ppc44x_clrbits32(&regs->odr, GPIO_MASK(gpio));
>
>         /* Float the pin */
> -       clrbits32(&regs->tcr, GPIO_MASK(gpio));
> +       ppc44x_clrbits32(&regs->tcr, GPIO_MASK(gpio));
>         gen_gc->sdir &=3D ~GPIO_MASK(gpio);
>
>         /* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
>         if (gpio < 16) {
> -               clrbits32(&regs->osrl, GPIO_MASK2(gpio));
> -               clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
> +               ppc44x_clrbits32(&regs->osrl, GPIO_MASK2(gpio));
> +               ppc44x_clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
>         } else {
> -               clrbits32(&regs->osrh, GPIO_MASK2(gpio));
> -               clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
> +               ppc44x_clrbits32(&regs->osrh, GPIO_MASK2(gpio));
> +               ppc44x_clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
>         }
>
>         gpio_generic_chip_unlock_irqrestore(gen_gc, flags);
> @@ -99,32 +115,32 @@ static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, =
unsigned int gpio)
>  }
>
>  static int
> -ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +ppc44x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  {
> -       struct ppc4xx_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       struct ppc44x_gpio_chip *chip =3D gpiochip_get_data(gc);
>         struct gpio_generic_chip *gen_gc =3D &chip->chip;
> -       struct ppc4xx_gpio __iomem *regs =3D chip->regs;
> +       struct ppc44x_gpio __iomem *regs =3D chip->regs;
>         unsigned long flags;
>
>         gpio_generic_chip_lock_irqsave(gen_gc, flags);
>
>         /* First set initial value */
> -       __ppc4xx_gpio_set(gc, gpio, val);
> +       __ppc44x_gpio_set(gc, gpio, val);
>
>         /* Disable open-drain function */
> -       clrbits32(&regs->odr, GPIO_MASK(gpio));
> +       ppc44x_clrbits32(&regs->odr, GPIO_MASK(gpio));
>
>         /* Drive the pin */
> -       setbits32(&regs->tcr, GPIO_MASK(gpio));
> +       ppc44x_setbits32(&regs->tcr, GPIO_MASK(gpio));
>         gen_gc->sdir |=3D GPIO_MASK(gpio);
>
>         /* Bits 0-15 use TSRL, bits 16-31 use TSRH */
>         if (gpio < 16) {
> -               clrbits32(&regs->osrl, GPIO_MASK2(gpio));
> -               clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
> +               ppc44x_clrbits32(&regs->osrl, GPIO_MASK2(gpio));
> +               ppc44x_clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
>         } else {
> -               clrbits32(&regs->osrh, GPIO_MASK2(gpio));
> -               clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
> +               ppc44x_clrbits32(&regs->osrh, GPIO_MASK2(gpio));
> +               ppc44x_clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
>         }
>
>         gpio_generic_chip_unlock_irqrestore(gen_gc, flags);
> @@ -134,14 +150,14 @@ ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned =
int gpio, int val)
>         return 0;
>  }
>
> -static int ppc4xx_gpio_probe(struct platform_device *ofdev)
> +static int ppc44x_gpio_probe(struct platform_device *ofdev)
>  {
>         struct device *dev =3D &ofdev->dev;
>         struct device_node *np =3D dev->of_node;
> -       struct ppc4xx_gpio_chip *chip;
> +       struct ppc44x_gpio_chip *chip;
>         struct gpio_generic_chip_config config;
>         struct gpio_chip *gc;
> -       struct ppc4xx_gpio __iomem *regs;
> +       struct ppc44x_gpio __iomem *regs;
>         int ret;
>
>         chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> @@ -169,8 +185,8 @@ static int ppc4xx_gpio_probe(struct platform_device *=
ofdev)
>
>         gc =3D &chip->chip.gc;
>         gc->fwnode =3D dev_fwnode(dev);
> -       gc->direction_input =3D ppc4xx_gpio_dir_in;
> -       gc->direction_output =3D ppc4xx_gpio_dir_out;
> +       gc->direction_input =3D ppc44x_gpio_dir_in;
> +       gc->direction_output =3D ppc44x_gpio_dir_out;
>
>         gc->label =3D devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
>         if (!gc->label)
> @@ -179,20 +195,20 @@ static int ppc4xx_gpio_probe(struct platform_device=
 *ofdev)
>         return devm_gpiochip_add_data(dev, gc, chip);
>  }
>
> -static const struct of_device_id ppc4xx_gpio_match[] =3D {
> +static const struct of_device_id ppc44x_gpio_match[] =3D {
>         {
>                 .compatible =3D "ibm,ppc4xx-gpio",
>         },
>         {},
>  };
> -MODULE_DEVICE_TABLE(of, ppc4xx_gpio_match);
> +MODULE_DEVICE_TABLE(of, ppc44x_gpio_match);
>
> -static struct platform_driver ppc4xx_gpio_driver =3D {
> -       .probe          =3D ppc4xx_gpio_probe,
> +static struct platform_driver ppc44x_gpio_driver =3D {
> +       .probe          =3D ppc44x_gpio_probe,
>         .driver         =3D {
> -               .name   =3D "ppc4xx-gpio",
> -               .of_match_table =3D ppc4xx_gpio_match,
> +               .name   =3D "ppc44x-gpio",
> +               .of_match_table =3D ppc44x_gpio_match,
>         },
>  };
>
> -module_platform_driver(ppc4xx_gpio_driver);
> +module_platform_driver(ppc44x_gpio_driver);
> --
> 2.54.0
>

