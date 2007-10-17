Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 6DFC9DDE32
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:30:26 +1000 (EST)
Date: Wed, 17 Oct 2007 14:30:25 +1000
To: Paul Mackerras <paulus@samba.org>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Fix vmemmap warning in init_64..c
Message-ID: <20071017043024.GE9814@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the right printk format to silence the following warning.

  CC      arch/powerpc/mm/init_64.o
arch/powerpc/mm/init_64.c: In function 'vmemmap_populate':
arch/powerpc/mm/init_64.c:243: warning: format '%p' expects type 'void *', but argument 4 has type 'long unsigned int'

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---

Also a whitespace fix while I'm there.

 arch/powerpc/mm/init_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 702d884..6720b1c 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -240,7 +240,7 @@ int __meminit vmemmap_populate(struct page *start_page,
 			return -ENOMEM;
 
 		printk(KERN_WARNING "vmemmap %08lx allocated at %p, "
-					"physical %p.\n", start, p, __pa(p));
+		                    "physical %08lx.\n", start, p, __pa(p));
 
 		mapped = htab_bolt_mapping(start, start + page_size,
 					__pa(p), mode_rw, mmu_linear_psize,
-- 
1.5.3.4

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
