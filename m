Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0452ADDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 16:09:01 +1100 (EST)
Date: Thu, 27 Mar 2008 16:08:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] htab_remove_mapping is only used by MEMORY_HOTPLUG
Message-Id: <20080327160857.a9dfdd78.sfr@canb.auug.org.au>
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

This eliminates a warning in builds that don't define
CONFIG_MEMORY_HOTPLUG.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/hash_utils_64.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index c2e5f61..96a5790 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -192,6 +192,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 	return ret < 0 ? ret : 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
 static void htab_remove_mapping(unsigned long vstart, unsigned long vend,
 		      int psize, int ssize)
 {
@@ -209,6 +210,7 @@ static void htab_remove_mapping(unsigned long vstart, unsigned long vend,
 	for (vaddr = vstart; vaddr < vend; vaddr += step)
 		ppc_md.hpte_removebolted(vaddr, psize, ssize);
 }
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 static int __init htab_dt_scan_seg_sizes(unsigned long node,
 					 const char *uname, int depth,
-- 
1.5.4.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
