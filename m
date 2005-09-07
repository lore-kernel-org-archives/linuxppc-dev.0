Return-Path: <jdl@jdl.com>
From: jdl@freescale.com
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Wed, 07 Sep 2005 15:59:48 -0500
Message-Id: <E1ED71I-00080l-MS@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH ppc: Merge a few more include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Merge a few asm-ppc and asm-ppc64 header files.
Note: the merge of setup.h intentionally does not carry
forward the m68k cruft.  That means this patch continues
to break the already broken amiga on the ppc32.

 include/asm-powerpc/msgbuf.h   |   33 +++++++++++++++++++
 include/asm-powerpc/param.h    |   24 ++++++++++++++
 include/asm-powerpc/setup.h    |    9 +++++
 include/asm-powerpc/timex.h    |   49 ++++++++++++++++++++++++++++
 include/asm-powerpc/topology.h |   70 ++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/user.h     |   55 +++++++++++++++++++++++++++++++
 include/asm-ppc/msgbuf.h       |   25 --------------
 include/asm-ppc/param.h        |   24 --------------
 include/asm-ppc/setup.h        |   14 --------
 include/asm-ppc/timex.h        |   40 -----------------------
 include/asm-ppc/topology.h     |    6 ---
 include/asm-ppc/user.h         |   54 -------------------------------
 include/asm-ppc64/msgbuf.h     |   27 ---------------
 include/asm-ppc64/param.h      |   31 ------------------
 include/asm-ppc64/setup.h      |    6 ---
 include/asm-ppc64/timex.h      |   26 ---------------
 include/asm-ppc64/topology.h   |   69 ---------------------------------------
 include/asm-ppc64/user.h       |   58 ---------------------------------
 18 files changed, 240 insertions(+), 380 deletions(-)

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---


diff --git a/include/asm-powerpc/msgbuf.h b/include/asm-powerpc/msgbuf.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/msgbuf.h
@@ -0,0 +1,33 @@
+#ifndef _ASM_POWERPC_MSGBUF_H
+#define _ASM_POWERPC_MSGBUF_H
+
+/*
+ * The msqid64_ds structure for the PowerPC architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+#ifndef __powerpc64__
+	unsigned int	__unused1;
+#endif
+	__kernel_time_t msg_stime;	/* last msgsnd time */
+#ifndef __powerpc64__
+	unsigned int	__unused2;
+#endif
+	__kernel_time_t msg_rtime;	/* last msgrcv time */
+#ifndef __powerpc64__
+	unsigned int	__unused3;
+#endif
+	__kernel_time_t msg_ctime;	/* last change time */
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+
+#endif	/* _ASM_POWERPC_MSGBUF_H */
diff --git a/include/asm-powerpc/param.h b/include/asm-powerpc/param.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/param.h
@@ -0,0 +1,24 @@
+#ifndef _ASM_POWERPC_PARAM_H
+#define _ASM_POWERPC_PARAM_H
+
+#include <linux/config.h>
+
+#ifdef __KERNEL__
+#define HZ		CONFIG_HZ	/* internal kernel timer frequency */
+#define USER_HZ		100		/* for user interfaces in "ticks" */
+#define CLOCKS_PER_SEC	(USER_HZ)	/* frequency at which times() counts */
+#endif /* __KERNEL__ */
+
+#ifndef HZ
+#define HZ 100
+#endif
+
+#define EXEC_PAGESIZE	4096
+
+#ifndef NOGROUP
+#define NOGROUP		(-1)
+#endif
+
+#define MAXHOSTNAMELEN	64	/* max length of hostname */
+
+#endif	/* _ASM_POWERPC_PARAM_H */
diff --git a/include/asm-powerpc/setup.h b/include/asm-powerpc/setup.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/setup.h
@@ -0,0 +1,9 @@
+#ifndef _ASM_POWERPC_SETUP_H
+#define _ASM_POWERPC_SETUP_H
+
+#ifdef __KERNEL__
+
+#define COMMAND_LINE_SIZE	512
+
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/include/asm-powerpc/timex.h b/include/asm-powerpc/timex.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/timex.h
@@ -0,0 +1,49 @@
+#ifndef _ASM_POWERPC_TIMEX_H
+#define _ASM_POWERPC_TIMEX_H
+
+#ifdef __KERNEL__
+
+/*
+ * PowerPC architecture timex specifications
+ */
+
+#include <linux/config.h>
+#include <asm/cputable.h>
+
+#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+
+typedef unsigned long cycles_t;
+
+static inline cycles_t get_cycles(void)
+{
+	cycles_t ret;
+
+#ifdef __powerpc64__
+
+	__asm__ __volatile__("mftb %0" : "=r" (ret) : );
+
+#else
+	/*
+	 * For the "cycle" counter we use the timebase lower half.
+	 * Currently only used on SMP.
+	 */
+
+	ret = 0;
+
+	__asm__ __volatile__(
+		"98:	mftb %0\n"
+		"99:\n"
+		".section __ftr_fixup,\"a\"\n"
+		"	.long %1\n"
+		"	.long 0\n"
+		"	.long 98b\n"
+		"	.long 99b\n"
+		".previous"
+		: "=r" (ret) : "i" (CPU_FTR_601));
+#endif
+
+	return ret;
+}
+
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_TIMEX_H */
diff --git a/include/asm-powerpc/topology.h b/include/asm-powerpc/topology.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/topology.h
@@ -0,0 +1,70 @@
+#ifndef _ASM_POWERPC_TOPOLOGY_H
+#define _ASM_POWERPC_TOPOLOGY_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_NUMA
+
+#include <asm/mmzone.h>
+
+static inline int cpu_to_node(int cpu)
+{
+	int node;
+
+	node = numa_cpu_lookup_table[cpu];
+
+#ifdef DEBUG_NUMA
+	BUG_ON(node == -1);
+#endif
+
+	return node;
+}
+
+#define parent_node(node)	(node)
+
+static inline cpumask_t node_to_cpumask(int node)
+{
+	return numa_cpumask_lookup_table[node];
+}
+
+static inline int node_to_first_cpu(int node)
+{
+	cpumask_t tmp;
+	tmp = node_to_cpumask(node);
+	return first_cpu(tmp);
+}
+
+#define pcibus_to_node(node)    (-1)
+#define pcibus_to_cpumask(bus)	(cpu_online_map)
+
+#define nr_cpus_node(node)	(nr_cpus_in_node[node])
+
+/* sched_domains SD_NODE_INIT for PPC64 machines */
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_EXEC	\
+				| SD_BALANCE_NEWIDLE	\
+				| SD_WAKE_IDLE		\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+
+#else
+
+#include <asm-generic/topology.h>
+
+#endif /* CONFIG_NUMA */
+
+#endif	/* _ASM_POWERPC_TOPOLOGY_H */
diff --git a/include/asm-powerpc/user.h b/include/asm-powerpc/user.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/user.h
@@ -0,0 +1,55 @@
+#ifndef _ASM_POWERPC_USER_H
+#define _ASM_POWERPC_USER_H
+
+#ifdef __KERNEL__
+
+#include <asm/ptrace.h>
+#include <asm/page.h>
+
+/*
+ * Adapted from <asm-alpha/user.h>
+ *
+ * Core file format: The core file is written in such a way that gdb
+ * can understand it and provide useful information to the user (under
+ * linux we use the `trad-core' bfd, NOT the osf-core).  The file contents
+ * are as follows:
+ *
+ *  upage: 1 page consisting of a user struct that tells gdb
+ *	what is present in the file.  Directly after this is a
+ *	copy of the task_struct, which is currently not used by gdb,
+ *	but it may come in handy at some point.  All of the registers
+ *	are stored as part of the upage.  The upage should always be
+ *	only one page long.
+ *  data: The data segment follows next.  We use current->end_text to
+ *	current->brk to pick up all of the user variables, plus any memory
+ *	that may have been sbrk'ed.  No attempt is made to determine if a
+ *	page is demand-zero or if a page is totally unused, we just cover
+ *	the entire range.  All of the addresses are rounded in such a way
+ *	that an integral number of pages is written.
+ *  stack: We need the stack information in order to get a meaningful
+ *	backtrace.  We need to write the data from usp to
+ *	current->start_stack, so we round each of these in order to be able
+ *	to write an integer number of pages.
+ */
+struct user {
+	struct pt_regs	regs;			/* entire machine state */
+	size_t		u_tsize;		/* text size (pages) */
+	size_t		u_dsize;		/* data size (pages) */
+	size_t		u_ssize;		/* stack size (pages) */
+	unsigned long	start_code;		/* text starting address */
+	unsigned long	start_data;		/* data starting address */
+	unsigned long	start_stack;		/* stack starting address */
+	long int	signal;			/* signal causing core dump */
+	struct regs *	u_ar0;			/* help gdb find registers */
+	unsigned long	magic;			/* identifies a core file */
+	char		u_comm[32];		/* user command name */
+};
+
+#define NBPG			PAGE_SIZE
+#define UPAGES			1
+#define HOST_TEXT_START_ADDR	(u.start_code)
+#define HOST_DATA_START_ADDR	(u.start_data)
+#define HOST_STACK_END_ADDR	(u.start_stack + u.u_ssize * NBPG)
+
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_USER_H */
diff --git a/include/asm-ppc/msgbuf.h b/include/asm-ppc/msgbuf.h
deleted file mode 100644
--- a/include/asm-ppc/msgbuf.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef _PPC_MSGBUF_H
-#define _PPC_MSGBUF_H
-
-/*
- * The msqid64_ds structure for the PPC architecture.
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	unsigned int	__unused1;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused3;
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused4;
-	unsigned long  __unused5;
-};
-
-#endif /* _PPC_MSGBUF_H */
diff --git a/include/asm-ppc/param.h b/include/asm-ppc/param.h
deleted file mode 100644
--- a/include/asm-ppc/param.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef _ASM_PPC_PARAM_H
-#define _ASM_PPC_PARAM_H
-
-#include <linux/config.h>
-
-#ifdef __KERNEL__
-#define HZ		CONFIG_HZ	/* internal timer frequency */
-#define USER_HZ		100		/* for user interfaces in "ticks" */
-#define CLOCKS_PER_SEC	(USER_HZ)	/* frequency at which times() counts */
-#endif /* __KERNEL__ */
-
-#ifndef HZ
-#define HZ 100
-#endif
-
-#define EXEC_PAGESIZE	4096
-
-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#endif
diff --git a/include/asm-ppc/setup.h b/include/asm-ppc/setup.h
deleted file mode 100644
--- a/include/asm-ppc/setup.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _PPC_SETUP_H
-#define _PPC_SETUP_H
-
-#define m68k_num_memory num_memory
-#define m68k_memory memory
-
-#include <asm-m68k/setup.h>
-/* We have a bigger command line buffer. */
-#undef COMMAND_LINE_SIZE
-#define COMMAND_LINE_SIZE	512
-
-#endif /* _PPC_SETUP_H */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/timex.h b/include/asm-ppc/timex.h
deleted file mode 100644
--- a/include/asm-ppc/timex.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * include/asm-ppc/timex.h
- *
- * ppc architecture timex specifications
- */
-#ifdef __KERNEL__
-#ifndef _ASMppc_TIMEX_H
-#define _ASMppc_TIMEX_H
-
-#include <linux/config.h>
-#include <asm/cputable.h>
-
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
-typedef unsigned long cycles_t;
-
-/*
- * For the "cycle" counter we use the timebase lower half.
- * Currently only used on SMP.
- */
-
-static inline cycles_t get_cycles(void)
-{
-	cycles_t ret = 0;
-
-	__asm__ __volatile__(
-		"98:	mftb %0\n"
-		"99:\n"
-		".section __ftr_fixup,\"a\"\n"
-		"	.long %1\n"
-		"	.long 0\n"
-		"	.long 98b\n"
-		"	.long 99b\n"
-		".previous"
-		: "=r" (ret) : "i" (CPU_FTR_601));
-	return ret;
-}
-
-#endif
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/topology.h b/include/asm-ppc/topology.h
deleted file mode 100644
--- a/include/asm-ppc/topology.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_PPC_TOPOLOGY_H
-#define _ASM_PPC_TOPOLOGY_H
-
-#include <asm-generic/topology.h>
-
-#endif /* _ASM_PPC_TOPOLOGY_H */
diff --git a/include/asm-ppc/user.h b/include/asm-ppc/user.h
deleted file mode 100644
--- a/include/asm-ppc/user.h
+++ /dev/null
@@ -1,54 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _PPC_USER_H
-#define _PPC_USER_H
-
-/* Adapted from <asm-alpha/user.h> */
-
-#include <linux/ptrace.h>
-#include <asm/page.h>
-
-/*
- * Core file format: The core file is written in such a way that gdb
- * can understand it and provide useful information to the user (under
- * linux we use the `trad-core' bfd, NOT the osf-core).  The file contents
- * are as follows:
- *
- *  upage: 1 page consisting of a user struct that tells gdb
- *	what is present in the file.  Directly after this is a
- *	copy of the task_struct, which is currently not used by gdb,
- *	but it may come in handy at some point.  All of the registers
- *	are stored as part of the upage.  The upage should always be
- *	only one page long.
- *  data: The data segment follows next.  We use current->end_text to
- *	current->brk to pick up all of the user variables, plus any memory
- *	that may have been sbrk'ed.  No attempt is made to determine if a
- *	page is demand-zero or if a page is totally unused, we just cover
- *	the entire range.  All of the addresses are rounded in such a way
- *	that an integral number of pages is written.
- *  stack: We need the stack information in order to get a meaningful
- *	backtrace.  We need to write the data from usp to
- *	current->start_stack, so we round each of these in order to be able
- *	to write an integer number of pages.
- */
-struct user {
-	struct pt_regs	regs;			/* entire machine state */
-	size_t		u_tsize;		/* text size (pages) */
-	size_t		u_dsize;		/* data size (pages) */
-	size_t		u_ssize;		/* stack size (pages) */
-	unsigned long	start_code;		/* text starting address */
-	unsigned long	start_data;		/* data starting address */
-	unsigned long	start_stack;		/* stack starting address */
-	long int	signal;			/* signal causing core dump */
-	struct regs *	u_ar0;			/* help gdb find registers */
-	unsigned long	magic;			/* identifies a core file */
-	char		u_comm[32];		/* user command name */
-};
-
-#define NBPG			PAGE_SIZE
-#define UPAGES			1
-#define HOST_TEXT_START_ADDR	(u.start_code)
-#define HOST_DATA_START_ADDR	(u.start_data)
-#define HOST_STACK_END_ADDR	(u.start_stack + u.u_ssize * NBPG)
-
-#endif /* _PPC_USER_H */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc64/msgbuf.h b/include/asm-ppc64/msgbuf.h
deleted file mode 100644
--- a/include/asm-ppc64/msgbuf.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _PPC64_MSGBUF_H
-#define _PPC64_MSGBUF_H
-
-/* 
- * The msqid64_ds structure for the PPC architecture.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused1;
-	unsigned long  __unused2;
-};
-
-#endif /* _PPC64_MSGBUF_H */
diff --git a/include/asm-ppc64/param.h b/include/asm-ppc64/param.h
deleted file mode 100644
--- a/include/asm-ppc64/param.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef _ASM_PPC64_PARAM_H
-#define _ASM_PPC64_PARAM_H
-
-#include <linux/config.h>
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifdef __KERNEL__
-# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
-# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
-#endif
-
-#ifndef HZ
-#define HZ 100
-#endif
-
-#define EXEC_PAGESIZE	4096
-
-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#endif /* _ASM_PPC64_PARAM_H */
diff --git a/include/asm-ppc64/setup.h b/include/asm-ppc64/setup.h
deleted file mode 100644
--- a/include/asm-ppc64/setup.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _PPC_SETUP_H
-#define _PPC_SETUP_H
-
-#define COMMAND_LINE_SIZE 512
-
-#endif /* _PPC_SETUP_H */
diff --git a/include/asm-ppc64/timex.h b/include/asm-ppc64/timex.h
deleted file mode 100644
--- a/include/asm-ppc64/timex.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * linux/include/asm-ppc/timex.h
- *
- * PPC64 architecture timex specifications
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifndef _ASMPPC64_TIMEX_H
-#define _ASMPPC64_TIMEX_H
-
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
-typedef unsigned long cycles_t;
-
-static inline cycles_t get_cycles(void)
-{
-	cycles_t ret;
-
-	__asm__ __volatile__("mftb %0" : "=r" (ret) : );
-	return ret;
-}
-
-#endif
diff --git a/include/asm-ppc64/topology.h b/include/asm-ppc64/topology.h
deleted file mode 100644
--- a/include/asm-ppc64/topology.h
+++ /dev/null
@@ -1,69 +0,0 @@
-#ifndef _ASM_PPC64_TOPOLOGY_H
-#define _ASM_PPC64_TOPOLOGY_H
-
-#include <linux/config.h>
-#include <asm/mmzone.h>
-
-#ifdef CONFIG_NUMA
-
-static inline int cpu_to_node(int cpu)
-{
-	int node;
-
-	node = numa_cpu_lookup_table[cpu];
-
-#ifdef DEBUG_NUMA
-	BUG_ON(node == -1);
-#endif
-
-	return node;
-}
-
-#define parent_node(node)	(node)
-
-static inline cpumask_t node_to_cpumask(int node)
-{
-	return numa_cpumask_lookup_table[node];
-}
-
-static inline int node_to_first_cpu(int node)
-{
-	cpumask_t tmp;
-	tmp = node_to_cpumask(node);
-	return first_cpu(tmp);
-}
-
-#define pcibus_to_node(node)    (-1)
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
-
-#define nr_cpus_node(node)	(nr_cpus_in_node[node])
-
-/* sched_domains SD_NODE_INIT for PPC64 machines */
-#define SD_NODE_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
-	.parent			= NULL,			\
-	.groups			= NULL,			\
-	.min_interval		= 8,			\
-	.max_interval		= 32,			\
-	.busy_factor		= 32,			\
-	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
-	.cache_nice_tries	= 1,			\
-	.per_cpu_gain		= 100,			\
-	.flags			= SD_LOAD_BALANCE	\
-				| SD_BALANCE_EXEC	\
-				| SD_BALANCE_NEWIDLE	\
-				| SD_WAKE_IDLE		\
-				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 1,			\
-	.nr_balance_failed	= 0,			\
-}
-
-#else
-
-#include <asm-generic/topology.h>
-
-#endif /* CONFIG_NUMA */
-
-#endif /* _ASM_PPC64_TOPOLOGY_H */
diff --git a/include/asm-ppc64/user.h b/include/asm-ppc64/user.h
deleted file mode 100644
--- a/include/asm-ppc64/user.h
+++ /dev/null
@@ -1,58 +0,0 @@
-#ifndef _PPC_USER_H
-#define _PPC_USER_H
-
-/* Adapted from <asm-alpha/user.h> 
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm/ptrace.h>
-#include <asm/page.h>
-
-/*
- * Core file format: The core file is written in such a way that gdb
- * can understand it and provide useful information to the user (under
- * linux we use the `trad-core' bfd, NOT the osf-core).  The file contents
- * are as follows:
- *
- *  upage: 1 page consisting of a user struct that tells gdb
- *	what is present in the file.  Directly after this is a
- *	copy of the task_struct, which is currently not used by gdb,
- *	but it may come in handy at some point.  All of the registers
- *	are stored as part of the upage.  The upage should always be
- *	only one page long.
- *  data: The data segment follows next.  We use current->end_text to
- *	current->brk to pick up all of the user variables, plus any memory
- *	that may have been sbrk'ed.  No attempt is made to determine if a
- *	page is demand-zero or if a page is totally unused, we just cover
- *	the entire range.  All of the addresses are rounded in such a way
- *	that an integral number of pages is written.
- *  stack: We need the stack information in order to get a meaningful
- *	backtrace.  We need to write the data from usp to
- *	current->start_stack, so we round each of these in order to be able
- *	to write an integer number of pages.
- */
-struct user {
-	struct pt_regs	regs;			/* entire machine state */
-	size_t		u_tsize;		/* text size (pages) */
-	size_t		u_dsize;		/* data size (pages) */
-	size_t		u_ssize;		/* stack size (pages) */
-	unsigned long	start_code;		/* text starting address */
-	unsigned long	start_data;		/* data starting address */
-	unsigned long	start_stack;		/* stack starting address */
-	long int	signal;			/* signal causing core dump */
-	struct regs *	u_ar0;			/* help gdb find registers */
-	unsigned long	magic;			/* identifies a core file */
-	char		u_comm[32];		/* user command name */
-};
-
-#define NBPG			PAGE_SIZE
-#define UPAGES			1
-#define HOST_TEXT_START_ADDR	(u.start_code)
-#define HOST_DATA_START_ADDR	(u.start_data)
-#define HOST_STACK_END_ADDR	(u.start_stack + u.u_ssize * NBPG)
-
-#endif /* _PPC_USER_H */
