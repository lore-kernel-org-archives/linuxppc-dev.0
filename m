Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 68B56DDF81
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 21:14:16 +1100 (EST)
Date: Tue, 3 Mar 2009 11:14:04 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: powerpc allnoconfig
In-Reply-To: <20090302200809.26b5d5bb.akpm@linux-foundation.org>
Message-ID: <alpine.LRH.2.00.0903031109190.31985@vixen.sonytel.be>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
	<20090302185514.2cc73512.akpm@linux-foundation.org>
	<20090303141905.52dbf9b1.sfr@canb.auug.org.au>
	<20090302200809.26b5d5bb.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Mar 2009, Andrew Morton wrote:
> On Tue, 3 Mar 2009 14:19:05 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > On Mon, 2 Mar 2009 18:55:14 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > Using built-in specs.
> > > Target: powerpc64-unknown-linux-gnu
> > > Configured with: /home/axboe/crosstool-0.43/build/powerpc64-unknown-linux-gnu/gcc-4.1.0-glibc-2.3.6/gcc-4.1.0/configure --target=powerpc64-unknown-linux-gnu --host=x86_64-host_unknown-linux-gnu --prefix=/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu --disable-multilib --with-sysroot=/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/powerpc64-unknown-linux-gnu/sys-root --with-local-prefix=/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/powerpc64-unknown-linux-gnu/sys-root --disable-nls --enable-threads=posix --enable-symvers=gnu --enable-__cxa_atexit --enable-languages=c --enable-shared --enable-c99 --enable-long-long
> > > Thread model: posix
> > > gcc version 4.1.0
> > > 
> > > > I suspect you have a 64 bit only compiler and allnoconfig produces a 32
> > > > bit kernel.  Is this a new error?
> > > 
> > > 2.6.28 does the same thing.  I don't recall having tested allnoconfig
> > > for ages if at all, so I don't know if it's a regression.
> > 
> > Right, you have a 64 bit only compiler. Also it is version 4.1.0 which we now black ban (I think).
> 
> Probably.  But I only use it for compilation testing, so the `Your
> version of gcc miscompiles the __weak directive' thing is a pointless
> PITA, so I patch it out.
> 
> >  You need to either build a biarch cross compiler (--enable-targets=all) or try:
> > 
> > $ cat >xxx <<EOF
> > CONFIG_PPC64=y
> > EOF
> > $ KCONFIG_ALLCONFIG=xxx make allnoconfig
> > $ make vmlinux
> > 
> > let us know if that works :-)
> 
> didn't.  Oh well.

Does allnoconfig work if you force the compiler to be 32-bit, like

    make CC="powerpc64-unknown-linux-gnu-gcc -m32"

? This is what I'm using to compile ppc32 kernels with the Cell SDK ppu-gcc43,
which defaults to -m64 (BTW, I also had to add "-mcpu=440" for gcc 4.3.2, which
I didn't need for the banned 4.1.1).

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
