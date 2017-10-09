Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9ch70MWgzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 21:59:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: Add kstack base to paca dump
Date: Mon,  9 Oct 2017 21:59:32 +1100
Message-Id: <1507546772-31932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When dumping the paca in xmon we currently show kstack. Although it's
not hard it's a bit fiddly to work out what the bounds of the kernel
stack should be based on the kstack value.

To make life easier and "kstack_base" which is the base (lowest
address) of the kernel stack, eg:

 kstack               = 0xc0000000f1a7be30      (0x258)
 kstack_base          = 0xc0000000f1a78000

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 429339df0e8e..b45741c50253 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2388,6 +2388,7 @@ static void dump_one_paca(int cpu)
 #endif
 	DUMP(p, __current, "p");
 	DUMP(p, kstack, "lx");
+	printf(" kstack_base          = 0x%016lx\n", p->kstack & ~(THREAD_SIZE - 1));
 	DUMP(p, stab_rr, "lx");
 	DUMP(p, saved_r1, "lx");
 	DUMP(p, trap_save, "x");
-- 
2.7.4
