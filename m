Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AB772C0513
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 11:39:40 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 21:39:38 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B92CEC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 21:39:34 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5Q1cDtO320770
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 21:38:14 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5Q1cD0C010381
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 19:38:13 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] powerpc/eeh: Fix address catch for PowerNV
Date: Wed, 26 Jun 2013 09:38:06 +0800
Message-Id: <1372210688-12214-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372210688-12214-1-git-send-email-shangw@linux.vnet.ibm.com>
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
