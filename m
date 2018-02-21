Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zmrfQ3lBYzF11b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 08:46:37 +1100 (AEDT)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] powerpc/time: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 22:46:33 +0100
Message-Id: <20180221214633.2012-1-alexandre.belloni@bootlin.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/powerpc/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index a32823dcd9a4..f7d96a68ecaa 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1234,7 +1234,7 @@ void calibrate_delay(void)
 static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 {
 	ppc_md.get_rtc_time(tm);
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
