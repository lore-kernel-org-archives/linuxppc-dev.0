Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE70C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 10:30:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CCC20817
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 10:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CCC20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xrwR0FVvzF3jq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 21:30:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xrnp5dqCzF3jS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 21:25:02 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42xrnh3kJGz9ty0B;
 Sat, 17 Nov 2018 11:24:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ljCNYiZ_bgXY; Sat, 17 Nov 2018 11:24:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42xrnh3BmMz9ty07;
 Sat, 17 Nov 2018 11:24:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 765268B78A;
 Sat, 17 Nov 2018 11:24:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Xn-bzSnWD-Va; Sat, 17 Nov 2018 11:24:59 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D33F8B74B;
 Sat, 17 Nov 2018 11:24:59 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id E114D69A6C; Sat, 17 Nov 2018 10:24:58 +0000 (UTC)
Message-Id: <803eeb2dd17b701fb1d4080f2ff6442f22e8829d.1542395798.git.christophe.leroy@c-s.fr>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/7] powerpc/kconfig: remove CONFIG_6xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 rjw@rjwysocki.net, viresh.kumar@linaro.org
Date: Sat, 17 Nov 2018 10:24:58 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

CONFIG_6xx is not used anymore. Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                       | 2 +-
 arch/powerpc/platforms/512x/Kconfig        | 2 +-
 arch/powerpc/platforms/52xx/Kconfig        | 2 +-
 arch/powerpc/platforms/82xx/Kconfig        | 4 ++--
 arch/powerpc/platforms/83xx/Kconfig        | 2 +-
 arch/powerpc/platforms/86xx/Kconfig        | 2 +-
 arch/powerpc/platforms/Kconfig             | 8 ++++----
 arch/powerpc/platforms/Kconfig.cputype     | 8 ++------
 arch/powerpc/platforms/amigaone/Kconfig    | 2 +-
 arch/powerpc/platforms/chrp/Kconfig        | 2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig | 2 +-
 11 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8be31261aec8..ac9703e8e722 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -556,7 +556,7 @@ config RELOCATABLE_TEST
 
 config CRASH_DUMP
 	bool "Build a dump capture kernel"
-	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
+	depends on PPC64 || PPC_BOOK3S_32 || FSL_BOOKE || (44x && !SMP)
 	select RELOCATABLE if PPC64 || 44x || FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a dump capture kernel.
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index b59eab6cbb1b..0c495823152c 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC_MPC512x
 	bool "512x-based boards"
-	depends on 6xx
+	depends on PPC_BOOK3S_32
 	select COMMON_CLK
 	select FSL_SOC
 	select IPIC
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 55a587070342..67f8c2d8fc0e 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC_MPC52xx
 	bool "52xx-based boards"
-	depends on 6xx
+	depends on PPC_BOOK3S_32
 	select COMMON_CLK
 	select PPC_PCI_CHOICE
 
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 1947a88bc69f..1af81de1c4e6 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig PPC_82xx
 	bool "82xx-based boards (PQ II)"
-	depends on 6xx
+	depends on PPC_BOOK3S_32
 
 if PPC_82xx
 
@@ -54,7 +54,7 @@ config PQ2ADS
 
 config 8260
 	bool
-	depends on 6xx
+	depends on PPC_BOOK3S_32
 	select CPM2
 	help
 	  The MPC8260 is a typical embedded CPU made by Freescale.  Selecting
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 071f53b0c0a0..ff0c69dfdf1a 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig PPC_83xx
 	bool "83xx-based boards"
-	depends on 6xx
+	depends on PPC_BOOK3S_32
 	select PPC_UDBG_16550
 	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index bcd179d3ed92..df692aa6b578 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -2,7 +2,7 @@
 config PPC_86xx
 menuconfig PPC_86xx
 	bool "86xx-based boards"
-	depends on 6xx
+	depends on PPC_BOOK3S_32
 	select FSL_SOC
 	select ALTIVEC
 	help
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 260a56b7602d..5c48dd823e15 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -40,7 +40,7 @@ config EPAPR_PARAVIRT
 
 config PPC_NATIVE
 	bool
-	depends on 6xx || PPC64
+	depends on PPC_BOOK3S_32 || PPC64
 	help
 	  Support for running natively on the hardware, i.e. without
 	  a hypervisor. This option is not user-selectable but should
@@ -48,7 +48,7 @@ config PPC_NATIVE
 
 config PPC_OF_BOOT_TRAMPOLINE
 	bool "Support booting from Open Firmware or yaboot"
-	depends on 6xx || PPC64
+	depends on PPC_BOOK3S_32 || PPC64
 	default y
 	help
 	  Support from booting from Open Firmware or yaboot using an
@@ -197,7 +197,7 @@ endmenu
 
 config PPC601_SYNC_FIX
 	bool "Workarounds for PPC601 bugs"
-	depends on 6xx && PPC_PMAC
+	depends on PPC_BOOK3S_32 && PPC_PMAC
 	help
 	  Some versions of the PPC601 (the first PowerPC chip) have bugs which
 	  mean that extra synchronization instructions are required near
@@ -211,7 +211,7 @@ config PPC601_SYNC_FIX
 
 config TAU
 	bool "On-chip CPU temperature sensor support"
-	depends on 6xx
+	depends on PPC_BOOK3S_32
 	help
 	  G3 and G4 processors have an on-chip temperature sensor called the
 	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f4e2c5729374..a106e78558c0 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -24,6 +24,7 @@ choice
 config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
+	select PPC_HAVE_PMU_SUPPORT
 
 config PPC_85xx
 	bool "Freescale 85xx"
@@ -179,11 +180,6 @@ config PPC_BOOK3E
 	def_bool y
 	depends on PPC_BOOK3E_64
 
-config 6xx
-	def_bool y
-	depends on PPC32 && PPC_BOOK3S
-	select PPC_HAVE_PMU_SUPPORT
-
 config E500
 	select FSL_EMB_PERFMON
 	select PPC_FSL_BOOK3E
@@ -266,7 +262,7 @@ config PHYS_64BIT
 
 config ALTIVEC
 	bool "AltiVec Support"
-	depends on 6xx || PPC_BOOK3S_64 || (PPC_E500MC && PPC64)
+	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64 || (PPC_E500MC && PPC64)
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
diff --git a/arch/powerpc/platforms/amigaone/Kconfig b/arch/powerpc/platforms/amigaone/Kconfig
index 03dc1e37c25b..e03d26d41957 100644
--- a/arch/powerpc/platforms/amigaone/Kconfig
+++ b/arch/powerpc/platforms/amigaone/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config AMIGAONE
 	bool "Eyetech AmigaOne/MAI Teron"
-	depends on 6xx && BROKEN_ON_SMP
+	depends on PPC_BOOK3S_32 && BROKEN_ON_SMP
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
 	select PPC_UDBG_16550
diff --git a/arch/powerpc/platforms/chrp/Kconfig b/arch/powerpc/platforms/chrp/Kconfig
index ead99eff875a..43a2484aad49 100644
--- a/arch/powerpc/platforms/chrp/Kconfig
+++ b/arch/powerpc/platforms/chrp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
-	depends on 6xx
+	depends on PPC_BOOK3S_32
 	select HAVE_PCSPKR_PLATFORM
 	select MPIC
 	select PPC_I8259
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 8ea16db5ff48..527d4aa46537 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based boards"
-	depends on 6xx && BROKEN_ON_SMP
+	depends on PPC_BOOK3S_32 && BROKEN_ON_SMP
 
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
-- 
2.13.3

