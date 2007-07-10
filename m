Return-Path: <b08248@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95355DE092
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 00:51:16 +1000 (EST)
Date: Tue, 10 Jul 2007 09:51:09 -0500
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200707101451.l6AEp9A3019214@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH v3][POWERPC] document ipic level/sense info
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

document level/sense encoding info for IPIC 
interrupt controllers

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index c169299..e7a465c 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -50,13 +50,14 @@ Table of Contents
       g) Freescale SOC SEC Security Engines
       h) Board Control and Status (BCSR)
       i) Freescale QUICC Engine module (QE)
-      g) Flash chip nodes
+      j) Flash chip nodes
 
   VII - Specifying interrupt information for devices
     1) interrupts property
     2) interrupt-parent property
     3) OpenPIC Interrupt Controllers
     4) ISA Interrupt Controllers
+    5) IPIC Interrupt Controllers
 
   Appendix A - Sample SOC node for MPC8540
 
@@ -1878,6 +1879,22 @@ encodings listed below:
 	2 =  high to low edge sensitive type enabled
 	3 =  low to high edge sensitive type enabled
 
+5) Freescale IPIC Interrupt Controllers
+---------------------------------------
+
+IPIC interrupt controllers are specific to Freescale 83xx
+SOCs.  Two cells are required to encode interrupt information.
+The first cell defines the interrupt number.  The second cell
+defines the sense and level information.
+
+Sense and level information follows the Linux convention
+(specified in include/linux/interrupt.h) and should be encoded
+as follows:
+
+	2 =  high to low edge sense type enabled
+	8 =  active low level sense type enabled
+
+Note: other level/sense types (0,1,4, etc) are not supported.
 
 Appendix A - Sample SOC node for MPC8540
 ========================================
-- 
1.5.0.3
