Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s60N60b2zF1P6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 21:02:12 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: fix invalid register expression in head_8xx.S
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180524110206.EFE226C991@localhost.localdomain>
Date: Thu, 24 May 2018 11:02:06 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

New binutils generate the following warning

  AS      arch/powerpc/kernel/head_8xx.o
arch/powerpc/kernel/head_8xx.S: Assembler messages:
arch/powerpc/kernel/head_8xx.S:916: Warning: invalid register expression

This patch fixes it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index d8670a37d70c..6cab07e76732 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -913,7 +913,7 @@ start_here:
 	tovirt(r6,r6)
 	lis	r5, abatron_pteptrs@h
 	ori	r5, r5, abatron_pteptrs@l
-	stw	r5, 0xf0(r0)	/* Must match your Abatron config file */
+	stw	r5, 0xf0(0)	/* Must match your Abatron config file */
 	tophys(r5,r5)
 	stw	r6, 0(r5)
 
-- 
2.13.3
