Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 75CF7DDF73
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 03:11:52 +1100 (EST)
Date: Thu, 10 Jan 2008 10:21:20 -0600
From: Olof Johansson <olof@lixom.net>
To: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
Message-ID: <20080110162120.GA4831@lixom.net>
References: <4782B985.2090508@austin.ibm.com> <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
	<20080110031723.GA22168@lixom.net>
	<3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	Nathan Lynch <ntl@pobox.com>, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 10:12:13PM -0600, Linas Vepstas wrote:
> On 09/01/2008, Olof Johansson <olof@lixom.net> wrote:
> > On Wed, Jan 09, 2008 at 08:33:53PM -0600, Linas Vepstas wrote:
> >
> > > Heh. That's the elbow-grease of this thing.  The easy part is to get
> > > the core function working. The hard part is to test these various configs,
> > > and when they don't work, figure out what went wrong. That will take
> > > perseverence and brains.
> >
> > This just sounds like a whole lot of extra work to get a feature that
> > already exists.
> 
> Well, no. kexec is horribly ill-behaved with respect to PCI. The
> kexec kernel starts running with PCI devices in some random
> state; maybe they're DMA'ing or who knows what. kexec tries
> real hard to whack a few needed pci devices into submission
> but it has been hit-n-miss, and the source of 90% of the kexec
> headaches and debugging effort. Its not pretty.

It surprises me that this hasn't been possible to resolve with less than
architecting a completely new interface, given that the platform has
all this fancy support for isolating and resetting adapters. After all,
the exact same thing has to be done by the hypervisor before rebooting
the partition.

> If all pci-host bridges could shut-down or settle the bus, and
> raise the #RST line high, and then if all BIOS'es supported
> this, you'd be right. But they can't ....

This argument doesn't hold. We're not talking about some generic PC with
a crappy BIOS here, we're specifically talking about POWER6 PHYP. It
certainly already has ways to reset adapters in it, or EEH wouldn't
work. Actually, the whole phyp dump feature wouldn't work either, since
it's exactly what the firmware has to do under the covers as well.


-Olof
