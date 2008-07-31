Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 7EB53DDEE4
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:51:44 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <f8882848269193ffb7259de706f097d8f2fe3882.1217476198.git.tony@bakeyournoodle.com>
In-Reply-To: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 7/8] Guard from_rtc_time() in
	arch/powerpc/platforms/powermac/time.c
Date: Thu, 31 Jul 2008 13:51:43 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

from_rtc_time() is only called when one of 3 CONFIG options are defined.
Guard the declaration appropriately.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/powermac/time.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index bbbefd6..59eb840 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -93,11 +93,14 @@ static void to_rtc_time(unsigned long now, struct rtc_time *tm)
 }
 #endif
 
+#if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU) || \
+    defined(CONFIG_PMAC_SMU)
 static unsigned long from_rtc_time(struct rtc_time *tm)
 {
 	return mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
 		      tm->tm_hour, tm->tm_min, tm->tm_sec);
 }
+#endif
 
 #ifdef CONFIG_ADB_CUDA
 static unsigned long cuda_get_time(void)
-- 
1.5.6.3
