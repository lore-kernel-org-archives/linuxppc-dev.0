Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 24/39] powerpc/powernv: Fix endian issues in OPAL RTC driver
Date: Mon, 23 Sep 2013 12:04:58 +1000
Message-Id: <1379901913-5945-25-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal-rtc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index 2aa7641..dbfdba3 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -48,6 +48,8 @@ unsigned long __init opal_get_boot_time(void)
 	}
 	if (rc != OPAL_SUCCESS)
 		return 0;
+	y_m_d = be32_to_cpu(y_m_d);
+	h_m_s_ms = be64_to_cpu(h_m_s_ms);
 	opal_to_tm(y_m_d, h_m_s_ms, &tm);
 	return mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 		      tm.tm_hour, tm.tm_min, tm.tm_sec);
@@ -68,6 +70,8 @@ void opal_get_rtc_time(struct rtc_time *tm)
 	}
 	if (rc != OPAL_SUCCESS)
 		return;
+	y_m_d = be32_to_cpu(y_m_d);
+	h_m_s_ms = be64_to_cpu(h_m_s_ms);
 	opal_to_tm(y_m_d, h_m_s_ms, tm);
 }
 
@@ -86,6 +90,9 @@ int opal_set_rtc_time(struct rtc_time *tm)
 	h_m_s_ms |= ((u64)bin2bcd(tm->tm_min)) << 48;
 	h_m_s_ms |= ((u64)bin2bcd(tm->tm_sec)) << 40;
 
+	y_m_d = cpu_to_be32(y_m_d);
+	h_m_s_ms = cpu_to_be64(h_m_s_ms);
+
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
-- 
1.8.1.2
