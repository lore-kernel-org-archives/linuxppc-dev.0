Return-Path: <benh@kernel.crashing.org>
Subject: RE: USB support on mpc5200 broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Carsten Schlote <c.schlote@konzeptpark.de>
In-Reply-To: <46597312D56D2A47A3A6E9C1D0D9B7AE012A7431@kpladc0001.konzeptpark.intra>
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop> <48E02FD0.8000809@genesi-usa.com>
	<20080929034329.GB8694@yookeroo.seuss>
	<9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
	<48E243C5.7000100@genesi-usa.com> <1222831901.12264.8.camel@pasglop>
	<46597312D56D2A47A3A6E9C1D0D9B7AE012A7431@kpladc0001.konzeptpark.intra>
Content-Type: text/plain
Date: Wed, 01 Oct 2008 20:36:36 +1000
Message-Id: <1222857396.12264.27.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-01 at 11:46 +0200, Carsten Schlote wrote:
> 
> 
> The framebuffer use-case is currently the only one, where such a
> hardware-swapper could be really useful. But still the drivers would
> have to know about this feature, it would require query/set macros/fcts
> for endian translation modes in the kernel, ... - in short it causes
> lots of extra overhead. And for framebuffers the need for such hard-ware
> swappers can be eleminated by using the right framebuffer mode.

Actually, fb's are -the- case where it's really necessary to have endian
swappers when they sit on PCI due to the way byte lanes are swapped on a
PCI host bridge on a BE platform, if you want to keep the same pixel
order as an x86 which is usually not only all that cards support, while
still having SW use native order which is usually all that the X server
supports :-)

> I fear, that such hard-wired 'magic' swapping is the source and reason
> for some of my current problems.

I wouldn't be surprised. The worst case I've seen is HW engineers trying
to be too smart for their own good and swapping the byte lanes of >8
bits data stream fifo's such as IDE (yeah, it makes the IDE ID block
more directly readable, at the expense of swapping all the data
effectively preventing the use of DMA unless you are fine with a custom
on-disk format incompatible with everything else).

Cheers,
Ben.
