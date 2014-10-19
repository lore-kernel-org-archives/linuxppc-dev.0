Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 760C81A1956
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Oct 2014 17:12:49 +1100 (AEDT)
Received: by mail-pd0-f182.google.com with SMTP id y10so3057456pdj.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 23:12:47 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] powerpc: call of_clk_init() from time_init()
Date: Sun, 19 Oct 2014 14:11:38 +0800
Message-Id: <1413699099-25743-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
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
---
A new patch in v2.

 arch/powerpc/kernel/time.c                    |  5 +++++
 arch/powerpc/platforms/512x/clock-commonclk.c | 11 +++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7505599c2593..8d3893e7564c 100644
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
