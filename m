Return-Path: <benmcollins13@gmail.com>
Received: from mail-da0-x229.google.com (mail-da0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 553772C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 10:19:12 +1100 (EST)
Received: by mail-da0-f41.google.com with SMTP id w4so15759dam.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 16:19:09 -0700 (PDT)
From: Ben Collins <benmcollins13@gmail.com>
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] sgy-cts1000: Remove __dev* attributes
Date: Mon, 18 Mar 2013 19:19:07 -0400
Message-Id: <1A7562E2-E3F4-499C-AB2E-788D08234B02@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Somehow the driver snuck in with these still in it.

Signed-off-by: Ben Collins <ben.c@servergy.com>
---
 arch/powerpc/platforms/85xx/sgy_cts1000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c =
b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index 611e92f..7179726 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -69,7 +69,7 @@ static irqreturn_t gpio_halt_irq(int irq, void =
*__data)
         return IRQ_HANDLED;
 };
=20
-static int __devinit gpio_halt_probe(struct platform_device *pdev)
+static int gpio_halt_probe(struct platform_device *pdev)
 {
 	enum of_gpio_flags flags;
 	struct device_node *node =3D pdev->dev.of_node;
@@ -128,7 +128,7 @@ static int __devinit gpio_halt_probe(struct =
platform_device *pdev)
 	return 0;
 }
=20
-static int __devexit gpio_halt_remove(struct platform_device *pdev)
+static int gpio_halt_remove(struct platform_device *pdev)
 {
 	if (halt_node) {
 		int gpio =3D of_get_gpio(halt_node, 0);
@@ -165,7 +165,7 @@ static struct platform_driver gpio_halt_driver =3D {
 		.of_match_table =3D gpio_halt_match,
 	},
 	.probe		=3D gpio_halt_probe,
-	.remove		=3D __devexit_p(gpio_halt_remove),
+	.remove		=3D gpio_halt_remove,
 };
=20
 module_platform_driver(gpio_halt_driver);
--=20
1.8.1.2


--
Servergy  : http://www.servergy.com/
SwissDisk : http://www.swissdisk.com/
Ubuntu    : http://www.ubuntu.com/
My Blog   : http://ben-collins.blogspot.com/
