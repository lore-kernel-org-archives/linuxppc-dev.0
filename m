Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2lN3CVbzDr0g
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:18:08 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JA8xbH110294
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:18:04 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28pk9p4ds7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:18:04 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 05:18:03 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Add translation mode information in /proc/cpuinfo
Date: Sun, 19 Feb 2017 15:47:49 +0530
Message-Id: <1487499469-15284-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this we have on powernv and pseries /proc/cpuinfo reporting

timebase        : 512000000
platform        : PowerNV
model           : 8247-22L
machine         : PowerNV 8247-22L
firmware        : OPAL
translation     : Hash

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 4 ++++
 arch/powerpc/platforms/pseries/setup.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d50c7d99baaf..d38571e289bb 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -95,6 +95,10 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	else
 		seq_printf(m, "firmware\t: BML\n");
 	of_node_put(root);
+	if (radix_enabled())
+		seq_printf(m, "translation\t: Radix\n");
+	else
+		seq_printf(m, "translation\t: Hash\n");
 }
 
 static void pnv_prepare_going_down(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 7736352f7279..6576fe306561 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -86,6 +86,10 @@ static void pSeries_show_cpuinfo(struct seq_file *m)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
 	of_node_put(root);
+	if (radix_enabled())
+		seq_printf(m, "translation\t: Radix\n");
+	else
+		seq_printf(m, "translation\t: Hash\n");
 }
 
 /* Initialize firmware assisted non-maskable interrupts if
-- 
2.7.4
