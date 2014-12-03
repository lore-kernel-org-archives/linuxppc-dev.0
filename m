Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4453F1A09E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 21:13:36 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6B9F51400DD
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 21:13:34 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/6] dt/bindings: bman: Add phandle to the portals
Date: Wed, 3 Dec 2014 04:02:39 -0600
Message-ID: <1417600964-24647-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1417600964-24647-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1417600964-24647-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This supports SoC(s) with multiple BMan instances

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 Documentation/devicetree/bindings/soc/fsl/bman.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt b/Documentation/devicetree/bindings/soc/fsl/bman.txt
index 9f80bf8..4fc4a6e 100644
--- a/Documentation/devicetree/bindings/soc/fsl/bman.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
@@ -36,6 +36,11 @@ are located at offsets 0xbf8 and 0xbfc
 	Value type:	<prop-encoded-array>
 	Definition:	Standard property. The error interrupt
 
+- fsl,bman-portals
+	Usage:		Required
+	Value type:	<phandle>
+	Definition:	Phandle to this BMan's instance portals
+
 - fsl,liodn
 	Usage:		See pamu.txt
 	Value type:	<prop-encoded-array>
@@ -104,6 +109,10 @@ The example below shows a BMan FBPR dynamic allocation memory node
 
 The example below shows a (P4080) BMan CCSR-space node
 
+	bportals: bman-portals@ff4000000 {
+		...
+	};
+
 	crypto@300000 {
 		...
 		fsl,bman = <&bman, 2>;
@@ -115,6 +124,7 @@ The example below shows a (P4080) BMan CCSR-space node
 		reg = <0x31a000 0x1000>;
 		interrupts = <16 2 1 2>;
 		fsl,liodn = <0x17>;
+		fsl,bman-portals = <&bportals>;
 		memory-region = <&bman_fbpr>;
 	};
 
-- 
2.2.0
