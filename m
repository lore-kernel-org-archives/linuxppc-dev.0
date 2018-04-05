Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GwdN3KG8zF1pk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 18:16:08 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id s10-v6so16122368plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 01:16:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.ibm.com>
Subject: [PATCH 3/6] powerpc/powernv: OPAL platform standardise OPAL_BUSY loops
Date: Thu,  5 Apr 2018 18:15:44 +1000
Message-Id: <20180405081547.13266-4-npiggin@gmail.com>
In-Reply-To: <20180405081547.13266-1-npiggin@gmail.com>
References: <20180405081547.13266-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert to using the standard delay poll/delay form.

The platform code:

- Used delay when called from a schedule()able context.
- Did not previously delay or sleep in the OPAL_BUSY_EVENT case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c  |  8 +++++---
 arch/powerpc/platforms/powernv/setup.c | 16 ++++++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index c15182765ff5..fb13bcabe609 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -896,10 +896,12 @@ void opal_shutdown(void)
 	 */
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_sync_host_reboot();
-		if (rc == OPAL_BUSY)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else
-			mdelay(10);
+		} else {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 
 	/* Unregister memory dump region */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 092715b9674b..6ea79d906784 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -187,10 +187,12 @@ static void  __noreturn pnv_restart(char *cmd)
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_cec_reboot();
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else
-			mdelay(10);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 	for (;;)
 		opal_poll_events(NULL);
@@ -204,10 +206,12 @@ static void __noreturn pnv_power_off(void)
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_cec_power_down(0);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else
-			mdelay(10);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 	for (;;)
 		opal_poll_events(NULL);
-- 
2.16.3
