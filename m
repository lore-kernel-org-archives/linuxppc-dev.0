Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76252C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 09:36:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A72613E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 09:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A72613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FF2V65Fyzz3bts
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 19:36:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=maz@kernel.org; receiver=<UNKNOWN>)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FF2Tl5Xhzz301g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Apr 2021 19:36:27 +1000 (AEST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 197BC613C3;
 Tue,  6 Apr 2021 09:36:25 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lTi8F-005owA-CS; Tue, 06 Apr 2021 10:36:23 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org
Subject: [PATCH 2/9] ARM: PXA: Kill use of irq_create_strict_mappings()
Date: Tue,  6 Apr 2021 10:35:50 +0100
Message-Id: <20210406093557.1073423-3-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406093557.1073423-1-maz@kernel.org>
References: <20210406093557.1073423-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, daniel@zonque.org,
 robert.jarzmik@free.fr, haojian.zhuang@gmail.com, ysato@users.sourceforge.jp,
 dalias@libc.org, tsbogend@alpha.franken.de, mpe@ellerman.id.au,
 tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Rich Felker <dalias@libc.org>,
 Thomas Gleixner <tglx@linutronix.de>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

irq_create_strict_mappings() is a poor way to allow the use of
a linear IRQ domain as a legacy one. Let's be upfront about
it and use a legacy domain when appropriate.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/mach-pxa/pxa_cplds_irqs.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index 45c19ca96f7a..ec0d9b094744 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -147,22 +147,20 @@ static int cplds_probe(struct platform_device *pdev)
 	}
 
 	irq_set_irq_wake(fpga->irq, 1);
-	fpga->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
-					       CPLDS_NB_IRQ,
-					       &cplds_irq_domain_ops, fpga);
+	if (base_irq)
+		fpga->irqdomain = irq_domain_add_legacy(pdev->dev.of_node,
+							CPLDS_NB_IRQ,
+							base_irq, 0,
+							&cplds_irq_domain_ops,
+							fpga);
+	else
+		fpga->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
+							CPLDS_NB_IRQ,
+							&cplds_irq_domain_ops,
+							fpga);
 	if (!fpga->irqdomain)
 		return -ENODEV;
 
-	if (base_irq) {
-		ret = irq_create_strict_mappings(fpga->irqdomain, base_irq, 0,
-						 CPLDS_NB_IRQ);
-		if (ret) {
-			dev_err(&pdev->dev, "couldn't create the irq mapping %d..%d\n",
-				base_irq, base_irq + CPLDS_NB_IRQ);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.29.2

