Date: Thu, 4 Nov 1999 00:33:01 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Gabriel Paubert <paubert@iram.es>
cc: Cort Dougan <cort@ppc.kernel.org>,
        David Monro <davidm@amberdata.demon.co.uk>,
        linuxppc-workstation@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQ problems on IBM 850
In-Reply-To: <Pine.HPX.4.10.9910252356120.21757-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96L.991103235121.11884C-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Oct 1999, Gabriel Paubert wrote:
> 
> On Mon, 25 Oct 1999, Cort Dougan wrote:
> 
> > I remember this problem some time ago.  The failure mode seems to be we get
> > 2 interrupts on the cascaded 8259 (irq > 7), we handle one and ack/eoi that
> > whole thing so we loose one of the interrupts.  On the 830's (I'm not sure
> > about the 850) the IDE and pcnet are on the cascaded 8259 controller so I
> > was able to easily reproduce this problem when trying to fix it by
> > generating a lot of network and disk traffic (such as copying something
> > to/from the network).
> > 
> > I had a loop in the 8259 code for some time to go through until it didn't
> > find any more interrupts pending.
> 
> In i8259.c, yes but a loop reading the IRR is not enough since it does not
> reset the edge detect logic. There is anyway one contradiction between
> what is implemented in the kernel and what my 8259 doc claims in the order
> of the EOI to the slave and master. Since on my machine I don't use the
> slave, I can't test it. 
> 
> cat /proc/interrupts
>            CPU0       
>   1:          8   i8259         keyboard
>   2:          0   i8259         82c59 secondary cascade
>   4:        680   i8259         serial
>  16:          0   OpenPIC       82c59 cascade
>  18:    1727293   OpenPIC       DC21140 (eth0)
>  19:     152520   OpenPIC       ncr53c8xx
>  21:   55648729   OpenPIC       vme (Universe)
> BAD:          0

An update:

I found at least a typo in arch/ppc/kernel/i8259.c. At about line 56:
                outb(0x20,0xA0);        /* Non-specific EOI */
                outb(0x20,0x20);        /* Non-specific EOI to cascade */ 

What I'm reading says that 0xA0 is the cascade, and 0x20 is the master. So the
order was the opposite of what the comments said. I would think you would want
to ack the master first and then the slave, but I changed this and it made no
difference. :(

My /proc/interrupts reads:
1:      576     i8259   keyboard
2:        0     i8259   82c59 secondary cascade
5:        1     i8259   Crystal audio controller
13:  287499     i8259   ide0
15:   16720     i8259   PCnet/PCI II 79C970A
BAD:      1

I don't know enough to interpret it. I do have a SCSI card attached right now
but no drive (and not compiled into the kernel) - is that the "BAD"?

I also don't know what to make of the lines that look like
        outb(0xFF, 0x21); /* Mask all */
and
        outb(cached_A1, 0x21);
They're to mask and unmask the interrupts? What is accomplished with
cached_A1? We keep the same interrupt from being re-entered? (I don't know the
order the functions in this file are called, nor how Linux interrupt handlers
work in general.)

Also, Cort, in your original comment... I don't see how acking one interrupt
causes another to be lost - it's only the ISR register that's supposed to be
cleared, not the IRR. If there are still things in the IRR, another interrupt
is supposed to be generated and the ISR set appropriately by the controller,
no?

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
