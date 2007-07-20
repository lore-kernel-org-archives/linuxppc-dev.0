Return-Path: <akpm@linux-foundation.org>
Date: Fri, 20 Jul 2007 12:55:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/14] spufs: add spu stats in sysfs and ctx stat file
	in spufs
Message-Id: <20070720125553.57e7616e.akpm@linux-foundation.org>
In-Reply-To: <200707202059.26732.arnd@arndb.de>
References: <1184908885751-git-send-email-jk@ozlabs.org>
	<11849088851210-git-send-email-jk@ozlabs.org>
	<20070720114421.0760cc5b.akpm@linux-foundation.org>
	<200707202059.26732.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christoph, Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Jeremy Kerr <jk@ozlabs.org>, Andre Detsch <adetsch@br.ibm.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Jul 2007 20:59:25 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 20 July 2007, Andrew Morton wrote:
> > And what's up with all these powerpc people sending out patchbombs after
> > the merge window has opened? __Formally, _all_ of this:
> > 
> ...
> > 
> > should be pushed back into 2.6.24 because it all arrived too late.
> > 
> > I guess you're all doing that to Paul on a regular basis. __Bad.
> 
> Yes, I'm particularly bad at this usually.
> 
> However, for the ps3 drivers and oprofile, the problem was really
> miscommunication about who gets to merge what first, because there
> were interdependencies with other subsystems: Paul wanted to have
> that code merged through other subsystems maintainers, which for
> different reasons just did not happen at first.
> 
> The spufs patches mostly basically fixes that came up after all the
> other spufs code got merged.
> 
> I'm also still sitting on the fixes (and two new drivers) that I
> submitted to you earlier this week, and asked Linus to pull consequently.
> My plan was to ask Linus again for merging them today, together
> with Jeremy's spufs patches and the oprofile stuff and another patch
> from Christoph.
> 
> Would you prefer me not to do that but to instead just push out the
> patches I have queued myself?
> 

I think it's better if you do it, please - I'm not doing anything useful
here.

Bob has just sent out an udpate to the oprofile patches btw.  I'll cc you
on the incrementals in case that's some use.

btw, I also found the below which I guess I'll merge:


From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

allnoconfig results in this:

 CC      arch/powerpc/mm/tlb_32.o
In file included from include/asm/tlb.h:60,
                 from arch/powerpc/mm/tlb_32.c:30:
include/asm-generic/tlb.h: In function 'tlb_flush_mmu':
include/asm-generic/tlb.h:76: error: implicit declaration of function 'release_pages'
include/asm-generic/tlb.h: In function 'tlb_remove_page':
include/asm-generic/tlb.h:105: error: implicit declaration of function 'page_cache_release'

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/mm/tlb_32.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/powerpc/mm/tlb_32.c~powerpc-tlb_32c-build-fix arch/powerpc/mm/tlb_32.c
--- a/arch/powerpc/mm/tlb_32.c~powerpc-tlb_32c-build-fix
+++ a/arch/powerpc/mm/tlb_32.c
@@ -26,6 +26,8 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
+
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 
_
