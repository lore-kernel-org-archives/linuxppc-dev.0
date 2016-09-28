Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skgZr2LQfzDrYv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 00:49:24 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 21so2258757pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 07:49:24 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH -next] powerpc/4xx: Fix error return code in ppc4xx_msi_probe()
Date: Wed, 28 Sep 2016 14:49:12 +0000
Message-Id: <1475074152-12932-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return a negative error code from the ppc4xx_setup_pcieh_hw()
error handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/powerpc/sysdev/ppc4xx_msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 590dab4..b729d44 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -242,7 +242,8 @@ static int ppc4xx_msi_probe(struct platform_device *dev)
 	if (!msi_irqs)
 		return -ENODEV;
 
-	if (ppc4xx_setup_pcieh_hw(dev, res, msi))
+	err = ppc4xx_setup_pcieh_hw(dev, res, msi);
+	if (err)
 		goto error_out;
 
 	err = ppc4xx_msi_init_allocator(dev, msi);
