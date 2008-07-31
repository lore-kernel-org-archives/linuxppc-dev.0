Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 15A6EDDEED
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:51:44 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 1/8] Guard linkstation_physmap_partitions.
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

linkstation_physmap_partitions is only used when CONFIG_MTD_PHYSMAP is
defined, so likewise guard the declaration.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/embedded6xx/linkstation.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index eb5d74e..bec68af 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -21,6 +21,7 @@
 
 #include "mpc10x.h"
 
+#ifdef CONFIG_MTD_PHYSMAP
 static struct mtd_partition linkstation_physmap_partitions[] = {
 	{
 		.name   = "mtd_firmimg",
@@ -53,6 +54,7 @@ static struct mtd_partition linkstation_physmap_partitions[] = {
 		.size   = 0x0f0000,
 	},
 };
+#endif /* CONFIG_MTD_PHYSMAP */
 
 static int __init linkstation_add_bridge(struct device_node *dev)
 {
-- 
1.5.6.3
