Date: Thu, 4 Nov 1999 14:27:26 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: Cort Dougan <cort@ppc.kernel.org>,
        David Monro <davidm@amberdata.demon.co.uk>,
        linuxppc-workstation@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQ problems on IBM 850
In-Reply-To: <Pine.LNX.3.96L.991103235121.11884C-100000@unix47.andrew.cmu.edu>
Message-ID: <Pine.HPX.4.10.9911041206100.2724-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 Nov 1999, Hollis R Blanchard wrote:

> An update:
> 
> I found at least a typo in arch/ppc/kernel/i8259.c. At about line 56:
>                 outb(0x20,0xA0);        /* Non-specific EOI */
>                 outb(0x20,0x20);        /* Non-specific EOI to cascade */ 
> 
> What I'm reading says that 0xA0 is the cascade, and 0x20 is the master. So the
> order was the opposite of what the comments said. I would think you would want
> to ack the master first and then the slave, but I changed this and it made no
> difference. :(

Not completely surprising. What if you apply the following patch ? 

It might not solve your problem, but anyway playing with cached_A1 and
cached_21 while an interrupt may be coming is not healthy, to say the
least. 

--- irq.c.orig	Thu Nov  4 12:51:20 1999
+++ irq.c	Thu Nov  4 14:10:41 1999
@@ -50,7 +50,6 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/irq.h>
-#include <asm/bitops.h>
 #include <asm/gg2.h>
 #include <asm/cache.h>
 #include <asm/prom.h>
@@ -61,6 +60,7 @@
 
 #include "local_irq.h"
 
+spinlock_t irq_controller_lock;
 extern volatile unsigned long ipi_count;
 void enable_irq(unsigned int irq_nr);
 void disable_irq(unsigned int irq_nr);
@@ -193,18 +193,27 @@
 /* XXX should implement irq disable depth like on intel */
 void disable_irq_nosync(unsigned int irq_nr)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&irq_controller_lock, flags);
 	mask_irq(irq_nr);
+	spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
 
 void disable_irq(unsigned int irq_nr)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&irq_controller_lock, flags);
 	mask_irq(irq_nr);
+	spin_unlock_irqrestore(&irq_controller_lock, flags);
 	synchronize_irq();
 }
 
 void enable_irq(unsigned int irq_nr)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&irq_controller_lock, flags);
 	unmask_irq(irq_nr);
+	spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
 
 int get_irq_list(char *buf)
@@ -242,6 +251,23 @@
 	len += sprintf(buf+len, "IPI: %10lu\n", ipi_count);
 #endif		
 	len += sprintf(buf+len, "BAD: %10u\n", ppc_spurious_interrupts);
+#if 1
+	do {
+		int imr, isr, irr;
+		spin_lock_irq(&irq_controller_lock);
+		imr = (inb(0xA1)<<8) | inb(0x21);
+		outb(0xb,0x20);
+		outb(0xb,0xa0);
+		isr = (inb(0xA0)<<8) | inb(0x20);
+		outb(0xa,0x20);
+		outb(0xa,0xa0);
+		irr = (inb(0xA0)<<8) | inb(0x20);
+		spin_unlock_irq(&irq_controller_loc);
+		len += sprintf(buf+len, "8259 IMR/ISR/IRR = %04x/%04x/%04x\n",
+			       imr, isr, irr);
+		
+	} while(0);
+#endif	
 	return len;
 }
 
@@ -256,6 +282,10 @@
 	int cpu = smp_processor_id();
 	
 	mask_and_ack_irq(irq);
+	/* See comments in do_IRQ, we don't want another processor to touch
+	 * the masks between acquiring the vector and mask_and_ack.
+	 */
+	spin_unlock(&irq_controller_lock);
 	status = 0;
 	action = irq_desc[irq].action;
 	kstat.irqs[cpu][irq]++;
@@ -267,10 +297,16 @@
 			action->handler(irq, action->dev_id, regs);
 			action = action->next;
 		} while ( action );
-		__cli();
+		spin_lock_irq(&irq_controller_lock);
+		/* Still wrong on SMP, the interrupt might have been
+		 * disabled by another processor while it was active.
+		 * Flags like on i386 are necessary...
+		 */
 		unmask_irq(irq);
+		spin_unlock(&irq_controller_lock);
 	} else {
 		ppc_spurious_interrupts++;
+		/* Is it necessary ? */
 		disable_irq( irq );
 	}
 }
@@ -280,6 +316,11 @@
 	int cpu = smp_processor_id();
 
         hardirq_enter(cpu);
+	/* Ugly, the irq controller has to be locked here and unlocked
+	 * in dispatch_handler it seems. I can't see any better solution
+	 * barring a complete rewrite of interrupt handling :-(
+	 */
+	spin_lock(&irq_controller_lock);
         ppc_md.do_IRQ(regs, cpu, isfake);
         hardirq_exit(cpu);
 }

> My /proc/interrupts reads:
> 1:      576     i8259   keyboard
> 2:        0     i8259   82c59 secondary cascade
> 5:        1     i8259   Crystal audio controller
> 13:  287499     i8259   ide0
> 15:   16720     i8259   PCnet/PCI II 79C970A
> BAD:      1

Now mine reads: 
           CPU0       
  1:          2   i8259         keyboard
  2:          0   i8259         82c59 secondary cascade
  4:          5   i8259         serial
 16:          0   OpenPIC       82c59 cascade
 18:       2754   OpenPIC       DC21140 (eth0)
 19:       1930   OpenPIC       ncr53c8xx
BAD:          1
8259 IMR/ISR/IRR = ffe9/0000/0040

BTW: if you apply only the part which modifies the /proc output you might
be able to know the state of the interrupt controller when the system
locks up. This would be interesting and probably better in a first step,
since the rest of the patch migt clash with your source.  In my case the
floppy interrupt is requested, but as long as it's masked...


> 
> I don't know enough to interpret it. I do have a SCSI card attached right now
> but no drive (and not compiled into the kernel) - is that the "BAD"?
> 
> I also don't know what to make of the lines that look like
>         outb(0xFF, 0x21); /* Mask all */
> and
>         outb(cached_A1, 0x21);
> They're to mask and unmask the interrupts? What is accomplished with
> cached_A1? We keep the same interrupt from being re-entered? (I don't know the
> order the functions in this file are called, nor how Linux interrupt handlers
> work in general.)

I'm in the process of rewriting a lot of i8259.c, but it might take some
time until it stabilizes...

> 
> Also, Cort, in your original comment... I don't see how acking one interrupt
> causes another to be lost - it's only the ISR register that's supposed to be
> cleared, not the IRR. If there are still things in the IRR, another interrupt
> is supposed to be generated and the ISR set appropriately by the controller,
> no?

The 8259 is a fragile beast, plus the fact that the current
enable/disable_irq code is completely unprotected. My patch is not
sufficient but might be a step in the right direction (hopefully enough
on UP). 

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
