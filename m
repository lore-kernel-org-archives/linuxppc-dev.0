Return-Path: <weiyongjun1@huawei.com>
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408xwm58LFzF23M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 01:53:44 +1100 (AEDT)
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Rob Herring
 <robh@kernel.org>, Markus Elfring <elfring@users.sourceforge.net>, "Tyrel
 Datwyler" <tyreld@linux.vnet.ibm.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] powerpc: Fix error return code in ppc4xx_msi_probe()
Date: Mon, 26 Mar 2018 14:43:09 +0000
Message-ID: <1522075389-23511-1-git-send-email-weiyongjun1@huawei.com>
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

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/powerpc/platforms/4xx/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/4xx/msi.c b/arch/powerpc/platforms/4xx/msi.c
index 4b859c8..0b71c52 100644
--- a/arch/powerpc/platforms/4xx/msi.c
+++ b/arch/powerpc/platforms/4xx/msi.c
@@ -241,7 +241,8 @@ static int ppc4xx_msi_probe(struct platform_device *dev)
 	if (!msi_irqs)
 		return -ENODEV;
 
-	if (ppc4xx_setup_pcieh_hw(dev, res, msi))
+	err = ppc4xx_setup_pcieh_hw(dev, res, msi)
+	if (err)
 		goto error_out;
 
 	err = ppc4xx_msi_init_allocator(dev, msi);
