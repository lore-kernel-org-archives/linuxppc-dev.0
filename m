Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfMCl0CSJzDshs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 00:17:54 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LEHmPR058876
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:17:53 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25kta9d01f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:17:53 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 10:17:52 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 904D638C8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:17:49 -0400 (EDT)
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V6 8/8] powerpc: Enable support for new DRC devtree properties
Date: Wed, 21 Sep 2016 09:17:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <42c0ba88-7edf-f75f-9c30-1ee582558d45@linux.vnet.ibm.com>
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
[V6: Resynchronize to latest kernel commit code]

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff -Naur linux-rhel/arch/powerpc/kernel/prom_init.c linux-rhel-patch/arch/powerpc/kernel/prom_init.c
--- linux-rhel/arch/powerpc/kernel/prom_init.c	2016-03-03 07:36:25.000000000 -0600
+++ linux-rhel-patch/arch/powerpc/kernel/prom_init.c	2016-06-20 15:59:58.016373676 -0500
@@ -695,7 +695,7 @@
 	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
 
 	/* option vector 5: PAPR/OF options */
-	VECTOR_LENGTH(21),		/* length */
+	VECTOR_LENGTH(22),		/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
 	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
@@ -731,6 +731,7 @@
 	0,							/* Byte 19 */
 	0,							/* Byte 20 */
 	OV5_FEAT(OV5_SUB_PROCESSORS),				/* Byte 21 */
+	OV5_FEAT(OV5_DYN_MEM_V2) | OV5_FEAT(OV5_DRC_INFO),	/* Byte 22 */
 
 	/* option vector 6: IBM PAPR hints */
 	VECTOR_LENGTH(3),		/* length */
