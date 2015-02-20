Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BA8C1A0EC0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 04:00:20 +1100 (AEDT)
Received: by iecrp18 with SMTP id rp18so9293069iec.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 09:00:17 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] crypto: talitos: Clean ups and comment fixes for
 ablkcipher commands
Date: Fri, 20 Feb 2015 12:00:09 -0500
Message-Id: <1424451610-5786-2-git-send-email-mort@bork.org>
In-Reply-To: <1424451610-5786-1-git-send-email-mort@bork.org>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
Cc: Martin Hicks <mort@bork.org>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This just cleans up some of the initializers, and improves the comments
should any other ablkcipher modes be added in the future.  The header
words 1 and 5 have more possibilities than just passing an IV.  These
are pointers to the Cipher Context in/out registers.

Signed-off-by: Martin Hicks <mort@bork.org>
---
 drivers/crypto/talitos.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 226654c..6b2a19a 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1377,11 +1377,9 @@ static int common_nonsnoop(struct talitos_edesc *edesc,
 	int sg_count, ret;
 
 	/* first DWORD empty */
-	desc->ptr[0].len = 0;
-	to_talitos_ptr(&desc->ptr[0], 0);
-	desc->ptr[0].j_extent = 0;
+	desc->ptr[0] = zero_entry;
 
-	/* cipher iv */
+	/* cipher context */
 	to_talitos_ptr(&desc->ptr[1], edesc->iv_dma);
 	desc->ptr[1].len = cpu_to_be16(ivsize);
 	desc->ptr[1].j_extent = 0;
@@ -1444,14 +1442,12 @@ static int common_nonsnoop(struct talitos_edesc *edesc,
 					   edesc->dma_len, DMA_BIDIRECTIONAL);
 	}
 
-	/* iv out */
+	/* cipher context out */
 	map_single_talitos_ptr(dev, &desc->ptr[5], ivsize, ctx->iv, 0,
 			       DMA_FROM_DEVICE);
 
 	/* last DWORD empty */
-	desc->ptr[6].len = 0;
-	to_talitos_ptr(&desc->ptr[6], 0);
-	desc->ptr[6].j_extent = 0;
+	desc->ptr[6] = zero_entry;
 
 	edesc->req.callback = callback;
 	edesc->req.context = areq;
-- 
1.7.10.4
