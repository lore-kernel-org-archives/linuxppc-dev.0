Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 0D6996899C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 04:56:02 +1100 (EST)
Date: Tue, 20 Dec 2005 10:54:24 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Brian Waite <bwaite@irobot.com>
Message-ID: <20051220175424.GB5647@mag.az.mvista.com>
References: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
	<20051220010136.GA31165@mag.az.mvista.com>
	<200512200927.35976.bwaite@irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200512200927.35976.bwaite@irobot.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linux DMA capabilities in MV64460
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2005 at 09:27:35AM -0500, Brian Waite wrote:
> On Monday 19 December 2005 8:01 pm, Mark A. Greer wrote:
> > >
> > > up the mv64460.  One source told me:
> > >   > In order to do PCI bursts, you'll need to use a DMA engine.  The
> > >   > MV64460 does contain a DMA engine, but you'd need to write a driver
> > >   > to access it.
> >
> > That is not correct (assuming the quote is not out of context).
> > The bridge supports bursting on the PCI bus as long as the bridge is
> > configured correctly and the PCI device is making an appropriate request.
> > Note, however, that there are many errata for the Marvell parts including
> > some with cache coherency.
> There are many many errata regarding cache coherency. Also, the PCI bandwidth 
> the bridge is capable of with coherency enabled is very small. You will most 
> likely need to use sw coherency for any real speed.

I've managed to get reasonable speed with coherency on but you have to
jack the burst sizes to the max (see my comment below).  The speed was
hugely affected by the burst size; coherency enabled had only a minor impact.
The problem for me, however, was the board(s) I have do not have the
necessary hw coherency errata workarounds implemented so the bridge
eventually hangs with coherency enabled.

Unfortunately, I think I deleted the file with my performance
results in one of my cleanup binges.  IIRC, though, I got ~750 Mbps
with coherency off and ~725 Mbps with it on using an e1000 & a 750fx
or gx clocked around 800 MHz.

> > If your system is running with coherency on, 
> > you may have to limit your bursts to 32 bytes (i.e., the size of one
> > cache line).
> You will have to limit your self to 32 byte bursts with coherency. This is a 
> requirement not an errata. 

That is only true for the 64360.  The 64460 does not have that
restriction AFAICT.

<snip>

Mark
