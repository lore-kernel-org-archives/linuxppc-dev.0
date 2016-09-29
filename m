Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slWcd0HqrzDsjp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:53:52 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8TNr6aV046981
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 19:53:50 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25s8st8yv6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 19:53:50 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 30 Sep 2016 09:53:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A6E432BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:53:44 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8TNriCB4784454
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:53:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8TNrhbN026932
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:53:44 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, benh@au1.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, clsoto@us.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] pci: Call pcibios_sriov_enable() before IOV BARs are
 enabled
Date: Fri, 30 Sep 2016 09:47:49 +1000
Message-Id: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In current implementation, pcibios_sriov_enable() is used by PPC
PowerNV platform only. In PowerNV specific pcibios_sriov_enable(),
PF's IOV BARs might be updated (shifted) by pci_update_resource().
It means the IOV BARs aren't ready for decoding incoming memory
address until pcibios_sriov_enable() returns.

This calls pcibios_sriov_enable() earlier before the IOV BARs are
enabled. As the result, the IOV BARs have been configured correctly
when they are enabled.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Carol Soto <clsoto@us.ibm.com>
---
 drivers/pci/iov.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2194b44..f1343f0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -303,13 +303,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 			return rc;
 	}
 
-	pci_iov_set_numvfs(dev, nr_virtfn);
-	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
-	pci_cfg_access_lock(dev);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	msleep(100);
-	pci_cfg_access_unlock(dev);
-
 	iov->initial_VFs = initial;
 	if (nr_virtfn < initial)
 		initial = nr_virtfn;
@@ -320,6 +313,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		goto err_pcibios;
 	}
 
+	pci_iov_set_numvfs(dev, nr_virtfn);
+	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
+	pci_cfg_access_lock(dev);
+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
+	msleep(100);
+	pci_cfg_access_unlock(dev);
+
 	for (i = 0; i < initial; i++) {
 		rc = pci_iov_add_virtfn(dev, i, 0);
 		if (rc)
-- 
2.1.0
