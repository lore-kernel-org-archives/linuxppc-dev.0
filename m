Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1EFF6872B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 20:13:02 +1100 (EST)
Date: Sat, 19 Nov 2005 10:12:57 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051119091257.GA30472@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
	<20051119084654.GA29731@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051119084654.GA29731@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Nov 19, Olaf Hering wrote:

>  On Sat, Nov 19, Paul Mackeras wrote:
> 
> > There is still something I haven't got right: if you do make -j3, it
> > does this sort of thing:
> > 
> >   STRIP   vmlinux.strip
> >   STRIP   vmlinux.strip
> >   GZIP    arch/powerpc/boot/kernel-vmlinux.strip.gz
> >   GZIP    arch/powerpc/boot/kernel-vmlinux.strip.gz
> >   BOOTCC  arch/powerpc/boot/kernel-vmlinux.strip.o
> >   BOOTCC  arch/powerpc/boot/kernel-vmlinux.strip.o
> > mv: cannot stat `arch/powerpc/boot/.kernel-vmlinux.strip.o.tmp': No such file or directory
> > make[2]: *** [arch/powerpc/boot/kernel-vmlinux.strip.o] Error 1
> > make[1]: *** [zImage] Error 2
> > 
> > I have no idea why it tries to make those things twice in parallel.

I got this:
  Building modules, stage 2.
  BOOTAS  arch/powerpc/boot/crt0.o
  BOOTCC  arch/powerpc/boot/prom.o
  BOOTAS  arch/powerpc/boot/crt0.o
  BOOTCC  arch/powerpc/boot/prom.o
  BOOTCC  arch/powerpc/boot/stdio.o
  BOOTCC  arch/powerpc/boot/main.o
  BOOTCC  arch/powerpc/boot/stdio.o
  BOOTCC  arch/powerpc/boot/main.o
  HOSTCC  arch/powerpc/boot/hack-coff
mv: cannot stat `arch/powerpc/boot/.crt0.o.tmp': No such file or directory
make[2]: *** [arch/powerpc/boot/crt0.o] Error 1
make[2]: *** Waiting for unfinished jobs....
mv: cannot stat `arch/powerpc/boot/.prom.o.tmp': No such file or directory
make[2]: *** [arch/powerpc/boot/prom.o] Error 1
fixdep: arch/powerpc/boot/.main.o.d: No such file or directory
make[2]: *** [arch/powerpc/boot/main.o] Error 2
make[1]: *** [zImage] Error 2
make[1]: *** Waiting for unfinished jobs....
mv: cannot stat `arch/powerpc/boot/.stdio.o.tmp': No such file or directory
make[2]: *** [arch/powerpc/boot/stdio.o] Error 1
make[1]: *** [zImage.coff] Error 2

The dependencies need some work.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
