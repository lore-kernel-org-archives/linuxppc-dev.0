Return-Path: <linuxppc-dev+bounces-21611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFDBCD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 02:56:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQrjX3Pwvz2y1W;
	Thu, 28 May 2026 12:56:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779936992;
	cv=none; b=Bo7M/lknd1MBsg0d/AL6Aa3vWI1L9vIYaRkcnHa3xAp/F0+HvZy4M5dsSc/F7TPFd0OC6uQbc+pCAo00vT3fIMqQ0RLTXLl9zetdGhtOb5QjwGFQBtWZ73x1SwAYZKtorSZPZulaR2iGz1pX97tasIP9g8c8wH1CNXOnLnDrUi5c84HSrfzRpxRZdWV0Nf4E2/VpT720fYoFw2/UXt8fh2+UFjqtEWMENhfiYNLfTcHXxbk1sRFsaKLZ8wA0+c9MfazdrxPyryhw7PdO/IBdZPzI67jQn23MjmQXaF9Pe7s/qw/lRNqfTzmNAUeuEnBtvgsMyBOHdm3ROcIVzO/IZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779936992; c=relaxed/relaxed;
	bh=++y4V+PCFusmclNoA0SYoxyTSV13piJXd/yLDVj40Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+frgjFVD5SfsWzlCIdg4IWrC/F04t3jEoagval3DBtXCcvO0+O0dXgcgV2UQsDVxvm7jUCuuKVx06ErhWc4+Odg3Q+Q9UvQ6ZpxJ97nZsYY9amVnzhwk+x33LdAQDw9fSwkU9d2C5EuLwr8o72j/b7GkeTGcuOKuDYGLPT7toUgkcyUbSvUmBRL6kw0bLYlszMYtE5iK10mBmoA9xtyjo6c4tcege6RplYesLduy6VcDppq6c2qUbekXs7nf3usvlyc8uy9B1icHiXcOv67DTepUyMeBemn7SnjlgZl/iM/4MBEUOZh1gZ4M18nzPpwiGENs8E+gpPKEEY3eD/5RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pMdJ7GMS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pMdJ7GMS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQrjV3twRz2xbN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 12:56:30 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2befd7eeb46so4910085ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 19:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936988; x=1780541788; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++y4V+PCFusmclNoA0SYoxyTSV13piJXd/yLDVj40Rs=;
        b=pMdJ7GMSqO9lJXFHAJ4HY63MsCINYzUhTi4QhoDj13rc+fjpDSuwJIfiIoHMcJ/etF
         1Rv5hw8lhaEsGAZg7LnyX7htrevGrfroiKyWqM3YVoqHq0wuRtEDORpCKi9nNA8ifXaU
         9lvOjsD1is2ksABVxNfst8q1nFiCyLIYlHiTRt/R/7vjgzFkx980zb1za7JarEBB4fu+
         9O57+QewG6WPwFdmh8sg3AQ+JvWOIaY3AAEqXlOWbIhLzfM7M6rOO0e5hV7bYP1MotqT
         5M2duursBry1jw8k7ALoOZK+pGT0tKvFeMy7wK3Q9iUzghfTUbsSBLE4BVtRwzIrfuqZ
         Asug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936988; x=1780541788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++y4V+PCFusmclNoA0SYoxyTSV13piJXd/yLDVj40Rs=;
        b=rStIbKGWblGZvnndnJkh12aLXcm+7SyErOztvwg2qDlfBQyfBX6vibXZ0ZFOvVODlW
         nEQTFauaxbjD0RrSSRW3LTWBeIltQ2l/IaDcJW6XX1NYqBkL0e5fgum+NGGAid9KaPA5
         /WSAjVFxX3QAJcde/YVmZswOE4pFCHL4ZCTKUTTrUakqnFNnMF5O9ozH+4DaBWIL9jww
         DxsHhf8Dig92hzKB+9UtTZ5n0q5xn52RyaByC1Qxp5ARAs/nffdL/+2bGZ7cwYLyVN6h
         R+UjJYmUIjXWUMAAYgqjERx3T8DxOs1eBL2WGlwdW/PsbcJjsRPLDajS8RvsEsgXMbGU
         TeyQ==
X-Gm-Message-State: AOJu0YznTC6Dm8R6hJ6wIvuMWrW8lcLawmMQrUwdjOmhJFV9jnMcHmO3
	SsKf6JWpUxg8ANqkbEZC3uWNxBedIiJLMpGUtLcKfCNhnmL1LSWs23Y/jHVevsI0
X-Gm-Gg: Acq92OEHv5GMCGwM5nCv/C0E2bqDABDD8lSzfpsx1ZhRh7VvIm1+RoVzfC291KU4qcP
	Al+nBN4HKh2/QLn7MH3yWnTopq++Rx4vwoRHdD3YuNW2HZZBfKorELnBOA12X7jFN8moyEOpf3Q
	km08e3WWE40PFtAt1ovXEVwtBACliaQt8Zsnn43h8StuT/JkOsHXsdi6nbDu1ZRMf2ZfnfeYUje
	TkrXTuRUhX6B3K67Rxa9oNcHNg9fN2Ws3I6Xe4GLOUjlfTmbpYHkh/44bYwfsMFEeZ0bhw0OCoT
	0RNAHjhHWpjv2Pl+T1XCO3/bLbOcdku49VIKCNnsc40Nqv4Kw3lE88Qyc2CWU0yk1mimbCE//nH
	BDxJNO9usQcSwOzjpKhHDz+5UYUH2IXBKqe/f15yJj6+XRWc3WmsecZ6O26rLs2IO1XeHOdOtNb
	CsUPRqDYla7ufNXKZBhk0VoI16+F5fDqqKaRZenXu6dtbeMZ1d6x+duJ8S7MNkGtSh1BfXCsvMB
	DS1mkdt66mx3JefGdBbWvMD8lkLKNLdxTyndbTVHxvJGA==
X-Received: by 2002:a17:902:db0d:b0:2bc:ac76:c1cf with SMTP id d9443c01a7336-2beb0698547mr284042265ad.24.1779936987896;
        Wed, 27 May 2026 19:56:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:b235:9fff:fe2d:7319])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c49b2sm160080275ad.60.2026.05.27.19.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:56:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM)
Subject: [PATCH] gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
Date: Wed, 27 May 2026 19:56:10 -0700
Message-ID: <20260528025610.713514-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
drivers/gpio/gpio-ppc4xx.c. The driver has no architecture-specific
dependencies and follows the same pattern as other PowerPC GPIO
drivers already in drivers/gpio/ (e.g. gpio-mpc8xxx, gpio-mpc5200).

- Renamed Kconfig symbol from PPC4xx_GPIO to GPIO_PPC4XX
- Updated ppc44x_defconfig and warp_defconfig to use the new symbol
- Marked the new option as tristate (was bool) since the driver
  supports module build via module_platform_driver()
- Added COMPILE_TEST support. Needs PPC as clrbits32 is in use.

Assisted-by: OpenCode:BigPickle
Signed-off-by: mangix <mangix@disroot.org>
---
 arch/powerpc/configs/44x/warp_defconfig                    | 2 +-
 arch/powerpc/configs/ppc44x_defconfig                      | 2 +-
 arch/powerpc/platforms/44x/Kconfig                         | 7 -------
 arch/powerpc/platforms/44x/Makefile                        | 1 -
 drivers/gpio/Kconfig                                       | 7 +++++++
 drivers/gpio/Makefile                                      | 1 +
 .../platforms/44x/gpio.c => drivers/gpio/gpio-ppc4xx.c     | 0
 7 files changed, 10 insertions(+), 10 deletions(-)
 rename arch/powerpc/platforms/44x/gpio.c => drivers/gpio/gpio-ppc4xx.c (100%)

diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 5757625469c4..380fa15af68d 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_EBONY is not set
 CONFIG_WARP=y
-CONFIG_PPC4xx_GPIO=y
+CONFIG_GPIO_PPC4XX=y
 CONFIG_HZ_1000=y
 CONFIG_CMDLINE="ip=on"
 # CONFIG_PCI is not set
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 41c930f74ed4..57a7342232d7 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -22,7 +22,7 @@ CONFIG_GLACIER=y
 CONFIG_REDWOOD=y
 CONFIG_EIGER=y
 CONFIG_YOSEMITE=y
-CONFIG_PPC4xx_GPIO=y
+CONFIG_GPIO_PPC4XX=y
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
index ca7b1bb442d9..179468a00f5e 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -15,4 +15,3 @@ obj-$(CONFIG_FSP2)	+= fsp2.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= hsta_msi.o
 obj-$(CONFIG_PPC4xx_CPM)	+= cpm.o
-obj-$(CONFIG_PPC4xx_GPIO)	+= gpio.o
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 020e51e30317..b87d2329900b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -584,6 +584,13 @@ config GPIO_POLARFIRE_SOC
 	help
 	  Say yes here to support the GPIO controllers on Microchip FPGAs.
 
+config GPIO_PPC4XX
+	tristate "PPC4xx GPIO support"
+	depends on 44x || (PPC && COMPILE_TEST)
+	select GPIO_GENERIC
+	help
+	  Enable gpiolib support for ppc440 based boards.
+
 config GPIO_PXA
 	bool "PXA GPIO support"
 	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index b267598b517d..192242988ecb 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_GPIO_PCIE_IDIO_24)		+= gpio-pcie-idio-24.o
 obj-$(CONFIG_GPIO_PCI_IDIO_16)		+= gpio-pci-idio-16.o
 obj-$(CONFIG_GPIO_PISOSR)		+= gpio-pisosr.o
 obj-$(CONFIG_GPIO_PL061)		+= gpio-pl061.o
+obj-$(CONFIG_GPIO_PPC4XX)		+= gpio-ppc4xx.o
 obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+= gpio-pmic-eic-sprd.o
 obj-$(CONFIG_GPIO_POLARFIRE_SOC)	+= gpio-mpfs.o
 obj-$(CONFIG_GPIO_PXA)			+= gpio-pxa.o
diff --git a/arch/powerpc/platforms/44x/gpio.c b/drivers/gpio/gpio-ppc4xx.c
similarity index 100%
rename from arch/powerpc/platforms/44x/gpio.c
rename to drivers/gpio/gpio-ppc4xx.c
-- 
2.54.0


