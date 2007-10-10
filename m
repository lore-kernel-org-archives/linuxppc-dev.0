Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DE5FDDF6E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 19:56:27 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9A9uMwL003124
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 02:56:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9A9uFRD029638
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 04:56:21 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 5/9] add documentation for SATA nodes
Date: Wed, 10 Oct 2007 18:06:40 +0800
Message-Id: <1192010804-20071-5-git-send-email-leoli@freescale.com>
In-Reply-To: <1192010804-20071-4-git-send-email-leoli@freescale.com>
References: <1192010804-20071-1-git-send-email-leoli@freescale.com>
	<1192010804-20071-2-git-send-email-leoli@freescale.com>
	<1192010804-20071-3-git-send-email-leoli@freescale.com>
	<1192010804-20071-4-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   32 ++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 76733a3..f499f76 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1824,6 +1824,38 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,has-rstcr;
 	};
 
+    l) SATA nodes
+
+    SATA nodes are defined to describe on-chip Serial ATA controllers.
+
+    Required properties:
+
+    - compatible : Should specify what this SATA controller is compatible
+      with.
+    - reg : Offset and length of the register set for the device.
+    - interrupts : <a b> where a is the interrupt number and b is a
+      field that represents an encoding of the sense and level
+      information for the interrupt.  This should be encoded based on
+      the information in section 2) depending on the type of interrupt
+      controller you have.
+    - interrupt-parent : the phandle for the interrupt controller that
+      services interrupts for this device.
+
+    Recommended properties :
+
+    - phy-handle : Some SATA controller uses a shared SerDes PHY. This
+      property should specify the phandle of the SerDes node.
+
+   Example:
+
+	sata@19000 {
+		compatible = "fsl,mpc8315-sata";
+		reg = <19000 1000>;
+		interrupts = <2d 8>;
+		interrupt-parent = < &ipic >;
+		phy-handle = < &serdes1 >;
+        };
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
-- 
1.5.3.2.104.g41ef
