Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D98E2DDDE9
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 21:07:01 +1000 (EST)
Date: Sun, 15 Jul 2007 12:06:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Use resource_size_t for serial port IO addresses
Message-ID: <20070715110606.GA32577@flint.arm.linux.org.uk>
References: <1184335336.6456.17.camel@weaponx.rchland.ibm.com>
	<20070713120226.797117e2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070713120226.797117e2.akpm@linux-foundation.org>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2007 at 12:02:26PM -0700, Andrew Morton wrote:
> On Fri, 13 Jul 2007 09:02:16 -0500
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > This is a resend of a patch David sent out on May 7.  Without it, the
> > PowerPC 44x port in 2.6.22 and on is broken.  I've rebased it off of
> > Linus' current tree.  Please consider pushing this soon.
> > 
> > josh
> > 
> > 
> > At present, various parts of the serial code use unsigned long to
> > define resource addresses.  This is a problem, because some 32-bit
> > platforms have physical addresses larger than 32-bits, and have mmio
> > serial uarts located above the 4GB point.
> > 
> > This patch changes the type of mapbase in both struct uart_port and
> > struct plat_serial8250_port to resource_size_t, which can be
> > configured to be 64 bits on such platforms.  The mapbase in
> > serial_struct can't safely be changed, because that structure is user
> > visible.
> 
> This is something we should do, but I have recollections of Russell
> identifying problems with this patch, or at least an earlier version of it?

Basically, there's two patches.  This one (let's call this patch A)
and another to prevent users being surprised (let's call that patch B).

I didn't have any real objections to patch A, provided something like
patch B was merged.  I did have objections against patch B, and I was
intermittently working on a revised solution.

However, for whatever reason [*], during the last merge window patch B
got merged and patch A got dropped, and as a result I've now given up
with my revised solution, and TBH, I no longer care.


* - probably a result of the patches having been worked on several
months prior to the merge window, then me forgetting the discussions
that were had, and then objecting to the wrong patch with wrong
reasoning.  I really hate this "work on patches, wait months, forget
all about them, then try to work out what the hell happened" approach.
It causes mistakes like this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
