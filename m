Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rywhv24ZxzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 08:21:51 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PMJbJT058952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:21:49 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c1h4vbxk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:21:49 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 16:21:48 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DDC323E40030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 16:21:43 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 8/8] powerpc: Enable support for new DRC devtree properties
Date: Mon, 25 Jul 2016 17:21:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <0ca54f14-5a86-c730-3a4c-0d108c65baf7@linux.vnet.ibm.com>
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
+	OV5_FEAT(OV5_RPS_DM2) | OV5_FEAT(OV5_RPS_DRC_INFO),
 
 	/* option vector 6: IBM PAPR hints */
 	VECTOR_LENGTH(3),		/* length */
