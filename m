Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY6NC4qxYzDqqL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 23:23:07 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u185so9897502pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 06:23:07 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tlfalcon@linux.vnet.ibm.com, benh@kernel.crashing.org,
 jallen@linux.vnet.ibm.com, mpe@ellerman.id.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: [PATCH] net: ibm: ibmveth: constify vio_device_id
Date: Thu, 17 Aug 2017 18:52:53 +0530
Message-Id: <b8393cdf646fae5ccbb64aab482c133fd54a7339.1502975929.git.arvind.yadav.cs@gmail.com>
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
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index d17c2b0..f210398 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1897,7 +1897,7 @@ static int ibmveth_resume(struct device *dev)
 	return 0;
 }
 
-static struct vio_device_id ibmveth_device_table[] = {
+static const struct vio_device_id ibmveth_device_table[] = {
 	{ "network", "IBM,l-lan"},
 	{ "", "" }
 };
-- 
2.7.4
