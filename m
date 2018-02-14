Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhtP82YRRzF1KK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 21:51:22 +1100 (AEDT)
To: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "David S. Miller" <davem@davemloft.net>, Haren Myneni <haren@us.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Dan Streetman <ddstreet@ieee.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] crypto: nx-842: Delete an error message for a failed memory
 allocation in nx842_pseries_init()
Message-ID: <8261d041-ccd9-c0f8-4530-a4afb43ee7ab@users.sourceforge.net>
Date: Wed, 14 Feb 2018 17:17:08 +0100
MIME-Version: 1.0
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
Date: Wed, 14 Feb 2018 17:05:13 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/nx/nx-842-pseries.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
index bf52cd1d7fca..66869976cfa2 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -1105,10 +1105,9 @@ static int __init nx842_pseries_init(void)
 
 	RCU_INIT_POINTER(devdata, NULL);
 	new_devdata = kzalloc(sizeof(*new_devdata), GFP_KERNEL);
-	if (!new_devdata) {
-		pr_err("Could not allocate memory for device data\n");
+	if (!new_devdata)
 		return -ENOMEM;
-	}
+
 	RCU_INIT_POINTER(devdata, new_devdata);
 
 	ret = vio_register_driver(&nx842_vio_driver);
-- 
2.16.1
