Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 7FF02B6F06
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 05:00:54 +1100 (EST)
Date: Thu, 10 Dec 2009 21:00:53 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/83xx/suspend: Clear deep_sleeping after
	devices resume
Message-ID: <20091210180053.GA32482@oksana.dev.rtsoft.ru>
References: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently 83xx PMC driver clears deep_sleeping variable very early,
before devices are resumed. This makes fsl_deep_sleep() unusable in
drivers' resume() callback.

Sure, drivers can store fsl_deep_sleep() value on suspend and use
the stored value on resume. But a better solution is to postpone
clearing the deep_sleeping variable, i.e. move it into finish()
callback.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/83xx/suspend.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index d306f07..b0c2619 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -194,7 +194,7 @@ out:
 	return ret;
 }
 
-static void mpc83xx_suspend_finish(void)
+static void mpc83xx_suspend_end(void)
 {
 	deep_sleeping = 0;
 }
@@ -278,7 +278,7 @@ static struct platform_suspend_ops mpc83xx_suspend_ops = {
 	.valid = mpc83xx_suspend_valid,
 	.begin = mpc83xx_suspend_begin,
 	.enter = mpc83xx_suspend_enter,
-	.finish = mpc83xx_suspend_finish,
+	.end = mpc83xx_suspend_end,
 };
 
 static int pmc_probe(struct of_device *ofdev,
-- 
1.6.3.3
