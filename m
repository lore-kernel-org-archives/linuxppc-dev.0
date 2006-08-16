Return-Path: <mkravetz@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BEEEA67B5C
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 02:04:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7GG4eb6026187
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 12:04:40 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7GG4eGn292004
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 12:04:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7GG4eIF029915
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 12:04:40 -0400
Date: Wed, 16 Aug 2006 09:04:57 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Instrument Hypervisor Calls
Message-ID: <20060816160456.GA4170@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add instrumentation for hypervisor calls on pseries.  Call statistics
include number of calls, wall time and cpu cycles (if available) and
are made available via debugfs.  Instrumentation code is behind the
HCALL_STATS config option and has no impact if not enabled.

-- 
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr powerpc2/arch/powerpc/Kconfig.debug powerpc2.work/arch/powerpc/Kconfig.debug
--- powerpc2/arch/powerpc/Kconfig.debug	2006-08-14 18:00:45.000000000 +0000
+++ powerpc2.work/arch/powerpc/Kconfig.debug	2006-08-15 18:45:57.000000000 +0000
@@ -18,6 +18,20 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
+config HCALL_STATS
+	bool "Hypervisor call instrumentation"
+	depends on PPC_PSERIES && DEBUG_FS
+	help
+	  Adds code to keep track of the number of hypervisor calls made and
+	  the amount of time spent in hypervisor callsr.  Wall time spent in
+	  each call is always calculated, and if available CPU cycles spent
+	  are also calculated.  A directory named hcall_inst is added at the
+	  root of the debugfs filesystem.  Within the hcall_inst directory
+	  are files that contain CPU specific call statistics.
+
+	  This option will add a small amount of overhead to all hypervisor
+	  calls.
+
 config DEBUGGER
 	bool "Enable debugger hooks"
 	depends on DEBUG_KERNEL
diff -Naupr powerpc2/arch/powerpc/kernel/asm-offsets.c powerpc2.work/arch/powerpc/kernel/asm-offsets.c
--- powerpc2/arch/powerpc/kernel/asm-offsets.c	2006-08-14 18:00:46.000000000 +0000
+++ powerpc2.work/arch/powerpc/kernel/asm-offsets.c	2006-08-14 22:22:49.000000000 +0000
@@ -136,6 +136,7 @@ int main(void)
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
+	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
 
 	DEFINE(LPPACASRR0, offsetof(struct lppaca, saved_srr0));
 	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
@@ -160,6 +161,12 @@ int main(void)
 	/* Create extra stack space for SRR0 and SRR1 when calling prom/rtas. */
 	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
 	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
+
+	/* hcall statistics */
+	DEFINE(HCALL_STAT_SIZE, sizeof(struct hcall_stats));
+	DEFINE(HCALL_STAT_CALLS, offsetof(struct hcall_stats, num_calls));
+	DEFINE(HCALL_STAT_TB, offsetof(struct hcall_stats, tb_total));
+	DEFINE(HCALL_STAT_PURR, offsetof(struct hcall_stats, purr_total));
 #endif /* CONFIG_PPC64 */
 	DEFINE(GPR0, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[0]));
 	DEFINE(GPR1, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[1]));
diff -Naupr powerpc2/arch/powerpc/platforms/pseries/Makefile powerpc2.work/arch/powerpc/platforms/pseries/Makefile
--- powerpc2/arch/powerpc/platforms/pseries/Makefile	2006-08-14 18:00:55.000000000 +0000
+++ powerpc2.work/arch/powerpc/platforms/pseries/Makefile	2006-08-14 21:31:45.000000000 +0000
@@ -12,3 +12,4 @@ obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o e
 
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
+obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
diff -Naupr powerpc2/arch/powerpc/platforms/pseries/hvCall.S powerpc2.work/arch/powerpc/platforms/pseries/hvCall.S
--- powerpc2/arch/powerpc/platforms/pseries/hvCall.S	2006-08-14 18:00:55.000000000 +0000
+++ powerpc2.work/arch/powerpc/platforms/pseries/hvCall.S	2006-08-15 19:06:10.000000000 +0000
@@ -10,9 +10,67 @@
 #include <asm/hvcall.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
 	
 #define STK_PARM(i)     (48 + ((i)-3)*8)
 
+#ifdef CONFIG_HCALL_STATS
+/*
+ * precall must preserve all registers.  use unused STK_PARM()
+ * areas to save snapshots and opcode.
+ */
+#define HCALL_INST_PRECALL					\
+	std	r3,STK_PARM(r3)(r1);	/* save opcode */	\
+	mftb	r3;			/* get timebase and */	\
+	std     r3,STK_PARM(r5)(r1);	/* save for later */	\
+BEGIN_FTR_SECTION;						\
+	mfspr	r3,SPRN_PURR;		/* get PURR and */	\
+	std	r3,STK_PARM(r6)(r1);	/* save for later */	\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
+	ld	r3,STK_PARM(r3)(r1);	/* opcode back in r3 */
+	
+/*
+ * postcall is performed immediately before function return which
+ * allows liberal use of volital registers.
+ */
+#define HCALL_INST_POSTCALL					\
+	/* get time and PURR snapshots after hcall */		\
+	mftb	r7;			/* timebase after */	\
+BEGIN_FTR_SECTION;						\
+	mfspr	r8,SPRN_PURR;		/* PURR after */	\
+	ld	r6,STK_PARM(r6)(r1);	/* PURR before */	\
+	subf	r6,r6,r8;		/* delta */		\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
+								\
+	ld	r5,STK_PARM(r5)(r1);	/* timebase before */	\
+	subf	r5,r5,r7;		/* time delta */	\
+								\
+	/* calculate address of stat structure */		\
+	ld	r4,STK_PARM(r3)(r1);	/* use opcode as */	\
+	rldicl	r4,r4,62,2;		/* index into array */	\
+	mulli	r4,r4,HCALL_STAT_SIZE;				\
+	LOAD_REG_ADDR(r7, per_cpu__hcall_stats);		\
+	add	r4,r4,r7;					\
+	ld	r7,PACA_DATA_OFFSET(r13); /* per cpu offset */	\
+	add	r4,r4,r7;					\
+								\
+	/* update stats	*/					\
+	ld	r7,HCALL_STAT_CALLS(r4); /* count */		\
+	addi	r7,r7,1;					\
+	std	r7,HCALL_STAT_CALLS(r4);			\
+	ld      r7,HCALL_STAT_TB(r4);	/* timebase */		\
+	add	r7,r7,r5;					\
+	std	r7,HCALL_STAT_TB(r4);				\
+BEGIN_FTR_SECTION;						\
+	ld	r7,HCALL_STAT_PURR(r4);	/* PURR */		\
+	add	r7,r7,r6;					\
+	std	r7,HCALL_STAT_PURR(r4);				\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);
+#else
+#define HCALL_INST_PRECALL
+#define HCALL_INST_POSTCALL
+#endif
+
 	.text
 
 _GLOBAL(plpar_hcall_norets)
@@ -21,8 +79,12 @@ _GLOBAL(plpar_hcall_norets)
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
@@ -33,6 +95,8 @@ _GLOBAL(plpar_hcall)
 	mfcr	r0
 	stw	r0,8(r1)
 
+	HCALL_INST_PRECALL
+
 	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
@@ -50,6 +114,8 @@ _GLOBAL(plpar_hcall)
 	std	r6, 16(r12)
 	std	r7, 24(r12)
 
+	HCALL_INST_POSTCALL
+
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 
@@ -61,6 +127,8 @@ _GLOBAL(plpar_hcall9)
 	mfcr	r0
 	stw	r0,8(r1)
 
+	HCALL_INST_PRECALL
+
 	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
@@ -86,6 +154,8 @@ _GLOBAL(plpar_hcall9)
 	std	r11,56(r12)
 	std	r12,64(r12)
 
+	HCALL_INST_POSTCALL
+
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 
diff -Naupr powerpc2/arch/powerpc/platforms/pseries/hvCall_inst.c powerpc2.work/arch/powerpc/platforms/pseries/hvCall_inst.c
--- powerpc2/arch/powerpc/platforms/pseries/hvCall_inst.c	1970-01-01 00:00:00.000000000 +0000
+++ powerpc2.work/arch/powerpc/platforms/pseries/hvCall_inst.c	2006-08-15 21:41:17.000000000 +0000
@@ -0,0 +1,129 @@
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
+#include <asm/cputable.h>
+
+DEFINE_PER_CPU(struct hcall_stats[MAX_HCALL_OPCODES+1], hcall_stats);
+
+/*
+ * Routines for displaying the statistics in debugfs
+ */
+static void *hc_start(struct seq_file *m, loff_t *pos)
+{
+	if ((int)*pos < (MAX_HCALL_OPCODES + 1))
+		return (void *)(unsigned long)(*pos + 1);
+
+	return NULL;
+}
+
+static void *hc_next(struct seq_file *m, void *p, loff_t * pos)
+{
+	++*pos;
+
+	return hc_start(m, pos);
+}
+
+static void hc_stop(struct seq_file *m, void *p)
+{
+}
+
+static int hc_show(struct seq_file *m, void *p)
+{
+	unsigned long h_num = (unsigned long)p;
+	struct hcall_stats *hs = (struct hcall_stats *)m->private;
+
+	if (hs[h_num].num_calls) {
+		if (cpu_has_feature(CPU_FTR_PURR))
+			seq_printf(m, "%lu %lu %lu %lu\n", h_num<<2,
+				   hs[h_num].num_calls,
+				   hs[h_num].tb_total,
+				   hs[h_num].purr_total);
+		else
+			seq_printf(m, "%lu %lu %lu\n", h_num<<2,
+				   hs[h_num].num_calls,
+				   hs[h_num].tb_total);
+	}
+
+	return 0;
+}
+
+static struct seq_operations hcall_inst_seq_ops = {
+        .start = hc_start,
+        .next  = hc_next,
+        .stop  = hc_stop,
+        .show  = hc_show
+};
+
+static int hcall_inst_seq_open(struct inode *inode, struct file *file)
+{
+	int rc;
+	struct seq_file *seq;
+
+	rc = seq_open(file, &hcall_inst_seq_ops);
+	seq = file->private_data;
+	seq->private = file->f_dentry->d_inode->u.generic_ip;
+
+	return rc;
+}
+
+static struct file_operations hcall_inst_seq_fops = {
+	.open = hcall_inst_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+#define	HCALL_ROOT_DIR		"hcall_inst"
+#define CPU_NAME_BUF_SIZE	32
+
+static int __init hcall_inst_init(void)
+{
+	struct dentry *hcall_root;
+	struct dentry *hcall_file;
+	char cpu_name_buf[CPU_NAME_BUF_SIZE];
+	int cpu;
+
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		return 0;
+
+	hcall_root = debugfs_create_dir(HCALL_ROOT_DIR, NULL);
+	if (!hcall_root)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		snprintf(cpu_name_buf, CPU_NAME_BUF_SIZE, "cpu%d", cpu);
+		hcall_file = debugfs_create_file(cpu_name_buf, S_IRUGO,
+						 hcall_root,
+						 per_cpu(hcall_stats, cpu),
+						 &hcall_inst_seq_fops);
+		if (!hcall_file)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+__initcall(hcall_inst_init);
diff -Naupr powerpc2/include/asm-powerpc/hvcall.h powerpc2.work/include/asm-powerpc/hvcall.h
--- powerpc2/include/asm-powerpc/hvcall.h	2006-08-14 18:05:16.000000000 +0000
+++ powerpc2.work/include/asm-powerpc/hvcall.h	2006-08-14 21:31:45.000000000 +0000
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
