Message-ID: <25757-52278@sneakemail.com>
Date: Tue, 13 Apr 2004 10:54:56 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: System ACE MPU interface to CF card
References: <407470ED.3030607@buckeye.ece.drexel.edu> <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu>
In-Reply-To: <407ADCFE.8080302@buckeye.ece.drexel.edu>
Content-Type: multipart/mixed;
 boundary="------------070909050201010407040802"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070909050201010407040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sharad Gupta sharad-at-buckeye.ece.drexel.edu |PPC Linux Embedded| wrote:

> Can you send me your board patch so that I can configure and build ACE
> driver for my board ? I want some help in knowing how and where to
> customize the driver for one's board.

The attached patch demonstrates how I enabled the SYSACE driver
for my (JSE) board. I'm not so sure I'm happy with it, because
each board will have to do something similar. I'm thinking that
the CONFIG_XILINX_SYSACE define should lose its dependence on
CONFIG_XILINX_OCP, but I'm not clear on the best way to account
for this in the xilinx_ocp/Makefile.

NOTE: This patch is meant to demonstrate my thinking on this
matter. It's not complete.

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."

--------------070909050201010407040802
Content-Type: text/plain;
 name="foo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo.txt"

Index: arch/ppc/platforms/xilinx_ocp/Makefile
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/arch/ppc/platforms/xilinx_ocp/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- arch/ppc/platforms/xilinx_ocp/Makefile	1 Dec 2002 22:42:56 -0000	1.1
+++ arch/ppc/platforms/xilinx_ocp/Makefile	13 Apr 2004 17:48:37 -0000
@@ -13,6 +13,7 @@
 			   xipif_v1_23_b.o xpacket_fifo_v1_00_b.o xversion.o

 obj-$(CONFIG_XILINX_OCP) := xilinx_ocp.o
+obj-$(CONFIG_JSE) := xilinx_ocp.o

 xilinx_ocp.o: $(xilinx_ocp-objs)
 	$(LD) -r -o $@ $(xilinx_ocp-objs)
Index: arch/ppc/platforms/xilinx_ocp/xparameters.h
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/arch/ppc/platforms/xilinx_ocp/xparameters.h,v
retrieving revision 1.2
diff -u -r1.2 xparameters.h
--- arch/ppc/platforms/xilinx_ocp/xparameters.h	30 Oct 2003 00:32:20 -0000	1.2
+++ arch/ppc/platforms/xilinx_ocp/xparameters.h	13 Apr 2004 17:48:37 -0000
@@ -16,3 +16,7 @@
 #if defined(CONFIG_XILINX_ML300)
 #include "xparameters_ml300.h"
 #endif
+
+#if defined(CONFIG_JSE)
+#include "xparameters_jse.h"
+#endif
Index: drivers/block/Config.in
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/drivers/block/Config.in,v
retrieving revision 1.5
diff -u -r1.5 Config.in
--- drivers/block/Config.in	30 Oct 2003 00:32:48 -0000	1.5
+++ drivers/block/Config.in	13 Apr 2004 17:48:37 -0000
@@ -40,7 +40,7 @@
 dep_tristate 'Mylex DAC960/DAC1100 PCI RAID Controller support' CONFIG_BLK_DEV_DAC960 $CONFIG_PCI
 dep_tristate 'Micro Memory MM5415 Battery Backed RAM support (EXPERIMENTAL)' CONFIG_BLK_DEV_UMEM $CONFIG_PCI $CONFIG_EXPERIMENTAL

-if [ "$CONFIG_XILINX_OCP" = "y" ]; then
+if [ "$CONFIG_XILINX_OCP" = "y" -o "$CONFIG_JSE" = "y" ]; then
    tristate 'Xilinx on-chip System ACE' CONFIG_XILINX_SYSACE
 fi


--------------070909050201010407040802--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
