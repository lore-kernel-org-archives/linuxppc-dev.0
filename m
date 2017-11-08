Return-Path: <srs0=buqp=cg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWqqq3PRnzDrCr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yWqqq1k7kz8trp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:23 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yWqqn3rm2z9sNr
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2017 13:24:21 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA82O4wn135429
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2017 21:24:19 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e3jfrh9ta-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Nov 2017 21:24:19 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Nov 2017 19:24:18 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 10/18] powerpc/vas, nx-842: Define and use chip_to_vas_id()
Date: Tue,  7 Nov 2017 18:23:50 -0800
In-Reply-To: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1510107838-15181-11-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define a helper, chip_to_vas_id() to map a given chip id to corresponding
vas id.

Normally, callers of vas_rx_win_open() and vas_tx_win_open() want the VAS
window to be on the same chip where the calling thread is executing. These
callers can pass in -1 for the VAS id.

This interface will be useful if a thread running on one chip wants to open
a window on another chip (like the NX-842 driver does during start up).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/vas.h       |  9 +++++++++
 arch/powerpc/platforms/powernv/vas.c | 11 +++++++++++
 drivers/crypto/nx/nx-842-powernv.c   | 18 +++---------------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index fd5963a..044748f 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -104,6 +104,15 @@ struct vas_tx_win_attr {
 };
 
 /*
+ * Helper to map a chip id to VAS id.
+ * For POWER9, this is a 1:1 mapping. In the future this maybe a 1:N
+ * mapping in which case, we will need to update this helper.
+ *
+ * Return the VAS id or -1 if no matching vasid is found.
+ */
+int chip_to_vas_id(int chipid);
+
+/*
  * Helper to initialize receive window attributes to defaults for an
  * NX window.
  */
diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index abb7090..cd9a733 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -123,6 +123,17 @@ struct vas_instance *find_vas_instance(int vasid)
 	return NULL;
 }
 
+int chip_to_vas_id(int chipid)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_to_chip_id(cpu) == chipid)
+			return per_cpu(cpu_vas_id, cpu);
+	}
+	return -1;
+}
+
 static int vas_probe(struct platform_device *pdev)
 {
 	return init_vas_instance(pdev);
diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 874ddf5..eb221ed 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -847,24 +847,12 @@ static int __init nx842_powernv_probe_vas(struct device_node *pn)
 		return -EINVAL;
 	}
 
-	for_each_compatible_node(dn, NULL, "ibm,power9-vas-x") {
-		if (of_get_ibm_chip_id(dn) == chip_id)
-			break;
-	}
-
-	if (!dn) {
-		pr_err("Missing VAS device node\n");
+	vasid = chip_to_vas_id(chip_id);
+	if (vasid < 0) {
+		pr_err("Unable to map chip_id %d to vasid\n", chip_id);
 		return -EINVAL;
 	}
 
-	if (of_property_read_u32(dn, "ibm,vas-id", &vasid)) {
-		pr_err("Missing ibm,vas-id device property\n");
-		of_node_put(dn);
-		return -EINVAL;
-	}
-
-	of_node_put(dn);
-
 	for_each_child_of_node(pn, dn) {
 		if (of_device_is_compatible(dn, "ibm,p9-nx-842")) {
 			ret = vas_cfg_coproc_info(dn, chip_id, vasid);
-- 
2.7.4
