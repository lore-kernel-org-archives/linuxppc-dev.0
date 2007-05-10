Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/7] Split out asm-ppc/mmu.h portions for the "classic"
	hash-based MMU
In-Reply-To: <20070510060449.GA3118@localhost.localdomain>
Message-Id: <20070510060556.7C67EDDEC9@ozlabs.org>
Date: Thu, 10 May 2007 16:05:56 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc still relies on asm-ppc/mmu.h for most 32-bit MMU types.
This patch is another step towards fixing this.  It takes the portions
of asm-ppc/mmu.h related to the "classic" 32-bit hash page table MMU
which are still relevant in arch/powerpc and puts them in a new
asm-powerpc/mmu-hash32.h, included when appropriate from
asm-powerpc/mmu.h.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 include/asm-powerpc/mmu-hash32.h |   91 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/mmu.h        |    3 +
 2 files changed, 94 insertions(+)

Index: working-2.6/include/asm-powerpc/mmu-hash32.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/include/asm-powerpc/mmu-hash32.h	2007-05-09 15:45:31.000000000 +1000
@@ -0,0 +1,91 @@
+#ifndef _ASM_POWERPC_MMU_HASH32_H_
+#define _ASM_POWERPC_MMU_HASH32_H_
+/*
+ * 32-bit hash table MMU support
+ */
+
+/*
+ * BATs
+ */
+
+/* Block size masks */
+#define BL_128K	0x000
+#define BL_256K 0x001
+#define BL_512K 0x003
+#define BL_1M   0x007
+#define BL_2M   0x00F
+#define BL_4M   0x01F
+#define BL_8M   0x03F
+#define BL_16M  0x07F
+#define BL_32M  0x0FF
+#define BL_64M  0x1FF
+#define BL_128M 0x3FF
+#define BL_256M 0x7FF
+
+/* BAT Access Protection */
+#define BPP_XX	0x00		/* No access */
+#define BPP_RX	0x01		/* Read only */
+#define BPP_RW	0x02		/* Read/write */
+
+#ifndef __ASSEMBLY__
+typedef struct _BAT {
+	struct {
+		unsigned long bepi:15;	/* Effective page index (virtual address) */
+		unsigned long :4;	/* Unused */
+		unsigned long bl:11;	/* Block size mask */
+		unsigned long vs:1;	/* Supervisor valid */
+		unsigned long vp:1;	/* User valid */
+	} batu; 		/* Upper register */
+	struct {
+		unsigned long brpn:15;	/* Real page index (physical address) */
+		unsigned long :10;	/* Unused */
+		unsigned long w:1;	/* Write-thru cache */
+		unsigned long i:1;	/* Cache inhibit */
+		unsigned long m:1;	/* Memory coherence */
+		unsigned long g:1;	/* Guarded (MBZ in IBAT) */
+		unsigned long :1;	/* Unused */
+		unsigned long pp:2;	/* Page access protections */
+	} batl;			/* Lower register */
+} BAT;
+#endif /* !__ASSEMBLY__ */
+
+/*
+ * Hash table
+ */
+
+/* Values for PP (assumes Ks=0, Kp=1) */
+#define PP_RWXX	0	/* Supervisor read/write, User none */
+#define PP_RWRX 1	/* Supervisor read/write, User read */
+#define PP_RWRW 2	/* Supervisor read/write, User read/write */
+#define PP_RXRX 3	/* Supervisor read,       User read */
+
+#ifndef __ASSEMBLY__
+
+/* Hardware Page Table Entry */
+typedef struct _PTE {
+	unsigned long v:1;	/* Entry is valid */
+	unsigned long vsid:24;	/* Virtual segment identifier */
+	unsigned long h:1;	/* Hash algorithm indicator */
+	unsigned long api:6;	/* Abbreviated page index */
+	unsigned long rpn:20;	/* Real (physical) page number */
+	unsigned long    :3;	/* Unused */
+	unsigned long r:1;	/* Referenced */
+	unsigned long c:1;	/* Changed */
+	unsigned long w:1;	/* Write-thru cache mode */
+	unsigned long i:1;	/* Cache inhibited */
+	unsigned long m:1;	/* Memory coherence */
+	unsigned long g:1;	/* Guarded */
+	unsigned long  :1;	/* Unused */
+	unsigned long pp:2;	/* Page protection */
+} PTE;
+
+typedef struct {
+	unsigned long id;
+	unsigned long vdso_base;
+} mm_context_t;
+
+typedef unsigned long phys_addr_t;
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_MMU_HASH32_H_ */
Index: working-2.6/include/asm-powerpc/mmu.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/mmu.h	2007-05-07 12:57:07.000000000 +1000
+++ working-2.6/include/asm-powerpc/mmu.h	2007-05-09 15:29:12.000000000 +1000
@@ -5,6 +5,9 @@
 #ifdef CONFIG_PPC64
 /* 64-bit classic hash table MMU */
 #  include <asm/mmu-hash64.h>
+#elif defined(CONFIG_PPC_STD_MMU)
+/* 32-bit classic hash table MMU */
+#  include <asm/mmu-hash32.h>
 #elif defined(CONFIG_44x)
 /* 44x-style software loaded TLB */
 #  include <asm/mmu-44x.h>
