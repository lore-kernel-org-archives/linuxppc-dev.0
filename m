Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: =?iso-8859-1?Q?Andr=E9_L=E4mmer?= <alaemmer@fh-konstanz.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Compiling Kernel 2.6 for ppc32 
Date: Wed, 10 Sep 2003 18:08:51 +0200
Message-ID: <000001c377b5$d341b2f0$0f21258d@fhkonstanz.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20030909173054.72C37C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf
> Of Wolfgang Denk
>
> > I tried to compile the kernel 2.6. test 4 for PowerPC. I used the
> > cross compile tool chain ELDK V2.1 from Denx
http://www.denx.de/. I am
> not able to make the kernel, because I get the following error.
>
> In file included from include/asm/system.h:8,
>                  from include/linux/list.h:8,
>                  from include/linux/signal.h:4,
>                  from arch/ppc/kernel/asm-offsets.c:12:
> include/linux/kernel.h:10: stdarg.h: Datei oder Verzeichnis nicht
> gefunden In file included from include/asm/system.h:8,
>
> In the top level Makefile, change the line
> kbuild_2_4_nostdinc     := -nostdinc -iwithprefix include
> into:
> kbuild_2_4_nostdinc     := -nostdinc $(shell $(CC) -print-search-dirs
| \
				sed -ne 's/install: \(.*\)/-I
\1include/gp')

Now I tried kernel 2.6 test5 and changed the following option:
NOSTDINC_FLAGS  =-nostdinc $(shell $(CC) -print-search-dirs | \
                 sed -ne 's/install: \(.*\)/-I \1include/gp')

The compilation continues but the binutiles of ELDK 2.1 are to old.

*** 2.6 kernels no longer buildcorrectly with old versions of binutils.
*** Please upgrade your binutils to 2.12.1 or newer

Will be there a new release in the next time?

André


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
