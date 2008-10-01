Return-Path: <c.schlote@konzeptpark.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: USB support on mpc5200 broken
Date: Wed, 1 Oct 2008 11:46:29 +0200
Message-ID: <46597312D56D2A47A3A6E9C1D0D9B7AE012A7431@kpladc0001.konzeptpark.intra>
In-Reply-To: <1222831901.12264.8.camel@pasglop>
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com><9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com><1222307447.8277.147.camel@pasglop>
	<48E02FD0.8000809@genesi-usa.com><20080929034329.GB8694@yookeroo.seuss><9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com><48E243C5.7000100@genesi-usa.com>
	<1222831901.12264.8.camel@pasglop>
From: "Carsten Schlote" <c.schlote@konzeptpark.de>
To: <benh@kernel.crashing.org>, "Matt Sealey" <matt@genesi-usa.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

> Note about the Amiga stuff: it's a bad idea :-) Every attempt=20
> at "magically" fixing endian in HW is a recipe for tears and=20
> disasters.

I fully agree. It's one of the problem I encountered with some similiar
approach on some other big-endian Freescale CPU. It is implemented as a
hard-wired 'endian-swap feature' and it simply makes everything much
more complicated for code intended to run on LE and BE CPU by virtually
adding some additional special case.=20

> Approximately ... always. The only cases that I know that=20
> have a remote chance of being useful are specifically=20
> programmable swappers on a given device or per-page endian=20
> configuration in the processor (like BooKE).

Also agree. There might be use-cases, where hardware-supported
endian-swapping might be useful. But it must be an optional feature.=20

It's already some PITA to develope and maintain drivers running on LE/BE
CPUs and to properly access word and longword PCI registers
endian-transparent. Byte streams should never be affected by endianess
anyway.=20

Automatic endian-swapping might speed up some register accesses or e.g.
framebuffer accesses (reverse pixel endianess), but in general it adds
more problems than it's worth.=20

The framebuffer use-case is currently the only one, where such a
hardware-swapper could be really useful. But still the drivers would
have to know about this feature, it would require query/set macros/fcts
for endian translation modes in the kernel, ... - in short it causes
lots of extra overhead. And for framebuffers the need for such hard-ware
swappers can be eleminated by using the right framebuffer mode.

I fear, that such hard-wired 'magic' swapping is the source and reason
for some of my current problems.

Carsten
