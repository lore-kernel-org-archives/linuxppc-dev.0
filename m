Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqxD45xdHzF1Vp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 09:23:00 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QML2sg005027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 17:22:58 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gcp5pjyuh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 17:22:57 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 17:22:56 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v2 20/38] cxlflash: Support reading adapter VPD data
Date: Mon, 26 Feb 2018 16:22:50 -0600
In-Reply-To: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519683770-17474-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the PCI VPD services to support reading the VPD data of the
underlying adapter.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 364e7a5..a1d58fc 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -324,6 +324,20 @@ static void ocxlflash_perst_reloads_same_image(void *afu_cookie, bool image)
 }
 
 /**
+ * ocxlflash_read_adapter_vpd() - reads the adapter VPD
+ * @pdev:	PCI device associated with the host.
+ * @buf:	Buffer to get the VPD data.
+ * @count:	Size of buffer (maximum bytes that can be read).
+ *
+ * Return: size of VPD on success, -errno on failure
+ */
+static ssize_t ocxlflash_read_adapter_vpd(struct pci_dev *pdev, void *buf,
+					  size_t count)
+{
+	return pci_read_vpd(pdev, 0, count, buf);
+}
+
+/**
  * ocxlflash_unconfig_afu() - unconfigure the AFU
  * @afu: AFU associated with the host.
  */
@@ -650,6 +664,7 @@ const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
 	.dev_context_init	= ocxlflash_dev_context_init,
 	.release_context	= ocxlflash_release_context,
 	.perst_reloads_same_image = ocxlflash_perst_reloads_same_image,
+	.read_adapter_vpd	= ocxlflash_read_adapter_vpd,
 	.create_afu		= ocxlflash_create_afu,
 	.destroy_afu		= ocxlflash_destroy_afu,
 	.get_fd			= ocxlflash_get_fd,
-- 
2.1.0
