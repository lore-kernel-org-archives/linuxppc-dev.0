Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id B856567A6B
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 10:10:10 +1100 (EST)
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id BA6693DF00E
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Feb 2005 23:53:08 +0100 (CET)
Date: Sun, 6 Feb 2005 23:53:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050206225323.GA16821@mars.ravnborg.org>
References: <20050206124014.GA5880@suse.de>
	<20050206215131.GF7686@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050206215131.GF7686@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>,
	Olaf Hering <olh@suse.de>
Subject: Re: make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 06, 2005 at 02:51:31PM -0700, Tom Rini wrote:
> On Sun, Feb 06, 2005 at 01:40:14PM +0100, Olaf Hering wrote:
> > 
> > this is what I got with 2.6.11rc3:
> > 
> > make ARCH=ppc O=../O-2.6.11-rc3-b50-SMP -j12 all
> > ...
> >   LD      vmlinux
> >   SYSMAP  System.map
> >   SYSMAP  .tmp_System.map
> >   OBJCOPY arch/ppc/boot/images/vmlinux.bin
> >   HOSTCC  arch/ppc/boot/utils/addnote
> >   HOSTCC  arch/ppc/boot/utils/mknote
> >   HOSTCC  arch/ppc/boot/utils/mkprep
> >   LD      arch/ppc/boot/lib/built-in.o
> >   HOSTCC  arch/ppc/boot/utils/hack-coff
> >   HOSTCC  arch/ppc/boot/utils/mkbugboot
> >   OBJCOPY arch/ppc/boot/images/vmlinux.bin
> >   GZIP    arch/ppc/boot/images/vmlinux.gz
> > /bin/sh: line 1: arch/ppc/boot/images/vmlinux.bin: No such file or directory
> > make[2]: *** [arch/ppc/boot/images/vmlinux.gz] Error 1
> > make[1]: *** [uImage] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > 
> > also, one time that zImage.chrp was only 570K instead of the expected
> > 1.4M, so netboot failed. But I got no build error.
> > Any idea what dependency is missing?
> 
> That is kinda odd.  My thought is that arch/ppc/boot/ just isn't fully
> safe for -j'ing.  Sam, any ideas on how to debug this kinda problem?

The problem is that the images/ sub directory is visited before the
prerequisites are finished.
I have no good way to debug this - I can see it based on the Makefile and
the output Olaf included.

Also the problem Olaf describe is just a cp of a half finished file.


So the fix is to let the images/ directory depends on the rest of the
directories.

Something like this may do the trick:

$(obj)/images: $(addprefix $(obj)/,$(subdir-y) $(bootdir-y))
	$(Q)$(MAKE) $(build)=$@

And then delete the assignment of images to subdir-y


Another solution would be to get rid on the images/ drectory and place
outputfiles where they are being built.

	Sam
