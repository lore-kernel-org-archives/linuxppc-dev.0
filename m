Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0717A67BFF
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 15:45:02 +1100 (EST)
Date: Fri, 15 Dec 2006 15:45:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix viocons init
Message-Id: <20061215154513.2d908bff.sfr@canb.auug.org.au>
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

Only initialise viocons on legacy iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/viocons.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/viocons.c b/drivers/char/viocons.c
index 6d2e314..d135fc7 100644
--- a/drivers/char/viocons.c
+++ b/drivers/char/viocons.c
@@ -42,6 +42,7 @@
 #include <linux/tty_flip.h>
 #include <linux/sysrq.h>
 
+#include <asm/firmware.h>
 #include <asm/iseries/vio.h>
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/hv_call_event.h>
@@ -1062,6 +1063,9 @@ static int __init viocons_init2(void)
 	atomic_t wait_flag;
 	int rc;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
 	/* +2 for fudge */
 	rc = viopath_open(HvLpConfig_getPrimaryLpIndex(),
 			viomajorsubtype_chario, VIOCHAR_WINDOW + 2);
@@ -1147,6 +1151,9 @@ static int __init viocons_init(void)
 {
 	int i;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
 	printk(VIOCONS_KERN_INFO "registering console\n");
 	for (i = 0; i < VTTY_PORTS; i++) {
 		port_info[i].lp = HvLpIndexInvalid;
-- 
1.4.4.2
