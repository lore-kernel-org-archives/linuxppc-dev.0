Return-Path: <linuxppc-dev+bounces-23521-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA21EC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:47:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQmJ2jCGz2yfS;
	Sat, 04 Jul 2026 06:47:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107666;
	cv=none; b=a0SScA5jMRKXLJabCIqn2UUZYqdgRSpSyjcU8sUockZYjooaAePoeEMhFujHhsdy/e9ZkWpTSgudCeOazE7KCYF7ykr5pubcRLQIxdY1nIzB7Gzeixu/ld2ltMrt78TA07Z1cLcO6z1fph+25/+bWgaemZU/04o3/oOmiJFExqzm542m+o9Y9kcUZ6rDFEogG22bi/WTpzHhgDXoFBSZBq0FulHzlYGeQl5o/7tV8XuwuTKXDxd6tq+OnWQls88vkzSFHoYEdB7fw01u83k3c7OQGnN21sz/dX+BGmnl/Okagf2wdtSVjrzpL0VW4OgqNPgCaa+Rr1rwbe97xs6TQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107666; c=relaxed/relaxed;
	bh=7S6HE1h6m9lhE60GLkuRwg8Afko2RFFjs4EYPEG7HaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP+eKjLR36hhOl1zMs7xeaOGLzTs67WYW0Wx5UO/D73Uovv+lStM1cMjAG8LT9AX8Fi/W5UplLlAeaZYPuy/hAlyrVPARS6t0jlMGdQsFdZcNNK7iqEfn4qQ2l2ufSERQq/sqXXud+xWX/O2iH4satPWNuld+z5RBVVEVBPid97Jq0LGU5YM6/9mvbDIKrsAVw8P5bvA21iRvhq6UV9yW6TA/78A+vYhbE057hvx8Uj62E33PDShKa8bK/Kclfetulr1W58GT0g7vmQMWFljfPsV+m/mvUMpABo2kRHALbqu+6hpPzWm7emajWim6OovLhNsT91H8TvFwDWGjkbxag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BWHUaZWv; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j+KSc+hW; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BWHUaZWv;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j+KSc+hW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 72 seconds by postgrey-1.37 at boromir; Sat, 04 Jul 2026 05:41:05 AEST
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPJ11Grqz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:41:04 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiIHf683668
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7S6HE1h6m9l
	hE60GLkuRwg8Afko2RFFjs4EYPEG7HaI=; b=BWHUaZWv+bF9yKBF+/TmAfINoX/
	JDQrYh1NjTGMSYWenUzFcBW7g0gbb+J+tyyNa56aj4sFeHGr3rPjjEDb8QbkBV3h
	KI3Vv8WYnY+o+4H00pvmBAdFK0PUp1dOXrM7+u3zuzfdWIdWke9AUcUJH3uUSxPT
	vQqu36jx0ftIDpgqrT4zTl9ahgQOi0NiCOdoTQREaXeNRfTSMs5kjjOCwlH5Ue1k
	zLbyHuCkxdDFhfryu5s/sG/7LZMR1EHCn6DL8cTFv+HpaM0WeShlHADd+PvnW8Xv
	B2oy+EBhx3rxbvnLnT43149pGltQRY09RsmrapivIiWSZbFohMSsgSevu5A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5brty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:41:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38096521198so1448719a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107662; x=1783712462; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S6HE1h6m9lhE60GLkuRwg8Afko2RFFjs4EYPEG7HaI=;
        b=j+KSc+hWRPNvfZaOhtxzTWB9cLGSb9mrtckHZkTqEGe7tusJ+bimyynkbBFU6llYSA
         MVUQlUZGrX1MXIWG3pfbtG9LqD7GDK5FUB2Oiav6nL4vg8GxqUtJAHzQI6R7+XyNV4fj
         19JaesF+ggWjKriQ0E9Awb3CKDVyGPAEx6VErwQSrfVOxDEITSGFpLZHCFbWWp+/LjM5
         dilkk0hlDqkphFxSC3mDe9AMofcc8R4cWX1eqyXoE2UYnuOlzzD76iN9fZDkhxSedauU
         zZRVGPFHh6azbvyQNxQF9oiOVoYY4WdvYNfZSIUcZA/AcsP1AFD+YUO2NKqVZ2cVM7ag
         GCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107662; x=1783712462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7S6HE1h6m9lhE60GLkuRwg8Afko2RFFjs4EYPEG7HaI=;
        b=dQX9N6xOyaSPVIbFNGkl3A+CL39PmJCh1XQOh84hp+HoTPsCDnyb+L8s4SwazNML/D
         CbTTNzUlu/rM+QdwYqkvmmFxCTqGxia6b/DRq2pLmzp3Wlv2kZm+Oc0MeBcA1wvCfdUT
         XjpcStu4J7Y07IENnCQoSxhWjNt4KX+IXECY4+s/3r1qTml483mP9O3QRkcbevjHvBRh
         qXEDrJ2ucECdkXA4d64isip5jmDLpwgHsFVYRfbLElSeH3TU1KoProU6P2pckeafgNXh
         Htfbrzjn5rYp0dDad1PDkE193xEp1C1VtGMDU9+d2XVC3TH56PMAF5CcTRCvY+qFZoNh
         2irw==
X-Forwarded-Encrypted: i=1; AHgh+RrvsNczemR+8h4qtZ/DSmW0Yi4/1sSXazUFW/O4Ijfu8S6PsXnNDKljk041PmHoF+j9le7jyoyMSmfhBwo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywv5dSNLNHAgsPkrozGbmwIiHta2SBJk0nthE3I5m/+rsg/ov/M
	/WRM1kAy1Ncbb8LEZj2SUSzkR4Jxpr85vFaH5Nxi6NnfVB+75ka5/EDh3a7JvPNiyHt5ZjzsRYI
	Se+R5tr6jVV3fQ1KZnBZ7jKmFgNz8/7ZMb8g1rSBOlwa71ffTcMRt6NxYWoFgoq71oSxJ
X-Gm-Gg: AfdE7cnxNHb+JJ1vZ66hRw3HvIepRWvcjOHoyOOELM4Kbk7X73r7AhAbIHP4fMrWsMO
	hn1W8NOFVz3YLkeVFyCAbt1skHz34SBAmF+yUQt4DkWBQps2keuELsT3vFQx6kMzVxwD+q8JOe2
	HMrta69S+HXPJKEV9pxJFIrbdPrSACSM2yWAt9xP0BCb2yMqejEquCZOyT8+anP6ntLTr4g7sHS
	8EXCK+5BPxRPoFTjsLptFtDZtsG2lcFUJNNlmIxdOsO6cs3qHn6flFA2euYiLnOqglZwJNM0VcT
	yD4AuLqIJn5VwQ5PCnDAjchw/FU3gMJTBPPeV+faM5ZDd5cwXxG0ZMgPdfZi2lPpMArSVhcYKb3
	yJesgLzi3raKlGMRokHsvVFMH6jutb9e6K2Kxag==
X-Received: by 2002:a17:90a:ec8d:b0:382:5c31:1f8a with SMTP id 98e67ed59e1d1-3829f7e92d6mr770728a91.27.1783107662206;
        Fri, 03 Jul 2026 12:41:02 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8d:b0:382:5c31:1f8a with SMTP id 98e67ed59e1d1-3829f7e92d6mr770661a91.27.1783107661655;
        Fri, 03 Jul 2026 12:41:01 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:41:01 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peter Chen <peter.chen@cixtech.com>,
        Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, linux-tegra@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 04/42] remoteproc: da8xx: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:17 +0530
Message-ID: <20260703193855.110619-5-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX6hrFc6C8KnRe
 /9MhheK1IPDsjJ0QhMPtX37KvmLkUkb+WwNhiCUIfGlAPX7aLCUHYX6fJY/r7/Batmm701izcdz
 4vZi1wlURnfLcA2d5OURnC+kwmLblg0=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a48104f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MiZJTWugLlTGxHTZgFEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: oeh852mKf88nlbn4yK1VVqZg-nsmZJsH
X-Proofpoint-GUID: oeh852mKf88nlbn4yK1VVqZg-nsmZJsH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX4Pkb4clgXMtw
 aG5hj4jUqBHYzn+C8t297ilIMt8Zw/BhKhuhyzcZdiKh6Hz8SdbNA3eqUEyjOLL7ndSxnqJVz8E
 I/NhL5pi4QO+q5g4yXAuLpyL36u7AyoUNlKmaxs2DXBHOjJ1R3PG4MK1H+7El+leVdl7l2KYlWw
 5V1RUs/2KmcB5/D3RRvahpzglAGXmR4gGYj3rMLMyUjOWC9Hl9KU8V04/5ro+mnHswHmlm1oT+4
 LOvDUzbcqaL3NfY4+N8+ufyJh6VSEzt8oPoGtC4DBNgBFYUqj9l7dBDVyqpFs4JUxxUw2co9A+s
 IuXXRUvbJ6wFRrRNFyeJCnn4/wSDpwMUPr4sI9p9uzbYEaETILE5P3sRw4xKz5ZFmPjRAW7nIGr
 sc/zMfnkhAg6VDgsh64O9B9pxlomb3Ls+jUiR6gBhrYgC8m9bi3BLMRIS5tNiPY71zbmiL5gwmq
 A/97qHEjsbI6nWusQSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030198

Replace the hand-rolled da8xx_rproc_mem_release() devres action with
devm_of_reserved_mem_device_init(), which handles the cleanup
automatically. This removes both the wrapper function and the
devm_add_action_or_reset() call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 23fca7176539..cd9a8f2b3163 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -230,13 +230,6 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
 	return 0;
 }
 
-static void da8xx_rproc_mem_release(void *data)
-{
-	struct device *dev = data;
-
-	of_reserved_mem_device_release(dev);
-}
-
 static int da8xx_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -267,10 +260,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 				     "unable to get reset control\n");
 
 	if (dev->of_node) {
-		ret = of_reserved_mem_device_init(dev);
+		ret = devm_of_reserved_mem_device_init(dev);
 		if (ret)
 			return dev_err_probe(dev, ret, "device does not have specific CMA pool\n");
-		devm_add_action_or_reset(&pdev->dev, da8xx_rproc_mem_release, &pdev->dev);
 	}
 
 	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
-- 
2.53.0


