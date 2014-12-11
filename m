Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFD2C1A0A07
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 14:29:06 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 11 Dec 2014 08:59:02 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EC9EA1258053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 08:59:23 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBB3TaTl66846872
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 08:59:37 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBB3SxmS027074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 08:59:00 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/eeh: Allow to set maximal frozen times
Date: Thu, 11 Dec 2014 14:28:56 +1100
Message-Id: <1418268536-15002-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1418268536-15002-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1418268536-15002-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: grimm@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When PE's frozen count hits maximal allowed frozen times, which is
5 currently, it will be forced to be offline permanently. Once the
PE is removed permanently, rebooting machine is required to bring
the PE back. It's not convienent when testing EEH functionality.

The patch exports the maximal allowed frozen times through debugfs
entry (/sys/kernel/debug/powerpc/eeh_max_freezes).

Requested-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |  7 +------
 arch/powerpc/kernel/eeh.c        | 24 ++++++++++++++++++++++++
 arch/powerpc/kernel/eeh_driver.c |  2 +-
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 3e4dd34..55abfd0 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -218,6 +218,7 @@ struct eeh_ops {
 };
 
 extern int eeh_subsystem_flags;
+extern int eeh_max_freezes;
 extern struct eeh_ops *eeh_ops;
 extern raw_spinlock_t confirm_error_lock;
 
@@ -255,12 +256,6 @@ static inline void eeh_serialize_unlock(unsigned long flags)
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
 
-/*
- * Max number of EEH freezes allowed before we consider the device
- * to be permanently disabled.
- */
-#define EEH_MAX_ALLOWED_FREEZES 5
-
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 void eeh_set_pe_aux_size(int size);
 int eeh_phb_pe_create(struct pci_controller *phb);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 05be77d..cada1aa 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -104,6 +104,13 @@
 int eeh_subsystem_flags;
 EXPORT_SYMBOL(eeh_subsystem_flags);
 
+/*
+ * EEH allowed maximal frozen times. If one particular PE's
+ * frozen count in last hour exceeds this limit, the PE will
+ * be forced to be offline permanently.
+ */
+int eeh_max_freezes = 5;
+
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
 
@@ -1655,8 +1662,22 @@ static int eeh_enable_dbgfs_get(void *data, u64 *val)
 	return 0;
 }
 
+static int eeh_freeze_dbgfs_set(void *data, u64 val)
+{
+	eeh_max_freezes = val;
+	return 0;
+}
+
+static int eeh_freeze_dbgfs_get(void *data, u64 *val)
+{
+	*val = eeh_max_freezes;
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
 			eeh_enable_dbgfs_set, "0x%llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(eeh_freeze_dbgfs_ops, eeh_freeze_dbgfs_get,
+			eeh_freeze_dbgfs_set, "0x%llx\n");
 #endif
 
 static int __init eeh_init_proc(void)
@@ -1667,6 +1688,9 @@ static int __init eeh_init_proc(void)
 		debugfs_create_file("eeh_enable", 0600,
                                     powerpc_debugfs_root, NULL,
                                     &eeh_enable_dbgfs_ops);
+		debugfs_create_file("eeh_max_freezes", 0600,
+				    powerpc_debugfs_root, NULL,
+				    &eeh_freeze_dbgfs_ops);
 #endif
 	}
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index ac00672..d099540 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -667,7 +667,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 
 	eeh_pe_update_time_stamp(pe);
 	pe->freeze_count++;
-	if (pe->freeze_count > EEH_MAX_ALLOWED_FREEZES)
+	if (pe->freeze_count > eeh_max_freezes)
 		goto excess_failures;
 	pr_warn("EEH: This PCI device has failed %d times in the last hour\n",
 		pe->freeze_count);
-- 
1.8.3.2
