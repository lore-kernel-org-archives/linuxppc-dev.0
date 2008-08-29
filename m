Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net
	[151.189.21.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0641EDDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 03:56:11 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
Date: Fri, 29 Aug 2008 19:56:02 +0200
References: <Pine.LNX.4.44L0.0808281558320.3844-100000@iolanthe.rowland.org>
	<48B71497.30500@harris.com>
In-Reply-To: <48B71497.30500@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808291956.03269.matthias.fuchs@esd-electronics.com>
Cc: Stefan Roese <sr@denx.de>, Mark Miesfeld <mmiesfeld@amcc.com>,
	Alan Stern <stern@rowland.harvard.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

please see my comment below. It might be helpful for some of you.

On Thursday 28 August 2008 23:11:51 Steven A. Falco wrote:
> Alan Stern wrote:
> > Your original post mentioned that the 440EPx has only one USB 2.0 host
> > port.  Then how can you use a keyboard and memory stick at the same
> > time?  You'd have to plug them into a hub -- in which case only one
> > controller would be needed, the one driving the hub.  The patch would
> > be unnecessary.
>
> I have one of these processors on a Sequoia board.  What happens is that
> if you build the kernel with both EHCI and OHCI support, then plug in
> a modern USB memory stick, it initially tries EHCI, the driver fails, and
> the whole thing falls back to OHCI.  So you wind up running at 12 Mbps.
> The only way to make high speed work is to turn off the OHCI driver, and
> then you cannot support slow devices with that kernel.
There is a simple trick to get all types (full, low ang high speed) of  
devices work: use a USB hub with transaction translators. We are doing so on 
a custom design based on the 440EPx. So we only build the kernel with EHCI 
support and there was no need for this ugly hack.
>
> So, hile you cannot plug two devices in at one time, you can plug in
> different speed devices at different times, and my understanding is that
> this patch will let that work seamlessly.
That's true.

Matthias
