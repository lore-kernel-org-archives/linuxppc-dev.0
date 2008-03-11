Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 7225ADDF86
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 10:48:49 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <4ea9ef2e0a35f100a99372bcbf0417220bc77bd3.1205279152.git.tony@bakeyournoodle.com>
In-Reply-To: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
References: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 4/4] Fix arch/powerpc/platforms/powermac/pic.c when
	!CONFIG_ADB_PMU.
Date: Wed, 12 Mar 2008 10:48:48 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When building arch/powerpc/platforms/powermac/pic.c when !CONFIG_ADB_PMU
we get the following warnings:
arch/powerpc/platforms/powermac/pic.c: In function 'pmacpic_find_viaint':
arch/powerpc/platforms/powermac/pic.c:623: warning: label 'not_found' defined but not used

Fix that.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/powermac/pic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 4073640..829b8b0 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -618,9 +618,9 @@ static int pmacpic_find_viaint(void)
 	if (np == NULL)
 		goto not_found;
 	viaint = irq_of_parse_and_map(np, 0);;
-#endif /* CONFIG_ADB_PMU */
 
 not_found:
+#endif /* CONFIG_ADB_PMU */
 	return viaint;
 }
 
-- 
1.5.4.3
