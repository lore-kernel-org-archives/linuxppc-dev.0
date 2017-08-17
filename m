Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYD0f5N7ZzDrJQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 03:36:34 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id y192so10906360pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 10:36:34 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: herbert@gondor.apana.org.au,
	mpm@selenic.com,
	mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Subject: [PATCH] hwrng: pseries: constify vio_device_id
Date: Thu, 17 Aug 2017 23:06:23 +0530
Message-Id: <ba527ef090617a90e6909bab75b09e1c1ac8be68.1502990171.git.arvind.yadav.cs@gmail.com>
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
 drivers/char/hw_random/pseries-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/pseries-rng.c b/drivers/char/hw_random/pseries-rng.c
index d9f46b4..4e2a3f6 100644
--- a/drivers/char/hw_random/pseries-rng.c
+++ b/drivers/char/hw_random/pseries-rng.c
@@ -72,7 +72,7 @@ static int pseries_rng_remove(struct vio_dev *dev)
 	return 0;
 }
 
-static struct vio_device_id pseries_rng_driver_ids[] = {
+static const struct vio_device_id pseries_rng_driver_ids[] = {
 	{ "ibm,random-v1", "ibm,random"},
 	{ "", "" }
 };
-- 
2.7.4
