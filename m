Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 34A35DDE2F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 23:00:05 +1100 (EST)
Date: Thu, 08 Feb 2007 04:00:03 -0800 (PST)
Message-Id: <20070208.040003.112623191.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: Kbuild change breaks the ppc64 build
From: David Miller <davem@davemloft.net>
In-Reply-To: <17867.1342.763881.188430@cargo.ozlabs.ibm.com>
References: <17867.1342.763881.188430@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, olecom@flower.upol.cz,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 8 Feb 2007 22:10:54 +1100

> Commit 5de043f4bd11a9e0a3e8daec7d1905da575a76b7 breaks the build on
> 64-bit powerpc because we no longer get the -m64 flag passed to gcc.
> There is code in arch/powerpc/Makefile which adds (or used to add)
> -m64 to AS, LD and CC if we are running on a 64-bit machine (which I
> am) and have a biarch toolchain (which I do).  Without -m64, the
> toolchain assumes 32-bit and all sorts of things break spectacularly.
> 
> I haven't yet tracked down exactly why this commit has this effect,
> since I find it takes considerable time and effort to understand
> Kbuild.

It's this commit:

commit 5de043f4bd11a9e0a3e8daec7d1905da575a76b7
Author: Oleg Verych <olecom@flower.upol.cz>
Date:   Tue Feb 6 02:18:21 2007 +0100

    [PATCH] kbuild: improve option checking, Kbuild.include cleanup
    
     GNU binutils, root users, tmpfiles, external modules ro builds must
     be fixed to do the right thing now.
    
    Cc: Roman Zippel <zippel@linux-m68k.org>
    Cc: Sam Ravnborg <sam@ravnborg.org>
    Cc: Horst Schirmeier <horst@schirmeier.com>
    Cc: Jan Beulich <jbeulich@novell.com>
    Cc: Daniel Drake <dsd@gentoo.org>
    Cc: Andi Kleen <ak@suse.de>
    Cc: Randy Dunlap <randy.dunlap@oracle.com>
    Signed-off-by: Oleg Verych <olecom@flower.upol.cz>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Linus and Oleg tried to fix it with various subsequent changes
to scripts/Kbuild.include, but it's still broken.

For some reason $(call ...) invocations add spaces.  I tried
another test case:

define test
 $(shell echo -n)
endef

VAR:=$(call test)

all:
	@echo "\'$(VAR)\'"

And this always prints:

' TEST'

even with GNU Make version 3.81

If I put a $(strip ...) around the define, the space is
still there.  If I put the $(strip ...) around VAR's
$(call), the space goes away.
