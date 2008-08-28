Return-Path: <stern+48acf28e@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 32B73DE488
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 06:13:36 +1000 (EST)
Date: Thu, 28 Aug 2008 16:13:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
In-Reply-To: <20080828233227.0d28f58d@vitb-lp>
Message-ID: <Pine.LNX.4.44L0.0808281558320.3844-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefan Roese <sr@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-usb@vger.kernel.org, Mark Miesfeld <mmiesfeld@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Aug 2008, Vitaly Bordug wrote:

> > This doesn't explain why the fatal error occurs.
> > 
> On certain 44x set of SoCs, only one controller is able to function,
> e.g. technically they are mutually exclusive.
> 
> There used to be recommendation to use only hi-speed or full-speed
> devices with specific conditions, when respective module was unloaded.
> Later, it was observed that ohci suspend is enough to keep things
> going, and it was turned into workaround, as explained below.

Okay, good.  _This_ is what you should have put in the patch 
description, instead of all that other stuff.

> > I have some doubts about parts of this patch.
> What stands about noted gotchas, I agree and will fix them, thanks for
> looking through the patch. I agree this doesn't look pleasant, but
> unfortunately is the only way to say use USB keyboard, and hi-speed
> memory stick at the same time.

Your original post mentioned that the 440EPx has only one USB 2.0 host
port.  Then how can you use a keyboard and memory stick at the same
time?  You'd have to plug them into a hub -- in which case only one
controller would be needed, the one driving the hub.  The patch would 
be unnecessary.

> > I doubt this will interact properly with usbcore and the rest of
> > ohci-hcd.  They do not expect the root hub to be suspended unless they
> > know about it.
> 
> I need to reemphasize, that upper is not "normal", but unfortunately
> the only way to have both full and hi-speed usb live in peace with
> 44xEPX family. Quirks are not going to be executed on other chip
> anyway, and on chip in question, it was tested and works stable enough.
> 
> I can add an explicit warning, that workaround is being utilised, to
> make things clear if it will be considered appropriate.

Do these systems support CONFIG_PM?  If they do then your patch
shouldn't be needed, because then ohci-hcd will automatically suspend
the OHCI root hub 1 second after the last full/low-speed device is
unplugged.  You could reduce that 1 second value if you wanted to 
decrease the probability of conflicts.

Alan Stern
