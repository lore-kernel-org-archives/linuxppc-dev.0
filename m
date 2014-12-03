Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 649171A0BF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 19:56:06 +1100 (AEDT)
Received: by mail-pd0-f182.google.com with SMTP id r10so15130054pdi.27
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2014 00:56:04 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch warning"
Date: Wed,  3 Dec 2014 16:53:51 +0800
Message-Id: <1417596833-31456-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit da788acb28386aa896224e784954bb73c99ff26c.

That commit tried to fix the section mismatch warning by moving the
ppc_corenet_clk_driver struct to init section. This is definitely wrong
because the kernel would free the memories occupied by this struct
after boot while this driver is still registered in the driver core.
The kernel would panic when accessing this driver struct.

Cc: stable@vger.kernel.org # 3.17
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Scott Wood <scottwood@freescale.com>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
v3: Cc stable and add ack.

v2: A new patch in v2.

 drivers/clk/clk-ppc-corenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index b6e6c85507a5..0a47d6f49cd6 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -291,7 +291,7 @@ static const struct of_device_id ppc_clk_ids[] __initconst = {
 	{}
 };
 
-static struct platform_driver ppc_corenet_clk_driver __initdata = {
+static struct platform_driver ppc_corenet_clk_driver = {
 	.driver = {
 		.name = "ppc_corenet_clock",
 		.of_match_table = ppc_clk_ids,
-- 
1.9.3
