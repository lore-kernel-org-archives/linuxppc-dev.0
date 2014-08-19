Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D2AE1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 14:48:05 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/4] powerpc/powernv: Check OPAL RTC calls exists before using
Date: Tue, 19 Aug 2014 14:48:00 +1000
Message-Id: <1408423682-14297-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1408423682-14297-1-git-send-email-mikey@neuling.org>
References: <1408423682-14297-1-git-send-email-mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check that the OPAL_RTC_READ token exists before we use the OPAL RTC.

Refactors the code a little to merge error paths.

This avoids littering the OPAL console with:
  "OPAL: Called with bad token 3".

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/powernv/opal-rtc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index b1885db..499707d 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -42,6 +42,9 @@ unsigned long __init opal_get_boot_time(void)
 	__be64 __h_m_s_ms;
 	long rc = OPAL_BUSY;
 
+	if (!opal_check_token(OPAL_RTC_READ))
+		goto out;
+
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
@@ -49,16 +52,18 @@ unsigned long __init opal_get_boot_time(void)
 		else
 			mdelay(10);
 	}
-	if (rc != OPAL_SUCCESS) {
-		ppc_md.get_rtc_time = NULL;
-		ppc_md.set_rtc_time = NULL;
-		return 0;
-	}
+	if (rc != OPAL_SUCCESS)
+		goto out;
+
 	y_m_d = be32_to_cpu(__y_m_d);
 	h_m_s_ms = be64_to_cpu(__h_m_s_ms);
 	opal_to_tm(y_m_d, h_m_s_ms, &tm);
 	return mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 		      tm.tm_hour, tm.tm_min, tm.tm_sec);
+out:
+	ppc_md.get_rtc_time = NULL;
+	ppc_md.set_rtc_time = NULL;
+	return 0;
 }
 
 void opal_get_rtc_time(struct rtc_time *tm)
-- 
1.9.1
