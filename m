Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSL51R0pzF2QF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:45 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c10so6920060pfi.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] tty: hvc: remove unexplained "just in case" spin delay
Date: Tue,  1 May 2018 00:55:52 +1000
Message-Id: <20180430145558.4308-10-npiggin@gmail.com>
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This delay was in the very first OPAL console commit 6.5 years ago,
and came from the vio hvc driver. The firmware console has hardened
sufficiently to remove it.

Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_opal.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 0a72f98ee082..786e76a1e06d 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -313,14 +313,8 @@ static int udbg_opal_getc(void)
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
