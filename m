Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4D2F6679E1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2005 07:34:38 +1000 (EST)
Date: Wed, 25 May 2005 23:34:33 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20050525213433.GA20585@suse.de>
References: <20050206124014.GA5880@suse.de>
	<20050206215131.GF7686@smtp.west.cox.net>
	<20050206225323.GA16821@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050206225323.GA16821@mars.ravnborg.org>
Subject: Re: make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Feb 06, Sam Ravnborg wrote:

> On Sun, Feb 06, 2005 at 02:51:31PM -0700, Tom Rini wrote:
> > On Sun, Feb 06, 2005 at 01:40:14PM +0100, Olaf Hering wrote:

> > >   GZIP    arch/ppc/boot/images/vmlinux.gz
> > > /bin/sh: line 1: arch/ppc/boot/images/vmlinux.bin: No such file or directory
> > > make[2]: *** [arch/ppc/boot/images/vmlinux.gz] Error 1
> > > make[1]: *** [uImage] Error 2
> > > make[1]: *** Waiting for unfinished jobs....
> > > 
> > > also, one time that zImage.chrp was only 570K instead of the expected
> > > 1.4M, so netboot failed. But I got no build error.
> > > Any idea what dependency is missing?
> > 
> > That is kinda odd.  My thought is that arch/ppc/boot/ just isn't fully
> > safe for -j'ing.  Sam, any ideas on how to debug this kinda problem?
> 
> The problem is that the images/ sub directory is visited before the
> prerequisites are finished.
> I have no good way to debug this - I can see it based on the Makefile and
> the output Olaf included.
> 
> Also the problem Olaf describe is just a cp of a half finished file.
> 
> 
> So the fix is to let the images/ directory depends on the rest of the
> directories.
> 
> Something like this may do the trick:
> 
> $(obj)/images: $(addprefix $(obj)/,$(subdir-y) $(bootdir-y))
> 	$(Q)$(MAKE) $(build)=$@
> 
> And then delete the assignment of images to subdir-y
> 
> 
> Another solution would be to get rid on the images/ drectory and place
> outputfiles where they are being built.

I did it this way:

...
  AS      arch/ppc/boot/common/util.o
  CC      arch/ppc/boot/of1275/write.o
  AR      arch/ppc/boot/common/lib.a
  AR      arch/ppc/boot/of1275/lib.a
`arch/ppc/boot/images/vmlinux.gz.27631' -> `arch/ppc/boot/images/vmlinux.gz'
  AR      arch/ppc/boot/lib/lib.a
  UIMAGE  arch/ppc/boot/images/uImage
"mkimage" command not found - U-Boot images will not be built
  Image: arch/ppc/boot/images/uImage not made
`arch/ppc/boot/images/vmlinux.gz.27676' -> `arch/ppc/boot/images/vmlinux.gz'
  CC      arch/ppc/boot/openfirmware/dummy.o
  AS      arch/ppc/boot/simple/head.o
  AS      arch/ppc/boot/simple/relocate.o
...


Index: linux-2.6.12-rc5-olh/scripts/Makefile.lib
===================================================================
--- linux-2.6.12-rc5-olh.orig/scripts/Makefile.lib
+++ linux-2.6.12-rc5-olh/scripts/Makefile.lib
@@ -1,3 +1,4 @@
+# vim: syntax=sh
 # ===========================================================================
 # kbuild: Generic definitions
 # ===========================================================================
@@ -177,7 +178,7 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS)
 # ---------------------------------------------------------------------------

 quiet_cmd_gzip = GZIP    $@
-cmd_gzip = gzip -f -9 < $< > $@
+cmd_gzip = gzip -f -9 < $< > $@.$$$$ ; mv -v $@.$$$$ $@

 # ===========================================================================
 # Generic stuff
