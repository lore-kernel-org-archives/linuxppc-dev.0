Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh0h32hRkzDqBf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 04:30:43 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 63so937763pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 11:30:42 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, gregkh@linuxfoundation.org, jslaby@suse.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] tty: hvcs: make ktermios const
Date: Tue, 29 Aug 2017 00:00:31 +0530
Message-Id: <1503945031-28202-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make this const as it is not modified anywhere.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/tty/hvc/hvcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 79cc5be..40adf86 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -189,7 +189,7 @@
  * that will cause echoing or we'll go into recursive loop echoing chars back
  * and forth with the console drivers.
  */
-static struct ktermios hvcs_tty_termios = {
+static const struct ktermios hvcs_tty_termios = {
 	.c_iflag = IGNBRK | IGNPAR,
 	.c_oflag = OPOST,
 	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
-- 
1.9.1
