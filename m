Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4CF682C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 19:59:08 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 25 Dec 2013 01:59:04 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8A28C3E40040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 01:59:02 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBP8wuDi9830744
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 09:58:57 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBP8x1RZ016008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 01:59:01 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/powernv: Detect PHB chip revision
Date: Wed, 25 Dec 2013 16:58:55 +0800
Message-Id: <1387961936-20451-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to detect the PHB3 chip revision that was exported
by the underly firmware. In turn, we can have different AER configuration
for switch ports and endpoints accordingly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    5 +++++
 arch/powerpc/platforms/powernv/pci.h      |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2c6d173..aea45fa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1201,6 +1201,11 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	else
 		phb->model = PNV_PHB_MODEL_UNKNOWN;
 
+	/* Detect chip revision */
+	prop32 = of_get_property(np, "ibm,revision", NULL);
+	if (prop32)
+		phb->rev = be32_to_cpup(prop32);
+
 	/* Parse 32-bit and IO ranges (if any) */
 	pci_process_bridge_OF_ranges(hose, np, !hose->global_number);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 911c24e..c5a0810 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -89,6 +89,7 @@ struct pnv_phb {
 	struct pci_controller	*hose;
 	enum pnv_phb_type	type;
 	enum pnv_phb_model	model;
+	u32			rev;
 	u64			hub_id;
 	u64			opal_id;
 	void __iomem		*regs;
-- 
1.7.10.4
