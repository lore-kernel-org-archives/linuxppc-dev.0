Subject: Re: RE : MPC5200Lite PCI & IRQ
From: David Woodhouse <dwmw2@infradead.org>
To: Bertrand Baudet <bbaudet@lacie.com>
Cc: linuxppc-embedded@lists.linuxppc.org, greg@kroah.com
In-Reply-To: <5A96167EBCEA8440A48790B5419953AE13C46A@gr-lafayette.lacie.com>
References: <5A96167EBCEA8440A48790B5419953AE13C46A@gr-lafayette.lacie.com>
Content-Type: text/plain
Message-Id: <1087554029.19489.3149.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 11:20:30 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-06-18 at 12:06 +0200, Bertrand Baudet wrote:
> Well, there is not only the IDE driver; the USB driver does it as well:
>
> In the 2.4.25, from the "drivers/usb/host/usb-ohci.c", in the 'ohci_pci_probe' function:
>
> And in the 2.6.7, from "drivers/usb/core/hcd-pci.c", in the 'usb_hcd_pci_probe' function:
>
> if (!dev->irq) {
> 	err("found OHCI device with no IRQ assigned. check BIOS settings!");
> 	pci_disable_device (dev);
> 	return -ENODEV;
> }
>
> There are probably other drivers that have the wrong assumption that IRQ 0
> is an unassigned IRQ.

They are broken. They need fixing. Please don't just work around their
brokenness -- send patches to the driver maintainer.


--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
