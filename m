Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89Rh46RbzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:48 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89Rh1lWcz8vDD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:48 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89Rg4y4Fz9t7W
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:28:47 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972OZT1082882
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:45 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2denvf0k6w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:45 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:44 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/18] powerpc/vas, nx-842: Define and use chip_to_vas_id()
Date: Fri,  6 Oct 2017 19:28:10 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-11-git-send-email-sukadev@linux.vnet.ibm.com>
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
