Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23FC4B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jun 2011 23:34:37 +1000 (EST)
Received: by pzk37 with SMTP id 37so4729057pzk.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jun 2011 06:34:34 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: introduce pSeries_reconfig_notify()
Date: Tue, 21 Jun 2011 22:35:55 +0900
Message-Id: <1308663356-20957-1-git-send-email-akinobu.mita@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This introduces pSeries_reconfig_notify() as a just wrapper of
blocking_notifier_call_chain() for pSeries_reconfig_chain.

This is a preparation to improvement of error code on reconfiguration
notifier failure.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/pSeries_reconfig.h |    2 +-
 arch/powerpc/platforms/pseries/dlpar.c      |   10 +++-----
 arch/powerpc/platforms/pseries/reconfig.c   |   30 ++++++++++++++++----------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/pSeries_reconfig.h b/arch/powerpc/include/asm/pSeries_reconfig.h
index 89d2f99..23cd6cc 100644
--- a/arch/powerpc/include/asm/pSeries_reconfig.h
+++ b/arch/powerpc/include/asm/pSeries_reconfig.h
@@ -17,7 +17,7 @@
 #ifdef CONFIG_PPC_PSERIES
 extern int pSeries_reconfig_notifier_register(struct notifier_block *);
 extern void pSeries_reconfig_notifier_unregister(struct notifier_block *);
-extern struct blocking_notifier_head pSeries_reconfig_chain;
+extern int pSeries_reconfig_notify(unsigned long action, void *p);
 /* Not the best place to put this, will be fixed when we move some
  * of the rtas suspend-me stuff to pseries */
 extern void pSeries_coalesce_init(void);
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 57ceb92..e9be25b 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -262,12 +262,11 @@ int dlpar_attach_node(struct device_node *dn)
 	if (!dn->parent)
 		return -ENOMEM;
 
-	rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
-					  PSERIES_RECONFIG_ADD, dn);
-	if (rc == NOTIFY_BAD) {
+	rc = pSeries_reconfig_notify(PSERIES_RECONFIG_ADD, dn);
+	if (rc) {
 		printk(KERN_ERR "Failed to add device node %s\n",
 		       dn->full_name);
-		return -ENOMEM; /* For now, safe to assume kmalloc failure */
+		return rc;
 	}
 
 	of_attach_node(dn);
@@ -297,8 +296,7 @@ int dlpar_detach_node(struct device_node *dn)
 		remove_proc_entry(dn->pde->name, parent->pde);
 #endif
 
-	blocking_notifier_call_chain(&pSeries_reconfig_chain,
-			    PSERIES_RECONFIG_REMOVE, dn);
+	pSeries_reconfig_notify(PSERIES_RECONFIG_REMOVE, dn);
 	of_detach_node(dn);
 	of_node_put(dn); /* Must decrement the refcount */
 
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 1de2cbb..286b6af 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -97,7 +97,7 @@ static struct device_node *derive_parent(const char *path)
 	return parent;
 }
 
-BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);
+static BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);
 
 int pSeries_reconfig_notifier_register(struct notifier_block *nb)
 {
@@ -109,6 +109,16 @@ void pSeries_reconfig_notifier_unregister(struct notifier_block *nb)
 	blocking_notifier_chain_unregister(&pSeries_reconfig_chain, nb);
 }
 
+int pSeries_reconfig_notify(unsigned long action, void *p)
+{
+	int err = blocking_notifier_call_chain(&pSeries_reconfig_chain,
+						action, p);
+
+	if (err == NOTIFY_BAD)
+		return -ENOMEM; /* For now, safe to assume kmalloc failure */
+	return 0;
+}
+
 static int pSeries_reconfig_add_node(const char *path, struct property *proplist)
 {
 	struct device_node *np;
@@ -132,11 +142,9 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
 		goto out_err;
 	}
 
-	err = blocking_notifier_call_chain(&pSeries_reconfig_chain,
-				  PSERIES_RECONFIG_ADD, np);
-	if (err == NOTIFY_BAD) {
+	err = pSeries_reconfig_notify(PSERIES_RECONFIG_ADD, np);
+	if (err) {
 		printk(KERN_ERR "Failed to add device node %s\n", path);
-		err = -ENOMEM; /* For now, safe to assume kmalloc failure */
 		goto out_err;
 	}
 
@@ -173,8 +181,7 @@ static int pSeries_reconfig_remove_node(struct device_node *np)
 
 	remove_node_proc_entries(np);
 
-	blocking_notifier_call_chain(&pSeries_reconfig_chain,
-			    PSERIES_RECONFIG_REMOVE, np);
+	pSeries_reconfig_notify(PSERIES_RECONFIG_REMOVE, np);
 	of_detach_node(np);
 
 	of_node_put(parent);
@@ -472,11 +479,10 @@ static int do_update_property(char *buf, size_t bufsize)
 		else
 			action = PSERIES_DRCONF_MEM_REMOVE;
 
-		rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
-						  action, value);
-		if (rc == NOTIFY_BAD) {
-			rc = prom_update_property(np, oldprop, newprop);
-			return -ENOMEM;
+		rc = pSeries_reconfig_notify(action, value);
+		if (rc) {
+			prom_update_property(np, oldprop, newprop);
+			return rc;
 		}
 	}
 
-- 
1.7.4.4
