Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 02/16] powerpc: Add new instructions for transactional memory
Date: Tue, 27 Nov 2012 13:47:54 +1100
Message-Id: <1353984488-1283-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1353984488-1283-1-git-send-email-mikey@neuling.org>
References: <1353984488-1283-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here we define the new instructions we need for transactional memory in the
kernel.  This is so we can support compiling with binutils that don't support
the new transactional memory instructions.

Transactional memory results in two sets of architected state (GPRs/VSRs
etc).

treclaim allows us to read the checkpointed state (from the tbegin) so that we
can store it away on a context switch.  It does this by overwriting the exiting
architected state, so you have to save that away before you treclaim.  treclaim
will also abort a transaction, so you can give a register value which contains
an abort reason.

trecheckpoint allows us to inject into the checkpointed state as if it were at
the tbegin.  It does this by copying the current architected state into the
checkpointed state.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/ppc-opcode.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 45fd394..3674ffc 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -129,6 +129,8 @@
 #define PPC_INST_TLBSRX_DOT		0x7c0006a5
 #define PPC_INST_XXLOR			0xf0000510
 #define PPC_INST_XVCPSGNDP		0xf0000780
+#define PPC_INST_TRECHKPT		0x7c0007dd
+#define PPC_INST_TRECLAIM		0x7c00075d
 
 #define PPC_INST_NAP			0x4c000364
 #define PPC_INST_SLEEP			0x4c0003a4
@@ -291,4 +293,9 @@
 #define PPC_NAP			stringify_in_c(.long PPC_INST_NAP)
 #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
 
+/* Transactional memory instructions */
+#define TRECHKPT		stringify_in_c(.long PPC_INST_TRECHKPT)
+#define TRECLAIM(r)		stringify_in_c(.long PPC_INST_TRECLAIM \
+					       | __PPC_RA(r))
+
 #endif /* _ASM_POWERPC_PPC_OPCODE_H */
-- 
1.7.9.5
