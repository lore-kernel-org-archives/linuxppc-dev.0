Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427KkP4HBTzF3Kw
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2018 15:39:41 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id d4-v6so8893143pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Sep 2018 22:39:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Matteo Croce <mcroce@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH v2 3/3] tty: hvc: hvc_write() fix break condition
Date: Sun,  9 Sep 2018 15:39:16 +1000
Message-Id: <20180909053916.14139-4-npiggin@gmail.com>
In-Reply-To: <20180909053916.14139-1-npiggin@gmail.com>
References: <20180909053916.14139-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 550ddadcc758 ("tty: hvc: hvc_write() may sleep") broke the
termination condition in case the driver stops accepting characters.
This can result in unnecessary polling of the busy driver.

Restore it by testing the hvc_push return code.

Tested-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index bacf9b73ec98..27284a2dcd2b 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -522,6 +522,8 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		return -EIO;
 
 	while (count > 0) {
+		int ret = 0;
+
 		spin_lock_irqsave(&hp->lock, flags);
 
 		rsize = hp->outbuf_size - hp->n_outbuf;
@@ -537,10 +539,13 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		}
 
 		if (hp->n_outbuf > 0)
-			hvc_push(hp);
+			ret = hvc_push(hp);
 
 		spin_unlock_irqrestore(&hp->lock, flags);
 
+		if (!ret)
+			break;
+
 		if (count) {
 			if (hp->n_outbuf > 0)
 				hvc_flush(hp);
-- 
2.18.0
