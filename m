Return-Path: <prvs=16695eb497=steve@digidescorp.com>
Received: from digidescorp.com (mail.digidescorp.com [66.244.163.200])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 464C1B7CE6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 04:48:48 +1100 (EST)
Received: from localhost.localdomain by digidescorp.com (Cipher
	TLSv1:RC4-MD5:128) (MDaemon PRO v10.1.1)
	with ESMTP id md50001203881.msg
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Feb 2010 11:40:35 -0600
From: "Steven J. Magnani" <steve@digidescorp.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [async_tx-next PATCH 1/2] fsldma: Fix cookie issues
Date: Mon, 22 Feb 2010 11:40:31 -0600
Message-Id: <1266860431-17310-1-git-send-email-steve@digidescorp.com>
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

fsl_dma_tx_submit() only sets the cookie on the first descriptor of a
transaction. It should set the cookie on all.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
---
diff -uprN a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
--- a/drivers/dma/fsldma.c	2010-02-22 11:16:36.000000000 -0600
+++ b/drivers/dma/fsldma.c	2010-02-22 11:24:01.000000000 -0600
@@ -362,7 +362,7 @@ static dma_cookie_t fsl_dma_tx_submit(st
 		if (cookie < 0)
 			cookie = 1;
 
-		desc->async_tx.cookie = cookie;
+		child->async_tx.cookie = cookie;
 	}
 
 	chan->common.cookie = cookie;
