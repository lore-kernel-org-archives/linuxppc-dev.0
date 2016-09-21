Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfYft3R1PzDsjr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 08:08:38 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LM3X22085006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 18:08:36 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25k6cmprrp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 18:08:36 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 16:08:35 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B3A4C3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 16:08:31 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LM8U5Z16712004
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 15:08:31 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89B986A047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 16:08:31 -0600 (MDT)
Received: from oc1376853207.ibm.com (unknown [9.53.92.233])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP id 5FADF6A03B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 16:08:31 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: c77dcd04-b878-476c-ad49-bf4a6def1116@linux.vnet.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Resend: [PATCH V7 8/8] powerpc: Enable support for new DRC devtree
 properties
Date: Wed, 21 Sep 2016 17:08:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <971f3dc0-1057-4d79-0029-cd926b1153a9@linux.vnet.ibm.com>
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
[V7: Correct mail threading]

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

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
