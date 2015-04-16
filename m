Return-Path: <weiyj_lk@163.com>
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by lists.ozlabs.org (Postfix) with ESMTP id EA3BD1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 22:36:13 +1000 (AEST)
From: weiyj_lk@163.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Wolfram Sang <wsa@the-dreams.de>, Alexander Gordeev <agordeev@redhat.com>,
 Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jiang Liu <jiang.liu@linux.intel.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/4xx: Fix return value check in hsta_msi_probe()
Date: Thu, 16 Apr 2015 20:18:50 +0800
Message-Id: <1429186730-20723-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the functions platform_get_resource() and kmalloc()
returns NULL not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
index f366d2d..49e24f5 100644
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -130,7 +130,7 @@ static int hsta_msi_probe(struct platform_device *pdev)
 	int irq, ret, irq_count;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(mem)) {
+	if (!mem) {
 		dev_err(dev, "Unable to get mmio space\n");
 		return -EINVAL;
 	}
@@ -155,7 +155,7 @@ static int hsta_msi_probe(struct platform_device *pdev)
 		goto out;
 
 	ppc4xx_hsta_msi.irq_map = kmalloc(sizeof(int) * irq_count, GFP_KERNEL);
-	if (IS_ERR(ppc4xx_hsta_msi.irq_map)) {
+	if (!ppc4xx_hsta_msi.irq_map) {
 		ret = -ENOMEM;
 		goto out1;
 	}
