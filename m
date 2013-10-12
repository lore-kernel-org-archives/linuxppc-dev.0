Return-Path: <weiyj.lk@gmail.com>
Received: from mail-bk0-x231.google.com (mail-bk0-x231.google.com
 [IPv6:2a00:1450:4008:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C788D2C034F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 18:13:24 +1100 (EST)
Received: by mail-bk0-f49.google.com with SMTP id r7so1890940bkg.36
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 00:13:20 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 12 Oct 2013 15:13:19 +0800
Message-ID: <CAPgLHd_c62rTu4pdxjC9188LO3k_gqTYdRHny6kAnR7nrfqTKw@mail.gmail.com>
Subject: [PATCH] ppc-6xx: add missing iounmap() on error in hlwd_pic_init()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, grant.likely@linaro.org,
 rob.herring@calxeda.com
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

Add the missing iounmap() before return from hlwd_pic_init()
in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 7cab21d..6c03034 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -183,6 +183,7 @@ struct irq_domain *hlwd_pic_init(struct device_node *np)
 					   &hlwd_irq_domain_ops, io_base);
 	if (!irq_domain) {
 		pr_err("failed to allocate irq_domain\n");
+		iounmap(io_base);
 		return NULL;
 	}
 
