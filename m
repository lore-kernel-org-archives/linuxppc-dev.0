Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7B141DDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Apr 2008 22:30:27 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id F3DA521D7AC
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Apr 2008 14:30:24 +0200 (CEST)
Received: from [10.0.30.2] (p4FE6671E.dip.t-dialin.net [79.230.103.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 8607C90017
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Apr 2008 14:30:24 +0200 (CEST)
Resent-Message-Id: <47F8C260.2060403@grandegger.com>
Message-ID: <47F8C230.4090607@grandegger.com>
Date: Sun, 06 Apr 2008 14:29:36 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: wg@grandegger.com
Subject: [PATCH RFC] tqm8560.dts: add local bus devices
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

this is my first attempt to add local bus nodes to the DTS file 
of the TQM8560 for the following devices:

  CS1: 128 MB NOR FLASH at 0xf8000000
  CS2: Two Intel 82527 CAN controller at 0xe3000000
  CS3: 128 MB NAND FLASH at 0xe3010000

Index: linux-2.6-denx/arch/powerpc/boot/dts/tqm8560.dts
===================================================================
--- linux-2.6-denx.orig/arch/powerpc/boot/dts/tqm8560.dts
+++ linux-2.6-denx/arch/powerpc/boot/dts/tqm8560.dts
@@ -221,6 +221,77 @@
 		};
 	};
 
+	localbus@e0005000 {
+		compatible = "fsl,mpc8560-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xe0005000 0x100>;	// BRx, ORx, etc.
+
+		ranges = <
+			0x0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
+			0x1 0x0 0xf8000000 0x08000000	// NOR FLASH bank 0
+			0x2 0x0 0xe3000000 0x00008000	// CAN (2 x i82527)
+			0x3 0x0 0xe3010000 0x00008000	// NAND FLASH
+		>;
+
+		flash@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x1 0x0 0x8000000>;
+			bank-width = <4>;
+			device-width = <1>;
+
+			partition@0 {
+                                label = "kernel";
+                                reg = <0x00000000 0x00300000>;
+                        };
+                        partition@300000 {
+                                label = "fs";
+                                reg = <0x00300000 0x07c00000>;
+                        };
+                        partition@7700000 {
+                                label = "firmware";
+                                reg = <0x07700000 0x00100000>;
+                                read-only;
+                        };
+
+		};
+
+		can@2,0 {
+			device_type = "can";
+			compatible = "i82527";	// Intel 82527 or Bosch CC770
+			reg = <0x2 0x0 0x100>;
+			interrupts = <0x9 0x2>;
+			interrupt-parent = <&mpic>;
+		}
+
+		can@2,100 {
+			device_type = "can";
+			compatible = "i82527";	// Intel 82527 or Bosch CC770
+			reg = <0x2 0x100 0x100>;
+			interrupts = <0x9 0x2>;
+			interrupt-parent = <&mpic>;
+		}
+
+		nand@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <0x3 0x0 0x8000>;
+
+			kernel@0 {
+                                label = "kernel";
+				reg = <0x000000 0x0300000>;
+			};
+			fs@300000 {
+                                label = "fs";
+				reg = <0x300000 0x7d00000>;
+			};
+		};
+	};
+
 	pci0: pci@e0008000 {
 		cell-index = <0>;
 		#interrupt-cells = <1>;


Do these entries make sense?

TIA.

Wolfgang.
