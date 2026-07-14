Return-Path: <linuxppc-dev+bounces-24164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62926C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvJ00kZz2ywn;
	Tue, 14 Jul 2026 11:45:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993499;
	cv=none; b=Y1dYUyjILXvUkdzez3haGMBU+1RKBnjbugbSRpdg8OpMWTJ3WxHhPwyPeTzXVts9KjHakVOEttZdzhnqC20Uejop9pRuK7bKsTqzb26y9tMnvwnDvxLtWyOC/jYp6bWjzwFJhE4EgnYaXNvL6soCum7Qwt3CnekgzgJVQLAnIDgl9oeI2IU4ZgsSq6/M2CsOENa9MowYB4Hh4Jh+XT/EldMySYDQoz8LlzWUJV3JTyrMiTMhK1ou9ra7hN7G/v/a4a/jDzHu+/yJFL/Jz7N/RC+zd4eWeCFSx1Q84bOr/28KkfsQMk5fUqmvwGwEUK3krCi3XRdpAl1qJz0ZYysJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993499; c=relaxed/relaxed;
	bh=+vBVSAe41gLF0/LGe0VpsCrXwVXYW7rQ7Wb7b1sitdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jsm0cMd8S5Qj6Fei4KijBlFIuR/bStafYGj5TKapqmdqg0waHrEOu2lTSURiA0qoAyhOjiD6CEge68lbXv4oSAKh82kV9ieKCuZ20+nXEQkTey8F8HZ/FqjWA0SnkldT8LjsLlXO2T0YTW3iRFCiecQz5Lvq2g3tQam1kaITbSv/4vNBzOKlShFk+wytEeMyxqV7Y9NiqvgU8oNsxRhmv8muxJXPRM40REKemAJrWSiaib1o5FBv5aOpZkigmbB9SCPb9Q0ZP4dH+6pmbjP21oycX3FhL12MMQWM3rsmS6a9krYQjwx1QmDHImg9s3sNDlyMBlx02REmLYVu/jfg+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SfWUes0N; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SfWUes0N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvB5B8hz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+vBVSAe41gLF0/LGe0VpsCrXwVXYW7rQ7Wb7b1sitdE=; b=SfWUes0Nc11TcnAEjLJ0+AVRtx
	7ubgOaeU6TwFcloAiOllAJO+VBV6QqTl7DOlxXbdB45DOfO567bZrAOX85c0ifY1vP52RdlTXNvWN
	yd0ex3V+Fyv9sl3lWcTNziorPecUZYB5OvrY64wss5VJcN0EOrHraB0QZqcV8gT18bxvzLPcFUQmK
	dWzi0laly4DiKm3OhZmjkRUEJ8V8e3fuKCqxHayAgHgttzpassTMyUBAkjRkkckf600I8ORzQb+wG
	y5EOcTQXNoRPB/NMWl2wRBw7xe/Yan4JHPaaNRDFnOAFKVtpZvVJHq0wck2hfBfzvz/55LRWZ70+D
	9EiuaXKw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCY-0000000AgsR-0Pgv;
	Tue, 14 Jul 2026 01:44:50 +0000
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
Subject: [PATCH 05/14] ASoC: fsl_easrc: use struct keyword on structs
Date: Mon, 13 Jul 2026 18:44:36 -0700
Message-ID: <20260714014445.569992-6-rdunlap@infradead.org>
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

Use the documented format for kernel-doc of structs to prevent
kernel-doc warnings:

Warning: ../sound/soc/fsl/fsl_easrc.h:606 cannot understand function prototype: 'struct fsl_easrc_ctx_priv'
Warning: ../sound/soc/fsl/fsl_easrc.h:641 cannot understand function prototype: 'struct fsl_easrc_priv'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org

 sound/soc/fsl/fsl_easrc.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/sound/soc/fsl/fsl_easrc.h
+++ linext-2026-0710/sound/soc/fsl/fsl_easrc.h
@@ -584,7 +584,7 @@ struct fsl_easrc_slot {
 };
 
 /**
- * fsl_easrc_ctx_priv: EASRC context private data
+ * struct fsl_easrc_ctx_priv - EASRC context private data
  *
  * @in_params: input parameter
  * @out_params:  output parameter
@@ -625,7 +625,7 @@ struct fsl_easrc_ctx_priv {
 };
 
 /**
- * fsl_easrc_priv: EASRC private data
+ * struct fsl_easrc_priv - EASRC private data
  *
  * @slot: slot setting
  * @firmware_hdr:  the header of firmware

