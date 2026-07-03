Return-Path: <linuxppc-dev+bounces-23522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E05C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:47:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQmR3WqGz2yZ6;
	Sat, 04 Jul 2026 06:47:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107690;
	cv=none; b=I0zO6cAbKfWedHxb/M2n9uifq1xMm58mYPT0+O0LCd3Mw5gA9kyV0cdqNbW3hqlLYfFPAvr2PdLTcMtYEZeI8U7j2KFLlc0o1jeDT1vuMxWRsF7Psutp+lPjeuJkJ9lDi4iJDuZEDJPwJ/KyGryOPWVwwRVPAPXKFfFjXL445h7+LjTW5fwkCvBLcxh+Qhz90GsqISfrlm/OO2Mb01opD+c12VrjHbjRjELnFApKyOaIAJ5v0Ra62wFBXupJlPGIvyiVS18jk2+adtTaFbovRkwa0bSSFeSH/o6Dd1CjpmTNce/tcbICKlBD1bp1GLiy1oY9p9p6NMNxb1MZJYfj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107690; c=relaxed/relaxed;
	bh=iMva+1PZ1+KdQNeTwrqYOxfRk7+6bOU700RhvaCTUnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iywpQ7nERp2W3hAHaVgPQSkFK7mw/kp88BjBlPLUAw2FKxsdRBQRgQsA4vSQR2kWxbGPcM6gE62Uvs8q7S1kKcnav6rvUcMj3Zijn5g4nW17+7DEU/M8UjyfkYPQg7M9MeQoU1pnP6ei05ei/eI0+MDWP3N/NrXSSFC+VokQJkYKP5YZI7VH8AkCEMepBjw5VXb5Lkikz3U3eYnKEbovw4NZy4yTAwuyraljtvWRp/V4lmtTeqWsMdOyLVtKPCNXhf1PGJfxao/tSSouIDXiQlhKFz54vChpymjNTUzquFrrM7sF0D83dt3M6Xx39dL48HGFcMN26NpAuHjGw/5Bjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GDm5wsiL; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duDexqkz; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GDm5wsiL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duDexqkz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPJT6YqWz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:41:29 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiV1n695783
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iMva+1PZ1+K
	dQNeTwrqYOxfRk7+6bOU700RhvaCTUnI=; b=GDm5wsiLQ2TMvz973C+7bjcmlR+
	KGiJp336Y4oOTICwBdUWMVqI146VpcWF6oH7l76OWtFhwQr/KC5Zs9E8CvG9J7Kv
	ghE5vT6lPIQaV3lb9//L6Y16OAJRpWdlXWygrH0x16FdDhVXJ6kE44kz/Z1ZCaPJ
	hhl03lmmTzIpMfqywvxTc/MkGVPxMgdFzcQsj9e+Ow4Q19hKKQpCdYr4vstuLfN5
	nFuUJpQSD/qPK2d7c2OTxO/zefd1KvlVaVXKOCYcganHPsX8mha4UUsMTkmcYIvJ
	oWbjPlo3Oz2VXqGEBrs0OQWWevT4vm0EG6eaNXNQU4rdU4R44hcOITOVEqg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a84a58w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:41:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88da04b719so672333a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107687; x=1783712487; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMva+1PZ1+KdQNeTwrqYOxfRk7+6bOU700RhvaCTUnI=;
        b=duDexqkzCLRUkkOhEmGkPbgdlopPrL3oSpBb/LOF7AYyc0R63OXa8Wv0GtObIcRxqF
         +/xi80eLngXqDphiNyYKMGcWyM1jyevXShnLfgD1SDSAKfEnbTVvzRM2H2U/7zBR+pqK
         m0S6WXIP8X+c5SRDBVYhnC9fJUysos+xHWjAHnQqcuiYHOuZwRJurI5ojw1CSa8SAhc4
         gtFP0YaKW8iSvMuhcydy+leOb1RJMTJexZ8ie7ksrRe8XVpwoAVM0XPdE9rB9YWyJOTU
         /m+Ws4KlKR6UjS1bdx1NXnZdFAsDZfUEB5v3S6ZRm51XSN/wVpCmNYidWjJgRaR6Y+YJ
         oGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107687; x=1783712487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMva+1PZ1+KdQNeTwrqYOxfRk7+6bOU700RhvaCTUnI=;
        b=OerA4LYzPrNBEvpXyH+BWLcFuoCydprqeEwgZzM7WmRt+8Ip4hftfGO9uSBe7l6ntt
         HmIL99QwDsMTERUUfl3XNG1rgTnx+hZhcVWbADWa9t8Lcxu7wBvP4XU03aOMYo8GQ1VI
         8ZVbHKQBO8b2hb6T9dOyTfUEn0mT0QPOfolY9t7bloLs/zknNptD9SuaifMUh4Wc7mSO
         5zWLTwLJT5RgZNd4hGSMlzpDOqe3rZYW2spihRDkT4zejKn0dGYXK27Fe8hjbTJbBAYs
         8IeX0bP3cCPw7Q+AOIjHSWuyRkWRj5yK7C1XM/swMVtBLf2PufpE1pEOTaPETQEOrixt
         5Nzg==
X-Forwarded-Encrypted: i=1; AFNElJ+7iUp+l09Tam+BwnTJssbwPdExEaerroLyK5Su9HjV/7Fdqs+bdzTvKRiw0DXY/UkzAFpI23opilPbKBs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz3La+BO7ttd7EvAHevpW4eLRLRSue8KOMJZsHlOt5dxsEKeNvg
	w98PFPTRPllu2CxP+n86nUpibSoLiVQmcZR1FlZnlwexYGjWoWao81rvr7vAAGYgWah1RoiD0Vo
	uTqoi5YdwNu320ramilGuJRl/31ySCGrH+chL10GdLyxJbJpeRD0xJDIUJRpUnlq+dcu+
X-Gm-Gg: AfdE7clkOHC/D0ABDlrMqDLoYvCwWjydcTBLCMAU+owd1OWK0x2+KZLLFsdhM7wub4n
	/cnSL5r7Iv0kGWmTxCjxrwmVMS3X/zg8ksSj/CeM66cDX4TyqtCXzyUTjDUsS9zeGJtXyWy15MC
	BkxFggcd2c9B/d/iiozhbhDa8YwXipLgedFiIV5RD4shNewqbEpOD3R8bVAlyDIOMEBZ2jUzJ2U
	fTne/lz/JKLVYpGy5CplgNAVrTmIpeEylZPt4lVOKYdwFKiICfqsIybhU6iMKzg0TjnOUEIk3pd
	SbPVT0vjyVGeCvoLDsCMWwk3d12htusgGaIBB9TqfVHPnnLnnhSjEk0jDkw7PtIn3lOq1kG67mA
	u2QGVHAI2MMw+ne+x30I+1fbNYCv+nhf208YLZQ==
X-Received: by 2002:a05:6a21:10e:b0:3bf:bc9a:db16 with SMTP id adf61e73a8af0-3c03e1ff210mr802318637.11.1783107686249;
        Fri, 03 Jul 2026 12:41:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:10e:b0:3bf:bc9a:db16 with SMTP id adf61e73a8af0-3c03e1ff210mr802255637.11.1783107685626;
        Fri, 03 Jul 2026 12:41:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:41:25 -0700 (PDT)
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
Subject: [PATCH 05/42] remoteproc: keystone: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:18 +0530
Message-ID: <20260703193855.110619-6-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: 4Vl3hnPxH1AVw2cDOAEhdEHrUEH1eZ6T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfXxHGEMKtzfiTA
 k31RNWgaqpsuQ+VJ3qae4g0Ow/o6SsGK72mfQpv6aW8iWcnHKEBYqbs5DEseMhal+GajK4zvSW0
 gP4yabmEBUEzfNvzRIgV0Ya9Eh7JBhs=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a481068 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=eZD8004roD30yaJJyL0A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX4tNO6NXgOPD6
 2p333XHhRFCEU9mrEL5/yhggT30SigeqCIyanWUEEP3o4ErqVOrMxzmIU4bNTQVQShhJ09XaLQM
 yqwu2t9vHNOy260GdIPQDhBMrJpEczO79g+bCbAuSCr8pm0qwh9YR2IYCCRvCPuJlzd3I68kwJD
 jgZ1pbpG8u9+JTZEKSEOVlFtqvwFVBqGo+L36ltOs/Qn7KS8a8jbURXxoyj6D9LVXTgR8zeJb8/
 opb7OpId2GVoKOieB7I8+5bpxJxbjlK4+I+s44//100RFm+1YsxMB81MJgTLC0U96bb1EVx2Kur
 WjJoQJMjdZTAKOZ53cOLQ5UGJi+nFFDqiHMSWPBxae9CjJWRtvqjAZqqW8BjEww5awnT3Whbisw
 7hPqiali+iGphlE9P9CGxVhg3uZD2WCk3jQUY7a6Hvot8faqivoQTDM4TgoelIYfdvgf2zJzRI1
 xwPmPpNc61/qZuWNotw==
X-Proofpoint-ORIG-GUID: 4Vl3hnPxH1AVw2cDOAEhdEHrUEH1eZ6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198

Replace the hand-rolled keystone_rproc_mem_release() devres action with
devm_of_reserved_mem_device_init(), which handles the cleanup
automatically. This removes both the wrapper function and the
devm_add_action_or_reset() call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/keystone_remoteproc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index 83763d640c4e..7834a50da209 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -330,13 +330,6 @@ static int keystone_rproc_of_get_dev_syscon(struct platform_device *pdev,
 	return 0;
 }
 
-static void keystone_rproc_mem_release(void *data)
-{
-	struct device *dev = data;
-
-	of_reserved_mem_device_release(dev);
-}
-
 static void keystone_rproc_pm_runtime_put(void *data)
 {
 	struct device *dev = data;
@@ -426,14 +419,9 @@ static int keystone_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get gpio for virtio kicks\n");
 
-	ret = of_reserved_mem_device_init(dev);
-	if (ret) {
+	ret = devm_of_reserved_mem_device_init(dev);
+	if (ret)
 		dev_warn(dev, "device does not have specific CMA pool\n");
-	} else {
-		ret = devm_add_action_or_reset(dev, keystone_rproc_mem_release, dev);
-		if (ret)
-			return ret;
-	}
 
 	/* ensure the DSP is in reset before loading firmware */
 	ret = reset_control_status(ksproc->reset);
-- 
2.53.0


