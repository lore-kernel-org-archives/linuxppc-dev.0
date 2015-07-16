Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 899001A090D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 05:35:50 +1000 (AEST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-spi@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 kernel@pengutronix.de, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: powerpc: adapt mpc5121-psc document to reality
Date: Thu, 16 Jul 2015 21:35:28 +0200
Message-Id: <1437075328-2574-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20150716133259.GI4039@sirena.org.uk>
References: <20150716133259.GI4039@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The drivers support MPC5125 additionally to MPC5121, and there is an spi
mode that is also supported. Additionally some minor corrections are
done.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I sent a patch adding mpc5125 support to the mpc512x driver and Mark
requested the new compatible to be documented. While at it I updated the
document a bit more, and obviously the spi support for mpc5125 depends
on my patch that isn't mainline yet.

Best regards
Uwe

 .../bindings/powerpc/fsl/mpc5121-psc.txt           | 24 ++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt
index 8832e8798912..647817527c88 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt
@@ -6,14 +6,14 @@ PSC in UART mode
 For PSC in UART mode the needed PSC serial devices
 are specified by fsl,mpc5121-psc-uart nodes in the
 fsl,mpc5121-immr SoC node. Additionally the PSC FIFO
-Controller node fsl,mpc5121-psc-fifo is requered there:
+Controller node fsl,mpc5121-psc-fifo is required there:
 
-fsl,mpc5121-psc-uart nodes
+fsl,mpc512x-psc-uart nodes
 --------------------------
 
 Required properties :
- - compatible : Should contain "fsl,mpc5121-psc-uart" and "fsl,mpc5121-psc"
- - cell-index : Index of the PSC in hardware
+ - compatible : Should contain "fsl,<soc>-psc-uart" and "fsl,<soc>-psc"
+   Supported <soc>s: mpc5121, mpc5125
  - reg : Offset and length of the register set for the PSC device
  - interrupts : <a b> where a is the interrupt number of the
    PSC FIFO Controller and b is a field that represents an
@@ -25,12 +25,21 @@ Recommended properties :
  - fsl,rx-fifo-size : the size of the RX fifo slice (a multiple of 4)
  - fsl,tx-fifo-size : the size of the TX fifo slice (a multiple of 4)
 
+PSC in SPI mode
+---------------
 
-fsl,mpc5121-psc-fifo node
+Similar to the UART mode a PSC can be operated in SPI mode. The compatible used
+for that is fsl,mpc5121-psc-spi. It requires a fsl,mpc5121-psc-fifo as well.
+The required and recommended properties are identical to the
+fsl,mpc5121-psc-uart nodes, just use spi instead of uart in the compatible
+string.
+
+fsl,mpc512x-psc-fifo node
 -------------------------
 
 Required properties :
- - compatible : Should be "fsl,mpc5121-psc-fifo"
+ - compatible : Should be "fsl,<soc>-psc-fifo"
+   Supported <soc>s: mpc5121, mpc5125
  - reg : Offset and length of the register set for the PSC
          FIFO Controller
  - interrupts : <a b> where a is the interrupt number of the
@@ -39,6 +48,9 @@ Required properties :
  - interrupt-parent : the phandle for the interrupt controller that
    services interrupts for this device.
 
+Recommended properties :
+ - clocks : specifies the clock needed to operate the fifo controller
+ - clock-names : name(s) for the clock(s) listed in clocks
 
 Example for a board using PSC0 and PSC1 devices in serial mode:
 
-- 
2.1.4
