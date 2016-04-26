Return-Path: <chris@distroguy.com>
Received: from mx-out02.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qv42k2TgCzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 10:38:37 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out02.mykolab.com (Postfix) with ESMTPS id 4DE086020B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 02:28:56 +0200 (CEST)
Date: Tue, 26 Apr 2016 10:28:50 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Add support for userspace P9 copy paste
Message-ID: <20160426002844.GA9198@x1.distroguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The copy paste facility introduced in POWER9 provides an optimised
mechanism for a userspace application to copy a cacheline. This is
provided by a pair of instructions, copy and paste, while a third,
cp_abort (copy paste abort), provides a clean up of the state in case of
a failure.

The copy instruction will read a 128 byte cacheline and store it in an
internal buffer. The subsequent paste instruction will store this
internal buffer to memory and set a CR field if the paste succeeds.

Since the state of the copy paste buffer is internal (and not
architecturally visible), in the unlikely event of a context switch, the
state cannot be stored and the paste should therefore fail.

The cp_abort instruction exists to fail and clean up any such
interrupted copy paste sequence and is to be called by the kernel as
part of the context switch. Doing so prevents data from a preceding copy
in one process leaking into the paste of another.

This code enables use of the cp_abort instruction if a supported
processor is detected.

NOTE: this is for userspace only, not in kernel, and does not deal
with KVM guests.

Patch created with much assistance from Michael Neuling
<mikey@neuling.org>

Signed-off-by: Chris Smart <chris@distroguy.com>
---

Note: A follow-up patch is expected soon with a working self-test.

 arch/powerpc/include/asm/ppc-opcode.h | 2 ++
 arch/powerpc/kernel/entry_64.S        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 7ab04fc59e24..1d035c1cc889 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -131,6 +131,7 @@
 /* sorted alphabetically */
 #define PPC_INST_BHRBE			0x7c00025c
 #define PPC_INST_CLRBHRB		0x7c00035c
+#define PPC_INST_CP_ABORT		0x7c00068c
 #define PPC_INST_DCBA			0x7c0005ec
 #define PPC_INST_DCBA_MASK		0xfc0007fe
 #define PPC_INST_DCBAL			0x7c2005ec
@@ -285,6 +286,7 @@
 #endif
 
 /* Deal with instructions that older assemblers aren't aware of */
+#define	PPC_CP_ABORT		stringify_in_c(.long PPC_INST_CP_ABORT)
 #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 8b9d68676d2b..ab1457c3f1d1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -36,6 +36,7 @@
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
+#include <asm/ppc-opcode.h>
 
 /*
  * System calls.
@@ -508,6 +509,14 @@ BEGIN_FTR_SECTION
 	ldarx	r6,0,r1
 END_FTR_SECTION_IFSET(CPU_FTR_STCX_CHECKS_ADDRESS)
 
+BEGIN_FTR_SECTION
+/*
+ * A cp_abort (copy paste abort) here ensures that when context switching, a
+ * copy from one process can't leak into the paste of another.
+ */
+        PPC_CP_ABORT
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 #ifdef CONFIG_PPC_BOOK3S
 /* Cancel all explict user streams as they will have no use after context
  * switch and will stop the HW from creating streams itself
-- 
2.5.5


-- 
  _
 °v°
/(_)\
 ^ ^
