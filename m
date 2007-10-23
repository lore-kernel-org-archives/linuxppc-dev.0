Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B3D9DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 19:09:42 +1000 (EST)
In-Reply-To: <20071023140231.12698d1c.sfr@canb.auug.org.au>
References: <20071023140231.12698d1c.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <abdbca68b7265f0722eca787b16b4dae@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Problems with allyesconfig kernel build
Date: Tue, 23 Oct 2007 11:09:04 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, amodra@bigpond.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This was first noted with the -mm tree, but has now migrated into 
> Linus'
> tree.  An allyesconfig build dies in the link stage like this:
>
> /usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x80c8): sibling call 
> optimization to `.text.init.refok' does not allow automatic multiple 
> TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or 
> make `.text.init.refok' extern
> /usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x8160): sibling call 
> optimization to `.text.init.refok' does not allow automatic multiple 
> TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or 
> make `.text.init.refok' extern
> /usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x81c4): sibling call 
> optimization to `.text.init.refok' does not allow automatic multiple 
> TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or 
> make `.text.init.refok' extern
> /usr/bin/ld: final link failed: Bad value

I just tried, and it works fine for me.

> Intuiting the obvious, I changed all the _INIT_STATIC and _INIT_GLOBAL
> uses in head_64.S back to _STATIC and _GLOBAL (which just moves the 
> code
> from .text.init.refok to .text).  Now the linker segfaults instead.  
> :-)

Tried that, too, and no segfault, everything happy.

> $ ld --version
> GNU ld (GNU Binutils for Debian) 2.18

I'm using CVS HEAD of binutils.  Could you try that, with the same
GCC version you are currently using?  Just to narrow things down...


Segher
