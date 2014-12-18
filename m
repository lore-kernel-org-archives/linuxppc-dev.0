Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0137.outbound.protection.outlook.com [157.56.111.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4252F1A00BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 12:06:49 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mpc85xx: Add ranges to etsec2 nodes
Date: Wed, 17 Dec 2014 19:06:31 -0600
Message-ID: <1418864791-32526-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 746c9e9f92dd "of/base: Fix PowerPC address parsing hack" limited
the applicability of the workaround whereby a missing ranges is treated
as an empty ranges.  This workaround was hiding a bug in the etsec2
device tree nodes, which have children with reg, but did not have
ranges.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
index 1382fec..7fcb1ac 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
@@ -50,6 +50,7 @@ ethernet@b0000 {
 	fsl,num_tx_queues = <0x8>;
 	fsl,magic-packet;
 	local-mac-address = [ 00 00 00 00 00 00 ];
+	ranges;
 
 	queue-group@b0000 {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
index 221cd2e..9f25427 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
@@ -50,6 +50,7 @@ ethernet@b1000 {
 	fsl,num_tx_queues = <0x8>;
 	fsl,magic-packet;
 	local-mac-address = [ 00 00 00 00 00 00 ];
+	ranges;
 
 	queue-group@b1000 {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
index 61456c3..cd7c318 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
@@ -49,6 +49,7 @@ ethernet@b2000 {
 	fsl,num_tx_queues = <0x8>;
 	fsl,magic-packet;
 	local-mac-address = [ 00 00 00 00 00 00 ];
+	ranges;
 
 	queue-group@b2000 {
 		#address-cells = <1>;
-- 
2.1.0
