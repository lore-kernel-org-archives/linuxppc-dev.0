Return-Path: <linuxppc-dev+bounces-24280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4494C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfH4fzQz2xLk;
	Wed, 15 Jul 2026 10:05:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073943;
	cv=none; b=LSuDGdqz4mBahHX//vmYocA8tGjbrTd+l9PM9dz5hXr0jZYlYdmtAh51SsqxOhv61/VPdElqjh0IqXB3xpXS6jCvcOdUoxDstdiFur/5AhK+EahAgsU6EeY/z4AcVUE4JUqwdEP4rW2X7K+WlFGX5RJs0H0NS4d7ISuB/zgPNbX62WIdL6CO0UEip13xrK5TJbAvj80vTd6ASQY7LUd8ej1eE7BGzG5BJp8NIu9DSBAeXuqNoaaetIg4Hk77KUlVJR9WxhYSYLqQsWpejZhnMZUtd36L/JwsFRiHxt9Sl1z1r7YewHdPIs4MDf5Ibx2s7oIVE0GzQA0OPNx9sMDcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073943; c=relaxed/relaxed;
	bh=qywkd8idYdvwcUR1m71kYoz3a59q0zRNVKzYSgEtA9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0JFzLXbhDHyjlJfaES0fdiuW5yWJv/HkioCYQ+baH/IakxJF492R2PGjlMP5QRz/r6/2dCW3WhrJ4yF/qtfzKpigVbQNymJes+848/clcSMLJsnvGsiYYZhPWlT9jQrd7RBobROcwKRcEJ6pE2CeEMzMjrklbxlEXd+KhYoV7AtGTL6/PhNFVZR4pLghw4YSawR1cFpQoPTCExZPu/mPiNVsSuUcT8gn5chk4A7NbNA1dkUYLq2TZyE3BcqxBboaopvnqqHQ17b0peo9yhAlgIvCuSo+Y5JIt++H8WZFWCJc+PhNdFOT8e/xxLdmNJYupJ5dw3aPEPz+HnB3UvUzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KNj/zD7F; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KNj/zD7F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfB5ZrCz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qywkd8idYdvwcUR1m71kYoz3a59q0zRNVKzYSgEtA9I=; b=KNj/zD7Fx+byxAHjGzT/PmtJAt
	iJNI/inZGAEQmMcUW4YDjyq06wv/hStJYRbqMJUehG5fvzi2v60yYmt+Bp2twMtiBeeJhZ2rIcBW7
	e7pNIBzwyUCPcZasQOD6WQZAufDE7FZlkpXF2+yPhnFtDT1L9PS3Vj+4HAjv++oE5FTDbyMqBP9Zk
	EPO8YusvLGEb6Pgi2cnmGWsyx/7B41IjSDAfqU3+/0BHzl+3W2lDTCLxNMix0UIGfZyvLE4TOOylp
	Gu3IJPeQKj1CJ1TLqMFxEh5Z1tmggWokxLOqa9LjrgfAfRMRRIxQj41536cCb7m6OMdvH34XKDttR
	loQvnQkQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn81-0000000DTcu-3kdc;
	Wed, 15 Jul 2026 00:05:33 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
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
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 10/14 v2] ASoC: SDCA: correct enum names and add a missing struct field
Date: Tue, 14 Jul 2026 17:05:21 -0700
Message-ID: <20260715000525.739874-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715000525.739874-1-rdunlap@infradead.org>
References: <20260715000525.739874-1-rdunlap@infradead.org>
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
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v2: add Rev-by: Charles

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org
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

