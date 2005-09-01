Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1125607912.16685.111.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 01 Sep 2005 15:51:52 -0500
Subject: PATCH Merge more include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch merges several include files from
asm-ppc and asm-ppc64 into the new asm-powerpc.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---

 include/asm-powerpc/bugs.h        |   18 +++++++++
 include/asm-powerpc/kmap_types.h  |   32 +++++++++++++++
 include/asm-powerpc/mc146818rtc.h |   36 +++++++++++++++++
 include/asm-powerpc/module.h      |   77 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/sembuf.h      |   36 +++++++++++++++++
 include/asm-powerpc/shmbuf.h      |   59 ++++++++++++++++++++++++++++
 include/asm-powerpc/siginfo.h     |   18 +++++++++
 include/asm-powerpc/socket.h      |   59 ++++++++++++++++++++++++++++
 include/asm-powerpc/sockios.h     |   19 +++++++++
 include/asm-ppc/bugs.h            |    6 ---
 include/asm-ppc/kmap_types.h      |   24 ------------
 include/asm-ppc/mc146818rtc.h     |   31 ---------------
 include/asm-ppc/module.h          |   44 ---------------------
 include/asm-ppc/sembuf.h          |   19 ---------
 include/asm-ppc/shmbuf.h          |   37 ------------------
 include/asm-ppc/siginfo.h         |    6 ---
 include/asm-ppc/socket.h          |   58 ----------------------------
 include/asm-ppc/sockios.h         |   17 --------
 include/asm-ppc64/bugs.h          |   12 ------
 include/asm-ppc64/kmap_types.h    |   23 -----------
 include/asm-ppc64/mc146818rtc.h   |   32 ---------------
 include/asm-ppc64/module.h        |   36 -----------------
 include/asm-ppc64/sembuf.h        |   27 -------------
 include/asm-ppc64/shmbuf.h        |   43 ---------------------
 include/asm-ppc64/siginfo.h       |   16 --------
 include/asm-ppc64/socket.h        |   59 ----------------------------
 include/asm-ppc64/sockios.h       |   19 ---------
 27 files changed, 354 insertions(+), 509 deletions(-)


diff --git a/include/asm-powerpc/bugs.h b/include/asm-powerpc/bugs.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/bugs.h
@@ -0,0 +1,18 @@
+#ifndef _POWERPC_BUGS_H
+#define _POWERPC_BUGS_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * This file is included by 'init/main.c' to check for
+ * architecture-dependent bugs.
+ */
+
+extern void check_bugs(void);
+
+#endif /* _POWERPC_BUGS_H */
diff --git a/include/asm-powerpc/kmap_types.h b/include/asm-powerpc/kmap_types.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/kmap_types.h
@@ -0,0 +1,32 @@
+#ifndef _POWERPC_KMAP_TYPES_H
+#define _POWERPC_KMAP_TYPES_H
+
+#ifdef __KERNEL__
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
+	KM_PTE0,
+	KM_PTE1,
+	KM_IRQ0,
+	KM_IRQ1,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_PPC_SYNC_PAGE,
+	KM_TYPE_NR
+};
+
+#endif	/* __KERNEL__ */
+#endif	/* _POWERPC_KMAP_TYPES_H */
diff --git a/include/asm-powerpc/mc146818rtc.h b/include/asm-powerpc/mc146818rtc.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/mc146818rtc.h
@@ -0,0 +1,36 @@
+#ifndef _POWERPC_MC146818RTC_H
+#define _POWERPC_MC146818RTC_H
+
+/*
+ * Machine dependent access functions for RTC registers.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+
+#include <asm/io.h>
+
+#ifndef RTC_PORT
+#define RTC_PORT(x)	(0x70 + (x))
+#define RTC_ALWAYS_BCD	1	/* RTC operates in binary mode */
+#endif
+
+/*
+ * The yet supported machines all access the RTC index register via
+ * an ISA port access but the way to access the date register differs ...
+ */
+#define CMOS_READ(addr) ({ \
+outb_p((addr),RTC_PORT(0)); \
+inb_p(RTC_PORT(1)); \
+})
+#define CMOS_WRITE(val, addr) ({ \
+outb_p((addr),RTC_PORT(0)); \
+outb_p((val),RTC_PORT(1)); \
+})
+
+#endif	/* __KERNEL__ */
+#endif	/* _POWERPC_MC146818RTC_H */
diff --git a/include/asm-powerpc/module.h b/include/asm-powerpc/module.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/module.h
@@ -0,0 +1,77 @@
+#ifndef _POWERPC_MODULE_H
+#define _POWERPC_MODULE_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/list.h>
+#include <asm/bug.h>
+
+
+#ifndef __powerpc64__
+/*
+ * Thanks to Paul M for explaining this.
+ *
+ * PPC can only do rel jumps += 32MB, and often the kernel and other
+ * modules are furthur away than this.  So, we jump to a table of
+ * trampolines attached to the module (the Procedure Linkage Table)
+ * whenever that happens.
+ */
+
+struct ppc_plt_entry {
+	/* 16 byte jump instruction sequence (4 instructions) */
+	unsigned int jump[4];
+};
+#endif	/* __powerpc64__ */
+
+
+struct mod_arch_specific {
+#ifdef __powerpc64__
+	unsigned int stubs_section;	/* Index of stubs section in module */
+	unsigned int toc_section;	/* What section is the TOC? */
+#else
+	/* Indices of PLT sections within module. */
+	unsigned int core_plt_section;
+	unsigned int init_plt_section;
+#endif
+
+	/* List of BUG addresses, source line numbers and filenames */
+	struct list_head bug_list;
+	struct bug_entry *bug_table;
+	unsigned int num_bugs;
+};
+
+extern struct bug_entry *module_find_bug(unsigned long bugaddr);
+
+/*
+ * Select ELF headers.
+ * Make empty section for module_frob_arch_sections to expand.
+ */
+
+#ifdef __powerpc64__
+#    define Elf_Shdr	Elf64_Shdr
+#    define Elf_Sym	Elf64_Sym
+#    define Elf_Ehdr	Elf64_Ehdr
+#    ifdef MODULE
+	asm(".section .stubs,\"ax\",@nobits; .align 3; .previous");
+#    endif
+#else
+#    define Elf_Shdr	Elf32_Shdr
+#    define Elf_Sym	Elf32_Sym
+#    define Elf_Ehdr	Elf32_Ehdr
+#    ifdef MODULE
+	asm(".section .plt,\"ax\",@nobits; .align 3; .previous");
+	asm(".section .init.plt,\"ax\",@nobits; .align 3; .previous");
+#    endif	/* MODULE */
+#endif
+
+
+struct exception_table_entry;
+void sort_ex_table(struct exception_table_entry *start,
+		   struct exception_table_entry *finish);
+
+#endif /* _POWERPC_MODULE_H */
diff --git a/include/asm-powerpc/sembuf.h b/include/asm-powerpc/sembuf.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/sembuf.h
@@ -0,0 +1,36 @@
+#ifndef _POWERPC_SEMBUF_H
+#define _POWERPC_SEMBUF_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * The semid64_ds structure for PPC architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct semid64_ds {
+	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#ifndef __powerpc64__
+	unsigned long	__unused1;
+#endif
+	__kernel_time_t	sem_otime;	/* last semop time */
+#ifndef __powerpc64__
+	unsigned long	__unused2;
+#endif
+	__kernel_time_t	sem_ctime;	/* last change time */
+	unsigned long	sem_nsems;	/* no. of semaphores in array */
+	unsigned long	__unused3;
+	unsigned long	__unused4;
+};
+
+#endif /* _POWERPC_SEMBUF_H */
diff --git a/include/asm-powerpc/shmbuf.h b/include/asm-powerpc/shmbuf.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/shmbuf.h
@@ -0,0 +1,59 @@
+#ifndef _POWERPC_SHMBUF_H
+#define _POWERPC_SHMBUF_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * The shmid64_ds structure for PPC architecture.
+ *
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+#ifndef __power64__
+	unsigned long		__unused1;
+#endif
+	__kernel_time_t		shm_atime;	/* last attach time */
+#ifndef __power64__
+	unsigned long		__unused2;
+#endif
+	__kernel_time_t		shm_dtime;	/* last detach time */
+#ifndef __power64__
+	unsigned long		__unused3;
+#endif
+	__kernel_time_t		shm_ctime;	/* last change time */
+#ifndef __power64__
+	unsigned long		__unused4;
+#endif
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused5;
+	unsigned long		__unused6;
+};
+
+struct shminfo64 {
+	unsigned long	shmmax;
+	unsigned long	shmmin;
+	unsigned long	shmmni;
+	unsigned long	shmseg;
+	unsigned long	shmall;
+	unsigned long	__unused1;
+	unsigned long	__unused2;
+	unsigned long	__unused3;
+	unsigned long	__unused4;
+};
+
+#endif /* _POWERPC_SHMBUF_H */
diff --git a/include/asm-powerpc/siginfo.h b/include/asm-powerpc/siginfo.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/siginfo.h
@@ -0,0 +1,18 @@
+#ifndef _POWERPC_SIGINFO_H
+#define _POWERPC_SIGINFO_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __powerpc64__
+#    define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#    define SI_PAD_SIZE32		((SI_MAX_SIZE/sizeof(int)) - 3)
+#endif
+
+#include <asm-generic/siginfo.h>
+
+#endif /* _POWERPC_SIGINFO_H */
diff --git a/include/asm-powerpc/socket.h b/include/asm-powerpc/socket.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/socket.h
@@ -0,0 +1,59 @@
+#ifndef _POWERPC_SOCKET_H
+#define _POWERPC_SOCKET_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/sockios.h>
+
+/* For setsockopt(2) */
+#define SOL_SOCKET	1
+
+#define SO_DEBUG	1
+#define SO_REUSEADDR	2
+#define SO_TYPE		3
+#define SO_ERROR	4
+#define SO_DONTROUTE	5
+#define SO_BROADCAST	6
+#define SO_SNDBUF	7
+#define SO_RCVBUF	8
+#define SO_SNDBUFFORCE	32
+#define SO_RCVBUFFORCE	33
+#define SO_KEEPALIVE	9
+#define SO_OOBINLINE	10
+#define SO_NO_CHECK	11
+#define SO_PRIORITY	12
+#define SO_LINGER	13
+#define SO_BSDCOMPAT	14
+/* To add :#define SO_REUSEPORT 15 */
+#define SO_RCVLOWAT	16
+#define SO_SNDLOWAT	17
+#define SO_RCVTIMEO	18
+#define SO_SNDTIMEO	19
+#define SO_PASSCRED	20
+#define SO_PEERCRED	21
+
+/* Security levels - as per NRL IPv6 - don't actually do anything */
+#define SO_SECURITY_AUTHENTICATION		22
+#define SO_SECURITY_ENCRYPTION_TRANSPORT	23
+#define SO_SECURITY_ENCRYPTION_NETWORK		24
+
+#define SO_BINDTODEVICE	25
+
+/* Socket filtering */
+#define SO_ATTACH_FILTER	26
+#define SO_DETACH_FILTER	27
+
+#define SO_PEERNAME		28
+#define SO_TIMESTAMP		29
+#define SCM_TIMESTAMP		SO_TIMESTAMP
+
+#define SO_ACCEPTCONN		30
+
+#define SO_PEERSEC		31
+
+#endif /* _POWERPC_SOCKET_H */
diff --git a/include/asm-powerpc/sockios.h b/include/asm-powerpc/sockios.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/sockios.h
@@ -0,0 +1,19 @@
+#ifndef _POWERPC_SOCKIOS_H
+#define _POWERPC_SOCKIOS_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/* Socket-level I/O control calls. */
+#define FIOSETOWN 	0x8901
+#define SIOCSPGRP	0x8902
+#define FIOGETOWN	0x8903
+#define SIOCGPGRP	0x8904
+#define SIOCATMARK	0x8905
+#define SIOCGSTAMP	0x8906		/* Get stamp */
+
+#endif /* _POWERPC_SOCKIOS_H */
diff --git a/include/asm-ppc/bugs.h b/include/asm-ppc/bugs.h
deleted file mode 100644
--- a/include/asm-ppc/bugs.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/*
- * This file is included by 'init/main.c'
- */
-
-extern void
-check_bugs(void);
diff --git a/include/asm-ppc/kmap_types.h b/include/asm-ppc/kmap_types.h
deleted file mode 100644
--- a/include/asm-ppc/kmap_types.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BIO_SRC_IRQ,
-	KM_BIO_DST_IRQ,
-	KM_PTE0,
-	KM_PTE1,
-	KM_IRQ0,
-	KM_IRQ1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_PPC_SYNC_PAGE,
-	KM_TYPE_NR
-};
-
-#endif
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/mc146818rtc.h b/include/asm-ppc/mc146818rtc.h
deleted file mode 100644
--- a/include/asm-ppc/mc146818rtc.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Machine dependent access functions for RTC registers.
- */
-#ifdef __KERNEL__
-#ifndef __ASM_PPC_MC146818RTC_H
-#define __ASM_PPC_MC146818RTC_H
-
-#include <asm/io.h>
-
-#ifndef RTC_PORT
-#define RTC_PORT(x)	(0x70 + (x))
-#define RTC_ALWAYS_BCD	1	/* RTC operates in binary mode */
-#endif
-
-/*
- * The yet supported machines all access the RTC index register via
- * an ISA port access but the way to access the date register differs ...
- */
-#define CMOS_READ(addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-inb_p(RTC_PORT(1)); \
-})
-#define CMOS_WRITE(val, addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-outb_p((val),RTC_PORT(1)); \
-})
-
-#define RTC_IRQ 8
-
-#endif /* __ASM_PPC_MC146818RTC_H */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/module.h b/include/asm-ppc/module.h
deleted file mode 100644
--- a/include/asm-ppc/module.h
+++ /dev/null
@@ -1,44 +0,0 @@
-#ifndef _ASM_PPC_MODULE_H
-#define _ASM_PPC_MODULE_H
-/* Module stuff for PPC.  (C) 2001 Rusty Russell */
-
-#include <linux/list.h>
-#include <asm/bug.h>
-
-/* Thanks to Paul M for explaining this.
-
-   PPC can only do rel jumps += 32MB, and often the kernel and other
-   modules are furthur away than this.  So, we jump to a table of
-   trampolines attached to the module (the Procedure Linkage Table)
-   whenever that happens.
-*/
-
-struct ppc_plt_entry
-{
-	/* 16 byte jump instruction sequence (4 instructions) */
-	unsigned int jump[4];
-};
-
-struct mod_arch_specific
-{
-	/* Indices of PLT sections within module. */
-	unsigned int core_plt_section, init_plt_section;
-
-	/* List of BUG addresses, source line numbers and filenames */
-	struct list_head bug_list;
-	struct bug_entry *bug_table;
-	unsigned int num_bugs;
-};
-
-extern struct bug_entry *module_find_bug(unsigned long bugaddr);
-
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
-/* Make empty sections for module_frob_arch_sections to expand. */
-#ifdef MODULE
-asm(".section .plt,\"ax\",@nobits; .align 3; .previous");
-asm(".section .init.plt,\"ax\",@nobits; .align 3; .previous");
-#endif
-#endif /* _ASM_PPC_MODULE_H */
diff --git a/include/asm-ppc/sembuf.h b/include/asm-ppc/sembuf.h
deleted file mode 100644
--- a/include/asm-ppc/sembuf.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef _PPC_SEMBUF_H
-#define _PPC_SEMBUF_H
-
-/*
- * The semid64_ds structure for PPC architecture.
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	unsigned int	__unused1;
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned int	__unused2;
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _PPC_SEMBUF_H */
diff --git a/include/asm-ppc/shmbuf.h b/include/asm-ppc/shmbuf.h
deleted file mode 100644
--- a/include/asm-ppc/shmbuf.h
+++ /dev/null
@@ -1,37 +0,0 @@
-#ifndef _PPC_SHMBUF_H
-#define _PPC_SHMBUF_H
-
-/*
- * The shmid64_ds structure for PPC architecture.
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	unsigned int		__unused1;
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned int		__unused2;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned int		__unused3;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned int		__unused4;
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused5;
-	unsigned long		__unused6;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _PPC_SHMBUF_H */
diff --git a/include/asm-ppc/siginfo.h b/include/asm-ppc/siginfo.h
deleted file mode 100644
--- a/include/asm-ppc/siginfo.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _PPC_SIGINFO_H
-#define _PPC_SIGINFO_H
-
-#include <asm-generic/siginfo.h>
-
-#endif
diff --git a/include/asm-ppc/socket.h b/include/asm-ppc/socket.h
deleted file mode 100644
--- a/include/asm-ppc/socket.h
+++ /dev/null
@@ -1,58 +0,0 @@
-#ifndef _ASM_SOCKET_H
-#define _ASM_SOCKET_H
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp */
-
-/* For setsockopt(2) */
-#define SOL_SOCKET	1
-
-#define SO_DEBUG	1
-#define SO_REUSEADDR	2
-#define SO_TYPE		3
-#define SO_ERROR	4
-#define SO_DONTROUTE	5
-#define SO_BROADCAST	6
-#define SO_SNDBUF	7
-#define SO_RCVBUF	8
-#define SO_SNDBUFFORCE	32
-#define SO_RCVBUFFORCE	33
-#define SO_KEEPALIVE	9
-#define SO_OOBINLINE	10
-#define SO_NO_CHECK	11
-#define SO_PRIORITY	12
-#define SO_LINGER	13
-#define SO_BSDCOMPAT	14
-/* To add :#define SO_REUSEPORT 15 */
-#define SO_RCVLOWAT	16
-#define SO_SNDLOWAT	17
-#define SO_RCVTIMEO	18
-#define SO_SNDTIMEO	19
-#define SO_PASSCRED	20
-#define SO_PEERCRED	21
-
-/* Security levels - as per NRL IPv6 - don't actually do anything */
-#define SO_SECURITY_AUTHENTICATION		22
-#define SO_SECURITY_ENCRYPTION_TRANSPORT	23
-#define SO_SECURITY_ENCRYPTION_NETWORK		24
-
-#define SO_BINDTODEVICE	25
-
-/* Socket filtering */
-#define SO_ATTACH_FILTER	26
-#define SO_DETACH_FILTER	27
-
-#define SO_PEERNAME		28
-#define SO_TIMESTAMP		29
-#define SCM_TIMESTAMP		SO_TIMESTAMP
-
-#define SO_ACCEPTCONN		30
-
-#define SO_PEERSEC		31
-
-#endif /* _ASM_SOCKET_H */
diff --git a/include/asm-ppc/sockios.h b/include/asm-ppc/sockios.h
deleted file mode 100644
--- a/include/asm-ppc/sockios.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef _ASM_PPC_SOCKIOS_H
-#define _ASM_PPC_SOCKIOS_H
-
-#if 0 /* These are defined this way on Alpha - maybe later. */
-/* Socket-level I/O control calls. */
-
-#define FIOGETOWN	_IOR('f', 123, int)
-#define FIOSETOWN 	_IOW('f', 124, int)
-
-#define SIOCATMARK	_IOR('s', 7, int)
-#define SIOCSPGRP	_IOW('s', 8, pid_t)
-#define SIOCGPGRP	_IOR('s', 9, pid_t)
-
-#define SIOCGSTAMP	0x8906		/* Get stamp - linux-specific */
-#endif
-
-#endif /* _ASM_PPC_SOCKIOS_H */
diff --git a/include/asm-ppc64/bugs.h b/include/asm-ppc64/bugs.h
deleted file mode 100644
--- a/include/asm-ppc64/bugs.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * This file is included by 'init/main.c' to check for architecture-dependent
- * bugs.
- *
- */
-#ifndef _ASM_PPC64_BUGS_H
-#define _ASM_PPC64_BUGS_H
-
-static void check_bugs(void) {
-}
-
-#endif /* _ASM_PPC64_BUGS_H */
diff --git a/include/asm-ppc64/kmap_types.h b/include/asm-ppc64/kmap_types.h
deleted file mode 100644
--- a/include/asm-ppc64/kmap_types.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BIO_SRC_IRQ,
-	KM_BIO_DST_IRQ,
-	KM_PTE0,
-	KM_PTE1,
-	KM_IRQ0,
-	KM_IRQ1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,	
-	KM_TYPE_NR
-};
-
-#endif
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc64/mc146818rtc.h b/include/asm-ppc64/mc146818rtc.h
deleted file mode 100644
--- a/include/asm-ppc64/mc146818rtc.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Machine dependent access functions for RTC registers.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifndef __ASM_PPC64_MC146818RTC_H
-#define __ASM_PPC64_MC146818RTC_H
-
-#include <asm/io.h>
-
-#ifndef RTC_PORT
-#define RTC_PORT(x)	(0x70 + (x))
-#define RTC_ALWAYS_BCD	1	/* RTC operates in binary mode */
-#endif
-
-/*
- * The yet supported machines all access the RTC index register via
- * an ISA port access but the way to access the date register differs ...
- */
-#define CMOS_READ(addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-inb_p(RTC_PORT(1)); \
-})
-#define CMOS_WRITE(val, addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-outb_p((val),RTC_PORT(1)); \
-})
-
-#endif /* __ASM_PPC64_MC146818RTC_H */
diff --git a/include/asm-ppc64/module.h b/include/asm-ppc64/module.h
deleted file mode 100644
--- a/include/asm-ppc64/module.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef _ASM_PPC64_MODULE_H
-#define _ASM_PPC64_MODULE_H
-
-#include <linux/list.h>
-#include <asm/bug.h>
-
-struct mod_arch_specific
-{
-	/* Index of stubs section within module. */
-	unsigned int stubs_section;
-
-	/* What section is the TOC? */
-	unsigned int toc_section;
-
-	/* List of BUG addresses, source line numbers and filenames */
-	struct list_head bug_list;
-	struct bug_entry *bug_table;
-	unsigned int num_bugs;
-};
-
-extern struct bug_entry *module_find_bug(unsigned long bugaddr);
-
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-
-/* Make empty section for module_frob_arch_sections to expand. */
-#ifdef MODULE
-asm(".section .stubs,\"ax\",@nobits; .align 3; .previous");
-#endif
-
-struct exception_table_entry;
-void sort_ex_table(struct exception_table_entry *start,
-			struct exception_table_entry *finish);
-
-#endif /* _ASM_PPC64_MODULE_H */
diff --git a/include/asm-ppc64/sembuf.h b/include/asm-ppc64/sembuf.h
deleted file mode 100644
--- a/include/asm-ppc64/sembuf.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _PPC64_SEMBUF_H
-#define _PPC64_SEMBUF_H
-
-/* 
- * The semid64_ds structure for PPC architecture.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;	/* last semop time */
-	__kernel_time_t	sem_ctime;	/* last change time */
-	unsigned long	sem_nsems;	/* no. of semaphores in array */
-
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* _PPC64_SEMBUF_H */
diff --git a/include/asm-ppc64/shmbuf.h b/include/asm-ppc64/shmbuf.h
deleted file mode 100644
--- a/include/asm-ppc64/shmbuf.h
+++ /dev/null
@@ -1,43 +0,0 @@
-#ifndef _PPC64_SHMBUF_H
-#define _PPC64_SHMBUF_H
-
-/* 
- * The shmid64_ds structure for PPC64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused1;
-	unsigned long		__unused2;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _PPC64_SHMBUF_H */
diff --git a/include/asm-ppc64/siginfo.h b/include/asm-ppc64/siginfo.h
deleted file mode 100644
--- a/include/asm-ppc64/siginfo.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef _PPC64_SIGINFO_H
-#define _PPC64_SIGINFO_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
-#define SI_PAD_SIZE32		((SI_MAX_SIZE/sizeof(int)) - 3)
-
-#include <asm-generic/siginfo.h>
-
-#endif /* _PPC64_SIGINFO_H */
diff --git a/include/asm-ppc64/socket.h b/include/asm-ppc64/socket.h
deleted file mode 100644
--- a/include/asm-ppc64/socket.h
+++ /dev/null
@@ -1,59 +0,0 @@
-#ifndef _ASM_SOCKET_H
-#define _ASM_SOCKET_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm/sockios.h>
-
-/* For setsockoptions(2) */
-#define SOL_SOCKET	1
-
-#define SO_DEBUG	1
-#define SO_REUSEADDR	2
-#define SO_TYPE		3
-#define SO_ERROR	4
-#define SO_DONTROUTE	5
-#define SO_BROADCAST	6
-#define SO_SNDBUF	7
-#define SO_RCVBUF	8
-#define SO_SNDBUFFORCE	32
-#define SO_RCVBUFFORCE	33
-#define SO_KEEPALIVE	9
-#define SO_OOBINLINE	10
-#define SO_NO_CHECK	11
-#define SO_PRIORITY	12
-#define SO_LINGER	13
-#define SO_BSDCOMPAT	14
-/* To add :#define SO_REUSEPORT 15 */
-#define SO_RCVLOWAT	16
-#define SO_SNDLOWAT	17
-#define SO_RCVTIMEO	18
-#define SO_SNDTIMEO	19
-#define SO_PASSCRED	20
-#define SO_PEERCRED	21
-
-/* Security levels - as per NRL IPv6 - don't actually do anything */
-#define SO_SECURITY_AUTHENTICATION		22
-#define SO_SECURITY_ENCRYPTION_TRANSPORT	23
-#define SO_SECURITY_ENCRYPTION_NETWORK		24
-
-#define SO_BINDTODEVICE	25
-
-/* Socket filtering */
-#define SO_ATTACH_FILTER	26
-#define SO_DETACH_FILTER	27
-
-#define SO_PEERNAME		28
-#define SO_TIMESTAMP		29
-#define SCM_TIMESTAMP		SO_TIMESTAMP
-
-#define SO_ACCEPTCONN           30
-
-#define SO_PEERSEC             31
-
-#endif /* _ASM_SOCKET_H */
diff --git a/include/asm-ppc64/sockios.h b/include/asm-ppc64/sockios.h
deleted file mode 100644
--- a/include/asm-ppc64/sockios.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef _ASM_PPC64_SOCKIOS_H
-#define _ASM_PPC64_SOCKIOS_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp */
-
-#endif /* _ASM_PPC64_SOCKIOS_H */
