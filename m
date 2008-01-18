Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE0A0DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:05:44 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0I05eHG008397
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 17:05:41 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-199.am.freescale.net
	[10.214.72.199])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0I05dK8028206
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 18:05:40 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCH v3 1/8] Add IPIC config option
Date: Thu, 17 Jan 2008 17:05:31 -0700
Message-Id: <1200614738-25654-2-git-send-email-jrigby@freescale.com>
In-Reply-To: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
References: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
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
+	select IPIC
 	select WANT_DEVICE_TREE
 
 config PPC_86xx
@@ -80,6 +81,10 @@ config XICS
 	bool
 	default y
 
+config IPIC
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
+obj-$(CONFIG_IPIC)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
 ifeq ($(CONFIG_PCI),y)
-- 
1.5.3.5.726.g41a7a
