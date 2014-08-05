Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 951411A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:30:03 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 5 Aug 2014 22:30:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 55761357802D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:29:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s75CUUUH11665482
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:30:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s75CTvMU020000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:29:57 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] vfio_pci: spapr: Enable VFIO if EEH is not supported
Date: Tue,  5 Aug 2014 22:29:45 +1000
Message-Id: <1407241785-30111-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
References: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing vfio_pci_open() fails if there is no EEH support for PCI.
This breaks POWER7's P5IOC2 PHB support which this patch brings back.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/pci/vfio_pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e2ee80f..63a73c0 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -179,10 +179,8 @@ static int vfio_pci_open(void *device_data)
 			goto error;
 
 		ret = vfio_spapr_pci_eeh_open(vdev->pdev);
-		if (ret) {
-			vfio_pci_disable(vdev);
-			goto error;
-		}
+		if (ret)
+			pr_warn("EEH is not supported\n");
 	}
 
 	return 0;
-- 
2.0.0
