Date: Wed, 30 Jun 2004 20:52:31 +0200
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Pegasos 2 support patch ...
Message-ID: <20040630185231.GA29878@pegasos>
References: <20040629165029.GA13468@pegasos> <1088587090.28598.3.camel@localhost> <20040630155027.GA27912@pegasos> <1088611966.28598.52.camel@localhost> <20040630162323.GA28483@pegasos> <1088613575.28598.59.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1088613575.28598.59.camel@localhost>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 30, 2004 at 05:39:35PM +0100, Adrian Cox wrote:
> On Wed, 2004-06-30 at 17:23, Sven Luther wrote:
> > I am not sure if it works for me, but in your case, would the right
> > solution not be to have d->init_chipset return the irq ?
>
> No, because d->init_chipset is only called once per pci device, and that
> one pci device provides two channels with different irqs.

Ah, too bad. that said, this could be perhaps changed ? After all the
calling code in the idesetup stuff is per channel, so there is no reason
we could not call this one (or a similar function) for each channel.

> The problem is that the via686 ide is hardwired to irqs 14 and 15 of the
> i8259 interrupt controller internally, but the kernel believes that only
> IDE controllers at the legacy address can have separate irqs for each
> channel.

Is this the case for each via ide controller ? If so why does it work on
x86 ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
