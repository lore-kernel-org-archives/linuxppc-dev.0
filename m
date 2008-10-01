Return-Path: <benh@kernel.crashing.org>
Subject: Re: USB support on mpc5200 broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48E243C5.7000100@genesi-usa.com>
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop> <48E02FD0.8000809@genesi-usa.com>
	<20080929034329.GB8694@yookeroo.seuss>
	<9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
	<48E243C5.7000100@genesi-usa.com>
Content-Type: text/plain
Date: Wed, 01 Oct 2008 13:31:41 +1000
Message-Id: <1222831901.12264.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This is what we were recommended to use at the time. There is a patch
> on www.powerdeveloper.org which tweaks the tree to make it ultra-compliant
> with the Linux version of things, which implements every variation. It
> also implements a suggested patch which added a "big-endian" property
> (not built in to the compatible property, but another property).
> 
> I don't see why THAT patch got reverted as it was a great idea that we
> all agreed was a great idea.

I agree. Something needs to be fixed on the OHCI OF stuff, it should
definitely cope with the "big-endian" property (which is a practice
borrowed from Apple that I recommended I think back then) and I don't
see any problem with having ohci-be in the "compatible" property, its
trivial enough to cope in the driver and being anal about it on the
kernel side doesn't really bring any benefit.

Care to send a patch ?

> Linux development around here is getting really schizophrenic. Nobody
> is writing these decisions down even as comments in the source code..

That isn't entirely true. There's the ePAPR effort on power.org that is
codifying a lot of that, and there are binding documents dropped in
Documentation/powerpc.

> No; you can have little endian OHCI controllers on big endian machines.
> It's a property of the host controller, not the system architecture, just
> like PCI is always little endian (except when you have magic in hardware
> like Amiga PowerUP cards which endianswap for you :)

In fact, you can have both kinds on the same machine.

Note about the Amiga stuff: it's a bad idea :-) Every attempt at
"magically" fixing endian in HW is a recipe for tears and disasters.
Approximately ... always. The only cases that I know that have a remote
chance of being useful are specifically programmable swappers on a given
device or per-page endian configuration in the processor (like BooKE).

Cheers,
Ben.
