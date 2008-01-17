Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id 9568ADDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 12:34:26 +1100 (EST)
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20080116091607.6aa76d11@kernel.crashing.org>
References: <20080111200705.GA696@loki.buserror.net>
	<1200234372.3990.24.camel@neuromancer.mindspace>
	<20080114152859.GA26907@ld0162-tx32.am.freescale.net>
	<1200350407.4061.19.camel@neuromancer.mindspace>
	<478BE6F2.4020207@freescale.com>
	<1200439502.3618.26.camel@neuromancer.mindspace>
	<20080116091607.6aa76d11@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 17 Jan 2008 01:34:22 +0000
Message-Id: <1200533662.3440.27.camel@neuromancer.mindspace>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-01-16 at 09:16 +0300, Vitaly Bordug wrote:

Greetings Vitaly !

> On Tue, 15 Jan 2008 23:25:02 +0000
> Bryan O'Donoghue wrote:
> 
> > Greetings Scott.
> > 
> > I've tried both of the procedures you've outlined on the Adder875 with
> > the patches supplied against the paulus git tree to no avail.
> > 
> > Pass #1 :
> > 
> > Doing it safe with cuImage.8xx
> > 
> 
> [...]
> > => bootm 0x400000
> > ## Booting image at 00400000 ...
> >    Image Name:   Linux-2.6.24-rc6-g4f43143f-dirty
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    1032266 Bytes = 1008.1 kB
> >    Load Address: 00400000
> >    Entry Point:  00400554
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK
> > 
> > I haven't as yet tried to single step through the bootup process -
> > but, just to say that assuming the above procedure isn't _too_ far
> > wrong - the stuff posted to the list agains the tree you've
> > recommended doesn't seem to work..
> > 
> yes the sequence seems correct, so I'd check cmdline params, contents of chosen node in dts, etc to make sure stuff is being written to the proper UART with proper settings.

Indeed - thing is for the cuImage.8xx it's definitely _not_ something
simple like a UART not set at the expected baud rate.

Using an Adder875 booted from U-Boot and cuImage.8xx with a  a bdi2000
as a debugger - after the jump to kernel startup we don't even hit
start_kernel ! There's no question about it - for whatever reason the
cuImage.8xx for this board is definitely broken.

I've been doing some experiments in the last hour or so mapping vmlinux
to 0x400554 in gdb - since that's the entry point above - and setting an
instruction breakpoint to do some instruction stepping.

When I do that with cuImage.8xx I find that in kernel/head_8xx.S the
code dies before going into virtual memory mode - haven't nailed down
exactly where yet.

Point being if I boot a uImage + dtb

bootm 0x400000 - 0x500000 with a breakpoint set at start_kernel - then
the uImage + dtb version _will_ hit start_kernel - where we are in
virtual mode...

_something_ wierd is for sure wrong with the cuImage.8xx and
unfortunately it's not a simple as a silly baud rate.

> > 
> following the u-boot way (which is more correct imo) you'll need to add some code that fixes up frequencies and stuff inside dtb, or you may try to hardcode those values inside dts(if you know exactly what should be  there). Just adding CONFIG_*LIBFDT is not going to work.

I agree, makes sense to go with the flow of things tbh.

It still leaves as unanswered why exactly the ucImage.8xx kernel dies
suddenly before hitting start_kernel - whereas the uImage + dtb boy is
getting much further along in the boot.

I suppose I'll do some debug with the uImage - and try to see what else
it wants to complete the boot though, it'd be nice if the cuImage worked
so there'd be a safety net to use as a comparison to get the uImage +
dtb running properly.
