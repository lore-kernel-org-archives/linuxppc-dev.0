Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ABCB1DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 14:18:49 +1000 (EST)
Date: Mon, 22 Oct 2007 21:18:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Problems with allyesconfig kernel build
Message-Id: <20071022211836.45a87a12.akpm@linux-foundation.org>
In-Reply-To: <20071023140231.12698d1c.sfr@canb.auug.org.au>
References: <20071023140231.12698d1c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, amodra@bigpond.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 23 Oct 2007 14:02:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> This was first noted with the -mm tree, but has now migrated into Linus'
> tree.

Yeah, sorry, I didn't know what to do about that.  I'm not even sure which
patch caused it.

>  An allyesconfig build dies in the link stage like this:
> 
> /usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x80c8): sibling call optimization to `.text.init.refok' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.init.refok' extern
> /usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x8160): sibling call optimization to `.text.init.refok' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.init.refok' extern
> /usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x81c4): sibling call optimization to `.text.init.refok' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.init.refok' extern
> /usr/bin/ld: final link failed: Bad value
> 
> We already compile with -mminimal-toc and adding
> -fno-optimize-sibling-call did not help.
> 
> Intuiting the obvious, I changed all the _INIT_STATIC and _INIT_GLOBAL
> uses in head_64.S back to _STATIC and _GLOBAL (which just moves the code
> from .text.init.refok to .text).  Now the linker segfaults instead.  :-)
> 
> /bin/sh: line 1:  5260 Segmentation fault      ld -m elf64ppc -Bstatic --emit-relocs --build-id -o .tmp_vmlinux1 -T arch/powerpc/kernel/vmlinux.lds arch/powerpc/kernel/head_64.o arch/powerpc/kernel/entry_64.o arch/powerpc/kernel/fpu.o init/built-in.o --start-group usr/built-in.o arch/powerpc/kernel/built-in.o arch/powerpc/mm/built-in.o arch/powerpc/lib/built-in.o arch/powerpc/sysdev/built-in.o arch/powerpc/platforms/built-in.o arch/powerpc/xmon/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o crypto/built-in.o block/built-in.o lib/lib.a lib/built-in.o drivers/built-in.o sound/built-in.o arch/powerpc/oprofile/built-in.o net/built-in.o --end-group
> make[1]: *** [.tmp_vmlinux1] Error 139
> 
> $ ld --version
> GNU ld (GNU Binutils for Debian) 2.18
> 
> I take this as an improvement :-)
> 
> We link .text.init.refok immediately after .text, but with
> allyesconfig, .text ends up very large.
> 
> The --emit-relocs is a product of something else I am working on.  So I
> took that out and now get a whole lot more messages like:
> 
> /usr/bin/ld: net/built-in.o(.fixup+0x4): sibling call optimization to `.text' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text' extern
> /usr/bin/ld: net/built-in.o(.fixup+0xc): sibling call optimization to `.text' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text' extern
> 
> Anyone have any ideas?

I still don't know ;)

What did we do which caused all this to start happening?
