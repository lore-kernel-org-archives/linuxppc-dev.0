Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D37C02C0310
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 16:38:12 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:38:10 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8ED276E803C
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:03 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P5c8g33801460
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 05:38:08 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P5c8mH020686
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:08 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/9] powerpc/powernv: Support eeh_ops->event()
Date: Tue, 25 Feb 2014 13:37:47 +0800
Message-Id: <1393306670-17435-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch implements the backend for eeh_ops->event() on PowerNV
platform so that we can allocate or destroy PHB diag-data buffer,
which is attached to eeh_pe::data.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c |   42 +++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/eeh_pseries.c |    3 +-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a59788e..cfba40a 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -365,6 +365,45 @@ static int powernv_eeh_restore_config(struct device_node *dn)
 	return 0;
 }
 
+static int powernv_eeh_event(int event, void *data)
+{
+	struct eeh_pe *pe = data;
+	struct pnv_phb *phb;
+	int ret = 0;
+
+	switch (event) {
+	case EEH_EVENT_PE_ALLOC:
+		if (!pe) {
+			ret = -EINVAL;
+			break;
+		} else if (pe->data) {
+			ret = -EEXIST;
+			break;
+		}
+
+		phb = pe->phb->private_data;
+		if (phb->model == PNV_PHB_MODEL_P7IOC ||
+		    phb->model == PNV_PHB_MODEL_PHB3) {
+			pe->data = kzalloc(PNV_PCI_DIAG_BUF_SIZE, GFP_KERNEL);
+			if (!pe->data)
+				ret = -ENOMEM;
+		}
+
+		break;
+	case EEH_EVENT_PE_FREE:
+		if (pe->data) {
+			kfree(pe->data);
+			pe->data = NULL;
+		}
+
+		break;
+	default:
+		return 0;
+	}
+
+	return ret;
+}
+
 static struct eeh_ops powernv_eeh_ops = {
 	.name                   = "powernv",
 	.init                   = powernv_eeh_init,
@@ -381,7 +420,8 @@ static struct eeh_ops powernv_eeh_ops = {
 	.read_config            = pnv_pci_cfg_read,
 	.write_config           = pnv_pci_cfg_write,
 	.next_error		= powernv_eeh_next_error,
-	.restore_config		= powernv_eeh_restore_config
+	.restore_config		= powernv_eeh_restore_config,
+	.event			= powernv_eeh_event
 };
 
 /**
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 8a8f047..b9a4ddb 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -691,7 +691,8 @@ static struct eeh_ops pseries_eeh_ops = {
 	.read_config		= pseries_eeh_read_config,
 	.write_config		= pseries_eeh_write_config,
 	.next_error		= NULL,
-	.restore_config		= NULL
+	.restore_config		= NULL,
+	.event			= NULL
 };
 
 /**
-- 
1.7.10.4
