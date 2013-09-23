Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 30/39] powerpc/powernv: Don't register exception handlers in
 little endian mode
Date: Mon, 23 Sep 2013 12:05:04 +1000
Message-Id: <1379901913-5945-31-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The powernv exception handlers are not ready to take exceptions
in little endian mode, so disable them.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index eb7bf3b..c2391bb 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -77,6 +77,7 @@ int __init early_init_dt_scan_opal(unsigned long node,
 
 static int __init opal_register_exception_handlers(void)
 {
+#ifdef __BIG_ENDIAN__
 	u64 glue;
 
 	if (!(powerpc_firmware_features & FW_FEATURE_OPAL))
@@ -94,6 +95,7 @@ static int __init opal_register_exception_handlers(void)
 					0, glue);
 	glue += 128;
 	opal_register_exception_handler(OPAL_SOFTPATCH_HANDLER, 0, glue);
+#endif
 
 	return 0;
 }
-- 
1.8.1.2
