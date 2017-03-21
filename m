Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnfwZ24pXzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 04:30:38 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2LHTOYt102594
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:30:26 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b0kd8154-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:30:26 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 13:30:25 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 05/10] powerpc/mm: Add translation mode information in
 /proc/cpuinfo
Date: Tue, 21 Mar 2017 22:59:55 +0530
In-Reply-To: <1490117400-9891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490117400-9891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490117400-9891-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
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
