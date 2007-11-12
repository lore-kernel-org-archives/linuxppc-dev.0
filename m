Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CE33CDDE2F
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 13:53:34 +1100 (EST)
Date: Mon, 12 Nov 2007 13:53:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Silence an annoying boot message
Message-Id: <20071112135339.9a01b115.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

vmemmap_populate will printk (with KERN_WARNING) for a lot of pages
if CONFIG_SPARSEMEM_VMEMMAP is enabled (at least it does on iSeries).
Turn it into a DEBUG message.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/init_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Without this patch, all the messages before this one are purged from the
console buffer.  Is this really a warning?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d9c82d3..ee0e0cc 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -239,7 +239,7 @@ int __meminit vmemmap_populate(struct page *start_page,
 		if (!p)
 			return -ENOMEM;
 
-		printk(KERN_WARNING "vmemmap %08lx allocated at %p, "
+		DBG(KERN_DEBUG "vmemmap %08lx allocated at %p, "
 		                    "physical %08lx.\n", start, p, __pa(p));
 
 		mapped = htab_bolt_mapping(start, start + page_size,
-- 
1.5.3.5
