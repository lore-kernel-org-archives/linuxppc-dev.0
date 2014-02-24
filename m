Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A164B2C0378
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 21:26:29 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] dt/bindings: fsl-fec: add "per" to clock properties
Date: Mon, 24 Feb 2014 11:25:57 +0100
Message-Id: <1393237557-31406-3-git-send-email-gsi@denx.de>
In-Reply-To: <1393237557-31406-1-git-send-email-gsi@denx.de>
References: <1393237557-31406-1-git-send-email-gsi@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

a recent FEC binding document update that was motivated by i.MX
development revealed that ARM and PowerPC implementations in Linux
did not agree on the clock names to use for the FEC nodes

update the FEC (fast ethernet controller) binding to document the
"per" clock name as an obsolete alias for "ipg"

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---

this patch depends on "dt/bindings: fsl-fec: add clock properties"
by Shawn Guo which introduces the context of this patch

the patch only is necessary if the MPC5121 .dtsi update (switch
FEC nodes from "per" to "ipg") won't make it for v3.14

---
 Documentation/devicetree/bindings/net/fsl-fec.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index 468736d4323d..f59b58e29da6 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -24,6 +24,8 @@ Optional properties:
      or external oscillator via pad depending on board design.
    - "enet_out": the phy reference clock provided by SoC via pad, which
      is available on SoC like i.MX28.
+   - "per": obsolete alias for "ipg" for compatibility with early
+     MPC5121 implementations, not recommended for new .dts files
 - clock-names: Must contain the clock names described just above
 
 Example:
-- 
1.7.10.4
