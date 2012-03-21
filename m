Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D8FCB6FEF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 11:58:59 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 22 Mar 2012 06:28:53 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2M0wmEp3280906
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 06:28:48 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2M6TG4L023699
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 17:29:17 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH 3/3] powerpc/eeh: Retrieve PHB from global list
Date: Wed, 21 Mar 2012 15:30:29 +0800
Message-Id: <1332315029-29688-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1332315029-29688-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1332315029-29688-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: sfr@canb.auug.org.au, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the existing PHBs are retrieved from the FDT (Flat
Device Tree) based on the name of FDT node. Specificly, those
FDT nodes whose names have prefix "pci" are regarded as PHBs.
That's inappropriate because some PCI bridges possibilly have
names leading with "pci". It caused EEH is enabled on same
PCI devices for towice.

The patch fixes the above issue. Besides, the PHBs are expected
to be figured out from FDT before enable EEH on them. Therefore,
it's resonable to retrieve the PHBs from the global linked list
traced by variable "hose_list" insteading poking them from FDT.

For the EEH implementation on pSeries platform, RTAS is critical
because all low-level functions are implemented based on RTAS.
Therefore, we should make sure "/rtas" OF node is available and
ready before to enable EEH core. However, it actually introduced
duplicate since the previous pSeries platform dependent initialization
function already do the check. Besides, we want to make eeh core
platform independent, so RTAS related staff should be removed there.
The patch removes the duplicate check on "/rtas" OF node for eeh
core.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 8011088..309d38e 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -984,7 +984,8 @@ int __exit eeh_ops_unregister(const char *name)
  */
 void __init eeh_init(void)
 {
-	struct device_node *phb, *np;
+	struct pci_controller *hose, *tmp;
+	struct device_node *phb;
 	int ret;
 
 	/* call platform initialization function */
@@ -1000,19 +1001,9 @@ void __init eeh_init(void)
 
 	raw_spin_lock_init(&confirm_error_lock);
 
-	np = of_find_node_by_path("/rtas");
-	if (np == NULL)
-		return;
-
-	/* Enable EEH for all adapters.  Note that eeh requires buid's */
-	for (phb = of_find_node_by_name(NULL, "pci"); phb;
-	     phb = of_find_node_by_name(phb, "pci")) {
-		unsigned long buid;
-
-		buid = get_phb_buid(phb);
-		if (buid == 0 || !of_node_to_eeh_dev(phb))
-			continue;
-
+	/* Enable EEH for all adapters */
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		phb = hose->dn;
 		traverse_pci_devices(phb, eeh_early_enable, NULL);
 	}
 
-- 
1.7.5.4
