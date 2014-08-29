Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id BCE0E1A0B6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 19:14:46 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 19/19] powerpc/8xx: Don't restore regs to save them again.
Message-Id: <20140829091440.C97981ABD65@localhost.localdomain>
Date: Fri, 29 Aug 2014 11:14:40 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is not need to restore r10, r11 and cr registers at this end of ITLBmiss
handler as they are saved again to the same place in ITLBError handler we are
jumping to.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/kernel/head_8xx.S |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index bb7c816..e21f0b2 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -381,8 +381,7 @@ InstructionTLBMiss:
 	lwz	r3, 8(r0)
 #endif
 	mfspr	r10, SPRN_SPRG_SCRATCH2
-	EXCEPTION_EPILOG_0
-	b	InstructionTLBError
+	b	InstructionTLBError1
 
 	. = 0x1200
 DataStoreTLBMiss:
@@ -471,7 +470,10 @@ DataStoreTLBMiss:
  */
 	. = 0x1300
 InstructionTLBError:
-	EXCEPTION_PROLOG
+	EXCEPTION_PROLOG_0
+InstructionTLBError1:
+	EXCEPTION_PROLOG_1
+	EXCEPTION_PROLOG_2
 	mr	r4,r12
 	mr	r5,r9
 	EXC_XFER_LITE(0x1300, handle_page_fault)
-- 
1.7.1
