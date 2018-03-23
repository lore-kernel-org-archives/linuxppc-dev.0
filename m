Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406t5F54CNzF21Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 16:53:53 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id 61-v6so6876613plf.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 22:53:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] powerpc/64s: Fix i-side SLB miss bad address handler saving
 nonvolatile GPRs
Date: Fri, 23 Mar 2018 15:53:38 +1000
Message-Id: <20180323055338.7066-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SLB bad address handler's trap number fixup does not preserve the
low bit that indicates nonvolatile GPRs have not been saved. This
leads save_nvgprs to skip saving them, and subsequent functions and
return from interrupt will think they are saved.

This causes kernel branch-to-garbage debugging to not have correct
registers, can also cause userspace to have its registers clobbered
after a segfault.

Fixes: f0f558b131 ("powerpc/mm: Preserve CFAR value on SLB miss caused by access to bogus address")
Cc: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3ac87e53b3da..1ecfd8ffb098 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -706,7 +706,7 @@ EXC_COMMON_BEGIN(bad_addr_slb)
 	ld	r3, PACA_EXSLB+EX_DAR(r13)
 	std	r3, _DAR(r1)
 	beq	cr6, 2f
-	li	r10, 0x480		/* fix trap number for I-SLB miss */
+	li	r10, 0x481		/* fix trap number for I-SLB miss */
 	std	r10, _TRAP(r1)
 2:	bl	save_nvgprs
 	addi	r3, r1, STACK_FRAME_OVERHEAD
-- 
2.16.1
