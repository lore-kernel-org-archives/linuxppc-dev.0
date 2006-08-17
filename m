Return-Path: <g.liakhovetski@gmx.de>
Date: Fri, 18 Aug 2006 01:19:22 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 6/6] bootwrapper: Add support for the sandpoint platform
In-Reply-To: <Pine.LNX.4.60.0608172352220.8228@poirot.grange>
Message-ID: <Pine.LNX.4.60.0608180109060.8228@poirot.grange>
References: <20060719231725.GG3887@mag.az.mvista.com>
	<Pine.LNX.4.60.0608172200080.8228@poirot.grange>
	<20060817211353.GA1402@mag.az.mvista.com>
	<Pine.LNX.4.60.0608172352220.8228@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Aug 2006, Guennadi Liakhovetski wrote:

> On Thu, 17 Aug 2006, Mark A. Greer wrote:
> 
> > Depends on what you mean by "__boot__".  This is the code needed to
> > prepare things--the flat dev tree in this case--so that the kernel
> > can boot when running the DINK firmware on a sandpoint.
> 
> ...after getting some vitamins on irc and re-reading some emails, I 
> finally realised what the stuff under boot is for. Expect more confusion 
> from me:-)

Ok, I think, now I have an idea what all these wrappers are about:

we want to be able to boot linux from a number of different environments:

OF

various firmwares / boot ROMs / bootloaders with very different 
capabilities of running foreign code and different calling conventions

"native" Linux bootloaders like u-Boot, etc.

kexec

...

and the chosen approach is to have a kernel proper common to all these 
possibilities, and "wrappers". These wrappers are boot-method and board 
specific, are distributed with the kernel, located under 
arch/powerpc/boot, get linked with the kernel proper, fdt, with various 
compression possibilities...

Have I got it right now? One of the reasons of me having problems to 
understand this is that on ARM we just say "to boot kernel you have to 
have MMU switched off, registers must contain this and that, you have to 
prepare a list of ATAGs, copy the kernel to a certain address, and jump to 
it. If you don't do that you cannot run Linux on your system":-)

Thanks
Guennadi
---
Guennadi Liakhovetski
