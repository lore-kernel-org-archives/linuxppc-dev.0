Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY6BG1jYWzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 23:14:30 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y129so9857138pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 06:14:30 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, benh@kernel.crashing.org,
 leosilva@linux.vnet.ibm.com, pfsmorigo@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] crypto: nx: 842: constify vio_device_id
Date: Thu, 17 Aug 2017 18:44:11 +0530
Message-Id: <75815c8052e9a456ac887965cc50945aedb877e0.1502974810.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <35e1702104da09dee65dd407bde06b8cb31f6483.1502974810.git.arvind.yadav.cs@gmail.com>
References: <35e1702104da09dee65dd407bde06b8cb31f6483.1502974810.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <35e1702104da09dee65dd407bde06b8cb31f6483.1502974810.git.arvind.yadav.cs@gmail.com>
References: <35e1702104da09dee65dd407bde06b8cb31f6483.1502974810.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vio_device_id are not supposed to change at runtime. All functions
working with vio_device_id provided by <asm/vio.h> work with
const vio_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/crypto/nx/nx-842-pseries.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
index cddc6d8..bf52cd1 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -1082,7 +1082,7 @@ static int nx842_remove(struct vio_dev *viodev)
 	return 0;
 }
 
-static struct vio_device_id nx842_vio_driver_ids[] = {
+static const struct vio_device_id nx842_vio_driver_ids[] = {
 	{"ibm,compression-v1", "ibm,compression"},
 	{"", ""},
 };
-- 
2.7.4
