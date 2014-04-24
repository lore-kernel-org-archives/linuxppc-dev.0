Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23DBC140172
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:32 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 593B12BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dQHs55836906
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80SOO014914
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:28 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 11/25] powerpc/eeh: Cleanup EEH subsystem variables
Date: Thu, 24 Apr 2014 18:00:17 +1000
Message-Id: <1398326431-24305-12-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There're 2 EEH subsystem variables: eeh_subsystem_enabled and
eeh_probe_mode. We needn't maintain 2 variables and we can just
have one variable and introduce different flags. The patch also
introduces additional flag EEH_FORCE_DISABLE, which will be used
to disable EEH subsystem via boot parameter ("eeh=off") in future.
Besides, the patch also introduces flag EEH_ENABLED, which is
changed to disable or enable EEH functionality on the fly through
debugfs entry in future.

With the patch applied, the creteria to check the enabled EEH
functionality is changed to:

!EEH_FORCE_DISABLED && EEH_ENABLED : Enabled
                       Other cases : Disabled

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 29 +++++++++++++++++++----------
 arch/powerpc/kernel/eeh.c      | 31 +++++++++++++++----------------
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index f0183e3..f4a9321 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -32,6 +32,12 @@ struct device_node;
 
 #ifdef CONFIG_EEH
 
+/* EEH subsystem flags */
+#define EEH_ENABLED		0x1	/* EEH enabled		*/
+#define EEH_FORCE_DISABLED	0x2	/* EEH disabled		*/
+#define EEH_PROBE_MODE_DEV	0x4	/* From PCI device	*/
+#define EEH_PROBE_MODE_DEVTREE	0x8	/* From device tree	*/
+
 /*
  * The struct is used to trace PE related EEH functionality.
  * In theory, there will have one instance of the struct to
@@ -173,37 +179,40 @@ struct eeh_ops {
 	int (*restore_config)(struct device_node *dn);
 };
 
+extern int eeh_subsystem_flags;
 extern struct eeh_ops *eeh_ops;
-extern bool eeh_subsystem_enabled;
 extern raw_spinlock_t confirm_error_lock;
-extern int eeh_probe_mode;
 
 static inline bool eeh_enabled(void)
 {
-	return eeh_subsystem_enabled;
+	if ((eeh_subsystem_flags & EEH_FORCE_DISABLED) ||
+	    !(eeh_subsystem_flags & EEH_ENABLED))
+		return false;
+
+	return true;
 }
 
 static inline void eeh_set_enable(bool mode)
 {
-	eeh_subsystem_enabled = mode;
+	if (mode)
+		eeh_subsystem_flags |= EEH_ENABLED;
+	else
+		eeh_subsystem_flags &= ~EEH_ENABLED;
 }
 
-#define EEH_PROBE_MODE_DEV	(1<<0)	/* From PCI device	*/
-#define EEH_PROBE_MODE_DEVTREE	(1<<1)	/* From device tree	*/
-
 static inline void eeh_probe_mode_set(int flag)
 {
-	eeh_probe_mode = flag;
+	eeh_subsystem_flags |= flag;
 }
 
 static inline int eeh_probe_mode_devtree(void)
 {
-	return (eeh_probe_mode == EEH_PROBE_MODE_DEVTREE);
+	return (eeh_subsystem_flags & EEH_PROBE_MODE_DEVTREE);
 }
 
 static inline int eeh_probe_mode_dev(void)
 {
-	return (eeh_probe_mode == EEH_PROBE_MODE_DEV);
+	return (eeh_subsystem_flags & EEH_PROBE_MODE_DEV);
 }
 
 static inline void eeh_serialize_lock(unsigned long *flags)
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 69df898..06d2b7c 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -87,22 +87,21 @@
 /* Time to wait for a PCI slot to report status, in milliseconds */
 #define PCI_BUS_RESET_WAIT_MSEC (5*60*1000)
 
-/* Platform dependent EEH operations */
-struct eeh_ops *eeh_ops = NULL;
-
-bool eeh_subsystem_enabled = false;
-EXPORT_SYMBOL(eeh_subsystem_enabled);
-
 /*
- * EEH probe mode support. The intention is to support multiple
- * platforms for EEH. Some platforms like pSeries do PCI emunation
- * based on device tree. However, other platforms like powernv probe
- * PCI devices from hardware. The flag is used to distinguish that.
- * In addition, struct eeh_ops::probe would be invoked for particular
- * OF node or PCI device so that the corresponding PE would be created
- * there.
+ * EEH probe mode support, which is part of the flags,
+ * is to support multiple platforms for EEH. Some platforms
+ * like pSeries do PCI emunation based on device tree.
+ * However, other platforms like powernv probe PCI devices
+ * from hardware. The flag is used to distinguish that.
+ * In addition, struct eeh_ops::probe would be invoked for
+ * particular OF node or PCI device so that the corresponding
+ * PE would be created there.
  */
-int eeh_probe_mode;
+int eeh_subsystem_flags;
+EXPORT_SYMBOL(eeh_subsystem_flags);
+
+/* Platform dependent EEH operations */
+struct eeh_ops *eeh_ops = NULL;
 
 /* Lock to avoid races due to multiple reports of an error */
 DEFINE_RAW_SPINLOCK(confirm_error_lock);
@@ -842,8 +841,8 @@ int eeh_init(void)
 			&hose_list, list_node)
 			pci_walk_bus(hose->bus, eeh_ops->dev_probe, NULL);
 	} else {
-		pr_warning("%s: Invalid probe mode %d\n",
-			   __func__, eeh_probe_mode);
+		pr_warn("%s: Invalid probe mode %x",
+			__func__, eeh_subsystem_flags);
 		return -EINVAL;
 	}
 
-- 
1.8.3.2
