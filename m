Return-Path: <jj@chaosbits.net>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by ozlabs.org (Postfix) with ESMTP id A4363B710E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Nov 2010 10:19:26 +1100 (EST)
Date: Tue, 9 Nov 2010 00:07:57 +0100 (CET)
From: Jesper Juhl <jj@chaosbits.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/17][trivial] powerpc: Remove unnecessary casts of void
	ptr returning alloc function return values
Message-ID: <alpine.LNX.2.00.1011082307330.23697@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, trivial@kernel.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The [vk][cmz]alloc(_node) family of functions return void pointers which
it's completely unnecessary/pointless to cast to other pointer types since
that happens implicitly.

This patch removes such casts from arch/powerpc/


Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 pgtable_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a87ead0..d1833ed 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -78,7 +78,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	/* pgdir take page or two with 4K pages and a page fraction otherwise */
 #ifndef CONFIG_PPC_4K_PAGES
-	ret = (pgd_t *)kzalloc(1 << PGDIR_ORDER, GFP_KERNEL);
+	ret = kzalloc(1 << PGDIR_ORDER, GFP_KERNEL);
 #else
 	ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO,
 			PGDIR_ORDER - PAGE_SHIFT);



-- 
Jesper Juhl <jj@chaosbits.net>             http://www.chaosbits.net/
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.
