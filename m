Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wVBmK3MVKzDqdg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 14:30:09 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id f27so11417841pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 21:30:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, tuliom@linux.vnet.ibm.com,
 Michael Ellerman <mpe@ellerman.id.au>, benh@ozlabs.au.ibm.com,
 Peter Bergner <bergner@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Bill Schmidt <wschmidt@us.ibm.com>
Subject: [PATCH] powerpc: add PPC_FEATURE userspace bits for SCV and DARN
 instructions
Date: Sat, 20 May 2017 14:29:49 +1000
Message-Id: <20170520042949.29359-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Providing "scv" support to userspace requires kernel support, so it
must be advertised as independently to the base ISA 3 instruction set.

The darn instruction relies on firmware enablement, so it has been
decided to split this out from the core ISA 3 feature as well.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
These uapi changes have been agreed by powerpc toolchain and firmware
teams. I believe this completes our anticipated requirements for user
feature advertisement for ISA v3.0B.

 arch/powerpc/include/uapi/asm/cputable.h | 2 ++
 arch/powerpc/kernel/cputable.c           | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index 3e7ce86d5c13..4d877144f377 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -46,6 +46,8 @@
 #define PPC_FEATURE2_HTM_NOSC		0x01000000
 #define PPC_FEATURE2_ARCH_3_00		0x00800000 /* ISA 3.00 */
 #define PPC_FEATURE2_HAS_IEEE128	0x00400000 /* VSX IEEE Binary Float 128-bit */
+#define PPC_FEATURE2_DARN		0x00200000 /* darn random number insn */
+#define PPC_FEATURE2_SCV		0x00100000 /* scv syscall */
 
 /*
  * IMPORTANT!
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9b3e88b1a9c8..6f849832a669 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -124,7 +124,8 @@ extern void __restore_cpu_e6500(void);
 #define COMMON_USER_POWER9	COMMON_USER_POWER8
 #define COMMON_USER2_POWER9	(COMMON_USER2_POWER8 | \
 				 PPC_FEATURE2_ARCH_3_00 | \
-				 PPC_FEATURE2_HAS_IEEE128)
+				 PPC_FEATURE2_HAS_IEEE128 | \
+				 PPC_FEATURE2_DARN )
 
 #ifdef CONFIG_PPC_BOOK3E_64
 #define COMMON_USER_BOOKE	(COMMON_USER_PPC64 | PPC_FEATURE_BOOKE)
-- 
2.11.0
