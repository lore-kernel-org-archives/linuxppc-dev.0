Return-Path: <flar@cynthia.pants.nu>
Date: Thu, 23 Aug 2007 11:56:32 -0700
From: Brad Boyer <flar@allandria.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Message-ID: <20070823185632.GA3571@cynthia.pants.nu>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<2F7E4C06-9AC3-458A-B1E3-CA6E0BDD189A@kernel.crashing.org>
	<20070823033318.GJ7042@localhost.localdomain>
	<F19C9986-9E53-47F3-835D-C93DA9C3ADED@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F19C9986-9E53-47F3-835D-C93DA9C3ADED@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 11:16:03PM -0500, Kumar Gala wrote:
> On Aug 22, 2007, at 10:33 PM, David Gibson wrote:
> >> My analysis of <asm/bootinfo.h> usage:
> >>
> >> ./drivers/macintosh/adb-iop.c:#include <asm/bootinfo.h>	 remove
> >> ./drivers/char/vme_scc.c:#include <asm/bootinfo.h>		68k only
> >> ./drivers/char/serial167.c:#include <asm/bootinfo.h>		68k only
> >> ./drivers/serial/dz.c:#include <asm/bootinfo.h>		 decstation
> >> ./drivers/mtd/devices/ms02-nv.c:#include <asm/bootinfo.h>	decstation
> >> ./drivers/net/macsonic.c:#include <asm/bootinfo.h>		68k
> >> ./drivers/net/jazzsonic.c:#include <asm/bootinfo.h>		mips
> >> ./drivers/video/pmag-aa-fb.c:#include <asm/bootinfo.h>		mips
> >> ./drivers/video/maxinefb.c:#include <asm/bootinfo.h>		mips
> >> ./drivers/video/logo/logo.c:#include <asm/bootinfo.h>		mips
> >> ./drivers/video/macfb.c:#include <asm/bootinfo.h>		68k
> >> ./drivers/video/valkyriefb.c:#include <asm/bootinfo.h>		68k
> >
> > Uh.. I'm pretty sure valkyriefb.c is for (old) PowerMacs, not 68k.
> 
> It appears to be both.  If you look at the include its protected by a  
> #ifdef CONFIG_MAC which we is only defined on m68k.

According to drivers/video/macfb.c, both the Quadra 630 and Performa 588
have the Valkyrie chip for their video. I don't remember which ppc based
models have it, but it's definitely on both architectures.

Just as an extra note, the file drivers/macintosh/adb-iop.c is m68k only,
so you should probably leave that alone as well. It probably doesn't need
that header, but the change should really come from the 68k side of things.

	Brad Boyer
	flar@allandria.com
