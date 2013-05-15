Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E814C2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:35:14 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 May 2013 21:35:12 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DD3EE3E40026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:34:54 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F3Z9Wg112490
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:09 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F3Z8ci003589
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:09 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/22] powerpc/eeh: Delay EEH probe during hotplug
Date: Wed, 15 May 2013 11:34:45 +0800
Message-Id: <1368588898-16224-10-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While doing EEH recovery, the PCI devices of the problematic PE
should be removed and then added to the system again. During the
so-called hotplug event, the PCI devices of the problematic PE
will be probed through early/late phase. We would delay EEH probe
on late point for PowerNV platform since the PCI device isn't
available in early phase.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index ffe34c4..c65e14c 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -758,6 +758,14 @@ static void eeh_add_device_early(struct device_node *dn)
 {
 	struct pci_controller *phb;
 
+	/*
+	 * If we're doing EEH probe based on PCI device, we
+	 * would delay the probe until late stage because
+	 * the PCI device isn't available this moment.
+	 */
+	if (!eeh_probe_mode_devtree())
+		return;
+
 	if (!of_node_to_eeh_dev(dn))
 		return;
 	phb = of_node_to_eeh_dev(dn)->phb;
@@ -766,7 +774,6 @@ static void eeh_add_device_early(struct device_node *dn)
 	if (NULL == phb || 0 == phb->buid)
 		return;
 
-	/* FIXME: hotplug support on POWERNV */
 	eeh_ops->of_probe(dn, NULL);
 }
 
@@ -817,6 +824,13 @@ static void eeh_add_device_late(struct pci_dev *dev)
 	edev->pdev = dev;
 	dev->dev.archdata.edev = edev;
 
+	/*
+	 * We have to do the EEH probe here because the PCI device
+	 * hasn't been created yet in the early stage.
+	 */
+	if (eeh_probe_mode_dev())
+		eeh_ops->dev_probe(dev, NULL);
+
 	eeh_addr_cache_insert_dev(dev);
 }
 
-- 
1.7.5.4
