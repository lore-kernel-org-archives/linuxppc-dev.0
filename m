Return-Path: <weiyj_lk@163.com>
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
 by lists.ozlabs.org (Postfix) with ESMTP id 927831A01E8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jul 2014 17:37:00 +1000 (EST)
From: weiyj_lk@163.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Grant Likely <grant.likely@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH -next] powerpc: Fix return value check in hsta_msi_probe()
Date: Sun, 20 Jul 2014 15:20:59 +0800
Message-Id: <1405840859-9594-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function ioremap() returns NULL
not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.


Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
index 11c8884..14c25c5 100644
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -150,7 +150,7 @@ static int hsta_msi_probe(struct platform_device *pdev)
 	ppc4xx_hsta_msi.address = mem->start;
 	ppc4xx_hsta_msi.data = ioremap(mem->start, resource_size(mem));
 	ppc4xx_hsta_msi.irq_count = irq_count;
-	if (IS_ERR(ppc4xx_hsta_msi.data)) {
+	if (!ppc4xx_hsta_msi.data) {
 		dev_err(dev, "Unable to map memory\n");
 		return -ENOMEM;
 	}
