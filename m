Date: Fri, 5 Nov 1999 09:42:17 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: Cort Dougan <cort@ppc.kernel.org>,
        David Monro <davidm@amberdata.demon.co.uk>,
        linuxppc-workstation@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQ problems on IBM 850
In-Reply-To: <Pine.LNX.3.96L.991104145520.4298C-100000@unix47.andrew.cmu.edu>
Message-ID: <Pine.HPX.4.10.9911050931010.2724-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 4 Nov 1999, Hollis R Blanchard wrote:

> The spinlock patch doesn't appear to have any affect on the situation. Still
> lots of "hda - lost interrupt"'s.

Now I might start to understand why.

> 
> A normal (no disk activity) /proc/interrupts:
> 1:     1321     i8259   keyboard
> 2:        0     i8259   82c59 secondary cascade
> 5:        1     i8259   Crystal audio controller
> 13:   82733     i8259   ide0
> 15:   30749     i8259   PCnet/PCI II 79C970A
> BAD:      1
> 8259 IMR/ISR/IRR = 5f99/0000/0001
> 
> When "lost interrupts" are occuring (the keyboard does still function Gabriel,
> my mistake), the last line consistantly looks like:
> 
> 8259 IMR/ISR/IRR = 5f99/0000/a001
> 
> The 'a' indicates that interrupts have come in on irq's 13 & 15, which would
> be ide0 and the ethernet controller. So it seems Cort's memory is correct. (In
> your output, is irq 6 '0x0040' the floppy drive you mention?)

Using interrupt 13 is strange, to say the least. It was reserved for FPU
errors on x86 processors. In your case obviously the interrupts are
expected (since you have a timeout) but have stayed masked for some
reason. We have to find where this happens. Some code paths might have an
unbalanced enable/disable_irq but I suspect that it will be hard to find.

Perhaps we should add some debugging code (again bloating
/proc/interrupts :-)) giving the address of the caller of the last
{en,dis}able_irq for every interrupt (just add 2 fields to each interrupt
struct ({dis,en}abled_by) set to builtin_return_address in
{dis,en}able_irq. Then print those addresses in /proc/interrupts. Can you
write such a patch or should I do it myself ?

And yes, irq 6 is the floppy drive, although I've no floppy connected. But
the controller is here. 

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
