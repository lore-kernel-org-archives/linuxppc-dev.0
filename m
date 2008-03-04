Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7725DDDE48
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 19:30:37 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m248UVrw018914
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 01:30:32 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m248US4U000207
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 02:30:31 -0600 (CST)
From: Zhang Wei <wei.zhang@freescale.com>
To: mporter@kernel.crashing.org, galak@kernel.crashing.org
Subject: [PATCH 02/17] Add RapidIO option to kernel configuration.
Date: Wed,  5 Mar 2008 00:29:47 +0800
Message-Id: <1204648202-5495-2-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1204648202-5495-1-git-send-email-wei.zhang@freescale.com>
References: <1204648202-5495-1-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/Kconfig                |   13 +++++++++++++
 arch/powerpc/platforms/86xx/Kconfig |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 485513c..70789e8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -563,6 +563,19 @@ source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
 
+config HAS_RAPIDIO
+	bool
+	default n
+
+config RAPIDIO
+	bool "RapidIO support"
+	depends on HAS_RAPIDIO
+	help
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
+source "drivers/rapidio/Kconfig"
+
 endmenu
 
 menu "Advanced setup"
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 21d1135..8c7c5ff 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -8,6 +8,7 @@ config MPC8641_HPCN
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575
+	select HAS_RAPIDIO
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
-- 
1.5.4
