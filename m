Subject: Re: Pegasos 2 support patch ...
From: Adrian Cox <adrian@humboldt.co.uk>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040630185231.GA29878@pegasos>
References: <20040629165029.GA13468@pegasos>
	 <1088587090.28598.3.camel@localhost> <20040630155027.GA27912@pegasos>
	 <1088611966.28598.52.camel@localhost> <20040630162323.GA28483@pegasos>
	 <1088613575.28598.59.camel@localhost>  <20040630185231.GA29878@pegasos>
Content-Type: text/plain
Message-Id: <1088622301.28598.68.camel@localhost>
Mime-Version: 1.0
Date: Wed, 30 Jun 2004 20:05:01 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-06-30 at 19:52, Sven Luther wrote:
> On Wed, Jun 30, 2004 at 05:39:35PM +0100, Adrian Cox wrote:
> > The problem is that the via686 ide is hardwired to irqs 14 and 15 of the
> > i8259 interrupt controller internally, but the kernel believes that only
> > IDE controllers at the legacy address can have separate irqs for each
> > channel.
>
> Is this the case for each via ide controller ? If so why does it work on
> x86 ?

Because on x86 the BIOS places the IDE controller at the legacy
addresses (0x1f0, 0x170), and then setup-pci.c spots that the via ide
controller is also the legacy IDE controller, and thus uses the legacy
irq numbers 14 and 15.

What I'm looking for is a tidy way of achieving the same result on a
platform where the boot firmware did not put the via ide controller at
the legacy addresses.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
