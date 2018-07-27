Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cl323KM9zF0tm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 09:06:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org,
	diana.craciun@nxp.com
Cc: oss@buserror.net,
	leoyang.li@nxp.com,
	bharat.bhushan@nxp.com
Subject: [PATCH v5 6/8] powerpc/fsl: Add barrier_nospec implementation for NXP
 PowerPC Book3E
Date: Sat, 28 Jul 2018 09:06:37 +1000
Message-Id: <20180727230639.25413-7-mpe@ellerman.id.au>
In-Reply-To: <20180727230639.25413-1-mpe@ellerman.id.au>
References: <20180727230639.25413-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <diana.craciun@nxp.com>

Implement the barrier_nospec as a isync;sync instruction sequence.
The implementation uses the infrastructure built for BOOK3S 64.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
[mpe: Split out of larger patch]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig               |  2 +-
 arch/powerpc/include/asm/barrier.h |  8 +++++++-
 arch/powerpc/lib/feature-fixups.c  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

v5: Split out.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index aef1c4e049f1..a0e9946083f4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -244,7 +244,7 @@ config PPC
 config PPC_BARRIER_NOSPEC
     bool
     default y
-    depends on PPC_BOOK3S_64
+    depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
 
 config GENERIC_CSUM
 	def_bool n
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index ec43375463ba..449474f667c4 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,12 +76,18 @@ do {									\
 	___p1;								\
 })
 
+#ifdef CONFIG_PPC_BOOK3S_64
+#define NOSPEC_BARRIER_SLOT   nop
+#elif defined(CONFIG_PPC_FSL_BOOK3E)
+#define NOSPEC_BARRIER_SLOT   nop; nop
+#endif
+
 #ifdef CONFIG_PPC_BARRIER_NOSPEC
 /*
  * Prevent execution of subsequent instructions until preceding branches have
  * been fully resolved and are no longer executing speculatively.
  */
-#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; nop
+#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; NOSPEC_BARRIER_SLOT
 
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 0e604b41b5d1..e613b02bb2f0 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -318,6 +318,37 @@ void do_barrier_nospec_fixups(bool enable)
 }
 #endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
+{
+	unsigned int instr[2], *dest;
+	long *start, *end;
+	int i;
+
+	start = fixup_start;
+	end = fixup_end;
+
+	instr[0] = PPC_INST_NOP;
+	instr[1] = PPC_INST_NOP;
+
+	if (enable) {
+		pr_info("barrier-nospec: using isync; sync as speculation barrier\n");
+		instr[0] = PPC_INST_ISYNC;
+		instr[1] = PPC_INST_SYNC;
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr[0]);
+		patch_instruction(dest + 1, instr[1]);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
 	long *start, *end;
-- 
2.14.1
