Return-Path: <David.Daney@caviumnetworks.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5BF29B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 07:51:19 +1000 (EST)
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id D91B0DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 07:51:18 +1000 (EST)
Message-ID: <4AAEBAC2.1050905@caviumnetworks.com>
Date: Mon, 14 Sep 2009 14:50:58 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 00/11] Add support for GCC's __builtin_unreachable() and use
	it in BUG (v2).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>, Mike Frysinger <vapier@gentoo.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-parisc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, Kyle McMartin <kyle@mcmartin.ca>,
	linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When I sent the first version, I had not realized that Roland McGrath
had only a day or two earlier submitted a very similar patch (although
one that only fixed up the x86 case).

I have been working on this quite a while now, starting with adding
the required support to GCC, so with an eye towards finishing it up I
have this new version.

 From the announcement of the first version:

Starting with version 4.5, GCC has a new built-in function called
__builtin_unreachable().  The function tells the compiler that control
flow will never reach that point.  Currently we trick the compiler by
putting in for(;;); but this has the disadvantage that extra code is
emitted for an endless loop.  For an i386 kernel using
__builtin_unreachable() results in an defaultconfig that is nearly 4000
bytes smaller.

This patch set adds support to compiler.h creating a
new macro usable in the kernel called unreachable().  If the compiler
lacks __builtin_unreachable(), it just expands to for(;;).

The x86 and MIPS patches I actually tested with a GCC-4.5 snapshot.
Lacking the ability to test the rest of the architectures, I just did
what seemed right without even trying to compile the kernel.

For version 2:

I fixed a couple of checkpatch issues, and simplified the
unreachable() macro for the pre-GCC-4.5 case (as suggested by Richard
Henderson).  Also several Acked-by: were added.

New in this version (as suggested by Ingo Molnar) I added 11/11 which
uses unreachable() in asm-generic/bug.h for !CONFIG_BUG case.  This
one may be a little controversial as it will end up making code
slightly larger when !CONFIG_BUG and you are using a pre-GCC-4.5
compiler.

I will reply with the 11 patches.

David Daney (11):
   Add support for GCC-4.5's __builtin_unreachable() to compiler.h (v2)
   x86: Convert BUG() to use unreachable()
   MIPS: Convert BUG() to use unreachable()
   s390: Convert BUG() to use unreachable()
   mn10300: Convert BUG() to use unreachable()
   parisc: Convert BUG() to use unreachable()
   powerpc: Convert BUG() to use unreachable()
   alpha: Convert BUG() to use unreachable()
   avr32: Convert BUG() to use unreachable()
   blackfin: Convert BUG() to use unreachable()
   Use unreachable() in asm-generic/bug.h for !CONFIG_BUG case.

  arch/alpha/include/asm/bug.h    |    3 ++-
  arch/avr32/include/asm/bug.h    |    2 +-
  arch/blackfin/include/asm/bug.h |    2 +-
  arch/mips/include/asm/bug.h     |    4 +---
  arch/mn10300/include/asm/bug.h  |    3 ++-
  arch/parisc/include/asm/bug.h   |    4 ++--
  arch/powerpc/include/asm/bug.h  |    2 +-
  arch/s390/include/asm/bug.h     |    2 +-
  arch/x86/include/asm/bug.h      |    4 ++--
  include/asm-generic/bug.h       |    4 ++--
  include/linux/compiler-gcc4.h   |   14 ++++++++++++++
  include/linux/compiler.h        |    5 +++++
  12 files changed, 34 insertions(+), 15 deletions(-)
