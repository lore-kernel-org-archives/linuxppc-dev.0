Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36C1A1A0F83
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jan 2015 04:22:28 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [RFC 07/11] i2c: axxia: make use of the new infrastructure for quirks
Date: Fri,  9 Jan 2015 18:21:37 +0100
Message-Id: <1420824103-24169-8-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-axxia.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 768a598d8d03..488c5d3bf9db 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -336,11 +336,6 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 	u32 addr_1, addr_2;
 	int ret;
 
-	if (msg->len > 255) {
-		dev_warn(idev->dev, "unsupported length %u\n", msg->len);
-		return -EINVAL;
-	}
-
 	idev->msg = msg;
 	idev->msg_xfrd = 0;
 	idev->msg_err = 0;
@@ -454,6 +449,11 @@ static const struct i2c_algorithm axxia_i2c_algo = {
 	.functionality = axxia_i2c_func,
 };
 
+static struct i2c_adapter_quirks axxia_i2c_quirks = {
+	.max_read_len = 255,
+	.max_write_len = 255,
+};
+
 static int axxia_i2c_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -511,6 +511,7 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 	strlcpy(idev->adapter.name, pdev->name, sizeof(idev->adapter.name));
 	idev->adapter.owner = THIS_MODULE;
 	idev->adapter.algo = &axxia_i2c_algo;
+	idev->adapter.quirks = &axxia_i2c_quirks;
 	idev->adapter.dev.parent = &pdev->dev;
 	idev->adapter.dev.of_node = pdev->dev.of_node;
 
-- 
2.1.3
