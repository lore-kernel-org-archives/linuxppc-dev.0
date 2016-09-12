Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXZKL6YLLzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:17:42 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH 3/3] powerpc/eeh: Skip finding bus until after failure
 reporting
Date: Mon, 12 Sep 2016 14:17:24 +1000
Message-Id: <20160912041724.16646-3-ruscur@russell.cc>
In-Reply-To: <20160912041724.16646-1-ruscur@russell.cc>
References: <20160912041724.16646-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In eeh_handle_special_event(), eeh_pe_bus_get() is called before calling
eeh_report_failure() on every device under a PE.  If a PE was missing a
bus for some reason, the error would occur before reporting failure, even
though eeh_report_failure() doesn't require a bus.

Fix this by moving the bus retrieval and error check after the
eeh_report_failure() calls.

Cc: stable #3.10+
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/eeh_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 29aa8d1..a62be72 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -993,6 +993,8 @@ static void eeh_handle_special_event(void)
 
 				/* Notify all devices to be down */
 				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
+				eeh_pe_dev_traverse(pe,
+					eeh_report_failure, NULL);
 				bus = eeh_pe_bus_get(phb_pe);
 				if (!bus) {
 					pr_err("%s: Cannot find PCI bus for "
@@ -1002,8 +1004,6 @@ static void eeh_handle_special_event(void)
 					       pe->addr);
 					break;
 				}
-				eeh_pe_dev_traverse(pe,
-					eeh_report_failure, NULL);
 				pci_hp_remove_devices(bus);
 			}
 			pci_unlock_rescan_remove();
-- 
2.9.3
