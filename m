From: Benjamin Herrenschmidt <bh40@calva.net>
To: De Schrijver Peter <schrijvp@rc.bel.alcatel.be>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS
 Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Date: Tue, 20 Jun 2000 15:30:01 +0200
Message-Id: <20000620133001.23202@mailhost.mipsys.com>
In-Reply-To: <20000620152509.O1177@rc.bel.alcatel.be>
References: <20000620152509.O1177@rc.bel.alcatel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 20, 2000, De Schrijver Peter <schrijvp@rc.bel.alcatel.be> wrote:

>> We still can decide (and that's what I currently do in the kernel) that
>> IO space is only supported on one of those 3 busses (the one on which the
>> external PCI is). This prevents however use of IOs on the AGP slot, which
>> is a problem for things like XFree who may try to use VGA addresses on
>> the card.
>>
>
>Is this really a problem ? I would expect AGP cards to be fully
>addresseable via
>the I/O space assigned in the PCI IO resource base ?

But even that doesn't work. If it's a kernel driver, then we can fixup
the io resources passed by the new kernel resources mecanism to handle
the IO base of this specific card. But this won't for userland.

I mean, if you read the PCI IO resource base from the card's config
space, then you have an IO address on which you need to add an iobase
(the base at which the IO bus is mapped). The problem is how to figure
out this IO base, especially since the machine has several IO busses at
different addresses, but all of them on the same PCI bus number (it's
actually 3 separate busses with the same bus number).

The kernel can figure this out from the dev_fn since there's fortunately
no overlap of dev_fn's between those busses. But how to translate this to
userland ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
