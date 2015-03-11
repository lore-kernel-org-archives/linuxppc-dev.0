Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D6ED1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 17:35:15 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2BF89140172
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2015 17:35:15 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 16:35:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5C4362CE8050
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2015 17:35:10 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B6Z2sg51511544
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2015 17:35:10 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B6YaLU031608
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2015 17:34:37 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/eeh: Introduce eeh_pe_inject_err()
Date: Wed, 11 Mar 2015 17:34:10 +1100
Message-Id: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 agraf@suse.de, alex.williamson@redhat.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch defines PCI error types and functions in eeh.h and
exports function eeh_pe_inject_err(), which will be called by
VFIO driver to inject the specified PCI error to the indicated
PE for testing purpose.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 24 ++++++++++++++++
 arch/powerpc/kernel/eeh.c      | 63 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 9de87ce..eb20c62 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -196,6 +196,28 @@ enum {
 #define EEH_RESET_COMPLETE	4	/* PHB complete reset		*/
 #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
 #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
+#define EEH_ERR_TYPE_32		0	/* 32-bits PCI error	*/
+#define EEH_ERR_TYPE_64		1	/* 64-bits PCI error	*/
+#define EEH_ERR_FUNC_LD_MEM_ADDR	0	/* Memory load	*/
+#define EEH_ERR_FUNC_LD_MEM_DATA	1
+#define EEH_ERR_FUNC_LD_IO_ADDR		2	/* IO load	*/
+#define EEH_ERR_FUNC_LD_IO_DATA		3
+#define EEH_ERR_FUNC_LD_CFG_ADDR	4	/* Config load	*/
+#define EEH_ERR_FUNC_LD_CFG_DATA	5
+#define EEH_ERR_FUNC_ST_MEM_ADDR	6	/* Memory store	*/
+#define EEH_ERR_FUNC_ST_MEM_DATA	7
+#define EEH_ERR_FUNC_ST_IO_ADDR		8	/* IO store	*/
+#define EEH_ERR_FUNC_ST_IO_DATA		9
+#define EEH_ERR_FUNC_ST_CFG_ADDR	10	/* Config store	*/
+#define EEH_ERR_FUNC_ST_CFG_DATA	11
+#define EEH_ERR_FUNC_DMA_RD_ADDR	12	/* DMA read	*/
+#define EEH_ERR_FUNC_DMA_RD_DATA	13
+#define EEH_ERR_FUNC_DMA_RD_MASTER	14
+#define EEH_ERR_FUNC_DMA_RD_TARGET	15
+#define EEH_ERR_FUNC_DMA_WR_ADDR	16	/* DMA write	*/
+#define EEH_ERR_FUNC_DMA_WR_DATA	17
+#define EEH_ERR_FUNC_DMA_WR_MASTER	18
+#define EEH_ERR_FUNC_DMA_WR_TARGET	19
 
 struct eeh_ops {
 	char *name;
@@ -296,6 +318,8 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option);
 int eeh_pe_get_state(struct eeh_pe *pe);
 int eeh_pe_reset(struct eeh_pe *pe, int option);
 int eeh_pe_configure(struct eeh_pe *pe);
+int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
+		      unsigned long addr, unsigned long mask);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 60a0f15ce..dbab1a4 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1657,6 +1657,69 @@ int eeh_pe_configure(struct eeh_pe *pe)
 }
 EXPORT_SYMBOL_GPL(eeh_pe_configure);
 
+/**
+ * eeh_pe_inject_err - Injecting the specified PCI error to the indicated PE
+ * @pe: the indicated PE
+ * @type: error type
+ * @function: error function
+ * @addr: address
+ * @mask: address mask
+ *
+ * The routine is called to inject the specified PCI error, which
+ * is determined by @type and @function, to the indicated PE for
+ * testing purpose.
+ */
+int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
+		      unsigned long addr, unsigned long mask)
+{
+	/* Invalid PE ? */
+	if (!pe)
+		return -ENODEV;
+
+	/* Unsupported operation ? */
+	if (!eeh_ops || !eeh_ops->err_inject)
+		return -ENOENT;
+
+	/* Check on PCI error type */
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+	case EEH_ERR_TYPE_64:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check on PCI error function */
+	switch (func) {
+	case EEH_ERR_FUNC_LD_MEM_ADDR:
+	case EEH_ERR_FUNC_LD_MEM_DATA:
+	case EEH_ERR_FUNC_LD_IO_ADDR:
+	case EEH_ERR_FUNC_LD_IO_DATA:
+	case EEH_ERR_FUNC_LD_CFG_ADDR:
+	case EEH_ERR_FUNC_LD_CFG_DATA:
+	case EEH_ERR_FUNC_ST_MEM_ADDR:
+	case EEH_ERR_FUNC_ST_MEM_DATA:
+	case EEH_ERR_FUNC_ST_IO_ADDR:
+	case EEH_ERR_FUNC_ST_IO_DATA:
+	case EEH_ERR_FUNC_ST_CFG_ADDR:
+	case EEH_ERR_FUNC_ST_CFG_DATA:
+	case EEH_ERR_FUNC_DMA_RD_ADDR:
+	case EEH_ERR_FUNC_DMA_RD_DATA:
+	case EEH_ERR_FUNC_DMA_RD_MASTER:
+	case EEH_ERR_FUNC_DMA_RD_TARGET:
+	case EEH_ERR_FUNC_DMA_WR_ADDR:
+	case EEH_ERR_FUNC_DMA_WR_DATA:
+	case EEH_ERR_FUNC_DMA_WR_MASTER:
+	case EEH_ERR_FUNC_DMA_WR_TARGET:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return eeh_ops->err_inject(pe, type, func, addr, mask);
+}
+EXPORT_SYMBOL_GPL(eeh_pe_inject_err);
+
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	if (!eeh_enabled()) {
-- 
1.8.3.2
