Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72B0EDDF66
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:28:35 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9JBSUAv015135
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:28:31 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9JBSNKe016129
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:28:30 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v7 5/9] add documentation for SATA nodes
Date: Fri, 19 Oct 2007 19:38:46 +0800
Message-Id: <1192793930-26039-6-git-send-email-leoli@freescale.com>
In-Reply-To: <1192793930-26039-5-git-send-email-leoli@freescale.com>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
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
index a96e853..8d49942 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2242,6 +2242,38 @@ platforms are moved over to use the flattened-device-tree model.
 			   available.
 			   For Axon: 0x0000012a
 
+    o) SATA nodes
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
