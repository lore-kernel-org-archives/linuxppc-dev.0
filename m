Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33D64DDF25
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 11:47:05 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Building ppc/powerpc kernel to run under QEMU.
Date: Fri, 11 May 2007 21:46:35 -0400
References: <200705092203.26042.rob@landley.net>
	<20070510172806.GE4452@austin.ibm.com>
	<464397B8.408@genesi-usa.com>
In-Reply-To: <464397B8.408@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200705112146.35495.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 May 2007 6:07 pm, Matt Sealey wrote:
> QEMU really really wants a PREP kernel, and that stuff's just not in the new
> arch/powerpc tree anymore is it?

In theory I could feed it a power mac kernel, but I'd have to create a 
partitioned hard drive image to satisfy open hackware.  A prep kernel fakes 
being a partitioned image sufficiently that I can use -kernel to boot.

> I'd love to see the device tree once QEMU's kernel has booted :D

So would I. :)

I'm told they've got that part working.  I once managed to get a powerpc 
Ubuntu ISO image to boot under qemu, I just can't _build_ a kernel that does.  
(I have no idea how to create the specially partitioned hard drive image it 
wants, and since I got 5 other architectures working without needing to do 
that, I'm looking for a way to make a prep kernel work so I won't have to.)

> I wonder.. would it be useful to have a qemu platform in arch/powerpc and
> for someone to start hacking in devices from a non-emulated point of view?
> It seems a bit of a waste in my mind to emulate a network card, serial port
> IDE interface, ADB (yick!) and a VESA graphics adapter in such 'detail' when
> it can be passed back to the emulation somehow through some kind of clever
> call interface (maybe just have the zero page of the emulation contain a
> bunch of 'ports' which are really function calls pointers..?)

Yeah, but qemu already _has_ an IDE interface, graphics card (an old western 
digital something or other), and network card working.  Once they got 'em 
working on one platform, they can plug them into a virtual PCI bus for other 
platforms.

What I wind up fighting with most when trying to get multiple platforms to 
work is firmware and bootloaders.  (All of which are insane, without 
exception so far.)  This is why I like the qemu -kernel thing, which lets me 
bypass the whole issue...

Usually.

Rob
