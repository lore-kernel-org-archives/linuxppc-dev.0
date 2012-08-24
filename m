Return-Path: <ananth@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7350B2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 17:26:14 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 24 Aug 2012 03:26:11 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 454BA6E8045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 03:26:08 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7O7Q7XW29360140
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 03:26:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7O7Q51g003675
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 04:26:07 -0300
Date: Fri, 24 Aug 2012 12:56:02 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: ppcdev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] powerpc: Consolidate *probe definitions
Message-ID: <20120824072602.GA32031@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 oleg@redhat.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Move is_trap() and relatives to a common file to be shared between *probes.
Code movement only; no change in functionality.

Suggested by Michael Ellerman.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h |   15 +------------
 arch/powerpc/include/asm/probes.h  |   42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 13 deletions(-)

Index: linux-tip-23aug/arch/powerpc/include/asm/kprobes.h
===================================================================
--- linux-tip-23aug.orig/arch/powerpc/include/asm/kprobes.h
+++ linux-tip-23aug/arch/powerpc/include/asm/kprobes.h
@@ -29,21 +29,16 @@
 #include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
+#include <asm/probes.h>
 
 #define  __ARCH_WANT_KPROBES_INSN_SLOT
 
 struct pt_regs;
 struct kprobe;
 
-typedef unsigned int kprobe_opcode_t;
-#define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
+typedef opcode_t kprobe_opcode_t;
 #define MAX_INSN_SIZE 1
 
-#define IS_TW(instr)		(((instr) & 0xfc0007fe) == 0x7c000008)
-#define IS_TD(instr)		(((instr) & 0xfc0007fe) == 0x7c000088)
-#define IS_TDI(instr)		(((instr) & 0xfc000000) == 0x08000000)
-#define IS_TWI(instr)		(((instr) & 0xfc000000) == 0x0c000000)
-
 #ifdef CONFIG_PPC64
 /*
  * 64bit powerpc uses function descriptors.
@@ -72,12 +67,6 @@ typedef unsigned int kprobe_opcode_t;
 		addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name); \
 	}								\
 }
-
-#define is_trap(instr)	(IS_TW(instr) || IS_TD(instr) || \
-			IS_TWI(instr) || IS_TDI(instr))
-#else
-/* Use stock kprobe_lookup_name since ppc32 doesn't use function descriptors */
-#define is_trap(instr)	(IS_TW(instr) || IS_TWI(instr))
 #endif
 
 #define flush_insn_slot(p)	do { } while (0)
Index: linux-tip-23aug/arch/powerpc/include/asm/probes.h
===================================================================
--- /dev/null
+++ linux-tip-23aug/arch/powerpc/include/asm/probes.h
@@ -0,0 +1,42 @@
+#ifndef _ASM_POWERPC_PROBES_H
+#define _ASM_POWERPC_PROBES_H
+#ifdef __KERNEL__
+/*
+ * Definitions common to probes files
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
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright IBM Corporation, 2012
+ */
+#include <linux/types.h>
+
+typedef u32 opcode_t;
+#define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
+
+/* Trap definitions per ISA */
+#define IS_TW(instr)		(((instr) & 0xfc0007fe) == 0x7c000008)
+#define IS_TD(instr)		(((instr) & 0xfc0007fe) == 0x7c000088)
+#define IS_TDI(instr)		(((instr) & 0xfc000000) == 0x08000000)
+#define IS_TWI(instr)		(((instr) & 0xfc000000) == 0x0c000000)
+
+#ifdef CONFIG_PPC64
+#define is_trap(instr)		(IS_TW(instr) || IS_TD(instr) || \
+				IS_TWI(instr) || IS_TDI(instr))
+#else
+#define is_trap(instr)		(IS_TW(instr) || IS_TWI(instr))
+#endif /* CONFIG_PPC64 */
+
+#endif /* __KERNEL__ */
+#endif	/* _ASM_POWERPC_PROBES_H */
