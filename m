Return-Path: <dank@kegel.com>
Received: from relay.pair.com (relay.pair.com [209.68.1.20])
	by ozlabs.org (Postfix) with SMTP id BE4452BDD3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 02:41:19 +1000 (EST)
Message-ID: <416BF876.4020606@kegel.com>
Date: Tue, 12 Oct 2004 08:29:58 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Stephen Warren <SWarren@nvidia.com>,
	linuxppc-embedded@ozlabs.org, crossgcc <crossgcc@sources.redhat.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B0021B045A@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B0021B045A@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: 
Subject: Re: FW: NPTL support on PPC32 (MPC5200) ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Stephen,
to build NPTL, you need to apply contrib/crosstool-0.28-rc34-nptl_fixes.patch
Then see demo-x86_64-nptl.sh

Enough people need this that I've been intending for two weeks to merge it asap,
but I haven't gotten around to it.

That patch was only tested for x86, but ppc32 shouldn't be any
harder, right? :-)
- Dan

Stephen Warren wrote:
> Hi. I'm attempting to use your crosstool to build a NPTL capable GLIBC
> and toolchain for a 32-bit PowerPC target.
> 
> I'm finding it very difficult to find information on which libc, kernel,
> compiler and binutils versions are required for this.
> 
> Can you point me to any information that'll tell me definitively which
> software versions support this, or at any mailing lists that are
> appropriate for this kind of question? I tried
> linuxppc-embedded@ozlabs.org (see attached email) but didn't hear
> anything back.
> 
> Thanks for any pointers at all!
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Subject:
> NPTL support on PPC32 (MPC5200) ?
> From:
> "Stephen Warren" <SWarren@nvidia.com>
> Date:
> Fri, 8 Oct 2004 09:26:22 -0700
> To:
> <linuxppc-embedded@ozlabs.org>
> 
> To:
> <linuxppc-embedded@ozlabs.org>
> 
> 
> Hello everyone.
> 
> I'm trying to run a fairly heavily multi-threaded application on the
> Motorola/Freescale MPC5200 platform. So far, we're having a few
> performance problems. Freescale has profiled the application using
> strace and shown that a lot of our CPU time goes into executing the kill
> and rt_sigsuspend system calls, which we understand are used in the
> implementation of the threading library.
> 
> So, I figured I'd see if NPTL (Native Posix Threads Library) would help
> us out at all. I found and attempted to use a utility named crosstool
> (0.28-rc37) from http://kegel.com/crosstool/ to build a new toolchain
> supporting this.
> 
> I made a few changes to crosstool.sh in an attempt to request NPTL.
> These are shown later in the email.
> 
> However, I'm getting an error from the configure of glibc:
> 
> ...
> /home/swarren/src/crosstool-0.28-rc37/build/powerpc-603e-linux-gnu/gcc-3
> .4-20041001-glibc-20041004/glibc-20041004/configure --prefix=/usr
> --build=i686-pc-linux-gnu --host=powerpc-603e-linux-gnu
> --enable-kernel=2.4.24 --without-cvs --without-gd --with-tls
> --with-__thread --enable-shared --enable-add-ons=nptl
> --with-headers=/usr/local/ppc_82xx/powerpc-603e-linux-gnu/gcc-3.4-200410
> 01-glibc-20041004/powerpc-603e-linux-gnu/include
> ...
> running configure fragment for nptl/sysdeps/pthread
> checking for forced unwind support... no
> configure: error: forced unwind support is required
> 
> I've tried various combinations of:
> 
> gcc-3.4.2        (release)
> gcc-3.4-20041001 (10/01 snapshot)
> glibc-2.3.3      (release)
> glibc-20041004   (10/04 snapshot)
> binutils-2.15    (release)
> binutils-041007) (10/07 snapshot)
> kernel 2.4.24    (release)
> kernel 2.6.8     (release)
> 
> My question is - can anybody tell me, or point me at a website that
> definitively tells me:
> 
> 1) Is NPTL available on PPC at all? I assume so, since I found one of
> the original announcement of NPTL, which mentions performance on a large
> SMP PPC system.
> 
> 2) Which kernels have the required support for NPTL - I believe 2.6.x
> does. I know RedHat back-ported it to their 2.4.x kernels for RedHat 9
> (at least x86). Did it get back-ported into any official 2.4.x kernel,
> such as the 2.4.24 I tried?
> 
> 3) Which glibc and gcc do I need. I found webpages that indicate gcc >=
> 3.4.x is required for toolchain thread/TLS support, and NPTL is part of
> glibc >= 2.3.x.
> 
> 4) Which binutils should work?
> 
> 5) Am I missing some configure options for glibc? Or, binutils or gcc?
> 
> So far, I'm downloading all GNU tools from gnu.org, or a mirror, and
> kernels from kernel.org. Should I try PPC-specific branches for any of
> this?
> 
> Note: I'd really like 2.4.x support if it's available - I need a
> DMA-enabled IDE driver for the MPC5200, and so far, all I have is a
> patched 2.4.24 directly from Freescale (which apparently they're working
> on integrating back into the kernel at www.denx.de) Eventually, we
> intend to use a Montavista-based system. We were using MV Linux 3.0
> (before we hit problems with IDE DMA) which uses kernel 2.4.18.
> 
> Thanks for any help, or pointers to good resources. I spent most of
> yesterday googling and trying out different gcc/glibc/kernel
> combinations, and couldn't get past this.
> 
> Modifications I made to crosstool.sh to request NPTL:
> 
> (Note that if I remove just the second part of this patch, it all builds
> fine, but using the old Linuxthreads instead of NPTL)
> 
> ===============================================================
> [swarren@swarren-linux crosstool-0.28-rc37]$ diff crosstool.sh.orig
> crosstool.sh
> 365,367c365,367
> <       --enable-kernel=2.4.3 \
> <         --without-cvs --disable-profile --disable-debug --without-gd \
> <         --without-tls --without-__thread \
> ---
> 
>>      --enable-kernel=2.4.24 \
>>        --without-cvs --without-gd \
>>        --with-tls --with-__thread \
> 
> 369c369
> <         --enable-add-ons${GLIBC_ADDON_OPTIONS}
> --with-headers=$HEADERDIR
> ---
> 
>>        --enable-add-ons=nptl --with-headers=$HEADERDIR
> 
> ===============================================================
> 
> I created my own top-level build script and .dat files based upon the
> existing ones:
> 
> ===============================================================
> [swarren@swarren-linux crosstool-0.28-rc37]$ cat demo-ppc603e.sh 
> #!/bin/sh
> set -ex
> TARBALLS_DIR=$HOME/archive
> RESULT_TOP=/usr/local/ppc_82xx
> export TARBALLS_DIR RESULT_TOP
> GCC_LANGUAGES="c,c++"
> export GCC_LANGUAGES
> 
> # Really, you should do the mkdir before running this,
> # and chown /opt/crosstool to yourself so you don't need to run as root.
> mkdir -p $RESULT_TOP
> 
> # Build the toolchain.  Takes a couple hours and a couple gigabytes.
> eval `cat powerpc-603e.dat gcc-3.4-20041001-glibc-20041004.dat` sh
> all.sh --notest
> 
> echo Done.
> ===============================================================
> 
> ===============================================================
> [swarren@swarren-linux crosstool-0.28-rc37]$ cat
> gcc-3.4-20041001-glibc-20041004.dat
> BINUTILS_DIR=binutils-2.15
> GCC_DIR=gcc-3.4-20041001
> GLIBC_DIR=glibc-20041004
> LINUX_DIR=linux-2.6.8
> ===============================================================
> 


-- 
Know a student in Los Angeles who wants a job doing C++ on Linux?  Send him/her to http://kegel.com/academy
