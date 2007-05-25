Return-Path: <maik@cs.vu.nl>
Received: from hydra.cs.vu.nl (hydra.cs.vu.nl [130.37.16.4])
	by ozlabs.org (Postfix) with ESMTP id E4531DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 17:14:01 +1000 (EST)
Date: Fri, 25 May 2007 08:39:53 +0200 (CEST)
From: Maik Nijhuis <maik@cs.vu.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: ps3 64-bit kernel: patched prpmc2800.c (fwd)
Message-ID: <Pine.GSO.4.63.0705250829380.19095@hydra.cs.vu.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I had an earlier discussion with Geoff Levand, he suggested me to post it
here.

While compiling a 64-bit kernel for the playstation 3 I noticed that
arch/powerpc/boot/prpmc2800.c doesn't compile. The assembler complains
about a constant that is too big.

When I compile prpmc2800.c this is what 'make V=1' shows:

gcc -m32 -Wp,-MD,arch/powerpc/boot/.prpmc2800.o.d -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-builtin -nostdinc
-isystem /usr/lib/gcc/powerpc64-unknown-linux-gnu/4.1.2/include -fPIC
-fno-stack-protector -Iarch/powerpc/boot
-I/usr/src/ps3-linux/arch/powerpc/boot -c -o arch/powerpc/boot/prpmc2800.o
arch/powerpc/boot/prpmc2800.c

And then this error follows:

/tmp/ccYHAOD7.s: Assembler messages:
/tmp/ccYHAOD7.s:9: Error: operand out of range (0xffffffffffff7fff is not
between 0x0000000000000000 and 0x00000000ffffffff)

I managed to fix this issue as follows: At the end of
arch/powerpc/boot/prpmc2800.c, there is an assembly instruction

rlwinm  10,10,0,~(1<<15)

I replaced this by

rlwinm  10,10,0,~(1<<15) & ((1<<32)-1)

I am running 64-bit gentoo linux with binutils 2.17.50.0.16. It has been
compiled on my ps3 using gentoo ebuild scripts.

After downgrading to binutils 2.17 the problem is gone..

In the binutils bugzilla I couldn't find anything when I searched for
'operand out of range'. It seems like an assembler bug: A 64-bit value is
assumed in a 32 bit instruction, even though the assembler runs in 32 bit
mode because of the -m32. As the value is used in an 'and', the high bits
can safely be ignored.

Could you please either fix binutils or apply the above patch?

Maik
