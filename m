Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 2D670DDF30
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 17:02:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Making __copy_tofrom_user more readable for powerpc
	(arch/powerpc/lib/copy_32.S)
Date: Fri, 11 Jul 2008 09:02:43 +0200
References: <49c0ff980807101644x6ffb9a66x3f73c72f1be86e3@mail.gmail.com>
In-Reply-To: <49c0ff980807101644x6ffb9a66x3f73c72f1be86e3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807110902.44237.arnd@arndb.de>
Cc: prodyut hazarika <prodyuth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 July 2008, prodyut hazarika wrote:
> I have a version which just keeps a count of bytes copied till any
> fault happened. Then for any exception, I just substract this value
> from the total number of bytes to be copied, and store in r3 and
> return back. This is the common fixup code for all paths. It makes the
> fixup code much more readable like other architectures (eg. x86).

In some cases, you need to make sure that the return value is exactly
the maximum you could copy, not a little less.
 
> The current code tries to copy one byte at a time after read fault. I
> don't understand why that is necessary. It then clears out the
> destination. All these logic has made the code very unfriendly to
> read.

I'm not sure if the code is also avoiding unaligned accesses here,
which is not a problem on x86. If you access uncached memory with
unaligned pointers, you get an exception and the fixup code will
copy it just fine with byte accesses.

> 2) For read failure, why do we clear out the destination (lines 509 to
> 529 in arch/powerpc/lib/copy_32.S)? Other architecture don't do that.

All architectures should do that for copy_from_user, to avoid potential
data leaks from the kernel when the data is copied back.

	Arnd <><
