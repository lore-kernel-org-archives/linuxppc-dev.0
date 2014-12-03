Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 465101A09EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 21:13:36 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0144.outbound.protection.outlook.com [207.46.100.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 953B81400E9
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 21:13:35 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/6] dt/bindings: qman: Add phandle to the portals
Date: Wed, 3 Dec 2014 04:02:40 -0600
Message-ID: <1417600964-24647-3-git-send-email-Emilian.Medve@Freescale.com>
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

This supports SoC(s) with multiple QMan instances

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 Documentation/devicetree/bindings/soc/fsl/qman.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/qman.txt b/Documentation/devicetree/bindings/soc/fsl/qman.txt
index 063e3a0..85d6059 100644
--- a/Documentation/devicetree/bindings/soc/fsl/qman.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/qman.txt
@@ -38,6 +38,11 @@ are located at offsets 0xbf8 and 0xbfc
 	Value type:	<prop-encoded-array>
 	Definition:	Standard property. The error interrupt
 
+- fsl,qman-portals
+	Usage:		Required
+	Value type:	<phandle>
+	Definition:	Phandle to this QMan's instance portals
+
 - fsl,liodn
 	Usage:		See pamu.txt
 	Value type:	<prop-encoded-array>
@@ -127,6 +132,10 @@ The example below shows a QMan FQD and a PFDR dynamic allocation memory nodes
 
 The example below shows a (P4080) QMan CCSR-space node
 
+	qportals: qman-portals@ff4200000 {
+		...
+	};
+
 	clockgen: global-utilities@e1000 {
 		...
 		sysclk: sysclk {
@@ -154,6 +163,7 @@ The example below shows a (P4080) QMan CCSR-space node
 		reg = <0x318000 0x1000>;
 		interrupts = <16 2 1 3>
 		fsl,liodn = <0x16>;
+		fsl,qman-portals = <&qportals>;
 		memory-region = <&qman_fqd &qman_pfdr>;
 		clocks = <&platform_pll 1>;
 	};
-- 
2.2.0
