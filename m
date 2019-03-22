Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBF8C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 08:17:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758A9213F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 08:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="whjER/+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758A9213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qc2l0fKTzDqRt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 19:17:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="whjER/+6"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qbrv3YmBzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 19:08:47 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Qbrq2NVtz9v9vV;
 Fri, 22 Mar 2019 09:08:43 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=whjER/+6; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id eaWPTpchCSG5; Fri, 22 Mar 2019 09:08:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Qbrq1CwNz9v9vG;
 Fri, 22 Mar 2019 09:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553242123; bh=qbdxgb1HYWPobWcLuIAD+ZD4jJ/zVC4av8h4SDf/6DM=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=whjER/+637OTJ22ms0B1Wx5Q9DLdpSLa2G5GoDFUFRVo3sSJil5yf699PTwJIE4CX
 BkUMLiE6Sj2sMoBq4KiE2ToV/A38oBwGXw4x8w5XEqYJS7uzvXcJZg9Crv6Vjiemb6
 hi2ufc8tFtHMtNqbhUXNGhQSb3mfkjKVpXGFfZZE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C7658B845;
 Fri, 22 Mar 2019 09:08:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id fA2g55RPylpa; Fri, 22 Mar 2019 09:08:44 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F16188B844;
 Fri, 22 Mar 2019 09:08:43 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DD35D6CD85; Fri, 22 Mar 2019 08:08:43 +0000 (UTC)
Message-Id: <b5e5ca3f472ba46a29d121da21fd381ca8c5be87.1553242059.git.christophe.leroy@c-s.fr>
In-Reply-To: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
References: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/7] powerpc/setup: cleanup ifdef mess in
 check_cache_coherency()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 22 Mar 2019 08:08:43 +0000 (UTC)
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

Use IS_ENABLED() instead of #ifdefs

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/setup-common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index fa90585760c0..95d545e94c28 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -734,23 +734,19 @@ void __init setup_panic(void)
  * BUG() in that case.
  */
 
-#ifdef CONFIG_NOT_COHERENT_CACHE
-#define KERNEL_COHERENCY	0
-#else
-#define KERNEL_COHERENCY	1
-#endif
+#define KERNEL_COHERENCY	(!IS_ENABLED(CONFIG_NOT_COHERENT_CACHE))
 
 static int __init check_cache_coherency(void)
 {
 	struct device_node *np;
 	const void *prop;
-	int devtree_coherency;
+	bool devtree_coherency;
 
 	np = of_find_node_by_path("/");
 	prop = of_get_property(np, "coherency-off", NULL);
 	of_node_put(np);
 
-	devtree_coherency = prop ? 0 : 1;
+	devtree_coherency = prop ? false : true;
 
 	if (devtree_coherency != KERNEL_COHERENCY) {
 		printk(KERN_ERR
-- 
2.13.3

