Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D821767C14
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 08:28:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: atomic operations in user space
Date: Wed, 23 Aug 2006 00:23:31 +0200
References: <20060822205024.98433.qmail@web36105.mail.mud.yahoo.com>
In-Reply-To: <20060822205024.98433.qmail@web36105.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608230023.31402.arnd@arndb.de>
Cc: Xupei Liang <tliang@yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Tuesday 22 August 2006 22:50 schrieb Xupei Liang:
> #include <asm-ppc/atomic.h>
>
> int main()
> {
> =A0=A0=A0=A0=A0=A0=A0=A0atomic_t atom;
>
> =A0=A0=A0=A0=A0=A0=A0=A0atomic_add(1, &atom);
> =A0=A0=A0=A0=A0=A0=A0=A0return (0);
> }
>
> I am able to compile it and the atomic_add seems to be
> translated into the correct instructions. Can anybody
> please confirm? Thanks.

No, you can't do that, the kernel headers are not generally
working in user space, recent kernel versions protect you
from doing this.

If you don't have a library providing you with atomic operations,
you can copy the inline functions from the kernel, which will
work fine, but require that your app is GPL licensed.

	Arnd <><
