Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 20044DDEFA
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:51:44 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <2c3573b405d98bf12ab2d2f0b6caff6eb6d97761.1217476198.git.tony@bakeyournoodle.com>
In-Reply-To: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 3/8] Silennce warning in arch/powerpc/mm/mem.c
Date: Thu, 31 Jul 2008 13:51:42 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Explicitly cast to unsigned long long, rather than u64.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/mm/mem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 702691c..1c93c25 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -311,7 +311,7 @@ void __init paging_init(void)
 #endif /* CONFIG_HIGHMEM */
 
 	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%lx\n",
-	       (u64)top_of_ram, total_ram);
+	       (unsigned long long)top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (long int)((top_of_ram - total_ram) >> 20));
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-- 
1.5.6.3
