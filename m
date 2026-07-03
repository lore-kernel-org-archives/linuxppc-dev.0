Return-Path: <linuxppc-dev+bounces-23534-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C650C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:50:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQrF0Yssz2yjN;
	Sat, 04 Jul 2026 06:50:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783110114;
	cv=none; b=GchpTn4g3jw33Ie8usNxqJRX5qINVgtDHAIpmu2JbB4iN5laMdeiLpGKEF3SRY3CnQti2LIaRTMdwELtJ2A74o9iIMwqiMN8IqOnAbtCLxymglvcqToXhAk4mrik0r9SaVdUf7gpNDO0gnL3SjjS/b7COfHQ7G/iojp2vipJnBdVKCZDuuvzEVlJy6fWkXHg2VO2a4O4Q4sMiA2khDt//QTeR6tY19oBeXVvjapjAnNqr0NR12yis6zOYxaNdDkKCKIr9cfsE6mBl6HOMNPIFt2V47QkzwhRk/4OqjTWcyYNF/61TU5QPOakA92gDORIPh+q+uhi5HURVQDyDOaxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783110114; c=relaxed/relaxed;
	bh=kAqGWShsALrUvOo44yJ9PZPqBuVxxzDIDv0SXARnsDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBedQWCAUrKnPr6tsiWg+PPxmyGIedWNvgh2AiF+4gNY1U4siLaH+j1Q83GHae5jrOLi1iqPVOmTlnOtzsloNaRFuQbAgQk5w75xssqpJamCUFuAfUgSCEG/2RGx3CfVHLMY2Ab023B4kKcYUx3ck5StFdx74S/oVKbRo9vMumtFVgnjzRlOLs6D3SCybU57eq+gt2YyCi9x/pKRhkdsjTTpHhJX/ZQS1/U6A/DxWp/ufoO4naBOt/EPqBbbYRs+H+f5GGKh/gbg7B62uVq3KNjoWpVTQhwhTAHuRjG4t4l8nBA9j1W4xhkwFByYHUuNfKc3i3iXDHQf0Z5+zhS0dA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iZuu44D6; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PclLUH0O; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iZuu44D6;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PclLUH0O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsQC51DY2z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 06:21:52 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HjBmp546852
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kAqGWShsALr
	UvOo44yJ9PZPqBuVxxzDIDv0SXARnsDY=; b=iZuu44D62fDE9nUkMGsQ/kikCWN
	vJtcLEgw6+dGCeIIHuOlMsUIpFKZZGJPJqfdF+O1SYEhJ9Ewxr3bmWpbtRmLiIqQ
	jYkNIvEv+KCpR6MtdXix1MGky2N2ZQ+IKKh/NsqwJzV4809aM+q8nNtoVSj4h9GS
	7ZOJF8MX23ckx9HxrND4qmrfOFK47QtXOdWwXxI5gur6l6dxQmmA/LR6so3jKGq/
	W7A00TMFaZJ0ko+VVC0tHFFvu0ryV81DeIP4S6UmjKnzb0SJmxCATCZFjAZe9zfa
	KCzmbOBkJT97xvyMzhw69zt86W2jJf7+4G93pb8Mz+QzA56HX9qkqRm3E6A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682btqnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:39:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fb51faa63so778167a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107591; x=1783712391; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAqGWShsALrUvOo44yJ9PZPqBuVxxzDIDv0SXARnsDY=;
        b=PclLUH0OY4yccyYTuors8a4sZiJqZDtcLHaO9D/MiJw8p74OqkbsNY5u/1fxuqzfPY
         tZ+OxxTpqaWD8yT6L1naKlf4BTso52sa9SnV5WfODSGMtaKOjt9YVr13vJktqdcGOJxg
         GDPEc7dMNHX+kqmmPwxGx4tqXZYrxUdPzQBFWxBeWFTz1g+DedNc9YdYQ9b/7cPT3Gfn
         AQjrLFfJBOIv6l6axaiTSOHQZlEuhQZ8l6oVlF4C1PVP2y+tg8IyNJ6ZE3B7MkpTr9Ab
         6rr2L6F0Fkct9cpjz/3g78bi5asIH3nLhddL8bYCkrRJN22uKXlk3nb9IwzjYY314Lwm
         efpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107591; x=1783712391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kAqGWShsALrUvOo44yJ9PZPqBuVxxzDIDv0SXARnsDY=;
        b=nJtkW7sIfAGigYmOXLs59SxcvCtqdgj0ej4SNKsxmbZa3Ku7q5bdWgSaBzLRjVGtER
         1XrQfjyWJ22QjyqcZJO9KA3X/9k3VrUa1H5wAn3OsWP/K53q2YzXIH2/8sVZDCJHY3ac
         AqF17TO4olNV5oq9+QpmIZ5diyLS48dYVXxvuX7Xiyn2FRae1nsDjM/OSb2RS56wEHCr
         gZsROp81h/tSsSK3qZOUhC7lTShQLWyk0ohfMDPV42KXiizXi4oEKcLeUJummmS52p0N
         sR75IFRBHSXBvaF4GF8i6Uufg+/QaldKtylkMyFxpp7GrBPSkZ8h/Oi51jb4RpbI9WCm
         rQVg==
X-Forwarded-Encrypted: i=1; AHgh+Rq13RTQ+8dGznRwB3VADBdR0l6ioLMDtIXA9beh9j1YmSQgmIPLU1xXNLBOCJ7lU/QABJd2Bwv/10zbe2k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLDIfAEBy/TwAz3XeVCarQlW2jdAGbJlyGvXMAdmPMGjOZeZ9T
	A7p4xs6kolIR8Krkt6B+J6jYSk0V5V12v6o0ffP6Bnqk/DmiqsFvL9w3zYAs8Pa+x9baBWNGGTf
	AAADtog+xezkAQGd+fh3PIlXLRBeln1+1YANIVT5Q0nHM4nHQ5FWsu9/9jMu2e6DsBw3Y
X-Gm-Gg: AfdE7cka34nRmf33m2Je+Cp/WEqscWOO6oujxR4WA6vSgEWbOzjJWvPTKNBVOqJkzcF
	774iBN3ArMEBtha13Mqsl1G96zk+NA+PGo0Q/zw3kyJMvjNuGBBIlbyC1jts0fT4IlZ88t1t56H
	Zd205vo+TuGBgL6jLh/i73W71/qGOKizqs6Tak9ETrnGH/x/izeuALXYCQ2IvcmG3HAXPtba+HC
	FtlbL63StixwClAJWsXWI8PnTD//HFxYRkMbP4I3lLpIXf+F8LfsxLM4/GRtAH0hZnLe5+16zw6
	ZmaopGGLAhhnss8xH52iWJlyIZaMXojYskzlaADwyuFKM55G14WR3BErmjvo/xfuWYzsuPb1ZOm
	8MnFAyRYzYC33BzagJCUVGbVS7YoOxrrWG7g/Jw==
X-Received: by 2002:a17:90a:e70c:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-381122ebda9mr5933736a91.9.1783107590249;
        Fri, 03 Jul 2026 12:39:50 -0700 (PDT)
X-Received: by 2002:a17:90a:e70c:b0:380:ce69:2669 with SMTP id 98e67ed59e1d1-381122ebda9mr5933658a91.9.1783107589588;
        Fri, 03 Jul 2026 12:39:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:39:49 -0700 (PDT)
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 01/42] of: reserved_mem: Introduce devres-managed initialization functions
Date: Sat,  4 Jul 2026 01:08:14 +0530
Message-ID: <20260703193855.110619-2-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX4FuHua+htXtQ
 9URewsbZye5mhTYyr4DX8dinzPsoOnGOI0b1NjyJvgwhVbc2N7xyrOs/9INRgV+1YOnHyaT0vEM
 JIbmCHCRDxeDpzmJE4eE0Bts4sGB+5F5W+xnZXg8hBkMPMJtwGCXTCk5hbZf9bx1aeJ2+j7dldu
 3bnXTZ4tqaTWm60f5z2d7MIXk6sfEaoRwjfNKyLeANoRyJXKcXry65YhPhd+jJsuJs6YKToj+aG
 Z8Yo7pMglB4KLhsMDI9K3t46szqpYTVIUPLw1hQtpzXL4T6T4lL7HLj0+CxZp8IdvsTtMRDE7iy
 BdsBZDNiqZXmUC4gqc1pN3QN8a747vIY/6PLiiF1UqVnhfK5yX6OA7Ce/nPtic/PjeWyCUjM9Yj
 XQgxajh1H2LB+hirBPZwVjQqR74bSsbykjnqPh5qf7nJ7/SA5qkT7b0TrENCmhbNfcgRZbSKJNM
 S0eFWVKiYCM7kBF4x6w==
X-Proofpoint-ORIG-GUID: oHxc6QSLO2lXb6KVFzbfxhg1FIEy2q3h
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a481007 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=C96w-YAaP-Zupzk_Mv8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX1McQuteSCUpN
 7gJiWKQeXUG4qNhLI1e0Q+It1+7iR7bF4Ki8pYr0hIIL6p4TpmG5F+Ni8ZK/3fny1L2SesJ7M5c
 a28bwgwnY7xRem9li6DS90u84/0OS8w=
X-Proofpoint-GUID: oHxc6QSLO2lXb6KVFzbfxhg1FIEy2q3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Introduce devres-based helpers for of_reserved_mem_device_init(_by_idx)
to help fight dangling references and ever so slightly reduce the
number of boilerplate deinitialization calls.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/of/of_reserved_mem.c    | 41 +++++++++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h | 25 ++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 82222bd45ac6..b35541e9fbe8 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -787,6 +787,47 @@ void of_reserved_mem_device_release(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_device_release);
 
+static void devm_of_reserved_mem_device_release(struct device *dev, void *res)
+{
+	of_reserved_mem_device_release(*(struct device **)res);
+}
+
+/**
+ * devm_of_reserved_mem_device_init_by_idx() - Resource managed of_reserved_mem_device_init_by_idx()
+ * @dev: Pointer to the device to configure
+ * @np: Pointer to the device node with 'memory-region' property
+ * @idx: Index of selected region
+ *
+ * This is a resource managed version of of_reserved_mem_device_init_by_idx().
+ * The reserved memory region will be released automatically when the device
+ * is unbound.
+ *
+ * Returns: Negative errno on failure or zero on success.
+ */
+int devm_of_reserved_mem_device_init_by_idx(struct device *dev,
+					    struct device_node *np, int idx)
+{
+	struct device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_of_reserved_mem_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = of_reserved_mem_device_init_by_idx(dev, np, idx);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = dev;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_of_reserved_mem_device_init_by_idx);
+
 /**
  * of_reserved_mem_lookup() - acquire reserved_mem from a device node
  * @np:		node pointer of the desired reserved-memory region
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index e8b20b29fa68..b9fd78123d77 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -40,6 +40,9 @@ int of_reserved_mem_device_init_by_name(struct device *dev,
 					const char *name);
 void of_reserved_mem_device_release(struct device *dev);
 
+int devm_of_reserved_mem_device_init_by_idx(struct device *dev,
+					    struct device_node *np, int idx);
+
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 int of_reserved_mem_region_to_resource(const struct device_node *np,
 				       unsigned int idx, struct resource *res);
@@ -68,6 +71,13 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
+static inline int devm_of_reserved_mem_device_init_by_idx(struct device *dev,
+							  struct device_node *np,
+							  int idx)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 {
 	return NULL;
@@ -108,4 +118,19 @@ static inline int of_reserved_mem_device_init(struct device *dev)
 	return of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
 }
 
+/**
+ * devm_of_reserved_mem_device_init() - Resource managed version of of_reserved_mem_device_init()
+ * @dev:	Pointer to the device to configure
+ *
+ * This is a resource managed version of of_reserved_mem_device_init().
+ * The reserved memory region will be released automatically when the device
+ * is unbound.
+ *
+ * Returns error code or zero on success.
+ */
+static inline int devm_of_reserved_mem_device_init(struct device *dev)
+{
+	return devm_of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
+}
+
 #endif /* __OF_RESERVED_MEM_H */
-- 
2.53.0


