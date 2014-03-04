Return-Path: <tipbot@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 127232C0267
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 04:14:45 +1100 (EST)
Date: Tue, 4 Mar 2014 08:39:42 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c866cda47f2c6c8abb929933b7794e9a92d7c924@git.kernel.org>
In-Reply-To: <20140223212736.451970660@linutronix.de>
References: <20140223212736.451970660@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] powerpc:eVh_pic: Kill irq_desc abuse
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: timur@freescale.com, peterz@infradead.org, ashish.kalra@freescale.com,
 linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 peterz@infradead.org, galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 ashish.kalra@freescale.com, benh@kernel.crashing.org, timur@freescale.com,
 tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  c866cda47f2c6c8abb929933b7794e9a92d7c924
Gitweb:     http://git.kernel.org/tip/c866cda47f2c6c8abb929933b7794e9a92d7c924
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Feb 2014 21:40:08 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 4 Mar 2014 17:37:51 +0100

powerpc:eVh_pic: Kill irq_desc abuse

I'm really grumpy about this one. The line:

#include "../../../kernel/irq/settings.h"

should have been an alarm sign for all people who added their SOB to
this trainwreck.

When I cleaned up the mess people made with interrupt descriptors a
few years ago, I warned that I'm going to hunt down new offenders and
treat them with stinking trouts. In this case I'll use frozen shark
for a better educational value.

The whole idiocy which was done there could have been avoided with two
lines of perfectly fine code. And do not complain about the lack of
correct examples in tree.

The solution is simple:

  Remove the brainfart and use the proper functions, which should
  have been used in the first place

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ashish Kalra <ashish.kalra@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: ppc <linuxppc-dev@lists.ozlabs.org>
Link: http://lkml.kernel.org/r/20140223212736.451970660@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/ehv_pic.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index b74085c..2d20f10 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -28,8 +28,6 @@
 #include <asm/ehv_pic.h>
 #include <asm/fsl_hcalls.h>
 
-#include "../../../kernel/irq/settings.h"
-
 static struct ehv_pic *global_ehv_pic;
 static DEFINE_SPINLOCK(ehv_pic_lock);
 
@@ -113,17 +111,13 @@ static unsigned int ehv_pic_type_to_vecpri(unsigned int type)
 int ehv_pic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
 	unsigned int src = virq_to_hw(d->irq);
-	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vecpri, vold, vnew, prio, cpu_dest;
 	unsigned long flags;
 
 	if (flow_type == IRQ_TYPE_NONE)
 		flow_type = IRQ_TYPE_LEVEL_LOW;
 
-	irq_settings_clr_level(desc);
-	irq_settings_set_trigger_mask(desc, flow_type);
-	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
-		irq_settings_set_level(desc);
+	irqd_set_trigger_type(d, flow_type);
 
 	vecpri = ehv_pic_type_to_vecpri(flow_type);
 
@@ -144,7 +138,7 @@ int ehv_pic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	ev_int_set_config(src, vecpri, prio, cpu_dest);
 
 	spin_unlock_irqrestore(&ehv_pic_lock, flags);
-	return 0;
+	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
 static struct irq_chip ehv_pic_irq_chip = {
