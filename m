Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 May 2007 09:49:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
Message-ID: <20070503234919.GA28599@localhost.localdomain>
References: <20070501051804.GB3881@localhost.localdomain>
	<20070503103534.63ff67b6@localhost.localdomain>
	<20070503070358.GA9430@localhost.localdomain>
	<4639CF44.6020608@ru.mvista.com>
	<20070503122213.GD26659@localhost.localdomain>
	<4639E389.4040604@ru.mvista.com>
	<a8625bde363025ce23393d5b2bb6ec07@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a8625bde363025ce23393d5b2bb6ec07@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 06:21:35PM +0200, Segher Boessenkool wrote:
> >     BTW, is it legal/appropriate to specify device (not bus) types for
> > of_platform_bus_probe()?
> 
> In almost all cases you should probe on "name"/"compatible",
> and not use "device_type" at all.

I don't think that's what he's getting at.  "compatible" is what we
should use for the device <-> driver matching, but
of_platform_bus_probe() is earlier than that, creating the devices in
the first place.

And no, I don't think it is appropriate to specify device types rather
than bus types there.  Probing devices independent of the bus type
they sit on will always run the risk of conflicting with the bus
type's specific probe logic.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
