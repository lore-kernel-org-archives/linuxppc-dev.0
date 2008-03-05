Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72B9BDDECA
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 19:42:23 +1100 (EST)
Date: Wed, 05 Mar 2008 17:41:54 +0900 (JST)
Message-Id: <20080305.174154.660275727.kouish@swc.toshiba.co.jp>
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

Reported-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---
 drivers/char/hvc_beat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/char/hvc_beat.c
===================================================================
--- a/drivers/char/hvc_beat.c	2008-03-03 23:49:18.000000000 +0900
+++ b/drivers/char/hvc_beat.c	2008-03-04 15:14:35.000000000 +0900
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
