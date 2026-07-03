Return-Path: <linuxppc-dev+bounces-23539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A7EC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:51:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQs02Qg1z2yv0;
	Sat, 04 Jul 2026 06:51:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107956;
	cv=none; b=hgOTLAaBssdIeJAkyp7K6Ph4v7HV6ChNC6NxLk0xkEXFDUMk3/w0EjctKIGQJ41esVbf2XvBwHrsqhu+leSz7tYLKrcgZRszc7+2whL+pD/9lYMaOWCHz+Z2c/SMILR8G+qyWxs3NE43PaiTup0/JIyi0kQExZ+vDVnEULevMFN8a+xKbhNXvMgxPVpp1oI6i4jwjbB5t7nMYSdPtFJQDvHgdPa97zeFTasli6IxjZHPC35QYkY/SjRr/psty5MGLyBMLvsrS959Ayt4B7xb06mIw+RUaoHPGv6qBL8us+bJf6CruGeAz2Gco7WWI3SlftAtyRdRYrwKw63cayqsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107956; c=relaxed/relaxed;
	bh=j1lwYspU1A2U5EbbDH49pPsamREmL4P/yJyzYostlIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naRe70C5+lFtMYJGwYzT4eW7b+RvmqaPEVKeVqa5snsxqUTvT/9NhdwZWiDR7vtzT0TxIEjpBKLnE9nZGzXo1tciU2MS1Hd3fj8jZDCYjztBEHvLVbB/piU1hVRHZHyY8dTR3NrCAT5FRKrWytQudp9T/nHyF5NGrTPDwVQbW8qTUufzDaqqwSN365/Gs2/h18cYyq3cP7NnCIobwVcGQQnZDV/SFSP15lzeDyeNzneyBHXYLAZqiztMF/y0fvvG1hsU70OfBZiM8kwx0KFIYHFN/gAo1q3E5ZOudyzfp41BE3iuwSTm/ZbZe4D+NU5SL8S8SWYNQyseB4eRBICgtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gb5iSDap; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=STev4GvW; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gb5iSDap;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=STev4GvW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPPb0CMjz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:45:54 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HjI7V547095
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j1lwYspU1A2
	U5EbbDH49pPsamREmL4P/yJyzYostlIQ=; b=gb5iSDapMq7o3MqL2/LIqb33K3g
	0Pdzuw6XKQM0a2+QFEDOC9CiNfibenplvyPz8NZeAhvpQA1nFugJk21ANwSvLc/X
	ieS7pEbmZLoneOlPen31kwzLe/6r6y8sac/YejEQzsE47S6jRJpmO6RcLHfi1cf9
	Jn1LynpmVilkwQTPBjEw/Zf7dPvwiTFQxtshXlMe83IJNx+CllsXSUTdrF9wRBjy
	SHzGnjWSCQ8Sz/15QC2dKRXMO3DdtOyER5uQo9gNk66TBLFTcuPHHi7uxyN6EloY
	h1vTF59Kptrbasun+lVb/DJ07ylnu5F8XN1GIDgzYC3y5WYifMMJIL7a0qw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682btrc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:45:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso1237185a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107952; x=1783712752; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1lwYspU1A2U5EbbDH49pPsamREmL4P/yJyzYostlIQ=;
        b=STev4GvW8xUuVZynlragbM+opFAVBHXPgfCOZUS0FP/rM3M+KsYS8NxzcXvVXgF3G5
         9ZWusExt3SESrXim0VUa+Mejb3KjCPeXm0J/2Kfsvq0GhHu4q8ZI2BIwUDcOY9+6Zsl6
         8OVzDNuGAupl6kUfn9r/o7S4DeyDCeWbTzGSJj34dCmceoiHyc+po1ytvuabN37lnmZs
         hT4xf1EJeOvZvFdfcYJ4ge450k5Lph20WY2fwnl5kajxDurxzsUkfiLoNt33g12JfgT/
         9ofQFoVGcre8Luo0Q86ZIYEDjOqFYSYqBv6V+DafixM3rGZp5DKSdkcFhXFhf+kCvX/u
         exOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107952; x=1783712752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1lwYspU1A2U5EbbDH49pPsamREmL4P/yJyzYostlIQ=;
        b=AHrZl88zmeuKkmVSGrdTalwdydyzNhMTmH/tlHRewVVnW319k+8MxupnwdAHjOwalJ
         5hBVV2Xntl6hLOAA/auRxFE/AWeMqAKL5J07auI3TGD5G2bMsTuYOkWW/P2gIdRxQOuY
         LcgO/CDEy7wlTI7ESybKmttuiDLdLeJQDcaae8ce4Ymoe6jpBFsH1mw0Rz8APdeab18t
         X8MqBUKifz/LIZg5CLqPQTo8LUnOusvMg8SntQkca39Xy36X/YNKKjY/U9SiVuk2Kfsa
         8Joqj7G/rCrUsokbcJ82r3qD5+IJ3//RohcFTvOFVznMp4nZJAlTqeBZyOs0IPsfNTcv
         548w==
X-Forwarded-Encrypted: i=1; AFNElJ9nXkB9zN+zEcwmjYgjcmxRZAw3z0MTu8h/BelKY+KxLYXiwByyeRxT+JtYmXqV8LD7tZ29/jOvzAP99F8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtZK3rJFn357OEpBASBO9NX1J7jWsl7jpXyDKEMb/RYW+r18qk
	BsYunKXLymdZrzFO27Qv/Yl7Q9csLWdYd2IyB7dlJMqem82hcHPYF9WHUKIbJfhABpBUNGySc48
	cJS7nb/DPvoj2hCTqQLoF87CzlAku6wfEUgMUgB6L21Q7tasnhwu0ZJ5uHYnWiWTs1626
X-Gm-Gg: AfdE7ckUwTIfW8ValW3T70Eevx4ZmUCioDux5EYs67wKCaPqS9m5k8FctgPBheATLsM
	54/IsHQYAu0hpvG0brbCrLX/iFWlqwCKs6zrULLIAWqn2e+DgaRQafa48j+MkQs9fZ1AmXq3bzA
	kBJRsp3oMSjAxVNheeDzdo49hQEwI6YNG9ySPe10pWKuGHzLHWnYFlQ1Gc2qJ/03oiS+2kVBazH
	e6JfV4Jcftkli4azyY6t3RTyRqhxZnX0tMrNASMZthHLcGpn2hM5MPuMLJW3ZcD9CmARzQkzRQS
	VCmO2lOGkuoUZBUzyZAvEmdUha1u6t1UMCWEnXeyj9SPrJS23CQGAFU66/3PKOEsFNQWAS9qQUU
	kw2E6rEdR2BUrQbJuFrHbIf2fE9yXpafGkt3TMw==
X-Received: by 2002:a05:6a20:5499:b0:3bf:6c08:fb85 with SMTP id adf61e73a8af0-3c03e50d4a8mr737381637.53.1783107952159;
        Fri, 03 Jul 2026 12:45:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:5499:b0:3bf:6c08:fb85 with SMTP id adf61e73a8af0-3c03e50d4a8mr737303637.53.1783107951614;
        Fri, 03 Jul 2026 12:45:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:45:50 -0700 (PDT)
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
Subject: [PATCH 16/42] drm: malidp: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:29 +0530
Message-ID: <20260703193855.110619-17-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX5YWmgp+f0gDj
 RJ84+H3QrPH2x7haX7YMNPhI+e2aEoE3+iWPGu1fL/nz6tT4XsfquFAO31IcL0GInI1YapzaQXD
 V6qBuzGWK1MBZVQ8IyUwTWD2tyfLLOf+xH72jmkP1zDDjqlX5Cjty218nqxmOMavXp235Ht/UOR
 gSkLE93R4QSP4SEtM2VDQ+7EnpRVV8cFvJ+Z6j6UcVMM6Nd7TgyDOimlWgstVcyJlXtZqj+gZfv
 AWMxOGTxbMdeRM7CLHsu0/LuXDR9OYTO4zPVBgUQEGqcXt4ISypVS2v0Ih7tIJFtnZiNFdixGvD
 QxhO0aRkPrDZYIxxFitYLF7l7ETgr2lj4RGOkXmi4YiWoOTscKWL6ybkC+Uc0ep+6pkMQtVTfWh
 fsJkxvaEILRr5X9Pi91R62NUrX/EC57OZLacr3He6WWW2qdMKJJgoHEqQu66qM9pX2IuTpGlQ5e
 4owsjdRyw0+ge/HnaFA==
X-Proofpoint-ORIG-GUID: zwPLsVO7kdPJXM7_l010sHxbgp-OfOUd
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a481170 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=JOjAg5lxkONN77W759IA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX46hGbCToQQ9c
 /eYuPoO3rxJWHpNwS1zBzKS6QDu8kRJlU6AyMMnd5b821bj4NpPG0HJ0fP8oM4qJ9Pc9QxqYOG4
 YMCXTObolLR8GjIg8ppUlyJ3BqDVWwk=
X-Proofpoint-GUID: zwPLsVO7kdPJXM7_l010sHxbgp-OfOUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 23fa942ae4bb..3e17513c3114 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -758,7 +758,7 @@ static int malidp_bind(struct device *dev)
 		return PTR_ERR(hwdev->pxlclk);
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -887,7 +887,6 @@ static int malidp_bind(struct device *dev)
 	else
 		malidp_runtime_pm_suspend(dev);
 	dev_set_drvdata(dev, NULL);
-	of_reserved_mem_device_release(dev);
 
 	return ret;
 }
@@ -913,7 +912,6 @@ static void malidp_unbind(struct device *dev)
 	else
 		malidp_runtime_pm_suspend(dev);
 	dev_set_drvdata(dev, NULL);
-	of_reserved_mem_device_release(dev);
 }
 
 static const struct component_master_ops malidp_master_ops = {
-- 
2.53.0


