Return-Path: <roy.pledge@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0049.outbound.protection.outlook.com [104.47.32.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Yy83Cd8zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 06:49:04 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>, <robin.murphy@arm.com>
CC: <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 03/11] dt-bindings: soc/fsl: Update reserved memory binding
 for QBMan
Date: Wed, 19 Apr 2017 16:48:42 -0400
Message-ID: <1492634930-10765-4-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Updates the QMan and BMan device tree bindings for reserved memory
nodes. This makes the reserved memory allocation compatiable with
the shared-dma-pool usage.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 Documentation/devicetree/bindings/soc/fsl/bman.txt | 11 ++++++-----
 Documentation/devicetree/bindings/soc/fsl/qman.txt | 18 +++++++++++-------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt b/Documentation/devicetree/bindings/soc/fsl/bman.txt
index 47ac834..3cd1e2c 100644
--- a/Documentation/devicetree/bindings/soc/fsl/bman.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
@@ -65,8 +65,8 @@ to the respective BMan instance
 BMan Private Memory Node
 
 BMan requires a contiguous range of physical memory used for the backing store
-for BMan Free Buffer Proxy Records (FBPR). This memory is reserved/allocated as a
-node under the /reserved-memory node
+for BMan Free Buffer Proxy Records (FBPR). This memory is reserved/allocated as
+a node under the /reserved-memory node.
 
 The BMan FBPR memory node must be named "bman-fbpr"
 
@@ -75,7 +75,8 @@ PROPERTIES
 - compatible
 	Usage:		required
 	Value type:	<stringlist>
-	Definition:	Must inclide "fsl,bman-fbpr"
+	Definition:	PPC platforms: Must include "fsl,bman-fbpr"
+			ARM platforms: Must include "shared-dma-pool"
 
 The following constraints are relevant to the FBPR private memory:
 	- The size must be 2^(size + 1), with size = 11..33. That is 4 KiB to
@@ -100,10 +101,10 @@ The example below shows a BMan FBPR dynamic allocation memory node
 		ranges;
 
 		bman_fbpr: bman-fbpr {
-			compatible = "fsl,bman-fbpr";
-			alloc-ranges = <0 0 0x10 0>;
+			compatible = "shared-mem-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 	};
 
diff --git a/Documentation/devicetree/bindings/soc/fsl/qman.txt b/Documentation/devicetree/bindings/soc/fsl/qman.txt
index 556ebb8..8cd20c0 100644
--- a/Documentation/devicetree/bindings/soc/fsl/qman.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/qman.txt
@@ -74,7 +74,9 @@ QMan Private Memory Nodes
 
 QMan requires two contiguous range of physical memory used for the backing store
 for QMan Frame Queue Descriptor (FQD) and Packed Frame Descriptor Record (PFDR).
-This memory is reserved/allocated as a nodes under the /reserved-memory node
+This memory is reserved/allocated as a node under the /reserved-memory node.
+
+For additional details about reserved memory regions see reserved-memory.txt
 
 The QMan FQD memory node must be named "qman-fqd"
 
@@ -83,7 +85,8 @@ PROPERTIES
 - compatible
 	Usage:		required
 	Value type:	<stringlist>
-	Definition:	Must inclide "fsl,qman-fqd"
+	Definition:	PPC platforms: Must include "fsl,qman-fqd"
+			ARM platforms: Must include "shared-dma-pool"
 
 The QMan PFDR memory node must be named "qman-pfdr"
 
@@ -92,7 +95,8 @@ PROPERTIES
 - compatible
 	Usage:		required
 	Value type:	<stringlist>
-	Definition:	Must inclide "fsl,qman-pfdr"
+	Definition:	PPC platforms: Must include "fsl,qman-pfdr"
+			ARM platforms: Must include "shared-dma-pool"
 
 The following constraints are relevant to the FQD and PFDR private memory:
 	- The size must be 2^(size + 1), with size = 11..29. That is 4 KiB to
@@ -117,16 +121,16 @@ The example below shows a QMan FQD and a PFDR dynamic allocation memory nodes
 		ranges;
 
 		qman_fqd: qman-fqd {
-			compatible = "fsl,qman-fqd";
-			alloc-ranges = <0 0 0x10 0>;
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
-			compatible = "fsl,qman-pfdr";
-			alloc-ranges = <0 0 0x10 0>;
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
-- 
2.7.4
