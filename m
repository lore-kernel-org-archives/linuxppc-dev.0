Message-ID: <39C8C584.D845678A@siemens.at>
Date: Wed, 20 Sep 2000 16:11:16 +0200
From: Rainer Kloud <rainer.kloud@siemens.at>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 FCC Ethernet driver, cpm_8260.h
References: <39C1DE70.F1D90668@siemens.at> <39C24395.756E3252@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Dan,

> Rainer Kloud wrote:
>
> > So my question is: Does anyone have a Ethernet Driver
> > for the FCC?
>
> Ummmm.....arch/ppc/8260_io/fcc_enet.c should do the trick......
>
> I am constantly making updates to the sources for 8260, and recently
> updated the driver (there is another major update coming).  You should
> probably get used to using the BitKeeper tree from FSM Labs...
>         www.fsmlabs.com/linuxppcbk/html

Thank you for your tip, the source file wasn't included in my
old distribution.

But one further question:
After compelation of your driver I was able to send some
data (bootp request), but I couldn't receive any. Further
I got no transmit interrupt. So I took a look to the FCC
mask register and I saw that the FCCM (and of course FCCE)
register is a 32 bit register where only the higher word is
used. But when useing the event constants (f.e. FCC_ENET_TXB)
from cpm_8260.h only the bits in the lower word are set.
So setting the desired events in the FCC mask register has
no effect!
After that I have changed the constants to manipulate the
high word and everything seems to work correct (I got my
transmit and receive interrupts).
I have seen, that the FCCM/FCCE are different from other
channels, f.e the SCC. There the mask register is only
defined as 16 bit register.

What do you think about this?

Bye,
Rainer


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
