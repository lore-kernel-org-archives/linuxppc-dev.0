Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DF8EFB6F72
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 20:02:59 +1100 (EST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Fix interrupt handling in MPC8xxx GPIO driver
Date: Tue, 11 Oct 2011 10:24:21 +0200
Message-Id: <1318321461-3066-1-git-send-email-felix@embedded-sol.com>
Cc: Felix Radensky <felix@embedded-sol.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Interrupt handler in MPC8xxx GPIO driver is missing the call
to PIC EOI (end of interrupt) handler. As a result, at least
on 85XX systems, GPIO interrupt is delivered only once. This
patch adds the missing EOI call. Tested on custom P1022 board.

Signed-off-by: Felix Radensky <felix@embedded-sol.com>
---
 arch/powerpc/sysdev/mpc8xxx_gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index fb4963a..d2e0e1c 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -153,6 +153,7 @@ static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
 	if (mask)
 		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
 						     32 - ffs(mask)));
+	desc->chip->eoi(irq);
 }
 
 static void mpc8xxx_irq_unmask(struct irq_data *d)
-- 
1.7.4.4
