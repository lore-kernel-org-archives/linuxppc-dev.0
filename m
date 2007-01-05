Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 367DDDDDF9
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jan 2007 08:25:06 +1100 (EST)
Subject: Re: 2.6.20-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20070105131516.bd9d8f45.akpm@osdl.org>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	<200701051723.08112.m.kozlowski@tuxland.pl>
	<1168030536.22458.28.camel@localhost.localdomain>
	<20070105131516.bd9d8f45.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 08:24:44 +1100
Message-Id: <1168032284.22458.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-05 at 13:15 -0800, Andrew Morton wrote:
> On Sat, 06 Jan 2007 07:55:36 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Fri, 2007-01-05 at 17:23 +0100, Mariusz Kozlowski wrote:
> > > Hello, 
> > > 
> > > 	Doesn't build on my iMac G3 based garage jukebox ;-)
> > > 
> > > arch/powerpc/kernel/of_platform.c:479: error: unknown field 'multithread_probe' specified in initializer
> > > arch/powerpc/kernel/of_platform.c:479: warning: initialization makes pointer from integer without a cast
> > > make[1]: *** [arch/powerpc/kernel/of_platform.o] Blad 1
> > > make: *** [arch/powerpc/kernel] Blad 2
> > > 
> > > I guess someone who knows multithread code should take a look at it.
> > 
> > Hrm. struct driver -> multithread_probe is gone in -mm ?
> > 
> 
> yeah, it moved into struct bus_type.
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/broken-out/driver-core-per-subsystem-multithreaded-probing.patch

Hrm. I disagree with this change. I have a few cases where drivers
actually want to explicitely do that. I suppose they can always fire off
a thread themselves from probe() but I don't see the reason to move it
to the bus type...

Easy enough for the bus type to force it if it wants.
 
Ben.
