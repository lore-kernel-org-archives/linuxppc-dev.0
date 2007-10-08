Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 77C20DDF30
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 17:53:20 +1000 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPL008CX1WQ0070@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 01:53:14 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPL00JRC1WQ9140@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 01:53:15 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPL008RW1WPHUB0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 01:53:13 -0600 (MDT)
Date: Mon, 08 Oct 2007 01:53:13 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Device tree bindings for Xilinx devices
To: linuxppc-dev@ozlabs.org
Message-id: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

This is a first draft, please review and comment.

On a side node, I think booting-without-of.txt could get really unwieldly
in the near future.  Perhaps the device tree bindings should be organized
differently and separated from the functional description of device tree
usage.  Thoughts?

Cheers,
g.

 Documentation/powerpc/booting-without-of.txt |   58 ++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 20e0e6c..a6d6056 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1850,6 +1850,64 @@ platforms are moved over to use the flattened-device-tree model.
 
    More devices will be defined as this spec matures.
 
+   l) Xilinx ML300 Framebuffer
+
+   Simple framebuffer device from the ML300 reference design (also on the
+   ML403 reference design as well as others).
+
+   Required properties:
+    - compatible : Must include "xilinx,ml300-fb"
+    - reg : offset and length of the framebuffer register set
+
+   Optional properties:
+    - resolution : <xres yres> pixel resolution of framebuffer.  Some
+                   implementations use a different resolution.  Default
+                   is <d#640 d#480>
+    - virt-resolution : <xvirt yvirt> Size of framebuffer in memory.
+                        Default is <d#1024 d#480>.
+    - rotate-display : rotate display 180 degrees.
+    - display-number : Logical number of display
+
+   m) Xilinx SystemACE
+
+   The Xilinx SystemACE device is used to program FPGAs from an FPGA
+   bitstream stored on a CF card.  It can also be used as a generic CF
+   interface device.
+
+   Required properties:
+    - compatible : Must include "xilinx,sysace"
+    - reg : offset and length of SystemACE register set
+
+   Recommended properties:
+    - interrupt-parent, interrupts : Connection of device irq signal.
+
+   Optional properties:
+    - number : logical number of the SystemACE device based at 0.
+    - 8-bit (empty) : Set this property if the SystemACE must be in 8 bit mode
+
+   n) Xilinx EMAC and Xilinx TEMAC
+
+   Xilinx Ethernet devices.  Uses common properties from other Ethernet
+   devices with the following constraints:
+   
+   Required properties:
+    - compatible : Must include one of: "xilinx,plb-temac",
+                   "xilinx,plb-emac", "xilinx-opb-emac"
+    - dma-mode : Must be one of "none", "simple", "sg" (sg == scatter gather)
+
+   o) Xilinx Uartlite
+
+   Xilinx uartlite devices are simple fixed speed serial ports.  Uartlite
+   ports should be described in a node with the following properties.
+
+   Requred properties:
+    - compatible : Must include "xilinx,uartlite"
+    - reg : offset and length of uartlite register set
+
+    Recommended properties:
+    - port-number : logical port number of uartlite device based at 0.
+    - interrupt-parent, interrupts : Connection of device irq signal.
+
 VII - Specifying interrupt information for devices
 ===================================================
 
