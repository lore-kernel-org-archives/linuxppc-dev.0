Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powernv: Remove get/set_rtc_time when they are not present
Date: Fri, 29 Nov 2013 14:22:48 +1100
Message-ID: <16539.1385695368@ale.ozlabs.ibm.com>
Cc: michael@ellerman.id.au, Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we continue to poll get/set_rtc_time even when we know they
are not working.

This changes it so that if it fails at boot time we remove the ppc_md
get/set_rtc_time hooks so that we don't end up polling known broken
calls.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index 7d07c7e..b1885db 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -18,6 +18,7 @@
 
 #include <asm/opal.h>
 #include <asm/firmware.h>
+#include <asm/machdep.h>
 
 static void opal_to_tm(u32 y_m_d, u64 h_m_s_ms, struct rtc_time *tm)
 {
@@ -48,8 +49,11 @@ unsigned long __init opal_get_boot_time(void)
 		else
 			mdelay(10);
 	}
-	if (rc != OPAL_SUCCESS)
+	if (rc != OPAL_SUCCESS) {
+		ppc_md.get_rtc_time = NULL;
+		ppc_md.set_rtc_time = NULL;
 		return 0;
+	}
 	y_m_d = be32_to_cpu(__y_m_d);
 	h_m_s_ms = be64_to_cpu(__h_m_s_ms);
 	opal_to_tm(y_m_d, h_m_s_ms, &tm);
