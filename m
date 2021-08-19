Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72749C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 00:48:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5197560F57
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 00:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5197560F57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqmNR31JGz3cLN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 10:48:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JXtImGhy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=wout5-smtp.messagingengine.com (client-ip=64.147.123.21;
 helo=wout5-smtp.messagingengine.com; envelope-from=fthain@linux-m68k.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=JXtImGhy; 
 dkim-atps=neutral
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqmMf2C5Bz301N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2021 10:47:56 +1000 (AEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 0DBFD3200989;
 Wed, 18 Aug 2021 20:47:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Wed, 18 Aug 2021 20:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:date:from:message-id:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=nbDBg9mYCKWOKiutMRQQ7517utN8j+39dIclsH3p0OA=; b=JXtImGhy
 WpkUposKZjVOio/dAQb8NpCo06qYe3j6QagXOTsEGiFpdOqVq6rONrld2BWi1wNY
 fs8F3Nd9bfUx0pkDV/Tr578vELd+ADuQdb2drYKIMU3o7DTDZevUg/dk1thv2yjS
 LgAOGiYnGVMTvAjskrrIqOmBAlBrFJTQreTDSvV9SUmknJ99SAT0wy4BFvbdvw/s
 e+rWgLLYBQNqlCw+lJq231ngch8tgmbj7JBbfwJeqGi07ob2btraAI3z1Gk7S/nQ
 GAbBTdketnEZxyWS+UYJklO6t9eKx9XJnBu/nUcUfz4m5vTIykRJmfWeQ+Yfaeyl
 TJbCEUqCMxP8DA==
X-ME-Sender: <xms:NaodYT_nWNw9QN-tURtesHwI9FQY_UYu99S63H0V6LAP6v3u-hD46Q>
 <xme:NaodYfsrp8mQWD1qFEZz-PmGVput7CfyZysrw7oARplixQx__BkGCdZjX3PEqEBUl
 48h9397IiQBfMulACI>
X-ME-Received: <xmr:NaodYRCUdTpVSRbvScc42ZWD6sDNzMNWwKVyLzlSwdM7NfaPCSnSrYfbkM6V4Wfmb-heAhaCxMaggPpnl0J9Njhz5oM8QrvF_2arZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdefkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefvkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
 oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
 dtleetkeelkeekvdeujeehkefgvddtheehhfetieethfetfeeghfduheevveelleenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinh
 eslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:NaodYffWuSr_LqYoWFdDRP31sbgXdpPOKtdUNfU-aOx6BOjLxhFX8w>
 <xmx:NaodYYM1OsI3BxJS16kWwW2iCxnAnARJxS448L0NR13YHvd9MBWqYw>
 <xmx:NaodYRkXh26GsV5Jp5o5XcgNy9J5islDW0q9DIdZI381CcBtDh3L5g>
 <xmx:N6odYRZQdwahIxCTbrXgzI9GoK7aFclZLnKIilczpljRkUJixsNL_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 20:47:47 -0400 (EDT)
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Message-Id: <44ab381741916a51e783c4a50d0b186abdd8f280.1629334014.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] powerpc/tau: Add 'static' storage qualifier to 'tau_work'
 definition
Date: Thu, 19 Aug 2021 10:46:54 +1000
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

This patch prevents the following sparse warning.

arch/powerpc/kernel/tau_6xx.c:199:1: sparse: sparse: symbol 'tau_work'
was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/powerpc/kernel/tau_6xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index b9a047d92ec0..8e83d19fe8fa 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -164,7 +164,7 @@ static void tau_work_func(struct work_struct *work)
 	queue_work(tau_workq, work);
 }
 
-DECLARE_WORK(tau_work, tau_work_func);
+static DECLARE_WORK(tau_work, tau_work_func);
 
 /*
  * setup the TAU
-- 
2.26.3

