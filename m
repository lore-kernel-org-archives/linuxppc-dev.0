Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHnFY3H0FzF0Xv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:46:41 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/xive: Add interrupt flag to disable automatic EOI
Date: Fri, 12 Jan 2018 13:39:28 +1100
Message-Id: <20180112023928.10926-2-benh@kernel.crashing.org>
In-Reply-To: <20180112023928.10926-1-benh@kernel.crashing.org>
References: <20180112023928.10926-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will be used by KVM in order to keep escalation interrupts
in the non-EOI (masked) state after they fire. They will be
re-enabled directly in HW by KVM when needed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/xive.h   | 3 +++
 arch/powerpc/sysdev/xive/common.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 0e77005cf021..b619a5585cd6 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -58,6 +58,9 @@ struct xive_irq_data {
 #define XIVE_IRQ_FLAG_EOI_FW	0x10
 #define XIVE_IRQ_FLAG_H_INT_ESB	0x20
 
+/* Special flag set by KVM for excalation interrupts */
+#define XIVE_IRQ_NO_EOI		0x80
+
 #define XIVE_INVALID_CHIP_ID	-1
 
 /* A queue tracking structure in a CPU */
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 838ebdbfe4c5..40c06110821c 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -367,7 +367,8 @@ static void xive_irq_eoi(struct irq_data *d)
 	 * EOI the source if it hasn't been disabled and hasn't
 	 * been passed-through to a KVM guest
 	 */
-	if (!irqd_irq_disabled(d) && !irqd_is_forwarded_to_vcpu(d))
+	if (!irqd_irq_disabled(d) && !irqd_is_forwarded_to_vcpu(d) &&
+	    !(xd->flags & XIVE_IRQ_NO_EOI))
 		xive_do_source_eoi(irqd_to_hwirq(d), xd);
 
 	/*
-- 
2.14.3
