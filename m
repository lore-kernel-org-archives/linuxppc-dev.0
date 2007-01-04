Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F4049DDE30
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 17:04:09 +1100 (EST)
Date: Thu, 4 Jan 2007 17:04:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix lpevents initialisation
Message-Id: <20070104170421.b751bff4.sfr@canb.auug.org.au>
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

/proc/iSeries/lpevents should only be created if we are running
on legacy iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/lpevents.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/lpevents.c b/arch/powerpc/platforms/iseries/lpevents.c
index e3e929e..c1f4502 100644
--- a/arch/powerpc/platforms/iseries/lpevents.c
+++ b/arch/powerpc/platforms/iseries/lpevents.c
@@ -17,6 +17,7 @@
 
 #include <asm/system.h>
 #include <asm/paca.h>
+#include <asm/firmware.h>
 #include <asm/iseries/it_lp_queue.h>
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/hv_call_event.h>
@@ -318,6 +319,9 @@ static int __init proc_lpevents_init(void)
 {
 	struct proc_dir_entry *e;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+
 	e = create_proc_entry("iSeries/lpevents", S_IFREG|S_IRUGO, NULL);
 	if (e)
 		e->proc_fops = &proc_lpevents_operations;
-- 
1.4.4.3
