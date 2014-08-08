Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 71D261A0A83
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 17:04:31 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 08/20] powerpc/8xx: No need to restore registers and save them
 again.
Message-Id: <20140808070341.F381E1ABD44@localhost.localdomain>
Date: Fri,  8 Aug 2014 09:03:41 +0200 (CEST)
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

In DTLBError handler there is not need to restore r10, r11 and cr registers
after fixing DAR as they are saved again to the same place just after.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/kernel/head_8xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5f04d5f..e5a250c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -478,8 +478,8 @@ DataTLBError:
 	cmpwi	cr0, r11, 0x00f0
 	beq-	FixupDAR	/* must be a buggy dcbX, icbi insn. */
 DARFixed:/* Return from dcbx instruction bug workaround */
-	EXCEPTION_EPILOG_0
-	EXCEPTION_PROLOG
+	EXCEPTION_PROLOG_1
+	EXCEPTION_PROLOG_2
 	mfspr	r10,SPRN_DSISR
 	stw	r10,_DSISR(r11)
 	mr	r5,r10
-- 
1.7.1
