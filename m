Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C206DDE18
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 23:01:16 +1000 (EST)
Date: Mon, 17 Sep 2007 17:00:05 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] usb: ehci-ppc-of dts bindings.
Message-ID: <20070917130005.GA29654@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917125543.GA29584@ru.mvista.com>
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff -ruN linux-2.6.orig/Documentation/powerpc/booting-without-of.txt linux-2.6.new/Documentation/powerpc/booting-without-of.txt
--- linux-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-09-15 14:27:57.000000000 +0400
+++ linux-2.6.new/Documentation/powerpc/booting-without-of.txt	2007-09-15 17:19:06.000000000 +0400
@@ -52,6 +52,7 @@
       i) Freescale QUICC Engine module (QE)
       j) CFI or JEDEC memory-mapped NOR flash
       k) Global Utilities Block
+      l) USB EHCI controllers
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -1848,6 +1849,35 @@
 		fsl,has-rstcr;
 	};
 
+  l) USB EHCI controllers
+
+  Required properties:
+  - device_type : should be "usb".
+  - compatible : should be "ehci".
+  - reg : Offset and length of the register set for the device
+  - interrupts : <a b> where a is the interrupt number and b is a
+    field that represents an encoding of the sense and level
+    information for the interrupt.  This should be encoded based on
+    the information in section 2) depending on the type of interrupt
+    controller you have.
+  - interrupt-parent : the phandle for the interrupt controller that
+    services interrupts for this device.
+  If device registers are implemented in big endian mode, the device
+  node should have "big-endian" property.
+  If controller implementation operates with big endian descriptors,
+  compatible should also have "ehci-be-desc"
+
+   Example (Sequoia 440EPx):
+	ehci@e0000300 {
+		device_type = "usb";
+		compatible = "ibm,ehci-440epx", "ehci-be-desc", "ehci";
+		interrupts = <1a 4>;
+		interrupt-parent = <&UIC0>;
+		reg = <0 e0000300 ff>;
+		big-endian;
+	};
+
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
