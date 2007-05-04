Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 May 2007 11:28:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
Message-ID: <20070504012835.GA1914@localhost.localdomain>
References: <20070501051804.GB3881@localhost.localdomain>
	<20070503103534.63ff67b6@localhost.localdomain>
	<20070503070358.GA9430@localhost.localdomain>
	<4639CF44.6020608@ru.mvista.com>
	<1178195353.6353.38.camel@localhost.localdomain>
	<20070504043056.14ab94cf@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070504043056.14ab94cf@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 04, 2007 at 04:30:56AM +0400, Vitaly Bordug wrote:
> On Thu, 03 May 2007 22:29:13 +1000
> Benjamin Herrenschmidt wrote:
> 
> > 
> > >     It doesn't seem a flexible enough approach. We could continue
> > > using platform devices then.
> > 
> > The problem is trivial enough tho... who ends up creating an
> > of_platform_device for that rom node ... to be picked up by the
> > driver.
> > 
> > Creating of_platform devices is platform code responsibility... either
> > by calling of_platform_bus_probe() (or whatever I called it ...) to
> > generate them from known bus type or by creating them directly, that
> > doesn't matter, that's still platform code business.
> > 
> Still, there is code duplication problem.
> 
> So, assuming we'd need 6 lines of code to do it properly in platform
> code, we may face tens of different targets that require exactly the
> same process to provide mtd of_devices stuff.

So make a helper function.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
