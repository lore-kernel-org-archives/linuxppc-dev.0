Return-Path: <SRS0=+E7l=JU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B2BC433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 14:41:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633CC6141C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 14:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633CC6141C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FRcRm0CkRz3br0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Apr 2021 00:41:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=wanadoo.fr
 (client-ip=80.12.242.126; helo=smtp.smtpout.orange.fr;
 envelope-from=christophe.jaillet@wanadoo.fr; receiver=<UNKNOWN>)
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FRcR93BrVz2yxS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Apr 2021 00:40:52 +1000 (AEST)
Received: from localhost.localdomain ([86.243.172.93]) by mwinf5d51 with ME
 id wEgp2400d21Fzsu03EgqWK; Fri, 23 Apr 2021 16:40:50 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 16:40:50 +0200
X-ME-IP: 86.243.172.93
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 gustavoars@kernel.org, robh@kernel.org
Subject: [PATCH 2/2] powerpc: Save a few lines of code
Date: Fri, 23 Apr 2021 16:40:48 +0200
Message-Id: <0ff6235a4e2d497e146ce401fa2df71449d290b6.1619188632.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr>
References: <f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr>
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

'arch/powerpc/platforms/powermac/feature.c' triggers many checkpatch.pl
warnings.
The code looks old and not very active, so fixing them all does not make
so much sense and will hide some 'git blame' information.

So only apply a few fixes that save a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/platforms/powermac/feature.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index e612222f7d2e..155e8586692e 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -83,8 +83,7 @@ struct macio_chip *macio_find(struct device_node *child, int type)
 }
 EXPORT_SYMBOL_GPL(macio_find);
 
-static const char *macio_names[] =
-{
+static const char *macio_names[] = {
 	"Unknown",
 	"Grand Central",
 	"OHare",
@@ -119,8 +118,7 @@ struct feature_table_entry {
 	feature_call	function;
 };
 
-struct pmac_mb_def
-{
+struct pmac_mb_def {
 	const char*			model_string;
 	const char*			model_name;
 	int				model_id;
@@ -301,11 +299,10 @@ static long ohare_sleep_state(struct device_node *node, long param, long value)
 
 	if ((pmac_mb.board_flags & PMAC_MB_CAN_SLEEP) == 0)
 		return -EPERM;
-	if (value == 1) {
+	if (value == 1)
 		MACIO_BIC(OHARE_FCR, OH_IOBUS_ENABLE);
-	} else if (value == 0) {
+	else if (value == 0)
 		MACIO_BIS(OHARE_FCR, OH_IOBUS_ENABLE);
-	}
 
 	return 0;
 }
@@ -2992,7 +2989,6 @@ void pmac_register_agp_pm(struct pci_dev *bridge,
 	if (bridge != pmac_agp_bridge)
 		return;
 	pmac_agp_suspend = pmac_agp_resume = NULL;
-	return;
 }
 EXPORT_SYMBOL(pmac_register_agp_pm);
 
-- 
2.27.0

