Return-Path: <linuxppc-dev+bounces-24011-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA7DC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 13:08:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxXGF3dHzz2y8F;
	Fri, 10 Jul 2026 23:08:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.180.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783688933;
	cv=pass; b=ahiRCtr9d4a3GqMJ2mGrTEqgqcgXaIn5omG7N2kPE1TU1ZdjBs+JpY+ctextG2l/XOCITaxrkr/Xzeexi+FPW2tc3EVVphN8xDMmCfMlu0sR4Jq6qZrQaxrnFPBByuU6O9i4WX9EcIAPG1ys665+zTl0OYhqeevG5VKMlmruL88U+KQaY9abAFxE6jZAD2Z8cpijyAe/XEZ1Xr3W3wOWCDPkGCjJOw6ZyDyfQKEDIhFz/xQyVr6NvLiePMN5PMhdvsa3ta2zhqP/BGKrPG7Y1Fn1pg2yAuCT811Yl+0st++qhPRtQFMqta+vxnDqWVmsXbeLUBwlXqoNskFLGUjXCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783688933; c=relaxed/relaxed;
	bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+vL/x6tTjIASewhY1q9ZMaN2A8lVawiJVAfM7OMedPd5NARMQelyaaXpqIzsnOVsl0w3qI/gBMlXG9cv8Z3clrmJNBU9a3WKf4+iqe2WKEllwQFAKSXPoAOt2raygJMlhGbp/BAJxtvw6qUekrjgqCrWBs/uIHkSqn4LZ1v/4k/BCU/FAXKCDdQps6te3XSiPL8kgsV7M3wktqoVX2EhR/VI9wt6z/dI1K/fN9U6/OgZAcF/SJpSqucSuaqI/CEtnamY4sP3255oIZUfWckvuXnCrctbnPYhZ90uh4QWeYWacucOGnsVhZiNYg+Uu54dhtRgNfkUK+c3g6DXGAE6A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PQbhMoe3; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UsY6iobo; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PQbhMoe3;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UsY6iobo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxXGD1zcTz2ySg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 23:08:50 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6kZq823892
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 13:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=; b=PQbhMoe3PoBcb3Hs
	/DihV9aYD7N2odD9vazHqRjsDv89h5rZHGphaH+tpWhsa7+af5rBKTPuJdW8LPZn
	Mk39Wieqo6Mw60r42dLUd2Gxgi7p8bxjZpLshjrj7AzbL34A0DXvPUZmVUH4NX0g
	MgtJWs+BKx0AJ2Ezx5aSRboaeoiSWTe52rVeK8zpfzJ0RAwKpEqAfSYiOKp5qRRf
	EsdJxs0bExnyDS3qhxtop/v2dbSfVm0i9jaV/APL5yQgCnzY8s/Y1+SDeOsMMPGn
	F/+wgSzwHMID5UrcvHdiCAnKRs1pvv9gBeLt9XKdfGXLhg0wmyfSh8mZwn6Udt4N
	ZKZX0A==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjcsaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 13:08:47 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-662f741fe3bso1177537d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 06:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783688927; cv=none;
        d=google.com; s=arc-20260327;
        b=LdhCJdfI9UHWoiQSXuQ5ii4iXJswIWTJNjscl5dDr/3/cZQU6PLTU0QvEh1uh0m0s2
         v4MIPm69UMvhvHlmBBs6NxJeTx3eLxm75MxYC5JCNoOklPfduhGDKNCqz0FJQckiHE0W
         e0mR8Icb/ynnjxJsPRWBOBmnRTYhw7J0SlFGlubTO0333WTvXKSYWqbS8/fqDJBJR/5e
         sdzqmGAIzkVM2JAp3lyjbK1V0wZa+vruVFtfsmfQKla6m5gCDALQZQEFCXndcWg8SWYe
         4l5fGGTdQ8WMUaj16jEkJyLb11ZexCHZixgl9Sly+NzA5BNtESBqbdjhVyRgV/MY56E+
         69EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        fh=lhRF0ROkRsdQXPZiVT9WPqFqwFc6yg3tmchCJGWHSOM=;
        b=p5vu0JE90BN5/8HfCYVFB0UIGOBYTykkl2DAGQ2zuhTU3SdePQLza3wvW8uIR0puZs
         OqELN2oiM6CPhe0mznednXPIuUu1kbLkoVeTjQoIya6HX6q2JtQLoRle1b/RxHPhFxst
         CZsyDHaZ6lv5vRysHUAeNeh9/VkiENiIuYSqPOyrrTBFg1vkllANOZsAVeO4FMtFv35J
         MLNYLvMep8WAhqDyD8VofULJeg8OTjcAen9uEaiQoNNYxr2qQdmQFxRGfMUBy9kVP+dq
         zMUpTqG0tk6YzRjBSs9YKwX/5N541Hox3cpgbLK52EHHRCNlrB90omK3jT2jRiGH+XiA
         WrCw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783688927; x=1784293727; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        b=UsY6ioboNaBLAzh9EpcjL2NTiqQf/ORLD2j3lzhFsrJHJRZwU41GrdEh3det1GPnPx
         ZaVY9hnhPn0YfcRmUi53x3+MN43Q9OicnAXbLykSbsPM1t3FLjqxQAixP6zI0ahIEhfw
         6vh5l+BWSTZGobEOFg7oDYgomlpTXRCnu6+7mQQ+vB+vXyPWhKUROns2C1cfK4Zg5vcw
         qzlZCiXbzdEiw+juEo7edO2INK9gjQXjag/mtTyT2IcWXBDESa94muYFWEsxz7ktNE0Z
         wFrbmGh1LDZ9D8KU/anreX0YdXa9dxoQuSFN/vhxTijrFvWRKTrZH+DPr0Bon+ORjsql
         wtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783688927; x=1784293727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5Cka933m4keuHC9q+ty9VLjOYV17gugYbjBnwJv6Bo=;
        b=Qe8OoH4Jlwt+oEWsaiYuZT/bLUrF7dv8CTOHfkNNp8hXD3rLgE99Yw3+3XOU+G405X
         /MpQH3OOODO0/PI9q1FpLSuFXsVpMHbB5BSCABnq/oIbMRtmOi5eK4ZI3kNWfhwbftyn
         WbxMXOI0/OxrIokQY6yikj0HRCjPfZL2oaOhdrRpHE9a8WUpixJCYyr0vZBbaUMF64+H
         UhFgw+doTWqS1xM3sPQMLdxxzcOe+HUEaXtVXIobPzyhFt9Wf/8VfYy6LhryiwdGrtpg
         qjoe1uvTc4Iv0iJvPja/jO3HKW24I3lT28Q3r8/uSKuhOPA1TiQh7AEBTU0mmXcALdDm
         T9wQ==
X-Forwarded-Encrypted: i=1; AHgh+RpV3C4A8S3Pv0J7SQ6PGAYu2TCz2fuqRpk7dJ1L6qCeXfnxJMKtkN7MP0RAQ205qIWTpuPueX1L1RjZCqE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+1S+BzhlobyFR2k/FIdf7Ut/K/eyofF98XD0PlzM2EuUtEGno
	CFKt9MgdoQWdpDoz/Tia/lnYtqYXyXT/oTyqtQbSZWXcblsIta9UVCgowX6/enwVAp3BK7bdqqc
	UpRtlqo4RnnHbSRC1IIexJfFOnrzIzAvx4ocdyCHAOmie1jYp5/dPc3RUvBxCQwPFVxlcS7EwQj
	pKBsOGAtK2d6bOwtIV0oEGdd5dXZcwrdhIYQI6lXgW0VI=
X-Gm-Gg: AfdE7cleLq1dkCTFWvS+s20KRdnhqdH952WVk4vXO/bWUv0eNvZbNfoE0O9GKPUY0LP
	+DZbxfMVXW3sui20L7nFzgJPaLdBVYPcXNCj64rinpbB2T/OjmAykKQlyOx3MsXKTnAQMMhjYro
	v07ouNsSrPSdF20sY8Y9MPLd/0kyL+aoK6Z/gAgPSmaZAjzMl9XeyYJXv7vzyDv96bLQVC
X-Received: by 2002:a53:bd08:0:b0:667:8b91:242d with SMTP id 956f58d0204a3-6679f245672mr5946051d50.92.1783688927310;
        Fri, 10 Jul 2026 06:08:47 -0700 (PDT)
X-Received: by 2002:a53:bd08:0:b0:667:8b91:242d with SMTP id
 956f58d0204a3-6679f245672mr5945969d50.92.1783688926691; Fri, 10 Jul 2026
 06:08:46 -0700 (PDT)
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
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com> <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
In-Reply-To: <20260703193855.110619-24-mukesh.ojha@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:08:34 +0200
X-Gm-Features: AVVi8CefhojPUiWasaXCCjZmJBb6K9Qzlv92c3u5BPoEMYadIduP2fyzpl9La3Q
Message-ID: <CAPx+jO-hkYQoEOj1Jrp7sn5HXYTDbfAG4U5rpNBW2Wue2TZxhQ@mail.gmail.com>
Subject: Re: [PATCH 23/42] mmc: sdhci-of-bst: Use devm_of_reserved_mem_device_init_by_idx()
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMCBTYWx0ZWRfX7izZtXT2tq2g
 rY/0OdhVsIfpqV9lyarAephwClflAK5zFTfOMmkWVoUn/Fgi8tP9fsjIoYcZXRykb1XX0rhZiJn
 mT6taaJs72gln/t8zyI9gNxeaE6gfODAR6vfoJm3wbymTBwk/haVeHwuFs88jxdwd/EzAbkQSR8
 N+U6qC/QVAzaMPoh3NyETZxQsfOh63uxsLWIiK2U3JLV1BBqWp/iSGWtgohPC+9DC++s8BoctbV
 qEDVn+ds4ENEqf5sCGF1n3TqBCHWEmWQMxI2CCFxpPT45BM2tsUGI1TviJYbzFv85dsHpPxVbry
 FR/Ltc78UUuD8olstwegWsIKR+bdZ1yCxspLuhXSnLDWn4teRS8EgN6EZQTURFwfMDkj3Ooxod2
 aZ66BrGPToh8wK6Grr94Fti5VdHKyR65tYzmaMlbd29QR92YqvrbCsqTx6nchkSlR7/7eSfqwJ1
 Hitf/Easxz2VNOI4pXQ==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50eedf cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=z_eSG8vRrt57AjWXvbkA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-GUID: VobCEoZUbZ578wNtUobMwxUQRkSCFnQp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMCBTYWx0ZWRfX5lHp1yX+9Tqs
 7tWQ1/di7JWOlc4ZwruTaKQdnkrqslDrv+lG3c/tWfQ8i2mTR+ngE7LV+BtGrPyZOr/yNheyWln
 RJwC4rhQLv6HVCJpqZNm9Yizef/+J0w=
X-Proofpoint-ORIG-GUID: VobCEoZUbZ578wNtUobMwxUQRkSCFnQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100130

On Fri, Jul 3, 2026 at 9:48=E2=80=AFPM Mukesh Ojha <mukesh.ojha@oss.qualcom=
m.com> wrote:
>
> Use the devres-managed devm_of_reserved_mem_device_init_by_idx() instead
> of the manual of_reserved_mem_device_init_by_idx()/
> of_reserved_mem_device_release() pair, letting the device resource
> manager handle cleanup automatically.
>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-bst.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-=
bst.c
> index f8d3df715e1a..304554ced690 100644
> --- a/drivers/mmc/host/sdhci-of-bst.c
> +++ b/drivers/mmc/host/sdhci-of-bst.c
> @@ -405,7 +405,6 @@ static void sdhci_bst_free_bounce_buffer(struct sdhci=
_host *host)
>                                   host->bounce_buffer, host->bounce_addr)=
;
>                 host->bounce_buffer =3D NULL;
>         }
> -       of_reserved_mem_device_release(mmc_dev(host->mmc));
>  }
>
>  static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
> @@ -417,7 +416,7 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci=
_host *host)
>         /* Fixed SRAM bounce size to 32KB: verified config under 32-bit D=
MA addressing limit */
>         bounce_size =3D SZ_32K;
>
> -       ret =3D of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(=
mmc)->of_node, 0);
> +       ret =3D devm_of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc=
_dev(mmc)->of_node, 0);
>         if (ret) {
>                 dev_err(mmc_dev(mmc), "Failed to initialize reserved memo=
ry\n");
>                 return ret;
> @@ -425,10 +424,8 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhc=
i_host *host)
>
>         host->bounce_buffer =3D dma_alloc_coherent(mmc_dev(mmc), bounce_s=
ize,
>                                                  &host->bounce_addr, GFP_=
KERNEL);
> -       if (!host->bounce_buffer) {
> -               of_reserved_mem_device_release(mmc_dev(mmc));
> +       if (!host->bounce_buffer)
>                 return -ENOMEM;
> -       }
>
>         host->bounce_buffer_size =3D bounce_size;
>
> --
> 2.53.0
>

