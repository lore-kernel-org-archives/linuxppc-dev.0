Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 076B068621
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 06:46:18 +1000 (EST)
Date: Fri, 28 Oct 2005 13:43:47 -0700
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20051028204347.GB18096@kroah.com>
References: <200510271439.48990.david.jander@protonic.nl>
	<20051028152109.GB18915@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051028152109.GB18915@logos.cnet>
Cc: David Jander <david.jander@protonic.nl>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8xx support in 2.6 and [PATCH] USB host controller
	selection...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 28, 2005 at 01:21:09PM -0200, Marcelo Tosatti wrote:
> Greg, please refer to the end of the message.
> > - USB Kconfig file for 2.6 kernel is broken. It is not correct to assume that 
> > you either have a PCI interface or a processor with internal HCI. Proof: We 
> > have a board based on MPC852T (no internal UHCI) which can plug into an 
> > (optional) daughter board with a ISP1160 on it. See attached patch.

Then please send the proper patch to the linux-usb-devel mailing list.

> Is it driven by the UHCI driver?

It shouldn't be :)

> >From http://www.semiconductors.philips.com/cgi-bin/pldb/pip/isp1160.html
> 
> The ISP1160 is an embedded Universal Serial Bus (USB) Host Controller
> (HC) that complies with Universal Serial Bus Specification Rev. 2.0,
> supporting data transfer at full-speed (12 Mbit/s) and low-speed (1.5
> Mbit/s).

We already have a driver for this device in the kernel tree, right?

> > Maybe the patch should be sent elsewere since it has not much to do with PPC, 
> > so can someone please tell me where?
> 
> I guess that you should have something like
> 
> config USB_ARCH_HAS_HCD
> 	default y if USB_ARCH_HAS_OHCI
> 	default y if USB_ARCH_HAS_UHCI
> 
> config USB_ARCH_UHCI
> 	default y if 8xx
> 
> Greg?

I don't understand what you are trying to fix up here.  What is wrong
with the current checks?  If your arch/board has support for the 1160
and we have the Kconfig set wrong for that, we can easily change it.

thanks,

greg k-h
