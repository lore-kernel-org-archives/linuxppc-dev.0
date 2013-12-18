Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 673D12C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 06:08:03 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rapidio: add modular rapidio core build into powerpc and mips
 branches
Date: Wed, 18 Dec 2013 13:57:35 -0500
Message-Id: <1387393055-10114-1-git-send-email-alexandre.bounine@idt.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
 Alexandre Bounine <alexandre.bounine@idt.com>, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow modular build option for RapidIO subsystem core in MIPS and PowerPC
architectural branches.

At this moment modular RapidIO subsystem build is enabled only for platforms
that use PCI/PCIe based RapidIO controllers (e.g. Tsi721).

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig    |    2 +-
 arch/powerpc/Kconfig |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 650de39..e6a8a7a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2442,7 +2442,7 @@ source "drivers/pcmcia/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
 
 config RAPIDIO
-	bool "RapidIO support"
+	tristate "RapidIO support"
 	depends on PCI
 	default n
 	help
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b44b52c..992531f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -790,7 +790,7 @@ config HAS_RAPIDIO
 	default n
 
 config RAPIDIO
-	bool "RapidIO support"
+	tristate "RapidIO support"
 	depends on HAS_RAPIDIO || PCI
 	help
 	  If you say Y here, the kernel will include drivers and
@@ -798,7 +798,7 @@ config RAPIDIO
 
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
-	depends on RAPIDIO && HAS_RAPIDIO
+	depends on RAPIDIO = y && HAS_RAPIDIO
 	default "n"
 	---help---
 	  Include support for RapidIO controller on Freescale embedded
-- 
1.7.8.4
