Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4JV110X4zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 23:31:53 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Remove redundant test in transfer_to_handler()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170414133148.A458B6E5FA@localhost.localdomain>
Date: Fri, 14 Apr 2017 15:31:48 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As stated in the comment on top of transfer_to_handler(),
all callers set cr0.eq if the exception occurred in kernel mode
(i.e. MSR:PR = 0)

Therefore, it is not needed to do the test again

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index a38600949f3a..0651a7438fa6 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -141,7 +141,6 @@ transfer_to_handler:
 	stw	r2,GPR2(r11)
 	stw	r12,_NIP(r11)
 	stw	r9,_MSR(r11)
-	andi.	r2,r9,MSR_PR
 	mfctr	r12
 	mfspr	r2,SPRN_XER
 	stw	r12,_CTR(r11)
-- 
2.12.0
