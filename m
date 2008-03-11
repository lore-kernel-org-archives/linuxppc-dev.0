Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 1D730DDF71
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 10:48:49 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <d402bc66886e9592503825b1151db65bcb534e3b.1205279152.git.tony@bakeyournoodle.com>
In-Reply-To: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
References: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 3/4] Fix drivers/macintosh/mediabay.c when !CONFIG_ADB_PMU.
Date: Wed, 12 Mar 2008 10:48:48 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When building drivers/macintosh/mediabay.c if CONFIG_ADB_PMU isn't defined we
get:
drivers/built-in.o: In function `media_bay_step':
mediabay.c:(.text+0x92b84): undefined reference to `pmu_suspend'
mediabay.c:(.text+0x92c08): undefined reference to `pmu_resume'

Create empty place holders in that scenario.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 include/linux/pmu.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index b02b57c..cafe98d 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -147,8 +147,15 @@ extern void pmu_wait_complete(struct adb_request *req);
 /* For use before switching interrupts off for a long time;
  * warning: not stackable
  */
+#if defined(CONFIG_ADB_PMU)
 extern void pmu_suspend(void);
 extern void pmu_resume(void);
+#else
+static inline void pmu_suspend(void)
+{}
+static inline void pmu_resume(void)
+{}
+#endif
 
 extern void pmu_enable_irled(int on);
 
-- 
1.5.4.3
