Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 9E453DDF27
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 00:46:44 +1100 (EST)
Date: 1 Nov 2007 06:46:42 -0700
Message-ID: <20071101134642.6257.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: tnt@blacksnow.net
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
In-Reply-To: <52304.213.186.37.16.1193915988.squirrel@www.opensources.be>
References: <20071024163412.GA17785@ru.mvista.com>
	<471FC191.6020704@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:
> > Valentine Barshak wrote:
> >> Rework ohci-ppc-of driver to use big-endian property instead of
> >> ohci-be/ohci-le compatible strings. Also remove unnecessary
> >> user-selectable USB_OHCI_HCD_PPC_OF_LE/BE stuff, because
> >> USB_OHCI_BIG_ENDIAN_DESC/MMIO should always be enabled for ppc
> >> and USB_OHCI_LITTLE_ENDIAN is selected for USB_OHCI_HCD_PCI by default.
> 
> I don't find those options useless. If you think the defauts are not the
> best change them but I find these options relevant. You don't always want
> the support for BE on PPC ... if the only controller you have is pci ...
> or if you're on a soc that use little endian ...

USB_OHCI_LITTLE_ENDIAN and USB_OHCI_BIG_ENDIAN are useful and I
don't see anyone wanting to remove them.  However, if all of the
chips supported by the ohci-ppc-of driver are big-endian, then
USB_OHCI_HCD_PPC_OF_LE and USB_OHCI_HCD_PPC_OF_BE are not needed.
Just select USB_OHCI_BIG_ENDIAN when the ohci-ppc-of driver is
selected, in the same way that we always select USB_OHCI_LITTLE_ENDIAN
when the ohci-pci driver is selected.

-Dale
