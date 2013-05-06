Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF2222C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 13:10:36 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <agraf@suse.de>
Subject: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
Date: Mon, 6 May 2013 11:10:31 +0800
Message-ID: <1367809831-28838-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the external interrupt, the decrementer exception and the doorbell
excpetion, we also need to soft-disable interrupts while doing as host
interrupt handlers since the DO_KVM hook is always performed to skip
EXCEPTION_COMMON then miss this original chance with the 'ints' (INTS_DISABLE).

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kvm/bookehv_interrupts.S |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index e8ed7d6..2fd62bf 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -33,6 +33,8 @@
 
 #ifdef CONFIG_64BIT
 #include <asm/exception-64e.h>
+#include <asm/hw_irq.h>
+#include <asm/irqflags.h>
 #else
 #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
 #endif
@@ -469,6 +471,13 @@ _GLOBAL(kvmppc_resume_host)
 	PPC_LL	r3, HOST_RUN(r1)
 	mr	r5, r14 /* intno */
 	mr	r14, r4 /* Save vcpu pointer. */
+#ifdef CONFIG_64BIT
+	/* Should we soft-disable interrupts? */
+	andi.	r6, r5, BOOKE_INTERRUPT_EXTERNAL | BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
+	beq	skip_soft_dis
+	SOFT_DISABLE_INTS(r7,r8)
+skip_soft_dis:
+#endif
 	bl	kvmppc_handle_exit
 
 	/* Restore vcpu pointer and the nonvolatiles we used. */
-- 
1.7.9.5
