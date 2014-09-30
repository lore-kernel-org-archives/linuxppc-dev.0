Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3A271A0704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:17 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:16 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7F01F2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:14 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2ExMC11403656
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:14:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dDcA029468
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/21] powerpc/powernv: Add PCI error injection debugfs entry
Date: Tue, 30 Sep 2014 12:38:57 +1000
Message-Id: <1412044750-24460-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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
index ddb38cc..3389cf0 100644
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
