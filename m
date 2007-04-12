Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0581FDDF54
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 16:36:38 +1000 (EST)
Subject: Re: [PATCH] Start split out of common open firmware code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070411.232545.45203999.davem@davemloft.net>
References: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<1176357020.8061.123.camel@localhost.localdomain>
	<20070411.232545.45203999.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 16:36:14 +1000
Message-Id: <1176359774.8061.129.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-11 at 23:25 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Thu, 12 Apr 2007 15:50:20 +1000
> 
> > On Thu, 2007-04-12 at 15:34 +1000, Stephen Rothwell wrote:
> > > This creates kernel/openfw.c (depending on CONFIG_OPENFW) and puts the
> > > first trivially common bits from the prom.c files into it.
> > 
> > Is this the right place ?
> > 
> > I want to split flat DT from live DT in separate files, then we have
> > of_device.c and of_platform.c that will need merging too, and possibly
> > the filesystem... that's a lot to put in kernel/
> 
> We could make drivers/openfw/{device,platform}.c, maybe that would
> work best?

Yeah, we could have something like:

 - base.c (the core stuff that stephen just merged)
 - parse.c (the parsers for irq tree, "reg"/"ranges", ...)
 - device.c
 - platform.c
(there is some work needed for the above to consolidate properly, I
suppose I'm the one who should do it since I'm to blame for most of that
code :-)
 - fs.c

In fact, we could even have trampoline.c for the powerpc prom_init
thingy though I'm not sure there is any interest in having that made
common with sparc, so it might as well stay where it is (in fact, we've
been considering moving it to the zImage wrapper and using the flattened
format to pass the DT along).

In addition, there are things that relate to the flat device-tree which
I don't know how much we want to make generic, both walking it, but also
things to generate one, mostly for use by iSeries and zImage wrappers...

Note that for the filesystem, we really want to stick to our binary
representation while you really want to stick to your text rep (we
decided to disagree iirc :-) I think we could keep a lot in common still
and just have a mount option to indicate how the file content is
exposed.

It's not really 2.6.22 material as far as I'm concerned as I'm pretty
busy with other things, unless of course Stephen feel like doing it
all :-) I'll see what I can do for the next cycle though.

Ben.
