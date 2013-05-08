Return-Path: <B31939@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2BC42C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 19:17:11 +1000 (EST)
Received: from mail144-co1 (localhost [127.0.0.1])	by
 mail144-co1-R.bigfish.com (Postfix) with ESMTP id D2A6ECA01CF	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 09:17:05 +0000 (UTC)
Received: from CO1EHSMHS029.bigfish.com (unknown [10.243.78.250])	by
 mail144-co1.bigfish.com (Postfix) with ESMTP id A5153C8004A	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 09:17:04 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl: add property 'reg' to pcie@0 node
Date: Wed, 8 May 2013 17:17:21 +0800
Message-ID: <1368004641-12405-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The property 'reg' is used to identify the PCIe device. if there is
no 'reg' the PCI driver can not find PCI device node corresponding
to PCI controller, and can not map the interrupts. So all the INTx
interrupts can not be used.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 7399154..d82c8da 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -49,6 +49,7 @@
 	interrupts = <20 2 0 0>;
 	fsl,iommu-parent = <&pamu0>;
 	pcie@0 {
+		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index bd611a9..3a6179f 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -48,6 +48,7 @@
 	bus-range = <0x0 0xff>;
 	interrupts = <20 2 0 0>;
 	pcie@0 {
+		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
@@ -74,6 +75,7 @@
 	bus-range = <0 0xff>;
 	interrupts = <21 2 0 0>;
 	pcie@0 {
+		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
@@ -100,6 +102,7 @@
 	bus-range = <0x0 0xff>;
 	interrupts = <22 2 0 0>;
 	pcie@0 {
+		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
@@ -126,6 +129,7 @@
 	bus-range = <0x0 0xff>;
 	interrupts = <23 2 0 0>;
 	pcie@0 {
+		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-- 
1.8.1.2
