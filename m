Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B94E01A06C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:39 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/20] powerpc/85xx/sgy_cts1000: Use pm_power_off rather
 than ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:15 +0200
Message-Id: <1413208888-49211-8-git-send-email-agraf@suse.de>
In-Reply-To: <1413208888-49211-1-git-send-email-agraf@suse.de>
References: <1413208888-49211-1-git-send-email-agraf@suse.de>
Cc: arnd@arndb.de, geoff@infradead.org, alistair@popple.id.au,
 scottwood@freescale.com, agust@denx.de, linux@roeck-us.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic power off callback is pm_power_off. Use that one rather than
the powerpc specific ppc_md.power_off.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/platforms/85xx/sgy_cts1000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index 8162b04..e149c9e 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -120,7 +120,7 @@ static int gpio_halt_probe(struct platform_device *pdev)
 
 	/* Register our halt function */
 	ppc_md.halt = gpio_halt_cb;
-	ppc_md.power_off = gpio_halt_cb;
+	pm_power_off = gpio_halt_cb;
 
 	printk(KERN_INFO "gpio-halt: registered GPIO %d (%d trigger, %d"
 	       " irq).\n", gpio, trigger, irq);
@@ -137,7 +137,7 @@ static int gpio_halt_remove(struct platform_device *pdev)
 		free_irq(irq, halt_node);
 
 		ppc_md.halt = NULL;
-		ppc_md.power_off = NULL;
+		pm_power_off = NULL;
 
 		gpio_free(gpio);
 
-- 
1.8.1.4
