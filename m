Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Wed, 09 Apr 2008 17:21:36 +1000
Subject: [PATCH 6/6] [POWERPC] Fix device-tree locking vs. interrupts
Message-Id: <20080409072233.45667DDF19@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Lockdep found out that we can occasionally take the device-tree
lock for reading from softirq time (from rtas_token called
by the rtas real time clock code called by the NTP code),
while we take it occasionally for writing without masking
interrupts. The combination of those two can thus deadlock.

While some of those cases of interrupt read lock could be fixed
(such as caching the RTAS tokens) I figured that taking the
lock for writing is so rare (device-tree modification) that we
may as well penalize that case and allow reading from interrupts.

Thus, this turns all the writers to take the lock with irqs
masked to avoid the situation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/prom.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/prom.c	2008-04-09 14:23:18.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom.c	2008-04-09 14:25:48.000000000 +1000
@@ -1244,12 +1244,14 @@ EXPORT_SYMBOL(of_node_put);
  */
 void of_attach_node(struct device_node *np)
 {
-	write_lock(&devtree_lock);
+	unsigned long flags;
+
+	write_lock_irqsave(&devtree_lock, flags);
 	np->sibling = np->parent->child;
 	np->allnext = allnodes;
 	np->parent->child = np;
 	allnodes = np;
-	write_unlock(&devtree_lock);
+	write_unlock_irqrestore(&devtree_lock, flags);
 }
 
 /*
@@ -1260,8 +1262,9 @@ void of_attach_node(struct device_node *
 void of_detach_node(struct device_node *np)
 {
 	struct device_node *parent;
+	unsigned long flags;
 
-	write_lock(&devtree_lock);
+	write_lock_irqsave(&devtree_lock, flags);
 
 	parent = np->parent;
 	if (!parent)
@@ -1292,7 +1295,7 @@ void of_detach_node(struct device_node *
 	of_node_set_flag(np, OF_DETACHED);
 
 out_unlock:
-	write_unlock(&devtree_lock);
+	write_unlock_irqrestore(&devtree_lock, flags);
 }
 
 #ifdef CONFIG_PPC_PSERIES
@@ -1373,20 +1376,21 @@ __initcall(prom_reconfig_setup);
 int prom_add_property(struct device_node* np, struct property* prop)
 {
 	struct property **next;
+	unsigned long flags;
 
 	prop->next = NULL;	
-	write_lock(&devtree_lock);
+	write_lock_irqsave(&devtree_lock, flags);
 	next = &np->properties;
 	while (*next) {
 		if (strcmp(prop->name, (*next)->name) == 0) {
 			/* duplicate ! don't insert it */
-			write_unlock(&devtree_lock);
+			write_unlock_irqrestore(&devtree_lock, flags);
 			return -1;
 		}
 		next = &(*next)->next;
 	}
 	*next = prop;
-	write_unlock(&devtree_lock);
+	write_unlock_irqrestore(&devtree_lock, flags);
 
 #ifdef CONFIG_PROC_DEVICETREE
 	/* try to add to proc as well if it was initialized */
@@ -1406,9 +1410,10 @@ int prom_add_property(struct device_node
 int prom_remove_property(struct device_node *np, struct property *prop)
 {
 	struct property **next;
+	unsigned long flags;
 	int found = 0;
 
-	write_lock(&devtree_lock);
+	write_lock_irqsave(&devtree_lock, flags);
 	next = &np->properties;
 	while (*next) {
 		if (*next == prop) {
@@ -1421,7 +1426,7 @@ int prom_remove_property(struct device_n
 		}
 		next = &(*next)->next;
 	}
-	write_unlock(&devtree_lock);
+	write_unlock_irqrestore(&devtree_lock, flags);
 
 	if (!found)
 		return -ENODEV;
@@ -1447,9 +1452,10 @@ int prom_update_property(struct device_n
 			 struct property *oldprop)
 {
 	struct property **next;
+	unsigned long flags;
 	int found = 0;
 
-	write_lock(&devtree_lock);
+	write_lock_irqsave(&devtree_lock, flags);
 	next = &np->properties;
 	while (*next) {
 		if (*next == oldprop) {
@@ -1463,7 +1469,7 @@ int prom_update_property(struct device_n
 		}
 		next = &(*next)->next;
 	}
-	write_unlock(&devtree_lock);
+	write_unlock_irqrestore(&devtree_lock, flags);
 
 	if (!found)
 		return -ENODEV;
