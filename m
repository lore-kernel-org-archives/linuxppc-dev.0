Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkPts1YK9zDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:32:52 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GANsYH045567
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:42 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297kjn7jfp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:42 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 06:32:39 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 05/11] powerpc/mm: Add translation mode information in
 /proc/cpuinfo
Date: Thu, 16 Mar 2017 16:02:03 +0530
In-Reply-To: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1489660329-22501-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
MMU		: Hash

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 4 ++++
 arch/powerpc/platforms/pseries/setup.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d50c7d99baaf..2d937f6d9260 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -95,6 +95,10 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	else
 		seq_printf(m, "firmware\t: BML\n");
 	of_node_put(root);
+	if (radix_enabled())
+		seq_printf(m, "MMU\t\t: Radix\n");
+	else
+		seq_printf(m, "MMU\t\t: Hash\n");
 }
 
 static void pnv_prepare_going_down(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b4d362ed03a1..b5d86426e97b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -87,6 +87,10 @@ static void pSeries_show_cpuinfo(struct seq_file *m)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
 	of_node_put(root);
+	if (radix_enabled())
+		seq_printf(m, "MMU\t\t: Radix\n");
+	else
+		seq_printf(m, "MMU\t\t: Hash\n");
 }
 
 /* Initialize firmware assisted non-maskable interrupts if
-- 
2.7.4
