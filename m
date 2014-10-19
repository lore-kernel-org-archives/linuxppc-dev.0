Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E4411A0639
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Oct 2014 17:12:43 +1100 (AEDT)
Received: by mail-pa0-f51.google.com with SMTP id lj1so3156583pab.24
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 23:12:42 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] Revert "clk: ppc-corenet: Fix Section mismatch warning"
Date: Sun, 19 Oct 2014 14:11:37 +0800
Message-Id: <1413699099-25743-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
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

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
A new patch in v2.

 drivers/clk/clk-ppc-corenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 8e58edfeeb37..8b284be4efa4 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -291,7 +291,7 @@ static const struct of_device_id ppc_clk_ids[] __initconst = {
 	{}
 };
 
-static struct platform_driver ppc_corenet_clk_driver __initdata = {
+static struct platform_driver ppc_corenet_clk_driver = {
 	.driver = {
 		.name = "ppc_corenet_clock",
 		.owner = THIS_MODULE,
-- 
1.9.3
