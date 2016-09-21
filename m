Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfYdj5HFYzDslr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 08:07:37 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LM3tQN036358
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 18:07:35 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25khte5w3f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 18:07:35 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 16:07:34 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0E4191FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 16:07:13 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LM7Vv412190084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 15:07:31 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC20E13603C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 16:07:31 -0600 (MDT)
Received: from oc1376853207.ibm.com (unknown [9.53.92.233])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP id 8FB89136044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 16:07:31 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: c77dcd04-b878-476c-ad49-bf4a6def1116@linux.vnet.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Resend: [PATCH V7 7/8] powerpc: Check arch.vec earlier during boot
 for memory features
Date: Wed, 21 Sep 2016 17:07:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <973da61f-30d0-ca7a-b810-44ed0b341bd2@linux.vnet.ibm.com>
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

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 946e34f..2034edc 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -753,6 +753,9 @@ void __init early_init_devtree(void *params)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
 
+	/* Now try to figure out if we are running on LPAR and so on */
+	pseries_probe_fw_features();
+
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
