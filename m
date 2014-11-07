Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0115.outbound.protection.outlook.com [207.46.100.115])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D2141A00B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 14:01:52 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl: Update fman dt binding with clock name and qbman
 link
Date: Thu, 6 Nov 2014 21:01:34 -0600
Message-ID: <1415329294-22011-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Igal Liberman <Igal.Liberman@freescale.com>,
 Emil Medve <Emilian.Medve@Freescale.com>, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The clock name "fmanclk" was given in the example, but not specified
in the binding itself.  Made clock-names mandatory as otherwise there's
not much point having it.

Added a reference to the fsl,qman and fsl,bman properties proposed
in http://patchwork.ozlabs.org/patch/407034/ and
http://patchwork.ozlabs.org/patch/407035/

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This patch is on top of http://patchwork.ozlabs.org/patch/390351/

 Documentation/devicetree/bindings/powerpc/fsl/fman.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
index da8e5f2..edeea16 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
@@ -79,12 +79,12 @@ PROPERTIES
 - clocks
 		Usage: required
 		Value type: <prop-encoded-array>
-		Definition: phandle for fman clock.
+		Definition: phandle for the fman input clock.
 
 - clock-names
-		usage: optional
+		usage: required
 		Value type: <stringlist>
-		Definition: A standard property
+		Definition: "fmanclk" for the fman input clock.
 
 - interrupts
 		Usage: required
@@ -104,6 +104,11 @@ PROPERTIES
 		"Work Queue (WQ) Channel Assignments in the QMan" section
 		in DPAA Reference Manual.
 
+- fsl,qman
+- fsl,bman
+		Usage: required
+		Definition: See soc/fsl/qman.txt and soc/fsl/bman.txt
+
 =============================================================================
 FMan MURAM Node
 
-- 
1.9.1
