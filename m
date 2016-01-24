Return-Path: <saurabh.truth@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A6681A18C8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jan 2016 17:54:10 +1100 (AEDT)
Received: by mail-pa0-x22b.google.com with SMTP id cy9so63923367pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2016 22:54:10 -0800 (PST)
From: Saurabh Sengar <saurabh.truth@gmail.com>
To: scottwood@freescale.com, qiang.zhao@freescale.com, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [PATCH] QE: Use GFP_ATOMIC while spin_lock_irqsave is held
Date: Sun, 24 Jan 2016 12:24:06 +0530
Message-Id: <1453618446-6857-1-git-send-email-saurabh.truth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpm_muram_alloc_common is called twice and both the times
spin_lock_irqsave is held.
Using GFP_KERNEL can sleep in spin_lock_irqsave context and cause
deadlock

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
Let me know if there is any other way to fix it.
Also, I would say this function should be static as it is not used in any other file
 drivers/soc/fsl/qe/qe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 419fa5b..d774e54 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -194,7 +194,7 @@ unsigned long cpm_muram_alloc_common(unsigned long size, genpool_algo_t algo,
 		goto out2;
 	start = start - GENPOOL_OFFSET;
 	memset_io(cpm_muram_addr(start), 0, size);
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		goto out1;
 	entry->start = start;
-- 
1.9.1
