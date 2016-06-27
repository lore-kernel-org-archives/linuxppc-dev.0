Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSp22Fl2zDqnM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:25:46 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSp14bPhz9t1M
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:25:45 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/17] powerpc/powernv: Add XICS emulation APIs
Date: Mon, 27 Jun 2016 22:25:17 +1000
Message-Id: <1467030333-31435-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL provides an emulated XICS interrupt controller to
use as a fallback on newer processors that don't have a
XICS. It's meant as a way to provide backward compatibility
with future processors. Add the corresponding interfaces.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal-api.h            | 6 +++++-
 arch/powerpc/include/asm/opal.h                | 5 +++++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 9bb8ddf..4b4b559 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -158,7 +158,11 @@
 #define OPAL_LEDS_SET_INDICATOR			115
 #define OPAL_CEC_REBOOT2			116
 #define OPAL_CONSOLE_FLUSH			117
-#define OPAL_LAST				117
+#define OPAL_INT_GET_XIRR			122
+#define	OPAL_INT_SET_CPPR			123
+#define OPAL_INT_EOI				124
+#define OPAL_INT_SET_MFRR			125
+#define OPAL_LAST				125
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9d86c66..6ccb847 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -210,6 +210,11 @@ int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
 int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
 		uint64_t token);
 
+int64_t opal_int_get_xirr(uint32_t *out_xirr, bool just_poll);
+int64_t opal_int_set_cppr(uint8_t cppr);
+int64_t opal_int_eoi(uint32_t xirr);
+int64_t opal_int_set_mfrr(uint32_t cpu, uint8_t mfrr);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e45b88a..3854343 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -302,3 +302,7 @@ OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
 OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
 OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
 OPAL_CALL(opal_console_flush,			OPAL_CONSOLE_FLUSH);
+OPAL_CALL(opal_int_get_xirr,			OPAL_INT_GET_XIRR);
+OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
+OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
+OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
-- 
2.7.4
