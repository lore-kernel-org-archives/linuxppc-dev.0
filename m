Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2502767B20
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 10:59:48 +1000 (EST)
Subject: Re: pmf_register_irq_client gives sleep with locks held warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1149020341.5128.7.camel@johannes>
References: <1149020341.5128.7.camel@johannes>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 10:59:34 +1000
Message-Id: <1149123574.15446.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-30 at 22:19 +0200, Johannes Berg wrote:
> Hi,
> 
> When testing headphone detection stuff I got this:
> 
> [  634.218762] BUG: sleeping function called from invalid context at mm/slab.c:2794
> [  634.218774] in_atomic():0, irqs_disabled():1
> [  634.218777] Call Trace:
> [  634.218779] [D67ADC00] [C00085F8] show_stack+0x50/0x190 (unreliable)
> [  634.218794] [D67ADC30] [C0024030] __might_sleep+0xcc/0xe8
> [  634.218804] [D67ADC40] [C0076C04] __kmalloc+0xf4/0xf8
> [  634.218815] [D67ADC60] [C00B37D4] proc_create+0x9c/0xe8
> [  634.218827] [D67ADC90] [C00B3930] proc_mkdir_mode+0x2c/0x88
> [  634.218833] [D67ADCB0] [C005227C] register_handler_proc+0xe4/0xfc
> [  634.218844] [D67ADD50] [C0051D70] setup_irq+0x118/0x16c
> [  634.218850] [D67ADD70] [C0051E68] request_irq+0xa4/0xb8
> [  634.218855] [D67ADDA0] [C0020BA0] macio_do_gpio_irq_enable+0x40/0x50
> [  634.218860] [D67ADDB0] [C00208BC] pmf_register_irq_client+0x88/0x9c
> [..., not important]

That's a bug in the PowerMac PMF code. What about this patch ?

This fixes request_irq() potentially called from atomic context.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/pfunc_core.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pfunc_core.c	2006-04-19 15:04:38.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/pfunc_core.c	2006-06-01 10:58:57.000000000 +1000
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 
 #include <asm/semaphore.h>
 #include <asm/prom.h>
@@ -546,6 +547,7 @@
 
 static LIST_HEAD(pmf_devices);
 static spinlock_t pmf_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_MUTEX(pmf_irq_mutex);
 
 static void pmf_release_device(struct kref *kref)
 {
@@ -864,15 +866,17 @@
 
 	spin_lock_irqsave(&pmf_lock, flags);
 	func = __pmf_find_function(target, name, PMF_FLAGS_INT_GEN);
-	if (func == NULL) {
-		spin_unlock_irqrestore(&pmf_lock, flags);
+	if (func)
+		func = pmf_get_function(func);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+	if (func == NULL)
 		return -ENODEV;
-	}
+	mutex_lock(&pmf_irq_mutex);
 	if (list_empty(&func->irq_clients))
 		func->dev->handlers->irq_enable(func);
 	list_add(&client->link, &func->irq_clients);
 	client->func = func;
-	spin_unlock_irqrestore(&pmf_lock, flags);
+	mutex_unlock(&pmf_irq_mutex);
 
 	return 0;
 }
@@ -881,16 +885,16 @@
 void pmf_unregister_irq_client(struct pmf_irq_client *client)
 {
 	struct pmf_function *func = client->func;
-	unsigned long flags;
 
 	BUG_ON(func == NULL);
 
-	spin_lock_irqsave(&pmf_lock, flags);
+	mutex_lock(&pmf_irq_mutex);
 	client->func = NULL;
 	list_del(&client->link);
 	if (list_empty(&func->irq_clients))
 		func->dev->handlers->irq_disable(func);
-	spin_unlock_irqrestore(&pmf_lock, flags);
+	mutex_unlock(&pmf_irq_mutex);
+	pmf_put_function(func);
 }
 EXPORT_SYMBOL_GPL(pmf_unregister_irq_client);
 
