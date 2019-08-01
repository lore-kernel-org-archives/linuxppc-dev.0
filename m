Return-Path: <SRS0=4G4N=V5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D0C19759
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 08:37:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86219214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 08:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86219214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zkFP0BqhzDqx2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 18:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=wanadoo.fr
 (client-ip=80.12.242.126; helo=smtp.smtpout.orange.fr;
 envelope-from=christophe.jaillet@wanadoo.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=wanadoo.fr
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zk7X0TM8zDqtQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2019 18:32:39 +1000 (AEST)
Received: from localhost.localdomain ([176.167.121.156]) by mwinf5d80 with ME
 id jkYb2000U3NZnML03kYcJj; Thu, 01 Aug 2019 10:32:36 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Aug 2019 10:32:36 +0200
X-ME-IP: 176.167.121.156
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 allison@lohutok.net, tglx@linutronix.de, clg@kaod.org, groug@kaod.org
Subject: [PATCH 2/2] powerpc/xive: Add a check for memory allocation failure
Date: Thu,  1 Aug 2019 10:32:42 +0200
Message-Id: <cc53462734dfeaf15b6bad0e626b483de18656b4.1564647619.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The result of this kzalloc is not checked. Add a check and corresponding
error handling code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Note that 'xive_irq_bitmap_add()' failures are not handled in
'xive_spapr_init()'
I guess that it is not really an issue. This function is _init, so if a
memory allocation occures here, it is likely that the system will
already be in bad shape.
Anyway, the check added here would at least keep the data linked in
'xive_irq_bitmaps' usable.
---
 arch/powerpc/sysdev/xive/spapr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index b4f5eb9e0f82..52198131c75e 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -53,6 +53,10 @@ static int xive_irq_bitmap_add(int base, int count)
 	xibm->base = base;
 	xibm->count = count;
 	xibm->bitmap = kzalloc(xibm->count, GFP_KERNEL);
+	if (!xibm->bitmap) {
+		kfree(xibm);
+		return -ENOMEM;
+	}
 	list_add(&xibm->list, &xive_irq_bitmaps);
 
 	pr_info("Using IRQ range [%x-%x]", xibm->base,
-- 
2.20.1

