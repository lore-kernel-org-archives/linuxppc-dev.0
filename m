Return-Path: <tnt@246tNt.com>
Received: from mailgate103.isp.belgacom.be (mailgate103.isp.belgacom.be
	[195.238.6.84]) by ozlabs.org (Postfix) with ESMTP id 6B059DDEC1
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 06:32:23 +1000 (EST)
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC dev ML <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/9] powerpc: exports rheap symbol to modules
Date: Sat, 12 May 2007 22:31:49 +0200
Message-Id: <11790019223299-git-send-email-tnt@246tNt.com>
In-Reply-To: <11790019171838-git-send-email-tnt@246tNt.com>
References: <11790019171838-git-send-email-tnt@246tNt.com>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Theses can be useful in modules too. So we export them.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/lib/rheap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index b2f6dcc..7c5968c 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 
@@ -724,3 +725,19 @@ void rh_dump_blk(rh_info_t * info, rh_block_t * blk)
 	       "blk @0x%p: 0x%lx-0x%lx (%u)\n",
 	       blk, blk->start, blk->start + blk->size, blk->size);
 }
+
+
+EXPORT_SYMBOL(rh_create);
+EXPORT_SYMBOL(rh_destroy);
+EXPORT_SYMBOL(rh_init);
+EXPORT_SYMBOL(rh_attach_region);
+EXPORT_SYMBOL(rh_detach_region);
+EXPORT_SYMBOL(rh_alloc_align);
+EXPORT_SYMBOL(rh_alloc);
+EXPORT_SYMBOL(rh_alloc_fixed);
+EXPORT_SYMBOL(rh_free);
+EXPORT_SYMBOL(rh_get_stats);
+EXPORT_SYMBOL(rh_set_owner);
+EXPORT_SYMBOL(rh_dump);
+EXPORT_SYMBOL(rh_dump_blk);
+
-- 
1.5.1.2
