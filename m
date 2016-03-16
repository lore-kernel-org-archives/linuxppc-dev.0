Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ7FB3NshzDqW7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 21:36:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: Make generic_memcpy() private to copy_32.S
Date: Wed, 16 Mar 2016 21:36:06 +1100
Message-Id: <1458124566-17763-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1458124566-17763-1-git-send-email-mpe@ellerman.id.au>
References: <1458124566-17763-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

generic_memcpy() is only called from copy_32.S, so there's no reason for
it to be global.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/copy_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index c44df2dbedd5..99f37f24185c 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -217,7 +217,7 @@ _GLOBAL(memcpy)
 	bdnz	40b
 65:	blr
 
-_GLOBAL(generic_memcpy)
+generic_memcpy:
 	srwi.	r7,r5,3
 	addi	r6,r3,-4
 	addi	r4,r4,-4
-- 
2.5.0
