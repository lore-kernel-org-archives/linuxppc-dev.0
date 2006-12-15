Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 53D6367BEA
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 15:41:31 +1100 (EST)
Date: Fri, 15 Dec 2006 15:41:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix viotape init
Message-Id: <20061215154143.955125c2.sfr@canb.auug.org.au>
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

Only initialise viotape on legacy iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/viotape.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index 73c78bf..0c5b7d7 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -49,7 +49,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
-
+#include <asm/firmware.h>
 #include <asm/vio.h>
 #include <asm/iseries/vio.h>
 #include <asm/iseries/hv_lp_event.h>
@@ -997,6 +997,9 @@ int __init viotap_init(void)
 	int ret;
 	struct proc_dir_entry *e;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
 	op_struct_list = NULL;
 	if ((ret = add_op_structs(VIOTAPE_MAXREQ)) < 0) {
 		printk(VIOTAPE_KERN_WARN "couldn't allocate op structs\n");
-- 
1.4.4.2
