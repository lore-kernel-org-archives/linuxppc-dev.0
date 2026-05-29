Return-Path: <linuxppc-dev+bounces-21678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB7ACD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 06:50:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRYrd4Pq9z2yRl;
	Fri, 29 May 2026 16:50:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780037409;
	cv=none; b=IZpWIGGsa8B5DjOoHxgYYQvNvrzk7GOXEyeSeX2QoZMr/2P0rEri9/w4qSySqRGMcCBDdKxW4jpt3AK8AsCuZ3KUZhxitk1MUqQDuN78DP9jcdkph1kht2QqHnQD8RQIabs3SXZQaEdvkP5vslF1WmPQDTrhP8XNpTVtTmJFeWfaLS2s9ETJRuJktYEx+8DgYz9NYNiOQBH84MgU+dWONe9EjE20U2QeYXomk3dpLQlOedESnfdC6SY4Q2/gqdRGOe9+me4/g+LGTSEpwijTGXYIIhxOmvNwXnIjmcjL9Cnq4paqNu14q7KbDQgwfGgRPSqrQaOdTcAwZOYKHpG1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780037409; c=relaxed/relaxed;
	bh=r1VXBQolH9n4v7TjEVBXIv3XIfE+zzKBxA2kgFL60r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyj0gC68H2+aPr+t5cfIEHQz6YgcYgvej9oxdNF6qJnKmNwTsStnw0Da9++lvZnL1DWBfciZ7dLMm48rVAi177mKK5BFE+AnGvAqoYHAnFfuKokQs/0NUq+qChVNjbdcsJmy+VtQRoBDSUaglHzag3e8MakLH1eKFNYxQ4gXwMqtcC9HgIzhV5maZ+phuTJH9yDXcsahrh8ZPR/RvEBCVTChRxiH1LBvf4KVFg/J08nQLEP3vg/bTa3Pvu2isXAcSH0P83c/ucYFg8NPG8l/JbM+Sw9G+qGI7PGxVYzOnsny9AHiZu/TtseG6k9o3cuREmkygT34EAn7xCwYuIRxaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CutkgRmh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CutkgRmh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRYrc3RLzz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 16:50:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B87340227;
	Fri, 29 May 2026 06:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A2A1F00893;
	Fri, 29 May 2026 06:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780037404;
	bh=r1VXBQolH9n4v7TjEVBXIv3XIfE+zzKBxA2kgFL60r0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CutkgRmhdEYf4HQ/shwyeH9rVmWmCWHf/ctVELIqliWB4LPG7dcZLie8SVnOymyU9
	 yqcu4fX96GoTLLN65XUKKaENHT6VFg5vU2tLwg8rqxRUTX5lHJTuHyz+Q4XKnebDwn
	 MIki8O4aOSaVtAKIFbpcEL8MaCmevdaYvjUFFTPCilz0Ku1v5+ubqR3HYLiTOjHjfc
	 dJAargVvHU4V+UAJn0IxcDjamtJByKKFTWqA7zB13brwA6sSnJkL3O7Fzuf1vJxk9k
	 ae/pu0GXlNW8tvrtJMsdFTCfW9hjvfMAIog6qK4LpAqDUe8EiNjfBZsuDE4kBkH2Ar
	 BcnFnd/UxHQHw==
Message-ID: <cc236562-3967-4361-ad92-05582db82282@kernel.org>
Date: Fri, 29 May 2026 08:49:57 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: move ppc4xx gpio driver from arch/powerpc to
 drivers/gpio
To: Rosen Penev <rosenp@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20260528025610.713514-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260528025610.713514-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/05/2026 à 04:56, Rosen Penev a écrit :
> Move the ppc4xx gpio driver out of arch/powerpc/platforms/44x/ into
> drivers/gpio/gpio-ppc4xx.c. The driver has no architecture-specific
> dependencies and follows the same pattern as other PowerPC GPIO
> drivers already in drivers/gpio/ (e.g. gpio-mpc8xxx, gpio-mpc5200).
> 
> - Renamed Kconfig symbol from PPC4xx_GPIO to GPIO_PPC4XX
> - Updated ppc44x_defconfig and warp_defconfig to use the new symbol
> - Marked the new option as tristate (was bool) since the driver
>    supports module build via module_platform_driver()
> - Added COMPILE_TEST support. Needs PPC as clrbits32 is in use.

Not only clrbits32() but also setbits32() and in_be32().

On the long run we want to get rid of PPC specific IO helpers, at least 
outside arch/powerpc/ , so don't add new instances.

Remove that dependency by switching to ioread32be() which has been 
equivalent to in_be32() since commit 894fa235eb4c ("powerpc: inline 
iomap accessors"), then implement a local equivalent of 
clrbits32()/setbits32()

See for instance:
- qe_setbits_be32() in include/soc/fsl/qe/qe.h
- tsa_clrbits32() in drivers/soc/fsl/qe/tsa.c

> 
> Assisted-by: OpenCode:BigPickle
> Signed-off-by: mangix <mangix@disroot.org>

Who is that ?

> ---
>   arch/powerpc/configs/44x/warp_defconfig                    | 2 +-
>   arch/powerpc/configs/ppc44x_defconfig                      | 2 +-
>   arch/powerpc/platforms/44x/Kconfig                         | 7 -------
>   arch/powerpc/platforms/44x/Makefile                        | 1 -
>   drivers/gpio/Kconfig                                       | 7 +++++++
>   drivers/gpio/Makefile                                      | 1 +
>   .../platforms/44x/gpio.c => drivers/gpio/gpio-ppc4xx.c     | 0

Not gpio-ppc4xx.c but gpio-ppc44x.c

>   7 files changed, 10 insertions(+), 10 deletions(-)
>   rename arch/powerpc/platforms/44x/gpio.c => drivers/gpio/gpio-ppc4xx.c (100%)
> 
> diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
> index 5757625469c4..380fa15af68d 100644
> --- a/arch/powerpc/configs/44x/warp_defconfig
> +++ b/arch/powerpc/configs/44x/warp_defconfig
> @@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
>   # CONFIG_EBONY is not set
>   CONFIG_WARP=y
> -CONFIG_PPC4xx_GPIO=y
> +CONFIG_GPIO_PPC4XX=y
>   CONFIG_HZ_1000=y
>   CONFIG_CMDLINE="ip=on"
>   # CONFIG_PCI is not set
> diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
> index 41c930f74ed4..57a7342232d7 100644
> --- a/arch/powerpc/configs/ppc44x_defconfig
> +++ b/arch/powerpc/configs/ppc44x_defconfig
> @@ -22,7 +22,7 @@ CONFIG_GLACIER=y
>   CONFIG_REDWOOD=y
>   CONFIG_EIGER=y
>   CONFIG_YOSEMITE=y
> -CONFIG_PPC4xx_GPIO=y
> +CONFIG_GPIO_PPC4XX=y
>   CONFIG_MATH_EMULATION=y
>   CONFIG_NET=y
>   CONFIG_PACKET=y
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index fc79f8466933..150813cea945 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -227,13 +227,6 @@ config PPC44x_SIMPLE
>   	help
>   	  This option enables the simple PowerPC 44x platform support.
>   
> -config PPC4xx_GPIO
> -	bool "PPC4xx GPIO support"
> -	depends on 44x
> -	select GPIOLIB
> -	help
> -	  Enable gpiolib support for ppc440 based boards
> -
>   # 44x specific CPU modules, selected based on the board above.
>   config 440EP
>   	bool
> diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
> index ca7b1bb442d9..179468a00f5e 100644
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -15,4 +15,3 @@ obj-$(CONFIG_FSP2)	+= fsp2.o
>   obj-$(CONFIG_PCI)		+= pci.o
>   obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= hsta_msi.o
>   obj-$(CONFIG_PPC4xx_CPM)	+= cpm.o
> -obj-$(CONFIG_PPC4xx_GPIO)	+= gpio.o
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 020e51e30317..b87d2329900b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -584,6 +584,13 @@ config GPIO_POLARFIRE_SOC
>   	help
>   	  Say yes here to support the GPIO controllers on Microchip FPGAs.
>   
> +config GPIO_PPC4XX

I'd prefer CONFIG_GPIO_PPC44X

That was added by 878e7556bfe7 ("powerpc/4xx: Add PowerPC 4xx GPIO 
driver") but since then 40x is gone with commit 47d13a269bbd 
("powerpc/40x: Remove 40x platforms.") so only 44x remains as depicted 
by commit 7bf5f0562b62 ("powerpc: Replace CONFIG_4xx with CONFIG_44x")

> +	tristate "PPC4xx GPIO support"
> +	depends on 44x || (PPC && COMPILE_TEST)
> +	select GPIO_GENERIC
> +	help
> +	  Enable gpiolib support for ppc440 based boards.
> +
>   config GPIO_PXA
>   	bool "PXA GPIO support"
>   	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index b267598b517d..192242988ecb 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -145,6 +145,7 @@ obj-$(CONFIG_GPIO_PCIE_IDIO_24)		+= gpio-pcie-idio-24.o
>   obj-$(CONFIG_GPIO_PCI_IDIO_16)		+= gpio-pci-idio-16.o
>   obj-$(CONFIG_GPIO_PISOSR)		+= gpio-pisosr.o
>   obj-$(CONFIG_GPIO_PL061)		+= gpio-pl061.o
> +obj-$(CONFIG_GPIO_PPC4XX)		+= gpio-ppc4xx.o
>   obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+= gpio-pmic-eic-sprd.o
>   obj-$(CONFIG_GPIO_POLARFIRE_SOC)	+= gpio-mpfs.o
>   obj-$(CONFIG_GPIO_PXA)			+= gpio-pxa.o
> diff --git a/arch/powerpc/platforms/44x/gpio.c b/drivers/gpio/gpio-ppc4xx.c
> similarity index 100%
> rename from arch/powerpc/platforms/44x/gpio.c
> rename to drivers/gpio/gpio-ppc4xx.c


