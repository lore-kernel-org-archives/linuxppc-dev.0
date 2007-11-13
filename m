Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 376BCDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 23:39:47 +1100 (EST)
Subject: [PATCH] powermac: fix warning in time.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Nov 2007 19:17:20 +0100
Message-Id: <1194977840.4299.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/powermac/time.c:88: warning: =E2=80=98to_rtc_time=E2=
=80=99 defined but not used

Somehow this warning has always bothered me. This patch fixes it by
making the relevant code depend on the users.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 arch/powerpc/platforms/powermac/time.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/time.c	2007-11-13 19=
:07:32.243563123 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/time.c	2007-11-13 19:08:2=
7.154561404 +0100
@@ -84,12 +84,14 @@ long __init pmac_time_init(void)
 	return delta;
 }
=20
+#if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU)
 static void to_rtc_time(unsigned long now, struct rtc_time *tm)
 {
 	to_tm(now, tm);
 	tm->tm_year -=3D 1900;
 	tm->tm_mon -=3D 1;
 }
+#endif
=20
 static unsigned long from_rtc_time(struct rtc_time *tm)
 {
