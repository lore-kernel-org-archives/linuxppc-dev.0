Return-Path: <bywxiaobai@163.com>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by lists.ozlabs.org (Postfix) with ESMTP id 2E5FD1A0048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 00:17:29 +1000 (AEST)
From: Yaowei Bai <bywxiaobai@163.com>
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net,
 k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be,
 lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sound/core/seq: make prioq_match return bool
Date: Mon, 21 Sep 2015 21:57:14 +0800
Message-Id: <1442843834-4648-4-git-send-email-bywxiaobai@163.com>
In-Reply-To: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
References: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch makes prioq_match return bool due to this particular
function only using either one or zero as its return value.

No functional change.

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 sound/core/seq/seq_prioq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/seq/seq_prioq.c b/sound/core/seq/seq_prioq.c
index bc1c848..aebae09 100644
--- a/sound/core/seq/seq_prioq.c
+++ b/sound/core/seq/seq_prioq.c
@@ -264,26 +264,26 @@ struct snd_seq_event_cell *snd_seq_prioq_cell_peek(struct snd_seq_prioq * f)
 }
 
 
-static inline int prioq_match(struct snd_seq_event_cell *cell,
+static inline bool prioq_match(struct snd_seq_event_cell *cell,
 			      int client, int timestamp)
 {
 	if (cell->event.source.client == client ||
 	    cell->event.dest.client == client)
-		return 1;
+		return true;
 	if (!timestamp)
-		return 0;
+		return false;
 	switch (cell->event.flags & SNDRV_SEQ_TIME_STAMP_MASK) {
 	case SNDRV_SEQ_TIME_STAMP_TICK:
 		if (cell->event.time.tick)
-			return 1;
+			return true;
 		break;
 	case SNDRV_SEQ_TIME_STAMP_REAL:
 		if (cell->event.time.time.tv_sec ||
 		    cell->event.time.time.tv_nsec)
-			return 1;
+			return true;
 		break;
 	}
-	return 0;
+	return false;
 }
 
 /* remove cells for left client */
-- 
1.9.1
