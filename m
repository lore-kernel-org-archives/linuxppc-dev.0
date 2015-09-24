Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f66.google.com (mail-la0-f66.google.com
 [209.85.215.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95EBB1A02C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 03:28:02 +1000 (AEST)
Received: by laag3 with SMTP id g3so8334652laa.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 10:27:58 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <robh@kernel.org>, Timur Tabi <timur@tabi.org>,
 Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Alexander Popov <alex.popov@linux.com>,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dmaengine: mpc512x: initialize with subsys_initcall()
Date: Thu, 24 Sep 2015 20:28:57 +0300
Message-Id: <1443115737-3948-4-git-send-email-alex.popov@linux.com>
In-Reply-To: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initialize Freescale MPC512x DMA driver with subsys_initcall()
to allow the depending drivers to call dma_request_slave_channel()
during their probe.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/dma/mpc512x_dma.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index e6281e7..4f29d7c 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -1083,7 +1083,17 @@ static struct platform_driver mpc_dma_driver = {
 	},
 };
 
-module_platform_driver(mpc_dma_driver);
+static int __init mpc_dma_driver_init(void)
+{
+	return platform_driver_register(&mpc_dma_driver);
+}
+subsys_initcall(mpc_dma_driver_init);
+
+static void __exit mpc_dma_driver_exit(void)
+{
+	platform_driver_unregister(&mpc_dma_driver);
+}
+module_exit(mpc_dma_driver_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Piotr Ziecik <kosmo@semihalf.com>");
-- 
1.9.1
