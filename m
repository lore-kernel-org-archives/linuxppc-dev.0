Subject: Re: [linux-usb-devel] Re: RE : MPC5200Lite PCI & IRQ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Bertrand Baudet <bbaudet@lacie.com>, Greg KH <greg@kroah.com>,
	linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40DD8710.8030100@pacbell.net>
References: <5A96167EBCEA8440A48790B5419953AE13C46A@gr-lafayette.lacie.com>
	 <1087554029.19489.3149.camel@hades.cambridge.redhat.com>
	 <20040619000118.GB24902@kroah.com>  <40DD8710.8030100@pacbell.net>
Content-Type: text/plain
Message-Id: <1088258564.3007.8.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Sat, 26 Jun 2004 15:02:47 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sad, 2004-06-26 at 15:24, David Brownell wrote:
> Is there a designated "no IRQ assigned" code?  There should be one ...
> that's why such code gets cut/pasted.  Unless pci_enable_device() is
> (now) guaranteed to fail if the device has no IRQ assignment?

There are a lot of drivers that assume 0 means no IRQ, including some
big x86 non-PC systems. Remember however that dev->irq is an OS private
cookie. In the x86 case for example we add 16 to APIC directed
interrupts both to split IRQs out and to avoid this problem.

So if your board has an IRQ 0 and it is a problem - just change your
numbering scheme.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
