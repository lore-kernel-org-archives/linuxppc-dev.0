Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 42AEFDDEFC
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 17:19:57 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l5J7Jfqx017415
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 00:19:42 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5J7JevV027573
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 02:19:41 -0500 (CDT)
Subject: [PATCH 1/2]: Document the global utilities node define and example
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1182237558.3269.14.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 19 Jun 2007 15:19:18 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Document the global utilities node define and example.
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
Based on current paul's tree!

 Documentation/powerpc/booting-without-of.txt |   28 ++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index d42d981..bdae4fc 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -51,6 +51,7 @@ Table of Contents
       h) Board Control and Status (BCSR)
       i) Freescale QUICC Engine module (QE)
       g) Flash chip nodes
+      k) Global Utilities Block
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -1782,6 +1783,33 @@ platforms are moved over to use the flattened-device-tree model.
  		partition-names = "fs\0firmware";
  	};
 
+   k) Global Utilities Block
+
+   The global utilities block controls power management, I/O device 
+   enabling, power-on-reset configuration monitoring, general-purpose
+   I/O signal configuration, alternate function selection for multiplexed
+   signals, and clock control.
+
+   Required properties:
+
+    - compatible : Should define the compatible device type for
+      global-utilities.
+    - reg : Offset and length of the register set for the device.
+
+  Recommended properties:
+
+    - fsl,has-rstcr : Indicates that the global utilities register set
+      contains a functioning "reset control register" (i.e. the board
+      is wired to reset upon setting the HRESET_REQ bit in this register).
+
+    Example:
+
+	global-utilities@e0000 {	/* global utilities reg */
+		compatible = "fsl,mpc8548-guts";
+		reg = <e0000 1000>;
+		fsl,has-rstcr;
+	};
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
-- 
1.5.1
