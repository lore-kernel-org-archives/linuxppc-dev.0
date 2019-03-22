Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1468C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 08:18:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47EF1213F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 08:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SxxSXPj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EF1213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qc4N2lQVzDqWG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 19:18:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="SxxSXPj8"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qbrx1llmzDqSk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 19:08:49 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Qbrr3Rf9z9vCWG;
 Fri, 22 Mar 2019 09:08:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=SxxSXPj8; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 9Z9pn60CMHs0; Fri, 22 Mar 2019 09:08:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Qbrr2Dyzz9v9vG;
 Fri, 22 Mar 2019 09:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553242124; bh=clISJmG2l3/ZkCVole2S2gui9mKGtnTXA7Zm6ytBbNw=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=SxxSXPj8CWxsFCGtaGYHQ5u8Hax2Ec5WM6xFZd5i5YgZTgT2MrbV+XjQaLjyXkxfN
 ZRYsvt0M3e+DcSXXMT/g9nqYZ32n9kCqx4iOJvaWKMuSuTarC31h9hVDcwFXqg4FNh
 DjF+M/GcznQ5LCFOHSFREhZulkJhO2o8D7dfktJY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BD0D8B845;
 Fri, 22 Mar 2019 09:08:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BIK7wei4BPRL; Fri, 22 Mar 2019 09:08:45 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 12CC08B844;
 Fri, 22 Mar 2019 09:08:45 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id EE1086CD85; Fri, 22 Mar 2019 08:08:44 +0000 (UTC)
Message-Id: <eaa134f9523f3cec1fcb9ab22c447111b36a9277.1553242059.git.christophe.leroy@c-s.fr>
In-Reply-To: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
References: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/7] powerpc/setup: cleanup the #ifdef CONFIG_TAU block
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 22 Mar 2019 08:08:44 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use cpu_has_feature() instead of opencoding

Use IS_ENABLED() instead of #ifdef for CONFIG_TAU_AVERAGE

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/setup-common.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 95d545e94c28..b6c86287085a 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -254,18 +254,18 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "\n");
 
 #ifdef CONFIG_TAU
-	if (cur_cpu_spec->cpu_features & CPU_FTR_TAU) {
-#ifdef CONFIG_TAU_AVERAGE
-		/* more straightforward, but potentially misleading */
-		seq_printf(m,  "temperature \t: %u C (uncalibrated)\n",
-			   cpu_temp(cpu_id));
-#else
-		/* show the actual temp sensor range */
-		u32 temp;
-		temp = cpu_temp_both(cpu_id);
-		seq_printf(m, "temperature \t: %u-%u C (uncalibrated)\n",
-			   temp & 0xff, temp >> 16);
-#endif
+	if (cpu_has_feature(CPU_FTR_TAU)) {
+		if (IS_ENABLED(CONFIG_TAU_AVERAGE)) {
+			/* more straightforward, but potentially misleading */
+			seq_printf(m,  "temperature \t: %u C (uncalibrated)\n",
+				   cpu_temp(cpu_id));
+		} else {
+			/* show the actual temp sensor range */
+			u32 temp;
+			temp = cpu_temp_both(cpu_id);
+			seq_printf(m, "temperature \t: %u-%u C (uncalibrated)\n",
+				   temp & 0xff, temp >> 16);
+		}
 	}
 #endif /* CONFIG_TAU */
 
-- 
2.13.3

