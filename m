Return-Path: <linuxppc-dev+bounces-23542-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F59C44500
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:51:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQsN2tjQz2yvH;
	Sat, 04 Jul 2026 06:51:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108030;
	cv=none; b=MLHqCeqQZ2/Snq6ucfDHsNuDcP3UQ21JIJ9gTq3WbqyDYhdL9P/JSVgaJpbTli3iVLL7v9U//Wo//tkNa0bHtEsp8PGNebKij8FWcV0dm+CpZlwsG736yOpCVikaZF4xtXO15f8WJoEXs8UKHqGtJbSx/pVQlkBYwB7QPEnj85T+Bqr39LY+wP18niEHJVD4swGe/juX+UCVmKXGdFoMVjvM+5gdlyLC9b595HCUCZPDhBxlcc0OxhEZiH7tutswTSQiN77ojHyup2MwGRgeEhIYWdpSv5Qq7mTIX9KAwSOKxL8vv6rCHApfw6nUufXKZebqsfXVKfzV8lhSzhKn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108030; c=relaxed/relaxed;
	bh=TQ2PuvPwxYkWt/yOA3YLy/RG2quNv49+20ByVVAjYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6fbUmdjLuFuqFTCP/KFOLdUf1fuBammIknqKPHbTmSUyVJD4AUL6VBnsjBM3urVTDXVBoIbwtYoqiRS+i3unvzUC+wb4lPd0uZi9Gelw3YWLDysTeRaUMQWHyMrgf3hgEIVuNKF3h3SBfFJ6WGSredQ7HTZNty3n+FkQggaA8NWTeBrAZMbrF1Ok+UN305FyC66ZShQmXzVvfqoSg8VGjqVzKgxBhvD7IRj5eiqgx3jmuSrnoYnMSPEtIjn2/Zeua1eELMvdEzy3ZuZoFdCYACEu6gYnQQpx6FQ81S/UqA6urcnT6B4lxo1aoUVrw0jJQO9VtX2R6kHdSVlTsWnnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DY4QvfxB; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IqWKJ5bW; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DY4QvfxB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IqWKJ5bW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPR12Zbtz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:47:09 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiSbM675104
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TQ2PuvPwxYk
	Wt/yOA3YLy/RG2quNv49+20ByVVAjYo8=; b=DY4QvfxBiKqNUjE+FO+PvI+2fN/
	tWkhy2AkYZlVHf5nAR/ui7uQa+iRBuLntvRwgE0dQFPkqzoLgEMw0zeqlayJ/Gel
	onjx03ASz3rWePMh+qGM/a04eeA80fikGiR1H9p8mrt2w/n2sWBvv1DztzavFtXL
	/XeeldILoOCBesxiNfgJ+C4BADjhG2L6FEbE1s+veZRH1J/q5MN7YvhlEZTBrt1i
	tgodfKGbcSEh9Oqr/vvq610x+ieI1FDFMT4rZr2sB2q1M3/nEMAHspCXkJy5Qnpy
	5vg2JXZqEzbKmYlRZWLE71DuByFP/kvnxPtKLGkBzFPdFWg8Hz/Jm6Zj7cQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj1hc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:47:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380ddac2b02so1248609a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108026; x=1783712826; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ2PuvPwxYkWt/yOA3YLy/RG2quNv49+20ByVVAjYo8=;
        b=IqWKJ5bWKqzcG8DFHrWm3p5mS6Lt2Rl6OoPyUGSw0uqGl3cg5PPus+26Bd7MMI1zka
         h+NFzEDSEqUMbFrVM6l4qNUDbWNe0W1hvU7Y/EMp+5b4lIbDV+lFMZYgsmxRP+K8qu71
         PolHQ3hli8f2lFVXVSN+CAv2n20Ex84FAma1yYKwU+Wv95U6mFN/zi5OIpypjA4mrNDa
         LSYa83QKPc9DB/YGVASWQy+i68kAd/pM3+IKRsg772OcAuF1rzBRZEbLgMEDYBYfZWM8
         D1ekQiOLys9MXeFAbs4BRRdU5GcWYLkwGQEQFvSWFSLFqgXgFf58zHRsYcI7cL2UypD7
         0jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108026; x=1783712826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQ2PuvPwxYkWt/yOA3YLy/RG2quNv49+20ByVVAjYo8=;
        b=SDkxv72xbhbxIWwL5zeNdc8ivNBErdwLt3ClvAbz19ZialsrkRyhWMOiVmBndt2ns5
         OmN3HnpPAOLBh8hycQ1SyY/W8ZUb6Q8fNPwjYx2jrz1QFhLlQQdue5PsLHQJ1ETbmZOH
         U61hmrgDwxcr6oNRg1k15712ZJISVibrOuQem9XzzNsXp0ktohza98Q4jPHbhxkrfJAB
         8Sfc/dndNKCdug2eQQoyTwlo6tN/KL4guuFerUHsbnCu2HoiougSXIcvzZOo+XUZKm7N
         TiyB+e7o7dZpkEgtXZtgU2M+5yQVT31OlSF0aoJfIgJ+lBdxhUX4fP1wWz3jPX8jSlR9
         ACpw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9qHS2tdrdcEBw33CRq6WvXT1ijmmWacw4PPaPmxbGtBe82vR+lxMWkcuMnVMrWD+MzP+XuroJdAWHkUE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymfNNkcACk1OfzofqTUfkAtuqf56x6HW29I10ROshmpxUkE6OC
	kZV4aaRVwJgukAYYgDnIe4S4Mu1xq4vQD1USRi5WG2Js+QgKwiNpSwF2JtKKh/AKgpW7Zvdh6x+
	K9tRA8LTuKZeTg84bIE6TJ5zBZvHcfIG4x6dOrsSDwif6Rdl8c37tKzDtaeiXDDACFfUo
X-Gm-Gg: AfdE7ckjmZnjJm1l0q+ecq+BRR00S7B52k71TYAGc8Gki3rmPpNympznr28A2WYPodq
	ewKeOEPmXTsweEtvACcK5LZi1ktK4RgrVRhTgVug8kxtD39Q4bZZiKGHWerNNO8c0WNY8kVqjTn
	YYAr8Q6uF3alJ7LgHqEfjlZDgt1G5KffNDqPcrCGqKFBFsF8lhreeB/kPbXI+8Ki247fpFhiWtw
	HJbuDzKXR8yZoS+7O96IeCGbWEVOKVuGsHQiG2tspZPGW/9GSeXkSoiiKae5cjD6ll3hHY+vAXB
	rlpOmLqBw9yit5IcPwyN/3ZWqOOKZiyU6RY1LMAhHgrpyb4+vu6uPxllOF+9ZmBvsOsmCOjxqeq
	GJUkv64rFhT8vOq444PwziWcBySVQb8g810kP0Q==
X-Received: by 2002:a17:90b:1e48:b0:37f:d262:1e0a with SMTP id 98e67ed59e1d1-38280d999c9mr747549a91.12.1783108025418;
        Fri, 03 Jul 2026 12:47:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1e48:b0:37f:d262:1e0a with SMTP id 98e67ed59e1d1-38280d999c9mr747443a91.12.1783108024778;
        Fri, 03 Jul 2026 12:47:04 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:47:04 -0700 (PDT)
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
Subject: [PATCH 19/42] drm: sun4i: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:32 +0530
Message-ID: <20260703193855.110619-20-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX0do8WyJ3YO73
 fWtc7LO2dQKi74MkpXmFzrRU653Kr6X4sK8YWPAZnU9irpuZJaEU5iW96VXR8oGAOJRh6mCKC0w
 L/PbWZiDN6fNDRqUW1e0XxztzMHLtgA=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a4811ba cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=UuaWy5wPpgFSIu4BNl0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: NdUvySQVBCfvLfVe5o35P97xLZTMSkgR
X-Proofpoint-GUID: NdUvySQVBCfvLfVe5o35P97xLZTMSkgR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfXylRBs6o/nGHc
 K9+1+loVkgdjJ8OoyfJCLP7c6RarSyUlqZjRgUuaOG+IUKIr2yb9mG6icgK5ggVY55vTKMQjuqf
 /S6rUyRzETuaD4dAGDWfUxgkxWY+F+EKVpRdj4tFeYRtcl1tGIES37onvfbiBtMEyR0CRe2DAkH
 4AYWeISkvZGxJvzjNp8QWNuVSbfWyXd3gVHYFrjWuY3pCtACJUjXuzmLvbuOW1uoE+IIQIhXM84
 k0d4OSThg1GuFXqOtZwkIdIrauJ79n8NH1FSXl0l9uYB2WXC1zRximRwSrlCvLNrnJdxULpGYHQ
 ojTnMtUVWOHYweCybfvRl4n1/fVtEhKAGuqf7FgDmf2mThWXXY9nYIFCtAbfsM4JczLNwlKa2Q4
 8+PGm0L2TcR3UwsgScIZZqTLTcsp4P0UrvCHiFSawZ7Sy/8G0XdJaPNpUru2RImn3oy/JGOxH6U
 LEJoEJo5PDF/sjNOtYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 8a409eee1dca..5ca7b6f4764b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -80,7 +80,7 @@ static int sun4i_drv_bind(struct device *dev)
 	INIT_LIST_HEAD(&drv->engine_list);
 	INIT_LIST_HEAD(&drv->tcon_list);
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(drm->dev, "Couldn't claim our memory region\n");
 		goto free_drm;
@@ -125,7 +125,6 @@ static int sun4i_drv_bind(struct device *dev)
 	component_unbind_all(dev, NULL);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
-	of_reserved_mem_device_release(dev);
 free_drm:
 	drm_dev_put(drm);
 	return ret;
@@ -142,7 +141,6 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 
 	component_unbind_all(dev, NULL);
-	of_reserved_mem_device_release(dev);
 
 	drm_dev_put(drm);
 }
-- 
2.53.0


