Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2D901A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 13:32:16 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 09:02:13 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6899F1258053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 09:01:43 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P3WPM360752032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 09:02:26 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P3WAgH013423
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 09:02:10 +0530
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] Bugfix: powerpc/eeh: Create eeh sysfs entry in post_init()
Date: Tue, 24 Jun 2014 23:32:07 -0400
Message-Id: <1403667127-1622-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Eeh sysfs entry created must be after EEH_ENABLED been set
in eeh_subsystem_flags.

In PowerNV platform, it try to create sysfs entry before
EEH_ENABLED been set, when boot up. So nothing will be
created for eeh in sysfs.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 8ad0c5b..5f95581 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -136,6 +136,9 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	struct pnv_phb *phb = hose->private_data;
 	int ret;
 
+	/* Creat sysfs after EEH_ENABLED been set */
+	eeh_add_sysfs_files(hose->bus);
+
 	/* Register OPAL event notifier */
 	if (!ioda_eeh_nb_init) {
 		ret = opal_notifier_register(&ioda_eeh_nb);
-- 
1.8.1.4
