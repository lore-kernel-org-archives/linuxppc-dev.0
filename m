Return-Path: <linuxppc-dev+bounces-23553-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB32C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:54:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQx02JMQz2yfs;
	Sat, 04 Jul 2026 06:54:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783111223;
	cv=none; b=CWgNfpPbE7Zg0bm0wnSw25NqCk7mQnpJ5k+rwyNRXrDB/ns54DvH9YdX1vaMycAFcKW9PSzN2V4Devg/Egw2HuxmtB6AF7HBZFwOuelPd71ME+lJ5OXG79vII3EMUS0d8NZZBl3VwuPNajVU+uZcm1LJNaoJtK6Aib8uaUUR5Fbs9Y/yWyjp/kjx4cr35rWg5h3iC2+iREc/CaFp7+dUGPVWOAm8eul2ISP2o3QHMHSVONLhpcHkvfbE0M6q3S9QNLfsfh6eu10HUqzp7nro0c08Q8vOwab9Bw+xLLOSMYrxQOGJmjTaVOiwEU6S7z1VwXX+TbH9Q6mqWDDKgQIfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783111223; c=relaxed/relaxed;
	bh=zR9XRPc5AVucodt4jcddD2QULOfOq2FWZnJr+n7Dti8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp15ejmUVsHH/nHzj4L1zSSCxhvsSHh3bm8HEJMIuwpM+y8AaOfbpe80kM+af/lzjw8uvUBMJ3QH2u6ZQhSEKejeuk0l23kRhqZIN2JoMF2ExaZ3zjGGfhQvFdKek1Pi5Ajm6tTt6reUo7nVQncGr4uS8JzooiK9nc+vRGwfejEKSFUnwYm57TP2GzSC2xmV2BDafRYhO1/KPn1QDJy8i3VE58UhVNHL6NSPhodqmIE0RD8lP7O3g0pYAqbAES0h2eRpx1W/9+epZAj6555uJD9mNH7IrF0pI/sHEUxUNaMjr7+2B67eWIVJ7wTVz8eu9xBZKbxdB+o1U7fW4etODA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J8ZGLy0x; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VlvKl3DW; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J8ZGLy0x;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VlvKl3DW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsQcQ36ZLz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 06:40:22 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiPVC545518
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zR9XRPc5AVu
	codt4jcddD2QULOfOq2FWZnJr+n7Dti8=; b=J8ZGLy0xXXuEjWJGW3BRjxYS6bM
	3+dbuT5zbOpIDAwUtNGrTXtoVnVWOwNUo6eIEA3DECCTEOtiBQ1DMFD0phWfoFf2
	dZFkiD8S7fenOGLkh0uuwz0ZkVjPa2JedzgOBGqFoBe+xMf5ZHKUOiSR5XFIcwzg
	mhGkObWbnIWinotY2TsclIJMO3qilpuGC9sJY+SB7NtO+LXzC21V17p4igcMbF62
	pjaIAo6TLB7y0l6+cDM1nurvPxHtA5vcKRXylW6Y4a/iQr5UqazN6A1IsYRX+Vhz
	/sKeBg0qQU3hsuEMTB5UiS1sB1Gi2oxTql7R/jI1L9tJWier4ElBv2IRhgQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682btqr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:40:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3811ae55313so749762a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107639; x=1783712439; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR9XRPc5AVucodt4jcddD2QULOfOq2FWZnJr+n7Dti8=;
        b=VlvKl3DWLaz9uGX08gn16JMempUQNzVqeIdJo2Bz7slpJmfrt76ZrtCkBBxNa0zxLi
         wIXszHY2pRAcksbjz8sSE9aLP76oMKE377+5kCcWr3Djl2XY81fc63dr+xnJX4S4nWxm
         tocef+sSTKLXyK8VVy5E8lj1opo9Qd9J72MwceMC3sV9CFuXdSR08RWV1Ycq/k9Q4GPJ
         8mf1mqONxPgCCnqFM3c+IGDZe+fYv8ANhzkMFrV7YgzELrF6ljgARU8uOzHthPO/tK4v
         0aeaLmnzTEKrsvrzHafKGFKLXbIAox4L0TCGc7o9fHoYVKxHzjsTbFrUUPDSi+5KRRJ8
         PqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107639; x=1783712439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zR9XRPc5AVucodt4jcddD2QULOfOq2FWZnJr+n7Dti8=;
        b=hP8zE++HPKtY+vHjNnqoswxg/vcFTxvR3o6Gb2svbGXIC9R8zzPZ92sJ/pcegTZMhe
         YPeZg0G/CJrVg7QTnDeNk5aKqtGAfpizdJ24aMV2cox/ub8RtHiiujIuCwDnkaHYo8Ch
         QFWW8sdjuAP4ZpxmJmpotxLfxFgWYEBUCAcFEj0w/PM7wK56koc1if1/cjibUMTekGKv
         Wgul5AN8+2OzzBS1bf0kvSlKLyeGjfLvNnJp5algT3sx3K4+gicsLPqrKM9+GE8eRZV0
         uElC6ojRJZr78VzmgKFmDAOA3aqpwYhtDHJMNuWK4HIvCuGCNlg1+j/NcKQbOvjgXLuB
         qwUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdrJfNH+eDgErq74z4oHQ3Bd+8hQ2/IG33V/oAGOVObendDMVgUKfIV6ypUfnQNIqy17V6fxrwAJhMXWM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbMzuJTVvHMyJCjp0LuMpFmbMjYba+Q12eK7fxLJva3sWrhTdv
	Bix9pUC+2M70e2p168pG5NGN/hm778kvmNWTIA5EhV7LTonzEvfyKhcRJdIMlPpZfxiUyc7FfZ3
	CyP47xMlRc3d1GKMqWRhfqudu40IeUNP1FOzKuSm9ms0fCcmjBCkZMY2msJ6kH9IG3TjF
X-Gm-Gg: AfdE7cl3/sBEuWOcfOD6s7gpxYcsSZ5Qjq2p706idBwQZ509Ud5Gx+EUiq63Bd7bWtP
	nxaoi3WHoRT2CyNYXak9Udrr5wQ6IhybHVitX1bW1XzGCPjNukFveDc5uT6D4sqddWqaBKpN9JB
	Nplifr/a8SUn3jyLGd15uCE2R3Z45JufptG91/OmrFpyddmSEu3ibcZ3wJlCozF+Vrmfstpy7bU
	N6iBXT6l7hAt8Vrt1xOtIv6wcXjInOTyzAXDJMnTSrx0MlH6jfJhDnTF1w/g4LxVPKfFeCL+v9q
	5xK2jIJJI4cliG/8p9jOKjVKrip3VvngfWTU07XPBWkQ4mqMuy9PtfW2/7v2K4JfUhry/hAhxub
	lxa2E4PDUZw2Ya4BW+nBq35p192PuZHgM5l7pZw==
X-Received: by 2002:a17:90b:3808:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-3829effb428mr834225a91.24.1783107638303;
        Fri, 03 Jul 2026 12:40:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3808:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-3829effb428mr834169a91.24.1783107637623;
        Fri, 03 Jul 2026 12:40:37 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:40:37 -0700 (PDT)
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
Subject: [PATCH 03/42] firmware: qcom: scm: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:16 +0530
Message-ID: <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX3wEDiYnu+wke
 pKacuim9D/XmK/jOezBxIHhilbvdtCnExocSOex9Eg55JPwtIgbrB7HUNXaMcsQ139QaNGD38s9
 EVuCDCygnrVY6U8aR0PLKPrxpva9oRg7aP27k4xSwb5ZDl0WdRAKmbdDzVssu0UcbKwNPeM0GCn
 T8OXIkQAGt2EP6sP4+dpYSxGuzFff9QDk7dhZgRstyJAt9DubL10MJFwCtq1krzvSOOkLCY9UGt
 3O3lHhQwg+IGA0GgOmzwdNwDkp0mdmMzwTsTpioMc69e/SntoUd2ZxbWirqMdI9brj5xmNR4F3f
 ijb4TUgpdFCB0Xzp752wap1l/DbDW0S2H5RKE2Xfxnc4ibFxLsZH5u/LqW94hoBrXGq5aNChUXN
 AYPnCnbK/eiACJ1Oj4G7RHfMtgqgCxUSBCLCUgXa5gugTAQL43fWoNySvlqFed0gG2aT40VatGC
 l4OJrDK11a9H4Xb6fOA==
X-Proofpoint-ORIG-GUID: QDER0zgPx-C_Vj-6cwQ4eVNxXY3sJmqJ
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a481037 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=-SVse2xkFbf2KMwQCVkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX12RBxQWoh/zv
 lpQJPRMv1cxuTPuujMgxXFbACSmFq95D7b9P4L8AYuXhIAJWMyBv4zDnmaNxDJAjMbyDe7hx56P
 c+O/F1d4So9WpeaLyLV83hOBo6/75v0=
X-Proofpoint-GUID: QDER0zgPx-C_Vj-6cwQ4eVNxXY3sJmqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198

Switch from of_reserved_mem_device_init() to the new resource managed
devm_of_reserved_mem_device_init() so that the reserved memory region
is released automatically on probe failure or device unbind. This
eliminates the err_rmem cleanup label and the need to call
of_reserved_mem_device_release() explicitly on error paths.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 26bf87247afa..0f9559b9cc53 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2779,17 +2779,15 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_reserved_mem_device_init(scm->dev);
+	ret = devm_of_reserved_mem_device_init(scm->dev);
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(scm->dev, ret,
 				     "Failed to setup the reserved memory region for TZ mem\n");
 
 	ret = qcom_tzmem_enable(scm->dev);
-	if (ret) {
-		ret = dev_err_probe(scm->dev, ret,
-				    "Failed to enable the TrustZone memory allocator\n");
-		goto err_rmem;
-	}
+	if (ret)
+		return dev_err_probe(scm->dev, ret,
+				     "Failed to enable the TrustZone memory allocator\n");
 
 	memset(&pool_config, 0, sizeof(pool_config));
 	pool_config.initial_size = 0;
@@ -2797,11 +2795,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	pool_config.max_size = SZ_256K;
 
 	scm->mempool = devm_qcom_tzmem_pool_new(scm->dev, &pool_config);
-	if (IS_ERR(scm->mempool)) {
-		ret = dev_err_probe(scm->dev, PTR_ERR(scm->mempool),
-				    "Failed to create the SCM memory pool\n");
-		goto err_rmem;
-	}
+	if (IS_ERR(scm->mempool))
+		return dev_err_probe(scm->dev, PTR_ERR(scm->mempool),
+				     "Failed to create the SCM memory pool\n");
 
 	ret = qcom_scm_query_waitq_count(scm);
 	scm->wq_cnt = ret < 0 ? QCOM_SCM_DEFAULT_WAITQ_COUNT : ret;
@@ -2872,10 +2868,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	qcom_scm_gunyah_wdt_init(scm);
 
 	return 0;
-
-err_rmem:
-	of_reserved_mem_device_release(scm->dev);
-	return ret;
 }
 
 static void qcom_scm_shutdown(struct platform_device *pdev)
-- 
2.53.0


