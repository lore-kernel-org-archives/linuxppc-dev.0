Date: Fri, 11 Feb 2000 18:11:17 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-bk@fsmlabs.com
Subject: Re: Latest OpenPic changes
In-Reply-To: <Pine.LNX.4.05.10002111739060.387-100000@callisto.of.borg>
Message-ID: <Pine.HPX.4.10.10002111800210.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 11 Feb 2000, Geert Uytterhoeven wrote:

>
> 	Hi Ben,
>
> After two days of hacking I finally found out what went wrong. Your changes to
> the OpenPIC code cause my machine to hang in openpic_enable_irq(). I added a
> timeout to the do { ... } while (...) loop:

Please use ISU[irq - open_pic_irq_offset] everywhere. You are not reading
the interrupt you are modifying probably. On the other hand I'm using a
completely different solution, and I don't read back when enabling the
IRQ. I can't see why you could need it, this will go to the bus sooner or
later, why wait one or several microseconds while the interrupts are being
acttually enabled in the controller ?



>
> void openpic_enable_irq(u_int irq)
> {
>         int timeout = 1000000;
>         check_arg_irq(irq);
>         openpic_clearfield(&ISU[irq - open_pic_irq_offset].Vector_Priority, OPENPIC_MASK);
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         /* make sure mask gets to controller before we return to user */
>         do {
>                 mb(); /* sync is probably useless here */
>         } while(openpic_readfield(&OpenPIC->Source[irq].Vector_Priority,
				    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                         OPENPIC_MASK) && --timeout);
>         if (!timeout)
>             printk("openpic_enable_irq %d timeout status 0x%08x\n", irq, openpic_readfield(&OpenPIC->Source[irq].Vector_Priority,OPENPIC_MASK));
> }
>

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
