Return-Path: <linuxppc-dev+bounces-23526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CA6C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:48:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQp472CQz2yjq;
	Sat, 04 Jul 2026 06:48:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107786;
	cv=none; b=EmjSdpGMyCDqEuEbVSnbviTyX6eJgZMzvCE5H55SUMHzm9HvnEH8PLO5U4mEdOng/v30GmDVr3FZT7sm89T5KD+3YwcjJH8RQyn5RidI6jia6wAAmOgPHOii5bXxK9XGBUchhZvQM0MeibUOLuXuW6NJnOeRmUP3xHJuKH2LWdAsjX49/ejDwySiAwK4qFjd0BSsb/vSD2hfkDQUvjoQI3CleS/lmL2tOL/kpT9WRWw+5ESFLjNFNv+UlPlD04RLc2LPVbNxuDwNZ7/t7l5XVxu/qyF3844DnPgQQZk1r68ha9IHXZTaNCHgsL/uVbS8hz1hPhJskMmoQw1+rbpnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107786; c=relaxed/relaxed;
	bh=Z1EEVIKsLJKUgc5TxRSkb+8QfAsvTDn+685DsfCzyOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW3xuN3wmp1cSJsNGXlEflcLsYjkwpnMxaI2+y340rjTS8aL2q1H3rM4oU6yMW6s7w7/LcshGxoM0drmDyaS8FyyVpuUmODGxJKoCh4+P6tdaaQUaIYOr7TthT8bzuWm4JXIlEVuTilXv4PGxCnWqjv/xjdVPqP6zMGfDRe7aTKYJdSpjI7O78Nb/vXUFZGmq+s8RGC1E9L75x4zjOKGZKadk5zimiT4ekX0KSZHHwSBE5nNnVj/webaAu8h+8+Ix56a4PrCnIWevFR0IAKe+a89Aef/ZIR6PQSDcuznBB2uAZlGsC5fxPoUZYXZhx64UWY9cZpUJzst3OaotJdQWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dBy/JQfo; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IlO7HI9a; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dBy/JQfo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IlO7HI9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPLK5KG5z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:43:05 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiRTt546647
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z1EEVIKsLJK
	Ugc5TxRSkb+8QfAsvTDn+685DsfCzyOg=; b=dBy/JQfo/vmPcUgd+SG5C/HFppQ
	VQPpo60m5XuLLe8IZz9VmkujdeOWKORaedTIbeEBXY3MrqaFrb5buG/dtNw1flVa
	gmLIGrbmt1RBL2AacXvRap654MDBA4a6SeaUuliy+gHrr788pt04eMSI9xpgs33+
	R5AZgG4+5VHgVaE2/+1DnI3BIA5lvOsSyAeCDfw9UMvsglqVfpNNovb5N7PeoTwg
	ln+ebK3WQ+ukRC6+S/3BEacZiLuSKmeNDsLRfTMLfQIiHJVlcehaxynQlPbJBxiI
	lA6TlzgWIpcuF6cQsHlG+pIWLBg20HuTazq1cz/Ht4OmvhKuWxEpUIEngyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j02vjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:43:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38096521198so1450368a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107783; x=1783712583; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1EEVIKsLJKUgc5TxRSkb+8QfAsvTDn+685DsfCzyOg=;
        b=IlO7HI9aqRlyJi0xdrLtqs89Oqvh3nURGO7QVveTkSfO9OuEdWEVPQ3+Qlonzquj9g
         aVQvmL3Bk22fYDLVQL9AqDMDefU+0Mp4DtUESTwQ4CEbnfFEiT5zXi5SIyFA7JWTK7yv
         SZhHWwZ3Y31tF2DF83ndCKt3yBZhpCCIrdcttJqbnJ2u6V9HBczNHDOgH0nMOCpffIiP
         X27oWvKfpbJZ5JPDhg+DinwSJpaSiIOA2qzv6/VF3QkeXOUDW06jnlEE4j+6EFpfizkM
         1ehQTZ4n+MnAy13ryoJI7x3z3bsmECDon3+y6ZOqIB1DqY+Qhl16w+EJ1+aCuf+ulRQk
         UE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107783; x=1783712583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z1EEVIKsLJKUgc5TxRSkb+8QfAsvTDn+685DsfCzyOg=;
        b=qu4rR7nrMdvApvRG4NsyqJ7DtIJTDwcffxCUVPx3k8t1Zur7BYJJaaKxIfX4ihgMLf
         i+9CjD54wfQquA/aeqN6HciP0aBkbjHZ5ax8yESCYXB6YuM4iawWSMIT65ibKG0nylrA
         8ljDXCucX7x26gFXvli/D1S5LWwlsy2HT75fLamjYkuJ2AGDOZ+kKb0h6GnFupzWM0Ph
         9gYbcVwQ9hwEOiJiD/ap6qmkQSwQbs5WzX+0rj4ExCmFeuEfFkopdRy5jK9ZFpNTpboU
         OoQZb/0F6V0MKo2WSOMn4aaaydGCr2RUp+eLB8C45bggsCKvq045lvLOTKFRJEoYnjYt
         dzGg==
X-Forwarded-Encrypted: i=1; AHgh+RpLy0mjC3gWAYMCIktfEdZ3uYJivOagqZlItX8XibIj7B49C9LxYNar7Cud1Vs4fFQHAm/ZjuwoSQoTee8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxaTdIQiDOhOjcVxtZ9PkL15pFbNlg5ty+JIeS4FvKHVw1oEwaD
	XsdE9htsFAKCsbo+0yEjO1VBIUWyuovGPc74p7/G4AOCVdQAwQ13Hvt3IlxVJxw+ZMaqXDYuAcX
	mWvGYBDZu7erfkZ4YeN1fUKhh07VOhX6kYwF4FdNLOP76SUCdrC+BsqRyAp7m3BeY3v9X
X-Gm-Gg: AfdE7cn/JggcnZOe0U12A+XeoL8iTvX6z9vfGuRl1cqFv0zCx/zd6AcDQYJ9sCkqBZK
	XXey3vSc81UJxxrygCcnBNa13WCxrZD74La5CB8Mhsp+TtO/57M75Dnj8j3tal/uY7a5TtP/7fO
	SiKlCnWzVL1PXRa2Zi6+6IDweCMVgvWu0Sf4GgJQjP0wwPklDJIRAE3OT/vIJT8tJinZq1IE7nR
	ReD3tJA/rhD06ElOS/J5gEVy4ZHhH2EkXcMbdUjkLisnDn35DwGqeluHFoUo0Lk0/xr/Ph0T17z
	YREoDQPXBtfaeFo1QjF3JDKJ9jpn8YYSiF8JorpN/gLLKt7sUvhjgRFF22D6zdNayL76vzUAEXr
	3OW2CbwsqU9QKtlRzVlT71p5v62niuEod6NyYhA==
X-Received: by 2002:a17:90a:d40f:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-382807aa1b0mr732930a91.7.1783107782566;
        Fri, 03 Jul 2026 12:43:02 -0700 (PDT)
X-Received: by 2002:a17:90a:d40f:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-382807aa1b0mr732847a91.7.1783107781822;
        Fri, 03 Jul 2026 12:43:01 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:43:01 -0700 (PDT)
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
Subject: [PATCH 09/42] drm: hdlcd: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:22 +0530
Message-ID: <20260703193855.110619-10-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: gPcFM3F7phbyHPZpDXH-5H70Y4sPT2nx
X-Proofpoint-ORIG-GUID: gPcFM3F7phbyHPZpDXH-5H70Y4sPT2nx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX3R2wq/vpMbIU
 dnAbXV0koaOWgRSmN94IS6YKHZjF3ZvGzjl5KVx/9/gMEJARxZQnTZLLXOt8rHqIcyFv2AI5Ph8
 7zds2/6OgrRg7P+cnW7kA/VtSyr44OY=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a4810c7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=zu8Q1U5i7KxegdXecekA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfXxL/1Xun2ioQH
 90S8ukTYajQtkfix+kgHZYyBz6gUnaExf64mJRP7SfBcXd2vcfkb7qEWb/jEpepcdENjY1U7Lxi
 L3ePzTHjajjNSxNNx7UfB67duV6Np5vRj8A5gckZs+DdhG1PfCbNBrDUf22ypFumKQBPKPchDlj
 EQngwxlnyAj34KAtWXkdEZl2HdbbKZUzJOo9qG0TVVP+IyzwiLAxXUqrDXMfFFOytPXKmTVmQ0s
 u00qI4YCQPdXXUT2+S8R32ig/ioyuqaGIfGgQ+AQQRBg80IUekwKTJYQm/jNv/uWqGpskwxNMdx
 ai3KWHJvBpGhJNBcP7E+If9BQyL3jIdt6hYqItjPZsV9uX3iJVydvBqLD/4T7vP1dokQ+898jaq
 PSld7CXF6D/T9sr2ioqVGoc9sM6L/+Qk3fBM415g5YZ2Qo6vWokV3oiYy9p6+XOcAm4TGprornf
 T7Smo9kWZsFY0+QwB9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device unbind.
Remove the three explicit of_reserved_mem_device_release() calls in
the setup_fail error path, the bind error path, and hdlcd_drm_unbind().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 81d45f2dd6a7..67466fd441d5 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -134,7 +134,7 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 		version & HDLCD_VERSION_MINOR_MASK);
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -164,8 +164,6 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 irq_fail:
 	drm_crtc_cleanup(&hdlcd->crtc);
 setup_fail:
-	of_reserved_mem_device_release(drm->dev);
-
 	return ret;
 }
 
@@ -316,7 +314,6 @@ static int hdlcd_drm_bind(struct device *dev)
 	of_node_put(hdlcd->crtc.port);
 	hdlcd->crtc.port = NULL;
 	hdlcd_irq_uninstall(hdlcd);
-	of_reserved_mem_device_release(drm->dev);
 err_free:
 	dev_set_drvdata(dev, NULL);
 	return ret;
@@ -338,7 +335,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	pm_runtime_put(dev);
 	if (pm_runtime_enabled(dev))
 		pm_runtime_disable(dev);
-	of_reserved_mem_device_release(dev);
 	dev_set_drvdata(dev, NULL);
 }
 
-- 
2.53.0


