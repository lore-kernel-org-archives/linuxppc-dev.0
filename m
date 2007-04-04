Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E602DDE29
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:10:51 +1000 (EST)
Date: Wed, 4 Apr 2007 17:10:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Theodore Tso <tytso@mit.edu>, David Miller <davem@davemloft.net>,
	dwmw2@infradead.org, paulus@samba.org, alan@lxorguk.ukuu.org.uk,
	flar@allandria.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404161029.GB18990@flint.arm.linux.org.uk>
References: <1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
	<20070404.011208.120446173.davem@davemloft.net>
	<20070404083803.GA13134@flint.arm.linux.org.uk>
	<20070404122154.GF31973@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070404122154.GF31973@thunk.org>
Sender: Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 08:21:54AM -0400, Theodore Tso wrote:
> So if we're going to do the "Worse is Better" thing, what I'd suggest
> doing is that someone simply submit a hack so that pmac_zilog can
> steal minor numbers and use /dev/ttyS0.  I accepted the patch way back
> when I was serial maintainer; Russell ripped it out when he became the
> serial maintainer; but now that he's no longer the serial maintainer,
> he doesn't get to complain about that any more :-)

The problem with that approach was that it was being extended to more
and more drivers in the ARM world, creating an #ifdef mess in the
serial driver.

Moreover, it provided *no* way to select an 8250-based serial port in
the presence of a "foreign" port claiming the ttyS console namespace.
Utterly unacceptable when you have a real environment of mixed serial
port types.

IOW, it was utterly broken.  It prevented me from doing the things I
wanted to do.

The only real answer is to fix the problem *properly*.  Hacks just end
up breaking peoples setups.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
