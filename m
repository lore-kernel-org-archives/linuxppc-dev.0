Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9E23867BE5
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 15:39:57 +1100 (EST)
Date: Fri, 15 Dec 2006 15:40:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix viodasd init
Message-Id: <20061215154008.7484e444.sfr@canb.auug.org.au>
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

Don't initialise viodasd except on legacy iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/viodasd.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index e19ba4e..68592c3 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -49,6 +49,7 @@
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/vio.h>
+#include <asm/firmware.h>
 
 MODULE_DESCRIPTION("iSeries Virtual DASD");
 MODULE_AUTHOR("Dave Boutcher");
@@ -769,6 +770,11 @@ static int __init viodasd_init(void)
 {
 	int rc;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
+		rc = -ENODEV;
+		goto early_fail;
+	}
+
 	/* Try to open to our host lp */
 	if (viopath_hostLp == HvLpIndexInvalid)
 		vio_set_hostlp();
-- 
1.4.4.2
