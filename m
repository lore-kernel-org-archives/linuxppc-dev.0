Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C5C41A0C8C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:55 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 91C0E2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDe9J31260914
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:48 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDL0a030447
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:22 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 49/50] drivers/of: Export OF changeset functions
Date: Thu,  5 Nov 2015 00:12:49 +1100
Message-Id: <1446642770-4681-50-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PowerNV PCI hotplug driver is going to use the OF changeset
to manage the changed device sub-tree. This exports those OF
changeset functions for that.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/dynamic.c    | 65 ++++++++++++++++++++++++++++++++++---------------
 drivers/of/of_private.h |  2 ++
 drivers/of/overlay.c    |  8 +++---
 drivers/of/unittest.c   |  4 ---
 4 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 53826b8..c647bd1 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -646,6 +646,7 @@ void of_changeset_init(struct of_changeset *ocs)
 	memset(ocs, 0, sizeof(*ocs));
 	INIT_LIST_HEAD(&ocs->entries);
 }
+EXPORT_SYMBOL_GPL(of_changeset_init);
 
 /**
  * of_changeset_destroy - Destroy a changeset
@@ -662,20 +663,9 @@ void of_changeset_destroy(struct of_changeset *ocs)
 	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
 		__of_changeset_entry_destroy(ce);
 }
+EXPORT_SYMBOL_GPL(of_changeset_destroy);
 
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
+ * success, like creation/destruction of devices and side-effects
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
+EXPORT_SYMBOL_GPL(of_changeset_apply);
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
+EXPORT_SYMBOL_GPL(of_changeset_revert);
+
+/**
  * of_changeset_action - Perform a changeset action
  *
  * @ocs:	changeset pointer
@@ -779,3 +805,4 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	list_add_tail(&ce->node, &ocs->entries);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(of_changeset_action);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 8e882e7..829469f 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -45,6 +45,8 @@ static inline struct device_node *kobj_to_device_node(struct kobject *kobj)
 extern int of_property_notify(int action, struct device_node *np,
 			      struct property *prop, struct property *old_prop);
 extern void of_node_release(struct kobject *kobj);
+extern int __of_changeset_apply(struct of_changeset *ocs);
+extern int __of_changeset_revert(struct of_changeset *ocs);
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_property_notify(int action, struct device_node *np,
 				     struct property *prop, struct property *old_prop)
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
index bafcf66..dad3fd2 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -526,18 +526,14 @@ static void __init of_unittest_changeset(void)
 	unittest(!of_changeset_add_property(&chgset, parent, ppadd), "fail add prop\n");
 	unittest(!of_changeset_update_property(&chgset, parent, ppupdate), "fail update prop\n");
 	unittest(!of_changeset_remove_property(&chgset, parent, ppremove), "fail remove prop\n");
-	mutex_lock(&of_mutex);
 	unittest(!of_changeset_apply(&chgset), "apply failed\n");
-	mutex_unlock(&of_mutex);
 
 	/* Make sure node names are constructed correctly */
 	unittest((np = of_find_node_by_path("/testcase-data/changeset/n2/n21")),
 		 "'%s' not added\n", n21->full_name);
 	of_node_put(np);
 
-	mutex_lock(&of_mutex);
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
-	mutex_unlock(&of_mutex);
 
 	of_changeset_destroy(&chgset);
 #endif
-- 
2.1.0
