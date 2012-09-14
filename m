Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add an xmon command to dump one or all pacas
Date: Fri, 14 Sep 2012 16:03:57 +1000
Message-Id: <1347602637-18683-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was originally motivated by a desire to see the mapping between
logical and hardware cpu numbers.

But it seemed that it made more sense to just add a command to dump
(most of) the paca.

With no arguments "dp" will dump the paca for the current cpu.

It also takes an argument, eg. "dp 3" which is the logical cpu number
in hex. This form does not check if the cpu is possible, but displays
the paca regardless, as well as the cpu's state in the possible, present
and online masks.

Thirdly, "dpa" will display the paca for all possible cpus. If there are
no possible cpus, like early in boot, it will tell you that.

Sample output, number in brackets is the offset into the struct:

2:mon> dp 3
paca for cpu 0x3 @ c00000000ff20a80:
 possible         = yes
 present          = yes
 online           = yes
 lock_token       = 0x8000            	(0x8)
 paca_index       = 0x3               	(0xa)
 kernel_toc       = 0xc00000000144f990	(0x10)
 kernelbase       = 0xc000000000000000	(0x18)
 kernel_msr       = 0xb000000000001032	(0x20)
 stab_real        = 0x0               	(0x28)
 stab_addr        = 0x0               	(0x30)
 emergency_sp     = 0xc00000003ffe4000	(0x38)
 data_offset      = 0xa40000          	(0x40)
 hw_cpu_id        = 0x9               	(0x50)
 cpu_start        = 0x1               	(0x52)
 kexec_state      = 0x0               	(0x53)
 __current        = 0xc00000007e568680	(0x218)
 kstack           = 0xc00000007e5a3e30	(0x220)
 stab_rr          = 0x1a              	(0x228)
 saved_r1         = 0xc00000007e7cb450	(0x230)
 trap_save        = 0x0               	(0x240)
 soft_enabled     = 0x0               	(0x242)
 irq_happened     = 0x0               	(0x243)
 io_sync          = 0x0               	(0x244)
 irq_work_pending = 0x0               	(0x245)
 nap_state_lost   = 0x0               	(0x246)

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

---

v2: Fix macro per sfr's comments. Change dp to show current cpu's paca,
    and add dpa to show all.
---
 arch/powerpc/xmon/xmon.c |   95 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9b49c65..2a2339f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -203,6 +203,8 @@ Commands:\n\
   df	dump float values\n\
   dd	dump double values\n\
   dl    dump the kernel log buffer\n\
+  dp[#]	dump paca for current cpu, or cpu #\n\
+  dpa	dump paca for all possible cpus\n\
   dr	dump stream of raw bytes\n\
   e	print exception information\n\
   f	flush cache\n\
@@ -2009,6 +2011,93 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
 	printf("\n");
 }
 
+static void dump_one_paca(int cpu)
+{
+	struct paca_struct *p;
+
+	if (setjmp(bus_error_jmp) != 0) {
+		printf("*** Error dumping paca for cpu 0x%x!\n", cpu);
+		return;
+	}
+
+	catch_memory_errors = 1;
+	sync();
+
+	p = &paca[cpu];
+
+	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
+
+	printf(" %-*s = %s\n", 16, "possible", cpu_possible(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
+
+#define DUMP(paca, name, format) \
+	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, paca->name, \
+		offsetof(struct paca_struct, name));
+
+	DUMP(p, lock_token, "x");
+	DUMP(p, paca_index, "x");
+	DUMP(p, kernel_toc, "lx");
+	DUMP(p, kernelbase, "lx");
+	DUMP(p, kernel_msr, "lx");
+#ifdef CONFIG_PPC_STD_MMU_64
+	DUMP(p, stab_real, "lx");
+	DUMP(p, stab_addr, "lx");
+#endif
+	DUMP(p, emergency_sp, "p");
+	DUMP(p, data_offset, "lx");
+	DUMP(p, hw_cpu_id, "x");
+	DUMP(p, cpu_start, "x");
+	DUMP(p, kexec_state, "x");
+	DUMP(p, __current, "p");
+	DUMP(p, kstack, "lx");
+	DUMP(p, stab_rr, "lx");
+	DUMP(p, saved_r1, "lx");
+	DUMP(p, trap_save, "x");
+	DUMP(p, soft_enabled, "x");
+	DUMP(p, irq_happened, "x");
+	DUMP(p, io_sync, "x");
+	DUMP(p, irq_work_pending, "x");
+	DUMP(p, nap_state_lost, "x");
+
+#undef DUMP
+
+	catch_memory_errors = 0;
+	sync();
+}
+
+static void dump_all_pacas(void)
+{
+	int cpu;
+
+	if (num_possible_cpus() == 0) {
+		printf("No possible cpus, use 'dp #' to dump individual cpus\n");
+		return;
+	}
+
+	for_each_possible_cpu(cpu)
+		dump_one_paca(cpu);
+}
+
+static void dump_pacas(void)
+{
+	unsigned long num;
+	int c;
+
+	c = inchar();
+	if (c == 'a') {
+		dump_all_pacas();
+		return;
+	}
+
+	termch = c;	/* Put c back, it wasn't 'a' */
+
+	if (scanhex(&num))
+		dump_one_paca(num);
+	else
+		dump_one_paca(xmon_owner);
+}
+
 #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
 			 || ('a' <= (c) && (c) <= 'f') \
 			 || ('A' <= (c) && (c) <= 'F'))
@@ -2018,6 +2107,12 @@ dump(void)
 	int c;
 
 	c = inchar();
+
+	if (c == 'p') {
+		dump_pacas();
+		return;
+	}
+
 	if ((isxdigit(c) && c != 'f' && c != 'd') || c == '\n')
 		termch = c;
 	scanhex((void *)&adrs);
-- 
1.7.9.5
