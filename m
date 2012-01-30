Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A25F1B6FB6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 08:28:48 +1100 (EST)
Received: by mail-yw0-f51.google.com with SMTP id o47so2113115yho.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2012 13:28:48 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC] powerpc: Make SPARSE_IRQ required
Date: Mon, 30 Jan 2012 11:02:19 -0700
Message-Id: <1327946539-17614-1-git-send-email-grant.likely@secretlab.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All IRQs on powerpc are managed via irq_domain anyway, there isn't really
any advantage to turning SPARSE_IRQ off, and it's the direction we want
to take the kernel design anyway.  This patch makes powerpc always use
SPARSE_IRQ.

On pseries_defconfig, SPARSE_IRQ adds only about 0x300 bytes to the
.text sections, and removes about 0x20000 from the data section for the
static irq_desc table.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/Kconfig      |    2 +-
 arch/powerpc/kernel/irq.c |    4 ----
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 303703d..1aa840d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -133,7 +133,7 @@ config PPC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
 	select HAVE_GENERIC_HARDIRQS
-	select HAVE_SPARSE_IRQ
+	select SPARSE_IRQ
 	select IRQ_PER_CPU
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_SHOW
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index e3673ff..282fb39 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -93,10 +93,6 @@ extern int tau_interrupts(int);
 
 #ifdef CONFIG_PPC64
 
-#ifndef CONFIG_SPARSE_IRQ
-EXPORT_SYMBOL(irq_desc);
-#endif
-
 int distribute_irqs = 1;
 
 static inline notrace unsigned long get_hard_enabled(void)
-- 
1.7.5.4
