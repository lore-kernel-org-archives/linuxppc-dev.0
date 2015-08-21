Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBCE11A0220
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 14:25:35 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9F6F3140A9A
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 21 Aug 2015 14:25:32 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A144A2BB0054
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7L4PLpV11796684
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7L4OuHV006662
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:24:56 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com
Subject: [PATCH v2 1/2] powerpc/xmon: Paged output for paca display
Date: Fri, 21 Aug 2015 14:24:27 +1000
Message-Id: <c70f0ed969560abe15e6671f9feb129dca920e25.1440131027.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
References: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
References: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
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

This patch adds a new command ".", which takes a single (hex) numeric
argument: lines per page. It will cause the output of "dp" and "dpa"
to be broken into pages, if necessary.

This is implemented by running over the entire output both for the
initial command and for each subsequent page: the visible part is
clipped out by checking line numbers. This is a simplistic approach
but minimally invasive; it is intended to be easily reusable for other
commands.

Sample output:

0:mon> .10
0:mon> dp1
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
 arch/powerpc/xmon/xmon.c | 86 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e599259..9ce9e7d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -72,6 +72,12 @@ static int xmon_gate;
 
 static unsigned long in_xmon __read_mostly = 0;
 
+#define XMON_PRINTF(...) do { if (paged_vis()) printf(__VA_ARGS__); } while (0)
+#define MAX_PAGED_SIZE 1024
+static unsigned long paged_size = 0, paged_pos, paged_cur_page;
+#ifdef CONFIG_PPC64
+static unsigned long paca_cpu;
+#endif
 static unsigned long adrs;
 static int size = 1;
 #define MAX_DUMP (128 * 1024)
@@ -242,6 +248,9 @@ Commands:\n\
 "  u	dump TLB\n"
 #endif
 "  ?	help\n"
+#ifdef CONFIG_PPC64
+"  .#	limit output to # lines per page (dump paca only)\n"
+#endif
 "  zr	reboot\n\
   zh	halt\n"
 ;
@@ -833,6 +842,19 @@ static void remove_cpu_bpts(void)
 	write_ciabr(0);
 }
 
+static void paged_set_size(void)
+{
+	if (!scanhex(&paged_size) || (paged_size > MAX_PAGED_SIZE)) {
+		printf("Invalid number of lines per page (max: %d).\n",
+		       MAX_PAGED_SIZE);
+		paged_size = 0;
+	}
+}
+static void paged_reset(void)
+{
+	paged_cur_page = 0;
+}
+
 /* Command interpreting routine */
 static char *last_cmd;
 
@@ -863,7 +885,8 @@ cmds(struct pt_regs *excp)
 			take_input(last_cmd);
 			last_cmd = NULL;
 			cmd = inchar();
-		}
+		} else
+			paged_reset();
 		switch (cmd) {
 		case 'm':
 			cmd = inchar();
@@ -924,6 +947,9 @@ cmds(struct pt_regs *excp)
 		case '?':
 			xmon_puts(help_string);
 			break;
+		case '.':
+			paged_set_size();
+			break;
 		case 'b':
 			bpt_cmds();
 			break;
@@ -2069,6 +2095,31 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
 	printf("\n");
 }
 
+static void paged_start(void)
+{
+	paged_pos = 0;
+}
+
+static void paged_end(char *next_cmd)
+{
+	unsigned long next_page_start = ++paged_cur_page * paged_size;
+
+	if (paged_size && (paged_pos > next_page_start)) {
+		last_cmd = next_cmd;
+		printf("[Enter for next page]\n");
+	}
+}
+
+static bool paged_vis(void)
+{
+	bool rv = (!paged_size
+	|| ((paged_pos >= (paged_size * paged_cur_page))
+	&& (paged_pos < (paged_size * (paged_cur_page + 1)))));
+
+	paged_pos++;
+	return rv;
+}
+
 #ifdef CONFIG_PPC64
 static void dump_one_paca(int cpu)
 {
@@ -2084,15 +2135,17 @@ static void dump_one_paca(int cpu)
 
 	p = &paca[cpu];
 
-	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
+	XMON_PRINTF("paca for cpu 0x%x @ %p:\n", cpu, p);
 
-	printf(" %-*s = %s\n", 16, "possible", cpu_possible(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
+	XMON_PRINTF(" %-*s = %s\n", 16, "possible", cpu_possible(cpu) ? "yes" : "no");
+	XMON_PRINTF(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
+	XMON_PRINTF(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
 
-#define DUMP(paca, name, format) \
-	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, paca->name, \
-		offsetof(struct paca_struct, name));
+#define DUMP(paca, name, format) do { \
+		if (paged_vis()) \
+			printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, \
+			       paca->name, offsetof(struct paca_struct, name)); \
+} while (0)
 
 	DUMP(p, lock_token, "x");
 	DUMP(p, paca_index, "x");
@@ -2134,13 +2187,14 @@ static void dump_all_pacas(void)
 		return;
 	}
 
+	paged_start();
 	for_each_possible_cpu(cpu)
 		dump_one_paca(cpu);
+	paged_end("dpa\n");
 }
 
 static void dump_pacas(void)
 {
-	unsigned long num;
 	int c;
 
 	c = inchar();
@@ -2148,13 +2202,15 @@ static void dump_pacas(void)
 		dump_all_pacas();
 		return;
 	}
+	if (c != '_') {
+		termch = c;
+		if (!scanhex(&paca_cpu))
+			paca_cpu = xmon_owner;
+	}
 
-	termch = c;	/* Put c back, it wasn't 'a' */
-
-	if (scanhex(&num))
-		dump_one_paca(num);
-	else
-		dump_one_paca(xmon_owner);
+	paged_start();
+	dump_one_paca(paca_cpu);
+	paged_end("dp_\n");
 }
 #endif
 
-- 
2.1.4
