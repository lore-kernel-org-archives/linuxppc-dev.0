Return-Path: <jfree@sovereign.org>
Received: from sovereign.org (sovereign.org [66.93.224.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lux.homenet", Issuer "lux.homenet" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2C7AD2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 11:56:12 +1000 (EST)
From: Jim Freeman <jfree@sovereign.org>
Date: Wed, 13 Oct 2004 19:55:41 -0600
To: Dan Kegel <dank@kegel.com>
Message-ID: <20041014015541.GC16252@sovereign.org>
References: <DBFABB80F7FD3143A911F9E6CFD477B0021B045A@hqemmail02.nvidia.com>
	<416BF876.4020606@kegel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <416BF876.4020606@kegel.com>
Cc: Stephen Warren <SWarren@nvidia.com>, crossgcc <crossgcc@sources.redhat.com>,
	linuxppc-embedded@ozlabs.org
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


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached script (wrapper/setup to crosstool.sh) gets me
a toolchain sufficient to build the default-config ppc kernel
(2.6.8.1, NPTL, gcc-3.4.2, glibc-2.3.3).

It tweaks the patch Dan references below for a ppc-ism,
then adds a patch (thanks Google!) to mask an issue that
gcc-3.4.2 has with inline functions calling setjmp() ( see
http://mirrors.mathematik.uni-bielefeld.de/pub/linux/suse/ftp.suse.com/pub/projects/powerpc/ftp.linuxppc64.org/pub/people/janis/old/README.20040130
)

The toolchain build fails near the end while linking
build-glibc/elf/sln with undefined references to
`_Unwind_Resume' and `__gcc_personality_v0' (which Google
hints is/was a popular problem, but I don't have time to
track it down).  In any case, 'sln' isn't needed for kernel
building, so it's good enough for me for now.

...jfree
========

On Tue, Oct 12, 2004 at 08:29:58AM -0700, Dan Kegel wrote:
> Hi Stephen,
> to build NPTL, you need to apply 
> contrib/crosstool-0.28-rc34-nptl_fixes.patch
> Then see demo-x86_64-nptl.sh
> 
> Enough people need this that I've been intending for two weeks to merge it 
> asap,
> but I haven't gotten around to it.
> 
> That patch was only tested for x86, but ppc32 shouldn't be any
> harder, right? :-)
> - Dan
> 
> Stephen Warren wrote:
> >Hi. I'm attempting to use your crosstool to build a NPTL capable GLIBC
> >and toolchain for a 32-bit PowerPC target.
...
> >Thanks for any pointers at all!
> >
> >------------------------------------------------------------------------
> >
> >Subject: NPTL support on PPC32 (MPC5200) ?
> >From: "Stephen Warren" <SWarren@nvidia.com>
...
> >My question is - can anybody tell me, or point me at a website that
> >definitively tells me:
> >
> >1) Is NPTL available on PPC at all? I assume so, since I found one of
> >the original announcement of NPTL, which mentions performance on a large
> >SMP PPC system.
...

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xgcc-booke

#!/bin/bash
set -x

# http://kegel.com/crosstool/
# http://sources.redhat.com/ml/binutils/2003-10/msg00448.html
# http://sources.redhat.com/ml/crossgcc/2004-03/msg00162.html
# http://sources.redhat.com/ml/binutils/2001-10/msg00186.html

## http://mirrors.mathematik.uni-bielefeld.de/pub/linux/suse/ftp.suse.com/pub/projects/powerpc/ftp.linuxppc64.org/pub/people/janis/old/README.20040130
## http://mirrors.mathematik.uni-bielefeld.de/pub/linux/suse/ftp.suse.com/pub/projects/powerpc/ftp.linuxppc64.org/pub/people/janis/old/glibc.patch.20040121 ;

[ ! -f  crosstool-0.28-rc37.tar.gz ] && \
	wget http://kegel.com/crosstool/crosstool-0.28-rc37.tar.gz || true

tar xzf crosstool-0.28-rc37.tar.gz

cd crosstool-0.28-rc37

pwd

## NPTL patch: when ARCH=ppc, dirname needs to be "powerpc"
## patch the patch ...

patch -p 0 <<HERE
--- contrib/crosstool-0.28-rc34-nptl_fixes.patch        2004/10/13 04:48:11    1.1
+++ contrib/crosstool-0.28-rc34-nptl_fixes.patch        2004/10/13 04:48:45
@@ -164,7 +164,7 @@
 +        # will have to manually be copied from under the tree of the desired
 +        # target pthread implementation.
 +        cp \${GLIBC_DIR}/nptl/sysdeps/pthread/pthread.h \$HEADERDIR/pthread.h
-+        cp \${GLIBC_DIR}/nptl/sysdeps/unix/sysv/linux/\${ARCH}/bits/pthreadtypes.h \$HEADERDIR/bits/pthreadtypes.h
++        cp \${GLIBC_DIR}/nptl/sysdeps/unix/sysv/linux/\${ARCH/ppc/powerpc}/bits/pthreadtypes.h \$HEADERDIR/bits/pthreadtypes.h
 +
 +        # On s390, powerpc and sparc we also require bits/wordsize.h.
 +        case \$TARGET in
HERE

# now apply the patch ...
patch -p 1 <  contrib/crosstool-0.28-rc34-nptl_fixes.patch

## gcc3.4.2 disallows setjmp() in inline functions:
## http://mirrors.mathematik.uni-bielefeld.de/pub/linux/suse/ftp.suse.com/pub/projects/powerpc/ftp.linuxppc64.org/pub/people/janis/old/README.20040130
## then fixup to only use first part of patch (and doctor for "patch -p1") ...

( cd patches/glibc-2.3.3;
        wget http://mirrors.mathematik.uni-bielefeld.de/pub/linux/suse/ftp.suse.com/pub/projects/powerpc/ftp.linuxppc64.org/pub/people/janis/old/glibc.patch.20040121 ;
        ed glibc.patch.20040121 <<HERE
/Makefile
.,\$d
,s#sysdeps#foo/sysdeps#g
wq
HERE
)

TARBALLS_DIR=`pwd`/..	\
TARGET=powerpc-8540-linux-gnu   \
TARGET_CFLAGS="-O -msoft-float -mno-string -Wa,-me500"  \
GCC_EXTRA_CONFIG=""     \
GCC_LANGUAGES="c"       \
GLIBC_EXTRA_CONFIG="--without-fp"       \
GLIBC_ADDON_NPTL=1	\
BINUTILS_DIR=binutils-2.15      \
GCC_DIR=gcc-3.4.2       \
GLIBC_DIR=glibc-2.3.3   \
LINUX_DIR=linux-2.6.8.1 \
        ./all.sh  --testlinux

	# now,
	#  cd build/powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3/linux-2.6.8.1
	# ( or wherever your kernel of interest lives )
	#  make V=1 ARCH=ppc CROSS_COMPILE=/work/src/crosstool-0.28-rc37/result/powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin/powerpc-8540-linux-gnu-

--1yeeQ81UyVL57Vl7--
