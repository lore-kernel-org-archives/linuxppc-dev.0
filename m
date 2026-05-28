Return-Path: <linuxppc-dev+bounces-21612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758E7CD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 03:05:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQrw212JDz2xR4;
	Thu, 28 May 2026 13:05:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779937538;
	cv=pass; b=mihyH4HLal6ju4h/JAhkjQ2qYJrI6jsoqBOI4llD4O/nJuG+bpHhMyz0DRxKbd/uKqZVAsNDWh7Z8+l/IoyTmRU/Zr53vjraAHXqqxNDzeZqTitVP6D4Blg2HvgLLs9QoANeTXI6Qq08duT0kf50VNb5d1cLnNbf3mERW0C59ei3ecmsdOeHWYW02+uYDBxry60oY0w87Srr3XZAlJbqWUdmFWy334nzH0DBiloLmgYRonDJ7I+bH6IF3lpePfmlQlbjeZ+cVAniSbcXQfgakzCwOCzf6l5bBKlKSgk2APBrRphXK3uxy2cUIoRhngostRwurm1ztweLmaS4iZGxow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779937538; c=relaxed/relaxed;
	bh=cPHLoqDxPmB8d9qB6DtASLpOV7DkVrp8skXoe/juiQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUph5sb2AdHZN69l0h0lCa9V2Ir4rXzXf76JZE0ppGfHm8IxNuue7GYKhb3/9HTXZRAGiqR1bV1inogGlJOfY6b1Vby95ixekHsQRxofJ+VWNIS2kx4iYPVA/LXvvsZPrjfOJcLBW2OhLziIeywlj4EI1hIXkFctiQDIdETOcf3izsd3Gn/EzvUesE00vafbUWoTDrdM8DVHT2ZdBDJuD173HOuU4Sb3H5QQ1EWvkk4yC+4pO/c0xeRAzFz5t2WC9S+hMYCNGkDzamlykd/IlAjeM1/YcdoOt80EcJckOUKzAbePWoakJrU1w5+o7WDter0gT+5bRz6nqc4HGsN/HA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H7HyfDED; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H7HyfDED;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQrw06kbkz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 13:05:36 +1000 (AEST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-68af2ac47afso428768a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 20:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779937532; cv=none;
        d=google.com; s=arc-20240605;
        b=WKWdqNy9kaidotI215QgRgkeP7KErGd7KIJqmnliBq4YsPsQKbI3FH8qsWXmtcnlv8
         2CofwBFXQYJP+nuBoB8iC8Hb9MijvJQxzMdMVDViDXU2YkZyL5LpsdQspNHSJLRaGaVE
         juWf9OZ1ISNNISrHjHrWKab+51JaCO9RxnLQtLM8/3EWdSXR+ZVMD2MRUVCCZGwV0poT
         tA+CXVdJCEGvK83AZWk+QYTxLiz8xGfjj6oXIRJlAsm/mW4Op1V0Ftncdbg2F1K5cvRf
         m1XpPapWXoDjysQcL0731eE7EDmPEEu4BhtNaSNzbHaYbEh7A3kb7ttgRo4ODSA7qeYj
         Z57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cPHLoqDxPmB8d9qB6DtASLpOV7DkVrp8skXoe/juiQs=;
        fh=xnT7csdvd1lqvoDEdKtcgw2KBs/DSBxUa77eQV2a8Zw=;
        b=MOboy3Nuk+RDCEiKtvNzxTYas1hpHHLgvf0Zo3+VZTUmi/HOGyeMrPQANFIrCpZ4kp
         7InGV3A9TACtjWyPer5aIERkC6mWINY5Mlv+9jB2TnR8+RiT+6hinHTEXgwko5OKvtSm
         ojylmZddgVMqkOc7SGIHgfeV/M1QM/wx4NuTbNeHpN5wWAQJIsd73/l55VQ0UyPbYxyl
         rr+g0bQdd0kPupUiauSUEGaNZ0jCQ7DxThLjRSq7TNOkmjKlHbaOtTaiUFLVmu3rWsHX
         rU1bRJhrzl7XAkMuUCWH7VKDraIuCek/9Qtvib5qGFJfnDRfkQHR+xK8A+nPGAt5XCUa
         7QSA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779937532; x=1780542332; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPHLoqDxPmB8d9qB6DtASLpOV7DkVrp8skXoe/juiQs=;
        b=H7HyfDEDd5idpCGlqC1JVo/XD6j6tmGqijZzwrP7Ik+VhilO31QYvJfhO4PNm3QA/j
         6bPnggzmlR5eZ9X6FCaO5Ihhots7nJIhc9CS+uV0VWDhYirMy3OlGQucG76Xg/c3zzqR
         WsXoywKH6K+3nJxNcDHuYQi9f6yRwrgpu1mbIqSPMOo9g3nK46ymL/G81wWvBwQlLLHB
         kYdP/PeEAdrwuTnOWA2592sfmFgASdqbqtgEvyaR52KvZLqPN5gMes6qttLTzxEAqSjK
         u56hIkD/UrExLrEnNbFl5fq7wiOD8MvMYh38AYcrjArZKNwwC9DwOuCzV9ZSu7+cOC+o
         LTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779937532; x=1780542332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPHLoqDxPmB8d9qB6DtASLpOV7DkVrp8skXoe/juiQs=;
        b=fjfDhh9m1+hmfxboONXGDgc7Bu/XngGEIJGxZNUwIK1KexHJk6IAl747V9NBQ89Ups
         wqizIlKNPyb1WgqIScU7fIksFOpW4RgipnfGf82qLPiBOrSHAkWoUAwdwTTKVcf6BdkB
         WrJmlvty5rF/ji9zIPveHxmiZXH/7L+gtJHUcolBqBgS1ABa51sZkwaHO85wWZ6e9Cqk
         vdPxcKckC0Tfpjmbz4gEEDORPZqGp8dy2oGcUdGBFqfG7eFZbrIo0mZj6XpyQoE4Y/ia
         qkurl1UB9dDw4DuooBqBFfl1qoo7gbayBmUQEzAzunOWRDwhlPh895QN4Ax9YGwEZLf4
         tEKw==
X-Gm-Message-State: AOJu0YzpIuQkirrXrekbR6tKAbygBIS6hJOqf3J7RfWysUCdFB44N36K
	7cWhPcOS67HJGieKdkS+LqAWEs57iE+wZIvHLfc47LBpX73GDjPnxnxKNQwy+PqoBhZr+TQHgtw
	HdODWCtHvxOa0mtuqqkiBBZE4nhyiC5DOlNRy
X-Gm-Gg: Acq92OEydtx3B3p/3nSi/iAxsE4XjusOnf8mtDQlfPzWrfkhLGTLfaFBr3PLryLcV98
	7o/Jy06R8avMVAGiDzdb/bs7vovy22P3AkN/7ueqOKalHYzMlhqJW90LATLCmBen6ep9M+/95Fn
	upOpJICt2Tm5/Il3YKnJjcNbBQz5D7gIP8yOjLQkB+X/BlKC9XPjilFei0SaPS9Cq2m1MoNMZ0D
	3NP8umxL7fZxs9Knc+B92Ofq1f8yi2D6n6tmwm8kdE5MHqd6D3eSqZe+1wB2zbOZmtzcMsd3abG
	fPDFf9rPUETX4P/juZEy+oO4p+GmEJD8EOO40LNZLjB+L2gEfxZ3dV9Oo1MCjZZg0Kn2NevfRb4
	cN3RbQU50u5jCqkfpOboDAA8mkzaj66/JGRI8PmX70xrcjdn4mKO2qQWo8nFnkkgdRVgG
X-Received: by 2002:a05:6402:1f8d:b0:68b:117b:2155 with SMTP id
 4fb4d7f45d1cf-68b117b25f0mr307439a12.15.1779937531643; Wed, 27 May 2026
 20:05:31 -0700 (PDT)
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
References: <20260528025610.713514-1-rosenp@gmail.com>
In-Reply-To: <20260528025610.713514-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 27 May 2026 20:05:20 -0700
X-Gm-Features: AVHnY4ISyDQ2wTV2j_1EbZdqvCNnJ2nwvhsyfLrB93TNg5isZhi6AALrDPoCpm8
Message-ID: <CAKxU2N8uBpBNJgPP+J1=MgCTYb9tweoeqzYRTTtOmB=6Z9W6Yw@mail.gmail.com>
Subject: Re: [PATCH] gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 7:56=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Move the ppc4xx gpio driver out of arch/powerpc/platforms/44x/ into
> drivers/gpio/gpio-ppc4xx.c. The driver has no architecture-specific
> dependencies and follows the same pattern as other PowerPC GPIO
> drivers already in drivers/gpio/ (e.g. gpio-mpc8xxx, gpio-mpc5200).
>
> - Renamed Kconfig symbol from PPC4xx_GPIO to GPIO_PPC4XX
> - Updated ppc44x_defconfig and warp_defconfig to use the new symbol
> - Marked the new option as tristate (was bool) since the driver
>   supports module build via module_platform_driver()
> - Added COMPILE_TEST support. Needs PPC as clrbits32 is in use.
>
> Assisted-by: OpenCode:BigPickle
> Signed-off-by: mangix <mangix@disroot.org>
Sigh forgot to check this. Was too focused on testing this.
> ---
>  arch/powerpc/configs/44x/warp_defconfig                    | 2 +-
>  arch/powerpc/configs/ppc44x_defconfig                      | 2 +-
>  arch/powerpc/platforms/44x/Kconfig                         | 7 -------
>  arch/powerpc/platforms/44x/Makefile                        | 1 -
>  drivers/gpio/Kconfig                                       | 7 +++++++
>  drivers/gpio/Makefile                                      | 1 +
>  .../platforms/44x/gpio.c =3D> drivers/gpio/gpio-ppc4xx.c     | 0
>  7 files changed, 10 insertions(+), 10 deletions(-)
>  rename arch/powerpc/platforms/44x/gpio.c =3D> drivers/gpio/gpio-ppc4xx.c=
 (100%)
>
> diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/confi=
gs/44x/warp_defconfig
> index 5757625469c4..380fa15af68d 100644
> --- a/arch/powerpc/configs/44x/warp_defconfig
> +++ b/arch/powerpc/configs/44x/warp_defconfig
> @@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=3Dy
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_EBONY is not set
>  CONFIG_WARP=3Dy
> -CONFIG_PPC4xx_GPIO=3Dy
> +CONFIG_GPIO_PPC4XX=3Dy
>  CONFIG_HZ_1000=3Dy
>  CONFIG_CMDLINE=3D"ip=3Don"
>  # CONFIG_PCI is not set
> diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs=
/ppc44x_defconfig
> index 41c930f74ed4..57a7342232d7 100644
> --- a/arch/powerpc/configs/ppc44x_defconfig
> +++ b/arch/powerpc/configs/ppc44x_defconfig
> @@ -22,7 +22,7 @@ CONFIG_GLACIER=3Dy
>  CONFIG_REDWOOD=3Dy
>  CONFIG_EIGER=3Dy
>  CONFIG_YOSEMITE=3Dy
> -CONFIG_PPC4xx_GPIO=3Dy
> +CONFIG_GPIO_PPC4XX=3Dy
>  CONFIG_MATH_EMULATION=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/=
44x/Kconfig
> index fc79f8466933..150813cea945 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -227,13 +227,6 @@ config PPC44x_SIMPLE
>         help
>           This option enables the simple PowerPC 44x platform support.
>
> -config PPC4xx_GPIO
> -       bool "PPC4xx GPIO support"
> -       depends on 44x
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
> index 020e51e30317..b87d2329900b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -584,6 +584,13 @@ config GPIO_POLARFIRE_SOC
>         help
>           Say yes here to support the GPIO controllers on Microchip FPGAs=
.
>
> +config GPIO_PPC4XX
> +       tristate "PPC4xx GPIO support"
> +       depends on 44x || (PPC && COMPILE_TEST)
> +       select GPIO_GENERIC
> +       help
> +         Enable gpiolib support for ppc440 based boards.
> +
>  config GPIO_PXA
>         bool "PXA GPIO support"
>         depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index b267598b517d..192242988ecb 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -145,6 +145,7 @@ obj-$(CONFIG_GPIO_PCIE_IDIO_24)             +=3D gpio=
-pcie-idio-24.o
>  obj-$(CONFIG_GPIO_PCI_IDIO_16)         +=3D gpio-pci-idio-16.o
>  obj-$(CONFIG_GPIO_PISOSR)              +=3D gpio-pisosr.o
>  obj-$(CONFIG_GPIO_PL061)               +=3D gpio-pl061.o
> +obj-$(CONFIG_GPIO_PPC4XX)              +=3D gpio-ppc4xx.o
>  obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)       +=3D gpio-pmic-eic-sprd.o
>  obj-$(CONFIG_GPIO_POLARFIRE_SOC)       +=3D gpio-mpfs.o
>  obj-$(CONFIG_GPIO_PXA)                 +=3D gpio-pxa.o
> diff --git a/arch/powerpc/platforms/44x/gpio.c b/drivers/gpio/gpio-ppc4xx=
.c
> similarity index 100%
> rename from arch/powerpc/platforms/44x/gpio.c
> rename to drivers/gpio/gpio-ppc4xx.c
> --
> 2.54.0
>

