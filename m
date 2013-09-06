Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B8F62C0155
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 11:00:48 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 21:00:46 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EEE2EC90042
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:00:42 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8610hlq29950136
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 01:00:43 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8610fgH003449
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 22:00:42 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/powernv: Support inbound error injection
Date: Fri,  6 Sep 2013 09:00:01 +0800
Message-Id: <1378429205-16248-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For now, we only support outbound error injection. Actually, the
hardware supports injecting inbound errors as well. The patch enables
to inject inbound errors.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   59 ++++++++++++++++++++++++----
 1 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 855c1d5..3ee44b0 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -66,26 +66,60 @@ static struct notifier_block ioda_eeh_nb = {
 };
 
 #ifdef CONFIG_DEBUG_FS
-static int ioda_eeh_dbgfs_set(void *data, u64 val)
+static int ioda_eeh_dbgfs_set(void *data, int offset, u64 val)
 {
 	struct pci_controller *hose = data;
 	struct pnv_phb *phb = hose->private_data;
 
-	out_be64(phb->regs + 0xD10, val);
+	out_be64(phb->regs + offset, val);
 	return 0;
 }
 
-static int ioda_eeh_dbgfs_get(void *data, u64 *val)
+static int ioda_eeh_dbgfs_get(void *data, int offset, u64 *val)
 {
 	struct pci_controller *hose = data;
 	struct pnv_phb *phb = hose->private_data;
 
-	*val = in_be64(phb->regs + 0xD10);
+	*val = in_be64(phb->regs + offset);
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_dbgfs_ops, ioda_eeh_dbgfs_get,
-			ioda_eeh_dbgfs_set, "0x%llx\n");
+static int ioda_eeh_outb_dbgfs_set(void *data, u64 val)
+{
+	return ioda_eeh_dbgfs_set(data, 0xD10, val);
+}
+
+static int ioda_eeh_outb_dbgfs_get(void *data, u64 *val)
+{
+	return ioda_eeh_dbgfs_get(data, 0xD10, val);
+}
+
+static int ioda_eeh_inbA_dbgfs_set(void *data, u64 val)
+{
+	return ioda_eeh_dbgfs_set(data, 0xD90, val);
+}
+
+static int ioda_eeh_inbA_dbgfs_get(void *data, u64 *val)
+{
+	return ioda_eeh_dbgfs_get(data, 0xD90, val);
+}
+
+static int ioda_eeh_inbB_dbgfs_set(void *data, u64 val)
+{
+	return ioda_eeh_dbgfs_set(data, 0xE10, val);
+}
+
+static int ioda_eeh_inbB_dbgfs_get(void *data, u64 *val)
+{
+	return ioda_eeh_dbgfs_get(data, 0xE10, val);
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_outb_dbgfs_ops, ioda_eeh_outb_dbgfs_get,
+			ioda_eeh_outb_dbgfs_set, "0x%llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbA_dbgfs_ops, ioda_eeh_inbA_dbgfs_get,
+			ioda_eeh_inbA_dbgfs_set, "0x%llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_inbB_dbgfs_ops, ioda_eeh_inbB_dbgfs_get,
+			ioda_eeh_inbB_dbgfs_set, "0x%llx\n");
 #endif /* CONFIG_DEBUG_FS */
 
 /**
@@ -123,10 +157,17 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	if (phb->dbgfs)
-		debugfs_create_file("err_injct", 0600,
+	if (phb->dbgfs) {
+		debugfs_create_file("err_injct_outbound", 0600,
+				    phb->dbgfs, hose,
+				    &ioda_eeh_outb_dbgfs_ops);
+		debugfs_create_file("err_injct_inboundA", 0600,
 				    phb->dbgfs, hose,
-				    &ioda_eeh_dbgfs_ops);
+				    &ioda_eeh_inbA_dbgfs_ops);
+		debugfs_create_file("err_injct_inboundB", 0600,
+				    phb->dbgfs, hose,
+				    &ioda_eeh_inbB_dbgfs_ops);
+	}
 #endif
 
 	phb->eeh_state |= PNV_EEH_STATE_ENABLED;
-- 
1.7.5.4
