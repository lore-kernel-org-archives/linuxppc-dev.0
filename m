Return-Path: <hugh_dickins@symantec.com>
Received: from extu-mxob-1.symantec.com (extu-mxob-1.symantec.com
	[216.10.194.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E14F67B6A
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 06:03:53 +1100 (EST)
Date: Tue, 31 Oct 2006 18:43:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/5] ppc64: make soft_enabled irqs preempt safe
In-Reply-To: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0610311841570.26470@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rewrite local_get_flags and local_irq_disable to use r13 explicitly,
to avoid the risk that gcc will split get_paca()->soft_enabled into
a sequence unsafe against preemption.

local_irq_restore be careful to access hard_enabled and lppaca before
setting soft_enabled, which may well permit preemption.  Use local_paca
instead of get_paca() when setting hard_enabled: looking ahead to the
DEBUG_PREEMPT patch, which uses local_paca as the raw unchecked version.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
As before, my powerpc and inline asm may be nonsense: please do fix it.
This patch is to powerpc git code, not intended for 2.6.19.

 arch/powerpc/kernel/irq.c    |   20 +++++++++++++++-----
 include/asm-powerpc/hw_irq.h |   20 +++++++++++++++-----
 2 files changed, 30 insertions(+), 10 deletions(-)

--- git-powerpc/arch/powerpc/kernel/irq.c	2006-10-30 19:30:57.000000000 +0000
+++ linux/arch/powerpc/kernel/irq.c	2006-10-30 19:32:38.000000000 +0000
@@ -99,20 +99,30 @@ int distribute_irqs = 1;
 
 void local_irq_restore(unsigned long en)
 {
-	get_paca()->soft_enabled = en;
-	if (!en)
+	unsigned long hard_enabled;
+
+	if (!en) {
+		get_paca()->soft_enabled = en;
 		return;
+	}
 
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		if (get_paca()->lppaca_ptr->int_dword.any_int)
+		unsigned long any_int;
+
+		any_int = get_lppaca()->int_dword.any_int;
+		get_paca()->soft_enabled = en;
+		if (any_int)
 			iseries_handle_interrupts();
 		return;
 	}
 
-	if (get_paca()->hard_enabled)
+	hard_enabled = get_paca()->hard_enabled;
+	get_paca()->soft_enabled = en;
+	if (hard_enabled)
 		return;
+
 	/* need to hard-enable interrupts here */
-	get_paca()->hard_enabled = en;
+	local_paca->hard_enabled = en;
 	if ((int)mfspr(SPRN_DEC) < 0)
 		mtspr(SPRN_DEC, 1);
 	hard_irq_enable();
--- git-powerpc/include/asm-powerpc/hw_irq.h	2006-10-30 19:30:57.000000000 +0000
+++ linux/include/asm-powerpc/hw_irq.h	2006-10-30 19:32:38.000000000 +0000
@@ -18,15 +18,25 @@ extern void timer_interrupt(struct pt_re
 
 static inline unsigned long local_get_flags(void)
 {
-	return get_paca()->soft_enabled;
+	unsigned long flags;
+
+	__asm__ __volatile__("lbz %0,%1(13)"
+	: "=r" (flags)
+	: "i" (offsetof(struct paca_struct, soft_enabled)));
+
+	return flags;
 }
 
 static inline unsigned long local_irq_disable(void)
 {
-	unsigned long flag = get_paca()->soft_enabled;
-	get_paca()->soft_enabled = 0;
-	barrier();
-	return flag;
+	unsigned long flags, zero;
+
+	__asm__ __volatile__("li %1,0; lbz %0,%2(13); stb %1,%2(13)"
+	: "=r" (flags), "=&r" (zero)
+	: "i" (offsetof(struct paca_struct, soft_enabled))
+	: "memory");
+
+	return flags;
 }
 
 extern void local_irq_restore(unsigned long);
