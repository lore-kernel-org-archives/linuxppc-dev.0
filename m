Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj1Qc5n9bzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 15:07:04 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2E3xI6t028605
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 00:07:02 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2955muc5tc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 00:07:02 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 09:36:58 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2E46pVn16842836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:36:51 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2E46sIk016138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:36:55 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH 1/3] cxl: Re-factor cxl_pci_afu_read_err_buffer()
Date: Tue, 14 Mar 2017 09:36:04 +0530
In-Reply-To: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
References: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20170314040606.16894-2-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves,renames and re-factors the function
afu_pci_afu_err_buffer(). The function is now moved to native.c from
pci.c and renamed as native_afu_read_err_buffer().

Also the ability of copying data from h/w enforcing 4/8 byte aligned
access is useful and better shared across other functions. So this
patch moves the core logic of existing cxl_pci_afu_read_err_buffer()
to a new function named __aligned_memcpy().The new implementation of
native_afu_read_err_buffer() is simply a call to __aligned_memcpy()
with appropriate actual parameters.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h    |  3 ---
 drivers/misc/cxl/native.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/misc/cxl/pci.c    | 44 -------------------------------------
 3 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 79e60ec..ef683b7 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -739,9 +739,6 @@ static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
 		return ~0ULL;
 }
 
-ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
-				loff_t off, size_t count);
-
 /* Internal functions wrapped in cxl_base to allow PHB to call them */
 bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
 void _cxl_pci_disable_device(struct pci_dev *dev);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 7ae7105..20d3df6 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -1276,6 +1276,60 @@ static int native_afu_cr_write8(struct cxl_afu *afu, int cr, u64 off, u8 in)
 	return rc;
 }
 
+#define ERR_BUFF_MAX_COPY_SIZE PAGE_SIZE
+
+/*
+ * __aligned_memcpy:
+ * Copies count or max_read bytes (whichever is smaller) from src to dst buffer
+ * starting at offset off in src buffer. This specialized implementation of
+ * memcpy_fromio is needed as capi h/w only supports 4/8 bytes aligned access.
+ * So in case the requested offset/count arent 8 byte aligned the function uses
+ * a bounce buffer which can be max ERR_BUFF_MAX_COPY_SIZE == PAGE_SIZE
+ */
+static ssize_t __aligned_memcpy(void *dst, void __iomem *src, loff_t off,
+			       size_t count, size_t max_read)
+{
+	loff_t aligned_start, aligned_end;
+	size_t aligned_length;
+	void *tbuf;
+
+	if (count == 0 || off < 0 || (size_t)off >= max_read)
+		return 0;
+
+	/* calculate aligned read window */
+	count = min((size_t)(max_read - off), count);
+	aligned_start = round_down(off, 8);
+	aligned_end = round_up(off + count, 8);
+	aligned_length = aligned_end - aligned_start;
+
+	/* max we can copy in one read is PAGE_SIZE */
+	if (aligned_length > ERR_BUFF_MAX_COPY_SIZE) {
+		aligned_length = ERR_BUFF_MAX_COPY_SIZE;
+		count = ERR_BUFF_MAX_COPY_SIZE - (off & 0x7);
+	}
+
+	/* use bounce buffer for copy */
+	tbuf = (void *)__get_free_page(GFP_TEMPORARY);
+	if (!tbuf)
+		return -ENOMEM;
+
+	/* perform aligned read from the mmio region */
+	memcpy_fromio(tbuf, src + aligned_start, aligned_length);
+	memcpy(dst, tbuf + (off & 0x7), count);
+
+	free_page((unsigned long)tbuf);
+
+	return count;
+}
+
+static ssize_t native_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
+				loff_t off, size_t count)
+{
+	void __iomem *ebuf = afu->native->afu_desc_mmio + afu->eb_offset;
+
+	return __aligned_memcpy(buf, ebuf, off, count, afu->eb_len);
+}
+
 const struct cxl_backend_ops cxl_native_ops = {
 	.module = THIS_MODULE,
 	.adapter_reset = cxl_pci_reset,
@@ -1294,7 +1348,7 @@ const struct cxl_backend_ops cxl_native_ops = {
 	.support_attributes = native_support_attributes,
 	.link_ok = cxl_adapter_link_ok,
 	.release_afu = cxl_pci_release_afu,
-	.afu_read_err_buffer = cxl_pci_afu_read_err_buffer,
+	.afu_read_err_buffer = native_afu_read_err_buffer,
 	.afu_check_and_enable = native_afu_check_and_enable,
 	.afu_activate_mode = native_afu_activate_mode,
 	.afu_deactivate_mode = native_afu_deactivate_mode,
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 91f6459..541dc9a 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1051,50 +1051,6 @@ static int sanitise_afu_regs(struct cxl_afu *afu)
 	return 0;
 }
 
-#define ERR_BUFF_MAX_COPY_SIZE PAGE_SIZE
-/*
- * afu_eb_read:
- * Called from sysfs and reads the afu error info buffer. The h/w only supports
- * 4/8 bytes aligned access. So in case the requested offset/count arent 8 byte
- * aligned the function uses a bounce buffer which can be max PAGE_SIZE.
- */
-ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
-				loff_t off, size_t count)
-{
-	loff_t aligned_start, aligned_end;
-	size_t aligned_length;
-	void *tbuf;
-	const void __iomem *ebuf = afu->native->afu_desc_mmio + afu->eb_offset;
-
-	if (count == 0 || off < 0 || (size_t)off >= afu->eb_len)
-		return 0;
-
-	/* calculate aligned read window */
-	count = min((size_t)(afu->eb_len - off), count);
-	aligned_start = round_down(off, 8);
-	aligned_end = round_up(off + count, 8);
-	aligned_length = aligned_end - aligned_start;
-
-	/* max we can copy in one read is PAGE_SIZE */
-	if (aligned_length > ERR_BUFF_MAX_COPY_SIZE) {
-		aligned_length = ERR_BUFF_MAX_COPY_SIZE;
-		count = ERR_BUFF_MAX_COPY_SIZE - (off & 0x7);
-	}
-
-	/* use bounce buffer for copy */
-	tbuf = (void *)__get_free_page(GFP_TEMPORARY);
-	if (!tbuf)
-		return -ENOMEM;
-
-	/* perform aligned read from the mmio region */
-	memcpy_fromio(tbuf, ebuf + aligned_start, aligned_length);
-	memcpy(buf, tbuf + (off & 0x7), count);
-
-	free_page((unsigned long)tbuf);
-
-	return count;
-}
-
 static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pci_dev *dev)
 {
 	int rc;
-- 
2.9.3
