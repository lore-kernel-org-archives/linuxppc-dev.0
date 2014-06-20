Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB87B1A0366
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 05:45:14 +1000 (EST)
Received: by mail-lb0-f181.google.com with SMTP id p9so2602656lbv.40
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 12:45:09 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jiri Kosina <trivial@kernel.org>
Subject: [PATCH] trivial: drivers/macintosh/smu.c: Fix closing brace followed
 by if
Date: Fri, 20 Jun 2014 21:44:27 +0200
Message-Id: <1403293467-17521-1-git-send-email-linux@rasmusvillemoes.dk>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A closing brace followed by "if" is almost certainly a mistake. Maybe
"else if" was meant, but in this case it doesn't really matter.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/macintosh/smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 23b4a3b..4eab93a 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -1257,7 +1257,8 @@ static unsigned int smu_fpoll(struct file *file, poll_table *wait)
 		if (pp->busy && pp->cmd.status != 1)
 			mask |= POLLIN;
 		spin_unlock_irqrestore(&pp->lock, flags);
-	} if (pp->mode == smu_file_events) {
+	}
+	if (pp->mode == smu_file_events) {
 		/* Not yet implemented */
 	}
 	return mask;
-- 
1.9.2
