Return-Path: <mopsfelder@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbyF86lRDzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 23:26:36 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id v195so1175906qka.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 06:26:36 -0700 (PDT)
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@iguana.be>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: [PATCH v2] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS
 dependencies
Date: Mon, 29 May 2017 10:26:28 -0300
Message-Id: <20170529132628.10803-1-mopsfelder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

drivers/watchdog/wdrtas.c uses symbols defined in arch/powerpc/kernel/rtas.c,
which are exported iff CONFIG_PPC_RTAS is selected. Building wdrtas.c without
setting CONFIG_PPC_RTAS throws the following errors:

    ERROR: ".rtas_token" [drivers/watchdog/wdrtas.ko] undefined!
    ERROR: "rtas_data_buf" [drivers/watchdog/wdrtas.ko] undefined!
    ERROR: "rtas_data_buf_lock" [drivers/watchdog/wdrtas.ko] undefined!
    ERROR: ".rtas_get_sensor" [drivers/watchdog/wdrtas.ko] undefined!
    ERROR: ".rtas_call" [drivers/watchdog/wdrtas.ko] undefined!

This was identified during a randconfig build where CONFIG_WATCHDOG_RTAS=m and
CONFIG_PPC_RTAS was not set. Logs are here:

    http://kisskb.ellerman.id.au/kisskb/buildresult/12982152/

This patch fixes the issue by updating CONFIG_WATCHDOG_RTAS to depend on just
CONFIG_PPC_RTAS, removing COMPILE_TEST entirely.

Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8b9049d..e6e31a1 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1688,7 +1688,7 @@ config MEN_A21_WDT
 
 config WATCHDOG_RTAS
 	tristate "RTAS watchdog"
-	depends on PPC_RTAS || (PPC64 && COMPILE_TEST)
+	depends on PPC_RTAS
 	help
 	  This driver adds watchdog support for the RTAS watchdog.
 
-- 
2.9.4
