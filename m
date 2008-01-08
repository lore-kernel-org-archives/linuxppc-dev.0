Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14863DDFEC
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 03:01:39 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m08G1ZLm013465
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 09:01:35 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-80.am.freescale.net
	[10.214.72.80])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m08G1XJH004714
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 10:01:34 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/7] mpc5121: Add IPIC config option
Date: Tue,  8 Jan 2008 09:01:27 -0700
Message-Id: <1199808093-15929-2-git-send-email-jrigby@freescale.com>
In-Reply-To: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

IPIC is not just for 83xx anymore so make it a separate
config option.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/platforms/Kconfig |    5 +++++
 arch/powerpc/sysdev/Makefile   |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index ea22cad..ad9b1c0 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -22,6 +22,7 @@ config PPC_83xx
 	depends on 6xx
 	select FSL_SOC
 	select 83xx
+	select FSL_IPIC
 	select WANT_DEVICE_TREE
 
 config PPC_86xx
@@ -80,6 +81,10 @@ config XICS
 	bool
 	default y
 
+config FSL_IPIC
+	bool
+	default n
+
 config MPIC
 	bool
 	default n
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 9a20ef4..66fe39c 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_AXON_RAM)		+= axonram.o
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
-obj-$(CONFIG_PPC_83xx)		+= ipic.o
+obj-$(CONFIG_FSL_IPIC)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
 ifeq ($(CONFIG_PCI),y)
-- 
1.5.3.5.726.g41a7a
