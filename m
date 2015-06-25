Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9FF31A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 11:38:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 11:38:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5EC272CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 11:38:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P1c4ts19923182
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 11:38:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P1beIP000766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 11:37:40 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Clear the EEH_DEV_NO_HANDLER flag when
 connecting edev with pdev
Date: Thu, 25 Jun 2015 09:37:22 +0800
Message-Id: <1435196242-10398-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On hotplug case, after a pdev is removed from the system, edev->mode will
set flag EEH_DEV_NO_HANDLER to mark the status. While this flag is not
cleared when we probe back those pdev. This will lead to miss the call of
driver->err_handler->slot_reset in eeh_report_reset().

This patch clear this flag when probe back those devices.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9ee61d1..adf9bc4 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1113,6 +1113,7 @@ void eeh_add_device_late(struct pci_dev *dev)
 
 	pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
 	edev = pdn_to_eeh_dev(pdn);
+	edev->mode &= ~EEH_DEV_NO_HANDLER;
 	if (edev->pdev == dev) {
 		pr_debug("EEH: Already referenced !\n");
 		return;
-- 
1.7.9.5
