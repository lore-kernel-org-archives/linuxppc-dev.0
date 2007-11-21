Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D4AFDDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:14:34 +1100 (EST)
Date: Tue, 20 Nov 2007 23:12:37 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] [POWERPC] Add docs for Freescale 83xx SATA device tree
	nodes
In-Reply-To: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0711202312130.24220@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 Documentation/powerpc/booting-without-of.txt |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index e9a3cb1..eb14dd5 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2514,6 +2514,29 @@ platforms are moved over to use the flattened-device-tree model.
       Requred properties:
        - current-speed : Baud rate of uartlite

+    * Freescale 8xxx/3.0 Gb/s SATA nodes
+
+    SATA nodes are defined to describe on-chip Serial ATA controllers.
+    Each SATA port should have its own node.
+
+    Required properties:
+    - compatible        : compatible list, contains 2 entries, first is
+			 "fsl,sata-CHIP", where CHIP is the processor
+			 (mpc8315, mpc8379, etc.) and the second is
+			 "fsl,sata-pq2pro"
+    - interrupts        : <interrupt mapping for SATA IRQ>
+    - interrupt-parent  : optional, if needed for interrupt mapping
+    - reg               : <registers mapping>
+
+   Example:
+
+	sata@19000 {
+		compatible = "fsl,mpc8315-sata", "fsl,sata-pq2pro;
+		reg = <19000 1000>;
+		interrupts = <2d 8>;
+		interrupt-parent = < &ipic >;
+        };
+
    More devices will be defined as this spec matures.

 VII - Specifying interrupt information for devices
-- 
1.5.3.4
