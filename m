Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3B141A2A8D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 15:55:01 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B24AD1402C7
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:55:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 22 Jul 2015 15:55:01 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7C3843578054
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:54:58 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6M5snYx983542
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:54:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6M5sPF8020101
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:54:25 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, benh@kernel.crashing.org
Subject: [RFC PATCH] powerpc/kexec: Wait 1s for secondaries to enter OPAL
Date: Wed, 22 Jul 2015 15:54:29 +1000
Message-Id: <1437544469-20028-1-git-send-email-sam.mj@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Always include a timeout when waiting for secondary cpus to enter OPAL
in the kexec path, rather than only when crashing.

Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 59076db..f916601 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -195,7 +195,7 @@ static void pnv_kexec_wait_secondaries_down(void)
 
 	for_each_online_cpu(i) {
 		uint8_t status;
-		int64_t rc;
+		int64_t rc, timeout = 1000;
 
 		if (i == my_cpu)
 			continue;
@@ -212,6 +212,18 @@ static void pnv_kexec_wait_secondaries_down(void)
 				       i, paca[i].hw_cpu_id);
 				notified = i;
 			}
+
+			/*
+			 * On crash secondaries might be unreachable or hung,
+			 * so timeout if we've waited too long
+			 * */
+			mdelay(1);
+			if (timeout-- == 0) {
+				printk(KERN_ERR "kexec: timed out waiting for "
+				       "cpu %d (physical %d) to enter OPAL\n",
+				       i, paca[i].hw_cpu_id);
+				break;
+			}
 		}
 	}
 }
@@ -233,13 +245,6 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 
 		/* Return the CPU to OPAL */
 		opal_return_cpu();
-	} else if (crash_shutdown) {
-		/*
-		 * On crash, we don't wait for secondaries to go
-		 * down as they might be unreachable or hung, so
-		 * instead we just wait a bit and move on.
-		 */
-		mdelay(1);
 	} else {
 		/* Primary waits for the secondaries to have reached OPAL */
 		pnv_kexec_wait_secondaries_down();
-- 
2.4.6
