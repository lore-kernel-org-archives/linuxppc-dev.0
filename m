Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYVCF5lD0zDvk7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 18:15:53 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB77Dchd146670
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 02:15:52 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 276dpege31-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 02:15:51 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 7 Dec 2016 00:15:50 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E35A919D801C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:15:08 -0700 (MST)
Subject: [PATCH V9 7/8] powerpc: Check arch.vec earlier during boot for
 memory features
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
Date: Wed, 07 Dec 2016 01:15:47 -0600
In-Reply-To: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148109493640.193207.4066849658518994363.stgit@powerkvm6.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

architecture.vec5 features: The boot-time memory management needs to
know the form of the "ibm,dynamic-memory-v2" property early during
scanning of the flattened device tree.  This patch moves execution of
the function pseries_probe_fw_features() early enough to be before
the scanning of the memory properties in the device tree to allow
recognition of the supported properties.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 2d49887..bd07157 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -759,6 +759,9 @@ void __init early_init_devtree(void *params)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
 
+	/* Now try to figure out if we are running on LPAR and so on */
+	pseries_probe_fw_features();
+
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
@@ -826,9 +829,6 @@ void __init early_init_devtree(void *params)
 #endif
 	epapr_paravirt_early_init();
 
-	/* Now try to figure out if we are running on LPAR and so on */
-	pseries_probe_fw_features();
-
 #ifdef CONFIG_PPC_PS3
 	/* Identify PS3 firmware */
 	if (of_flat_dt_is_compatible(of_get_flat_dt_root(), "sony,ps3"))
