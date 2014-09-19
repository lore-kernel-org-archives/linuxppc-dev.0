Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 0319F1A0B61
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 18:36:16 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v4 19/21] powerpc/8xx: Don't restore regs to save them again.
Message-Id: <20140919083610.7D8E01AB03E@localhost.localdomain>
Date: Fri, 19 Sep 2014 10:36:10 +0200 (CEST)
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
Changes in v2:
- None

Changes in v3:
- None

Changes in v4:
- None

 arch/powerpc/kernel/head_8xx.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index f372984..bcf0a43 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -383,8 +383,7 @@ InstructionTLBMiss:
 	lwz	r3, 8(r0)
 #endif
 	mfspr	r10, SPRN_SPRG_SCRATCH2
-	EXCEPTION_EPILOG_0
-	b	InstructionTLBError
+	b	InstructionTLBError1
 
 	. = 0x1200
 DataStoreTLBMiss:
@@ -473,7 +472,10 @@ DataStoreTLBMiss:
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
 	/* 0x400 is InstructionAccess exception, needed by bad_page_fault() */
-- 
2.1.0
