Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C683F1A08C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:49:38 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 6 Aug 2014 12:49:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D79D83578061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:49:02 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s762VnMY000450
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:31:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s762n0DC020436
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:49:01 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] vfio_pci: spapr: Enable VFIO if EEH is not supported
Date: Wed,  6 Aug 2014 12:48:33 +1000
Message-Id: <1407293313-24894-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
References: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
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

It is a warning because this should not normally happen on supported
configurations such as POWER8+IODA so we always want to see it in dmesg.
It is _once() as the message may be triggered by non-privileged userspace
and we do not want to pollute dmesg.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* discussed with Ben Herrenschmidt and did s/pr_warn/pr_warn_once/
* updated commit log
---
 drivers/vfio/pci/vfio_pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e2ee80f..68dc8da 100644
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
+			pr_warn_once("EEH is not supported\n");
 	}
 
 	return 0;
-- 
2.0.0
