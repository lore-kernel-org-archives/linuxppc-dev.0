Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts43-srv.bellnexxia.net (tomts43.bellnexxia.net
	[209.226.175.110]) by ozlabs.org (Postfix) with ESMTP id 2EFE9DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 08:32:58 +1000 (EST)
Received: from krystal.dyndns.org ([76.65.102.190])
	by tomts43-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070719223255.GCIS5730.tomts43-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 18:32:55 -0400
Date: Thu, 19 Jul 2007 18:32:54 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Powerpc - Include pagemap.h in asm/powerpc/tlb.h
Message-ID: <20070719223254.GA30383@Krystal>
References: <20070714012033.GC31649@Krystal>
	<20070718223034.7388e59f.akpm@linux-foundation.org>
	<D9805F9D-04B0-4422-81F1-958B15482A93@kernel.crashing.org>
	<20070719131348.170443bb.akpm@linux-foundation.org>
	<E7820A72-36A3-4B4D-A497-974409D3EBDE@kernel.crashing.org>
	<20070719143020.5e0b7474.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070719143020.5e0b7474.akpm@linux-foundation.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Andrew Morton (akpm@linux-foundation.org) wrote:
> On Thu, 19 Jul 2007 16:04:38 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> > >> Andrew,
> > >>
> > >> Are you sending this to linus directly or should this go via paul and
> > >> me?
> > >>
> > >
> > > I queued it up for Paul.  I can send it over to Linus today if we  
> > > have a
> > > reason for that.  It's just that I dont understand the patch: does  
> > > it fix
> > > -mm-only breakage?  Does it fix something which already got fixed,  
> > > or what?
> > 
> > I'm seeing the same breakage in my tree.
> 
> Oh, OK.  Let's just merge it.
> 
> > > One might think "gee, it's trivial, just slam it in", but these nested
> > > includes are often not-trivial and something else can explode as a  
> > > result.
> > 
> > I'll do a git-bisect and see if I can find the patch that causes this  
> > breakage so we know what's going on.
> 
> eh, don't bother.

Hrm, I still think it's kind of interesting to see what happens there.

So the sane way to make sure it's fixed would be to turn the macros
free_page_and_swap_cache() and free_pages_and_swap_cache() into an
inline function (just to make sure the compiler complains), but that
would require to include linux/pagemap.h from linux/swap.h. But let's
just see what happens on sparc if we include linux/pagemap.h from
swap.h.

I just tested compiling on sparc, here is the result:


  /opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/bin/sparc-unknown-linux-gnu-gcc -Wp,-MD,init/.main.o.d  -nostdinc -isystem /opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/lib/gcc/sparc-unknown-linux-gnu/4.1.1/include -D__KERNEL__ -Iinclude -Iinclude2 -I/home/compudj/git/linux-2.6-lttng/include -include include/linux/autoconf.h -I/home/compudj/git/linux-2.6-lttng/init -Iinit -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -fomit-frame-pointer -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign  -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(main)"  -D"KBUILD_MODNAME=KBUILD_STR(main)" -c -o init/.tmp_main.o /home/compudj/git/linux-2.6-lttng/init/main.c
In file included from /home/compudj/git/linux-2.6-lttng/include/linux/highmem.h:24,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:10,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/swap.h:9,
                 from include2/asm/pgtable.h:15,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/mm.h:38,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/rmap.h:9,
                 from /home/compudj/git/linux-2.6-lttng/init/main.c:49:
include2/asm/highmem.h: In function 'kmap':
include2/asm/highmem.h:60: error: implicit declaration of function 'PageHighMem'
include2/asm/highmem.h:61: error: implicit declaration of function 'page_address'
include2/asm/highmem.h:61: warning: return makes pointer from integer without a cast
In file included from /home/compudj/git/linux-2.6-lttng/include/linux/swap.h:9,
                 from include2/asm/pgtable.h:15,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/mm.h:38,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/rmap.h:9,
                 from /home/compudj/git/linux-2.6-lttng/init/main.c:49:
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h: In function 'linear_page_index':
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:153: error: dereferencing pointer to incomplete type
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:154: error: dereferencing pointer to incomplete type
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h: In function 'lock_page':
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:168: error: implicit declaration of function 'TestSetPageLocked'
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h: In function 'wait_on_page_locked':
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:198: error: implicit declaration of function 'PageLocked'
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:199: error: 'PG_locked' undeclared (first use in this function)
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:199: error: (Each undeclared identifier is reported only once
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:199: error: for each function it appears in.)
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h: In function 'wait_on_page_writeback':
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:207: error: implicit declaration of function 'PageWriteback'
/home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:208: error: 'PG_writeback' undeclared (first use in this function)
In file included from /home/compudj/git/linux-2.6-lttng/include/linux/rmap.h:9,
                 from /home/compudj/git/linux-2.6-lttng/init/main.c:49:
/home/compudj/git/linux-2.6-lttng/include/linux/mm.h: At top level:
/home/compudj/git/linux-2.6-lttng/include/linux/mm.h:605: error: conflicting types for 'page_address'
include2/asm/highmem.h:61: error: previous implicit declaration of 'page_address' was here

PageHighMem is declared in linux/page-flags.h, which is included in
linux/mm.h with the following comment:

/*
 * FIXME: take this include out, include page-flags.h in
 * files which need it (119 of them)
 */
#include <linux/page-flags.h>

(linux/mm.h is included from linux/highmem.h)

Actually, we get a circular inclusion there:

In file included from /home/compudj/git/linux-2.6-lttng/include/linux/highmem.h:24,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/pagemap.h:10,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/swap.h:9,
                 from include2/asm/pgtable.h:15,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/mm.h:38,
                 from /home/compudj/git/linux-2.6-lttng/include/linux/rmap.h:9,
                 from /home/compudj/git/linux-2.6-lttng/init/main.c:49:


mm.h includes asm-sparc/pgtable.h includes linux/swap.h includes
linux/pagemap.h (which I have added myself) includes linux/highmem.h
includes mm.h.....

Is it me or it all looks like a fubarish mess ? :(

Why is asm-sparc/pgtable.h including linux/swap.h ? Perharps the sparc
devs will be able to enlighten us...

Mathieu

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
