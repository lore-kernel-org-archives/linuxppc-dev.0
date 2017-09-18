Return-Path: <bhumirks@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwnz46rMfzDrS9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 00:13:04 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id e69so236189pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 07:13:04 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] powerpc: make irq_chip const, __initdata and __initconst
Date: Mon, 18 Sep 2017 19:42:47 +0530
Message-Id: <1505743967-19448-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make ehv_pic_irq_chip, mpic_ipi_chip and mpic_tm_chip const as they are
used only as a copy operation. This usage is during init, so make them
__initconst too.
Make mpic_ipi_chip __initdata as it is only modified during the init
phase and there is no reference of it anywhere after init.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/powerpc/sysdev/ehv_pic.c | 2 +-
 arch/powerpc/sysdev/mpic.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index 48866e6..12a54f3 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -141,7 +141,7 @@ int ehv_pic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
-static struct irq_chip ehv_pic_irq_chip = {
+static const struct irq_chip ehv_pic_irq_chip __initconst = {
 	.irq_mask	= ehv_pic_mask_irq,
 	.irq_unmask	= ehv_pic_unmask_irq,
 	.irq_eoi	= ehv_pic_end_irq,
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index ead3e25..6a435c0 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -964,21 +964,21 @@ static void mpic_set_destination(unsigned int virq, unsigned int cpuid)
 };
 
 #ifdef CONFIG_SMP
-static struct irq_chip mpic_ipi_chip = {
+static const struct irq_chip mpic_ipi_chip __initconst = {
 	.irq_mask	= mpic_mask_ipi,
 	.irq_unmask	= mpic_unmask_ipi,
 	.irq_eoi	= mpic_end_ipi,
 };
 #endif /* CONFIG_SMP */
 
-static struct irq_chip mpic_tm_chip = {
+static struct irq_chip mpic_tm_chip __initdata = {
 	.irq_mask	= mpic_mask_tm,
 	.irq_unmask	= mpic_unmask_tm,
 	.irq_eoi	= mpic_end_irq,
 };
 
 #ifdef CONFIG_MPIC_U3_HT_IRQS
-static struct irq_chip mpic_irq_ht_chip = {
+static const struct irq_chip mpic_irq_ht_chip __initconst = {
 	.irq_startup	= mpic_startup_ht_irq,
 	.irq_shutdown	= mpic_shutdown_ht_irq,
 	.irq_mask	= mpic_mask_irq,
-- 
1.9.1
