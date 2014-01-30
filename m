Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 04F922C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 00:01:13 +1100 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 30 Jan 2014 11:01:07 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 211081DC0074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 08:00:54 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0UD0woC4444302
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 11:00:59 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0UD0ofm030936
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 11:00:50 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: drop taken reference to driver on eeh_rmv_device
Date: Thu, 30 Jan 2014 11:00:48 -0200
Message-Id: <1391086848-11311-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: paulus@samba.org, shangw@linux.vnet.ibm.com,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit f5c57710dd62dd06f176934a8b4b8accbf00f9f8 ("powerpc/eeh: Use
partial hotplug for EEH unaware drivers") introduces eeh_rmv_device,
which may grab a reference to a driver, but not release it.

That prevents a driver from being removed after it has gone through EEH
recovery.

This patch drops the reference in either exit path if it was taken.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7bb30dc..afe7337 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -364,7 +364,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
 		return NULL;
 	driver = eeh_pcid_get(dev);
 	if (driver && driver->err_handler)
-		return NULL;
+		goto out;
 
 	/* Remove it from PCI subsystem */
 	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
@@ -377,6 +377,9 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	pci_stop_and_remove_bus_device(dev);
 	pci_unlock_rescan_remove();
 
+out:
+	if (driver)
+		eeh_pcid_put(dev);
 	return NULL;
 }
 
-- 
1.7.1
