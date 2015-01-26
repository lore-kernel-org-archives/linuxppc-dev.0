Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BA0B1A05E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 06:27:51 +1100 (AEDT)
Date: Mon, 26 Jan 2015 13:22:22 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3] powerpc/mm: fix undefined reference to
 `.__kernel_map_pages' on FSL PPC64
Message-ID: <20150126132222.6477257be204a3332601ef11@freescale.com>
In-Reply-To: <1421987091.24984.13.camel@ellerman.id.au>
References: <20150120140200.aa7ba0eb28d95e456972e178@freescale.com>
 <20150120230150.GA14475@cloud>
 <20150120160738.edfe64806cc8b943beb1dfa0@linux-foundation.org>
 <CAC5umyieZn7ppXkKb45O=C=BF+iv6R_A1Dwfhro=cBJzFeovrA@mail.gmail.com>
 <20150122014550.GA21444@js1304-P5Q-DELUXE>
 <20150122144147.019eedc41f189eac44c3c4cd@freescale.com>
 <CAC5umyiF52cykH2_5TD0yzXb+842gywpe-+XZHEwmrDe0nYCPw@mail.gmail.com>
 <20150122212017.4b7032d52a6c75c06d5b4728@freescale.com>
 <1421987091.24984.13.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
 Rik van Riel <riel@redhat.com>, josh@joshtriplett.org,
 Minchan Kim <minchan@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Johannes Weiner <hannes@cmpxchg.org>,
 Scott Wood <scottwood@freescale.com>, Sasha Levin <sasha.levin@oracle.com>,
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

arch/powerpc has __kernel_map_pages implementations in mm/pgtable_32.c, and
mm/hash_utils_64.c, of which the former is built for PPC32, and the latter
for PPC64 machines with PPC_STD_MMU.  Fix arch/powerpc/Kconfig to not select
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
v3:
- fix wording for hash_utils_64.c implementation pointed out by
Michael Ellerman
- changed designation from 'mm:' to 'powerpc/mm:', as I think this
now belongs in ppc-land

v2:
- corrected SUPPORTS_DEBUG_PAGEALLOC selection to enable
non-STD_MMU_64 builds to use the generic __kernel_map_pages().

depends on:
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date: Thu, 22 Jan 2015 10:28:58 +0900
Subject: [PATCH] mm/debug_pagealloc: fix build failure on ppc and some other archs

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
