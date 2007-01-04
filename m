Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 51E9ADDE31
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 17:05:10 +1100 (EST)
Date: Thu, 4 Jan 2007 17:05:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix viopath initialisation
Message-Id: <20070104170513.14e52b44.sfr@canb.auug.org.au>
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

/proc/iSeries/config should only be created if we are running on legacy
iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/viopath.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/viopath.c b/arch/powerpc/platforms/iseries/viopath.c
index 84e7ee2..a6799ed 100644
--- a/arch/powerpc/platforms/iseries/viopath.c
+++ b/arch/powerpc/platforms/iseries/viopath.c
@@ -42,6 +42,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/prom.h>
+#include <asm/firmware.h>
 #include <asm/iseries/hv_types.h>
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/hv_lp_config.h>
@@ -183,6 +184,9 @@ static int __init vio_proc_init(void)
 {
 	struct proc_dir_entry *e;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+
 	e = create_proc_entry("iSeries/config", 0, NULL);
 	if (e)
 		e->proc_fops = &proc_viopath_operations;
-- 
1.4.4.3
