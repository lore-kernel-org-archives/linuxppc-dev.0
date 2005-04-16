Return-Path: <juhl-lkml@dif.dk>
Received: from saerimmer.dif.dk (mail.dif.dk [193.138.115.101])
	by ozlabs.org (Postfix) with ESMTP id E80AF67A67
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Apr 2005 02:24:00 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by saerimmer.dif.dk (Postfix) with ESMTP id 7908DFFC6E
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Apr 2005 18:28:15 +0200 (CEST)
Received: from saerimmer.dif.dk ([127.0.0.1])
	by localhost (saerimmer [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 10887-10 for <linuxppc-dev@ozlabs.org>;
	Sat, 16 Apr 2005 18:28:13 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk
	[10.227.136.246])
	by saerimmer.dif.dk (Postfix) with ESMTP id 6F406FF423
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Apr 2005 18:28:12 +0200 (CEST)
Date: Sat, 16 Apr 2005 18:20:30 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Message-ID: <Pine.LNX.4.62.0504161801580.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@ozlabs.org,
	linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Joshua Thompson <funaho@jurai.org>
Subject: [PATCH] drivers/macintosh: Remove redundant NULL check before kfree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes a redundant NULL check before kfree() - kfree handles 
NULL pointers just fine so there's no need to check first.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/macintosh/adbhid.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


--- linux-2.6.12-rc2-mm3-orig/drivers/macintosh/adbhid.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/macintosh/adbhid.c	2005-04-16 18:00:10.000000000 +0200
@@ -806,8 +806,7 @@ adbhid_input_register(int id, int defaul
 static void adbhid_input_unregister(int id)
 {
 	input_unregister_device(&adbhid[id]->input);
-	if (adbhid[id]->keycode)
-		kfree(adbhid[id]->keycode);
+	kfree(adbhid[id]->keycode);
 	kfree(adbhid[id]);
 	adbhid[id] = NULL;
 }



-- 
Jesper Juhl

PS. Sorry about the long CC list, but I was unsure who to send this to.
Please CC me on replies.
