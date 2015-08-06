Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C5941A0884
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7DDBA2BB0066
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D6nX22347988
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764Cc0m001316
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:41 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 41/42] drivers/of: Export OF changeset functions
Date: Thu,  6 Aug 2015 14:11:46 +1000
Message-Id: <1438834307-26960-42-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PowerNV PCI hotplug driver is going to use the OF changeset
to manage the changed device sub-tree, which requires those OF
changeset functions are exported.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/dynamic.c  | 65 ++++++++++++++++++++++++++++++++++++---------------
 drivers/of/overlay.c  |  8 +++----
 drivers/of/unittest.c |  4 ++--
 include/linux/of.h    |  2 ++
 4 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 53826b8..af65b5b 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -646,6 +646,7 @@ void of_changeset_init(struct of_changeset *ocs)
 	memset(ocs, 0, sizeof(*ocs));
 	INIT_LIST_HEAD(&ocs->entries);
 }
+EXPORT_SYMBOL(of_changeset_init);
 
 /**
  * of_changeset_destroy - Destroy a changeset
@@ -662,20 +663,9 @@ void of_changeset_destroy(struct of_changeset *ocs)
 	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
 		__of_changeset_entry_destroy(ce);
 }
+EXPORT_SYMBOL(of_changeset_destroy);
 
-/**
- * of_changeset_apply - Applies a changeset
- *
- * @ocs:	changeset pointer
- *
- * Applies a changeset to the live tree.
- * Any side-effects of live tree state changes are applied here on
- * sucess, like creation/destruction of devices and side-effects
- * like creation of sysfs properties and directories.
- * Returns 0 on success, a negative error value in case of an error.
- * On error the partially applied effects are reverted.
- */
-int of_changeset_apply(struct of_changeset *ocs)
+int __of_changeset_apply(struct of_changeset *ocs)
 {
 	struct of_changeset_entry *ce;
 	int ret;
@@ -704,17 +694,30 @@ int of_changeset_apply(struct of_changeset *ocs)
 }
 
 /**
- * of_changeset_revert - Reverts an applied changeset
+ * of_changeset_apply - Applies a changeset
  *
  * @ocs:	changeset pointer
  *
- * Reverts a changeset returning the state of the tree to what it
- * was before the application.
- * Any side-effects like creation/destruction of devices and
- * removal of sysfs properties and directories are applied.
+ * Applies a changeset to the live tree.
+ * Any side-effects of live tree state changes are applied here on
+ * sucess, like creation/destruction of devices and side-effects
+ * like creation of sysfs properties and directories.
  * Returns 0 on success, a negative error value in case of an error.
+ * On error the partially applied effects are reverted.
  */
-int of_changeset_revert(struct of_changeset *ocs)
+int of_changeset_apply(struct of_changeset *ocs)
+{
+	int ret;
+
+	mutex_lock(&of_mutex);
+	ret = __of_changeset_apply(ocs);
+	mutex_unlock(&of_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(of_changeset_apply);
+
+int __of_changeset_revert(struct of_changeset *ocs)
 {
 	struct of_changeset_entry *ce;
 	int ret;
@@ -742,6 +745,29 @@ int of_changeset_revert(struct of_changeset *ocs)
 }
 
 /**
+ * of_changeset_revert - Reverts an applied changeset
+ *
+ * @ocs:	changeset pointer
+ *
+ * Reverts a changeset returning the state of the tree to what it
+ * was before the application.
+ * Any side-effects like creation/destruction of devices and
+ * removal of sysfs properties and directories are applied.
+ * Returns 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_revert(struct of_changeset *ocs)
+{
+	int ret;
+
+	mutex_lock(&of_mutex);
+	ret = __of_changeset_revert(ocs);
+	mutex_unlock(&of_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(of_changeset_revert);
+
+/**
  * of_changeset_action - Perform a changeset action
  *
  * @ocs:	changeset pointer
@@ -779,3 +805,4 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	list_add_tail(&ce->node, &ocs->entries);
 	return 0;
 }
+EXPORT_SYMBOL(of_changeset_action);
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 24e025f..804ea33 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -378,9 +378,9 @@ int of_overlay_create(struct device_node *tree)
 	}
 
 	/* apply the changeset */
-	err = of_changeset_apply(&ov->cset);
+	err = __of_changeset_apply(&ov->cset);
 	if (err) {
-		pr_err("%s: of_changeset_apply() failed for tree@%s\n",
+		pr_err("%s: __of_changeset_apply() failed for tree@%s\n",
 				__func__, tree->full_name);
 		goto err_revert_overlay;
 	}
@@ -508,7 +508,7 @@ int of_overlay_destroy(int id)
 
 
 	list_del(&ov->node);
-	of_changeset_revert(&ov->cset);
+	__of_changeset_revert(&ov->cset);
 	of_free_overlay_info(ov);
 	idr_remove(&ov_idr, id);
 	of_changeset_destroy(&ov->cset);
@@ -539,7 +539,7 @@ int of_overlay_destroy_all(void)
 	/* the tail of list is guaranteed to be safe to remove */
 	list_for_each_entry_safe_reverse(ov, ovn, &ov_list, node) {
 		list_del(&ov->node);
-		of_changeset_revert(&ov->cset);
+		__of_changeset_revert(&ov->cset);
 		of_free_overlay_info(ov);
 		idr_remove(&ov_idr, ov->id);
 		kfree(ov);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 2270830..06eb3e5 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -527,7 +527,7 @@ static void __init of_unittest_changeset(void)
 	unittest(!of_changeset_update_property(&chgset, parent, ppupdate), "fail update prop\n");
 	unittest(!of_changeset_remove_property(&chgset, parent, ppremove), "fail remove prop\n");
 	mutex_lock(&of_mutex);
-	unittest(!of_changeset_apply(&chgset), "apply failed\n");
+	unittest(!__of_changeset_apply(&chgset), "apply failed\n");
 	mutex_unlock(&of_mutex);
 
 	/* Make sure node names are constructed correctly */
@@ -536,7 +536,7 @@ static void __init of_unittest_changeset(void)
 	of_node_put(np);
 
 	mutex_lock(&of_mutex);
-	unittest(!of_changeset_revert(&chgset), "revert failed\n");
+	unittest(!__of_changeset_revert(&chgset), "revert failed\n");
 	mutex_unlock(&of_mutex);
 
 	of_changeset_destroy(&chgset);
diff --git a/include/linux/of.h b/include/linux/of.h
index edc068d..5c030e1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1001,7 +1001,9 @@ extern int of_reconfig_get_state_change(unsigned long action,
 
 extern void of_changeset_init(struct of_changeset *ocs);
 extern void of_changeset_destroy(struct of_changeset *ocs);
+extern int __of_changeset_apply(struct of_changeset *ocs);
 extern int of_changeset_apply(struct of_changeset *ocs);
+extern int __of_changeset_revert(struct of_changeset *ocs);
 extern int of_changeset_revert(struct of_changeset *ocs);
 extern int of_changeset_action(struct of_changeset *ocs,
 		unsigned long action, struct device_node *np,
-- 
2.1.0
