Return-Path: <dbaryshkov@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id C97E7B7D9C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 02:42:45 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1587822fga.3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 07:42:44 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 5/5] qe_gpio: port to new of gpio interface
Date: Tue, 17 Nov 2009 18:42:26 +0300
Message-Id: <1258472546-31343-6-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/sysdev/qe_lib/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
index 8e7a776..b85eab8 100644
--- a/arch/powerpc/sysdev/qe_lib/gpio.c
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -187,7 +187,7 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
 	if (err < 0)
 		goto err1;
 
-	mm_gc = to_of_mm_gpio_chip(&of_gc->gc);
+	mm_gc = to_of_mm_of_chip(of_gc);
 	qe_gc = to_qe_gpio_chip(mm_gc);
 
 	spin_lock_irqsave(&qe_gc->lock, flags);
@@ -319,7 +319,7 @@ static int __init qe_add_gpiochips(void)
 
 		mm_gc = &qe_gc->mm_gc;
 		of_gc = &mm_gc->of_gc;
-		gc = &of_gc->gc;
+		gc = &mm_gc->gc;
 
 		mm_gc->save_regs = qe_gpio_save_regs;
 		of_gc->gpio_cells = 2;
-- 
1.6.5
