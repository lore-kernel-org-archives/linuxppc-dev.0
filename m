Return-Path: <linuxppc-dev+bounces-24284-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40BAC44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfL4qsHz3c2P;
	Wed, 15 Jul 2026 10:05:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073946;
	cv=none; b=nTfsYbPY8htY+nYVwmFaPuDG9qcFzaZGgDXG2Dd5o8lAQo2yKoddoweHVa+KaT8LCc+SRlCY1yjtwN1PLG6qV1vZI8s+yEEu0JS7OaWdqRyxCp4ByRk/m/OjiBSJlTFCTq7txn5CofrKmttBeNa2Fwx6yywKFevgks5OcnruTPPOPTqGuBPGbrT0zv5owccT9qs9FRX2+pg3GcQjYroVBA2RvDiLnfKNYMwsi+DlpSR/dNeDCfbWRKYzhIc0SE4okgMJwqdRxVSGSzvQNx3Gk8qoZKwrpY58EDB9hfw2o980euLvG6Dvb6tq7R+Pcfn6NTLYdPzaJKfcj7bEVdO1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073946; c=relaxed/relaxed;
	bh=1/veRKqkCOO3tCdMqjMmmlqScA2diiWPP5iGYEMMiz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ln6X4BiUZdqrtN6LIOF6lLL4CO+kCifEBn4JTt5k3ul/nAUvSBLL+FOitGH+Vaehvvhzrs8zHkVej6cmTrhuyrW6p/RZsmehejVQmGyPw1Qsy7tUhM1y6l+RZIs7eLub8rFmjBop5hYT+KrhO+onr00jwIZukJjrhiVkVFBopQp3ipFDSqpK40tWPy0ihX1C4M7IR8P38q1w7t8p4LxY8AtGACeLB7s65/EwFUIKPS5TlZEBEeRKKlcw0QQsLkYmJV5qlhIbskwE7f7f+iyxbIVWWlT+XLrLAS27t8VGRp+EkPkw3Q5rzj8nVQAk62xAogO6N/LD+17v56OjcYR1vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dwvjszr9; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dwvjszr9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfC5qrLz2ywn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1/veRKqkCOO3tCdMqjMmmlqScA2diiWPP5iGYEMMiz0=; b=dwvjszr96Sl/xA7jvslf1Y5FWz
	guoWsAT1Vhx//VzkPfaOczFILPwpIfT4sG5aDBAtuXK/fsD/IvqI8RfUQ2FTUf06GfdKi5O4ptMuF
	JLen7WoXUA25092gzK0G3ckiP0z1m9TK2OqRB8EmVgNbhparCSawYJwo93Stgd565NOe4w7zUnzsi
	ryJ/2Xv1PxwE3w0RKLPUYWAqF1fPQALoW2gcNHBbk4zyT1AJg70/bNc/Ocgyg4GqLLAWnrD1HPWu8
	dCJCJL7SEG7KDK97hfIkWM3/eexRaYSCHLvxZOSEuSklmhn/kU70diKy4zmHjSxlveDII2tva1Tp+
	4M2O7H3g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn84-0000000DTcu-1Gx6;
	Wed, 15 Jul 2026 00:05:36 +0000
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
Subject: [PATCH 14/14 v2] ASoC: wm8904: don't use "/**" for non-kernel-doc comments
Date: Tue, 14 Jul 2026 17:05:25 -0700
Message-ID: <20260715000525.739874-15-rdunlap@infradead.org>
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

Modify these errant comments to use "/*" since they are not kernel-doc
comments.

Warning: include/sound/wm8904.h:119 This comment starts with '/**', but isn't a kernel-doc comment.
 * DRC configurations are specified with a label and a set of register
Warning: ../include/sound/wm8904.h:134 This comment starts with '/**', but isn't a kernel-doc comment.
 * ReTune Mobile configurations are specified with a label, sample

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v2: Add Rev-by: Charles

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org

 include/sound/wm8904.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/include/sound/wm8904.h
+++ linext-2026-0710/include/sound/wm8904.h
@@ -116,7 +116,7 @@
 #define WM8904_DRC_REGS  4
 #define WM8904_EQ_REGS   24
 
-/**
+/*
  * DRC configurations are specified with a label and a set of register
  * values to write (the enable bits will be ignored).  At runtime an
  * enumerated control will be presented for each DRC block allowing
@@ -131,7 +131,7 @@ struct wm8904_drc_cfg {
 	u16 regs[WM8904_DRC_REGS];
 };
 
-/**
+/*
  * ReTune Mobile configurations are specified with a label, sample
  * rate and set of values to write (the enable bits will be ignored).
  *

