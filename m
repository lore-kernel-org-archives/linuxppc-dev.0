Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A86D0B7C48
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 01:44:50 +1000 (EST)
Date: Thu, 22 Apr 2010 19:44:47 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Fix P1020RDB boot hang due USB2
Message-ID: <20100422154447.GA30785@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since USB2 is shared with local bus, either local bus or USB2
should be disabled. By default U-Boot enables local bus, so we
have to disable USB2, otherwise kernel hangs:

 ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
 fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
 fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
 fsl-ehci fsl-ehci.0: irq 28, io base 0xffe22000
 fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 1 port detected
 fsl-ehci fsl-ehci.1: Freescale On-Chip EHCI Host Controller
 fsl-ehci fsl-ehci.1: new USB bus registered, assigned bus number 2
 <hangs here>

Note that U-Boot doesn't clear 'status' property when it enables
USB2, so we have to comment out the whole node.

To enable USB2, one can issue
'setenv hwconfig usb2:dr_mode=<host|peripheral>' command at the
U-Boot prompt.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/boot/dts/p1020rdb.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index df52690..865795e 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -356,6 +356,11 @@
 			phy_type = "ulpi";
 		};
 
+		/* USB2 is shared with localbus, so it must be disabled
+		   by default. We can't put 'status = "disabled";' here
+		   since U-Boot doesn't clear the status property when
+		   it enables USB2. OTOH, U-Boot does create a new node
+		   when there isn't any. So, just comment it out.
 		usb@23000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -365,6 +370,7 @@
 			interrupts = <46 0x2>;
 			phy_type = "ulpi";
 		};
+		*/
 
 		sdhci@2e000 {
 			compatible = "fsl,p1020-esdhc", "fsl,esdhc";
-- 
1.7.0.4
