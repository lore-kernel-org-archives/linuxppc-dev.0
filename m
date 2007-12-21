Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA6D7DDF45
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 04:59:39 +1100 (EST)
Date: Fri, 21 Dec 2007 20:22:39 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] PowerPC: Add PCI entry to 440GRx Rainier DTS.
Message-ID: <20071221172239.GA2317@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476BF5B7.3030201@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds PCI entry to PowerPC 440GRx Rainier DTS.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/rainier.dts |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+)

--- linux-2.6.orig/arch/powerpc/boot/dts/rainier.dts	2007-12-19 16:00:01.000000000 +0300
+++ linux-2.6/arch/powerpc/boot/dts/rainier.dts	2007-12-20 21:59:42.000000000 +0300
@@ -317,6 +317,33 @@
 				has-new-stacr-staopc;
 			};
 		};
+
+		PCI0: pci@1ec000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb440grx-pci", "ibm,plb-pci";
+			primary;
+			reg = <1 eec00000 8	/* Config space access */
+			       1 eed00000 4	/* IACK */
+			       1 eed00000 4	/* Special cycle */
+			       1 ef400000 40>;	/* Internal registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed. Chip supports a second
+			 * IO range but we don't use it for now
+			 */
+			ranges = <02000000 0 80000000 1 80000000 0 10000000
+				01000000 0 00000000 1 e8000000 0 00100000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+
+			/* All PCI interrupts are routed to IRQ 67 */
+			interrupt-map-mask = <0000 0 0 0>;
+			interrupt-map = < 0000 0 0 0 &UIC2 3 8 >;
+		};
 	};
 
 	chosen {
