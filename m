Date: Fri, 18 Jun 2004 17:01:19 -0700
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>,
	linux-usb-devel@lists.sourceforge.net
Cc: Bertrand Baudet <bbaudet@lacie.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: RE : MPC5200Lite PCI & IRQ
Message-ID: <20040619000118.GB24902@kroah.com>
References: <5A96167EBCEA8440A48790B5419953AE13C46A@gr-lafayette.lacie.com> <1087554029.19489.3149.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087554029.19489.3149.camel@hades.cambridge.redhat.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 18, 2004 at 11:20:30AM +0100, David Woodhouse wrote:
> On Fri, 2004-06-18 at 12:06 +0200, Bertrand Baudet wrote:
> > Well, there is not only the IDE driver; the USB driver does it as well:
> >
> > In the 2.4.25, from the "drivers/usb/host/usb-ohci.c", in the 'ohci_pci_probe' function:
> >
> > And in the 2.6.7, from "drivers/usb/core/hcd-pci.c", in the 'usb_hcd_pci_probe' function:
> >
> > if (!dev->irq) {
> > 	err("found OHCI device with no IRQ assigned. check BIOS settings!");
> > 	pci_disable_device (dev);
> > 	return -ENODEV;
> > }
> >
> > There are probably other drivers that have the wrong assumption that IRQ 0
> > is an unassigned IRQ.
>
> They are broken. They need fixing. Please don't just work around their
> brokenness -- send patches to the driver maintainer.

Yes, please do :)

thanks,

greg k-h

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
