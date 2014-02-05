Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D27A02C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 05:20:57 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 16:20:51 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id F14EA1DC006C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 13:20:48 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s15IKCwq44499032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 16:20:12 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s15IKlYH020865
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 16:20:48 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/eeh: drop taken reference to driver on
 eeh_rmv_device
Date: Wed,  5 Feb 2014 16:20:45 -0200
Message-Id: <1391624445-9095-1-git-send-email-cascardo@linux.vnet.ibm.com>
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

This patch drops the reference if it was taken.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7bb30dc..fdc679d 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -362,9 +362,13 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	 */
 	if (!dev || (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
 		return NULL;
+
 	driver = eeh_pcid_get(dev);
-	if (driver && driver->err_handler)
-		return NULL;
+	if (driver) {
+		eeh_pcid_put(dev);
+		if (driver->err_handler)
+			return NULL;
+	}
 
 	/* Remove it from PCI subsystem */
 	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
-- 
1.7.1
