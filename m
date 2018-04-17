Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QPrf70W2zF1vZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 22:36:50 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/boot: remove unused variable in mpc8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180417123646.066056C09D@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 17 Apr 2018 14:36:45 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Variable div is set but never used. Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/boot/mpc8xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/mpc8xx.c b/arch/powerpc/boot/mpc8xx.c
index add55a7f184f..c9bd9285c548 100644
--- a/arch/powerpc/boot/mpc8xx.c
+++ b/arch/powerpc/boot/mpc8xx.c
@@ -24,7 +24,7 @@ u32 mpc885_get_clock(u32 crystal)
 {
 	u32 *immr;
 	u32 plprcr;
-	int mfi, mfn, mfd, pdf, div;
+	int mfi, mfn, mfd, pdf;
 	u32 ret;
 
 	immr = fsl_get_immr();
@@ -43,7 +43,6 @@ u32 mpc885_get_clock(u32 crystal)
 	}
 
 	pdf = (plprcr >> 1) & 0xf;
-	div = (plprcr >> 20) & 3;
 	mfd = (plprcr >> 22) & 0x1f;
 	mfn = (plprcr >> 27) & 0x1f;
 
-- 
2.13.3
