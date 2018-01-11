Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMBf4RS2zF0XF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:42 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id d23so1311509pfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:42 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 14/26] KVM: PPC: Book3S PR: export
 tm_enable()/tm_disable/tm_abort() APIs
Date: Thu, 11 Jan 2018 18:11:27 +0800
Message-Id: <1515665499-31710-15-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
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
index 9c3b290..2a0f54e 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -133,4 +133,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 void _kvmppc_save_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
 #endif
 
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
index 655a5a9..d354de6 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -63,6 +63,7 @@
 #include <asm/trace.h>
 #include <asm/ps3.h>
 #include <asm/pte-walk.h>
+#include <asm/asm-prototypes.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
-- 
1.8.3.1
