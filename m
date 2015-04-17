Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0136.outbound.protection.outlook.com [157.56.111.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 597C31A0028
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 08:53:36 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/qman: Change fsl,qman-channel-id to cell-index
Date: Fri, 17 Apr 2015 17:53:06 -0500
Message-ID: <1429311187-19062-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, devicetree@vger.kernel.org,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It turns out that existing U-Boots will dereference NULL pointers
if the device tree does not have cell-index in the portal nodes.

No patch has yet been merged adding device tree nodes for this binding
(except a dtsi that has not yet been referenced), nor has any driver
yet been merged making use of the binding, so it's not too late to
change the binding in order to keep compatibility with existing
U-Boots.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
---
 Documentation/devicetree/bindings/soc/fsl/qman-portals.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt b/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
index 48c4dae..47e46cc 100644
--- a/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
@@ -47,7 +47,7 @@ PROPERTIES
 
 	For additional details about the PAMU/LIODN binding(s) see pamu.txt
 
-- fsl,qman-channel-id
+- cell-index
 	Usage:		Required
 	Value type:	<u32>
 	Definition:	The hardware index of the channel. This can also be
@@ -136,7 +136,7 @@ The example below shows a (P4080) QMan portals container/bus node with two porta
 			reg = <0x4000 0x4000>, <0x101000 0x1000>;
 			interrupts = <106 2 0 0>;
 			fsl,liodn = <3 4>;
-			fsl,qman-channel-id = <1>;
+			cell-index = <1>;
 
 			fman0 {
 				fsl,liodn = <0x22>;
-- 
2.1.0
