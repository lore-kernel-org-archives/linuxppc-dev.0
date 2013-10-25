Return-Path: <weiyj.lk@gmail.com>
Received: from mail-ee0-x22c.google.com (mail-ee0-x22c.google.com
 [IPv6:2a00:1450:4013:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB1FE2C0119
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 20:30:27 +1100 (EST)
Received: by mail-ee0-f44.google.com with SMTP id c4so1303747eek.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 02:30:24 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 25 Oct 2013 17:30:24 +0800
Message-ID: <CAPgLHd8=sS2NgzbdihnzwaFvWf-TJYYCm8hxWfPjFpvuYOxomQ@mail.gmail.com>
Subject: [PATCH] mv643xx_eth: fix return value check in
 mv64x60_eth_register_shared_pdev()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, grant.likely@linaro.org,
 rob.herring@calxeda.com, davem@davemloft.net, florian@openwrt.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function platform_device_register_simple() returns
RR_PTR() and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/sysdev/mv64x60_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 4a25c26..a3a8fad 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -228,7 +228,7 @@ static struct platform_device * __init mv64x60_eth_register_shared_pdev(
 
 	if (id == 0) {
 		pdev = platform_device_register_simple("orion-mdio", -1, &r[1], 1);
-		if (!pdev)
+		if (IS_ERR(pdev))
 			return pdev;
 	}
 
