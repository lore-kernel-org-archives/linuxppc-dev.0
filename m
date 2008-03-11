Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 787A6DDF8C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 10:48:49 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 1/4] Ensure that pmu_sys_suspended exists in appropriate
	configs.
Date: Wed, 12 Mar 2008 10:48:48 +1100 (EST)
Cc: Guido Guenther <agx@sigxcpu.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pmu_sys_suspended is declared extern when:
	defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
but only defined when:
	defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
which is wrong.  Lets fix that.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 include/linux/pmu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index 4c5f653..b02b57c 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -192,7 +192,7 @@ extern unsigned int pmu_power_flags;
 extern void pmu_backlight_init(void);
 
 /* some code needs to know if the PMU was suspended for hibernation */
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 extern int pmu_sys_suspended;
 #else
 /* if power management is not configured it can't be suspended */
-- 
1.5.4.3
