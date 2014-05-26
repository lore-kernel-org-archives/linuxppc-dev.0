Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A38881A0590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 21:02:19 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] xmon: Fix up xmon format strings
Date: Mon, 26 May 2014 21:02:14 +1000
Message-Id: <1401102134-3125-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are a couple of places where xmon is using %x to print values that
are unsigned long.

I found this out the hard way recently:

 0:mon> p c000000000d0e7c8 c00000033dc90000 00000000a0000089 c000000000000000
 return value is 0x96300500

Which is calling find_linux_pte_or_hugepte(), the result should be a
kernel pointer. After decoding the page tables by hand I discovered the
correct value was c000000396300500.

So fix up that case and a few others.

We also use a mix of 0x%x, %x and %u to print cpu numbers. So
standardise on 0x%x.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 08504e7..3fd1d9a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -419,7 +419,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		get_output_lock();
 		excprint(regs);
 		if (bp) {
-			printf("cpu 0x%x stopped at breakpoint 0x%x (",
+			printf("cpu 0x%x stopped at breakpoint 0x%lx (",
 			       cpu, BP_NUM(bp));
 			xmon_print_symbol(regs->nip, " ", ")\n");
 		}
@@ -513,7 +513,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		excprint(regs);
 		bp = at_breakpoint(regs->nip);
 		if (bp) {
-			printf("Stopped at breakpoint %x (", BP_NUM(bp));
+			printf("Stopped at breakpoint %lx (", BP_NUM(bp));
 			xmon_print_symbol(regs->nip, " ", ")\n");
 		}
 		if (unrecoverable_excp(regs))
@@ -997,14 +997,14 @@ static int cpu_cmd(void)
 					last_cpu = cpu;
 				} else {
 					if (last_cpu != first_cpu)
-						printf("-%lx", last_cpu);
+						printf("-0x%lx", last_cpu);
 					last_cpu = first_cpu = cpu;
-					printf(" %lx", cpu);
+					printf(" 0x%lx", cpu);
 				}
 			}
 		}
 		if (last_cpu != first_cpu)
-			printf("-%lx", last_cpu);
+			printf("-0x%lx", last_cpu);
 		printf("\n");
 		return 0;
 	}
@@ -1024,7 +1024,7 @@ static int cpu_cmd(void)
 			/* take control back */
 			mb();
 			xmon_owner = smp_processor_id();
-			printf("cpu %u didn't take control\n", cpu);
+			printf("cpu 0x%x didn't take control\n", cpu);
 			return 0;
 		}
 		barrier();
@@ -1086,7 +1086,7 @@ csum(void)
 	fcs = 0xffff;
 	for (i = 0; i < ncsum; ++i) {
 		if (mread(adrs+i, &v, 1) == 0) {
-			printf("csum stopped at %x\n", adrs+i);
+			printf("csum stopped at "REG"\n", adrs+i);
 			break;
 		}
 		fcs = FCS(fcs, v);
@@ -1202,12 +1202,12 @@ bpt_cmds(void)
 			/* assume a breakpoint address */
 			bp = at_breakpoint(a);
 			if (bp == NULL) {
-				printf("No breakpoint at %x\n", a);
+				printf("No breakpoint at %lx\n", a);
 				break;
 			}
 		}
 
-		printf("Cleared breakpoint %x (", BP_NUM(bp));
+		printf("Cleared breakpoint %lx (", BP_NUM(bp));
 		xmon_print_symbol(bp->address, " ", ")\n");
 		bp->enabled = 0;
 		break;
@@ -1746,7 +1746,7 @@ mwrite(unsigned long adrs, void *buf, int size)
 		__delay(200);
 		n = size;
 	} else {
-		printf("*** Error writing address %x\n", adrs + n);
+		printf("*** Error writing address "REG"\n", adrs + n);
 	}
 	catch_memory_errors = 0;
 	return n;
@@ -2435,7 +2435,7 @@ static void proccall(void)
 		ret = func(args[0], args[1], args[2], args[3],
 			   args[4], args[5], args[6], args[7]);
 		sync();
-		printf("return value is %x\n", ret);
+		printf("return value is 0x%lx\n", ret);
 	} else {
 		printf("*** %x exception occurred\n", fault_except);
 	}
@@ -2700,7 +2700,7 @@ static void dump_slb(void)
 	unsigned long esid,vsid,valid;
 	unsigned long llp;
 
-	printf("SLB contents of cpu %x\n", smp_processor_id());
+	printf("SLB contents of cpu 0x%x\n", smp_processor_id());
 
 	for (i = 0; i < mmu_slb_size; i++) {
 		asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (i));
@@ -2732,7 +2732,7 @@ static void dump_stab(void)
 	int i;
 	unsigned long *tmp = (unsigned long *)local_paca->stab_addr;
 
-	printf("Segment table contents of cpu %x\n", smp_processor_id());
+	printf("Segment table contents of cpu 0x%x\n", smp_processor_id());
 
 	for (i = 0; i < PAGE_SIZE/16; i++) {
 		unsigned long a, b;
-- 
1.9.1
