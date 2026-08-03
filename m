Return-Path: <linuxppc-dev+bounces-25297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E598EC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:35:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjH1rzSz2yFP;
	Tue, 04 Aug 2026 08:35:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796547;
	cv=none; b=mVrPBCT8HZ+A1iVwucKJhWwNbBymy4YDy/nf404bosL47PIR+DEtTGgQsD40nx0wY7whtPpmx4tUjQyLU3TMKoTD33NnK2mxg01/Vz2EG5BXg3tyQZszcE1wp2kCDKnZRYO03EfH5KdYVjA0GUPpUUdfVXk+Gfe3AAow9+AE3R5mrcZqm/Y9iFDHA1fXgdjwq1QO8EvZurVB9dK/JI+2bJKCppTLL+EcLQ3iEzPuAjoB+3WqODea5XKfn2664JvQSFjeiithHMMmjTpN8m1CXIwvyLkbqgw1YJ1jpZfDKLLJXqg6Cb3+6VqlcKSJV2KyExUQ5v0Kt7mrsySwat5Dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796547; c=relaxed/relaxed;
	bh=UNjLiku9OGDGFHcyr8i3iGPZu1wi19gAKG2Bs0IITD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLQ5lAbmRS34+rUpDi/OXs3CsNY+cBNxNMH4Nv1nfLfOWJAo9ojJjUqPphHpZUKuDNMihvbOY73/jP6DZqTtNuNiG+0d55MDTgUlG94VW2PLvKi+KO658Ca4jYOK45qPBs/5jeBsenY9wb5HFqXVLcgS/2HCre08yb7N5WhMWkumMZsREgPZ8OBl8H3bqh4d1DB/ONNuc2uG5YBpHgT1RsFNE4NJbTPDX3LQSrHKM0DkUdHsOmpIL/M6LFOqsXn3H1ZNuc3O8Mekr8uhqGQ6JnPGKygEP9Hk5mnceuzaMpa8KW8VhG9jorDDFdk9vEPJqP7F8ravUB9wHjP650GRHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CkY1Jofa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CkY1Jofa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjF605Hz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:45 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-848761b5897so2656842b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796543; x=1786401343; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNjLiku9OGDGFHcyr8i3iGPZu1wi19gAKG2Bs0IITD4=;
        b=CkY1JofaS/PxD0IX1e20QYkain9mRYl8BkBjmqkWm0BbcvZs1dxKpZ3/TVctl1LodS
         Y/e/lF2NpUOye/+TH0NyziefTWWxyP9R2A9KSzSzKi/78OQjmsX20Ybf2Qvdsbkw3MAu
         iOa+k8t4JcZ5A9shd13FEAYUgn9QUSY36UdD3zLVcHYTBUBbqB9TRp3ifZUnJolhdQ6f
         hy0wCMYYT8sfbsEaqfW2sMByYE8rMz1yy/+b/j9lhuAVJtZm1rBjloYKCnXGD+c/+HGO
         fziJ2rYBsowb4ORKoTMa1bJkzIEkyQce65WrUurzCpWpFGMJZTl2033eJTxICIpwlz9h
         ddaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796543; x=1786401343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNjLiku9OGDGFHcyr8i3iGPZu1wi19gAKG2Bs0IITD4=;
        b=J2RKtSr1Hi5uDEzqZJAYlMz0hyHYPwftUwR96r3fkSZwIazTcCwfkDccKeG3+vdR50
         gVUP/9MzsjZMhvtTFuXNdDbCDr+MVBPrAeJaDHQMH4V/gFPAoFpcLuLS2Qax8F+bnhVK
         yE8WQUJMAo9wjRB7/l8t8IeebjU9iB4w0c8jNixsIZ6orwj/8g1ITIjBwT7ECpv9cKRY
         KMDTErlolHqRSCGe9rAOGjtN/ki6jKFNMpzZiIxyZotN0zDUM0dApsm9tVT2XSc5qtfp
         bXay1swKfonw5+F/qHA+F0WHGSPMjhQqqHGXCJc1Bnt46VNJ5Er259hb+n0iJIk7ZErS
         Fjbw==
X-Forwarded-Encrypted: i=1; AHgh+RqX1ztLr5/mHsqPwOonehDoDksZ5Pt+eQ2GdjMa4pVv9uY0Jl/jGNNao71dZZ7CGu+VolM9OqdJa710/Rs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwcBwhTNxH+SFEnHsfQOFfanbTdvUBjAoBQ2OeZTChFLf+fi1Vp
	hBnHGAaqCghT/EIc3CfNx+Jn0cOUlV8kHtchhv+1raWbXaqM+C9SIWdf
X-Gm-Gg: AR+sD12/n1bt/dhP4tfqLbH7fglBZZUBxb4yq0gRtvJs8FEtA6NU11CUaWe+HFld1zF
	IO984F2pSUwUbSfKpb3gXQhGDSY7fsGjl0CCLFTmG7WL0oMGsHrxQcJ42fnWuUzwyBBQsCV2LTs
	/1JMJTl36dSP1LX2P1zgaN86s1rYZITBqrSqtmpd71MYhcBKW0b38BghqGzC6UlwcP6xEJ4k9PA
	LaLsfIsTcgnxu20tYd/TKkxDbcS7HX3DHCviearJuc/XqJ+39nGXqa7eyRcYvBTJ5bIgc4upNFZ
	lkqsKjVee/RXS+sr87HV2SHdZlxuVuQdanfUpQZhJDgITvkt2g2fZ1TWHCmdhL+xXgvUmiEK9j8
	La8r3RfdAHlFXbTO4+IiNy/sxwoKHiv5zlR1QbbyuC6YB6vHvOhuN6wT9bSD5qbmXrQ5VE5hrLL
	Vij5kYDftBSPsy7QN4JGBjg+Y3S5kPhQldsTGHSKuEv4s6piGPJi0qILsFdNigPZGDlGu+1rSHW
	aLnuclBaZzRzu2pK6KP3D+yPFb98VyDuCM/c6KBtAtwDTUv/Iyq0p1xaXhpE+JNeirD1JsdWaQq
	yiS29bWt4kUq1CnJHmnxNunc1+gHGMAYwFvoWw==
X-Received: by 2002:a05:6a00:148d:b0:848:4424:2b83 with SMTP id d2e1a72fcca58-84ee492211bmr10553771b3a.77.1785796543456;
        Mon, 03 Aug 2026 15:35:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/8] gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
Date: Mon,  3 Aug 2026 15:35:32 -0700
Message-ID: <20260803223539.86303-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803223539.86303-1-rosenp@gmail.com>
References: <20260803223539.86303-1-rosenp@gmail.com>
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
Content-Transfer-Encoding: 8bit

Move the ppc4xx gpio driver out of arch/powerpc/platforms/44x/ into
drivers/gpio/gpio-ppc44x.c. The driver has no architecture-specific
dependencies and follows the same pattern as other PowerPC GPIO
drivers already in drivers/gpio/ (e.g. gpio-mpc8xxx, gpio-mpc5200).

- Renamed Kconfig symbol from PPC4xx_GPIO to GPIO_PPC44X
- Updated ppc44x_defconfig and warp_defconfig to use the new symbol
- Marked the new option as tristate (was bool) since the driver
  supports module build via module_platform_driver()

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/configs/44x/warp_defconfig                    | 2 +-
 arch/powerpc/configs/ppc44x_defconfig                      | 2 +-
 arch/powerpc/platforms/44x/Kconfig                         | 7 -------
 arch/powerpc/platforms/44x/Makefile                        | 2 +-
 drivers/gpio/Kconfig                                       | 7 +++++++
 drivers/gpio/Makefile                                      | 1 +
 .../platforms/44x/gpio.c => drivers/gpio/gpio-ppc44x.c     | 0
 7 files changed, 11 insertions(+), 10 deletions(-)
 rename arch/powerpc/platforms/44x/gpio.c => drivers/gpio/gpio-ppc44x.c (100%)

diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 5757625469c4..d6014b9c5708 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_EBONY is not set
 CONFIG_WARP=y
-CONFIG_PPC4xx_GPIO=y
+CONFIG_GPIO_PPC44X=y
 CONFIG_HZ_1000=y
 CONFIG_CMDLINE="ip=on"
 # CONFIG_PCI is not set
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 0dc537f6aff3..d351551e266f 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -22,7 +22,7 @@ CONFIG_GLACIER=y
 CONFIG_REDWOOD=y
 CONFIG_EIGER=y
 CONFIG_YOSEMITE=y
-CONFIG_PPC4xx_GPIO=y
+CONFIG_GPIO_PPC44X=y
 CONFIG_MATH_EMULATION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index fc79f8466933..150813cea945 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -227,13 +227,6 @@ config PPC44x_SIMPLE
 	help
 	  This option enables the simple PowerPC 44x platform support.
 
-config PPC4xx_GPIO
-	bool "PPC4xx GPIO support"
-	depends on 44x
-	select GPIOLIB
-	help
-	  Enable gpiolib support for ppc440 based boards
-
 # 44x specific CPU modules, selected based on the board above.
 config 440EP
 	bool
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index ca7b1bb442d9..4598d8b89bf4 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_FSP2)	+= fsp2.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= hsta_msi.o
 obj-$(CONFIG_PPC4xx_CPM)	+= cpm.o
-obj-$(CONFIG_PPC4xx_GPIO)	+= gpio.o
+
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index af84285ed1bd..15fd5874f4ea 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -593,6 +593,13 @@ config GPIO_POLARFIRE_SOC
 	help
 	  Say yes here to support the GPIO controllers on Microchip FPGAs.
 
+config GPIO_PPC44X
+	tristate "PPC44x GPIO support"
+	depends on 44x
+	select GPIO_GENERIC
+	help
+	  Enable gpiolib support for ppc440 based boards.
+
 config GPIO_PXA
 	bool "PXA GPIO support"
 	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fa14581e3995..dc9e6d643b5b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -147,6 +147,7 @@ obj-$(CONFIG_GPIO_PCIE_IDIO_24)		+= gpio-pcie-idio-24.o
 obj-$(CONFIG_GPIO_PCI_IDIO_16)		+= gpio-pci-idio-16.o
 obj-$(CONFIG_GPIO_PISOSR)		+= gpio-pisosr.o
 obj-$(CONFIG_GPIO_PL061)		+= gpio-pl061.o
+obj-$(CONFIG_GPIO_PPC44X)		+= gpio-ppc44x.o
 obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+= gpio-pmic-eic-sprd.o
 obj-$(CONFIG_GPIO_POLARFIRE_SOC)	+= gpio-mpfs.o
 obj-$(CONFIG_GPIO_PXA)			+= gpio-pxa.o
diff --git a/arch/powerpc/platforms/44x/gpio.c b/drivers/gpio/gpio-ppc44x.c
similarity index 100%
rename from arch/powerpc/platforms/44x/gpio.c
rename to drivers/gpio/gpio-ppc44x.c
-- 
2.55.0


