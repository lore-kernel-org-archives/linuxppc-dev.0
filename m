Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0122.outbound.protection.outlook.com [207.46.100.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB2EA1A0F4C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:49:45 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Mike Turquette <mturquette@linaro.org>, Tang Yuantian
 <Yuantian.Tang@freescale.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liberman Igal-B31950
 <Igal.Liberman@freescale.com>, Bucur Madalin-Cristian-B32716
 <madalin.bucur@freescale.com>, <linux-clk@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: [RFC PATCH 7/8] clk: qoriq: Expose OF clocks directly from the
 clockgen node
Date: Thu, 18 Jun 2015 21:49:17 -0500
Message-ID: <1434682158-7243-8-git-send-email-scottwood@freescale.com>
In-Reply-To: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
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

This allows the "clocks" property to be used in the absence of
legacy nodes, and for clocks that the legacy nodes do not describe.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/clk/clk-qoriq.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index f6aa106..e408965 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -938,6 +938,61 @@ static void __init pltfrm_pll_init(struct device_node *np)
 	legacy_pll_init(np, PLATFORM_PLL);
 }
 
+static struct clk *clockgen_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct clockgen *cg = data;
+	struct clk *clk;
+	struct clockgen_pll *pll;
+	u32 type, idx;
+
+	if (clkspec->args_count < 2) {
+		pr_err("%s: insufficient phandle args\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	type = clkspec->args[0];
+	idx = clkspec->args[1];
+
+	switch (type) {
+	case 0:
+		if (idx != 0)
+			goto bad_args;
+		clk = cg->sysclk;
+		break;
+	case 1:
+		if (idx >= ARRAY_SIZE(cg->cmux))
+			goto bad_args;
+		clk = cg->cmux[idx];
+		break;
+	case 2:
+		if (idx >= ARRAY_SIZE(cg->hwaccel))
+			goto bad_args;
+		clk = cg->hwaccel[idx];
+		break;
+	case 3:
+		if (idx >= ARRAY_SIZE(cg->fman))
+			goto bad_args;
+		clk = cg->fman[idx];
+		break;
+	case 4:
+		pll = &cg->pll[PLATFORM_PLL];
+		if (idx >= ARRAY_SIZE(pll->div))
+			goto bad_args;
+		clk = pll->div[idx].clk;
+		break;
+	default:
+		goto bad_args;
+	}
+
+	if (!clk)
+		return ERR_PTR(-ENOENT);
+	return clk;
+
+bad_args:
+	pr_err("%s: Bad phandle args %u %u\n", __func__, type, idx);
+	return ERR_PTR(-EINVAL);
+}
+
 #ifdef CONFIG_PPC
 #include <asm/mpc85xx.h>
 
@@ -982,7 +1037,7 @@ static bool __init has_erratum_a4510(void)
 
 static void __init clockgen_init(struct device_node *np)
 {
-	int i;
+	int i, ret;
 
 	clockgen.node = np;
 	clockgen.regs = of_iomap(np, 0);
@@ -1028,6 +1083,12 @@ static void __init clockgen_init(struct device_node *np)
 	if (clockgen.info.init_periph)
 		clockgen.info.init_periph(&clockgen);
 
+	ret = of_clk_add_provider(np, clockgen_clk_get, &clockgen);
+	if (ret) {
+		pr_err("%s: Couldn't register clk provider for node %s: %d\n",
+		       __func__, np->name, ret);
+	}
+
 	return;
 err:
 	iounmap(clockgen.regs);
-- 
2.1.4
