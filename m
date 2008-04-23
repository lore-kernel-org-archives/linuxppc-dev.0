Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 13A79DE02A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 19:52:18 +1000 (EST)
Date: Wed, 23 Apr 2008 12:51:38 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Grant Likely <grant.likely@secretlab.ca>, paulus@samba.org
Subject: [2.6 patch] char/xilinx_hwicap/ section fix
Message-ID: <20080423095138.GA28933@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the following build error:

<--  snip  -->

...
  CC [M]  drivers/char/xilinx_hwicap/xilinx_hwicap.o
...
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/char/xilinx_hwicap/xilinx_hwicap.c:806: error: hwicap_of_match causes a section type conflict
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/char/xilinx_hwicap/xilinx_hwicap.c:806: error: hwicap_of_match causes a section type conflict
make[4]: *** [drivers/char/xilinx_hwicap/xilinx_hwicap.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
2f0f31d8aa696ca6cc45ab865ec8c68b90cd0e46 diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 016f905..dfe6907 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -803,7 +803,7 @@ static int __devexit hwicap_of_remove(struct of_device *op)
 }
 
 /* Match table for of_platform binding */
-static const struct of_device_id __devinit hwicap_of_match[] = {
+static const struct of_device_id __devinitconst hwicap_of_match[] = {
 	{ .compatible = "xlnx,opb-hwicap-1.00.b", .data = &buffer_icap_config},
 	{ .compatible = "xlnx,xps-hwicap-1.00.a", .data = &fifo_icap_config},
 	{},
