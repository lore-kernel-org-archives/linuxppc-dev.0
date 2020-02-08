Return-Path: <SRS0=oxDq=34=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CCC35250
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Feb 2020 14:18:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9452D2082E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Feb 2020 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9452D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48FDmj2s40zDqXv
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Feb 2020 01:18:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=wanadoo.fr
 (client-ip=80.12.242.130; helo=smtp.smtpout.orange.fr;
 envelope-from=christophe.jaillet@wanadoo.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=wanadoo.fr
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr
 [80.12.242.130])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48FDZ140vbzDqXT
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Feb 2020 01:09:29 +1100 (AEDT)
Received: from localhost.localdomain ([93.22.133.23]) by mwinf5d31 with ME
 id 0E9R220070WSqZ103E9RbC; Sat, 08 Feb 2020 15:09:26 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Feb 2020 15:09:26 +0100
X-ME-IP: 93.22.133.23
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: oss@buserror.net, galak@kernel.crashing.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc/83xx: Add some error handling in
 'quirk_mpc8360e_qe_enet10()'
Date: Sat,  8 Feb 2020 15:09:20 +0100
Message-Id: <20200208140920.7652-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
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

In some error handling path, we should call "of_node_put(np_par)" or
some resource may be leaking in case of error.

Fixes: 8159df72d43e ("83xx: add support for the kmeter1 board.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/platforms/83xx/km83xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 306be75faec7..bcdc2c203ec9 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -60,10 +60,12 @@ static void quirk_mpc8360e_qe_enet10(void)
 	ret = of_address_to_resource(np_par, 0, &res);
 	if (ret) {
 		pr_warn("%s couldn't map par_io registers\n", __func__);
-		return;
+		goto out;
 	}
 
 	base = ioremap(res.start, resource_size(&res));
+	if (!base)
+		goto out;
 
 	/*
 	 * set output delay adjustments to default values according
@@ -111,6 +113,7 @@ static void quirk_mpc8360e_qe_enet10(void)
 		setbits32((base + 0xac), 0x0000c000);
 	}
 	iounmap(base);
+out:
 	of_node_put(np_par);
 }
 
-- 
2.20.1

