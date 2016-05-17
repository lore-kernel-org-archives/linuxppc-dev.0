Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8GCF122zzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 22:01:44 +1000 (AEST)
Message-Id: <fb8a0e9fa5af537857fb3ee25caf0c634894cca4.1463486314.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/2] powerpc32: Use instruction symbolic names in
 check_io_access()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 May 2016 14:01:39 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc-opcode.h | 1 +
 arch/powerpc/kernel/traps.c           | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1d035c1..37e7b9d 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -148,6 +148,7 @@
 #define PPC_INST_LWSYNC			0x7c2004ac
 #define PPC_INST_SYNC			0x7c0004ac
 #define PPC_INST_SYNC_MASK		0xfc0007fe
+#define PPC_INST_ISYNC			0x4c00012c
 #define PPC_INST_LXVD2X			0x7c000698
 #define PPC_INST_MCRXR			0x7c000400
 #define PPC_INST_MCRXR_MASK		0xfc0007fe
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9229ba6..255f5cc 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -342,12 +342,11 @@ static inline int check_io_access(struct pt_regs *regs)
 		 * For the debug message, we look at the preceding
 		 * load or store.
 		 */
-		if (*nip == 0x60000000)		/* nop */
+		if (*nip == PPC_INST_NOP)
 			nip -= 2;
-		else if (*nip == 0x4c00012c)	/* isync */
+		else if (*nip == PPC_INST_ISYNC)
 			--nip;
-		if (*nip == 0x7c0004ac || (*nip >> 26) == 3) {
-			/* sync or twi */
+		if (*nip == PPC_INST_SYNC || (*nip >> 26) == OP_TRAP) {
 			unsigned int rb;
 
 			--nip;
-- 
2.1.0
