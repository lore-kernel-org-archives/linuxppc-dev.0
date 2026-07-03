Return-Path: <linuxppc-dev+bounces-23557-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC190C44500
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 23:12:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsV0M0HPhz2yRn;
	Sat, 04 Jul 2026 09:12:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783120370;
	cv=none; b=agQ47xiH0AhWms/jGrKfjqmgVsSqDdZq0zZwQDKsBVUhzhIG0GbW06RTZw1LWrk1LwNmEo4uCCCpMoWNknUpA3WkZ3qossbSkDwNNTi3jxNgsIto4Vv0bG92GLY9b14k5CUOawGwKXrAQUe34B3EO3aR9qCnoKiQOFwv7IByiAV72CsWoK3xRZJoOT6lNXW9TwFPUIDAU1tIu2vZQmN7J0VKhk0fSM9VqFigL5VFK8sa/9xhTh4hRvwwDReQLtfD0lutXdOJCrQbOAoD1yldjfn7PCTSInPVKLKXghM9P64mhbwBhdtU7cNyi9y5co4brTa333U32z5h0WhGfHU4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783120370; c=relaxed/relaxed;
	bh=ptvjiVFY55mHuzyR7IOPZN3qjRdO4GwgfZdidGQ+xdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0Isuiys8vJr7x5gRMkeNL5IZbFq7HqRvTlQMCD5scf3XiieSFjx1iwHgCtS3PJvqA4wkMnb/6INOS71/KkIT5FXquZCCDCD3Nx1v3O++Tod4BX16NVeH7hs7QWRTOE470UHr+npwxC+8O2j+mWSOEyfH3RUMq7tAaO7EUCAfa5hJY9ueQ7cKCCXDBn8q1SUOyyt1G/TzPXWWCoeXcAZ1bum/KcFrdgtcf6Ss/YfcsPuManwDnyjQeMB8ZEATJe8AIrof0emLrlB/zfcWstM9NC9AJCukYzGYyxdTr94nKzZEm7pP7CBkF0ZWbA9rSREDbdSntoVKHdeMR1GDA1nuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MwuefZpS; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fKcJicAM; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=dmitry.baryshkov@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MwuefZpS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fKcJicAM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=dmitry.baryshkov@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsV0J5rmKz2yH4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 09:12:46 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPgAI1020707
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 23:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ptvjiVFY55mHuzyR7IOPZN3q
	jRdO4GwgfZdidGQ+xdk=; b=MwuefZpSFTvuNgJyrkHy6OEbxdQIh4zwoxkeV0v1
	SeNT+DdlpzYtM/NzLKO5cRhFyyJnebuIF5IKibnQH9YpiTNtspV6uDvHww+LUUZw
	Z26z8Ghqy1Bdy97MgjMlCybQAcNvxhH7AanAObFO0nN5IPodyrTpWh3DwjILH5JS
	lGZlFabkn+OlzqLPqxZPmZYtMum9AdRVSTRs/wP4GOzKS3Aj0HWCmra/f6MkDSMw
	qYaBJCD0DDY6/4P6Rd9xzPP5E3hUq7S5beve23YXYe29Mo8LO5BMBx2bJeVN/Pjr
	eFrVkDRH+FB3sjLbh5P/z/JAV4UUnzJ+/KZJdzBA5COZEg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkhr1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:12:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso16198116d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783120363; x=1783725163; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptvjiVFY55mHuzyR7IOPZN3qjRdO4GwgfZdidGQ+xdk=;
        b=fKcJicAMqk0nS6XCjY8aa7+50EJMVE0cSc+e+OcUjKvylnbgql7HtfDmgNTKTY7KFY
         oX/r1sLj6djSyvCYufXkVu56jamn6DWAblFHLTWS91FzdoJCP98i9IBtdSknOqDftbjt
         2SxYASk9MtHEhy6M7pp7GXoE+DasBY4ECXsrhmBIzC4VOEKUGyGm9upFPYyjax4DKqEf
         farxeJx9GOt9Y4JbciCPjluLkaLvo0rcO7MO4Vpr+PqaxAaJWmVtkNrAD3jiEl34dOKa
         gRoZXXNwy90ZR+xv7QCZ6GWXYrHPuSid40Rq6h0tYnPD9PJ7dGTFNY6K2mQm4Bd5fGLh
         iiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783120363; x=1783725163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptvjiVFY55mHuzyR7IOPZN3qjRdO4GwgfZdidGQ+xdk=;
        b=AA86wcFPGboGaqlJjHG7uNxY80K1xAnTeamS61gu5r6YhgGB0Nj0nQelFqX3cTRbiZ
         wSGtgKAOiULsnjQQTYuLBGX3fAssBEJQmkbD8SIYHZPG6+mznda4J+UF3E9VOIXegiy8
         BAlUAW8ApofAe7yvisHW0NhXJx2euaB7U+8Za/+2wVEYWVZoBsd1BZgDdi2o94Z/b9ny
         F/6QVCTEXfXpFcvDr0VQrFESGu6qBasb17Vikq6bx1a5dWML9+bKxg4DcgJZbUdNeu5q
         kTexSHq7ois4yrYRE+tHt5fGFcMEUPeLqFXdO0TGcctSALha3Ul32zpJd/q5WeZiHFK2
         VcNw==
X-Forwarded-Encrypted: i=1; AHgh+RpYGfOL//6eB76ja+leg8WY8MIozR/tkDcW70dIgfc80aYyVPBZroK09gplomSiEvOdS0WfZfeed3Izkh8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDZmb/vcAfDykJrsfzmmcJlKs42XI9FxI5iGxfmvnZxmVE9lcM
	5GKPuPs5DOr+X+1A/Mw1LD8GJa5Oo7/XfjOYRv7aGDbScbki6Hdpvoyu/oghMN0OTUPXHvZMtQH
	a0BYE+I7PioRCgwxRYqELjwZqwKX363ldjBucn2wV+YTYQdhykzLyAvlNVzEfCvJK7Nqn
X-Gm-Gg: AfdE7cnvJMF6E5ELJDJvO20sOvsHIjPFd0H+ul8qMGZk7Arh0Pzjvpu1DbE0iw8rg5+
	+qk7YXG2EhTdcwjZu3O2JiQPDGG9lloA92w4CMC32uG/oERPdQBgNb0t1U+rupRhLduH4oJtLoh
	ZkPoPvGlyYj5dYCR932fgMeSNth1otUTwgEfjP/c86nhpyIJtdBTsgSgRocN+ksw0CU0yMbxjCk
	xWUGdZZWhk13u985jTGWbiGWVm2s0R9kpoLtxKDUQgQyozvk36cQ4Exr8mey9DQqxzCppTs+kGl
	pFAiDe1K5tb/9jsS1hbsHbbR31YOomo7dS86sZqJnlzCe/eusw374erVgFvw4VCAsxyBis3iMJH
	7W8M+mAg8aWhdp3L0rJZFijwsNxBJ1kWFK93Tb37ZeTxO0lSVzzOKoyTUzK6lTtMK2sLKyRFi6f
	6FF7W+0Z5XSll1ZKvX4/ghCCN+
X-Received: by 2002:ad4:5c82:0:b0:8ea:efae:ab2c with SMTP id 6a1803df08f44-8f74c0a468cmr20755756d6.38.1783120363157;
        Fri, 03 Jul 2026 16:12:43 -0700 (PDT)
X-Received: by 2002:ad4:5c82:0:b0:8ea:efae:ab2c with SMTP id 6a1803df08f44-8f74c0a468cmr20754586d6.38.1783120362600;
        Fri, 03 Jul 2026 16:12:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c3a0asm815528e87.71.2026.07.03.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 16:12:40 -0700 (PDT)
Date: Sat, 4 Jul 2026 02:12:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        Fugang Duan <fugang.duan@cixtech.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
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
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 03/42] firmware: qcom: scm: Use
 devm_of_reserved_mem_device_init()
Message-ID: <6ejxrh43bkhryudrxk3lkzf2knlgv3mxtfgzhrzujw7km4n5bq@4bd2ahopzs4j>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIzNSBTYWx0ZWRfX95pnmuqksGUV
 7+OfVMmg2BLiVbQ3rZ2BbxJeajBuxXswNUdPOvj9uSmrr0DinAtvJ9QTQkDulFBtcFUIjplRFi/
 rjnbhuoLACTD3a72AKahyeps8ZtJBLdygGNekcP1+QoZdDD7AFKTM40JApEqmqyGPT1wRanjgMe
 goLF4eXiTjNCp7Kxb78kCfOiD+wC+BY4W7AzTQTKDbRYIST2wmTWz4i2I73UbKgH8g3SZjLLYYi
 mdBCz9P3GVVkxO1wMcpAjI2ULsm9aYZlfpiIYVilPrQGe9VcGtlalfQ4cWwXPxNgFoV7HRKgFaY
 PfhIRRjjSn43mSE0LUxe839kqF3SRPSi3G+2u1qMDH53+2MXgB4qA4IlqO3DuXd74vl3WYT2Mb5
 t1y+/5gvSGXIcRzWgRAomx/GDuF1AYNmKI7819t+djlR5eFexm8dO+M7fVLIj6ZsxnujT6gQGZY
 qGQ4w486rbXSPINr90A==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a4841eb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Dn8qeLIeI0d_esIdenwA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 5mOGCTWjP0wWc2VALwGqkEgvamyQ99gH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIzNSBTYWx0ZWRfX0C8qy6ymEa8P
 gbUTAw6PBVyhti4nxvemXSwp6KDUITn6XyvejwOtJo9OKHOrUzjWgu1K8Izjmwl+G3j5jCLxk5L
 DrFzF0nlyK1JyqtYoCff6QqeaYkpkW4=
X-Proofpoint-GUID: 5mOGCTWjP0wWc2VALwGqkEgvamyQ99gH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030235

On Sat, Jul 04, 2026 at 01:08:16AM +0530, Mukesh Ojha wrote:
> Switch from of_reserved_mem_device_init() to the new resource managed
> devm_of_reserved_mem_device_init() so that the reserved memory region
> is released automatically on probe failure or device unbind. This
> eliminates the err_rmem cleanup label and the need to call
> of_reserved_mem_device_release() explicitly on error paths.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

