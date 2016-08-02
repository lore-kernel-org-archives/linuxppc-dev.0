Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3TM22dzYzDrJT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 18:07:10 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/32: fix csum_partial_copy_generic()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org, antoine.blangy@c-s.fr, segher@kernel.crashing.org
Message-Id: <20160802080705.69A9F1A2394@localhost.localdomain>
Date: Tue,  2 Aug 2016 10:07:05 +0200 (CEST)
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

This patch also fixes related comments

Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
based on copy_tofrom_user()")
Cc: stable@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: updated comments as suggested by Segher

 arch/powerpc/lib/checksum_32.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index d90870a..0a57fe6 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -127,8 +127,9 @@ _GLOBAL(csum_partial_copy_generic)
 	stw	r7,12(r1)
 	stw	r8,8(r1)
 
-	andi.	r0,r4,1			/* is destination address even ? */
-	cmplwi	cr7,r0,0
+	rlwinm	r0,r4,3,0x8
+	rlwnm	r6,r6,r0,0,31	/* odd destination address: rotate one byte */
+	cmplwi	cr7,r0,0	/* is destination address even ? */
 	addic	r12,r6,0
 	addi	r6,r4,-4
 	neg	r0,r4
@@ -237,7 +238,7 @@ _GLOBAL(csum_partial_copy_generic)
 66:	addze	r3,r12
 	addi	r1,r1,16
 	beqlr+	cr7
-	rlwinm	r3,r3,8,0,31	/* swap bytes for odd destination */
+	rlwinm	r3,r3,8,0,31	/* odd destination address: rotate one byte */
 	blr
 
 /* read fault */
-- 
2.1.0
