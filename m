Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B35CA1A04CC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 13:02:46 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sun, 17 Aug 2014 08:32:44 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 81AE7E0017
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 08:34:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7H334Ru49807394
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 08:33:05 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7H32fxw007229
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Aug 2014 08:32:42 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc/eeh: Clear frozen state on passing device
Date: Sun, 17 Aug 2014 13:02:29 +1000
Message-Id: <1408244549-10221-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1408244549-10221-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1408244549-10221-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When passing through device, its PE might have been put into frozen
state. One obvious example would be: the passed PE is forced to be
offline because of hitting maximal allowed EEH errors in userland.
In that case, the frozen state won't be cleared and then the PE is
returned back to host, which might not have chance detecting and
recovering from it.

The patch adds more check when passing through device and clear the
PE frozen state if necessary.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index db2841c..211175e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1150,6 +1150,8 @@ void eeh_remove_device(struct pci_dev *dev)
 int eeh_dev_open(struct pci_dev *pdev)
 {
 	struct eeh_dev *edev;
+	int flag = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
+	int ret = -ENODEV;
 
 	mutex_lock(&eeh_dev_mutex);
 
@@ -1162,6 +1164,34 @@ int eeh_dev_open(struct pci_dev *pdev)
 	if (!edev || !edev->pe)
 		goto out;
 
+	/*
+	 * The PE might have been put into frozen state, but we
+	 * didn't detect that yet. The passed through PCI devices
+	 * in frozen PE won't work properly. Clear the frozen state
+	 * in advance.
+	 */
+	ret = eeh_ops->get_state(edev->pe, NULL);
+	if (ret > 0 && ret != EEH_STATE_NOT_SUPPORT &&
+	    (ret & flag) != flag) {
+		ret = eeh_ops->set_option(edev->pe, EEH_OPT_THAW_MMIO);
+		if (ret) {
+			pr_warn("%s: Failure %d enabling MMIO "
+				"for PHB#%x-PE#%x\n",
+				__func__, ret, edev->phb->global_number,
+				edev->pe->addr);
+			goto out;
+		}
+
+		ret = eeh_ops->set_option(edev->pe, EEH_OPT_THAW_DMA);
+		if (ret) {
+			pr_warn("%s: Failure %d enabling DMA "
+				"for PHB#%x-PE#%x\n",
+				__func__, ret, edev->phb->global_number,
+				edev->pe->addr);
+			goto out;
+		}
+	}
+
 	/* Increase PE's pass through count */
 	atomic_inc(&edev->pe->pass_dev_cnt);
 	mutex_unlock(&eeh_dev_mutex);
@@ -1169,7 +1199,7 @@ int eeh_dev_open(struct pci_dev *pdev)
 	return 0;
 out:
 	mutex_unlock(&eeh_dev_mutex);
-	return -ENODEV;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(eeh_dev_open);
 
-- 
1.8.3.2
