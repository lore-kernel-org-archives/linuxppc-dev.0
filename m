Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9018DDDEC
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 18:45:36 +1000 (EST)
Received: from debian (unknown [218.241.174.18])
	by mx.linux.net.cn (Postfix) with ESMTP id 807833ED42
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 16:58:18 +0800 (CST)
Date: Thu, 25 Sep 2008 16:36:46 +0800
From: Wang Jian <lark@linux.net.cn>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] pata_platform struct resource signness fix
Message-ID: <20080925083622.GA2701@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This patch is to pata_platform.c but at this time, it's powerpc specific
because it can only be triggerred using openfirmware, so I post the patch
here. The patch is against 2.6.26-rc8.

The problem is triggerred when ata device is populated using 
pata_of_platform.c, and no irq is assigned (poll mode, such as CF card).

pata_of_platform_probe() parse device tree and

        if (ret == NO_IRQ)
	                irq_res.start = irq_res.end = -1;

Then irq is 0xffffffff, not NULL. Probe will fail coz irq can't be
requested.


---
(irq_res->start > 0) will be true even when it is (-1). When the device
has no irq, irq_res->start is assigned (-1).

Signed-off-by: Wang Jian <lark@linux.net.cn>
---
 drivers/ata/pata_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 8f65ad6..b12cd0c 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -123,7 +123,7 @@ int __devinit __pata_platform_probe(struct device *dev,
 	/*
 	 * And the IRQ
 	 */
-	if (irq_res && irq_res->start > 0) {
+	if (irq_res && irq_res->start != -1) {
 		irq = irq_res->start;
 		irq_flags = irq_res->flags;
 	}
-- 
1.5.5.4
