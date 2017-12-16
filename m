Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzTbP17t6zDsPq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 01:05:36 +1100 (AEDT)
Subject: [PATCH 1/2] ps3: Delete an error message for a failed memory
 allocation in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
Message-ID: <58807b28-b2b9-7e77-11b8-21db43c9d5ba@users.sourceforge.net>
Date: Sat, 16 Dec 2017 14:51:42 +0100
MIME-Version: 1.0
In-Reply-To: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 16 Dec 2017 12:32:42 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ps3/ps3-lpm.c   | 2 --
 drivers/ps3/ps3-vuart.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index e34de9a7d517..ac8d5725c9b4 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -1123,8 +1123,6 @@ int ps3_lpm_open(enum ps3_lpm_tb_type tb_type, void *tb_cache,
 		lpm_priv->tb_cache_internal = kzalloc(
 			lpm_priv->tb_cache_size + 127, GFP_KERNEL);
 		if (!lpm_priv->tb_cache_internal) {
-			dev_err(sbd_core(), "%s:%u: alloc internal tb_cache "
-				"failed\n", __func__, __LINE__);
 			result = -ENOMEM;
 			goto fail_malloc;
 		}
diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index b7f300b79ffd..bbaad30a876f 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -929,7 +929,6 @@ static int ps3_vuart_bus_interrupt_get(void)
 	vuart_bus_priv.bmp = kzalloc(sizeof(struct ports_bmp), GFP_KERNEL);
 
 	if (!vuart_bus_priv.bmp) {
-		pr_debug("%s:%d: kzalloc failed.\n", __func__, __LINE__);
 		result = -ENOMEM;
 		goto fail_bmp_malloc;
 	}
-- 
2.15.1
