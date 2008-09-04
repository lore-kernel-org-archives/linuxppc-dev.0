Return-Path: <buytenh@wantstofly.org>
Received: from xi.wantstofly.org (xi.wantstofly.org [83.160.184.112])
	by ozlabs.org (Postfix) with ESMTP id 2956C47A27
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:20:36 +1000 (EST)
Date: Thu, 4 Sep 2008 17:20:33 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH,
	RFC] mv643xx_eth: move sram window setting code into the driver
Message-ID: <20080904152032.GB27272@xi.wantstofly.org>
References: <20080903140048.GC19602@xi.wantstofly.org>
	<48BFE63F.70700@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48BFE63F.70700@genesi-usa.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2008 at 08:44:31AM -0500, Matt Sealey wrote:

> I was thinking about this actually, similar to the Efika Device Tree 
> Supplement for MPC5200B board (which adds a lot of device tree nodes
> not present on the production model and fixes some things), we have
> a Pegasos one too which changes some very minor stuff.
> 
> This could be in the kernel (chrp fixups) or in a pre-boot Forth
> script, but in either case, wouldn't a real sram node in the device
> tree be the proper solution here? Hardcoding addresses for devices
> is rather arch/ppc behaviour and the driver is one of the few cases
> that never got reworked to fit.

Probably.

I guess you don't want to pass that info _directly_ to the mv643xx_eth
driver, though -- since the on-chip SRAM can be used for many things,
and you're not necessarily sure that the user wants to use it for
descriptors.  (Or how much of it they want to use for descriptors.)
(Or for the descriptors of which of the 8 possible transmit and receive
queues, considering the 2.6.27 driver supports multiple queues.)

Well, I'm not sure what the best solution is. :-)


> I don't have a Pegasos running right now to test but I will, as soon
> as possible, make sure this works first.

Cool, thanks.  It would be nice if you could give the driver in
2.6.27-rc5 a spin, it has seen a _lot_ of changes since 2.6.25 and
I'd really like to make sure it still works on Pegasos.
