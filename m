Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2zpx6m6XzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 22:56:09 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: fix csum_partial_copy_generic()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org, antoine.blangy@c-s.fr
Message-Id: <20160801125605.410371A23A2@localhost.localdomain>
Date: Mon,  1 Aug 2016 14:56:05 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
based on copy_tofrom_user()") introduced a bug when destination
address is odd and initial csum is not null

In that (rare) case the initial csum value has to be rotated one byte
as well as the resulting value is

Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
based on copy_tofrom_user()")
Cc: stable@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/checksum_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index d90870a..ad0870a 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -127,7 +127,8 @@ _GLOBAL(csum_partial_copy_generic)
 	stw	r7,12(r1)
 	stw	r8,8(r1)
 
-	andi.	r0,r4,1			/* is destination address even ? */
+	rlwinm	r0,r4,3,0x8		/* is destination address even ? */
+	rlwnm	r6,r6,r0,0,31		/* swap bytes for odd destination */
 	cmplwi	cr7,r0,0
 	addic	r12,r6,0
 	addi	r6,r4,-4
-- 
2.1.0
