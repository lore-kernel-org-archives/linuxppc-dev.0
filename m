Message-ID: <3981DEB5.9B1756DD@mvista.com>
Date: Fri, 28 Jul 2000 12:27:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MontaVista->sandpoint_setup.c:  changing IRQs
References: <000401bff808$a2501f90$4d012ac7@warp-speed> <3980B7FD.1BC681E6@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Ron.

>The sandpoint code sets up the EPIC to cascade to the 8259.
>
>I've changed it to try to use the openpic for all irqs.  And changed
>the sandpoint_map[]
>in sandpoint_pci.c to agree with my hardware.
>And all other sandpoint specific irq stuff, including #if 0'ing  out
all >code related to
>the 8259 in the sandpoint files.
>
>FYI, I've tried to create 2 replacement files for sandpoint_setup.c
>and sandpoint_pci.c
>with different names but changing the Makefile where the related
>object files are
>referenced is not sufficient to have the new files included in the
>build.  I don't
>understand all the components that control a build well enough >yet to
make successful
>changes to the process.  I wish there was some detailed >explaination
somewhere.
>
>I'm still uncertain that I've done all the right things.
>
>In sandpoint_init_IRQ():
>
>- I'm uncertain about:   irq_desc[i].ctl = &open_pic   where i is less
>than 16.    Should
>I include 0 to 15 for this?

Basically, irq's 0-15 were reserved for the 8259 and irq's 16, 17, 18,
and 19 were for the 4 PCI interrupts that go directly into the 8240's
epic (MPC107's epic, whatever).  The actual loops set irq's 0-15 to
&i8259_pic and irq's 16-NR_IRQS to &openpic_pic (even though only 16-19
will be used).

The 8259 interrupt is shared with either PCI slot 2 or 3's INTA line.
There are only 4 external epic interrupts hooked up (which will report
irq values from 16-19.) one of which will really be an 8259 interrupt.

When an external interrupt hits, sandpoint_get_irq() is called and will
look at the epic for the irq (by calling openpic_irq() which will return
an irq in range of 16-19).  If the irq is the one shared with the i8259,
it will call i8259_irq() to get the 8259 irq (in range of 0-15).  It
then returns the irq (in range 0-19) to do_IRQ() which called
sandpoint_get_irq() and do_IRQ() will call the appropriate handler
(because in the earlier loops we set up the handlers for irq's 0-15 to
be the 8259 intr handler and irq's 16-19 to be the openpic intr handler.

Make sense?

Basically, if you don't have an cascaded PIC, simply set up the epic for
the irq's that are hooked up to something, and set up the
irq_desc[i].handler to &open_pic.  You don't need to set up irq's in
irq_desc[] that will never be called or you can just set them all to
&open_pic.

Regarding the makefile setup.  Probably the place you want to start is
arch/ppc/config.in.  That is the file that has the menus that you will
see with "make menuconfig" (or whatever make config you use) that are
for the architecture selection.  It also causes CONFIG_XXX to be defined
for your architecture.  Take a look and you should see how other
architectures did it.

Did I answer all your questions?

>- Since there is no setup for the 8259 now in 'my' modified code, >is
there someplace
>amongst all the openpic init stuff where I need to explicitly provide
>EPIC register setup
>for all interrupts to direct mode?

Take a look in arch/ppc/kernel/open_pic.c:openpic_init() and you will
see the openpic being setup (calls to openpic_initirq() and
openpic_mapirq()).

Mark


--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
