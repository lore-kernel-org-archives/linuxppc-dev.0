Return-Path: <prvs=1672ac1db0=steve@digidescorp.com>
Received: from digidescorp.com (mail.digidescorp.com [66.244.163.200])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78DEFB7CE2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 06:39:39 +1100 (EST)
Received: from localhost.localdomain by digidescorp.com (Cipher
	TLSv1:RC4-MD5:128) (MDaemon PRO v10.1.1)
	with ESMTP id md50001207274.msg
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 13:39:34 -0600
From: "Steven J. Magnani" <steve@digidescorp.com>
To: Li Yang <leoli@freescale.com>
Subject: [async_tx-next PATCH v2 1/2] fsldma: Fix cookie issues
Date: Thu, 25 Feb 2010 13:39:30 -0600
Message-Id: <1267126770-21497-1-git-send-email-steve@digidescorp.com>
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Zhang Wei <zw@zh-kernel.org>,
	"Steven J. Magnani" <steve@digidescorp.com>,
	Dan Williams <dan.j.williams@intel.com>
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
