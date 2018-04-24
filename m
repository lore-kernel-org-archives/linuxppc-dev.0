Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VVPf3zW5zF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 14:16:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	msuchanek@suse.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] powerpc/64s: Add barrier_nospec
Date: Tue, 24 Apr 2018 14:15:54 +1000
Message-Id: <20180424041559.32410-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Suchanek <msuchanek@suse.de>

A no-op form of ori (or immediate of 0 into r31 and the result stored
in r31) has been re-tasked as a speculation barrier. The instruction
only acts as a barrier on newer machines with appropriate firmware
support. On older CPUs it remains a harmless no-op.

Implement barrier_nospec using this instruction.

mpe: The semantics of the instruction are believed to be that it
prevents execution of subsequent instructions until preceding branches
have been fully resolved and are no longer executing speculatively.
There is no further documentation available at this time.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
mpe: Make it Book3S64 only, update comment & change log, add a
     memory clobber to the asm.
---
 arch/powerpc/include/asm/barrier.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index c7c63959ba91..e582d2c88092 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,6 +76,21 @@ do {									\
 	___p1;								\
 })
 
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * Prevent execution of subsequent instructions until preceding branches have
+ * been fully resolved and are no longer executing speculatively.
+ */
+#define barrier_nospec_asm ori 31,31,0
+
+// This also acts as a compiler barrier due to the memory clobber.
+#define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
+
+#else /* !CONFIG_PPC_BOOK3S_64 */
+#define barrier_nospec_asm
+#define barrier_nospec()
+#endif
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_POWERPC_BARRIER_H */
-- 
2.14.1
