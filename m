Return-Path: <linuxppc-dev+bounces-23547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7C3C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:52:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQt46pYrz2ywy;
	Sat, 04 Jul 2026 06:52:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108152;
	cv=none; b=SFQ566CUbjcqNiN2olhfwE7pgeTGOgZmdt0O7aKb3xMHQ+xey85ORhjbgfb6OXCJ6QbFSNrOfzBZDgcL+9t0FEP7fL2ckcLl2j7bZh4/djybiRNwsslK0D14p7BF+4d68TivJqOqYUBGOPJzJjIZZN7/ABsHU0SysRvlv5ET1ZVnXWutUfOm0OSneEk5562kpxBbyHls0BzyDjffWYqQMSamoYdQEm/DiZUCL5CniBhOsHRdF07wAPwFiadjK/HMopcEFi4ljJHFqyduOqWolWaQncE9Op0DyTJPyqB3GYBFddEmxjderCatlKuU+KUn5LfISY8Oel+64AC4T3JvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108152; c=relaxed/relaxed;
	bh=qrLNvvBd1ILtTArtQX8hnsFClrmyzhIwysun4St2jcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltzOoSV3A2Iw0IxsYEL/q52fKC+QpRFCkkVfpyJhC0hRRqrVRTfUQJBqIRyPhv/I2azUlW3h0Wfl0db5mkxK41LzVoTLE7Wg0NQgLVgfT2Eh3TiExvodrHLZLINGQoL+wF9xaqqqu2EbwvEbvkKGaOdqiepkJu2NJ0Bkb9lFD0/g8w1MGoynlphAK9uqz3ER0+nlzRUUd7xoLiRQ66HsI4+iHIXzk4dUSrilss6bMtrnOXxhGsmHme5isk/P6S+ODHXYp3AEsFXza3lzcqXPxcCzGHiiVjfLm/rTrCgHHe8tN7afQ5XazpwR5SfP4tnWZ9pG60y7OPG+lRmI45DmGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S1EkCV5n; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VwfDHlM4; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S1EkCV5n;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VwfDHlM4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPTM1lgkz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:49:10 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiU7v676153
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qrLNvvBd1IL
	tTArtQX8hnsFClrmyzhIwysun4St2jcc=; b=S1EkCV5ncADGpatu+eYZt750/gJ
	LNLywLK3880MOVcH/tdC1TcI+OqeOew5eBqmPBQw2WxbhuKJxdDehFccfF1Iw06A
	ah4T8eIEryoVXAk78NJxSVoqTVGOs88jJDt6BItnQh/marGnHSf8MAYdrnL+EvAy
	X6tFzBtTSIu8UyHQ/B433/b2JRqYdep4RBZUNOlTI8pJMS+8R3opxr2x38x/E7Ig
	o3oGK6JEOl8FvcuYjJVxSgdKyDxnHNT4LXiEu6qE8OpEDqKzfYrsezcTm8AvWFnP
	9MSzx/BgCvxY+6M1AZ4K+vK8GI3ISog4BM0DfWHZ8CqfNzkkcsMDn1W9VAg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkh9hp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:49:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8952346bb9so765877a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108147; x=1783712947; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrLNvvBd1ILtTArtQX8hnsFClrmyzhIwysun4St2jcc=;
        b=VwfDHlM450AanF0s2xzQQB+hSBI1Ay1jphB4fpotYJxBz1Jks0ToQn3cZBYEqJ/tkl
         chl5wJCYkCfd4VWUqbVucx171YaQDxkDajcvFvzENwO1Mx93MCceBl4mEkLlB7aRYXHj
         GgJT9eI0wEwnu58nxdyPxdZj5ZJKpjnEy1ieJFf2nmP4zh3ourARRkA2+ruOJFVafJyX
         KksJvh98vET99IOd7BE0FPx+Hze4I1U4x4hFyPI+2nmfqQFajV3Ky9JzzXuMCUVc9Qr3
         UQS/zLHn/O6YzRX318FhEJSSq9rcOpO9jDrN/qqH0mh9Y1icxlELuNk1CyYKsHyOw5c/
         ILyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108147; x=1783712947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qrLNvvBd1ILtTArtQX8hnsFClrmyzhIwysun4St2jcc=;
        b=qD1lxMhCOalhoTqJYIs8Q/VI2We53Qiw71irUtWhG3HvUvq0iqJDraDw0f+wUnQSmP
         Ea/9FKuUja6antPXfjwPdpSEHrQrd/IuXelhlF1ajhT3BeZAilOkMs4Q0O3vS5Rb2hEm
         HOcNZxYgmBUgLdvAOZ4btzSXv8doq69aEsaToypAWuqBUbtYGUZcG1r8wQMTukkRKbZV
         PnlRckAZweePLY7qCV1UkVhOAGKlPyexvdwUtVBMD93wUDbTmgJk7cvtApnZBkZ42O58
         /KGDrKFtazo0sfaL2jDf4IIfiIHwIqX3cZErCM3yg+HZSiFbu40JzJeeIN3uGrg2Ch1d
         1gRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0s75eNERNUVDyArqtO694H0S0L/AMS/thdfbm93yZRlwxbp3tsse5Bb6hnu1iOq+FLi3Ak3mYjYmPNe4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5Zpu6iYF/LVZy02G+D4nBT9cmnwc6F804892s3+VZbaZkTL8R
	Lgvr6LF3HRAyg1UUf56Qt6vuPme1uk23Ge62q1uBpctn7cvFBBdElq27Z6uAAMUGi5oVJwww0TN
	byWt1fpZY//CCTUiaOXVcVUUmsEnvLT5555NY0fFsF6EmInu97/v9MV2QZXjQyAPNRPw6
X-Gm-Gg: AfdE7ckIDv43eA+RubB7BBzxsK84fnGVjGdXYzl22HkkGr+Q1fs/Bi+hoPfi+pgJqbf
	XdEBogec64XkKQONPPgovEzSGv1tKcWPDrTJ+PGKmtcCsryZTrFfB+tI6WeAmMTyYBqgrBTLCOH
	qeYDtrGMN7Da3t4sv6k6tGVPIxUMl2oLstdslw10VemD4m66QqQKeH4tdg3rj5l09R4jmskj7DA
	YY/AakgDNQ5HoctFornGv/Y0Y/yXWT+ugHPbCjJkz58Vgk79/e3xzJtURH+OpD/NJnW3XFJ2EM8
	joNJHY8lQp0jYVeN6ZIEfeyPFT57jfy1hHWUncHDdJ24Ma+qQaU3+1ruE6Q2aeGxf0qng2IFsgF
	xyah2L2L1Oeg9ajOMkgNGH5XBEysdzInUOdsJUQ==
X-Received: by 2002:a05:6a21:6e48:b0:3bf:6c04:a816 with SMTP id adf61e73a8af0-3c03e4da45cmr721891637.55.1783108146896;
        Fri, 03 Jul 2026 12:49:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e48:b0:3bf:6c04:a816 with SMTP id adf61e73a8af0-3c03e4da45cmr721855637.55.1783108146324;
        Fri, 03 Jul 2026 12:49:06 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:49:05 -0700 (PDT)
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
Subject: [PATCH 24/42] remoteproc: ti_k3: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:37 +0530
Message-ID: <20260703193855.110619-25-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX1utgOaMxI00d
 VordflykZV8HEBFbXYL6JruCIT54MRU+nt2E5vkE0taBli42df7INEztiOGmIU0SxUw5WFViyfh
 mLuuOHKYt7itS/R6jc+1Sm8lsrF5z3Bm0n/MaQfTKoI5yuIL1jqnkGv41XEMNP2lkcFhfa9qJ/3
 c3I6EQd6CAaUvBeiRvwHgTteMNFvCrWNpCqyOawPXZ1FTV6XfGGKRRQx0zaecKK2ql/ReLyDsjw
 80Snshk26W1WP6SeD0ezJyMofXEwr0X8rzaaA67eR1hc+JA45GAd4DxugsKi0D+O/tyDz+H/WnY
 POmeoWmMKB1WkDDXbn2guNA+CBA7GYXCUxKFrIyY1pdor391JzGtGNbl0P8MWOfJSWbn6fV16DR
 vuYfSHd3pJOcqpKZLG9MWTeXsvJPqmqEGymFzLLh1xqDo6yZEiRqRs7QBjZrCCrx9BtmRgq/aWF
 BK9WsTO/CNb4qkvReZA==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a481234 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=7v6Lk8RlztZ-GcM17LUA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: Audh_6mAQJ8X-Nc9fvyJXN67_4MBXjYg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfXyU7tJGQaSnIk
 4mNPd454NmvZS2g9eBJHwlJAHANNqtaX/a3JK3yDYVKcaNb0htEgsvkhEHFYufgALPko1IOSR4N
 ua1RdHPiNrgowGxaE3Bd66AH1X5cBz0=
X-Proofpoint-GUID: Audh_6mAQJ8X-Nc9fvyJXN67_4MBXjYg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030200

Replace the hand-rolled devm wrapper (k3_mem_release +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource
manager handle cleanup automatically. Remove the now-unused k3_mem_release
exported symbol.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/ti_k3_common.c | 13 +------------
 drivers/remoteproc/ti_k3_common.h |  1 -
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_common.c b/drivers/remoteproc/ti_k3_common.c
index 3cb8ae5d72f6..f08b9e373220 100644
--- a/drivers/remoteproc/ti_k3_common.c
+++ b/drivers/remoteproc/ti_k3_common.c
@@ -458,14 +458,6 @@ int k3_rproc_of_get_memories(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(k3_rproc_of_get_memories);
 
-void k3_mem_release(void *data)
-{
-	struct device *dev = data;
-
-	of_reserved_mem_device_release(dev);
-}
-EXPORT_SYMBOL_GPL(k3_mem_release);
-
 int k3_reserved_mem_init(struct k3_rproc *kproc)
 {
 	struct device *dev = kproc->dev;
@@ -486,14 +478,11 @@ int k3_reserved_mem_init(struct k3_rproc *kproc)
 	}
 
 	/* use reserved memory region 0 for vring DMA allocations */
-	ret = of_reserved_mem_device_init_by_idx(dev, np, 0);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_err(dev, "device cannot initialize DMA pool (%d)\n", ret);
 		return ret;
 	}
-	ret = devm_add_action_or_reset(dev, k3_mem_release, dev);
-	if (ret)
-		return ret;
 
 	num_rmems--;
 	kproc->rmem = devm_kcalloc(dev, num_rmems, sizeof(*kproc->rmem), GFP_KERNEL);
diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
index aee3c28dbe51..9a58aeb3867c 100644
--- a/drivers/remoteproc/ti_k3_common.h
+++ b/drivers/remoteproc/ti_k3_common.h
@@ -112,7 +112,6 @@ void *k3_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len,
 			bool *is_iomem);
 int k3_rproc_of_get_memories(struct platform_device *pdev,
 			     struct k3_rproc *kproc);
-void k3_mem_release(void *data);
 int k3_reserved_mem_init(struct k3_rproc *kproc);
 void k3_release_tsp(void *data);
 #endif /* REMOTEPROC_TI_K3_COMMON_H */
-- 
2.53.0


