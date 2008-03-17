Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79183DDED1
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 21:05:24 +1100 (EST)
Date: Mon, 17 Mar 2008 19:05:18 +0900 (JST)
Message-Id: <20080317.190518.-1300513271.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 11/11] hvcbeat: fix buffer manipulation
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a potential bug at drivers/char/hvc_beat.c.
 - hvc_put_term_char routine will decrement "rest" variable twice,
   and forget to advance "buf" pointer by "nlen" bytes.
This bug was not hit because the output handler in
drivers/char/hvc_console.c splits given output into 16 bytes
at maximum.

This patch is one of a series that I posted on Mar.14, "celleb:
patchset for 2.6.26 (take2)". I send this again because it
would be lost.

Reported-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/hvc_beat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/char/hvc_beat.c
===================================================================
--- a/drivers/char/hvc_beat.c	2008-03-10 14:11:57.000000000 +0900
+++ b/drivers/char/hvc_beat.c	2008-03-10 14:13:40.000000000 +0900
@@ -78,8 +78,8 @@
 	for (rest = cnt; rest > 0; rest -= nlen) {
 		nlen = (rest > 16) ? 16 : rest;
 		memcpy(kb, buf, nlen);
-		beat_put_term_char(vtermno, rest, kb[0], kb[1]);
-		rest -= nlen;
+		beat_put_term_char(vtermno, nlen, kb[0], kb[1]);
+		buf += nlen;
 	}
 	return cnt;
 }
