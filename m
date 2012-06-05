Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id DDAA5B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 12:27:58 +1000 (EST)
Message-ID: <1338863274.13348.530.camel@gandalf.stny.rr.com>
Subject: [PATCH] powerpc/ftrace: Do not trace restore_interrupts()
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 04 Jun 2012 22:27:54 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Cc: stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As I was adding code that affects all archs, I started testing function
tracer against PPC64 and found that it currently locks up with 3.4
kernel. I figured it was due to tracing a function that shouldn't be, so
I went through the following process to bisect to find the culprit:

 cat /debug/tracing/available_filter_functions > t
 num=`wc -l t`
 sed -ne "1,${num}p" t > t1
 let num=num+1
 sed -ne "${num},$p" t > t2
 cat t1 > /debug/tracing/set_ftrace_filter
 echo function /debug/tracing/current_tracer
 <failed? bisect t1, if not bisect t2>

It finally came down to this function: restore_interrupts()

I'm not sure why this locks up the system. It just seems to prevent
scheduling from occurring. Interrupts seem to still work, as I can ping
the box. But all user processes freeze.

When restore_interrupts() is not traced, function tracing works fine.

Cc: stable@kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 641da9e..64eec59 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -277,7 +277,7 @@ EXPORT_SYMBOL(arch_local_irq_restore);
  * NOTE: This is called with interrupts hard disabled but not marked
  * as such in paca->irq_happened, so we need to resync this.
  */
-void restore_interrupts(void)
+void notrace restore_interrupts(void)
 {
 	if (irqs_disabled()) {
 		local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
