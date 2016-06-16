Return-Path: <chris@distroguy.com>
Received: from mx-out01.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW0880XWFzDqc2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 09:34:00 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out01.mykolab.com (Postfix) with ESMTPS id A432D615E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 01:33:51 +0200 (CEST)
Date: Fri, 17 Jun 2016 09:33:45 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Patch v2 1/2] powerpc: Send SIGBUS on unaligned copy and paste
Message-ID: <20160616233340.GA14449@distroguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Calling ISA 3.0 instructions copy, copy_first, paste and paste_last
generates an alignment fault when copying or pasting unaligned
data (128 byte). We catch this and send SIGBUS to the userspace
process that caused it.

We do not emulate these because paste may contain additional metadata
when pasting to a co-processor and paste_last is the synchronisation
point for preceding copy/paste sequences.

Thanks to Michael Neuling <mikey@neuling.org> for his help.

Signed-off-by: Chris Smart <chris@distroguy.com>
---

Changes since v1:
 - define and use instruction for mask test

 arch/powerpc/include/asm/ppc-opcode.h |  4 ++++
 arch/powerpc/kernel/align.c           | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1d035c1cc889..7921d3e5704d 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -131,6 +131,8 @@
 /* sorted alphabetically */
 #define PPC_INST_BHRBE			0x7c00025c
 #define PPC_INST_CLRBHRB		0x7c00035c
+#define PPC_INST_COPY			0x7c00060c
+#define PPC_INST_COPY_FIRST		0x7c20060c
 #define PPC_INST_CP_ABORT		0x7c00068c
 #define PPC_INST_DCBA			0x7c0005ec
 #define PPC_INST_DCBA_MASK		0xfc0007fe
@@ -159,6 +161,8 @@
 #define PPC_INST_MSGSNDP		0x7c00011c
 #define PPC_INST_MTTMR			0x7c0003dc
 #define PPC_INST_NOP			0x60000000
+#define PPC_INST_PASTE			0x7c00070c
+#define PPC_INST_PASTE_LAST		0x7c20070d
 #define PPC_INST_POPCNTB		0x7c0000f4
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
 #define PPC_INST_POPCNTD		0x7c0003f4
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 8e7cb8e2b21a..6e0a1f8495f2 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -875,6 +875,20 @@ int fix_alignment(struct pt_regs *regs)
 		return emulate_vsx(addr, reg, areg, regs, flags, nb, elsize);
 	}
 #endif
+
+	/*
+	 * ISA 3.0 (such as P9) copy, copy_first, paste and paste_last alignment
+	 * check.
+	 *
+	 * Send a SIGBUS to the process that caused the fault.
+	 *
+	 * We do not emulate these because paste may contain additional metadata
+	 * when pasting to a co-processor. Furthermore, paste_last is the
+	 * synchronisation point for preceding copy/paste sequences.
+	 */
+	if ((instruction & 0xfc0006fe) == PPC_INST_COPY)
+		return -EIO;
+
 	/* A size of 0 indicates an instruction we don't support, with
 	 * the exception of DCBZ which is handled as a special case here
 	 */
-- 
2.7.4
