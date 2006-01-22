Return-Path: <bcollins@ubuntu.com>
Date: Sat, 21 Jan 2006 23:40:48 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH] Enable irq's for platform functions.
To: Linuxppc-dev@ozlabs.org
Message-id: <1137904849.5871.11.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the platform function interrupt functions actually
work. Calls irq_enable() for the first in the list, and irq_disable()
for the last.

Added *func to struct irq_client so the the user can pass just that to
pmf_unregister_irq_client().

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index 76d037c..51b3601 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -869,21 +869,28 @@ int pmf_register_irq_client(struct devic
 		spin_unlock_irqrestore(&pmf_lock, flags);
 		return -ENODEV;
 	}
+	if (list_empty(&func->irq_clients))
+		func->dev->handlers->irq_enable(func);
 	list_add(&client->link, &func->irq_clients);
+	client->func = func;
 	spin_unlock_irqrestore(&pmf_lock, flags);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pmf_register_irq_client);
 
-void pmf_unregister_irq_client(struct device_node *np,
-			      const char *name,
-			      struct pmf_irq_client *client)
+void pmf_unregister_irq_client(struct pmf_irq_client *client)
 {
+	struct pmf_function *func = client->func;
 	unsigned long flags;
 
+	BUG_ON(func == NULL);
+
 	spin_lock_irqsave(&pmf_lock, flags);
+	client->func = NULL;
 	list_del(&client->link);
+	if (list_empty(&func->irq_clients))
+		func->dev->handlers->irq_disable(func);
 	spin_unlock_irqrestore(&pmf_lock, flags);
 }
 EXPORT_SYMBOL_GPL(pmf_unregister_irq_client);
diff --git a/include/asm-powerpc/pmac_pfunc.h b/include/asm-powerpc/pmac_pfunc.h
index d6d9a4d..e4594d5 100644
--- a/include/asm-powerpc/pmac_pfunc.h
+++ b/include/asm-powerpc/pmac_pfunc.h
@@ -168,6 +168,7 @@ struct pmf_irq_client {
 	void			*data;
 	struct module		*owner;
 	struct list_head	link;
+	struct pmf_function	*func;
 };
 
 
@@ -188,9 +189,7 @@ extern int pmf_register_irq_client(struc
 				   const char *name,
 				   struct pmf_irq_client *client);
 
-extern void pmf_unregister_irq_client(struct device_node *np,
-				      const char *name,
-				      struct pmf_irq_client *client);
+extern void pmf_unregister_irq_client(struct pmf_irq_client *client);
 
 /*
  * Called by the handlers when an irq happens


-- 
Ben Collins
Kernel Developer - Ubuntu Linux
