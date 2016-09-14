Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZCG20hDWzDsWl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 06:05:29 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8EK2p0K109611
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 16:05:28 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25f8ubm9bj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 16:05:28 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 14:05:27 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2B5481FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 14:05:06 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V5 8/8] powerpc: Enable support for new DRC devtree properties
Date: Wed, 14 Sep 2016 15:05:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <6f98d032-7699-770c-cabb-e2e645c8647c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

prom_init.c: Enable support for new DRC device tree properties
"ibm,drc-info" and "ibm,dynamic-memory-v2" in initial handshake
between the Linux kernel and the front end processor.

[V2: Revise constant names.]
[V3: No change.]
[V4: Update comments]
[V5: Resynchronize/resubmit]

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff -Naur linux-rhel/arch/powerpc/kernel/prom_init.c linux-rhel-patch/arch/powerpc/kernel/prom_init.c
--- linux-rhel/arch/powerpc/kernel/prom_init.c	2016-03-03 07:36:25.000000000 -0600
+++ linux-rhel-patch/arch/powerpc/kernel/prom_init.c	2016-06-20 15:59:58.016373676 -0500
@@ -695,7 +695,7 @@ unsigned char ibm_architecture_vec[] = {
 	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
 
 	/* option vector 5: PAPR/OF options */
-	VECTOR_LENGTH(18),		/* length */
+	VECTOR_LENGTH(22),		/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
 	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
@@ -728,6 +728,10 @@ unsigned char ibm_architecture_vec[] = {
 	OV5_FEAT(OV5_PFO_HW_RNG) | OV5_FEAT(OV5_PFO_HW_ENCR) |
 	OV5_FEAT(OV5_PFO_HW_842),
 	OV5_FEAT(OV5_SUB_PROCESSORS),
+	0,
+	0,
+	0,
+	OV5_FEAT(OV5_DYN_MEM_V2) | OV5_FEAT(OV5_DRC_INFO),
 
 	/* option vector 6: IBM PAPR hints */
 	VECTOR_LENGTH(3),		/* length */
