Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3204467A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 11:52:05 +1000 (EST)
Date: Wed, 28 Jun 2006 11:51:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] update asm-powerpc/time.h
Message-Id: <20060628115141.47db50ae.sfr@canb.auug.org.au>
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

If we ever build a combined kernel including iSeries, then this will
be needed.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/time.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index 912118d..db8a57e 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -19,8 +19,9 @@ #include <linux/types.h>
 #include <linux/percpu.h>
 
 #include <asm/processor.h>
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_ISERIES
 #include <asm/paca.h>
+#include <asm/firmware.h>
 #include <asm/iseries/hv_call.h>
 #endif
 
@@ -178,7 +179,8 @@ #else
 #ifdef CONFIG_PPC_ISERIES
 	int cur_dec;
 
-	if (get_lppaca()->shared_proc) {
+	if (firmware_has_feature(FW_FEATURE_ISERIES) &&
+			get_lppaca()->shared_proc) {
 		get_lppaca()->virtual_decr = val;
 		cur_dec = get_dec();
 		if (cur_dec > val)
-- 
1.3.3.g16a4
