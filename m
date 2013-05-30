Return-Path: <lig.fnst@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id A3CF52C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 17:08:10 +1000 (EST)
From: liguang <lig.fnst@cn.fujitsu.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/pseries: use 'true' instead of '1' for
 orderly_poweroff
Date: Thu, 30 May 2013 15:07:31 +0800
Message-Id: <1369897651-23770-1-git-send-email-lig.fnst@cn.fujitsu.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 liguang <lig.fnst@cn.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

orderly_poweroff is expecting a bool parameter, so
use 'ture' instead '1'

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 arch/powerpc/platforms/pseries/ras.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index c4dfccd..79b9502 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -83,7 +83,7 @@ static void handle_system_shutdown(char event_modifier)
 	switch (event_modifier) {
 	case EPOW_SHUTDOWN_NORMAL:
 		pr_emerg("Firmware initiated power off");
-		orderly_poweroff(1);
+		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_ON_UPS:
@@ -95,13 +95,13 @@ static void handle_system_shutdown(char event_modifier)
 		pr_emerg("Loss of system critical functions reported by "
 			"firmware");
 		pr_emerg("Check RTAS error log for details");
-		orderly_poweroff(1);
+		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_AMBIENT_TEMPERATURE_TOO_HIGH:
 		pr_emerg("Ambient temperature too high reported by firmware");
 		pr_emerg("Check RTAS error log for details");
-		orderly_poweroff(1);
+		orderly_poweroff(true);
 		break;
 
 	default:
@@ -162,7 +162,7 @@ void rtas_parse_epow_errlog(struct rtas_error_log *log)
 
 	case EPOW_SYSTEM_HALT:
 		pr_emerg("Firmware initiated power off");
-		orderly_poweroff(1);
+		orderly_poweroff(ture);
 		break;
 
 	case EPOW_MAIN_ENCLOSURE:
-- 
1.7.2.5
