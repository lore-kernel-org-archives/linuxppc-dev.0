Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A000DDFE2
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 10:31:14 +1000 (EST)
Date: Fri, 4 May 2007 04:30:56 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
Message-ID: <20070504043056.14ab94cf@localhost.localdomain>
In-Reply-To: <1178195353.6353.38.camel@localhost.localdomain>
References: <20070501051804.GB3881@localhost.localdomain>
	<20070503103534.63ff67b6@localhost.localdomain>
	<20070503070358.GA9430@localhost.localdomain>
	<4639CF44.6020608@ru.mvista.com>
	<1178195353.6353.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 03 May 2007 22:29:13 +1000
Benjamin Herrenschmidt wrote:

> 
> >     It doesn't seem a flexible enough approach. We could continue
> > using platform devices then.
> 
> The problem is trivial enough tho... who ends up creating an
> of_platform_device for that rom node ... to be picked up by the
> driver.
> 
> Creating of_platform devices is platform code responsibility... either
> by calling of_platform_bus_probe() (or whatever I called it ...) to
> generate them from known bus type or by creating them directly, that
> doesn't matter, that's still platform code business.
> 
Still, there is code duplication problem.

So, assuming we'd need 6 lines of code to do it properly in platform code,
we may face  tens of different targets that require exactly the same process to 
provide mtd of_devices stuff.

The hard part of it is apparently how the respective flash space should be remapped
(b/c it is depending on HW design), but since we really care only about things that may be
encoded into device tree, there is really an option to utilize devtree power and effectiveness,
I think.


-- 
Sincerely, Vitaly
