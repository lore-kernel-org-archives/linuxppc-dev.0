Subject: Re: Problems with 2_4_devel & MVME2600 serial interrupts
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <E9EEC3C2-E2B0-11D6-8132-0003931C2BFA@control.lth.se>
References: <E9EEC3C2-E2B0-11D6-8132-0003931C2BFA@control.lth.se>
Date: 18 Oct 2002 11:04:15 -0500
Message-Id: <1034957059.8253.110.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2002-10-18 at 10:47, Anders Blomdell wrote:
> > Seems to me that either:
> > a) the pci_intack value is incorrect for your board, in which case you
> > should correct it
> Shure is, question is if it really should be caught from the pci_intack
> register,

If possible, yes it should (IMHO). There was a thread on linuxppc-dev
about a year ago:
http://lists.linuxppc.org/linuxppc-dev/200112/msg00032.html

I think Gabriel's point about hardware testing methods is the best
argument, though I also think having hardware figure it out greatly
diminishes the chance of software polling race conditions such as those
that plagued a few desktop PReP machines for a long time.

> as far as I can understand from the MVME2600 doc's, the 8259
> interrupt generates a MPIC-IRQ0, but one has to poll the 8259 to find out
> what device it was that generated the interrupt.

Yes. Software can do this. The alternative is that some hardware (PHBs)
can do it too, which is what you're using if you pass a non-0 address to
i8259_init.

> Perhaps an extra field in the 'mot_info' (arch/ppc/platforms/prep_pci.c) is
> called for? This line in prep_init_IRQ (arch/ppc/platforms/prep_setup.c):
>
>    i8259_init(0xbffffff0); /* PCI interrupt ack address for MPC105 and 106
> */
>
> does not look like a general solution.

What you're saying is that you have a PReP machine without a Motorola
host bridge? Then yes, that constant will need to be abstracted.

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
