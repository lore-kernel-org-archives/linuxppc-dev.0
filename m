Return-Path: <afleming@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTGSB2T4mzDrp5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 05:12:10 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id w78so10911989oie.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 12:12:10 -0700 (PDT)
From: Andy Fleming <afleming@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
Cc: aperez@alexperez.com
Subject: [PATCH 3/3] Cyrus: create a defconfig
Date: Tue,  6 Sep 2016 14:11:59 -0500
Message-Id: <1473189119-29458-4-git-send-email-afleming@gmail.com>
In-Reply-To: <1473189119-29458-1-git-send-email-afleming@gmail.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This sets up the proper config elements for Power and Reset to work
properly (using the gpio pins).

Signed-off-by: Andy Fleming <afleming@gmail.com>
---
 arch/powerpc/Makefile                      | 5 +++++
 arch/powerpc/configs/cyrus_basic_defconfig | 9 +++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/powerpc/configs/cyrus_basic_defconfig

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1934707..83f257e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -332,6 +332,11 @@ corenet64_smp_defconfig:
 	$(call merge_into_defconfig,corenet_basic_defconfig,\
 		85xx-64bit 85xx-smp altivec 85xx-hw fsl-emb-nonhw)
 
+PHONY += cyrus_defconfig
+cyrus_defconfig:
+	$(call merge_into_defconfig,cyrus_basic_defconfig,\
+		85xx-64bit 85xx-smp altivec 85xx-hw fsl-emb-nonhw)
+
 PHONY += mpc86xx_defconfig
 mpc86xx_defconfig:
 	$(call merge_into_defconfig,mpc86xx_basic_defconfig,\
diff --git a/arch/powerpc/configs/cyrus_basic_defconfig b/arch/powerpc/configs/cyrus_basic_defconfig
new file mode 100644
index 0000000..975150c
--- /dev/null
+++ b/arch/powerpc/configs/cyrus_basic_defconfig
@@ -0,0 +1,9 @@
+CONFIG_CORENET_GENERIC=y
+CONFIG_USERLIB=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_GPIO=y
+CONFIG_POWER_RESET_GPIO_RESTART=y
+CONFIG_RESET_CONTROLLER=y
+CONFIG_EXT3_FS=y
-- 
1.9.1
