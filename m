Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0130.outbound.protection.outlook.com [157.56.111.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 685F31A0E36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:59:16 +1100 (AEDT)
Date: Thu, 22 Jan 2015 21:20:17 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 2/2] mm: fix undefined reference to `.kernel_map_pages'
 on PPC builds
Message-ID: <20150122212017.4b7032d52a6c75c06d5b4728@freescale.com>
In-Reply-To: <CAC5umyiF52cykH2_5TD0yzXb+842gywpe-+XZHEwmrDe0nYCPw@mail.gmail.com>
References: <20150120140200.aa7ba0eb28d95e456972e178@freescale.com>
 <20150120230150.GA14475@cloud>
 <20150120160738.edfe64806cc8b943beb1dfa0@linux-foundation.org>
 <CAC5umyieZn7ppXkKb45O=C=BF+iv6R_A1Dwfhro=cBJzFeovrA@mail.gmail.com>
 <20150122014550.GA21444@js1304-P5Q-DELUXE>
 <20150122144147.019eedc41f189eac44c3c4cd@freescale.com>
 <CAC5umyiF52cykH2_5TD0yzXb+842gywpe-+XZHEwmrDe0nYCPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
 Rik van Riel <riel@redhat.com>, linux-mm@kvack.org, josh@joshtriplett.org,
 LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
 Minchan Kim <minchan@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Johannes Weiner <hannes@cmpxchg.org>, Sasha Levin <sasha.levin@oracle.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 23 Jan 2015 08:49:36 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2015-01-23 5:41 GMT+09:00 Kim Phillips <kim.phillips@freescale.com>:
> > Thanks. Now I get this:
> >
> >   LD      init/built-in.o
> > mm/built-in.o: In function `kernel_map_pages':
> > include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
> > include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
> > include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
> > Makefile:925: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> >
> > but, AFAICT, that's not because this patch is invalid: it's because
> > __kernel_map_pages() isn't implemented in
> > arch/powerpc/mm/pgtable_64.c, i.e., for non-PPC_STD_MMU_64 PPC64
> > machines.
> 
> Then, in order to use generic __kernel_map_pages() in mm/debug-pagealloc.c,
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC shouldn't be selected in
> arch/powerpc/Kconfig, when CONFIG_PPC_STD_MMU_64 isn't defined.

Thanks.  I'm still build-testing this now:

>From 082911ee947246ff962ef21863c45ec467455c40 Mon Sep 17 00:00:00 2001
From: Kim Phillips <kim.phillips@freescale.com>
Date: Thu, 22 Jan 2015 20:42:40 -0600
Subject: [PATCH v2] mm: fix undefined reference to  `.__kernel_map_pages' on FSL
 PPC64

arch/powerpc has __kernel_map_pages implementations in mm/pgtable_32.c, and
mm/hash_utils_64.c, of which the former is built for PPC32, and the latter
PPC64's without PPC_STD_MMU.  Fix arch/powerpc/Kconfig to not select
ARCH_SUPPORTS_DEBUG_PAGEALLOC when CONFIG_PPC_STD_MMU_64 isn't defined,
i.e., for 64-bit book3e builds to use the generic __kernel_map_pages()
in mm/debug-pagealloc.c.

  LD      init/built-in.o
mm/built-in.o: In function `kernel_map_pages':
include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
include/linux/mm.h:2076: undefined reference to `.__kernel_map_pages'
Makefile:925: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
v2: corrected SUPPORTS_DEBUG_PAGEALLOC selection to enable
non-STD_MMU_64 builds to use the generic __kernel_map_pages().

note: depends on Joonsoo Kim's patch "mm/debug_pagealloc: fix build
failure on ppc and some other archs" published earlier in this
thread.

 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a2a168e..22b0940 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -256,6 +256,7 @@ config PPC_OF_PLATFORM_PCI
 	default n
 
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	depends on PPC32 || PPC_STD_MMU_64
 	def_bool y
 
 config ARCH_SUPPORTS_UPROBES
-- 
2.2.2

Thanks,

Kim
