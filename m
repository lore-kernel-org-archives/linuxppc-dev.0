Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB4511A076F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 19:16:21 +1000 (AEST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: devicetree@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org,
 kernel@pengutronix.de
Subject: [PATCH RESENT] powerpc: dts: don't fall back to fsl, pq3-gpio for fsl,
 mpc8572-gpio devices
Date: Fri, 31 Jul 2015 11:16:06 +0200
Message-Id: <1438334166-12579-1-git-send-email-u.kleine-koenig@pengutronix.de>
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

While the handling of fsl,pq3-gpio and fsl,mpc8572-gpio is done in the
same driver and the two hardly differ, the latter controller needs a
workaround for an erratum in the gpio_get callback. To make this
difference more explicit remove fsl,pq3-gpio from the list of
compatibles for mpc8572 machines.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

got the parameters for git-send-email wrong and forgot to send this to the
powerpc folks.

Best regards
Uwe

 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
index c8b2daa40ac8..41935709ebe8 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
@@ -172,7 +172,7 @@
 
 	/* mark compat w/8572 to get some erratum treatment */
 	gpio-controller@f000 {
-		compatible = "fsl,mpc8572-gpio", "fsl,pq3-gpio";
+		compatible = "fsl,mpc8572-gpio";
 	};
 
 	sata@18000 {
diff --git a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
index d44e25a48734..49294cf36b4e 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
@@ -162,7 +162,7 @@
 /include/ "pq3-dma-1.dtsi"
 /include/ "pq3-gpio-0.dtsi"
 	gpio-controller@f000 {
-		compatible = "fsl,mpc8572-gpio", "fsl,pq3-gpio";
+		compatible = "fsl,mpc8572-gpio";
 	};
 
 	L2: l2-cache-controller@20000 {
-- 
2.1.4
