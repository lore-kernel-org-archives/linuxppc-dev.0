Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snWgM09g9zDrDv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 17:03:11 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove static branch prediction in atomic{,
 64}_add_unless
Date: Mon,  3 Oct 2016 17:03:03 +1100
Message-Id: <1475474583-3085-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

I see quite a lot of static branch mispredictions on a simple
web serving workload. The issue is in __atomic_add_unless(), called
from _atomic_dec_and_lock(). There is no obvious common case, so it
is better to let the hardware predict the branch.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/atomic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index f08d567..2b90335 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -233,7 +233,7 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
 	PPC_ATOMIC_ENTRY_BARRIER
 "1:	lwarx	%0,0,%1		# __atomic_add_unless\n\
 	cmpw	0,%0,%3 \n\
-	beq-	2f \n\
+	beq	2f \n\
 	add	%0,%2,%0 \n"
 	PPC405_ERR77(0,%2)
 "	stwcx.	%0,0,%1 \n\
@@ -539,7 +539,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 	PPC_ATOMIC_ENTRY_BARRIER
 "1:	ldarx	%0,0,%1		# __atomic_add_unless\n\
 	cmpd	0,%0,%3 \n\
-	beq-	2f \n\
+	beq	2f \n\
 	add	%0,%2,%0 \n"
 "	stdcx.	%0,0,%1 \n\
 	bne-	1b \n"
-- 
2.7.4
