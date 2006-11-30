Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6013467B9F
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 11:44:13 +1100 (EST)
Date: Thu, 30 Nov 2006 11:44:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] Allow xmon to build on legacy iSeries
Message-Id: <20061130114409.994a661e.sfr@canb.auug.org.au>
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

xmon still does not run on iSeries, but this allows us to build a combined
kernel that includes it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig.debug |    2 +-
 arch/powerpc/xmon/xmon.c   |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index ff16063..5cce904 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -77,7 +77,7 @@ config KGDB_CONSOLE
 
 config XMON
 	bool "Include xmon kernel debugger"
-	depends on DEBUGGER && !PPC_ISERIES
+	depends on DEBUGGER
 	help
 	  Include in-kernel hooks for the xmon kernel monitor/debugger.
 	  Unless you are intending to debug the kernel, say N here.
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 1cf90c8..767b242 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -44,6 +44,7 @@
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
 #include <asm/paca.h>
+#include <asm/iseries/it_lp_reg_save.h>
 #endif
 
 #include "nonstdio.h"
@@ -2580,6 +2581,10 @@ void dump_segments(void)
 
 void xmon_init(int enable)
 {
+#ifdef CONFIG_PPC_ISERIES
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return;
+#endif
 	if (enable) {
 		__debugger = xmon;
 		__debugger_ipi = xmon_ipi;
@@ -2617,6 +2622,10 @@ static struct sysrq_key_op sysrq_xmon_op =
 
 static int __init setup_xmon_sysrq(void)
 {
+#ifdef CONFIG_PPC_ISERIES
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+#endif
 	register_sysrq_key('x', &sysrq_xmon_op);
 	return 0;
 }
-- 
1.4.4.1
