Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCpP03c82zDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 14:23:16 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v113IwQT137743
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 22:23:14 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ab00efka-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 22:23:14 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 1 Feb 2017 13:23:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B1ED13578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 14:23:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v113N0UR29425908
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 14:23:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v113Ma7B002279
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 14:22:36 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: [PATCH v2] cxl: fix build when CONFIG_DEBUG_FS=n
Date: Wed,  1 Feb 2017 14:22:07 +1100
Message-Id: <20170201032207.14940-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stub out the debugfs functions so that the build doesn't break when
CONFIG_DEBUG_FS=n.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

v1->v2:
- use inline stubs in cxl.h instead of normal functions

---
 drivers/misc/cxl/Makefile |  3 ++-
 drivers/misc/cxl/cxl.h    | 59 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 56e9a4732ef0..c14fd6b65b5a 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -2,9 +2,10 @@ ccflags-y			:= $(call cc-disable-warning, unused-const-variable)
 ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
-cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
+cxl-y				+= context.o sysfs.o pci.o trace.o
 cxl-y				+= vphb.o phb.o api.o
 cxl-$(CONFIG_PPC_PSERIES)	+= flash.o guest.o of.o hcalls.o
+cxl-$(CONFIG_DEBUG_FS)		+= debugfs.o
 obj-$(CONFIG_CXL)		+= cxl.o
 obj-$(CONFIG_CXL_BASE)		+= base.o
 
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b24d76723fb0..76591138faa5 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -800,12 +800,67 @@ int afu_register_irqs(struct cxl_context *ctx, u32 count);
 void afu_release_irqs(struct cxl_context *ctx, void *cookie);
 void afu_irq_name_free(struct cxl_context *ctx);
 
+#ifdef CONFIG_DEBUG_FS
+
 int cxl_debugfs_init(void);
 void cxl_debugfs_exit(void);
 int cxl_debugfs_adapter_add(struct cxl *adapter);
 void cxl_debugfs_adapter_remove(struct cxl *adapter);
 int cxl_debugfs_afu_add(struct cxl_afu *afu);
 void cxl_debugfs_afu_remove(struct cxl_afu *afu);
+void cxl_stop_trace(struct cxl *cxl);
+void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir);
+void cxl_debugfs_add_adapter_xsl_regs(struct cxl *adapter, struct dentry *dir);
+void cxl_debugfs_add_afu_psl_regs(struct cxl_afu *afu, struct dentry *dir);
+
+#else /* CONFIG_DEBUG_FS */
+
+static inline int __init cxl_debugfs_init(void)
+{
+	return 0;
+}
+
+static inline void cxl_debugfs_exit(void)
+{
+}
+
+static inline int cxl_debugfs_adapter_add(struct cxl *adapter)
+{
+	return 0;
+}
+
+static inline void cxl_debugfs_adapter_remove(struct cxl *adapter)
+{
+}
+
+static inline int cxl_debugfs_afu_add(struct cxl_afu *afu)
+{
+	return 0;
+}
+
+static inline void cxl_debugfs_afu_remove(struct cxl_afu *afu)
+{
+}
+
+static inline void cxl_stop_trace(struct cxl *cxl)
+{
+}
+
+static inline void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter,
+						    struct dentry *dir)
+{
+}
+
+static inline void cxl_debugfs_add_adapter_xsl_regs(struct cxl *adapter,
+						    struct dentry *dir)
+{
+}
+
+static inline void cxl_debugfs_add_afu_psl_regs(struct cxl_afu *afu, struct dentry *dir)
+{
+}
+
+#endif /* CONFIG_DEBUG_FS */
 
 void cxl_handle_fault(struct work_struct *work);
 void cxl_prefault(struct cxl_context *ctx, u64 wed);
@@ -870,12 +925,8 @@ int cxl_data_cache_flush(struct cxl *adapter);
 int cxl_afu_disable(struct cxl_afu *afu);
 int cxl_psl_purge(struct cxl_afu *afu);
 
-void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir);
-void cxl_debugfs_add_adapter_xsl_regs(struct cxl *adapter, struct dentry *dir);
-void cxl_debugfs_add_afu_psl_regs(struct cxl_afu *afu, struct dentry *dir);
 void cxl_native_psl_irq_dump_regs(struct cxl_context *ctx);
 void cxl_native_err_irq_dump_regs(struct cxl *adapter);
-void cxl_stop_trace(struct cxl *cxl);
 int cxl_pci_vphb_add(struct cxl_afu *afu);
 void cxl_pci_vphb_remove(struct cxl_afu *afu);
 void cxl_release_mapping(struct cxl_context *ctx);
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
