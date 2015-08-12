Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C860E1A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 21:55:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: khandual@linux.vnet.ibm.com
Subject: [PATCH v2] powerpc/xmon: Allow limiting the size of the paca display
Date: Wed, 12 Aug 2015 21:55:25 +1000
Message-Id: <1439380525-9986-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1439362653-14665-1-git-send-email-mpe@ellerman.id.au>
References: <1439362653-14665-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The paca display is already more than 24 lines, which can be problematic
if you have an old school 80x24 terminal, or more likely you are on a
virtual terminal which does not scroll for whatever reason.

We'd like to expand the paca display even more, so add a way to limit
the number of lines that are displayed.

This adds a third form of 'dp' which is 'dp # #', where the first number
is the cpu, and the second is the number of lines to display.

Example output:

  5:mon> dp 3 6
  paca for cpu 0x3 @ c00000000fe00c00:
   possible         = yes
   present          = yes
   online           = yes
   lock_token       = 0x8000            	(0xa)
   paca_index       = 0x3               	(0x8)
   kernel_toc       = 0xc000000001230300	(0x10)

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

v2: Honour the limit even for the initial lines, and change the
    implementation to use goto to bail out early rather than checking
    continuously.


 arch/powerpc/xmon/xmon.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e599259d84fc..2950c6aface4 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -205,6 +205,7 @@ Commands:\n\
 #ifdef CONFIG_PPC64
   "\
   dp[#]	dump paca for current cpu, or cpu #\n\
+  dp##  dump paca for cpu #, only # lines\n\
   dpa	dump paca for all possible cpus\n"
 #endif
   "\
@@ -2070,9 +2071,10 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
 }
 
 #ifdef CONFIG_PPC64
-static void dump_one_paca(int cpu)
+static void dump_one_paca(int cpu, int num_lines)
 {
 	struct paca_struct *p;
+	int line;
 
 	if (setjmp(bus_error_jmp) != 0) {
 		printf("*** Error dumping paca for cpu 0x%x!\n", cpu);
@@ -2082,17 +2084,28 @@ static void dump_one_paca(int cpu)
 	catch_memory_errors = 1;
 	sync();
 
+#define CHECK_LINE()				\
+	if (num_lines && line++ >= num_lines)	\
+		goto out;			\
+
+#define DUMP(paca, name, format)					\
+	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18,	\
+	       paca->name, offsetof(struct paca_struct, name));		\
+	CHECK_LINE();
+
 	p = &paca[cpu];
 
+	line = 0;
+
 	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
+	CHECK_LINE();
 
 	printf(" %-*s = %s\n", 16, "possible", cpu_possible(cpu) ? "yes" : "no");
+	CHECK_LINE();
 	printf(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
+	CHECK_LINE();
 	printf(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
-
-#define DUMP(paca, name, format) \
-	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, paca->name, \
-		offsetof(struct paca_struct, name));
+	CHECK_LINE();
 
 	DUMP(p, lock_token, "x");
 	DUMP(p, paca_index, "x");
@@ -2119,8 +2132,10 @@ static void dump_one_paca(int cpu)
 	DUMP(p, irq_work_pending, "x");
 	DUMP(p, nap_state_lost, "x");
 
+#undef CHECK_LINE
 #undef DUMP
 
+out:
 	catch_memory_errors = 0;
 	sync();
 }
@@ -2135,12 +2150,12 @@ static void dump_all_pacas(void)
 	}
 
 	for_each_possible_cpu(cpu)
-		dump_one_paca(cpu);
+		dump_one_paca(cpu, 0);
 }
 
 static void dump_pacas(void)
 {
-	unsigned long num;
+	unsigned long num, lines;
 	int c;
 
 	c = inchar();
@@ -2151,10 +2166,13 @@ static void dump_pacas(void)
 
 	termch = c;	/* Put c back, it wasn't 'a' */
 
-	if (scanhex(&num))
-		dump_one_paca(num);
-	else
-		dump_one_paca(xmon_owner);
+	num = xmon_owner;
+	scanhex(&num);
+
+	lines = 0;
+	scanhex(&lines);
+
+	dump_one_paca(num, lines);
 }
 #endif
 
-- 
2.1.4
