Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id B3BD7DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 09:58:12 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] sys_indirect kernel implementation for PowerPC
Date: Tue, 27 Nov 2007 23:57:56 +0100
References: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
	<20071121144245.e8abf9e8.sfr@canb.auug.org.au>
In-Reply-To: <20071121144245.e8abf9e8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711272357.57007.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 November 2007, Stephen Rothwell wrote:
> > +++ b/include/asm-powerpc/systbl.h
> > @@ -313,3 +313,4 @@ COMPAT_SYS_SPU(timerfd)
> > =A0SYSCALL_SPU(eventfd)
> > =A0COMPAT_SYS_SPU(sync_file_range2)
> > =A0COMPAT_SYS(fallocate)
> > +COMPAT_SYS(indirect)
>=20
> Do the SPUs want this?

Excellent question. Sorry for being late in my reply here. The calls
that are marked non-spu capable are those that are harmful when run
on the SPU, e.g. because they modify the signal mask -- the SPU cannot
receive signals itself.

sys_indirect is potentially very useful on the SPU, but we can't allow
it if it gives you access to all other syscalls. If we want to use it
on the SPU at some point, we may have to provide an alternative
implementation that walks the spu_syscall_table instead.
OTOH, if sys_indirect is mostly useful for the eventual addition of
syslets, we can leave it out, because syslets don't make sense if
you have no multithreading capability.

	Arnd <><
