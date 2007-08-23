Return-Path: <euphoria@arcor.de>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1DB62DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 08:41:06 +1000 (EST)
Message-ID: <46CE0CF6.2010804@arcor.de>
Date: Fri, 24 Aug 2007 00:40:54 +0200
From: Florian Boelstler <euphoria@arcor.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC] xmon: setjmp / longjmp implementation problems
Content-Type: text/plain; charset=ISO-8859-15
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I was hunting an ugly problem in the NuBus PowerMac port of Linux [1]
for a while now (that platform isn't included in mainline kernel and
still is based on 2.4 kernel series).
Linux was successfully built using gcc-3.3.5/binutils-2.15 so far.

Later toolchain versions (e.g. gcc-3.4.5/binutils-2.15) turned out to
break things during hardware detection on the NuBus.
Looking at the relevant code sections shows that the register probing
code is based on the setjmp/longjmp implementation [2] found in xmon.
Regarding the "ppc" platform that code almost matches at least up to
mainline kernel 2.6.20.1 [3].
On the "powerpc" platform the code did dramatically change [4].

I was extracting both implementations to a simple userspace application
to be able to easily try different compiler versions and optimization
levels.
Eventually I found out that the temporary solution is to build the
ppc-implementation using -O1 for gcc versions >3.3.5.

Since I found a comment by Paul in arch/ppc/xmon/setjmp.c: "NB this file
must be compiled with -O2.", I was wondering which toolchain versions
are/were used to compile xmon-enabled kernels for the ppc and powerpc
platform.
Since -O2 seems to be the default for 2.6 kernels as well, I am
wondering what gcc version is known to build a kernel with xmon support.
Are there are any known gcc versions, which are causing trouble with
xmon (actually its setjmp/longjmp implementation)?


Some details of toolchain tests follow:

"ppc" implementation:
When -O2 is used gcc-3.4.5 inlines static functions by default, which
turned out to be the first problem. Even when "static" is removed the
resulting program flow reflects an infinite loop (when longjumped
function returns).
I found out that -O1 with gcc-3.4.5 generates code, which resembles the
functionality of gcc-3.3.5 with -O2. I.e. a working version of
setjmp/longjmp. A segmentation fault occurs when no optimization level
is used.
With gcc-4.1.0 no successful working build was possible.

"powerpc" implementation:
The binary works with no optimization level, -O0 and -O1 with gcc-3.4.5.
Using -O2 turns the resulting code into an infinite loop again.
With gcc-4.1.0/binutils-2.16.1 only -O0 generated a useful binary.


Thanks for any suggestions!

  Florian


[1] http://nubus-pmac.sf.net
[2]
http://nubus-pmac.cvs.sourceforge.net/nubus-pmac/linuxppc-2.4-nubus/arch/ppc/platforms/nbpmac_setup.c
Lines 162-194
[3] http://lxr.linux.no/source/arch/ppc/xmon/setjmp.c?a=ppc
[4] http://lxr.linux.no/source/arch/powerpc/xmon/setjmp.S?a=ppc
