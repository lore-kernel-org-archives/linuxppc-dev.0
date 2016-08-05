Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5PgZ03KdzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 21:28:10 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/40x: Clear MSR_DR in one insn instead of two
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160805112806.5E6981A244A@localhost.localdomain>
Date: Fri,  5 Aug 2016 13:28:05 +0200 (CEST)
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
 arch/powerpc/kernel/misc_32.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index d9c912b..e025230 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -243,8 +243,7 @@ _GLOBAL(_nmask_and_or_msr)
  */
 _GLOBAL(real_readb)
 	mfmsr	r7
-	ori	r0,r7,MSR_DR
-	xori	r0,r0,MSR_DR
+	rlwinm	r0,r7,0,~MSR_DR
 	sync
 	mtmsr	r0
 	sync
@@ -261,8 +260,7 @@ _GLOBAL(real_readb)
  */
 _GLOBAL(real_writeb)
 	mfmsr	r7
-	ori	r0,r7,MSR_DR
-	xori	r0,r0,MSR_DR
+	rlwinm	r0,r7,0,~MSR_DR
 	sync
 	mtmsr	r0
 	sync
-- 
2.1.0
