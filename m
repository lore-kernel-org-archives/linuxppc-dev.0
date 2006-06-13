Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A7C467B2A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 02:06:06 +1000 (EST)
Subject: [PATCH] make pmf irq_client functions safe against pmf interrupts
	coming in
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1150192713.13958.52.camel@localhost.localdomain>
References: <1149020341.5128.7.camel@johannes>
	<1149123574.15446.15.camel@localhost.localdomain>
	<1149793098.11525.34.camel@johannes>
	<1149897784.12687.87.camel@localhost.localdomain>
	<1149931638.3864.34.camel@johannes.berg>
	<1149977097.12687.144.camel@localhost.localdomain>
	<1150188199.9208.7.camel@johannes>
	<1150192713.13958.52.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 17:43:42 +0200
Message-Id: <1150213423.6305.1.camel@johannes>
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

This fixes the pmf irq_client functions to be safe against pmf interrupts coming
in while a client is registered/unregistered.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/pfunc_core.c	2006-06-13 17:37:35.791076087 +0200
+++ linux-2.6-git/arch/powerpc/platforms/powermac/pfunc_core.c	2006-06-13 17:40:16.213632271 +0200
@@ -871,10 +871,17 @@ int pmf_register_irq_client(struct devic
 	spin_unlock_irqrestore(&pmf_lock, flags);
 	if (func == NULL)
 		return -ENODEV;
+
+	/* guard against manipulations of list */
 	mutex_lock(&pmf_irq_mutex);
 	if (list_empty(&func->irq_clients))
 		func->dev->handlers->irq_enable(func);
+
+	/* guard against pmf_do_irq while changing list */
+	spin_lock_irqsave(&pmf_lock, flags);
 	list_add(&client->link, &func->irq_clients);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+
 	client->func = func;
 	mutex_unlock(&pmf_irq_mutex);
 
@@ -885,12 +892,19 @@ EXPORT_SYMBOL_GPL(pmf_register_irq_clien
 void pmf_unregister_irq_client(struct pmf_irq_client *client)
 {
 	struct pmf_function *func = client->func;
+	unsigned long flags;
 
 	BUG_ON(func == NULL);
 
+	/* guard against manipulations of list */
 	mutex_lock(&pmf_irq_mutex);
 	client->func = NULL;
+
+	/* guard against pmf_do_irq while changing list */
+	spin_lock_irqsave(&pmf_lock, flags);
 	list_del(&client->link);
+	spin_unlock_irqrestore(&pmf_lock, flags);
+
 	if (list_empty(&func->irq_clients))
 		func->dev->handlers->irq_disable(func);
 	mutex_unlock(&pmf_irq_mutex);
