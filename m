Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDD342C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:47:00 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 23:46:58 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2DCA319D8048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:45 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R5kso2143374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R5kr6A026151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:54 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/8] powerpc/eeh: Fix address catch for PowerNV
Date: Thu, 27 Jun 2013 13:46:45 +0800
Message-Id: <1372312009-13710-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the PowerNV platform, the EEH address cache isn't built correctly
because we skipped the EEH devices without binding PE. The patch
fixes that.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c           |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 1d5d9a6..858ebea 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -194,7 +194,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 	}
 
 	/* Skip any devices for which EEH is not enabled. */
-	if (!edev->pe) {
+	if (!eeh_probe_mode_dev() && !edev->pe) {
 #ifdef DEBUG
 		pr_info("PCI: skip building address cache for=%s - %s\n",
 			pci_name(dev), dn->full_name);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3e5c3d5..0ff9a3a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -998,6 +998,7 @@ static void pnv_pci_ioda_fixup(void)
 	pnv_pci_ioda_create_dbgfs();
 
 #ifdef CONFIG_EEH
+	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
 	eeh_addr_cache_build();
 	eeh_init();
 #endif
-- 
1.7.5.4
