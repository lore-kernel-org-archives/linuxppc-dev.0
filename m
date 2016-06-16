Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVjVH3mC2zDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 22:33:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: dja@axtens.net
Subject: [PATCH] powerpc/align: Use #ifdef __BIG_ENDIAN__ #else for REG_BYTE
Date: Thu, 16 Jun 2016 22:33:41 +1000
Message-Id: <1466080421-25188-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Daniel Axtens <dja@axtens.net>

Sparse complains that it doesn't know what REG_BYTE is:

  arch/powerpc/kernel/align.c:313:29: error: undefined identifier 'REG_BYTE'

REG_BYTE is defined differently based on whether we're compiling for
LE, BE32 or BE64. Sparse apparently doesn't provide __BIG_ENDIAN__ or
__LITTLE_ENDIAN__, which means we get no definition.

Rather than check for __BIG_ENDIAN__ and then separately for
__LITTLE_ENDIAN__, just switch the #ifdef to check for __BIG_ENDIAN__
and then #else we define the little endian version. Technically that's
dicey because PDP_ENDIAN is also a possibility, but we already do it in
a lot of places so one more hardly matters.

Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/align.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 8e7cb8e2b21a..d7ad66bc5bdf 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -228,9 +228,7 @@ static int emulate_dcbz(struct pt_regs *regs, unsigned char __user *addr)
 #else
 #define REG_BYTE(rp, i)		*((u8 *)(rp) + (i))
 #endif
-#endif
-
-#ifdef __LITTLE_ENDIAN__
+#else
 #define REG_BYTE(rp, i)		(*(((u8 *)((rp) + ((i)>>2)) + ((i)&3))))
 #endif
 
-- 
2.5.0
