Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC96C433E9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 15:08:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83EC61481
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 15:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83EC61481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbNSN01R5zDwft
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 02:08:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKnZ3lqzzDrBg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2021 00:08:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=OFTHXoil; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKnY1Hzyz9sXb; Thu, 11 Feb 2021 00:08:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1612962497;
 bh=fjdkr3cU1F0ePjeN3WeSRjNqNCsn6uIjm79EeabjIcc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=OFTHXoilAjb2oO+fZT+//8s0aCOn0/V2qq9mZKqzdqU3qHzUSvxwh9b+1Hx1iR6W5
 WVs0j0kYRrdOPCWrcWB63sF/t/J+Y2xOVDHdv0X/B7HQVsSHdEW1H8ivYNtEhw0Q04
 GjD4SsVuG95kNJHLrDCU0R7nLCFjZPh/FiCiGCVBaORHjn1BU9S2iGdz9OdGJFAgRF
 SPQ5T+ZFNqOLE4R9N1bNfQLlhXwJ/7muAFo8Gj5RQRjiv4b1E0ryIeSvjI77dFgw94
 cvpmPpB/Ff69qGb2ydIzPoTUPrGipVvaKukExkSLipqxmL0ShKe57ORInLM2en5+4Q
 6Qnj8tWwNWxIw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/amigaone: Make amigaone_discover_phbs() static
Date: Thu, 11 Feb 2021 00:08:04 +1100
Message-Id: <20210210130804.3190952-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210130804.3190952-1-mpe@ellerman.id.au>
References: <20210210130804.3190952-1-mpe@ellerman.id.au>
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

It's only used in setup.c, so make it static.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 053d58c87029 ("powerpc/amigaone: Move PHB discovery")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/amigaone/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/amigaone/setup.c b/arch/powerpc/platforms/amigaone/setup.c
index b25ddf39dd43..9d252c554f7f 100644
--- a/arch/powerpc/platforms/amigaone/setup.c
+++ b/arch/powerpc/platforms/amigaone/setup.c
@@ -70,7 +70,7 @@ void __init amigaone_setup_arch(void)
 		ppc_md.progress("Linux/PPC "UTS_RELEASE"\n", 0);
 }
 
-void __init amigaone_discover_phbs(void)
+static void __init amigaone_discover_phbs(void)
 {
 	struct device_node *np;
 	int phb = -ENODEV;
-- 
2.25.1

