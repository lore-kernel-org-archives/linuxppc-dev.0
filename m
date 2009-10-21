Return-Path: <vivek.mahajan@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D0F6B7B9D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 23:51:23 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9LCp5E8010982
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 05:51:15 -0700 (MST)
From: Vivek Mahajan <vivek.mahajan@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/3] powerpc/fsl: 85xx: document cache-sram
Date: Wed, 21 Oct 2009 18:20:58 +0530
Message-Id: <1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
In-Reply-To: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com>
References: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com>
Cc: kumar.gala@freescale.com, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds documentation for Freescale's QorIQ based cache-sram as under:-

* How to enable it from a low level driver
* How to set its size

Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
---
v2, v3: No change over v1

 Documentation/powerpc/fsl_85xx_cache_sram.txt |   31 +++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/fsl_85xx_cache_sram.txt

diff --git a/Documentation/powerpc/fsl_85xx_cache_sram.txt b/Documentation/powerpc/fsl_85xx_cache_sram.txt
new file mode 100644
index 0000000..7f43e2a
--- /dev/null
+++ b/Documentation/powerpc/fsl_85xx_cache_sram.txt
@@ -0,0 +1,31 @@
+* Freescale QorIQ based Cache SRAM
+
+Freescale's QorIQ platforms provide an option of configuring
+a part of (or full) cache memory as SRAM. Any low level
+driver can use its APIs via selecting FSL_85XX_CACHE_SRAM as
+under for the case of gianfar ethernet driver:-
+
+In drivers/net/Kconfig:-
+
+config GIANFAR
+      ....
+      select FSL_85XX_CACHE_SRAM if MPC85xx
+      ....
+
+FSL_85XX_CACHE_SRAM and its base address are defined in
+arch/powerpc/platforms/85xx/Kconfig as under:-
+
+config FSL_85XX_CACHE_SRAM
+	bool
+	select PPC_LIB_RHEAP
+
+config FSL_85XX_CACHE_SRAM_BASE
+	hex
+	depends on FSL_85XX_CACHE_SRAM
+	default "0xfff00000"
+
+The size of the above cache SRAM memory window is passed via the
+kernel command line as <cache-sram-size=....>
+
+Absence of the above parameter in the kernel command line is
+treated as no cache SRAM.
-- 
1.5.6.5
