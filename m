Message-ID: <38BF7E76.34F12DF8@redhat.com>
Date: Fri, 03 Mar 2000 03:57:26 -0500
From: Doug Ledford <dledford@redhat.com>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Need reports about PCI I/O conflicts
References: <20000302152244.014464@mailhost.mipsys.com> <v04220800b4e5212c2027@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:

>    PCI: setting IRQ 24 on device 01:18.
>    PCI: Correcting IOaddress 0 on device 01:18, now fe000001.
>    PCI: Enabling I/O for device 01:18
>    PCI: setting IRQ 25 on device 01:20.
>    PCI: Correcting IOaddress 0 on device 01:20, now fe000001.
>    PCI: Correcting IOaddress 0 on device 01:21, now fe000001.
>
> 01:18 is the 2940UW, 01:20 and 01:21 the two channels of the 39160.
>
> I remember looking at the code which enables I/O for a device, but it
> wasn't clear to me at that time how it decided whether to enable I/O.
>
> By the way, Doug, can you comment on whether the 39160 should get one
> or two IRQs?  I/O and memory base registers are clearly not shared
> between the channels, but according to these boot messages, only one
> channel gets assigned an IRQ.  (I've confirmed this with lspci.)
>
> I'm guessing only one is required, due to the need to conserve IRQs
> in the PC world, but you never know.

On all the recent dual channel controllers (meaning everything after the
original 3940 cards that had three large chips, a DEC bridge chip and two 7880
chips, where as the later 3940 cards have a 7895 chip and the dual channel
ultra2 and later cards are all single chip designs) the cards will route one
channel's interrupt through the INTA connector on the card edge and will route
the other channel's interrupt through the INTB connector on the card edge.
This is hard wired on the cards, so whether or not the channels share the same
interrupt is determined by whether or not the INTA and INTB connectors on a
single slot share the same interrupt.  That is motherboard specific and
typically up to the machine's BIOS to set up in the interrupt tables so that
the kernel PCI code can read it and do the right thing.


--

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
