Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSLN37gRzF2QD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:57:00 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id l2-v6so6473241pgc.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:57:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] tty: hvc: hvc_write may sleep
Date: Tue,  1 May 2018 00:55:56 +1000
Message-Id: <20180430145558.4308-14-npiggin@gmail.com>
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

Rework the hvc_write loop to drop and re-take the spinlock on each
iteration, add a cond_resched. Don't bother with an initial hvc_push
initially, which makes the logic simpler -- just do a hvc_push on
each time around the loop.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 36 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 2abfc0b15fbb..6131d5084c42 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -493,23 +493,29 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 	if (hp->port.count <= 0)
 		return -EIO;
 
-	spin_lock_irqsave(&hp->lock, flags);
+	while (count > 0) {
+		spin_lock_irqsave(&hp->lock, flags);
 
-	/* Push pending writes */
-	if (hp->n_outbuf > 0)
-		hvc_push(hp);
-
-	while (count > 0 && (rsize = hp->outbuf_size - hp->n_outbuf) > 0) {
-		if (rsize > count)
-			rsize = count;
-		memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
-		count -= rsize;
-		buf += rsize;
-		hp->n_outbuf += rsize;
-		written += rsize;
-		hvc_push(hp);
+		rsize = hp->outbuf_size - hp->n_outbuf;
+
+		if (rsize) {
+			if (rsize > count)
+				rsize = count;
+			memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
+			count -= rsize;
+			buf += rsize;
+			hp->n_outbuf += rsize;
+			written += rsize;
+		}
+
+		if (hp->n_outbuf > 0)
+			hvc_push(hp);
+
+		spin_unlock_irqrestore(&hp->lock, flags);
+
+		if (count)
+			cond_resched();
 	}
-	spin_unlock_irqrestore(&hp->lock, flags);
 
 	/*
 	 * Racy, but harmless, kick thread if there is still pending data.
-- 
2.17.0
