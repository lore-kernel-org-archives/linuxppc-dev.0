Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id A5AECDDFD5
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 05:39:56 +1000 (EST)
Message-ID: <46685F77.7050901@ru.mvista.com>
Date: Thu, 07 Jun 2007 23:41:43 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Randy Vinson <rvinson@mvista.com>
Subject: Re: [RFC] 85XX: Allow 8259 cascade to share an MPIC interrupt line.
References: <466755AC.40201@mvista.com> <46683D12.1050204@ru.mvista.com>
	<46685B9C.10501@mvista.com>
In-Reply-To: <46685B9C.10501@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randy Vinson wrote:

>>>---
>>>Note that there may very well be a better way of accomplishing this.
>>>If someone
>>>has a better alternative, I'm open to it. This was just the simplest
>>>way I could
>>>get this to work.

>>>Also, the addition of the .end routine for the MPIC is not strictly
>>>necessary for
>>>this patch. It's there so this code will run from within the threaded
>>>interrupt
>>>context used by the Real Time 

>>   Hmmm, why would you need that? Where RT is different from the
>>vanilla? :-O

> The threaded interrupt system has threaded routines for the 4 standard
> interrupts types used by the generic IRQ system (fasteoi, edge, level
> and simple), plus a handler for non-generic interrupts (the ones that
> still use __do_IRQ.) When interrupts are being threaded and a
> non-cascaded MPIC interrupt occurs, desc->handler normally points to
> handle_fasteoi_irq which masks the interrupt source, schedules the
> corresponding IRQ thread, issues an EOI and returns to the interrupted
> context. At a later time, the scheduler dispatches the IRQ thread which
> calls a threaded version of the fasteoi handler. The threaded fasteoi
> routine processes the action chain and calls .unmask to re-enable the
> interrupt before returning to the calling thread. Once the interrupt has
> been unmasked, the entire process is free to repeat as needed.

    Oh, you could have really skipped the basics. ;-)

> After processing a possible 8259 interrupt, the 8259 cascade handler
> calls handle_fasteoi_irq to perform the actions noted above. However,
> with the 8259 cascade handler hooked to the interrupt, the threaded IRQ
> handler doesn't recognize it as one of the 4 standard generic IRQ types
> and calls the threaded version of do_irq instead of the threaded fasteoi
> handler.

    Ah, that's it!

> Once the threaded do_irq handler completes the action list, it
> uses the .end routine to restart the interrupt flow. Pointing .end to
> the standard MPIC unmask routine allows it to balance the interrupt mask
> operation performed by handle_fasteoi_irq before it scheduled the IRQ
> thread.

    Well, but when MPIC's eoi() method is called then? :-O

>>> arch/powerpc/platforms/85xx/mpc85xx_cds.c |   32
>>>+++++++++++++++++++++++++---
>>> arch/powerpc/sysdev/mpic.c                |    1 +
>>> 2 files changed, 29 insertions(+), 4 deletions(-)

>>>diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
>>>b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
>>>index 1490eb3..431aaa2 100644
>>>--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
>>>+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
>>>@@ -127,16 +127,30 @@ static void __init mpc85xx_cds_pcibios_fixup(void)
>>> }

>>> #ifdef CONFIG_PPC_I8259
>>>-#warning The i8259 PIC support is currently broken
>>>-static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc
>>>*desc)
>>>+static void mpc85xx_8259_cascade_handler(unsigned int irq,
>>>+                     struct irq_desc *desc)
>>> {
>>>     unsigned int cascade_irq = i8259_irq();
>>> 
>>>     if (cascade_irq != NO_IRQ)
>>>+        /* handle an interrupt from the 8259 */
>>>         generic_handle_irq(cascade_irq);
>>> 
>>>-    desc->chip->eoi(irq);
>>>+    /* check for any interrupts from the shared IRQ line */
>>>+    handle_fasteoi_irq(irq, desc);
>>> }
>>>+
>>>+static irqreturn_t mpc85xx_8259_cascade_action(int irq, void *dev_id)
>>>+{
>>>+    return IRQ_HANDLED;
>>>+}

>>   Well, mpc85xx_8259_intr() would probably be more in line with the
>>code elsewhere... and you could keep the mpc85xx_8259_cascade() name then.

> I chose the names to show that the two routines run at different levels
> within the interrupt subsystem. The cascade handler always runs in
> interrupt context while the cascade action can run in interrupt context
> or in threaded context. While I was researching this, I kept getting
> confused between the desc->handler and action->handler fields so I named
> them different to make it easier for me to keep the differences clear in
> my head. I can change the names it if you think it's important.

    I don't insist. :-)

> Randy V.

WBR, Sergei
