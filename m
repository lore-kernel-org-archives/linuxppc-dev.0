Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A6E31DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 18:42:01 +1000 (EST)
Date: Wed, 04 Apr 2007 01:41:55 -0700 (PDT)
Message-Id: <20070404.014155.58456511.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070404075244.GB3440@flint.arm.linux.org.uk>
References: <1175663999.2932.8.camel@shinybook.infradead.org>
	<20070403.225006.119275067.davem@davemloft.net>
	<20070404075244.GB3440@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 4 Apr 2007 08:52:44 +0100

> On Tue, Apr 03, 2007 at 10:50:06PM -0700, David Miller wrote:
> > From: David Woodhouse <dwmw2@infradead.org>
> > Date: Wed, 04 Apr 2007 01:19:59 -0400
> > 
> > > I don't see why that 'should' be the case. Certainly it _isn't_ the case
> > > on most supported platforms -- we have separate device numbers, and
> > > names, for most types of ports. There's only one or two drivers which
> > > abuse ttySn for anything other than 8250 ports.
> > 
> > sunsu, sunzilog, pmac_zilog, sunsab, etc.
> > 
> > The list is longer than you think.  In fact the convention is
> > very well established.
> 
> ... and has never ever worked along side the existing 8250 (or serial)
> driver - therefore it can also be viewed as a long standing BUG.

I forked the 8250 driver for Sparc, that's what sunsu is, and it works
along side sunzilog and sunsab, which also use the ttyS0 major, just
fine.

They also setup the console correctly, and even make sure it matches
what the user selected in the firmware environment variables.

It can be made to work.
