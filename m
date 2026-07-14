Return-Path: <linuxppc-dev+bounces-24167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD9DC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvM4Bpnz3bp7;
	Tue, 14 Jul 2026 11:45:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993503;
	cv=none; b=DH3kbBqxvTtdxS0JpqP5TAce0c+b+XjzXcl1jZhLrlfGOWhRxvTNpRSXYkAxGKa5MtnGV71JhdwHmDRraCNKyqVLJaGThJZ47I8nnhIf1F1PyMITCqR+vXFAcpFEMGCiRaRfTrebZdRRbE/5WLUFPjk8OoajSXzQ/Tb7RRpKGxFvuCtdzb09nzX6TNSHzt4zM/SWsjUDtUXwnnb8SwLkWn/71SvHkSQLL9Ww4rbdp4L689Ehud5p2Say4zoXYw/Ts0o5IjxHq+qGZ4NdXytOsfzDFkIwm5q0iRw6k5hpgaZv7U2X2mZpoGko8mrpZHIL0oW77iCIO/HrBZV2Bj7lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993503; c=relaxed/relaxed;
	bh=AP+EjHl4fkplBLEzqE85avbK3Q0+8lYsmdrsTbCkoWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWuOU1YvsSyhFoViMBZuANEZVn0v1GQshXVIPYGIm08WLjGjXwzjvNXFVRK9RY3/FH59JsdhqwLuNxUg6CMAF+c9lZqUwz+SBHaaUFdU1U/3Ux3N39Vkzqvou+aBNearkZdJUhal6F9k1Z9bcpREJ1TT9JAr0YuQqM3tLfdK/O+S2M5CdV3NlmI1r1k2ONc0NtOPCwFKG+U5D1ApBElw3kLeJ9kXjwpVwTw4ELwMpqZNaA5pWTRqBTw1YrDkpFGcFBMI0OiJS7WXpxcV1rPY3qrmI1x+WXavbGWBhVnuzFt+r2OfmEJ4ZN+MMC1PL/jxx6xo+8flYGiJHNqLnn8ynQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=goRfGHv+; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=goRfGHv+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvF371Rz2ygs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AP+EjHl4fkplBLEzqE85avbK3Q0+8lYsmdrsTbCkoWk=; b=goRfGHv+vWeowQz0+5fZt8Ltle
	GKIXWjiWFAKUKU9RH1zyyNe3b5KtXU8BBqnU42TgoVjzH59opvV3ShBT6caOiPlG6nOPXSzhszvYj
	hGdpo7+AZkSsYXrvIgRGXyuUN9gD1+OIu3HjTQPnnkzOkDFmsL7Q/ucz70QCmrYPPUQIBRn8Z0TEo
	DyIyUUz6k43skiuHqAiX2SSZbFmqx//1GcAVzyihOTO1CyLCZUAZWMv9MmAfgwg1dVYvk38fHRtuG
	5Lmr7YcwYE1BjZ1AUFMViwTfvdmYgwOuu2lca/4r/3783MAl0r02FARn4i5w66VpVcdhmFncvsdeh
	L/LI6gBQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCc-0000000AgsR-3Arg;
	Tue, 14 Jul 2026 01:44:54 +0000
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
Subject: [PATCH 13/14] ASoC: qcom: audioreach: use C-style "/*" comment
Date: Mon, 13 Jul 2026 18:44:44 -0700
Message-ID: <20260714014445.569992-14-rdunlap@infradead.org>
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

Modify the "/**" to use "/*" instead since this is not a kernel-doc
comment. This avoids all kernel-doc warnings in this header file:

Warning: include/uapi/sound/snd_ar_tokens.h:61 Cannot find identifier on line:
 * %AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:           Sub Graph Instance Id
Warning: ../include/uapi/sound/snd_ar_tokens.h:62 Cannot find identifier on line: *
Warning: ../include/uapi/sound/snd_ar_tokens.h:63 Cannot find identifier on line:
 * %AR_TKN_U32_SUB_GRAPH_PERF_MODE:             Performance mode of subgraph
Warning: include/uapi/sound/snd_ar_tokens.h:64 This comment starts with '/**', but isn't a kernel-doc comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org

 include/uapi/sound/snd_ar_tokens.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linext-2026-0710.orig/include/uapi/sound/snd_ar_tokens.h
+++ linext-2026-0710/include/uapi/sound/snd_ar_tokens.h
@@ -58,7 +58,7 @@ enum ar_event_types {
 #define SND_SOC_AR_TPLG_FE_BE_GRAPH_CTL_MIX	256
 #define SND_SOC_AR_TPLG_VOL_CTL			257
 
-/**
+/*
  * %AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:		Sub Graph Instance Id
  *
  * %AR_TKN_U32_SUB_GRAPH_PERF_MODE:		Performance mode of subgraph

