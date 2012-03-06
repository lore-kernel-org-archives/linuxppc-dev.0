Return-Path: <B35336@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E344DB6FE6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:05:02 +1100 (EST)
Received: from mail72-am1 (localhost [127.0.0.1])	by mail72-am1-R.bigfish.com
 (Postfix) with ESMTP id EFE35A0610	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:04:56 +0000 (UTC)
Received: from AM1EHSMHS004.bigfish.com (unknown [10.3.201.230])	by
 mail72-am1.bigfish.com (Postfix) with ESMTP id 1602740052	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:04:55 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/9] powerpc/mpc8548cds: Add NOR flash node to dts
Date: Tue, 6 Mar 2012 17:06:40 +0800
Message-ID: <1331024805-15926-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: chenhui zhao <chenhui.zhao@freescale.com>

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8548cds.dts |   40 +++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 07b8dae..c3c8741 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -1,7 +1,7 @@
 /*
  * MPC8548 CDS Device Tree Source
  *
- * Copyright 2006, 2008 Freescale Semiconductor Inc.
+ * Copyright 2006, 2008, 2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -34,6 +34,44 @@
 
 	lbc: localbus@e0005000 {
 		reg = <0 0xe0005000 0 0x1000>;
+
+		ranges = <0x0 0x0 0x0 0xff000000 0x01000000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x01000000>;
+			bank-width = <2>;
+			device-width = <2>;
+
+			partition@0 {
+				reg = <0x0 0x0b00000>;
+				label = "ramdisk-nor";
+			};
+
+			partition@300000 {
+				reg = <0x0b00000 0x0400000>;
+				label = "kernel-nor";
+			};
+
+			partition@700000 {
+				reg = <0x0f00000 0x060000>;
+				label = "dtb-nor";
+			};
+
+			partition@760000 {
+				reg = <0x0f60000 0x020000>;
+				label = "env-nor";
+				read-only;
+			};
+
+			partition@780000 {
+				reg = <0x0f80000 0x080000>;
+				label = "u-boot-nor";
+				read-only;
+			};
+		};
 	};
 
 	soc: soc8548@e0000000 {
-- 
1.6.4.1
