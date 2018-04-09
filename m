Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KK121XZBzDr3t
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:41:26 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id a2so5234331pff.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:41:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 6/6] drivers/tty/hvc: remove unexplained "just in case" spin
 delay
Date: Mon,  9 Apr 2018 15:40:56 +1000
Message-Id: <20180409054056.27292-7-npiggin@gmail.com>
In-Reply-To: <20180409054056.27292-1-npiggin@gmail.com>
References: <20180409054056.27292-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This delay was in the very first OPAL console commit 6.5 years ago.
The firmware console has hardened sufficiently to remove it.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_opal.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index e151cfacf2a7..436b98258e60 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -307,14 +307,8 @@ static int udbg_opal_getc(void)
 	int ch;
 	for (;;) {
 		ch = udbg_opal_getc_poll();
-		if (ch == -1) {
-			/* This shouldn't be needed...but... */
-			volatile unsigned long delay;
-			for (delay=0; delay < 2000000; delay++)
-				;
-		} else {
+		if (ch != -1)
 			return ch;
-		}
 	}
 }
 
-- 
2.17.0
