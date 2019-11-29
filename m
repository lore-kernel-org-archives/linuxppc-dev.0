Return-Path: <SRS0=844/=ZV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3289C432C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 14:28:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B8921736
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 14:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="vwadSwR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B8921736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47PcM76KlczDrDF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Nov 2019 01:28:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="vwadSwR/"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47PcJk4F9NzDqtt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Nov 2019 01:26:46 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47PcJd22cjz9tyNL;
 Fri, 29 Nov 2019 15:26:41 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=vwadSwR/; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id xzgtBmZd6aO8; Fri, 29 Nov 2019 15:26:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47PcJd10X5z9tyNH;
 Fri, 29 Nov 2019 15:26:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1575037601; bh=fRzoFjkgDE6CKu0YY0lAoghACN69MKrk+j4pYatlQUs=;
 h=From:Subject:To:Cc:Date:From;
 b=vwadSwR/lBeQgtwOB28/AUGLBS8ZI1bEXg/s87aTU3glmMEtByxgdIh4Ef0vqqiJw
 sCZwfzASF5lp890RA3KoRYKc4x7FdFIV1XiqZnS3gioEOLT13S6BnzloaKCNZqwxm9
 E08V+/mfCFAau2Gdp9flJZ2OXU9F+S6vvRDVr+/0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8927B8B8DA;
 Fri, 29 Nov 2019 15:26:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id uSsj_lN5kQFD; Fri, 29 Nov 2019 15:26:42 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D2A38B8D2;
 Fri, 29 Nov 2019 15:26:42 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2F4E8635D4; Fri, 29 Nov 2019 14:26:41 +0000 (UTC)
Message-Id: <b58426f1664a4b344ff696d18cacf3b3e8962111.1575036985.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/kasan: fix boot failure with RELOCATABLE && FSL_BOOKE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 shaolexi@huawei.com
Date: Fri, 29 Nov 2019 14:26:41 +0000 (UTC)
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

When enabling CONFIG_RELOCATABLE and CONFIG_KASAN on FSL_BOOKE,
the kernel doesn't boot.

relocate_init() requires KASAN early shadow area to be set up because
it needs access to the device tree through generic functions.

Call kasan_early_init() before calling relocate_init()

Reported-by: Lexi Shao <shaolexi@huawei.com>
Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_fsl_booke.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 838d9d4650c7..6f7a3a7162c5 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -240,6 +240,9 @@ set_ivor:
 
 	bl	early_init
 
+#ifdef CONFIG_KASAN
+	bl	kasan_early_init
+#endif
 #ifdef CONFIG_RELOCATABLE
 	mr	r3,r30
 	mr	r4,r31
@@ -266,9 +269,6 @@ set_ivor:
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
-#ifdef CONFIG_KASAN
-	bl	kasan_early_init
-#endif
 	mr	r3,r30
 	mr	r4,r31
 	bl	machine_init
-- 
2.13.3

