Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 420dN9424zzF13F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:00:41 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/time: Calculate proper wday
Date: Wed, 29 Aug 2018 09:54:58 +0200
Message-Id: <20180829075458.10145-1-joakim.tjernlund@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

to_tm() hardcodes wday to -1 as "No-one uses the day of the week".
But recently rtc driver ds1307 does care and tries to correct wday.

Add wday calculation(stolen from rtc_time64_to_tm) to to_tm() to please ds1307.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 arch/powerpc/kernel/time.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index fe6f3a285455..f4a09ee01944 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1160,6 +1160,9 @@ void to_tm(int tim, struct rtc_time * tm)
 	day = tim / SECDAY;
 	hms = tim % SECDAY;
 
+	/* day of the week, 1970-01-01 was a Thursday */
+	tm->tm_wday = (day + 4) % 7;
+
 	/* Hours, minutes, seconds are easy */
 	tm->tm_hour = hms / 3600;
 	tm->tm_min = (hms % 3600) / 60;
@@ -1180,11 +1183,6 @@ void to_tm(int tim, struct rtc_time * tm)
 
 	/* Days are what is left over (+1) from all that. */
 	tm->tm_mday = day + 1;
-
-	/*
-	 * No-one uses the day of the week.
-	 */
-	tm->tm_wday = -1;
 }
 EXPORT_SYMBOL(to_tm);
 
-- 
2.16.4
