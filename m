Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9FEFFDDE9D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 15:28:12 +1000 (EST)
Date: Thu, 23 Aug 2007 23:33:14 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Move serial_dev_init to device_initcall()
Message-ID: <20070824043314.GA10189@lixom.net>
References: <20070823002637.GA24332@lixom.net>
	<Pine.LNX.4.60.0708240117460.3246@poirot.grange>
	<20070823231510.GA5619@lixom.net>
	<1187931578.5972.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1187931578.5972.25.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 06:59:38AM +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2007-08-23 at 18:15 -0500, Olof Johansson wrote:
> > On Fri, Aug 24, 2007 at 01:21:57AM +0200, Guennadi Liakhovetski wrote:
> > > On Wed, 22 Aug 2007, Olof Johansson wrote:
> > > 
> > > > With the I/O space rewrite by BenH, the legacy_serial serial_dev_init()
> > > > initcall is now called before I/O space is setup, but it's dependent on
> > > > it being available.
> > > > 
> > > > Since there's no way to make dependencies between initcalls, we'll just
> > > > have to move it to device_initcall(). Yes, it's suboptimal but I'm not
> > > > aware of any better solution at this time.
> > > 
> > > Do I understand it right, that with this change all UARTs, controlled by 
> > > legacy_serial will be initialized later, and that for example console 
> > > output will be first possible later?
> > 
> > Yes, unfortunately. Unless they've got a udbg driver, since that
> > would give console output during early boot anyway (even without using
> > EARLY_DEBUG).
> 
> Legacy ports should get udbg first.
> 
> > > Maybe, if there is really no other 
> > > possibility for I/O space devices, we could have both calls
> > >
> > > arch_initcall(serial_mem_dev_init);
> > > device_initcall(serial_io_dev_init);
> > > 
> > > so, that at least MEMIO based UARTs could still initialize as before?
> > 
> > That's quite a hack, I hope we can avoid it. Maybe Ben has some suggestion
> > on how to get the IO setup earlier instead.
> 
> IO space allocation now relies on get_vm_area() which can't be done too
> early (not in setup_arch) which is why I allocate all PCI IO space at
> PHB scanning time, which is a subsys initcall.
> 
> An option would be to do it from some other init call, but that's a bit
> ugly. That means PCI would be split into setup_arch() setting up PHBs,
> that initcall allocating the IO spaces, and later, the actual scan.
> 
> It would be tricky though as my current interface relies on pci_bus
> structures. So you would also need to re-split that into a low-level
> that works on the PHB and a high level version that works on the bus.
> 
> Is this really necessary ?

No, that's what I'm hoping won't be, i.e. that it'll be fine to just
init serial ports slightly later. If people care about early output they
should use udbg anyway.

It'd be useful if people could at least test the patch on their systems.
I have only a few 32-bit ones with proper uarts, and none of them are
currently in a state where I can just throw a new kernel on them for
testing. :(


-Olof
