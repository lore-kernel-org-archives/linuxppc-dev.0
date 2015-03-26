Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29CEB1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 16:43:24 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 068871400DD
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:24 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 15:43:23 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 963393578047
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:21 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2Q5hD9227787354
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2Q5gm13014601
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:42:48 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 2/3] powerpc/eeh: Introduce eeh_pe_inject_err()
Date: Thu, 26 Mar 2015 16:42:08 +1100
Message-Id: <1427348529-7060-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1427348529-7060-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1427348529-7060-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch defines PCI error types and functions in uapi/asm/eeh.h
and exports function eeh_pe_inject_err(), which will be called by
VFIO driver to inject the specified PCI error to the indicated
PE for testing purpose.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/eeh.h      |  2 ++
 arch/powerpc/include/uapi/asm/eeh.h | 26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh.c           | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 08c4042..cd6003b 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -291,6 +291,8 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option);
 int eeh_pe_get_state(struct eeh_pe *pe);
 int eeh_pe_reset(struct eeh_pe *pe, int option);
 int eeh_pe_configure(struct eeh_pe *pe);
+int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
+		      unsigned long addr, unsigned long mask);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
diff --git a/arch/powerpc/include/uapi/asm/eeh.h b/arch/powerpc/include/uapi/asm/eeh.h
index 8bb34b0..291b7d1 100644
--- a/arch/powerpc/include/uapi/asm/eeh.h
+++ b/arch/powerpc/include/uapi/asm/eeh.h
@@ -27,4 +27,30 @@
 #define EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only	*/
 #define EEH_PE_STATE_UNAVAIL		5	/* Unavailable		*/
 
+/* EEH error types and functions */
+#define EEH_ERR_TYPE_32			0       /* 32-bits error	*/
+#define EEH_ERR_TYPE_64			1       /* 64-bits error	*/
+#define EEH_ERR_FUNC_MIN		0
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
+#define EEH_ERR_FUNC_MAX		19
+
 #endif /* _ASM_POWERPC_EEH_H */
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 76253eb..daa68a1 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1636,6 +1636,41 @@ int eeh_pe_configure(struct eeh_pe *pe)
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
+	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
+		return -EINVAL;
+
+	/* Check on PCI error function */
+	if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
+		return -EINVAL;
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
