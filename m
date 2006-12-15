Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1B41967BEC
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 15:43:54 +1100 (EST)
Date: Fri, 15 Dec 2006 15:44:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix viocd init
Message-Id: <20061215154404.7e9e25e8.sfr@canb.auug.org.au>
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

Only initialise viocd on legacy iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/cdrom/viocd.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index 54ca931..93fbf84 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -47,6 +47,7 @@
 #include <asm/iseries/hv_types.h>
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/vio.h>
+#include <asm/firmware.h>
 
 #define VIOCD_DEVICE			"iseries/vcd"
 
@@ -748,6 +749,9 @@ static int __init viocd_init(void)
 	struct proc_dir_entry *e;
 	int ret = 0;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
 	if (viopath_hostLp == HvLpIndexInvalid) {
 		vio_set_hostlp();
 		/* If we don't have a host, bail out */
-- 
1.4.4.2
