Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id B06091007DB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 21:04:21 +1000 (EST)
From: Ian Campbell <ian.campbell@citrix.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] irq: rename IRQF_TIMER to IRQF_NO_SUSPEND
Date: Wed, 28 Jul 2010 11:54:24 +0100
Message-Id: <1280314467-5637-1-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
References: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
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

Continue to provide IRQF_TIMER as an alias to IRQF_NO_SUSPEND since I
think it is worth preserving the nice self-documenting name (where it
is used appropriately). It also avoid needing to patch all the many
users who are using the flag for an actual timer interrupt.

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
 include/linux/interrupt.h |    8 ++++++--
 kernel/irq/manage.c       |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c233113..b9bedd5 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -44,7 +44,7 @@
  * IRQF_SAMPLE_RANDOM - irq is used to feed the random generator
  * IRQF_SHARED - allow sharing the irq among several devices
  * IRQF_PROBE_SHARED - set by callers when they expect sharing mismatches to occur
- * IRQF_TIMER - Flag to mark this interrupt as timer interrupt
+ * IRQF_NO_SUSPEND - Do not disable this IRQ during suspend
  * IRQF_PERCPU - Interrupt is per cpu
  * IRQF_NOBALANCING - Flag to exclude this interrupt from irq balancing
  * IRQF_IRQPOLL - Interrupt is used for polling (only the interrupt that is
@@ -53,17 +53,21 @@
  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
  *                Used by threaded interrupts which need to keep the
  *                irq line disabled until the threaded handler has been run.
+ *
+ * IRQF_TIMER - Flag to mark this interrupt as timer interrupt
  */
 #define IRQF_DISABLED		0x00000020
 #define IRQF_SAMPLE_RANDOM	0x00000040
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
-#define IRQF_TIMER		0x00000200
+#define IRQF_NO_SUSPEND		0x00000200
 #define IRQF_PERCPU		0x00000400
 #define IRQF_NOBALANCING	0x00000800
 #define IRQF_IRQPOLL		0x00001000
 #define IRQF_ONESHOT		0x00002000
 
+#define IRQF_TIMER		(IRQF_NO_SUSPEND)
+
 /*
  * Bits used by threaded handlers:
  * IRQTF_RUNTHREAD - signals that the interrupt handler thread should run
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
