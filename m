Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 72CB3B7E69
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 11:11:08 +1100 (EST)
Date: Wed, 11 Nov 2009 03:11:07 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 4/6] gianfar: Fix thinko in gfar_set_rx_stash_index()
Message-ID: <20091111001107.GD8817@oksana.dev.rtsoft.ru>
References: <20091111001036.GA28576@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091111001036.GA28576@oksana.dev.rtsoft.ru>
Cc: Jon Loeliger <jdl@jdl.com>, Kumar Gopalpet-B05799 <B05799@freescale.com>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We obviously want to write a modified 'temp' value back to the
register, not the saved IRQ flags.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/gianfar_sysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar_sysfs.c b/drivers/net/gianfar_sysfs.c
index 3724835..b31c9c8 100644
--- a/drivers/net/gianfar_sysfs.c
+++ b/drivers/net/gianfar_sysfs.c
@@ -186,7 +186,7 @@ static ssize_t gfar_set_rx_stash_index(struct device *dev,
 	temp = gfar_read(&regs->attreli);
 	temp &= ~ATTRELI_EI_MASK;
 	temp |= ATTRELI_EI(index);
-	gfar_write(&regs->attreli, flags);
+	gfar_write(&regs->attreli, temp);
 
 out:
 	unlock_rx_qs(priv);
-- 
1.6.3.3
