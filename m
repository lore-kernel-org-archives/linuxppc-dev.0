Return-Path: <linuxppc-dev+bounces-24175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2169C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:46:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvT4mJsz3c3v;
	Tue, 14 Jul 2026 11:45:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993508;
	cv=none; b=ld+3T+B4zvI6+TkiUGpvExH1aasQKsp9x8iy74vDbPjEVk0aMp73A8EvGuFlAJSS4Detiqfkr6zHZNiBe+vas2LGEijwuNYFwCe1ckN5PKmAEalaQVLMFsTaf3W5iJsxZnUtr45uop6xruy5rSC/dnNkOXHaeVRP6J0sM919CCPYDXiTlLSW7sP6QhPWF2JXlInljiw9P1cgI8cwuNMJgWNkE9CNW6Z5z24yMDrkBEx5+5dzNfCsJFYLagF66CoiXuYVaMcMXvis8M20rtfktyvGykTbFZ/huUNDmjOHo1AbOeppHZ27/zbdzV3AI5mDSwqWWOrjYVNsYc6kxKDBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993508; c=relaxed/relaxed;
	bh=3c6jVXUi+55jepOtFloOQNLKIS9Pd9AodNsSEPjbFmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwX4YBf6qUJKHuMvGE59TsXdxH4LdKzTd8dpA0HF/4v0GBB+QH6yDB070PzvhvSjfNcHjXwe+2+L17ZI1BKihEhEPAi8kxaeQJkJ73WLplAMZMiEZWtAQFG6ls6Gr3CrdY28kZLSU8bJnZTappAwsINfqBC6Q4yBDAMQVs90ccKXcal2056/0YfpiHwYwba6kG0C05rLWR5As1dvy5l247Gy/BAFXKC2xkMjOwc6x3r4uko6lx/HQcrmF89R73HRCI0jkY6xgL/7+zQqyg/jAemQnjDsr48yBrDN/wMImF8WwxfF5yzWZmCIvhoTcZmWqnPWUa4kyrL5J1sNCVZkyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wpf+mTGC; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wpf+mTGC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvK1WLvz3092
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:45:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3c6jVXUi+55jepOtFloOQNLKIS9Pd9AodNsSEPjbFmU=; b=Wpf+mTGC04w9/6knISjuoyn4ng
	6GeE7czqqKRqbFnOCE+gpMDAEUQe57zEK3y6msSTZLW6ARFKL508dCaZ3+yVix6iWinpEkqa0s1Ii
	7TvIf1+H+CgxiUTjJL9i96wsCySCJwyWq943ItF21FtwqOD3/xAWX1CEB1mWHRnGXnofoI+BnH8eu
	qGvoaYGJ/d/WqQT2KCC3vALwCk1TEz66dgbY8P/OTJMfDIxBGkGmdd2nLye/dxD6I7lCP4g1zOCsw
	HSsvX+xB6/dtCZB+BbvmvUaJzidiLKuiNk4dt/JKW2+4ApCkVtYzW657BLHN2/4GzZ7QkaCntpcez
	uFj4btqA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCb-0000000AgsR-09IW;
	Tue, 14 Jul 2026 01:44:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	patches@opensource.cirrus.com,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 10/14] ASoC: SDCA: correct enum names and add a missing struct field
Date: Mon, 13 Jul 2026 18:44:41 -0700
Message-ID: <20260714014445.569992-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714014445.569992-1-rdunlap@infradead.org>
References: <20260714014445.569992-1-rdunlap@infradead.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kernel-doc comment for @is_volatile in struct sdca_control.
Correct 2 malformed enum names to match the enums.
Fixes 3 warnings:

Warning: include/sound/sdca_function.h:306 expecting prototype for enum sdca_set_index_range. Prototype was for enum sdca_fdl_set_index_range instead

Warning: include/sound/sdca_function.h:829 struct member 'is_volatile' not described in 'sdca_control'

Warning: include/sound/sdca_function.h:1152 expecting prototype for enum sdca_xu_reset_machanism. Prototype was for enum sdca_xu_reset_mechanism instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: patches@opensource.cirrus.com

 include/sound/sdca_function.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/include/sound/sdca_function.h
+++ linext-2026-0710/include/sound/sdca_function.h
@@ -298,7 +298,7 @@ enum sdca_xu_controls {
 };
 
 /**
- * enum sdca_set_index_range - Column definitions UMP SetIndex
+ * enum sdca_fdl_set_index_range - Column definitions UMP SetIndex
  */
 enum sdca_fdl_set_index_range {
 	SDCA_FDL_SET_INDEX_SET_NUMBER			= 0,
@@ -803,6 +803,8 @@ struct sdca_control_range {
  * @mode: Access mode of the Control.
  * @layers: Bitmask of access layers of the Control.
  * @deferrable: Indicates if the access to the Control can be deferred.
+ * @is_volatile: Indicates the Control registers are forced to be treated
+ *  as volatile.
  * @has_default: Indicates the Control has a default value to be written.
  * @has_reset: Indicates the Control has a defined reset value.
  * @has_fixed: Indicates the Control only supports a single value.
@@ -1144,7 +1146,7 @@ struct sdca_entity_hide {
 };
 
 /**
- * enum sdca_xu_reset_machanism - SDCA FDL Resets
+ * enum sdca_xu_reset_mechanism - SDCA FDL Resets
  */
 enum sdca_xu_reset_mechanism {
 	SDCA_XU_RESET_FUNCTION				= 0x0,

