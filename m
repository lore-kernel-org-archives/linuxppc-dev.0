Return-Path: <yangbo.lu@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411g710CCzzF333
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 19:22:36 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 03/10] dt-binding: ptp_qoriq: add DPAA FMan support
Date: Thu,  7 Jun 2018 17:20:43 +0800
Message-Id: <20180607092050.46128-4-yangbo.lu@nxp.com>
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to add bindings description for DPAA
FMan 1588 timer, and also remove its description in
fsl-fman dt-bindings document.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- None.
---
 Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-------------------
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++++++++--
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-fman.txt b/Documentation/devicetree/bindings/net/fsl-fman.txt
index df873d1..74603dd 100644
--- a/Documentation/devicetree/bindings/net/fsl-fman.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fman.txt
@@ -356,30 +356,7 @@ ethernet@e0000 {
 ============================================================================
 FMan IEEE 1588 Node
 
-DESCRIPTION
-
-The FMan interface to support IEEE 1588
-
-
-PROPERTIES
-
-- compatible
-		Usage: required
-		Value type: <stringlist>
-		Definition: A standard property.
-		Must include "fsl,fman-ptp-timer".
-
-- reg
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition: A standard property.
-
-EXAMPLE
-
-ptp-timer@fe000 {
-	compatible = "fsl,fman-ptp-timer";
-	reg = <0xfe000 0x1000>;
-};
+Refer to Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
 
 =============================================================================
 FMan MDIO Node
diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
index 0f569d8..c5d0e79 100644
--- a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
+++ b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
@@ -2,7 +2,8 @@
 
 General Properties:
 
-  - compatible   Should be "fsl,etsec-ptp"
+  - compatible   Should be "fsl,etsec-ptp" for eTSEC
+                 Should be "fsl,fman-ptp-timer" for DPAA FMan
   - reg          Offset and length of the register set for the device
   - interrupts   There should be at least two interrupts. Some devices
                  have as many as four PTP related interrupts.
@@ -43,14 +44,22 @@ Clock Properties:
   value, which will be directly written in those bits, that is why,
   according to reference manual, the next clock sources can be used:
 
+  For eTSEC,
   <0> - external high precision timer reference clock (TSEC_TMR_CLK
         input is used for this purpose);
   <1> - eTSEC system clock;
   <2> - eTSEC1 transmit clock;
   <3> - RTC clock input.
 
-  When this attribute is not used, eTSEC system clock will serve as
-  IEEE 1588 timer reference clock.
+  For DPAA FMan,
+  <0> - external high precision timer reference clock (TMR_1588_CLK)
+  <1> - MAC system clock (1/2 FMan clock)
+  <2> - reserved
+  <3> - RTC clock oscillator
+
+  When this attribute is not used, the IEEE 1588 timer reference clock
+  will use the eTSEC system clock (for Gianfar) or the MAC system
+  clock (for DPAA).
 
 Example:
 
-- 
1.7.1
