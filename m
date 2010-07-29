Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id 4B1F0100AC3
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 20:16:46 +1000 (EST)
From: Ian Campbell <ian.campbell@citrix.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] irq: Add new IRQ flag IRQF_NO_SUSPEND
Date: Thu, 29 Jul 2010 11:16:32 +0100
Message-Id: <1280398595-29708-1-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1280398573.24292.1684.camel@zakaz.uk.xensource.com>
References: <1280398573.24292.1684.camel@zakaz.uk.xensource.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com,
	Ian Campbell <ian.campbell@citrix.com>,
	devicetree-discuss@lists.ozlabs.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-input@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A small number of users of IRQF_TIMER are using it for the implied no
suspend behaviour on interrupts which are not timer interrupts.

Therefore add a new IRQF_NO_SUSPEND flag, rename IRQF_TIMER to
__IRQF_TIMER and redefine IRQF_TIMER in terms of these new flags.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: xen-devel@lists.xensource.com
Cc: linux-input@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 include/linux/interrupt.h |    7 ++++++-
 kernel/irq/manage.c       |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c233113..a0384a4 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -53,16 +53,21 @@
  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
  *                Used by threaded interrupts which need to keep the
  *                irq line disabled until the threaded handler has been run.
+ * IRQF_NO_SUSPEND - Do not disable this IRQ during suspend
+ *
  */
 #define IRQF_DISABLED		0x00000020
 #define IRQF_SAMPLE_RANDOM	0x00000040
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
-#define IRQF_TIMER		0x00000200
+#define __IRQF_TIMER		0x00000200
 #define IRQF_PERCPU		0x00000400
 #define IRQF_NOBALANCING	0x00000800
 #define IRQF_IRQPOLL		0x00001000
 #define IRQF_ONESHOT		0x00002000
+#define IRQF_NO_SUSPEND		0x00004000
+
+#define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND)
 
 /*
  * Bits used by threaded handlers:
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e149748..c3003e9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -216,7 +216,7 @@ static inline int setup_affinity(unsigned int irq, struct irq_desc *desc)
 void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspend)
 {
 	if (suspend) {
-		if (!desc->action || (desc->action->flags & IRQF_TIMER))
+		if (!desc->action || (desc->action->flags & IRQF_NO_SUSPEND))
 			return;
 		desc->status |= IRQ_SUSPENDED;
 	}
-- 
1.5.6.5
