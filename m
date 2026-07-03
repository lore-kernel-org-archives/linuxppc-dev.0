Return-Path: <linuxppc-dev+bounces-23546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A2FC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:52:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQsy5NQzz3cdM;
	Sat, 04 Jul 2026 06:52:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108127;
	cv=none; b=EROAkpYAUKB6uA25hv7SoJib66d8oU9Euv6r+whVshRo08SXqTm/kko5Da0e9ylnqDZ4Gzwu/gZ/qlqh7EBj2HCxjMHWLcjjUGr7M2AvOa/uH8RBf7MtrcNOOr0HOHSB0Ij9meTJgyOMCZ9DuelJ+qOeBc83JW7vBOjh6VRjO9QqFyLdbfmVWkbyuCxmm0LoOq4/rV6HzFmfsKiVXSOB77SrYSz7VLeitMv5BLAloW62RvMU2/JX6ukufWalucruIAh2ntTeM9IQ2WRvhEUfg0Jd+vtw9a4pOwjD5u6pmzeBUDYYGyL9hNr005nyNk8SRV/61KxipQq+YoG1+WB0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108127; c=relaxed/relaxed;
	bh=vTaFds4j6VItza7UvAMztb4cdgVduD/jcDAbw1WAnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBJ25bbftuR04zEc8S3n3SvyX7bVqTk+ILkIGYxE7aL1Hjw02/byp2hmNnY5mYhaJ6fToF8IPOOvxNzKvXBVz7fc08/h84ZFGekf4jJEcRUnhXIqj2csi32H1MOOu6ziMVArkXAdbB5z/eGKDYOHOhIc21cTIdjazNDSHWdmu5O1JBW37Uk48fNbU6OqiDkxavcqnB9e/46IKX0OQs8DK9zC7lp3WuSopoNEadYNpO1h/MB/WfmJqyWNa0KP5MtiJDRGObofQ1c41zT+Tdg7q0AUqqHuiAXqFcADHgrMpYYCNnAlN0kqCLvbwCt1l2HjpL6BMeCRtVZFx4FaGP4j0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oe2yBMtu; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WblGQojr; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oe2yBMtu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WblGQojr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPSt3mkjz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:48:46 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiX5N662857
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vTaFds4j6VI
	tza7UvAMztb4cdgVduD/jcDAbw1WAnR0=; b=Oe2yBMtuiakzJoNHyUhWZrUssrK
	VkYy44as8rYFaPVY3qYkY58rW5vsbqBLlEVR1wNCoOP409lsvwRermF3M/2rZckO
	jDRSAa1yhBNtN9Z35pxSi31zhiIjTvpsUGRTw/pqHw+R0wHgO6YcLOKJUyc8SVKP
	c6zl/n2I5OUPpbZRdTcpiWOUvbo0NlKiTQ5N1OKL+St860bWesJlesEKMiGuGXfV
	2eby/uOoEfslWXMef31inHLf1ztWTQyHIMq7e5WpqVs0l1nAzq6GJnq4lPGmaaTM
	w39ZQFAZOHylcs/I2t11wpHn4o1yjBTu6D/2Ao7mpX6BoNbpRrVQAm2oUnQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eycfqa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:48:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381120d6d62so1548526a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108123; x=1783712923; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTaFds4j6VItza7UvAMztb4cdgVduD/jcDAbw1WAnR0=;
        b=WblGQojrEQC9kXSADnmu2sqDyNhPpFHBpQvXl/mBttMdWK1kl6wQIY6VPpNDDs8zi/
         PuIrcNqt8RAEal2wPhzLaBJtTmdyCNb9bYOtGLZsasqvurQ0Jxdd1pV+PK6qbhpIzSfC
         7m5eGXCj2NgWKGVRZ5VtGRusrwznwSLo3I9008oGQcpnEYGzPui+5e0/GnXmZWMCXTZ9
         Q0IyZuNRUWhyD5R0cM5YZy6hXib8hVCNgbvemQPAWA0atrfwX3h0GT76fBnpew3yLdi5
         gw2GH2UxT7ro0LAk6FqXXnTbnVOiOPuiNHUyeRLgZE4vJQhGXqdnqL2K9XAwMy0KBB9I
         J9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108123; x=1783712923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTaFds4j6VItza7UvAMztb4cdgVduD/jcDAbw1WAnR0=;
        b=abPZiCnNqSRfdOb9BvEShifKn0z9S5SHE+gixlVRB/xENewRawGpehneHWneMZyh6I
         8++RbNxQC+JY3UqjCZc9ktUwA9249eRKX2j8jkn1jaeAIPzGs8yIKgtV8P32Fa/xUa86
         9xc71dNzeGp55VEjWq9Ytpr8OZVXxysknTppdy8I9ojw2nzrFsLGWln9qVyRwZPMdoPh
         ezP/nmX1hjNN0mUlNypDhhTC3cKVYmwqWSipLt/J3k2XoumFVADPlnYnyFFGXkGnlogb
         eB9+dnbIjJjaXBaptGT/LhJNJr3r/l31fA1l5y5ZorqA/8BLBOxu2iYvU2nMK8brd6UL
         ic1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp7VP+PUF3waAYxZArbvXaeBrpQ01tzhCJQqAkARWTfRzxZNM6QutQlW47CDxrm17NKD8xw44ctUSp1CRM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywvi+OfGEJGuBAXrBNGqG1CFYncMnMy7jcAtvHtxnvJoxi9NFQu
	ifAD3Zt7oKzBTXNOHPDK11uz4TWqNIzw1q2Q2lk007MD6SpCKgeOpptHZDzN4MRUXl5TmY201uK
	aibnmSz3WQh2FQtIeSIgZ3zB/G1AJko7IXC4C2Cfai4+8dLCO1rxAJAA5xM4PP7sTV0lM
X-Gm-Gg: AfdE7cnJyvyu521FagV8gK85QRr8PM8t4LMtieN8SwmFflnFxQ1otSEFDfrZM2nzmYB
	sEtrUsMIaBlbMJQHu/v/msR875yOv180kIz54GP5+ZvlSHfA0s1YEI1tIUs4SCBE3tfmFqpPrtg
	xKjbR+ewvwLWGNdz4bOj7Oj37bE3F0/mmtG3n552fjUAA/GU6JFIm95trn2yHPuAHpCrrfP5nFf
	g0HiBvhEWkuinNFd6V0z+e0d42o45u/vphNnzDb9Ovk9vG1W+ACBNvJkXLkBYbZb8z4HujMW7ua
	679px/QwjE4KLq0ftZ0bIB5rVgli+i7P8iHwrg4gGG2eVeBQrC//gx52pTuMRJA8fWhH1lazHWY
	XQN1oyaJlaReYiiWwYdpE1GsbMi7JXxOQf/bYkQ==
X-Received: by 2002:a17:90b:4a46:b0:37f:f89a:a1e6 with SMTP id 98e67ed59e1d1-3825c50b0aamr934548a91.0.1783108122628;
        Fri, 03 Jul 2026 12:48:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4a46:b0:37f:f89a:a1e6 with SMTP id 98e67ed59e1d1-3825c50b0aamr934462a91.0.1783108122019;
        Fri, 03 Jul 2026 12:48:42 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:48:41 -0700 (PDT)
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
Subject: [PATCH 23/42] mmc: sdhci-of-bst: Use devm_of_reserved_mem_device_init_by_idx()
Date: Sat,  4 Jul 2026 01:08:36 +0530
Message-ID: <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfXzp8opAA8L1Et
 yW3lf0B5HfleMXOymfKCnP2yvx3O2lm/4HQ1XKI2QBQLzqimDLquC/JDGVoIHRP3xAAy2BhzyVN
 fmp2mniL1FP6FHfnCEP8Np0ZbSXSu4k1CqleoQU1pwLJ2ywXmbirnFd78jeGLUT8WfyZdZ9ftyD
 XDHhW79hM6bj0laT38tjhvKAIU7ct8TjGDsYKYibI9yOwXd+cgMZLcpWmDOLZ5lmu1N0Thsp83/
 1i7tG5i9+GiLwkAMGnpdE2C7MBF63QawseaX3HtSkFaQKhhltA4C20Ogt1LDt+Qji7YrN/tnr65
 pcb3AO9RmW8tLYAaOMqrDX0llWxAJtKZAb4oXm4W5jpw3THdruM4KroDFUkaexwFct85f58o4Th
 SmfHNVqwiT3Fr+k0p3O0q6GyTV5TMbhpIR2g82s8do4vhkLu2H9nPhG4XqHvZNNFwp1ZX/h7cJc
 Kbr7NodA9KHdrABlYjg==
X-Proofpoint-GUID: SBoUfkNGhJr8qVHyFgRQhGriTWN0X-8C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX8olQ5Eb3UHZa
 T4j8fB/k5W6aIMICGqPuMghUA7+x30LhgtvZWonrYZK73j1TdiC8ywzGmVVZDTLhEZdpGtJUTFJ
 2tRmZKDH46mPlPFlgQkaF8gpNXYprgI=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a48121b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=BxB3lidwPopAx76cZsYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: SBoUfkNGhJr8qVHyFgRQhGriTWN0X-8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030200

Use the devres-managed devm_of_reserved_mem_device_init_by_idx() instead
of the manual of_reserved_mem_device_init_by_idx()/
of_reserved_mem_device_release() pair, letting the device resource
manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-of-bst.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-bst.c
index f8d3df715e1a..304554ced690 100644
--- a/drivers/mmc/host/sdhci-of-bst.c
+++ b/drivers/mmc/host/sdhci-of-bst.c
@@ -405,7 +405,6 @@ static void sdhci_bst_free_bounce_buffer(struct sdhci_host *host)
 				  host->bounce_buffer, host->bounce_addr);
 		host->bounce_buffer = NULL;
 	}
-	of_reserved_mem_device_release(mmc_dev(host->mmc));
 }
 
 static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
@@ -417,7 +416,7 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
 	/* Fixed SRAM bounce size to 32KB: verified config under 32-bit DMA addressing limit */
 	bounce_size = SZ_32K;
 
-	ret = of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
+	ret = devm_of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
 	if (ret) {
 		dev_err(mmc_dev(mmc), "Failed to initialize reserved memory\n");
 		return ret;
@@ -425,10 +424,8 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
 
 	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
 						 &host->bounce_addr, GFP_KERNEL);
-	if (!host->bounce_buffer) {
-		of_reserved_mem_device_release(mmc_dev(mmc));
+	if (!host->bounce_buffer)
 		return -ENOMEM;
-	}
 
 	host->bounce_buffer_size = bounce_size;
 
-- 
2.53.0


