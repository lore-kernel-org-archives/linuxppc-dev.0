Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 346E968734
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 19:46:59 +1100 (EST)
Date: Sat, 19 Nov 2005 09:46:54 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051119084654.GA29731@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17278.40894.898159.724090@cargo.ozlabs.ibm.com>
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

 On Sat, Nov 19, Paul Mackeras wrote:

> There is still something I haven't got right: if you do make -j3, it
> does this sort of thing:
> 
>   STRIP   vmlinux.strip
>   STRIP   vmlinux.strip
>   GZIP    arch/powerpc/boot/kernel-vmlinux.strip.gz
>   GZIP    arch/powerpc/boot/kernel-vmlinux.strip.gz
>   BOOTCC  arch/powerpc/boot/kernel-vmlinux.strip.o
>   BOOTCC  arch/powerpc/boot/kernel-vmlinux.strip.o
> mv: cannot stat `arch/powerpc/boot/.kernel-vmlinux.strip.o.tmp': No such file or directory
> make[2]: *** [arch/powerpc/boot/kernel-vmlinux.strip.o] Error 1
> make[1]: *** [zImage] Error 2
> 
> I have no idea why it tries to make those things twice in parallel.
> It doesn't do that for vmlinux.

I think this comes from the targets evaluation. Maybe strip needs to be
some sort of serialization:

cmd_stripvm = $(STRIP) -s -R .comment $< -o $@.$$$$ && mv -v $@.$$$$ $@

gzip is also called twice, use the mygzip rule from
arch/ppc/boot/images/Makefile

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
