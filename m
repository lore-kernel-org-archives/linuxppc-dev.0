Return-Path: <mkravetz@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3D8267BA3
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 16:48:09 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6L6m64X028720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 02:48:06 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6L6m6Vh154342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 00:48:06 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6L6m6hT002304
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 00:48:06 -0600
Date: Thu, 20 Jul 2006 23:48:05 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add
	instrumentation
Message-ID: <20060721064805.GE8639@monkey.ibm.com>
References: <20060721063824.GA8639@monkey.ibm.com>
	<20060721064153.GC8639@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060721064153.GC8639@monkey.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2006 at 11:41:53PM -0700, Mike Kravetz wrote:
> Gather snapshots in the hcall routines and make callout to update data.

Wrong patch!!!!  Sorry!  Here is the correct one.

Gather snapshots in the hcall routines and make callout to update data.
--
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr powerpc/arch/powerpc/Kconfig.debug powerpc.work/arch/powerpc/Kconfig.debug
--- powerpc/arch/powerpc/Kconfig.debug	2006-07-19 18:45:58.000000000 +0000
+++ powerpc.work/arch/powerpc/Kconfig.debug	2006-07-21 07:06:49.000000000 +0000
@@ -18,6 +18,20 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
+config HCALL_STATS
+	bool "Hypervisor call instrumentation"
+	depends on PPC_PSERIES && DEBUG_FS
+	help
+	  Adds code to keep track of the number of hypervisor calls made and
+	  the amount of time spent in hypervisor calls: both wall time (based
+	  on time base) and cpu time (based on PURR).  A directory named
+	  hcall_inst is added at the root of the debugfs filesystem.  Within
+	  the hcall_inst directory are files that contain CPU specific call
+	  statistics.
+
+	  This option will add a small amount of overhead to all hypervisor
+	  calls.
+
 config DEBUGGER
 	bool "Enable debugger hooks"
 	depends on DEBUG_KERNEL
diff -Naupr powerpc/arch/powerpc/platforms/pseries/Makefile powerpc.work/arch/powerpc/platforms/pseries/Makefile
--- powerpc/arch/powerpc/platforms/pseries/Makefile	2006-07-19 18:46:08.000000000 +0000
+++ powerpc.work/arch/powerpc/platforms/pseries/Makefile	2006-07-21 07:06:49.000000000 +0000
@@ -12,3 +12,4 @@ obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o e
 
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
+obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
diff -Naupr powerpc/arch/powerpc/platforms/pseries/hvCall.S powerpc.work/arch/powerpc/platforms/pseries/hvCall.S
--- powerpc/arch/powerpc/platforms/pseries/hvCall.S	2006-07-19 18:58:18.000000000 +0000
+++ powerpc.work/arch/powerpc/platforms/pseries/hvCall.S	2006-07-21 07:06:49.000000000 +0000
@@ -11,7 +11,57 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 	
-#define STK_PARM(i)     (48 + ((i)-3)*8)
+#define STK_PARM(i)     (STACKFRAMESIZE + 48 + ((i)-3)*8)
+#define STK_REG(i)      (112 + ((i)-14)*8)
+
+#ifdef CONFIG_HCALL_STATS
+#define STACKFRAMESIZE  256
+#define HCALL_INST_PRECALL					\
+	/* use stack frame to save a few non-volital regs */	\
+	stdu    r1,-STACKFRAMESIZE(r1);				\
+	std     r31,STK_REG(r31)(r1);				\
+	std     r30,STK_REG(r30)(r1);				\
+	std     r29,STK_REG(r29)(r1);				\
+	std     r28,STK_REG(r28)(r1);				\
+								\
+	/* save lr and hcall opcode */				\
+	/* then get time, purr snapshot before hcall */		\
+	mflr	r31;						\
+	mr	r30,r3;						\
+	mftb	r29;						\
+BEGIN_FTR_SECTION;						\
+	mfspr	r28,SPRN_PURR;					\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);
+
+#define HCALL_INST_POSTCALL					\
+	/* get time, purr snapshot after hcall */		\
+	mftb	r4;						\
+BEGIN_FTR_SECTION;						\
+	mfspr	r5,SPRN_PURR;					\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
+								\
+	/* setup regs to call routine that stuffs stats */	\
+	/* into per-cpu/per-call structure.		*/	\
+	subf	r4,r29,r4;					\
+	subf	r5,r28,r5;					\
+	mr	r29,r3;		/* save hcall rc  */		\
+	mr	r3,r30;						\
+	bl	.update_hcall_stats;				\
+								\
+	/* restore hcall rc, lr and non-volital regs */		\
+	mr	r3,r29;						\
+	mtlr	r31;						\
+	ld      r31,STK_REG(r31)(r1);				\
+	ld      r30,STK_REG(r30)(r1);				\
+	ld      r29,STK_REG(r29)(r1);				\
+	ld      r28,STK_REG(r28)(r1);				\
+	addi    r1,r1,STACKFRAMESIZE
+#else
+
+#define STACKFRAMESIZE	0
+#define HCALL_INST_PRECALL	nop
+#define HCALL_INST_POSTCALL	nop
+#endif
 
 	.text
 
@@ -21,8 +71,12 @@ _GLOBAL(plpar_hcall_norets)
 	mfcr	r0
 	stw	r0,8(r1)
 
+	HCALL_INST_PRECALL
+
 	HVSC				/* invoke the hypervisor */
 
+	HCALL_INST_POSTCALL
+
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 	blr				/* return r3 = status */
@@ -33,6 +87,8 @@ _GLOBAL(plpar_hcall)
 	mfcr	r0
 	stw	r0,8(r1)
 
+	HCALL_INST_PRECALL
+
 	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
@@ -50,6 +106,8 @@ _GLOBAL(plpar_hcall)
 	std	r6, 16(r12)
 	std	r7, 24(r12)
 
+	HCALL_INST_POSTCALL
+
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 
@@ -61,6 +119,8 @@ _GLOBAL(plpar_hcall9)
 	mfcr	r0
 	stw	r0,8(r1)
 
+	HCALL_INST_PRECALL
+
 	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
@@ -86,6 +146,8 @@ _GLOBAL(plpar_hcall9)
 	std	r11,56(r12)
 	std	r12,64(r12)
 
+	HCALL_INST_POSTCALL
+
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 
diff -Naupr powerpc/arch/powerpc/platforms/pseries/hvCall_inst.c powerpc.work/arch/powerpc/platforms/pseries/hvCall_inst.c
--- powerpc/arch/powerpc/platforms/pseries/hvCall_inst.c	1970-01-01 00:00:00.000000000 +0000
+++ powerpc.work/arch/powerpc/platforms/pseries/hvCall_inst.c	2006-07-21 07:08:40.000000000 +0000
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2006 Mike Kravetz IBM Corporation
+ *
+ * Hypervisor Call Instrumentation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/cpumask.h>
+#include <asm/hvcall.h>
+#include <asm/firmware.h>
+
+DEFINE_PER_CPU(struct hcall_stats[MAX_HCALL_OPCODES+1], hcall_stats);
+
+/*
+ * Common update of the per-CPU/per-hcall statistics
+ */
+void update_hcall_stats(unsigned long opcode,
+				unsigned long tb_delta,
+				unsigned long purr_delta)
+{
+	unsigned long op_index = opcode >> 2;
+	struct hcall_stats *hs = &__get_cpu_var(hcall_stats[op_index]);
+
+	hs->tb_total += tb_delta;
+	hs->purr_total += purr_delta;
+	hs->num_calls++;
+}
diff -Naupr powerpc/include/asm-powerpc/hvcall.h powerpc.work/include/asm-powerpc/hvcall.h
--- powerpc/include/asm-powerpc/hvcall.h	2006-07-21 07:04:39.000000000 +0000
+++ powerpc.work/include/asm-powerpc/hvcall.h	2006-07-21 07:06:49.000000000 +0000
@@ -246,6 +246,15 @@ long plpar_hcall(unsigned long opcode, u
 #define PLPAR_HCALL9_BUFSIZE 9
 long plpar_hcall9(unsigned long opcode, unsigned long *retbuf, ...);
 
+/* For hcall instrumentation.  One structure per-hcall, per-CPU */
+struct hcall_stats {
+	unsigned long	num_calls;	/* number of calls (on this CPU) */
+	unsigned long	tb_total;	/* total wall time (mftb) of calls. */
+	unsigned long	purr_total;	/* total cpu time (PURR) of calls. */
+};
+void update_hcall_stats(unsigned long opcode, unsigned long tb_delta,
+			unsigned long purr_delta);
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
