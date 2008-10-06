Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8F865DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 04:26:55 +1100 (EST)
Date: Mon, 6 Oct 2008 21:26:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Wang Jian <lark@linux.net.cn>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When no irq specified the pata_of_platform fills the irq_res with -1,
which is wrong to do for two reasons:

1. By definition, 'no irq' should be IRQ 0, not some negative integer;
2. pata_platform checks for irq_res.start > 0, but since irq_res.start
   is unsigned type, the check will be true for `-1'.

Reported-by: Steven A. Falco <sfalco@harris.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Resending again...

 drivers/ata/pata_of_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 408da30..1f18ad9 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
 
 	ret = of_irq_to_resource(dn, 0, &irq_res);
 	if (ret == NO_IRQ)
-		irq_res.start = irq_res.end = -1;
+		irq_res.start = irq_res.end = 0;
 	else
 		irq_res.flags = 0;
 
-- 
1.5.6.3
