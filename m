Return-Path: <dwalker@mvista.com>
Received: from dwalker1.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4B2EDDF3B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 11:51:36 +1100 (EST)
Message-Id: <20071213003028.676998182@mvista.com>
Date: Wed, 12 Dec 2007 00:00:01 -0800
Subject: [PATCH 1/3] ps3: vuart: fix error path locking
Message-Id: <20071213003023.117964080@mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@linux-foundation.org
Cc: matthias.kaehlcke@gmail.com, linux-kernel@vger.kernel.org, linux@bohmer.net,
	linuxppc-dev@ozlabs.org, mingo@elte.hu, kjwinchester@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This stray down would cause a permanent sleep which doesn't seem correct. 
The other uses of this semaphore appear fairly mutex like it's even initialized
with init_MUTEX() ..  So here a patch for removing this one down().

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 drivers/ps3/ps3-vuart.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.23/drivers/ps3/ps3-vuart.c
===================================================================
--- linux-2.6.23.orig/drivers/ps3/ps3-vuart.c
+++ linux-2.6.23/drivers/ps3/ps3-vuart.c
@@ -1072,7 +1072,6 @@ static int ps3_vuart_probe(struct ps3_sy
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: drv->probe failed\n",
 			__func__, __LINE__);
-		down(&vuart_bus_priv.probe_mutex);
 		goto fail_probe;
 	}
 

-- 
