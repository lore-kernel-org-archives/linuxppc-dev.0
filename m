Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 922B467A79
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2005 07:36:32 +1000 (EST)
Date: Tue, 12 Jul 2005 14:36:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050712213630.GJ7741@smtp.west.cox.net>
References: <20050206124014.GA5880@suse.de> <20050712212928.GA6717@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050712212928.GA6717@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2005 at 11:29:28PM +0200, Olaf Hering wrote:
>  On Sun, Feb 06, Olaf Hering wrote:
> 
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
> 
> 
> make -j zImage may call if_changed twice at the same time,
> the result is a corrupted vmlinux.gz
> write to a temporary file for the time being until someone with
> make skills fix the serialization properly.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

This is at least functional, so
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

-- 
Tom Rini
http://gate.crashing.org/~trini/
