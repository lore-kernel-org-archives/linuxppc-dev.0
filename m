Return-Path: <himangi774@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C60281A0590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 06:21:41 +1000 (EST)
Received: by mail-pa0-f48.google.com with SMTP id rd3so8012695pab.35
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 13:21:39 -0700 (PDT)
Date: Tue, 27 May 2014 01:51:31 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: Anatolij Gustschin <agust@denx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Introduce the use of the managed version of kzalloc
Message-ID: <20140526202130.GA16360@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julia.lawall@lip6.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves data allocated using kzalloc to managed data allocated
using devm_kzalloc and cleans now unnecessary kfree in probe function.

The following Coccinelle semantic patch was used for making the change:

@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@prb@
identifier platform.probefn, pdev;
expression e, e1, e2;
@@
probefn(struct platform_device *pdev, ...) {
  <+...
- e = kzalloc(e1, e2)
+ e = devm_kzalloc(&pdev->dev, e1, e2)
  ...
?-kfree(e);
  ...+>
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Not compile tested
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 6929982..37343a6 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -724,7 +724,7 @@ static int mpc52xx_gpt_probe(struct platform_device *ofdev)
 {
 	struct mpc52xx_gpt_priv *gpt;
 
-	gpt = kzalloc(sizeof *gpt, GFP_KERNEL);
+	gpt = devm_kzalloc(&ofdev->dev, sizeof *gpt, GFP_KERNEL);
 	if (!gpt)
 		return -ENOMEM;
 
@@ -732,10 +732,8 @@ static int mpc52xx_gpt_probe(struct platform_device *ofdev)
 	gpt->dev = &ofdev->dev;
 	gpt->ipb_freq = mpc5xxx_get_bus_frequency(ofdev->dev.of_node);
 	gpt->regs = of_iomap(ofdev->dev.of_node, 0);
-	if (!gpt->regs) {
-		kfree(gpt);
+	if (!gpt->regs)
 		return -ENOMEM;
-	}
 
 	dev_set_drvdata(&ofdev->dev, gpt);
 
-- 
1.9.1
