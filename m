Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id C383CDDEBE
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 19:16:09 +1100 (EST)
Date: Tue, 30 Jan 2007 09:16:03 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory for ps3fb
In-Reply-To: <1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.62.0701300914580.4728@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251849550.24610@pademelon.sonytel.be>
	<1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 30 Jan 2007, Michael Ellerman wrote:
> On Thu, 2007-01-25 at 18:50 +0100, Geert Uytterhoeven wrote:
> > Preallocate bootmem memory for the PS3 frame buffer device, which needs a
> > large block of physically-contiguous memory. The size of this memory block is
> > configurable:
> >   - The config option CONFIG_FB_PS3_DEFAULT_SIZE_M allows to specify the
> >     default amount of memory (in MiB) allocated to the virtual frame buffer.
> >   - The early boot parameter `ps3fb=xxx' allows to override the default value.
> >     It will be rounded up to a multiple of 1 MiB, if needed.
> > 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> Rather than doing the alloc in setup.c, defining a structure to the hold
> the params, and then exporting the structure - why don't you just do the
> alloc in the ps3 fb driver code, and have it all private in there?

Because at that time it's no longer possible to allocate such a big block of
memory.

We have a similar problem with the storage driver, which needs a block of 256
KiB of contiguous memory.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
