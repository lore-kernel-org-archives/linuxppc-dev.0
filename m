Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 6EF04DDF7E
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 10:48:49 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <5a9d5c6fb764c94218a47aa8e6bb49335ca8da83.1205279152.git.tony@bakeyournoodle.com>
In-Reply-To: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
References: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 2/4] Fix build of modular drivers/macintosh/apm_emu.c
Date: Wed, 12 Mar 2008 10:48:48 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

apm_emu.c needs access to pmu_batteries[] and friends.  If CONFIG_SUSPEND isn't
defined these symbols aren't exported and the build fails with:
  Building modules, stage 2.
ERROR: "pmu_batteries" [drivers/macintosh/apm_emu.ko] undefined!
ERROR: "pmu_battery_count" [drivers/macintosh/apm_emu.ko] undefined!
ERROR: "pmu_power_flags" [drivers/macintosh/apm_emu.ko] undefined!

Fix that.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 drivers/macintosh/via-pmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index ebec663..0170f55 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2528,10 +2528,10 @@ EXPORT_SYMBOL(pmu_wait_complete);
 EXPORT_SYMBOL(pmu_suspend);
 EXPORT_SYMBOL(pmu_resume);
 EXPORT_SYMBOL(pmu_unlock);
-#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
+#if defined(CONFIG_PPC32)
 EXPORT_SYMBOL(pmu_enable_irled);
 EXPORT_SYMBOL(pmu_battery_count);
 EXPORT_SYMBOL(pmu_batteries);
 EXPORT_SYMBOL(pmu_power_flags);
-#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
+#endif /* CONFIG_PPC32 */
 
-- 
1.5.4.3
