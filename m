Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 874A9DE061
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 05:00:44 +1100 (EST)
Subject: Re: Building dtc etc. for packaging
From: Nate Case <ncase@xes-inc.com>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <4919C115.8040107@genesi-usa.com>
References: <4919C115.8040107@genesi-usa.com>
Content-Type: text/plain
Date: Tue, 11 Nov 2008 12:00:37 -0600
Message-Id: <1226426437.27415.379.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-11-11 at 11:29 -0600, Matt Sealey wrote:
> (the other tool we need is mkimage from U-Boot, I noticed Debian uses
> this
> same command name inside jigdo etc. too, sigh.. also you can't build
> the
> tools without the rest of U-Boot which is hard to envision doing just
> to
> get one command out of it - "make tools/mkimage" doesn't work and I
> got
> tired of reverse engineering the chickenscratch..)

This is a bit off-topic, but here is my ugly hack to compile a
statically linked 'mkimage' from the U-Boot tree:

Place this file, 'Makefile.mkimage' in u-boot/tools/
---[snip]---
CFLAGS = -O2 -static -I../include -DUSE_HOSTCC -I.
ASMDIR = ../include/asm

CFILES = ../lib_generic/crc32.c ../libfdt/fdt_strerror.c \
         ../lib_generic/sha1.c ../lib_generic/md5.c ../common/image.c \
         ../libfdt/fdt_wip.c ../libfdt/fdt.c ../libfdt/fdt_ro.c \
         ../libfdt/fdt_rw.c

mkimage: mkimage.c
        mv $(ASMDIR) $(ASMDIR).back
        ln -s $(ASMDIR)-i386 $(ASMDIR)
        gcc $(CFLAGS) $(CFILES) mkimage.c -o mkimage
        rm -f $(ASMDIR)
        mv $(ASMDIR).back $(ASMDIR)
        strip mkimage

default: mkimage
---[snip]---

Then just run 'make -f Makefile.mkimage' from within tools/.  Of course
this uses some nasty tricks that will only work on i386 host.  I don't
think I'm the first person to have this need, so others here may have
better solutions.

-- 
Nate Case <ncase@xes-inc.com>
