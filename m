Return-Path: <weiyongjun1@huawei.com>
Received: from huawei.com (unknown [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMRQW71nmzF0VR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 12:37:07 +1100 (AEDT)
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>, "Alistair
 Popple" <alistair@popple.id.au>, Michael Ellerman <mpe@ellerman.id.au>,
 "Jeremy Kerr" <jk@ozlabs.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
 <openipmi-developer@lists.sourceforge.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] ipmi/powernv: Fix error return code in
 ipmi_powernv_probe()
Date: Thu, 18 Jan 2018 01:43:19 +0000
Message-ID: <1516239799-71370-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1516188311-144227-1-git-send-email-weiyongjun1@huawei.com>
References: <1516188311-144227-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix to return a negative error code from the request_irq() error
handling case instead of 0, as done elsewhere in this function.

Fixes: dce143c3381c ("ipmi/powernv: Convert to irq event interface")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: add fixes.
---
 drivers/char/ipmi/ipmi_powernv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index c687c8d..bcf493d 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -250,8 +250,9 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
 		ipmi->irq = opal_event_request(prop);
 	}
 
-	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
-				"opal-ipmi", ipmi)) {
+	rc = request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
+			 "opal-ipmi", ipmi);
+	if (rc) {
 		dev_warn(dev, "Unable to request irq\n");
 		goto err_dispose;
 	}
