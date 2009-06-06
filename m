Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4CF1B70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 02:16:15 +1000 (EST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id AE124DDDA0
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 02:16:07 +1000 (EST)
Received: by ewy11 with SMTP id 11so3082681ewy.9
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 09:15:56 -0700 (PDT)
Message-ID: <4a2a9611.06c8100a.49ae.ffff88e4@mx.google.com>
Date: Sat, 06 Jun 2009 09:15:13 -0700 (PDT)
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	linux-kernel@vger.kernel.org
To: Leon Woestenberg <leon@sidebranch.com>
From: leon.woestenberg@gmail.com
Subject: [PATCH v2] Add MSI interrupts to DTS of MPC8315E-RDB
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCIe MSI interrupts are missing from the device tree source, and
thus were not enabled. This patch adds them.

v2 of the patch fixes inconsistent white space, reported by David Gibson.

Tested to work on MPC8315E-RDB with custom FPGA PCIe device.

Signed-off-by: Leon Woestenberg <leon@sidebranch.com>
Tested-by: Leon Woestenberg <leon@sidebranch.com>

Index: git/arch/powerpc/boot/dts/mpc8315erdb.dts
===================================================================
--- git.orig/arch/powerpc/boot/dts/mpc8315erdb.dts	2009-05-23 20:49:40.000000000 +0200
+++ git/arch/powerpc/boot/dts/mpc8315erdb.dts	2009-06-06 10:35:14.000000000 +0200
@@ -322,6 +322,21 @@
 			reg = <0x700 0x100>;
 			device_type = "ipic";
 		};
+
+		ipic-msi@7c0 {
+			compatible = "fsl,ipic-msi";
+			reg = <0x7c0 0x40>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <0x43 0x8
+				      0x4  0x8
+				      0x51 0x8
+				      0x52 0x8
+				      0x56 0x8
+				      0x57 0x8
+				      0x58 0x8
+				      0x59 0x8>;
+			interrupt-parent = < &ipic >;
+		};
 	};
 
 	pci0: pci@e0008500 {
