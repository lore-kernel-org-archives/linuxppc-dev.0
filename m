Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48DDB1A0C33
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 19:56:11 +1100 (AEDT)
Received: by mail-pa0-f42.google.com with SMTP id et14so15339477pad.15
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2014 00:56:09 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/3] powerpc: call of_clk_init() from time_init()
Date: Wed,  3 Dec 2014 16:53:52 +0800
Message-Id: <1417596833-31456-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So the boards which has COMMON_CLK enabled don't have to
invoke this in its board specific file.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Scott Wood <scottwood@freescale.com>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
v3: Add ack.

v2: A new patch in v2.

 arch/powerpc/kernel/time.c                    |  5 +++++
 arch/powerpc/platforms/512x/clock-commonclk.c | 11 +++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index fa7c4f12104f..df9fa05b5fd3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -54,6 +54,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
+#include <linux/clk-provider.h>
 #include <asm/trace.h>
 
 #include <asm/io.h>
@@ -943,6 +944,10 @@ void __init time_init(void)
 
 	init_decrementer_clockevent();
 	tick_setup_hrtimer_broadcast();
+
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#endif
 }
 
 
diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 6eb614a271fb..f691bcabd710 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -1168,6 +1168,11 @@ static void mpc5121_clk_provide_backwards_compat(void)
 	}
 }
 
+/*
+ * The "fixed-clock" nodes (which includes the oscillator node if the board's
+ * DT provides one) has already been scanned by the of_clk_init() in
+ * time_init().
+ */
 int __init mpc5121_clk_init(void)
 {
 	struct device_node *clk_np;
@@ -1187,12 +1192,6 @@ int __init mpc5121_clk_init(void)
 	mpc512x_clk_preset_data();
 
 	/*
-	 * have the device tree scanned for "fixed-clock" nodes (which
-	 * includes the oscillator node if the board's DT provides one)
-	 */
-	of_clk_init(NULL);
-
-	/*
 	 * add a dummy clock for those situations where a clock spec is
 	 * required yet no real clock is involved
 	 */
-- 
1.9.3
