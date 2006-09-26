Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E0F1867B59
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 13:42:43 +1000 (EST)
Date: Tue, 26 Sep 2006 13:35:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/7] [POWERPC] The two vio HVC backends clash
Message-Id: <20060926133548.43afd711.sfr@canb.auug.org.au>
In-Reply-To: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
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

Make sure only one of them actually registered as a driver.

Also, remove cast from get_property().

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvc_iseries.c |    8 ++++++--
 drivers/char/hvc_vio.c     |    4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index 4747729..ea36201 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -29,6 +29,7 @@ #include <linux/console.h>
 #include <asm/hvconsole.h>
 #include <asm/vio.h>
 #include <asm/prom.h>
+#include <asm/firmware.h>
 #include <asm/iseries/vio.h>
 #include <asm/iseries/hv_call.h>
 #include <asm/iseries/hv_lp_config.h>
@@ -493,6 +494,9 @@ static int hvc_vio_init(void)
 	atomic_t wait_flag;
 	int rc;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -EIO;
+
 	/* +2 for fudge */
 	rc = viopath_open(HvLpConfig_getPrimaryLpIndex(),
 			viomajorsubtype_chario, VIOCHAR_WINDOW + 2);
@@ -567,7 +571,7 @@ static int hvc_find_vtys(void)
 
 	for (vty = of_find_node_by_name(NULL, "vty"); vty != NULL;
 			vty = of_find_node_by_name(vty, "vty")) {
-		uint32_t *vtermno;
+		const uint32_t *vtermno;
 
 		/* We have statically defined space for only a certain number
 		 * of console adapters.
@@ -576,7 +580,7 @@ static int hvc_find_vtys(void)
 				(num_found >= VTTY_PORTS))
 			break;
 
-		vtermno = (uint32_t *)get_property(vty, "reg", NULL);
+		vtermno = get_property(vty, "reg", NULL);
 		if (!vtermno)
 			continue;
 
diff --git a/drivers/char/hvc_vio.c b/drivers/char/hvc_vio.c
index cc95941..f9c0084 100644
--- a/drivers/char/hvc_vio.c
+++ b/drivers/char/hvc_vio.c
@@ -35,6 +35,7 @@ #include <linux/init.h>
 #include <asm/hvconsole.h>
 #include <asm/vio.h>
 #include <asm/prom.h>
+#include <asm/firmware.h>
 
 #include "hvc_console.h"
 
@@ -120,6 +121,9 @@ static int hvc_vio_init(void)
 {
 	int rc;
 
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return -EIO;
+
 	/* Register as a vio device to receive callbacks */
 	rc = vio_register_driver(&hvc_vio_driver);
 
-- 
1.4.2.1
