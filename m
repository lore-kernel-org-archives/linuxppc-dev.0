Date: Fri, 18 Oct 2002 17:47:32 +0200
Subject: Re: Problems with 2_4_devel & MVME2600 serial interrupts
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
To: Hollis Blanchard <hollis@austin.ibm.com>
From: Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <1034954142.8169.91.camel@granite.austin.ibm.com>
Message-Id: <E9EEC3C2-E2B0-11D6-8132-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Seems to me that either:
> a) the pci_intack value is incorrect for your board, in which case you
> should correct it
Shure is, question is if it really should be caught from the pci_intack
register, as far as I can understand from the MVME2600 doc's, the 8259
interrupt generates a MPIC-IRQ0, but one has to poll the 8259 to find out
what device it was that generated the interrupt.


> b) your board's int-ack feature is broken and you'll need to poll

Perhaps an extra field in the 'mot_info' (arch/ppc/platforms/prep_pci.c) is
called for? This line in prep_init_IRQ (arch/ppc/platforms/prep_setup.c):

   i8259_init(0xbffffff0); /* PCI interrupt ack address for MPC105 and 106
*/

does not look like a general solution.

I'll take a further look in next week. Any comments/suggestions are welcome.
..

Regards

Anders Blomdell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
