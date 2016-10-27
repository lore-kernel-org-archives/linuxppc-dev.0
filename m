Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4Tvj56jgzDt3Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 01:35:45 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9REYvkS015341
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:35:42 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26bg8ae712-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:35:42 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 08:35:40 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AB69119D8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:35:01 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9REYNeQ4653474
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 07:35:36 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D5F7C604C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:35:35 -0600 (MDT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP id 1F36FC6051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:35:35 -0600 (MDT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 0A150C203E37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 09:25:44 -0500 (CDT)
Subject: [PATCH V8 7/8] powerpc: Check arch.vec earlier during boot for
 memory features
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 27 Oct 2016 09:25:44 -0500
In-Reply-To: <147757821176.2995.6400281020620333555.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <147757821176.2995.6400281020620333555.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147757833672.2995.14630722264949315307.stgit@powerkvm6.aus.stglabs.ibm.com>
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

[V2: No change]
[V3: Updated after commit 3808a88985b4f5f5e947c364debce4441a380fb8.]
[V4: Update comments]
[V5: Resynchronize/resubmit]
[V6: Resync to v4.7 kernel code]
[V7: Correct mail threading]
[v8: Insert more useful variable names]

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
