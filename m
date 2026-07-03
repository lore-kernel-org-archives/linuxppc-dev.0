Return-Path: <linuxppc-dev+bounces-23520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17DAC43602
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:47:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQm93BWXz2xF8;
	Sat, 04 Jul 2026 06:47:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107574;
	cv=none; b=Tl/3DCMH8dkmDDwUAeJwtc8Smcd4r9Tt/dBnfmef5bPOGZL5j8jHX2jioWRFZ+SAdkG2B4Ki6t2KnCiVt94apjUBMvJBIOloMSHvuxnnCfU0hbZrxYMeyuvGcaeSTuxkg65QE+u6D+Q6KOrkZX+4XpA/brBXqh8uIwBJphpDitjbzw2fmNRKmBnoa23akum+FwBgxMMymZi050tvb6My0Ql9VKfCNWRCXgqcAjS0stNRnu6Rp5u//ZM2y0WZ0px32b7CdBuMP0uN0Ewge+ng0i+58xB8bXcj9ZAJN/EkdpROa2wKnly0NguaP+Aw521QzkxPSYKH8AJDfR+hPVYj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107574; c=relaxed/relaxed;
	bh=yuDgKoAlw/JRHunDNfGXYBYzhSRLVnjx2xmNmMEK1vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SjwjCVZHGTKsg4ahdueTbrGRVGNQJu3U+6UdOs1mwwgympuuVufxtMCbXU/H+6akey0PmcgLEPBJqJY9FVJ5pMMX6RUrFuhwnxtGgN5cxuc6Y+F8ONlPtorvsuu/R2+xtOsKF8Ywabc3WTxkIoZAEyrRRVP4fVoDDWF278KLACPkIYrs57cMegrcGmt0f9vIcnTlt3AfgCjSwoctCrkFB/Iq7YdZ9l/Dss7odz1c2lfDzsUh+gii/oVX2ICe+fJPYkmBsUGRg9QFnNTx5tc4qLhsHS9pjU/v8hrR5TqwgsMIVo5G9REni5gcVJ19Qs2mmxZUNbuJy2ugf4kTl1+ujg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YEMeysY1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f9yjXJ5v; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YEMeysY1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f9yjXJ5v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPGD5XXcz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:39:31 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Hid2p675631
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yuDgKoAlw/JRHunDNfGXYB
	YzhSRLVnjx2xmNmMEK1vs=; b=YEMeysY1/myhDao0i74e7TNlV74ktXTCfMwdq9
	CR3QbS5AITeviE8hf9EJ30WAllVldtcYL4AMMm0/LzjQKzr0t0eqDF0S43incuSV
	MyApeWy7M1IbpM60LNShiFzTpmwg+/W0PKTj+Lp+cXYVgARiHsuxhXD426SvD7cT
	GGZrPR1QcL7iICOr24d23aBH8a/MPY5danZVa1/zTiMmF2fSUTDZMyH3oHPCfVAv
	4nbvlJJiytEOZCVzenusm2J4e5XUbEHMVWQY64oswPjfiGG059bwY0hXxdENEoJ/
	sJbKqjoPigEwtHk2s+fe6Ba9Tfz1f/tpFlGt1x1q0Mz2ipmQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj1ge7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:39:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe2607511so1340889a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107566; x=1783712366; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuDgKoAlw/JRHunDNfGXYBYzhSRLVnjx2xmNmMEK1vs=;
        b=f9yjXJ5v3mWB2p/VJCp9E7x1kAnvOl79+PK+ASqAO1R6o4fHL/sEZkYXA1gIM54rcE
         nBm4Xqq/ggnH4fJCh75pxlvJ4XSV9nnYG88kbMQjuEq86uWf3bGCQPzDQK6C+AuiallZ
         uU7G0PyufLdRZMwEqlnKciq1e27MI9I9OTUhdjNIspzxWEVK4VlyR3D4nLyruoadxUbx
         lhR5GzeTyM5HxJefVg+J+gLlz/DTE1XJijayatVsXHfOhT2XbPHe+gDFiLGFBEYeMqeX
         fzvWiCngiHWKSoKLUUbW8u0XV4h3szvGnBruBFN+J9DaJGvcH0yapPV0j7ISkg63YTam
         wA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107566; x=1783712366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuDgKoAlw/JRHunDNfGXYBYzhSRLVnjx2xmNmMEK1vs=;
        b=nElz6d6MaRnfXgd6GIWJluDr88luPnyOvnRqfCVCM6swRJqZ0tsy2Gefe+gGoI6zIq
         uS3a99uFHLPxoECXbK8xJ3Fr0phDDVzF13UCMRLwF1j1/EK4lpxWoSaolDqe4hHPTbG2
         UiCUPSlUNQoeghpWXcOkKgbuYzwertaf4rs8YrQEZKe2t/geA4H1llX3u7rq412QmOgA
         10rW/lReoFhLO4Pv0I3skykAYsvRekUQXU6z3ccpK/vNTfXik2TOSBWzujtCHfDXjGNY
         ww7e67ouOn1NnkUZ+9oycvLzklFYPMXJo790Qk/Gf7sfipPcUEbHK8ncHA+JYkan1JJ6
         AKvw==
X-Forwarded-Encrypted: i=1; AFNElJ+0M9lXecoz6Mf+YQH7hKD3KSIa3qDLEYiRYfCL/THmSGEA0QMmt0Sw6giWjmhq3LIqWh+AgOPiIrqJww0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywu2oibPerwalXDvUEWhoWT9d2KzM5GwuwxCMuIrmqKDUXqt1H5
	0K5PFhA1fGXBdFEtY/y1WQlO9Bo72Mm93OVSdaeoc1VmWBboLvBLbyoKEAoz7DE5Xn1fwjTpzhF
	ezvQ20bVwpFgeT6ZozQXud0FCofGWYAyz9XzkCJDe+nOmksqoxIb2hETCvvkYJ6zJIIwl
X-Gm-Gg: AfdE7cn8NzstI+nGc5crGx7pdOg+D8EYI9jtShxQOwZh8WdqedyF+Q25HNcNMsUMtYR
	rB/lbQ+bQMmHSosjk/Qw7o81Ri9Uw6Ghnqs/M2LvtG6KzY/tEQnjjVKHakw2txceDaejrcxT+im
	KTETS+2B+3yNvu0baFqV+rB8+ZweI1NmatLQ5BBLY3j8o3CPCWmWSTBglwgyzvENjpSS/+GXsST
	gXC1SKavorTLEx0orYMQKAAtDV/1ASTBvbiCvOZiQI98lbWiN8f80ijW+jRrnSWpQZ3giPKG6R0
	kkWYQYQ1l1Nyy/Am38Yu11qxHzJIMx+IucU3Q6IiVIFIghkZ7CDL8Y6B3xoEK6p15hnA1cv1PLO
	a1hmJpANK+57PRCEW4ENGvJpRyVjJq2LzORuUMw==
X-Received: by 2002:a05:6a21:4c81:b0:3bf:e291:496c with SMTP id adf61e73a8af0-3c03e298475mr701895637.17.1783107565950;
        Fri, 03 Jul 2026 12:39:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c81:b0:3bf:e291:496c with SMTP id adf61e73a8af0-3c03e298475mr701865637.17.1783107565344;
        Fri, 03 Jul 2026 12:39:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:39:24 -0700 (PDT)
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
Subject: [PATCH 00/42] of: reserved_mem: Introduce devres helpers and convert drivers
Date: Sat,  4 Jul 2026 01:08:13 +0530
Message-ID: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX2NJE1KvCl4rb
 f25s5taUMRW8UeE0Lduw1O9mqup22zb6DCztdQPtujOwv39606PGCKfXU2CQiKH6bFPVNyHagsU
 uTySPWm5huH/hdBeNRVviRNjVyOYmrg=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a480fef cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c_1ikP4J58vCyc_cPHMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: R_UsZzGZsFhXGoQnCF5ohsZQwuZOSc-p
X-Proofpoint-GUID: R_UsZzGZsFhXGoQnCF5ohsZQwuZOSc-p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX3s/ziPBuM5zB
 N37hO3X/ErsuVuJvWJpcAfZWxLyJwfnDiI0nHz5EnAobQyIbu2a27rUahsfB+426IEdAMs9OwqD
 AFcpGbU2C6apV7ZjMRK5nR5EsfWH1AH6fqq8gHKopB/bTUGBp4abx9akwEjymAkU+7gDjxZUVEQ
 vMS5n9LRxfs03Ex/rFdXwP2txCQ4892yfY8mtSXtD+TMDe9rS0eoDmOUPhxabvkhfyMnjO57ySf
 gSzKi3Q1HEgjx/xkdYGaFVZ8CmeLNciKMXV2613bXvF4Z8g7oHI5uwTXvTHsyZUCQILv5+ytYbf
 IkkviF6cWUz7V9zHkm7YlzxbHoWM5mKGzxT7xbccqHRtWP+JZgViP54pKCBmcxN2rRldRG/mB4I
 ryme6JZpQomvQCaCBesgsGAH1LrSiUaZSY2YhBdorBSyoydZsyVRAVKJqU5bdvF46ofbOObPruc
 l7Ga9fJcfDzN3bo9XQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198

Drivers using of_reserved_mem_device_init() and its variants must
manually call of_reserved_mem_device_release() in their remove and
error-unwind paths. This is repetitive boilerplate that is easy to
get wrong, and several drivers have open-coded the teardown
inconsistently or skipped it entirely, leading to dangling reserved
memory references.

This series introduces devres-managed wrappers —
devm_of_reserved_mem_device_init(), devm_of_reserved_mem_device_init_by_idx(),
and devm_of_reserved_mem_device_init_by_name() — that tie the reserved
memory region lifetime to the device, releasing it automatically on
unbind. The remaining 40 patches convert drivers across the drm, media,
ASoC, remoteproc, firmware, mmc, memory and misc subsystems to use these
helpers, yielding a net reduction of ~90 lines of boilerplate.

This series depends on  https://lore.kernel.org/lkml/20260703164457.4040457-1-mukesh.ojha@oss.qualcomm.com/

Konrad Dybcio (1):
  of: reserved_mem: Introduce devres-managed initialization functions

Mukesh Ojha (41):
  of: reserved_mem: Add devm_of_reserved_mem_device_init_by_name()
  firmware: qcom: scm: Use devm_of_reserved_mem_device_init()
  remoteproc: da8xx: Use devm_of_reserved_mem_device_init()
  remoteproc: keystone: Use devm_of_reserved_mem_device_init()
  media: synopsys: hdmirx: Use devm_of_reserved_mem_device_init()
  remoteproc: omap: Use devm_of_reserved_mem_device_init()
  drm: logicvc: Use devm_of_reserved_mem_device_init()
  drm: hdlcd: Use devm_of_reserved_mem_device_init()
  drm: pl111: Use devm_of_reserved_mem_device_init()
  remoteproc: mtk_scp: Use devm_of_reserved_mem_device_init()
  media: aspeed: Use devm_of_reserved_mem_device_init()
  media: nuvoton: npcm-video: Use devm_of_reserved_mem_device_init()
  memory: tegra210-emc: Use devm_of_reserved_mem_device_init_by_name()
  drm: komeda: Use devm_of_reserved_mem_device_init()
  drm: malidp: Use devm_of_reserved_mem_device_init()
  drm: ingenic: Use devm_of_reserved_mem_device_init()
  drm: kmb: Use devm_of_reserved_mem_device_init()
  drm: sun4i: Use devm_of_reserved_mem_device_init()
  drm: xlnx: zynqmp_dpsub: Use devm_of_reserved_mem_device_init()
  media: arm: mali-c55: Use devm_of_reserved_mem_device_init()
  media: mediatek: vpu: Use devm_of_reserved_mem_device_init()
  mmc: sdhci-of-bst: Use devm_of_reserved_mem_device_init_by_idx()
  remoteproc: ti_k3: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8192: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8196: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8183: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8189: Use devm_of_reserved_mem_device_init()
  ASoC: SOF: imx: Use devm_of_reserved_mem_device_init_by_name()
  staging: media: cedrus: Use devm_of_reserved_mem_device_init()
  ASoC: cix-ipbloq: Use devm_of_reserved_mem_device_init()
  drm: aspeed: Use devm_of_reserved_mem_device_init()
  drm: arcpgu: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8173: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8188: Use devm_of_reserved_mem_device_init()
  ASoC: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
  ASoC: SOF: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
  ASoC: SOF: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
  misc: fastrpc: Use devm_of_reserved_mem_device_init()
  ASoC: fsl: imx-rpmsg: Use devm_of_reserved_mem_device_init_by_idx()
  ASoC: sprd: Use devm_of_reserved_mem_device_init()

 drivers/firmware/qcom/qcom_scm.c              | 22 +++------
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  4 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |  6 +--
 drivers/gpu/drm/arm/malidp_drv.c              |  4 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     | 13 +-----
 drivers/gpu/drm/kmb/kmb_drv.c                 | 12 +----
 drivers/gpu/drm/logicvc/logicvc_drm.c         | 21 ++++-----
 drivers/gpu/drm/pl111/pl111_drv.c             |  4 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  4 +-
 drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |  4 +-
 .../platform/arm/mali-c55/mali-c55-core.c     | 12 ++---
 drivers/media/platform/aspeed/aspeed-video.c  | 12 ++---
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |  3 +-
 drivers/media/platform/nuvoton/npcm-video.c   |  9 +---
 .../platform/synopsys/hdmirx/snps_hdmirx.c    | 16 +------
 drivers/memory/tegra/tegra210-emc-core.c      | 21 ++++-----
 drivers/misc/fastrpc.c                        |  2 +-
 drivers/mmc/host/sdhci-of-bst.c               |  7 +--
 drivers/of/of_reserved_mem.c                  | 41 +++++++++++++++++
 drivers/remoteproc/da8xx_remoteproc.c         | 10 +---
 drivers/remoteproc/keystone_remoteproc.c      | 16 +------
 drivers/remoteproc/mtk_scp.c                  |  3 +-
 drivers/remoteproc/omap_remoteproc.c          | 13 +-----
 drivers/remoteproc/ti_k3_common.c             | 13 +-----
 drivers/remoteproc/ti_k3_common.h             |  1 -
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  6 +--
 include/linux/of_reserved_mem.h               | 46 +++++++++++++++++++
 sound/hda/controllers/cix-ipbloq.c            |  2 +-
 sound/soc/fsl/imx-rpmsg.c                     |  2 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c    | 13 +-----
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c    | 16 +------
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    | 11 +----
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |  2 +-
 sound/soc/mediatek/mt8196/mt8196-afe-pcm.c    | 14 +-----
 sound/soc/sof/imx/imx-common.c                |  9 ++--
 sound/soc/sof/mediatek/mt8186/mt8186.c        |  2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c        |  2 +-
 sound/soc/sprd/sprd-pcm-dma.c                 |  3 +-
 43 files changed, 162 insertions(+), 249 deletions(-)

-- 
2.53.0


