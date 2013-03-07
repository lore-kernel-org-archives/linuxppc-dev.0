Return-Path: <B37400@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 423672C0402
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 22:28:09 +1100 (EST)
From: Sandeep Singh <Sandeep@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/4] TDM Device Tree entries for various Freescale Platforms
Date: Thu, 7 Mar 2013 16:57:47 +0530
Message-ID: <1362655668-26721-3-git-send-email-Sandeep@freescale.com>
In-Reply-To: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Sandeep Singh <Sandeep@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1010RDB, P1020RDB, P1020MBG-PC, P1022DS, P1020RDB-PC and P1024RDB

In this Patch:
 1. TDM node included in <silicon>.dtsi files.
 2. Disabled TDM in 36bit configurations because of limitations
    in TDM hardware block, details mentioned below.

Details of 36bit h/w limitaion:
 ---------------------------------
TDM DMAC IP does not support more than 32b address. To address memory regions
more than 4GB, 4 bits of address were provided in GUTs, which are appended to
txns initiated by TDM DMAC. These 4 bits are appended irrespective of the
region addressed. When TDM works in DMA mode, the DMA need to access DDR as
well as TDM FIFO in CCSR space. So this poses a restriction that if memory
region above 4GB need to be accessed, CCSR space should also be mapped into
that 4GB region.
In this case DDR is at at first 4G (starting from 0) and CCSR is at
 different 4G (0xfffe00000), hence the issue.

Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |    1 +
 arch/powerpc/boot/dts/p1010rdb_36b.dts      |    3 +++
 arch/powerpc/boot/dts/p1020mbg-pc_36b.dts   |    3 +++
 arch/powerpc/boot/dts/p1020rdb-pc_36b.dts   |    3 +++
 arch/powerpc/boot/dts/p1020rdb_36b.dts      |    3 +++
 arch/powerpc/boot/dts/p1022ds_36b.dts       |    3 +++
 arch/powerpc/boot/dts/p1024rdb_36b.dts      |    3 +++
 9 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index 0bde9ee..15c74a2 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -1,7 +1,7 @@
 /*
  * P1010/P1014 Silicon/SoC Device Tree Source (post include)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -132,6 +132,7 @@
 /include/ "pq3-gpio-0.dtsi"
 /include/ "pq3-sata2-0.dtsi"
 /include/ "pq3-sata2-1.dtsi"
+/include/ "pq3-tdm1.0-0.dtsi"
 
 	can0: can@1c000 {
 		compatible = "fsl,p1010-flexcan";
diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
index 68cc5e7..684f664 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
@@ -131,6 +131,7 @@
 	};
 
 /include/ "pq3-gpio-0.dtsi"
+/include/ "pq3-tdm1.0-0.dtsi"
 
 	L2: l2-cache-controller@20000 {
 		compatible = "fsl,p1020-l2-cache-controller";
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 06216b8..4016e45 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -190,6 +190,7 @@
 		fsl,fifo-depth = <15>;
 	};
 
+/include/ "pq3-tdm1.0-0.dtsi"
 /include/ "pq3-sata2-0.dtsi"
 /include/ "pq3-sata2-1.dtsi"
 
diff --git a/arch/powerpc/boot/dts/p1010rdb_36b.dts b/arch/powerpc/boot/dts/p1010rdb_36b.dts
index 64776f4..e159b42 100644
--- a/arch/powerpc/boot/dts/p1010rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1010rdb_36b.dts
@@ -52,6 +52,9 @@
 
 	board_soc: soc: soc@fffe00000 {
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		tdm@16000 {
+			status = "disabled";
+		};
 	};
 
 	pci0: pcie@fffe09000 {
diff --git a/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts b/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
index 9e9f401..416e1a7 100644
--- a/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
+++ b/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
@@ -52,6 +52,9 @@
 
 	soc: soc@fffe00000 {
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		tdm@16000 {
+			status = "disabled";
+		};
 	};
 
 	pci0: pcie@fffe09000 {
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts b/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
index 5237da7..a1861d6 100644
--- a/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
+++ b/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
@@ -53,6 +53,9 @@
 
 	soc: soc@fffe00000 {
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		tdm@16000 {
+			status = "disabled";
+		};
 	};
 
 	pci0: pcie@fffe09000 {
diff --git a/arch/powerpc/boot/dts/p1020rdb_36b.dts b/arch/powerpc/boot/dts/p1020rdb_36b.dts
index bdbdb60..7bac196 100644
--- a/arch/powerpc/boot/dts/p1020rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1020rdb_36b.dts
@@ -29,6 +29,9 @@
 
 	board_soc: soc: soc@fffe00000 {
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		tdm@16000 {
+			status = "disabled";
+		};
 	};
 
 	pci0: pcie@fffe09000 {
diff --git a/arch/powerpc/boot/dts/p1022ds_36b.dts b/arch/powerpc/boot/dts/p1022ds_36b.dts
index f7aacce..024ea40 100644
--- a/arch/powerpc/boot/dts/p1022ds_36b.dts
+++ b/arch/powerpc/boot/dts/p1022ds_36b.dts
@@ -51,6 +51,9 @@
 
 	board_soc: soc: soc@fffe00000 {
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		tdm@16000 {
+			status = "disabled";
+		};
 	};
 
 	pci0: pcie@fffe09000 {
diff --git a/arch/powerpc/boot/dts/p1024rdb_36b.dts b/arch/powerpc/boot/dts/p1024rdb_36b.dts
index 3656825..b113229 100644
--- a/arch/powerpc/boot/dts/p1024rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1024rdb_36b.dts
@@ -49,6 +49,9 @@
 
 	soc: soc@fffe00000 {
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		tdm@16000 {
+			status = "disabled";
+		};
 	};
 
 	pci0: pcie@fffe09000 {
-- 
1.7.6.GIT
