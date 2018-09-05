Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4252hJ6r5VzF36T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:14:56 +1000 (AEST)
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so3385067pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 05:14:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Matteo Croce <mcroce@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH 1/3] tty: hvc: hvc_poll() fix read loop hang
Date: Wed,  5 Sep 2018 22:14:37 +1000
Message-Id: <20180905121439.23809-2-npiggin@gmail.com>
In-Reply-To: <20180905121439.23809-1-npiggin@gmail.com>
References: <20180905121439.23809-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop") causes
the virtio console to hang at times (e.g., if you paste a bunch of
characters to it.

The reason is that get_chars must return 0 before we can be sure the
driver will kick or poll input again, but this change only scheduled a
poll if get_chars had returned a full count. Change this to poll on
any > 0 count.

Fixes: ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop")
Reported-by: Matteo Croce <mcroce@redhat.com>
Reported-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a87bea..c917749708d2 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -717,10 +717,13 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 #endif /* CONFIG_MAGIC_SYSRQ */
 		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
-	if (n == count)
-		poll_mask |= HVC_POLL_READ;
 	read_total = n;
 
+	/*
+	 * Latency break, schedule another poll immediately.
+	 */
+	poll_mask |= HVC_POLL_READ;
+
  out:
 	/* Wakeup write queue if necessary */
 	if (hp->do_wakeup) {
-- 
2.18.0
