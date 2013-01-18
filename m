Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 358192C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2013 06:17:55 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 18 Jan 2013 14:17:52 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A1FF26E8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 14:17:48 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0IJHnBx086916
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 14:17:49 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0IJHm6w006733
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 14:17:49 -0500
Date: Fri, 18 Jan 2013 11:17:36 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] pseries/iommu: ensure TCEs are cleared with non-huge DDW
Message-ID: <20130118191736.GC25500@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nfont@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 miltonm@bga.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are now two kinds of DMA windows that might be presented by
PowerVM DDW support -- huge windows (that can map all of system memory
regardless of the LPAR configuration) and non-huge windows (which
can't). They are implemented slightly differently in PowerVM, and thus
have different characteristics. The most obvious is that slot isolate
doesn't clear the TCEs/window for us with non-huge windows. Thus, when a
DLPAR operation occurs on a slot using a non-huge window, TCEs are still
present (the notifier chain doesn't currently remove them explicitly)
and the DLPAR fails. Fix this by calling remove_ddw() first, which will
unmap the DDW TCEs.

Note: a corresponding change to drmgr is needed to actually successfully
DLPAR, such that the device-tree update (which causes the notifier chain
to fire) occurs before slot isolate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a55b685..b4bb9e1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1296,6 +1296,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 
 	switch (action) {
 	case OF_RECONFIG_DETACH_NODE:
+		remove_ddw(np);
 		if (pci && pci->iommu_table)
 			iommu_free_table(pci->iommu_table, np->full_name);
 
@@ -1308,16 +1309,6 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 			}
 		}
 		spin_unlock(&direct_window_list_lock);
-
-		/*
-		 * Because the notifier runs after isolation of the
-		 * slot, we are guaranteed any DMA window has already
-		 * been revoked and the TCEs have been marked invalid,
-		 * so we don't need a call to remove_ddw(np). However,
-		 * if an additional notifier action is added before the
-		 * isolate call, we should update this code for
-		 * completeness with such a call.
-		 */
 		break;
 	default:
 		err = NOTIFY_DONE;
