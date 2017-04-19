Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Mgy66LvzDqvk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:06:06 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id a140so2675190ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 06:06:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/9] powerpc/64s: Remove unnecessary relocation branch from
 idle handler
Date: Wed, 19 Apr 2017 23:05:43 +1000
Message-Id: <20170419130551.32378-2-npiggin@gmail.com>
In-Reply-To: <20170419130551.32378-1-npiggin@gmail.com>
References: <20170419130551.32378-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The system reset idle handler system_reset_idle_common is relocated, so
relocation is not required to branch to kvm_start_guest. The superfluous
relocation does not result in incorrect code, but it does not compile
outside of exception-64s.S (with fixed section definitions).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 8 --------
 arch/powerpc/kernel/exceptions-64s.S     | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 14752eee3d0c..ee21457e23d4 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -256,11 +256,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	ld	r9,area+EX_R9(r13);					\
 	bctr
 
-#define BRANCH_TO_KVM(reg, label)					\
-	__LOAD_FAR_HANDLER(reg, label);					\
-	mtctr	reg;							\
-	bctr
-
 #else
 #define BRANCH_TO_COMMON(reg, label)					\
 	b	label
@@ -268,9 +263,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define BRANCH_LINK_TO_FAR(reg, label)					\
 	bl	label
 
-#define BRANCH_TO_KVM(reg, label)					\
-	b	label
-
 #define __BRANCH_TO_KVM_EXIT(area, label)				\
 	ld	r9,area+EX_R9(r13);					\
 	b	label
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 857bf7c5b946..7d496ee984fe 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -142,7 +142,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
 	cmpwi	r0,0
 	beq	1f
-	BRANCH_TO_KVM(r10, kvm_start_guest)
+	b	kvm_start_guest
 1:
 #endif
 
-- 
2.11.0
