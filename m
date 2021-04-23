Return-Path: <SRS0=+E7l=JU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673BDC433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 14:41:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B541F6141C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 14:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B541F6141C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FRcRQ324gz2xZH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Apr 2021 00:41:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=wanadoo.fr
 (client-ip=80.12.242.126; helo=smtp.smtpout.orange.fr;
 envelope-from=christophe.jaillet@wanadoo.fr; receiver=<UNKNOWN>)
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FRcR31ThRz2xfy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Apr 2021 00:40:45 +1000 (AEST)
Received: from localhost.localdomain ([86.243.172.93]) by mwinf5d51 with ME
 id wEgd2400J21Fzsu03EgdTu; Fri, 23 Apr 2021 16:40:40 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 16:40:40 +0200
X-ME-IP: 86.243.172.93
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 gustavoars@kernel.org, robh@kernel.org
Subject: [PATCH 1/2] powerpc: Fix a memory leak in error handling paths
Date: Fri, 23 Apr 2021 16:40:35 +0200
Message-Id: <f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
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

If we exit the for_each_of_cpu_node loop early, the reference on the
current node must be decremented, otherwise there is a leak.

Fixes: a94fe366340a ("powerpc: use for_each_of_cpu_node iterator")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Strangely, the commit above added the needed of_node_put in one place but
missed 2 other places!
This is strange, so maybe I misunderstand something. Review carefully
---
 arch/powerpc/platforms/powermac/feature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 5c77b9a24c0e..e612222f7d2e 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1060,6 +1060,7 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 			continue;
 		if (param == *num) {
 			reset_io = *rst;
+			of_node_put(np);
 			break;
 		}
 	}
@@ -1506,6 +1507,7 @@ static long g5_reset_cpu(struct device_node *node, long param, long value)
 			continue;
 		if (param == *num) {
 			reset_io = *rst;
+			of_node_put(np);
 			break;
 		}
 	}
-- 
2.27.0

