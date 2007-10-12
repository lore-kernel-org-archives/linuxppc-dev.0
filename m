Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C827DDDF18
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 23:18:41 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9CDIaC3009216
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:18:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9CDIKNH006039
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:18:35 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v3 6/9] add documentation for SerDes nodes
Date: Fri, 12 Oct 2007 21:28:45 +0800
Message-Id: <1192195728-24189-7-git-send-email-leoli@freescale.com>
In-Reply-To: <1192195728-24189-6-git-send-email-leoli@freescale.com>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
	<1192195728-24189-6-git-send-email-leoli@freescale.com>
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
 Documentation/powerpc/booting-without-of.txt |   29 ++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 8d49942..8a9372e 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2274,6 +2274,35 @@ platforms are moved over to use the flattened-device-tree model.
 		phy-handle = < &serdes1 >;
         };
 
+    p) SerDes nodes
+
+    SerDes is a serializer/deserializer used by some Freescale SoC.
+
+    Required properties:
+
+    - compatible : Should specify what this SerDes controller is compatible
+      with.  Currently, this is most likely to be "fsl,serdes".
+    - reg : Offset and length of the register set for the device.
+    - protocol : Which up layer protocol is running on the serial
+      interface.  Could be "sata", "pcie", "sgmii".
+    - clock : Input clock frequency for SerDes in unit of MHz.
+
+    Optional properties:
+
+    - vdd-1v : Define this property when Vdd is 1V.
+    - pcie-x2 : Define this property when using PCI Express x2 interface.
+      Valid only when protocol is set to "pcie".
+
+   Example:
+
+	serdes1:serdes@e3000 {
+		compatible = "fsl,serdes";
+		reg = <e3000 100>;
+		vdd-1v;
+		protocol = "sata";
+		clock = <d#100>;
+	};
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
-- 
1.5.3.2.104.g41ef
