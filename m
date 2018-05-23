Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPk26CfdzDr43
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:47:22 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id 30-v6so12502240pld.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:47:22 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 03/29] powerpc: export tm_enable()/tm_disable/tm_abort()
 APIs
Date: Wed, 23 May 2018 15:01:46 +0800
Message-Id: <1527058932-7434-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch exports tm_enable()/tm_disable/tm_abort() APIs, which
will be used for PR KVM transaction memory logic.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/asm-prototypes.h |  3 +++
 arch/powerpc/include/asm/tm.h             |  2 --
 arch/powerpc/kernel/tm.S                  | 12 ++++++++++++
 arch/powerpc/mm/hash_utils_64.c           |  1 +
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index d9713ad..dfdcb23 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -141,4 +141,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 void pnv_power9_force_smt4_catch(void);
 void pnv_power9_force_smt4_release(void);
 
+void tm_enable(void);
+void tm_disable(void);
+void tm_abort(uint8_t cause);
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
index b1658c9..e94f6db 100644
--- a/arch/powerpc/include/asm/tm.h
+++ b/arch/powerpc/include/asm/tm.h
@@ -10,12 +10,10 @@
 
 #ifndef __ASSEMBLY__
 
-extern void tm_enable(void);
 extern void tm_reclaim(struct thread_struct *thread,
 		       uint8_t cause);
 extern void tm_reclaim_current(uint8_t cause);
 extern void tm_recheckpoint(struct thread_struct *thread);
-extern void tm_abort(uint8_t cause);
 extern void tm_save_sprs(struct thread_struct *thread);
 extern void tm_restore_sprs(struct thread_struct *thread);
 
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index b92ac8e..ff12f47 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -12,6 +12,7 @@
 #include <asm/ptrace.h>
 #include <asm/reg.h>
 #include <asm/bug.h>
+#include <asm/export.h>
 
 #ifdef CONFIG_VSX
 /* See fpu.S, this is borrowed from there */
@@ -55,6 +56,16 @@ _GLOBAL(tm_enable)
 	or	r4, r4, r3
 	mtmsrd	r4
 1:	blr
+EXPORT_SYMBOL_GPL(tm_enable);
+
+_GLOBAL(tm_disable)
+	mfmsr	r4
+	li	r3, MSR_TM >> 32
+	sldi	r3, r3, 32
+	andc	r4, r4, r3
+	mtmsrd	r4
+	blr
+EXPORT_SYMBOL_GPL(tm_disable);
 
 _GLOBAL(tm_save_sprs)
 	mfspr	r0, SPRN_TFHAR
@@ -78,6 +89,7 @@ _GLOBAL(tm_restore_sprs)
 _GLOBAL(tm_abort)
 	TABORT(R3)
 	blr
+EXPORT_SYMBOL_GPL(tm_abort);
 
 /* void tm_reclaim(struct thread_struct *thread,
  *		   uint8_t cause)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0bd3790..1bd8b4c1 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -64,6 +64,7 @@
 #include <asm/trace.h>
 #include <asm/ps3.h>
 #include <asm/pte-walk.h>
+#include <asm/asm-prototypes.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
-- 
1.8.3.1
