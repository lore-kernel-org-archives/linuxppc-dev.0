Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8GCG0cZGzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 22:01:46 +1000 (AEST)
Message-Id: <3257f244fea7785aa1791d3ac68922692bffc3c3.1463486314.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/2] powerpc32: fix check_io_access()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 May 2016 14:01:41 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On processors like the 8xx, the machine check exception can also
happen directly on the load/store instruction itself, so that case
needs to be handled as well

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc-opcode.h |  1 +
 arch/powerpc/kernel/traps.c           | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 37e7b9d..5e613b8 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -84,6 +84,7 @@
 /* opcode and xopcode for instructions */
 #define OP_TRAP 3
 #define OP_TRAP_64 2
+#define OP_31		31
 
 #define OP_31_XOP_TRAP      4
 #define OP_31_XOP_LWZX      23
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 255f5cc..27f1a36 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -334,6 +334,7 @@ static inline int check_io_access(struct pt_regs *regs)
 
 	if (((msr & 0xffff0000) == 0 || (msr & (0x80000 | 0x40000)))
 	    && (entry = search_exception_tables(regs->nip)) != NULL) {
+		int op, xop;
 		/*
 		 * Check that it's a sync instruction, or somewhere
 		 * in the twi; isync; nop sequence that inb/inw/inl uses.
@@ -346,10 +347,18 @@ static inline int check_io_access(struct pt_regs *regs)
 			nip -= 2;
 		else if (*nip == PPC_INST_ISYNC)
 			--nip;
-		if (*nip == PPC_INST_SYNC || (*nip >> 26) == OP_TRAP) {
+		if (*nip == PPC_INST_SYNC || (*nip >> 26) == OP_TRAP)
+			--nip;
+		op = *nip >> 26;
+		xop = (*nip >> 1) & 0x3ff;
+		if (op == OP_LWZ || op == OP_LBZ || op == OP_STW ||
+		    op == OP_STB || op == OP_LHZ || op == OP_STH ||
+		    (op == OP_31 &&
+		     (xop == OP_31_XOP_LBZX || xop == OP_31_XOP_LHBRX ||
+		      xop == OP_31_XOP_LWBRX || xop == OP_31_XOP_STBX ||
+		      xop == OP_31_XOP_STHBRX || xop == OP_31_XOP_STWBRX))) {
 			unsigned int rb;
 
-			--nip;
 			rb = (*nip >> 11) & 0x1f;
 			printk(KERN_DEBUG "%s bad port %lx at %p\n",
 			       (*nip & 0x100)? "OUT to": "IN from",
-- 
2.1.0
