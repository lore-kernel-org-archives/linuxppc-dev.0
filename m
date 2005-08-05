Return-Path: <arnd@arndb.de>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82A5567E2E
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Aug 2005 04:42:21 +1000 (EST)
Received: from e6.ny.us.ibm.com ([192.168.1.106])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j75GSaF0005400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Aug 2005 12:28:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 5 Aug 2005 18:24:16 +0200
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<200508051353.23750.arnd@arndb.de>
	<20050806005941.5d1fe432.sfr@canb.auug.org.au>
In-Reply-To: <20050806005941.5d1fe432.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508051824.17947.arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
	Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Freedag 05 August 2005 16:59, Stephen Rothwell wrote:

> Well noone should even include kernel headers from user space :-) and my
> understanding is that glibc "sanitizes" its version of the kernel headers
> anyway.

Glibc doesn't change the header files too much, most of that is done in
the linux-libc-headers package, which is maintained separately from the
kernel and from glibc. There is some effort being put into keeping the
difference between that package and the kernel headers small.

Also, while using kernel headers directly from user space should be
considered a bug, Linus has stated before that he wants source code
that is broken in that way to keep working instead of breaking it
even more.

There is also klibc, which heavily relies on kernel headers by design.

> > Using CONFIG_64BIT instead of __powerpc64__ only within #ifdef __KERNEL=
__
> > would be correct but less consistant.
>=20
> The advantage of using CONFIG_64BIT as much as possible is that it shows
> us places that can be consolidated across the various architectures
> (which is a bit of a passion of mine :-)). =A0And more consolidation shou=
ld
> make life easier for the glibc folks in the long run.

AFAIK, in linux-libc-headers every usage of CONFIG_* outside of __KERNEL__
is a bug that needs to be fixed by the maintainer, so we really should not
do that.

I think it might be ok to use CONFIG_64BIT for files that are completely
inside #ifdef __KERNEL__, but I'd like to avoid stuff like:

#ifndef __powerpc64__
#define __NR_sendfile64=AD=AD		226 /* only for 32 bit */
#endif /* __powerpc64__ */
=2E..
#ifdef __KERNEL__
#ifndef CONFIG_64BIT
#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
#else  /* CONFIG_64BIT */
#define cond_syscall(x) asm(".weak\t." #x "\n\t.set\t." #x ",.sys_ni_syscal=
l")
#endif /* CONFIG_64BIT */
#endif /* __KERNEL__ */

in a single file. Using __powerpc64__ consistantly has the advantage that
the casual reader can easily find all places that rely on 32/64 bit
definitions without having to understand why there are two different ways
to do the same thing.

Perhaps it works out better if this is combined with the split into
include/asm-powerpc/ and include/asm-powerpc/user, as mentioned in the
thread around http://www.ussg.iu.edu/hypermail/linux/kernel/0411.3/1663.htm=
l.
Then we could have CONFIG_64BIT everywhere in the real kernel headers and
__powerpc64__ in the user interface headers.

	Arnd <><
