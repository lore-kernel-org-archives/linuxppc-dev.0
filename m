Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPPkx6bh7zDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 17:26:01 +1100 (AEDT)
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 15 Mar 2016 01:25:51 -0500
Message-Id: <1458023151-32066-1-git-send-email-oss@buserror.net>
Subject: [PATCH] powerpc/8xx: Fix do_mtspr_cpu6 build on older compilers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some versions of GCC, reportedly before 4.9, fail with
arch/powerpc/mm/8xx_mmu.c:139:2: error: memory input 1 is not directly
addressable

Use a register constraint instead of a memory constraint to avoid this.
Also change the one-element array into a simple variable.

Signed-off-by: Scott Wood <oss@buserror.net>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
---
Christope, could you test?  And was there any particular reason for the [1]?

 arch/powerpc/include/asm/reg_8xx.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index d41412c..cb7dfb9 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -53,11 +53,11 @@
 #ifdef CONFIG_8xx_CPU6
 #define do_mtspr_cpu6(rn, rn_addr, v)	\
 	do {								\
-		int _reg_cpu6 = rn_addr, _tmp_cpu6[1];		\
-		asm volatile("stw %0, %1;"				\
-			     "lwz %0, %1;"				\
+		int _reg_cpu6 = rn_addr, _tmp_cpu6;		\
+		asm volatile("stwx %0, 0, %1;"				\
+			     "lwzx %0, 0, %1;"				\
 			     "mtspr " __stringify(rn) ",%2" :		\
-			     : "r" (_reg_cpu6), "m"(_tmp_cpu6),		\
+			     : "r" (_reg_cpu6), "r" (&_tmp_cpu6),	\
 			       "r" ((unsigned long)(v))			\
 			     : "memory");				\
 	} while (0)
-- 
2.5.0
