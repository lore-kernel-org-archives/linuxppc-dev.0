Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0273FC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:59:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2171D64E74
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2171D64E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbNG40KYrzDwfw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 01:59:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKnW4Hs5zDrBg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2021 00:08:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=hp7UvjEo; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKnT5MZPz9sXM; Thu, 11 Feb 2021 00:08:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1612962493;
 bh=myV60sJbxvQOLGBqcKw+G8ipFrxoKWnt/ilJzxeOoY4=;
 h=From:To:Subject:Date:From;
 b=hp7UvjEoT5MbJXwZWwpp6+O3HB84rZQM08zVxv+5a/Ca9ad0mIbFYsr2fx4xreaLH
 9qdjm1uatsBma7hTx4NQluQ9a5gPe8emFPbN6fBDtWOJgJuiUeQxXuqgwIqDkhglnc
 ARWzC63JECHVD+jAp5Nu3A0CnsRxb738TrK570WHwdKzjoGf+pSik09UOULKeKsadt
 w0iY1rAXLHZQY9yINIk9L+vfCeNZYuG5rVxcgPZ+E7xqyFynnc07WtEuMjx8Ysk98b
 BfDgUSZ7lRb6/fEqUMBLsN1PpuUc9RB9iYQNZL8PFVcpmXVaHfMhShS63grRszY3y9
 LlzIylNapax+w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/83xx: Fix build error when CONFIG_PCI=n
Date: Thu, 11 Feb 2021 00:08:02 +1100
Message-Id: <20210210130804.3190952-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As reported by lkp:

  arch/powerpc/platforms/83xx/km83xx.c:183:19: error: 'mpc83xx_setup_pci' undeclared here (not in a function)
     183 |  .discover_phbs = mpc83xx_setup_pci,
	 |                   ^~~~~~~~~~~~~~~~~
	 |                   mpc83xx_setup_arch

There is a stub defined for the CONFIG_PCI=n case, but now that
mpc83xx_setup_pci() is being assigned to discover_phbs the correct
empty value is NULL.

Fixes: 83f84041ff1c ("powerpc/83xx: Move PHB discovery")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/83xx/mpc83xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index f37d04332fc7..a30d30588cf6 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -76,7 +76,7 @@ extern void mpc83xx_ipic_init_IRQ(void);
 #ifdef CONFIG_PCI
 extern void mpc83xx_setup_pci(void);
 #else
-#define mpc83xx_setup_pci()	do {} while (0)
+#define mpc83xx_setup_pci	NULL
 #endif
 
 extern int mpc83xx_declare_of_platform_devices(void);
-- 
2.25.1

