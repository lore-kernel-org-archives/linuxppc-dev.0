Return-Path: <stern+48acf28e@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 13A97DDEFC
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 07:30:58 +1000 (EST)
Date: Fri, 29 Aug 2008 17:30:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
In-Reply-To: <20080829222044.53c56bca@vitb-lp>
Message-ID: <Pine.LNX.4.44L0.0808291722590.13185-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: USB list <linux-usb@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Mark Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Aug 2008, Vitaly Bordug wrote:

> But even assuming PM set, common use-case of
> embedded systems to have stuff on USB bus that is never plugged off;
> and in case of compiled-in ehci and ohci there is just 
> 
> Initializing USB Mass Storage driver...
> usb 1-1: new high speed USB device using ppc-of-ehci and address 2
> usb 1-1: device descriptor read/all, error -110
> hub 1-0:1.0: unable to enumerate USB device on port 1
> 
> (not touching PM here to be clear)
> 
> even 1-second delay would be enough for root hub to be hosed... So, is
> the patch (with all the issues addressed) acceptable for mainline?

Try doing this instead.  First, make sure CONFIG_PM is set!  :-)
Then replace your patch with something that adds a 2-second delay to 
the end of ehci_start() when running on a 440EPx system.  That should 
give the OHCI controller time to suspend before the EHCI root hub is 
registered.

A little more tweaking will be needed to handle system sleeps.  But 
this should be a good start.

What to do when CONFIG_PM is off is a separate matter.  Let's not worry 
about it for now -- especially since, as Matthias suggested, you can 
use a USB 2.0 hub.

Alan Stern
