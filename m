Return-Path: <dgibson@ozlabs.org>
Date: Tue, 6 Mar 2007 11:09:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 11/15] zImage wrapper for Ebony
Message-ID: <20070306000905.GC4728@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.EDB2BDDF1D@ozlabs.org>
	<20070305171053.GC32672@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070305171053.GC32672@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2007 at 10:10:53AM -0700, Mark A. Greer wrote:
> On Mon, Mar 05, 2007 at 02:24:52PM +1100, David Gibson wrote:
> > This patch adds support for building a zImage wrapper suitable for the
> > Ebony (440GP) evaluation board.  This supports booting both from uboot
> > (old versions which don't supply a flattened device tree) and IBM
> > Openbios (aka "treeboot").
> > 
> > Signed-off-by: David Gibson <dwg@au1.ibm.com>
> > ---
> 
> <snip>
> 
> > Index: working-2.6/arch/powerpc/boot/Makefile
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/boot/Makefile	2007-02-26 13:25:31.000000000 +1100
> > +++ working-2.6/arch/powerpc/boot/Makefile	2007-02-26 13:25:33.000000000 +1100
> 
> <snip>
> 
> > @@ -120,6 +128,13 @@ quiet_cmd_wrap_initrd = WRAP    $@
> >        cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
> >  				-i $(obj)/ramdisk.image.gz vmlinux
> >  
> > +quiet_cmd_wrap_dtb	= WRAP    $@
> > +      cmd_wrap_dtb	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
> > +				-d $3 vmlinux
> > +quiet_cmd_wrap_dtb_initrd = WRAP    $@
> > +      cmd_wrap_dtb_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
> > +				-d $3 -i $(obj)/ramdisk.image.gz vmlinux
> > +
> 
> David,
> 
> I think we more-or-less agreed to go with Scott Wood's 'wrap' method
> (unless there is a problem with it).

Oh, we had?

> http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031337.html

Um.. I'm pretty uneasy about that, because I'm not at all sure that
the wrapper script does the right thing w.r.t. where it puts the .dtb
file, when building with a VPATH.

Actually, longer term what I think might be a better option is to
build *all* the dts files into asm (with different symbolic names) and
fold them into the wrapper library.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
