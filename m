Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Nov 2008 11:23:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: powerpc: udbg based backend for hvc_console
Message-ID: <20081121002314.GA13049@yookeroo.seuss>
References: <20081024035434.GF4267@yookeroo.seuss>
	<20081119004220.GE29577@yookeroo.seuss>
	<4569571e317d43f1b26b087fcdebcba3@bga.com>
	<4925B78B.2040709@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4925B78B.2040709@freescale.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2008 at 01:16:27PM -0600, Timur Tabi wrote:
> Milton Miller wrote:
> 
> > Stated differently, if your routine (1) fundamently works one character  
> > at a time and (2) is not interrupt driven, and (3) only supports one  
> > channel, what avantage is there to an explicit hvc driver?
> 
> I think it's because HVC has the ability to use HVC client drivers
> for console and TTY, but udbg does not.  So if you have a udbg-only
> driver, it will cease to function when the kernel switches to the
> normal console.
> 
> Perhaps it would make more sense to have the kernel continue to use udbg if
> there is no normal console driver, instead of relying on David's
> driver.

This doesn't work - the udbg console can't support a full tty driver
which is needed by userspace.  Originally, I was going to extend the
udbg console so that it supported a tty backended onto the udbg
methods.  Then I realised that the code I'd need to do this would be
essentially identical to hvconsole, so why duplicate it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
