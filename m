Subject: Re: [linux-usb-devel] Re: RE : MPC5200Lite PCI & IRQ
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Brownell <david-b@pacbell.net>,
	Bertrand Baudet <bbaudet@lacie.com>, Greg KH <greg@kroah.com>,
	linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1088258564.3007.8.camel@localhost.localdomain>
References: <5A96167EBCEA8440A48790B5419953AE13C46A@gr-lafayette.lacie.com>
	 <1087554029.19489.3149.camel@hades.cambridge.redhat.com>
	 <20040619000118.GB24902@kroah.com>  <40DD8710.8030100@pacbell.net>
	 <1088258564.3007.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 27 Jun 2004 11:09:07 +0100
Message-Id: <1088330947.4268.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-06-26 at 15:02 +0100, Alan Cox wrote:
> There are a lot of drivers that assume 0 means no IRQ, including some
> big x86 non-PC systems. Remember however that dev->irq is an OS private
> cookie. In the x86 case for example we add 16 to APIC directed
> interrupts both to split IRQs out and to avoid this problem.

There aren't _that_ many drivers which have this bug; certainly not
non-ISA drivers. Even when you consider irq_t to be an OS-private
cookie, that doesn't excuse this brokenness on the part of drivers --
they need fixing.

> So if your board has an IRQ 0 and it is a problem - just change your
> numbering scheme.

That's a workaround, not a fix. Not really Linux style.

Personally, I think we want to stop even thinking of it as a numbering
scheme. IRQs are a tree, not a flat array.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
