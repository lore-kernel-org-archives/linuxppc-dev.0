Return-Path: <olecom@flower.upol.cz>
Received: from raven.upol.cz (raven.upol.cz [158.194.120.4])
	by ozlabs.org (Postfix) with ESMTP id 0E29EDDE2E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 23:39:00 +1100 (EST)
Date: Thu, 8 Feb 2007 13:47:56 +0100
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Kbuild change breaks the ppc64 build
Message-ID: <20070208124756.GU22699@flower.upol.cz>
References: <17867.1342.763881.188430@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17867.1342.763881.188430@cargo.ozlabs.ibm.com>
From: Oleg Verych <olecom@flower.upol.cz>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 08, 2007 at 10:10:54PM +1100, Paul Mackerras wrote:
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

As i have refactored some CC checking code in Kbuild.include, it
turned, that some versions of `make' after calling nested functions,
add (or leave) prefix whitespace to result, thus ifeq[0] fails:

 .-*- (ppc Makefile)
 |HAS_BIARCH      := $(call cc-option-yn, -m32)
0|ifeq ($(HAS_BIARCH),y)
 |AS              := $(AS) -a32
 |LD              := $(LD) -m elf32ppc
 |CC              := $(CC) -m32
 |endif

David wrote and showed a testcase.
Adding $(strip ) wrapper helped with this, but may screw many other
things. Maybe you will help, unless Linus will finally revert this :)

____
