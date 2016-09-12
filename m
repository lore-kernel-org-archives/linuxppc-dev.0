Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXZKL0j2szDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:17:42 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH 1/3] powerpc/eeh: Null check uses of eeh_pe_bus_get
Date: Mon, 12 Sep 2016 14:17:22 +1000
Message-Id: <20160912041724.16646-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eeh_pe_bus_get() can return NULL if a PCI bus isn't found for a given PE.
Some callers don't check this, and can cause a null pointer dereference
under certain circumstances.

Fix this by checking NULL everywhere eeh_pe_bus_get() is called.

Cc: stable #3.10+
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/eeh_driver.c             | 8 ++++++++
 arch/powerpc/platforms/powernv/eeh-powernv.c | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 5f36e8a..29aa8d1 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -994,6 +994,14 @@ static void eeh_handle_special_event(void)
 				/* Notify all devices to be down */
 				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 				bus = eeh_pe_bus_get(phb_pe);
+				if (!bus) {
+					pr_err("%s: Cannot find PCI bus for "
+					       "PHB#%d-PE#%x\n",
+					       __func__,
+					       pe->phb->global_number,
+					       pe->addr);
+					break;
+				}
 				eeh_pe_dev_traverse(pe,
 					eeh_report_failure, NULL);
 				pci_hp_remove_devices(bus);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 86544ea..cb08e6a 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1091,6 +1091,11 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 	}
 
 	bus = eeh_pe_bus_get(pe);
+	if (!bus) {
+		pr_err("%s: Cannot find PCI bus for PHB#%d-PE#%x\n",
+			__func__, pe->phb->global_number, pe->addr);
+		return -EIO;
+	}
 	if (pe->type & EEH_PE_VF)
 		return pnv_eeh_reset_vf_pe(pe, option);
 
-- 
2.9.3
