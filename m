Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 36DD3DDF8A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 08:58:33 +1000 (EST)
Date: Mon, 18 Jun 2007 15:55:37 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 30/33] PS3: Bootwrapper support.
Message-ID: <20070618225537.GA19966@mag.az.mvista.com>
References: <46730D8A.9090309@am.sony.com>
	<951969d2021fe6e78917ef8bdb47cf6f@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <951969d2021fe6e78917ef8bdb47cf6f@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2007 at 09:20:10AM -0500, Milton Miller wrote:
> On Sat Jun 16 08:07:06 EST 2007, Geoff Levand wrote:

> > @@ -187,11 +189,12 @@ $(obj)/zImage.%: vmlinux $(wrapperbits)
> >  $(obj)/zImage.iseries: vmlinux
> >         $(STRIP) -s -R .comment $< -o $@
> >
> > -$(obj)/zImage.ps3: vmlinux
> > -       $(STRIP) -s -R .comment $< -o $@
> > +$(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits) 
> > $(srctree)/$(src)/dts/ps3.dts
> > +       $(STRIP) -s -R .comment $< -o vmlinux.strip
> > +       $(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
> >
> > -$(obj)/zImage.initrd.ps3: vmlinux
> > -       @echo "  WARNING zImage.initrd.ps3 not supported (yet)"
> > +$(obj)/zImage.initrd.ps3: vmlinux  $(wrapper) $(wrapperbits) 
> > $(srctree)/$(src)/dts/ps3.dts $(obj)/ramdisk.image.gz
> > +       $(call 
> > cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,$(obj)/ramdisk.image.gz)
> 
> The separate rule here is to pick up ps3.dts, correct?
> 
> After Marc's 3 patch series this would be handled by the config file.
           ^ k  :)

Yep.  Hack the appropriate Kconfig to 'select WANT_DEVICE_TREE'
then make config to set DEVICE_TREE to the name of your dts file
(e.g., ps3.dts).  See configs/prpmc2800_defconfig for an example.

The patches Milton is referring to are at:
http://patchwork.ozlabs.org/linuxppc/patch?id=11428 + 11429 + 11430

> > +
> > +       /* Primary goes to _zimage_start in wrapper. */
> > +
> > +       lis     r4, _zimage_start at ha
> > +       addi    r4, r4, _zimage_start at l
> > +       mtctr   r4
> > +       bctr
> > +
> > +/*
> > + * __system_reset_kernel - Place holder for the kernel reset vector.
> > + *
> > + * The bootwrapper build script copies 0x100 bytes from offset 0x100
> > + * of the rom image to the symbol __system_reset_kernel.  At runtime
> > + * the bootwrapper program copies the 0x100 bytes at 
> > __system_reset_kernel
> > + * to ram address 0x100.  This symbol must occupy 0x100 bytes.
> > + */
> > +
> > +       .globl __system_reset_kernel
> > +__system_reset_kernel:
> > +
> > +       . = __system_reset_kernel + 0x100
> 
> Not bad.   Since this code doesn't have to be at any particular 
> location when it is built (you have no .org or similar, its all PIC), I 
> don't see anything that couldn't be done from an asm block in the 
> platform .c file, like the entry point in prpmc2800.c file; that would 
> save a file in the boot directory.  In that case __system_reset_kernel 
> would be an array of 256 bytes.

Agree.

As for the rest of Geoff's patch, I think I get the gist of what's going
on but it would be really nice to have it described in English (and put
in the patch description).  That way others (like me) could understand
the problem you're solving and what your solution is.

(Hey, Paul made me do that so you can too! ;)

Mark
