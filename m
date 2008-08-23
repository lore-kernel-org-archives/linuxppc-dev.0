Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 340ABDDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 18:57:39 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: checkpatch nits ...
Date: Sat, 23 Aug 2008 10:57:21 +0200
References: <48AF5818.7010802@hypersurf.com>
In-Reply-To: <48AF5818.7010802@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808231057.22399.arnd@arndb.de>
Cc: Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 23 August 2008, Kevin Diggs wrote:
> WARNING: externs should be avoided in .c files
> #1137: FILE: powerpc/kernel/cpu/pll_if.c:369:
> + =A0 =A0 =A0 __asm__ __volatile__ (
>=20
> ??? I don't know what this is?
>=20
> The entire block is:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0__asm__ __volatile__ (
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"addi %0,%3,-1\n"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"andc %1,%3,%0\n"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"cntlzw %1,%1\n"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"subfic %1,%1,31\n"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"cntlzw %0,%2\n":
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"=3Dr"(cntlz), "=3Dr"(cnt=
tz):
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"r"(tmp), "b"(cnttz)
> =A0=A0=A0=A0=A0=A0=A0=A0);
>=20

It's a bug in checkpatch, your code is correct (although I would write
asm volatile, not __asm__ __volatile__, and add \t after each \n).
Can you explain why you need that inline assembly? All you do in there
are arithmetic operations, so you should be able to express that using
C, or at least using the helpers we already have.

Checkpatch thinks that what you wrote is a declaration for a function
named __volatile__ returning a variable of type __asm__, and complains
that this declaration belongs into a header file.

	Arnd <><
