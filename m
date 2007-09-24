Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C3CBDDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 05:29:12 +1000 (EST)
Date: Mon, 24 Sep 2007 23:27:56 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] usb: ehci-ppc-of dts bindings.
Message-ID: <20070924192756.GA5371@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070924192519.GA4192@ru.mvista.com>
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds EHCI OF bindings to documentation.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   28 +++++++++++++++++++++++++++
 1 files changed, 28 insertions(+)

diff -ruN linux-2.6.orig/Documentation/powerpc/booting-without-of.txt linux-2.6/Documentation/powerpc/booting-without-of.txt
--- linux-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-09-24 14:55:04.000000000 +0400
+++ linux-2.6/Documentation/powerpc/booting-without-of.txt	2007-09-24 22:42:35.000000000 +0400
@@ -52,6 +52,7 @@
       i) Freescale QUICC Engine module (QE)
       j) CFI or JEDEC memory-mapped NOR flash
       k) Global Utilities Block
+      l) USB EHCI controllers
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -1848,6 +1849,33 @@
 		fsl,has-rstcr;
 	};
 
+  l) USB EHCI controllers
+
+  Required properties:
+  - compatible : should be "usb-ehci".
+  - reg : should contain at least address and length of the standard EHCI
+    register set for the device. Optional platform-dependent registers
+    (debug-port or other) can be also specified here, but only after
+    definition of standard EHCI registers.
+  - interrupts : one EHCI interrupt should be described here.
+  If device registers are implemented in big endian mode, the device
+  node should have "big-endian-regs" property.
+  If controller implementation operates with big endian descriptors,
+  "big-endian-desc" property should be specified.
+  If both big endian registers and descriptors are used by the controller
+  implementation, "big-endian" property can be specified instead of having
+  both "big-endian-regs" and "big-endian-desc".
+
+   Example (Sequoia 440EPx):
+	ehci@e0000300 {
+		compatible = "ibm,usb-ehci-440epx", "usb-ehci";
+		interrupt-parent = <&UIC0>;
+		interrupts = <1a 4>;
+		reg = <0 e0000300 90 0 e0000390 70>;
+		big-endian;
+	};
+
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
