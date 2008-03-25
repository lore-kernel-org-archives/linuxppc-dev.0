Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA855DDF9D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:03:58 +1100 (EST)
Date: Tue, 25 Mar 2008 11:03:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] cpm_uart: Allocate DPRAM memory for SMC ports on
	CPM2-based platforms.
Message-ID: <20080325160331.GB15093@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803251634.50253.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2008 at 04:34:46PM +0100, Laurent Pinchart wrote:
> On Tuesday 25 March 2008 15:58, Scott Wood wrote:
> > Please maintain backward compatibility with older device trees (by
> > checking the length of the second reg resource).  At the very least,
> > update the device trees that are affected.
> 
> I haven't seen any CPM2-based board using SMC ports in the device trees 
> available in arch/powerpc/boot/dts.

ep8248e

> Should I still maintain compatibility with older device trees ? Is there any 
> out-of-tree PQ2 boards using udbg and SMC ?

Yes, I've answered questions on the lists from at least one person using
a custom board with cpm2 smc.

> What about printing a warning if the second reg resource has the wrong
> size ?

The only way you'll see the warning is if udbg is enabled. :-P

Will a CPM reset blow away the portion of muram that holds the SMC pram
pointer?  If not (and I don't think it will), just return the device tree
reg resource as is currently done if the resource is the wrong size.

> > After this point, even if you don't reset the CPM, udbg printk is broken
> > because you moved pram.  The udbg disabling will have to be moved before
> > this.
> 
> Moving the SMC pram doesn't break udbg printk in itself. What will break it is 
> moving the TX BDs, but the end result is the same, moving pram will result in 
> udbg being broken.
> 
> The cpm_uart driver disable udbg before allocating the new BDs. What about 
> moving that right before moving the parameter RAM ? cpm_uart_request_port(), 
> which is called in between, already disables RX and TX on the port, so we 
> won't loose any debug message.

cpm_uart_request_port() returns without doing that if it's a console
port.  I think the current placement of the udbg disable will be fine.

-Scott
