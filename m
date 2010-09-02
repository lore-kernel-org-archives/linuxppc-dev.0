Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 016F9B7199
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 07:16:14 +1000 (EST)
Date: Thu, 2 Sep 2010 17:16:11 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: Where to put board-specific drivers
Message-ID: <20100902171611.14fced27@lappy.seanm.ca>
In-Reply-To: <20100902200434.GC24861@ovro.caltech.edu>
References: <20100902200434.GC24861@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Sep 2010 13:04:34 -0700
"Ira W. Snyder" <iws@ovro.caltech.edu> wrote:

> Hello all,
> 
> I've written several drivers for a custom board. The board is
> basically an mpc8349_mds board with some extra FPGAs for data
> processing.
> 
> All of the drivers were written to interface with a custom system
> controller FPGA, which handles things like LED control, FPGA
> programming, and fast data dumping from the data processing FPGAs.
> 
> I'd like to start pushing some of these drivers into mainline, but I
> don't know where to put them. I don't think drivers/ is appropriate:
> these are highly board specific. Does arch/powerpc/ have a recommended
> place for board-specific drivers? I was thinking about
> arch/powerpc/drivers/, however that doesn't exist.

Drivers should go in the proper place if it all possible. For example,
for Pika's warp, the watchdog driver is in the watchdog directory
(drivers/watchdog/pika_wdt.c) even though it is FPGA based and very
specific to the warp.

However, the LEDS where put in arch/powerpc/platforms/44x/warp.c. So it
is in the platform code. I also put our FPGA based DTM (Dynamic Thermal
Management) in the warp.c file.

If you submit the code... the reviewers will make recommendations on
where it should go.

Cheers,
   Sean

Cheers,
   Sean
