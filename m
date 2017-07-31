Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLmV860fszDrF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 03:22:24 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VHJ6iU144106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:22:21 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c27csms3a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:22:21 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 31 Jul 2017 14:22:19 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6VHMFPO22675708
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 14:22:15 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6VHMIxn031956
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 14:22:18 -0300
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH 1/3] powerpc/xmon: Dump ftrace buffers for the current CPU
Date: Mon, 31 Jul 2017 14:22:09 -0300
Message-Id: <1501521731-12123-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current xmon 'dt' command dumps the tracing buffer for all the CPUs,
which makes it possibly hard to read the logs due to the fact that most
of powerpc machines currently have many CPUs. Other than that, the CPU
lines are interleaved in the ftrace log.

This new option just dumps the ftrace buffer for the current CPU.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/xmon/xmon.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 08e367e3e8c3..0cbd910193fa 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -234,6 +234,7 @@ Commands:\n\
   "\
   dr	dump stream of raw bytes\n\
   dt	dump the tracing buffers (uses printk)\n\
+  dtc	dump the tracing buffers for current CPU (uses printk)\n\
 "
 #ifdef CONFIG_PPC_POWERNV
 "  dx#   dump xive on CPU #\n\
@@ -2342,6 +2343,19 @@ static void dump_one_paca(int cpu)
 	sync();
 }
 
+static void dump_tracing(void)
+{
+	int c;
+
+	c = inchar();
+	if (c == 'c')
+		ftrace_dump(DUMP_ORIG);
+	else
+		ftrace_dump(DUMP_ALL);
+
+	tracing_on();
+}
+
 static void dump_all_pacas(void)
 {
 	int cpu;
@@ -2507,6 +2521,11 @@ dump(void)
 	}
 #endif
 
+	if (c == 't') {
+		dump_tracing();
+		return;
+	}
+
 	if (c == '\n')
 		termch = c;
 
@@ -2525,9 +2544,6 @@ dump(void)
 		dump_log_buf();
 	} else if (c == 'o') {
 		dump_opal_msglog();
-	} else if (c == 't') {
-		ftrace_dump(DUMP_ALL);
-		tracing_on();
 	} else if (c == 'r') {
 		scanhex(&ndump);
 		if (ndump == 0)
-- 
2.13.2
