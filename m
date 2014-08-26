Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40C6B1A08D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 17:56:36 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 26 Aug 2014 13:26:32 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 05760394005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:30 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7Q7wqoV38994130
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:28:52 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7Q7uTZf029734
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:29 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/powernv: Add error injection debugfs entry
Date: Tue, 26 Aug 2014 17:56:18 +1000
Message-Id: <1409039779-392-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1409039779-392-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1409039779-392-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: qiudayu@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mike Qiu <qiudayu@linux.vnet.ibm.com>

The patch adds debugfs file (/sys/kernel/debug/powerpc/PCIxxxx/
err_injct), which accepts following formated string, to support
error injection. It will be used to support userland utility
"errinjct" in future.

  "pe_no:0:function:address:mask" - 32-bits PCI errors
  "pe_no:1:function:address:mask" - 64-bits PCI errors

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 18099c5..4d40093 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -66,6 +66,54 @@ static struct notifier_block ioda_eeh_nb = {
 };
 
 #ifdef CONFIG_DEBUG_FS
+static ssize_t ioda_eeh_ei_write(struct file *filp,
+				 const char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct pci_controller *hose = filp->private_data;
+	struct pnv_phb *phb = hose->private_data;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int pe_no, type, func;
+	unsigned long addr, mask;
+	char buf[50];
+	int ret;
+
+	if (!phb->eeh_ops || !phb->eeh_ops->err_inject)
+		return -ENXIO;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	if (!ret)
+		return -EFAULT;
+
+	/* Retrieve parameters */
+	ret = sscanf(buf, "%x:%x:%x:%lx:%lx",
+		     &pe_no, &type, &func, &addr, &mask);
+	if (ret != 5)
+		return -EINVAL;
+
+	/* Retrieve PE */
+	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+	if (!edev)
+		return -ENOMEM;
+	edev->phb = hose;
+	edev->pe_config_addr = pe_no;
+	pe = eeh_pe_get(edev);
+	kfree(edev);
+	if (!pe)
+		return -ENODEV;
+
+	/* Do error injection */
+	ret = phb->eeh_ops->err_inject(pe, type, func, addr, mask);
+	return ret < 0 ? ret : count;
+}
+
+static const struct file_operations ioda_eeh_ei_fops = {
+	.open   = simple_open,
+	.llseek = no_llseek,
+	.write  = ioda_eeh_ei_write,
+};
+
 static int ioda_eeh_dbgfs_set(void *data, int offset, u64 val)
 {
 	struct pci_controller *hose = data;
@@ -152,6 +200,10 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	if (!phb->has_dbgfs && phb->dbgfs) {
 		phb->has_dbgfs = 1;
 
+		debugfs_create_file("err_injct", 0200,
+				    phb->dbgfs, hose,
+				    &ioda_eeh_ei_fops);
+
 		debugfs_create_file("err_injct_outbound", 0600,
 				    phb->dbgfs, hose,
 				    &ioda_eeh_outb_dbgfs_ops);
-- 
1.8.3.2
