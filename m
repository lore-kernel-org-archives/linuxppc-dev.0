Subject: Re: Pegasos 2 support patch ...
From: Adrian Cox <adrian@humboldt.co.uk>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040630162323.GA28483@pegasos>
References: <20040629165029.GA13468@pegasos>
	 <1088587090.28598.3.camel@localhost> <20040630155027.GA27912@pegasos>
	 <1088611966.28598.52.camel@localhost>  <20040630162323.GA28483@pegasos>
Content-Type: text/plain
Message-Id: <1088613575.28598.59.camel@localhost>
Mime-Version: 1.0
Date: Wed, 30 Jun 2004 17:39:35 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-06-30 at 17:23, Sven Luther wrote:
> I am not sure if it works for me, but in your case, would the right
> solution not be to have d->init_chipset return the irq ?

No, because d->init_chipset is only called once per pci device, and that
one pci device provides two channels with different irqs.

The problem is that the via686 ide is hardwired to irqs 14 and 15 of the
i8259 interrupt controller internally, but the kernel believes that only
IDE controllers at the legacy address can have separate irqs for each
channel.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
