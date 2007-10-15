Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id D10DBDE9AE
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 01:55:48 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPY00FKBMUONS80@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 15 Oct 2007 09:54:24 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPY00EOAMUNTS60@pd4mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 15 Oct 2007 09:54:24 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPY00IKOMTL28P0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 15 Oct 2007 09:53:45 -0600 (MDT)
Date: Mon, 15 Oct 2007 09:53:44 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2] Device tree bindings for Xilinx devices
To: linuxppc-dev@ozlabs.org,
	Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>,
	Leonid <Leonid@a-k-a.net>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	microblaze-uclinux@itee.uq.edu.au
Message-id: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
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

Here's my second version of xilinx device tree bindings.  Please review
and comment.  I'd like to push these out to Paulus in the next couple
of days.

Cheers,
g.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 Documentation/powerpc/booting-without-of.txt |   55 ++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 7a6c5f2..21afaea 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2089,6 +2089,61 @@ platforms are moved over to use the flattened-device-tree model.
 
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
+    - rotate-display (empty) : rotate display 180 degrees.
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
+    - interrupt-parent, interrupts : Connection of device irq signal.
+
 VII - Specifying interrupt information for devices
 ===================================================
 
