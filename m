Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A1DCDDEDC
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 20:06:14 +1000 (EST)
Date: Thu, 26 Jul 2007 19:06:08 +0900 (JST)
Message-Id: <20070726.190608.1649795822.kouish@swc.toshiba.co.jp>
Subject: [PATCH 4/4] init markings for hvc_beat
To: paulus@samba.org
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

Fix warnings about section mismatch.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/drivers/char/hvc_beat.c
===================================================================
--- linux-powerpc-git.orig/drivers/char/hvc_beat.c
+++ linux-powerpc-git/drivers/char/hvc_beat.c
@@ -97,7 +97,7 @@ static int hvc_beat_config(char *p)
 	return 0;
 }
 
-static int hvc_beat_console_init(void)
+static int __init hvc_beat_console_init(void)
 {
 	if (hvc_beat_useit && machine_is_compatible("Beat")) {
 		hvc_instantiate(0, 0, &hvc_beat_get_put_ops);
@@ -106,7 +106,7 @@ static int hvc_beat_console_init(void)
 }
 
 /* temp */
-static int hvc_beat_init(void)
+static int __init hvc_beat_init(void)
 {
 	struct hvc_struct *hp;
 
