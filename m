Return-Path: <linuxppc-dev+bounces-21832-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0735DC5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:01:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTzFw6CBYz2yth;
	Tue, 02 Jun 2026 15:01:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780376516;
	cv=none; b=XqiYLdKmbEOCL49xz6M3pKTypbUwGS7rbGIVQfgaHfLkGSHWLVrsFgwLSdLaPuoCR6jeEWeKyJVybKK5/7URjhFYR2IpSmrnhP/dqHJjS7bzvCU/xuUgCbZzU86NKXSnakH42ngA82oOListZxW5mr8Mwy76FTdAAopv86D4NMNber8PXUhmH69hO4m9Xs8NCsTcdBqIKJHK5Ncxvm3qjA6TEnx3h86tu0ud0286FAd5aLyL6/o0H/e4oUn2/XSL8VGYntNxrV4VZ4KLXVzARXWvzKXEY1Op8FyKPFJopcMFVaURrbnPmvtm/sPwxR/Ly1xJ6h6HMRI2PsAdr9u5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780376516; c=relaxed/relaxed;
	bh=wGFxNfjzZNv84pjFOZFMUu5zdOh74zYkDbHbwTMiiog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1eEQlT0VdjaS//CKwW6MNdhvgCMI75cQkv92/xPbu7ubkGpLVEuaqjgWcjb4E3ijEPfp8b2m9LK31vdzxyOjRSppCYp3FVj4MW8SX3q4m4BBaRU9PrDFjI3R9ysMm0ygwiBeyDtLwJvrRXgle/lmNABx7q1NLzU12TWtnM7SyqoE7JrVSG0j5e4DZcpmEP0AnmTpZ1j6cw4dnjR7/K3q4dVOdGZEIry11++gxZXlOPM68n3gCBwfONxexzYYdCPsnllnQu3w7KKKKYbQjJyhLPXXXfzM/K1OiGn77KKquY1uJfnCLMwMHrmjV0mqhTl2SF0BHH7EkfII5cYySd3Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KlrXPT3E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KlrXPT3E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTzFv4lXWz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 15:01:55 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c8585cd8400so941564a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 22:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376513; x=1780981313; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGFxNfjzZNv84pjFOZFMUu5zdOh74zYkDbHbwTMiiog=;
        b=KlrXPT3Ehe/OM7MFisf6wCQQqdx2H4yXZVG4Hsdud3kGaVBMQnhMpQ4sO2VOnjE3WX
         +h5F9EPdPgdPXK14Dghhg351bkKYec70NEMWwVswM264QoyzkKnlTjnramjvII3Xh7a4
         ZvGuJdKVa4mjBQ+H6d1xnIDkYjdYcWZsI0xiWND/AMkEl8AGEKlxQV051+N2gmx79c5g
         kAzU0Nhwfz3k8qIJBdARQoPW84/RMSGP5R5ebKnmy/c2imf2mVOqeJOYJz8vGxTsxwpI
         2tkoQU89WhtCH7t5ryE76VKRAH2oFAkxqjypGMg80HtBd+eiE46P90OOc+SjtOZ3d4P4
         pI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376513; x=1780981313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGFxNfjzZNv84pjFOZFMUu5zdOh74zYkDbHbwTMiiog=;
        b=ZPiAZRjR49qjEsTrHSwjVOE/E58sGgqGZaherGGoUsMDUs1RGbv3XJu8YdOlVxJq2F
         Zz7dQ1ThqylTNRCzjro+wCQCbYC9cYA4cxtVG52F6P8viXM/Ygu23rc3PNS7W6qHpU0u
         2QtATGBkeYDmIGGo/5IZACpLuhno3RWr59rZSFYREx+d9zi5Ns5JXSEoVpPihrku4CPg
         dXm8Snco8EsiVrQY6bURHpAjfzsb0bLi0ofiLh3Z7zP3gW3DxyL+fWJQN0rO6Jm1jTvj
         ExT5PPYnym0qDx1m45DWJJSov+snlL498kKmBL7FeYIWuDNFOCG4rhxiFTXqnLwmLhpT
         T9Pw==
X-Forwarded-Encrypted: i=1; AFNElJ/fHd6j7UQAmgRMpDkuiqXqQxi0gk6fyp30FYRUisB/Zzysc0xCk6EcE+lrMynNbRB/RxMz+qlxDTQnJ0Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYlotHbPao3Mwrx0KNPaPcJuBvzTZgu36djISKLr/IK5qp5nt/
	GwbuifvGaR+9LIUL75SeGdg//NIVycHkwrDcVxOGkXAxBCcbZZLqkaMs
X-Gm-Gg: Acq92OHwu5F451ESjl1bYC4h/IcRASEbIY64bt0iLHf7Ob0vzzyvGIM/2a73d9PL4Jr
	Qovhv+ZDb7MsIuqM/+Rkjni60QOWqKZUMmIFS8nmUTj7oJz5BvISeF53nuUp2CJY1DAyHHkuSGq
	pnbAbSRvL4gP/VXqj9HQeGvfABCXyrx4ASTa3OwOXhKVBZBvcEfC8qWpe8OAy0DBXTIo0aDUkma
	0bYLf8eLVAN0jlaV+AqfWyoN08NKwJgzOniTUlTBxWcVHyaX5L3shDWPOszdSu3cpWokN9m9HBo
	z4NIBEeuKsuJOhhEgLaNkAZAVx9rRIolyLnzv4NQmQPm7ir0MnSOrrwGjzwxkk1AeTVypvIUDI4
	4g6ep+SPurf4adjq4NrzaJXqLbZEC4U0xDOqCwKV9csC4TgopF51RTQNqxdlIFFe+iWXo2kIGLY
	N20MAUytuECNbO6Bk/SCnBbwPTxhFLFOZd/jW7v/b5chPUiSCowVyTbnfZd4fdEMHeyKc2mK6A3
	Z3Jb7HcYDAAzaYOh46Gc/4qoL4T/HStSN0aiH4nYmoZ4g==
X-Received: by 2002:a05:6a20:da11:b0:3b2:9360:4598 with SMTP id adf61e73a8af0-3b427e62c76mr16236422637.7.1780376513384;
        Mon, 01 Jun 2026 22:01:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8589d055c7sm8958467a12.9.2026.06.01.22.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:01:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/7] gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
Date: Mon,  1 Jun 2026 22:01:25 -0700
Message-ID: <20260602050131.856789-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602050131.856789-1-rosenp@gmail.com>
References: <20260602050131.856789-1-rosenp@gmail.com>
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
 arch/powerpc/configs/44x/warp_defconfig                   | 2 +-
 arch/powerpc/configs/ppc44x_defconfig                     | 2 +-
 arch/powerpc/platforms/44x/Kconfig                        | 7 -------
 arch/powerpc/platforms/44x/Makefile                       | 2 +-
 drivers/gpio/Kconfig                                      | 8 ++++++++
 drivers/gpio/Makefile                                     | 1 +
 .../platforms/44x/gpio.c => drivers/gpio/gpio-ppc44x.c    | 0
 7 files changed, 12 insertions(+), 10 deletions(-)
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
index 41c930f74ed4..b0c7ad8c6d9b 100644
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
index 89c77ec6c205..77991da43ec1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -593,6 +593,14 @@ config GPIO_POLARFIRE_SOC
 	help
 	  Say yes here to support the GPIO controllers on Microchip FPGAs.
 
+config GPIO_PPC44X
+	tristate "PPC44x GPIO support"
+	depends on 44x
+	select GPIO_GENERIC
+	select GPIOLIB
+	help
+	  Enable gpiolib support for ppc440 based boards.
+
 config GPIO_PXA
 	bool "PXA GPIO support"
 	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 8ec03c9aec20..9e8c9ca1d3fb 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -146,6 +146,7 @@ obj-$(CONFIG_GPIO_PCIE_IDIO_24)		+= gpio-pcie-idio-24.o
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
2.54.0


