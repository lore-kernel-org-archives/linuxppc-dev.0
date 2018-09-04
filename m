Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424McY0snmzF3Lq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 19:54:17 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w849TObj137372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Sep 2018 05:31:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m9m1tgxjt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 05:31:01 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Tue, 4 Sep 2018 03:31:00 -0600
Subject: [PATCH] powerpc/pseries: Export VPA related data
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 aravinda@linux.vnet.ibm.com
Date: Tue, 04 Sep 2018 15:00:55 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153605345531.16879.5116444181129068578.stgit@aravinda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch exports VPA related data such as stolen and
donated CPU cycles through /proc/powerpc/lparcfg file.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/lppaca.h        |   10 ++++++-
 arch/powerpc/platforms/pseries/lparcfg.c |   45 ++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 7c23ce8..87e22f6 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -94,7 +94,15 @@ struct lppaca {
 	volatile __be32 dispersion_count; /* dispatch changed physical cpu */
 	volatile __be64 cmo_faults;	/* CMO page fault count */
 	volatile __be64 cmo_fault_time;	/* CMO page fault time */
-	u8	reserved10[104];
+	volatile __be64 idle_stolen_purr;
+	volatile __be64 idle_stolen_spurr;
+	volatile __be64 busy_stolen_purr;
+	volatile __be64 busy_stolen_spurr;
+	volatile __be64 idle_donated_purr;
+	volatile __be64 idle_donated_spurr;
+	volatile __be64 busy_donated_purr;
+	volatile __be64 busy_donated_spurr;
+	u8  reserved10[40];
 
 	/* cacheline 4-5 */
 
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 7c872dc..b986551 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -433,6 +433,50 @@ static void parse_em_data(struct seq_file *m)
 		seq_printf(m, "power_mode_data=%016lx\n", retbuf[0]);
 }
 
+static void pseries_vpa_data(struct seq_file *m)
+{
+	int cpu;
+	unsigned long idle_stolen_purr = 0;
+	unsigned long idle_stolen_spurr = 0;
+	unsigned long busy_stolen_purr = 0;
+	unsigned long busy_stolen_spurr = 0;
+	unsigned long idle_donated_purr = 0;
+	unsigned long idle_donated_spurr = 0;
+	unsigned long busy_donated_purr = 0;
+	unsigned long busy_donated_spurr = 0;
+
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		idle_stolen_purr +=
+			be64_to_cpu(lppaca_of(cpu).idle_stolen_purr);
+		idle_stolen_spurr +=
+			be64_to_cpu(lppaca_of(cpu).idle_stolen_spurr);
+		busy_stolen_purr +=
+			be64_to_cpu(lppaca_of(cpu).busy_stolen_purr);
+		busy_stolen_spurr +=
+			be64_to_cpu(lppaca_of(cpu).busy_stolen_spurr);
+		idle_donated_purr +=
+			be64_to_cpu(lppaca_of(cpu).idle_donated_purr);
+		idle_donated_spurr +=
+			be64_to_cpu(lppaca_of(cpu).idle_donated_spurr);
+		busy_donated_purr +=
+			be64_to_cpu(lppaca_of(cpu).busy_donated_purr);
+		busy_donated_spurr +=
+			be64_to_cpu(lppaca_of(cpu).busy_donated_spurr);
+	}
+
+	seq_printf(m, "idle_stolen_purr=%lu\n", idle_stolen_purr);
+	seq_printf(m, "idle_stolen_spurr=%lu\n", idle_stolen_spurr);
+	seq_printf(m, "busy_stolen_purr=%lu\n", busy_stolen_purr);
+	seq_printf(m, "busy_stolen_spurr=%lu\n", busy_stolen_spurr);
+	seq_printf(m, "idle_donated_purr=%lu\n", idle_donated_purr);
+	seq_printf(m, "idle_donated_spurr=%lu\n", idle_donated_spurr);
+	seq_printf(m, "busy_donated_purr=%lu\n", busy_donated_purr);
+	seq_printf(m, "busy_donated_spurr=%lu\n", busy_donated_spurr);
+}
+
 static int pseries_lparcfg_data(struct seq_file *m, void *v)
 {
 	int partition_potential_processors;
@@ -491,6 +535,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
 #endif
 	parse_em_data(m);
+	pseries_vpa_data(m);
 
 	return 0;
 }
