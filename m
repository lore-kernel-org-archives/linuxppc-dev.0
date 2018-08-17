Return-Path: <21cnbao@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sNcM4q6hzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 23:01:03 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id a4-v6so200751plm.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 06:01:03 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: leoyang.li@nxp.com, zw@zh-kernel.org, dan.j.williams@intel.com,
 vkoul@kernel.org, linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/3] dmaengine: fsldma: move spin_lock_bh to spin_lock in
 tasklet
Date: Fri, 17 Aug 2018 06:00:26 -0700
Message-Id: <1534510826-7603-1-git-send-email-21cnbao@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

as you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/dma/fsldma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1117b51..9d360a3 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -987,7 +987,7 @@ static void dma_do_tasklet(unsigned long data)
 
 	chan_dbg(chan, "tasklet entry\n");
 
-	spin_lock_bh(&chan->desc_lock);
+	spin_lock(&chan->desc_lock);
 
 	/* the hardware is now idle and ready for more */
 	chan->idle = true;
@@ -995,7 +995,7 @@ static void dma_do_tasklet(unsigned long data)
 	/* Run all cleanup for descriptors which have been completed */
 	fsldma_cleanup_descriptors(chan);
 
-	spin_unlock_bh(&chan->desc_lock);
+	spin_unlock(&chan->desc_lock);
 
 	chan_dbg(chan, "tasklet exit\n");
 }
-- 
2.7.4
