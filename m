Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA0C1DE327
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 06:27:11 +1100 (EST)
Date: Mon, 29 Oct 2007 23:23:59 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] PowerPC: NDFC entry for 440EPx Sequoia DTS
Message-ID: <20071029202359.GA2176@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071029201738.GA2022@ru.mvista.com>
Cc: tglx@linutronix.de, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

NDFC DTS entry for PowerPC 440EPx Sequoia board.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/sequoia.dts |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+)

diff -pruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-10-29 16:02:11.000000000 +0300
+++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-10-29 18:59:11.000000000 +0300
@@ -141,6 +141,29 @@
 				interrupts = <5 1>;
 				interrupt-parent = <&UIC1>;
 
+				ndfc@0,0 {
+					compatible = "ibm,ndfc-440epx", "ibm,ndfc";
+					reg = <3 000000 2000>;
+					ndfc-mtd0 {
+						bank-settings = <80002222>;
+						bank-map = <3>;
+						chip-delay = <32>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						partition@0 {
+							label = "u-boot-nand";
+							reg = <0 0080000>;
+						};
+						partition@80000 {
+							label = "kernel-nand";
+							reg = <0080000 0180000>;
+						};
+						partition@200000 {
+							label = "filesystem";
+							reg = <0200000 1e00000>;
+						};
+					};
+				};
 				nor_flash@0,0 {
 					compatible = "amd,s29gl256n", "cfi-flash";
 					bank-width = <2>;
