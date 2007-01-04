Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 55126DDE29
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 17:03:11 +1100 (EST)
Date: Thu, 4 Jan 2007 17:03:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix proc/iSeries initialisation
Message-Id: <20070104170316.f36859d4.sfr@canb.auug.org.au>
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

These proc files should only be created if we are running on legacy
iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/proc.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/proc.c b/arch/powerpc/platforms/iseries/proc.c
index c241413..b54e371 100644
--- a/arch/powerpc/platforms/iseries/proc.c
+++ b/arch/powerpc/platforms/iseries/proc.c
@@ -24,6 +24,7 @@
 #include <asm/processor.h>
 #include <asm/time.h>
 #include <asm/lppaca.h>
+#include <asm/firmware.h>
 #include <asm/iseries/hv_call_xm.h>
 
 #include "processor_vpd.h"
@@ -31,7 +32,12 @@
 
 static int __init iseries_proc_create(void)
 {
-	struct proc_dir_entry *e = proc_mkdir("iSeries", 0);
+	struct proc_dir_entry *e;
+
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+
+	e = proc_mkdir("iSeries", 0);
 	if (!e)
 		return 1;
 
@@ -106,6 +112,9 @@ static int __init iseries_proc_init(void)
 {
 	struct proc_dir_entry *e;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+
 	e = create_proc_entry("iSeries/titanTod", S_IFREG|S_IRUGO, NULL);
 	if (e)
 		e->proc_fops = &proc_titantod_operations;
-- 
1.4.4.3
