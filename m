Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3pwW0vgNzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 14:19:23 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, maddy@linux.vnet.ibm.com, grimm@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Ignore reserved field in DCSR and PVR reads and
 writes
Date: Thu, 19 Jan 2017 14:19:10 +1100
Message-Id: <20170119031910.2335-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

IBM bit 31 (for the rest of us - bit 0) is a reserved field in the
instruction definition of mtspr and mfspr. Hardware is encouraged to
(and does) ignore it.

As a result, if userspace executes an mtspr DSCR with the reserved bit
set, we get a DSCR facility unavailable exception. The kernel fails to
match against the expected value/mask, and we silently return to
userspace to try and re-execute the same mtspr DSCR instruction. We
loop forever until the process is killed.

We should do something here, and it seems mirroring what hardware does
is the better option vs killing the process. While here, relax the
matching of mfspr PVR too.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc-opcode.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index c56ea8c..c4ced1d 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -157,7 +157,7 @@
 #define PPC_INST_MCRXR			0x7c000400
 #define PPC_INST_MCRXR_MASK		0xfc0007fe
 #define PPC_INST_MFSPR_PVR		0x7c1f42a6
-#define PPC_INST_MFSPR_PVR_MASK		0xfc1fffff
+#define PPC_INST_MFSPR_PVR_MASK		0xfc1ffffe
 #define PPC_INST_MFTMR			0x7c0002dc
 #define PPC_INST_MSGSND			0x7c00019c
 #define PPC_INST_MSGCLR			0x7c0001dc
@@ -174,13 +174,13 @@
 #define PPC_INST_RFDI			0x4c00004e
 #define PPC_INST_RFMCI			0x4c00004c
 #define PPC_INST_MFSPR_DSCR		0x7c1102a6
-#define PPC_INST_MFSPR_DSCR_MASK	0xfc1fffff
+#define PPC_INST_MFSPR_DSCR_MASK	0xfc1ffffe
 #define PPC_INST_MTSPR_DSCR		0x7c1103a6
-#define PPC_INST_MTSPR_DSCR_MASK	0xfc1fffff
+#define PPC_INST_MTSPR_DSCR_MASK	0xfc1ffffe
 #define PPC_INST_MFSPR_DSCR_USER	0x7c0302a6
-#define PPC_INST_MFSPR_DSCR_USER_MASK	0xfc1fffff
+#define PPC_INST_MFSPR_DSCR_USER_MASK	0xfc1ffffe
 #define PPC_INST_MTSPR_DSCR_USER	0x7c0303a6
-#define PPC_INST_MTSPR_DSCR_USER_MASK	0xfc1fffff
+#define PPC_INST_MTSPR_DSCR_USER_MASK	0xfc1ffffe
 #define PPC_INST_MFVSRD			0x7c000066
 #define PPC_INST_MTVSRD			0x7c000166
 #define PPC_INST_SLBFEE			0x7c0007a7
-- 
2.9.3
