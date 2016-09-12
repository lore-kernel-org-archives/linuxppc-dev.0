Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXZSx3SbRzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:24:17 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH 2/3] powernv/eeh: Skip finding bus for VF resets
Date: Mon, 12 Sep 2016 14:17:23 +1000
Message-Id: <20160912041724.16646-2-ruscur@russell.cc>
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

When the PE used in pnv_eeh_reset() is that of a VF,
pnv_eeh_reset_vf_pe() is used.  Unlike the other reset functions called
in pnv_eeh_reset(), the VF reset doesn't require a bus, and if a bus was
missing the function would error out before resetting the VF PE.

To avoid this, reorder the VF reset function to occur before finding and
checking the bus.

Cc: stable #3.10+
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index cb08e6a..68f1a85 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1090,14 +1090,15 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 		}
 	}
 
+	if (pe->type & EEH_PE_VF)
+		return pnv_eeh_reset_vf_pe(pe, option);
+
 	bus = eeh_pe_bus_get(pe);
 	if (!bus) {
 		pr_err("%s: Cannot find PCI bus for PHB#%d-PE#%x\n",
 			__func__, pe->phb->global_number, pe->addr);
 		return -EIO;
 	}
-	if (pe->type & EEH_PE_VF)
-		return pnv_eeh_reset_vf_pe(pe, option);
 
 	if (pci_is_root_bus(bus) ||
 	    pci_is_root_bus(bus->parent))
-- 
2.9.3
