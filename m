Return-Path: <larry.finger@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfWY73f7nzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 13:34:03 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id 2so5874928oif.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 18:34:03 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "regressions @ leemhuis . info" <regressions@leemhuis.info>
Subject: [PATCH] powerpc: Fix crash introduced with commit 5657933dbb6e
Date: Thu,  9 Mar 2017 20:33:51 -0600
Message-Id: <20170310023351.973-1-Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code inserted during the code merged between kernels 4.10 and 4.11-rc1
caused an early panic quickly followed by a complete shutdown for
PowerPC. The traceback was not displayed long enough to read or
photograph, thus it is not reproduced here.

The problem was bisected to commit 5657933dbb6e ("treewide: Move dma_ops
from struct dev_archdata into struct device"). The problem was a missing
copy of critical information from struct dev_archdata into struct device,
leading to the dereference of a null pointer.

This fix was suggested by Benjamin Herrenschmidt.

Fixes: commit 5657933dbb6e ("treewide: Move dma_ops from struct dev_archdata into struct device")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: regressions@leemhuis.info <regressions@leemhuis.info>

 drivers/macintosh/macio_asic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 3f041b1..f757cef2 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -392,6 +392,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 	 * To get all the fields, copy all archdata
 	 */
 	dev->ofdev.dev.archdata = chip->lbus.pdev->dev.archdata;
+	dev->ofdev.dev.dma_ops = chip->lbus.pdev->dev.dma_ops;
 #endif /* CONFIG_PCI */
 
 #ifdef DEBUG
-- 
2.10.2
