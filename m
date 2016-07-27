Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzy0K38qZzDrPr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:23:45 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6RENh64090133
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:43 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24e1btppj8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:43 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 27 Jul 2016 08:23:36 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2848C3E40041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 08:23:34 -0600 (MDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6RENRq310223958
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 14:23:37 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CBDEAE05C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:33 -0400 (EDT)
Received: from oc1376853207.ibm.com (unknown [9.77.146.137])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 45D7DAE04E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:33 -0400 (EDT)
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V2 8/8] powerpc: Enable support for new DRC devtree properties
Date: Wed, 27 Jul 2016 09:23:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a07aeb2e-7bb2-40ae-577a-5dd44ecf5477@linux.vnet.ibm.com>
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
