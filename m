Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 44A48DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 16:40:53 +1100 (EST)
Subject: Re: [PATCH 19/25] powerpc: Wire up PCI on Bamboo board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206211906.2e1c099f@zod.rchland.ibm.com>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080130.2B29FDE0BA@ozlabs.org>
	<20071206211906.2e1c099f@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 16:40:22 +1100
Message-Id: <1197265222.6563.54.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Wire up PCI on Bamboo board

This adds the device-tree bits & call to ppc4xx_pci_find_bridges()
to make PCI work on the Bamboo board

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/arch/powerpc/boot/dts/bamboo.dts
===================================================================
--- linux-work.orig/arch/powerpc/boot/dts/bamboo.dts	2007-12-10 15:56:59.000000000 +1100
+++ linux-work/arch/powerpc/boot/dts/bamboo.dts	2007-12-10 16:39:51.000000000 +1100
@@ -239,10 +239,48 @@
 				zmii-channel = <1>;
 			};
 		};
+
+		PCI0: pci@ec000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
+			primary;
+			reg = <0 eec00000 8	/* Config space access */
+			       0 eed80000 4	/* IACK */
+			       0 eed80000 4	/* Special cycle */
+			       0 ef480000 40>;	/* Internal registers */
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed. Chip supports a second
+			 * IO range but we don't use it for now
+			 */
+			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
+				  01000000 0 00000000 0 e8000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+
+			/* Bamboo has all 4 IRQ pins tied together per slot */
+			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map = <
+				/* IDSEL 1 */
+				0800 0 0 0 &UIC0 1c 8
+
+				/* IDSEL 2 */
+				1000 0 0 0 &UIC0 1b 8
+
+				/* IDSEL 3 */
+				1800 0 0 0 &UIC0 1a 8
+
+				/* IDSEL 4 */
+				2000 0 0 0 &UIC0 19 8
+			>;
+		};
 	};
 
 	chosen {
 		linux,stdout-path = "/plb/opb/serial@ef600300";
-		bootargs = "console=ttyS0,115200";
 	};
 };
