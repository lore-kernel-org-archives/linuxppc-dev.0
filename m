Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A6011A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 22:09:50 +1100 (AEDT)
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 2/5] printk/nmi: Use IRQ work only when ready
Date: Fri, 27 Nov 2015 12:09:29 +0100
Message-Id: <1448622572-16900-3-git-send-email-pmladek@suse.com>
In-Reply-To: <1448622572-16900-1-git-send-email-pmladek@suse.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NMIs could happen at any time. This patch makes sure that the safe
printk() in NMI will schedule IRQ work only when the related
structs are initialized.

All pending messages are flushed when the IRQ work is being
initialized.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 3989e13a0021..05b4c09110f9 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -36,6 +36,7 @@
  * were handled or when IRQs are blocked.
  */
 DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
+static int printk_nmi_irq_ready;
 
 struct nmi_seq_buf {
 	atomic_t		len;	/* length of written data */
@@ -80,8 +81,11 @@ again:
 		goto again;
 
 	/* Get flushed in a more safe context. */
-	if (add)
+	if (add && printk_nmi_irq_ready) {
+		/* Make sure that IRQ work is really initialized. */
+		smp_rmb();
 		irq_work_queue(&s->work);
+	}
 
 	return add;
 }
@@ -187,6 +191,13 @@ void __init printk_nmi_init(void)
 
 		init_irq_work(&s->work, __printk_nmi_flush);
 	}
+
+	/* Make sure that IRQ works are initialized before enabling. */
+	smp_wmb();
+	printk_nmi_irq_ready = 1;
+
+	/* Flush pending messages that did not have scheduled IRQ works. */
+	printk_nmi_flush();
 }
 
 void printk_nmi_enter(void)
-- 
1.8.5.6
