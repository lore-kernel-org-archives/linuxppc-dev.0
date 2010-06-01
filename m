Return-Path: <anton@ozlabs.org>
Date: Tue, 1 Jun 2010 14:45:11 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, michael@ellerman.id.au, amodra@gmail.com
Subject: [PATCH] powerpc: Optimise per cpu accesses on 64bit
Message-ID: <20100601044511.GF28295@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Now we dynamically allocate the paca array, it takes an extra load
whenever we want to access another cpu's paca. One place we do that a lot
is per cpu variables. A simple example:

DEFINE_PER_CPU(unsigned long, vara);
unsigned long test4(int cpu)
{
	return per_cpu(vara, cpu);
}

This takes 4 loads, 5 if you include the actual load of the per cpu variable:

    ld r11,-32760(r30)  # load address of paca pointer
    ld r9,-32768(r30)   # load link address of percpu variable
    sldi r3,r29,9       # get offset into paca (each entry is 512 bytes)
    ld r0,0(r11)        # load paca pointer
    add r3,r0,r3        # paca + offset
    ld r11,64(r3)       # load paca[cpu].data_offset

    ldx r3,r9,r11       # load per cpu variable

If we remove the ppc64 specific per_cpu_offset(), we get the generic one
which indexes into a statically allocated array. This removes one load and
one add:

    ld r11,-32760(r30)  # load address of __per_cpu_offset
    ld r9,-32768(r30)   # load link address of percpu variable
    sldi r3,r29,3       # get offset into __per_cpu_offset (each entry 8 bytes)
    ldx r11,r11,r3      # load __per_cpu_offset[cpu]

    ldx r3,r9,r11       # load per cpu variable

Having all the offsets in one array also helps when iterating over a per cpu
variable across a number of cpus, such as in the scheduler. Before we would
need to load one paca cacheline when calculating each per cpu offset. Now we
have 16 (128 / sizeof(long)) per cpu offsets in each cacheline.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/percpu.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/percpu.h	2010-06-01 11:10:16.225954322 +1000
+++ powerpc.git/arch/powerpc/include/asm/percpu.h	2010-06-01 11:32:27.713476455 +1000
@@ -1,7 +1,6 @@
 #ifndef _ASM_POWERPC_PERCPU_H_
 #define _ASM_POWERPC_PERCPU_H_
 #ifdef __powerpc64__
-#include <linux/compiler.h>
 
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
@@ -12,9 +11,7 @@
 
 #include <asm/paca.h>
 
-#define __per_cpu_offset(cpu) (paca[cpu].data_offset)
 #define __my_cpu_offset local_paca->data_offset
-#define per_cpu_offset(x) (__per_cpu_offset(x))
 
 #endif /* CONFIG_SMP */
 #endif /* __powerpc64__ */
Index: powerpc.git/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/asm-offsets.c	2010-06-01 11:10:16.195958268 +1000
+++ powerpc.git/arch/powerpc/kernel/asm-offsets.c	2010-06-01 11:32:27.713476455 +1000
@@ -194,7 +194,6 @@ int main(void)
 	DEFINE(PACA_STARTSPURR, offsetof(struct paca_struct, startspurr));
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
-	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
 	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	DEFINE(PACA_KVM_SVCPU, offsetof(struct paca_struct, shadow_vcpu));
Index: powerpc.git/arch/powerpc/kernel/setup_64.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/setup_64.c	2010-06-01 11:10:16.205958158 +1000
+++ powerpc.git/arch/powerpc/kernel/setup_64.c	2010-06-01 11:32:27.713476455 +1000
@@ -604,6 +604,9 @@ static int pcpu_cpu_distance(unsigned in
 		return REMOTE_DISTANCE;
 }
 
+unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(__per_cpu_offset);
+
 void __init setup_per_cpu_areas(void)
 {
 	const size_t dyn_size = PERCPU_MODULE_RESERVE + PERCPU_DYNAMIC_RESERVE;
@@ -628,8 +631,10 @@ void __init setup_per_cpu_areas(void)
 		panic("cannot initialize percpu area (err=%d)", rc);
 
 	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
-	for_each_possible_cpu(cpu)
-		paca[cpu].data_offset = delta + pcpu_unit_offsets[cpu];
+	for_each_possible_cpu(cpu) {
+                __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
+		paca[cpu].data_offset = __per_cpu_offset[cpu];
+	}
 }
 #endif
 
