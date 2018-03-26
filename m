Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40904q75ZbzF23J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:30:51 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGTXt8038113
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:30:49 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy29t6qja-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:30:48 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 12:30:46 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 03/41] cxlflash: Add argument identifier names
Date: Mon, 26 Mar 2018 11:30:37 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522081837-57561-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Checkpatch throws a warning when the argument identifier names are not
included in the function definitions.

To avoid these warnings, argument identifiers are added in the existing
function definitions.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/backend.h | 47 ++++++++++++++++++++++-------------------
 drivers/scsi/cxlflash/common.h  |  4 ++--
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/cxlflash/backend.h b/drivers/scsi/cxlflash/backend.h
index 339e42b..7b72149 100644
--- a/drivers/scsi/cxlflash/backend.h
+++ b/drivers/scsi/cxlflash/backend.h
@@ -16,26 +16,29 @@ extern const struct cxlflash_backend_ops cxlflash_cxl_ops;
 
 struct cxlflash_backend_ops {
 	struct module *module;
-	void __iomem * (*psa_map)(void *);
-	void (*psa_unmap)(void __iomem *);
-	int (*process_element)(void *);
-	int (*map_afu_irq)(void *, int, irq_handler_t, void *, char *);
-	void (*unmap_afu_irq)(void *, int, void *);
-	int (*start_context)(void *);
-	int (*stop_context)(void *);
-	int (*afu_reset)(void *);
-	void (*set_master)(void *);
-	void * (*get_context)(struct pci_dev *, void *);
-	void * (*dev_context_init)(struct pci_dev *, void *);
-	int (*release_context)(void *);
-	void (*perst_reloads_same_image)(void *, bool);
-	ssize_t (*read_adapter_vpd)(struct pci_dev *, void *, size_t);
-	int (*allocate_afu_irqs)(void *, int);
-	void (*free_afu_irqs)(void *);
-	void * (*create_afu)(struct pci_dev *);
-	struct file * (*get_fd)(void *, struct file_operations *, int *);
-	void * (*fops_get_context)(struct file *);
-	int (*start_work)(void *, u64);
-	int (*fd_mmap)(struct file *, struct vm_area_struct *);
-	int (*fd_release)(struct inode *, struct file *);
+	void __iomem * (*psa_map)(void *ctx_cookie);
+	void (*psa_unmap)(void __iomem *addr);
+	int (*process_element)(void *ctx_cookie);
+	int (*map_afu_irq)(void *ctx_cookie, int num, irq_handler_t handler,
+			   void *cookie, char *name);
+	void (*unmap_afu_irq)(void *ctx_cookie, int num, void *cookie);
+	int (*start_context)(void *ctx_cookie);
+	int (*stop_context)(void *ctx_cookie);
+	int (*afu_reset)(void *ctx_cookie);
+	void (*set_master)(void *ctx_cookie);
+	void * (*get_context)(struct pci_dev *dev, void *afu_cookie);
+	void * (*dev_context_init)(struct pci_dev *dev, void *afu_cookie);
+	int (*release_context)(void *ctx_cookie);
+	void (*perst_reloads_same_image)(void *afu_cookie, bool image);
+	ssize_t (*read_adapter_vpd)(struct pci_dev *dev, void *buf,
+				    size_t count);
+	int (*allocate_afu_irqs)(void *ctx_cookie, int num);
+	void (*free_afu_irqs)(void *ctx_cookie);
+	void * (*create_afu)(struct pci_dev *dev);
+	struct file * (*get_fd)(void *ctx_cookie, struct file_operations *fops,
+				int *fd);
+	void * (*fops_get_context)(struct file *file);
+	int (*start_work)(void *ctx_cookie, u64 irqs);
+	int (*fd_mmap)(struct file *file, struct vm_area_struct *vm);
+	int (*fd_release)(struct inode *inode, struct file *file);
 };
diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index 5d7ca01..d7fccea 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -232,8 +232,8 @@ struct hwq {
 
 struct afu {
 	struct hwq hwqs[CXLFLASH_MAX_HWQS];
-	int (*send_cmd)(struct afu *, struct afu_cmd *);
-	int (*context_reset)(struct hwq *);
+	int (*send_cmd)(struct afu *afu, struct afu_cmd *cmd);
+	int (*context_reset)(struct hwq *hwq);
 
 	/* AFU HW */
 	struct cxlflash_afu_map __iomem *afu_map;	/* entire MMIO map */
-- 
2.1.0
