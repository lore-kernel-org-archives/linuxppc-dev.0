Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7013EDDE44
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:39:45 +1100 (EST)
Date: Tue, 22 Jan 2008 15:37:15 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Add docs for Freescale PowerQUICC SATA device tree
	nodes
Message-ID: <Pine.LNX.4.64.0801221536430.25559@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 Documentation/powerpc/booting-without-of.txt |   30 ++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 3584c33..387310a 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2743,6 +2743,36 @@ platforms are moved over to use the flattened-device-tree model.
 		};
 	};

+    * Freescale 8xxx/3.0 Gb/s SATA nodes
+
+    SATA nodes are defined to describe on-chip Serial ATA controllers.
+    Each SATA port should have its own node.
+
+    Required properties:
+    - compatible        : compatible list, contains 2 entries, first is
+			 "fsl,CHIP-sata", where CHIP is the processor
+			 (mpc8315, mpc8379, etc.) and the second is
+			 "fsl,pq-sata"
+    - interrupts        : <interrupt mapping for SATA IRQ>
+    - cell-index        : controller index.
+                              1 for controller @ 0x18000
+                              2 for controller @ 0x19000
+                              3 for controller @ 0x1a000
+                              4 for controller @ 0x1b000
+
+    Optional properties:
+    - interrupt-parent  : optional, if needed for interrupt mapping
+    - reg               : <registers mapping>
+
+   Example:
+
+	sata@18000 {
+		compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+		reg = <0x18000 0x1000>;
+		cell-index = <1>;
+		interrupts = <2c 8>;
+		interrupt-parent = < &ipic >;
+        };

    More devices will be defined as this spec matures.

-- 
1.5.3.7
