Return-Path: <prvs=16695eb497=steve@digidescorp.com>
Received: from digidescorp.com (mail.digidescorp.com [66.244.163.200])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48D8CB7CEA
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 04:48:48 +1100 (EST)
Received: from localhost.localdomain by digidescorp.com (Cipher
	TLSv1:RC4-MD5:128) (MDaemon PRO v10.1.1)
	with ESMTP id md50001203882.msg
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Feb 2010 11:40:40 -0600
From: "Steven J. Magnani" <steve@digidescorp.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [async_tx-next PATCH 2/2] fsldma: Fix cookie issues
Date: Mon, 22 Feb 2010 11:40:39 -0600
Message-Id: <1266860439-17352-1-git-send-email-steve@digidescorp.com>
Cc: Zhang Wei <zw@zh-kernel.org>, linux-kernel@vger.kernel.org,
	"Steven J. Magnani" <steve@digidescorp.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fsl_dma_update_completed_cookie() appears to calculate the last completed
cookie incorrectly in the corner case where DMA on cookie 1 is in progress
just following a cookie wrap.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
---
diff -uprN a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
--- a/drivers/dma/fsldma.c	2010-02-22 11:16:36.000000000 -0600
+++ b/drivers/dma/fsldma.c	2010-02-22 11:08:41.000000000 -0600
@@ -819,8 +819,11 @@ static void fsl_dma_update_completed_coo
 	desc = to_fsl_desc(chan->ld_running.prev);
 	if (dma_is_idle(chan))
 		cookie = desc->async_tx.cookie;
-	else
+	else {
 		cookie = desc->async_tx.cookie - 1;
+		if (unlikely(cookie < DMA_MIN_COOKIE))
+			cookie = DMA_MAX_COOKIE;
+	}
 
 	chan->completed_cookie = cookie;
 
diff -uprN a/include/linux/dmaengine.h b/include/linux/dmaengine.h
--- a/include/linux/dmaengine.h	2010-02-22 11:18:11.000000000 -0600
+++ b/include/linux/dmaengine.h	2010-02-22 11:18:30.000000000 -0600
@@ -31,6 +31,8 @@
  * if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error code
  */
 typedef s32 dma_cookie_t;
+#define DMA_MIN_COOKIE	1
+#define DMA_MAX_COOKIE	2147483647
 
 #define dma_submit_error(cookie) ((cookie) < 0 ? 1 : 0)
 
