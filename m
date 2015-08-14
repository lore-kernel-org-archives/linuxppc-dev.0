Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77A841A1D39
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 12:56:17 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 463DE14018C
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 12:56:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 14 Aug 2015 12:56:16 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 907DF2CE8052
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 12:56:13 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E2u4W436831302
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 12:56:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E2teYH010183
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 12:55:41 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com
Subject: [PATCH 1/1] powerpc/xmon: Paged output for paca display
Date: Fri, 14 Aug 2015 12:55:14 +1000
Message-Id: <e9e27ee5cee97ac3be2599646243fefc319f92a9.1439520906.git.sam.bobroff@au1.ibm.com>
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

This adds an optional letter to the "dp" and "dpa" xmon commands
("dpp" and "dppa"), which will enable a "per-page" display (with 16
line pages): the first page  will be displayed and if there was data
that didn't fit, it will display a message indicating that the user can
use enter to display the next page. The intent is that this feels
similar to the way the memory display functions work.

This is implemented by running over the entire output both for the
initial command and for each subsequent page: the visible part is
clipped out by checking line numbers. Handling the empty command as
"more" is done by writing a special command into a static buffer that
indicates where to move the sliding visibility window. This is similar
to the approach used for the memory dump commands except that the
state data is encoded into the "last_cmd" string, rather than a set of
static variables. The memory dump commands could probably be rewritten
to make use of the same buffer and remove their other static
variables.

Sample output:

0:mon> dpp1
paca for cpu 0x1 @ c00000000fdc0480:
 possible         = yes
 present          = yes
 online           = yes
 lock_token       = 0x8000            	(0x8)
 paca_index       = 0x1               	(0xa)
 kernel_toc       = 0xc000000000eb2400	(0x10)
 kernelbase       = 0xc000000000000000	(0x18)
 kernel_msr       = 0xb000000000001032	(0x20)
 emergency_sp     = 0xc00000003ffe8000	(0x28)
 mc_emergency_sp  = 0xc00000003ffe4000	(0x2e0)
 in_mce           = 0x0               	(0x2e8)
 data_offset      = 0x7f170000        	(0x30)
 hw_cpu_id        = 0x8               	(0x38)
 cpu_start        = 0x1               	(0x3a)
 kexec_state      = 0x0               	(0x3b)
[Enter for next page]
0:mon>
 __current        = 0xc00000007e696620	(0x290)
 kstack           = 0xc00000007e6ebe30	(0x298)
 stab_rr          = 0xb               	(0x2a0)
 saved_r1         = 0xc00000007ef37860	(0x2a8)
 trap_save        = 0x0               	(0x2b8)
 soft_enabled     = 0x0               	(0x2ba)
 irq_happened     = 0x1               	(0x2bb)
 io_sync          = 0x0               	(0x2bc)
 irq_work_pending = 0x0               	(0x2bd)
 nap_state_lost   = 0x0               	(0x2be)
0:mon>

(Based on a similar patch by Michael Ellerman <mpe@ellerman.id.au>
"[v2] powerpc/xmon: Allow limiting the size of the paca display".
This patch is an alternative and cannot coexist with the original.)

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---

 arch/powerpc/xmon/xmon.c | 82 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e599259..9157286 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -72,6 +72,7 @@ static int xmon_gate;
 
 static unsigned long in_xmon __read_mostly = 0;
 
+static char last_cmd_buf[128];
 static unsigned long adrs;
 static int size = 1;
 #define MAX_DUMP (128 * 1024)
@@ -204,8 +205,8 @@ Commands:\n\
   dl    dump the kernel log buffer\n"
 #ifdef CONFIG_PPC64
   "\
-  dp[#]	dump paca for current cpu, or cpu #\n\
-  dpa	dump paca for all possible cpus\n"
+  dp[p][#]	dump paca for current cpu, or cpu # (p = paged)\n\
+  dp[p]a	dump paca for all possible cpus (p = paged)\n"
 #endif
   "\
   dr	dump stream of raw bytes\n\
@@ -2070,7 +2071,17 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
 }
 
 #ifdef CONFIG_PPC64
-static void dump_one_paca(int cpu)
+static bool line_visible(unsigned long start, unsigned long count,
+			 unsigned long *line) {
+	bool rv = (!count
+	|| ((*line >= start) && (*line < (start + count))));
+
+	(*line)++;
+	return rv;
+}
+
+static void dump_one_paca(int cpu, unsigned long start,
+			  unsigned long count, unsigned long *line)
 {
 	struct paca_struct *p;
 
@@ -2084,15 +2095,22 @@ static void dump_one_paca(int cpu)
 
 	p = &paca[cpu];
 
-	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
+#define VPRINT(...) do { \
+	if (line_visible(start, count, line)) \
+		printf(__VA_ARGS__); \
+} while (0)
+	VPRINT("paca for cpu 0x%x @ %p:\n", cpu, p);
 
-	printf(" %-*s = %s\n", 16, "possible", cpu_possible(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
+	VPRINT(" %-*s = %s\n", 16, "possible", cpu_possible(cpu) ? "yes" : "no");
+	VPRINT(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
+	VPRINT(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
+#undef VPRINT
 
-#define DUMP(paca, name, format) \
-	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, paca->name, \
-		offsetof(struct paca_struct, name));
+#define DUMP(paca, name, format) do { \
+	if (line_visible(start, count, line)) \
+		printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, \
+		       paca->name, offsetof(struct paca_struct, name)); \
+} while (0)
 
 	DUMP(p, lock_token, "x");
 	DUMP(p, paca_index, "x");
@@ -2125,7 +2143,8 @@ static void dump_one_paca(int cpu)
 	sync();
 }
 
-static void dump_all_pacas(void)
+static void dump_all_pacas(unsigned long start, unsigned long count,
+			   unsigned long *line)
 {
 	int cpu;
 
@@ -2135,26 +2154,49 @@ static void dump_all_pacas(void)
 	}
 
 	for_each_possible_cpu(cpu)
-		dump_one_paca(cpu);
+		dump_one_paca(cpu, start, count, line);
 }
 
 static void dump_pacas(void)
 {
-	unsigned long num;
+	bool all, paged;
+	unsigned long num, start = 0, end, count = 0, line = 0;
 	int c;
 
 	c = inchar();
-	if (c == 'a') {
-		dump_all_pacas();
-		return;
+	paged = (c == 'p');
+	if (paged)
+		c = inchar();
+	all = (c == 'a');
+	if (!all) {
+		termch = c;
+		if (!scanhex(&num))
+			num = xmon_owner;
 	}
 
-	termch = c;	/* Put c back, it wasn't 'a' */
+	if (paged) {
+		count = 16;
+		scanhex(&start);
+		scanhex(&count);
+	}
 
-	if (scanhex(&num))
-		dump_one_paca(num);
+	if (all)
+		dump_all_pacas(start, count, &line);
 	else
-		dump_one_paca(xmon_owner);
+		dump_one_paca(num, start, count, &line);
+	if (count) {
+		end = start + count;
+		if (line > end) {
+			if (all)
+				snprintf(last_cmd_buf, sizeof(last_cmd_buf),
+					 "dppa %lx %lx\n", end, count);
+			else
+				snprintf(last_cmd_buf, sizeof(last_cmd_buf),
+					 "dpp%lx %lx %lx\n", num, end, count);
+			last_cmd = last_cmd_buf;
+			printf("[Enter for next page]\n");
+		}
+	}
 }
 #endif
 
-- 
2.1.4
