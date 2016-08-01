Return-Path: <millerjo@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3BLZ1BtBzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 06:50:45 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71KnO9S059665
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 16:50:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gnv13sf0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 16:50:43 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Mon, 1 Aug 2016 14:50:42 -0600
From: Jack Miller <jack@codezen.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org
Subject: [PATCH] powernv: Search for new flash DT node location
Date: Mon,  1 Aug 2016 15:50:35 -0500
Message-Id: <20160801205035.18514-1-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Skiboot will place the flash device tree node at ibm,opal/flash/flash@0
on P9 and later systems, so Linux needs to search for it there as well
as ibm,opal/flash@0 for backwards compatibility.

Signed-off-by: Jack Miller <jack@codezen.org>
---
 arch/powerpc/platforms/powernv/opal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index ae29eaf..2847cb0 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -755,9 +755,14 @@ static int __init opal_init(void)
 
 	/* Initialize platform devices: IPMI backend, PRD & flash interface */
 	opal_pdev_init(opal_node, "ibm,opal-ipmi");
-	opal_pdev_init(opal_node, "ibm,opal-flash");
+	opal_pdev_init(opal_node, "ibm,opal-flash"); // old <= P8 flash location
 	opal_pdev_init(opal_node, "ibm,opal-prd");
 
+	/* New >= P9 flash location */
+	np = of_get_child_by_name(opal_node, "flash");
+	if (np)
+		opal_pdev_init(np, "ibm,opal-flash");
+
 	/* Initialise OPAL kmsg dumper for flushing console on panic */
 	opal_kmsg_init();
 
-- 
2.9.2
