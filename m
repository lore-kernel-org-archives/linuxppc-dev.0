Return-Path: <linuxppc-dev+bounces-23524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C962DC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:47:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQmh3tsBz2ypY;
	Sat, 04 Jul 2026 06:47:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107739;
	cv=none; b=gfLH0Ct3/CcpQwOHtd48AT+CJ2q777xG6lgqUnYMB1/fCzR21WRkcoHdigl33TXj+imkG9sNh88XkMKPpnzRpvbrg7kH6kNQhTDAJPOJP7wZ67h/PDtzAbcAPhflHY4o5rwmodCPYiRKxVIphCaF0ehZLNT+yizjM6waVyCUPqWlXeHaDZz5li/M48Sw6LXp3NbKDYC3VaaSnvY8lfL1g1PBRxiTsRZ84rVpNKWJefiUh77FfEhOIG7oak7Befgk/bRRKcET1i4Aj9I0OpbN2YeEoW1NB/cZBMfXF4wjN2gfmz7AWhB6lvK6ZlrvBBezP/d27IFfisKuPxfpNgbr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107739; c=relaxed/relaxed;
	bh=fk9/GLsPy9MHMLueq2DDIsdR8wBa5mOqZj4lU8apFQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjeDmbXrLMMbtNP4of7qWrEJpaIKsJw8BLnxM0nXAUbl6ifzT3Y8rVxtDomuZsI7Q9po/cNCwmwRLuAAdnwHcakMZz0qo6fA64e/Wqva8vnZo/JV/aDWvifiRG0AQ4Ckwzk6gZLfFOqhaKMjr95Le8M0Zna/NW2SFf8UMUsVF9PGd+90WTILObQE0vWPA0XY8rwE3QJBUqPcVZqGu1wwLmtSl9oGaMJYxxCaNhqgzOrS8uoUUhEyvvtyZSWIX6fy9L3+sLKh/8GY/M3w4BH33X2dd7S8GZvPbtpb9ZxknSkY38UQVicmN7ZT72sDUKkWP2UilyGru+bz9bCQ5tib2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ri6qsvH0; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C+yijyyR; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ri6qsvH0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C+yijyyR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPKQ35slz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:42:18 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiavA675622
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fk9/GLsPy9M
	HMLueq2DDIsdR8wBa5mOqZj4lU8apFQg=; b=Ri6qsvH0IQB7xkBldT85DbEuPR+
	V38c/QBjrTx3QAafrYlhGfVLLgywea6jC0l65ZPVm+U3OmpMLlZ2VV+buorCWD04
	bPspMhxpQP3PxJgSkqo5xItrUqIdk/3FX8SpHBpXs4HooIhx3sX33Vm6KIAIvuuO
	V+zfVc1wJpwX93k13QZzhz9J8673uBXFJQFPim6Amvhm2v5TN3gUh0UgLqfi+nD3
	BBivAzeFqowQTT99u2jDYsv71gJbnTCR7VBBQLywg7pl2+GwxpAmKoOyAAxYXYRC
	H0KctSWMLFGXaAlJi6ZSIXtE97kU1lZAseBWBP7EoFJBmuUPuQyLsm2DrLw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj1gq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:42:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37fc66ee6a4so1459559a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107735; x=1783712535; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fk9/GLsPy9MHMLueq2DDIsdR8wBa5mOqZj4lU8apFQg=;
        b=C+yijyyRqmLRghaR+KdMbbjb5ZCpmoObASwWHywhfTAPGyvZzGYjT9VXIu1yKUYRdi
         AErZZBHUkGIPfiQzH+A/z+lNAk3SpJ7CzWWV2t3bVECtcWPrKo6hGHycUqbamxXfXLvB
         UdISmmNusSb+fYGS9IdBBeZtIv3GnWc0ZNa0qoO8iyOEC6m30ykWdRkpz9o9WIiw9cyY
         Kpvb8l9eDqR9ejvkNIPPhBDr27BlP5o9J6uSUbLcCC6Z3IZ6qMePcnFpFPlGod7GjTDk
         tBWbkItd/tW+qK3WtB6AUmgMkeXTJ8F5QrpUmdlIftZRyqKzBZG5EJjPoRDB/6kP2At6
         r8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107735; x=1783712535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fk9/GLsPy9MHMLueq2DDIsdR8wBa5mOqZj4lU8apFQg=;
        b=ZyIyMn5zCTMd9pbEiBpD/qEZbghyKWvjTpv8mCa2NxZh5YSP0Fpi//4+Ot8rO3j20O
         6ILBFnYC6nTb9/HEygl8z/SzkHBPVEPXMzCSlytY89/qd+SzySULPs+G9y+iYXAB7zns
         GwrfOKwC13+kcN4hz4hb5eCP8vAlEwNApG8cuJ8iix7Iik71YeYf5mosFtjYvoyvFGO8
         WELvLqtOP8M/OiqhuXOhM4IWHIqSPQxANiNxvETWUXRHlMgA6NFko8xy6q9ohzwb0qpV
         dNL0Ie1616IWQew41YYM/JyMTBU5G7UQ8lX/ft1nDPSsiH62qahSDYSkv8GDNK8glguG
         3ezQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNWFP4kF1NzeWwPetWnhgmzyp4J1PquDjr0+HIoiPnA8LA7CQSPL7AsI0cPfkh0X8lu/Qagom8CYvg0PE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5oB460/T5YJIELIB+Utc3YBnz0t5gwkiSlEPhtJZ0v/cHVQVA
	T/oUWdsDvUpNRQ0vyNa4anC3fNF6XBq5nCM0/LP30XCmiO+uypuMEx1VC6nbgD1U0M2HUOBUHY9
	fbLrlf9c0KTrn7jfILWywaiJicY0/llw5hCYJTYZ62ndl6ScGQf0ga1HPJoXFO1NxD2yk
X-Gm-Gg: AfdE7cm4pQeHKUxqrluIdKdOR1I2xHeGfxm7TZ9vKl6b1BRotj8uywA56YAciZhYS5V
	4FHe2WmkMl2vvB5fUPEDg5QPNDkjeSPYMp/gxrq91ZANyW1kJ78FEF+dRBfHW7cMrtjmP3aG7bp
	mgd1jVCI1s8JeuLeX7CL9Eaox4uSxl1TcehLsH3RpHWKl75Xkt/kdjOiSOHdFfrjdR9LioDDfRV
	WuXAAF0Fyg6GjWhtl0SbudDUj3VmT7TRHVkmgnlNDeMn6BRetUg2Boxjfd65w3aHANxff7hrLn1
	4JFNHWhLpSmcRCIkoK64xv3rSz7GqQwqvA/HaSfRmTcFJhZ0mub1LbcyPLDuL6yrpYDN4qjVDlU
	3EPKrHnQeyBfr6q2rdYw16d7hOq+ETinM2IXqUw==
X-Received: by 2002:a17:90a:d408:b0:381:854:dba4 with SMTP id 98e67ed59e1d1-3829e933299mr718669a91.20.1783107734446;
        Fri, 03 Jul 2026 12:42:14 -0700 (PDT)
X-Received: by 2002:a17:90a:d408:b0:381:854:dba4 with SMTP id 98e67ed59e1d1-3829e933299mr718564a91.20.1783107733767;
        Fri, 03 Jul 2026 12:42:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:42:13 -0700 (PDT)
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
Subject: [PATCH 07/42] remoteproc: omap: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:20 +0530
Message-ID: <20260703193855.110619-8-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfXwmf6dG2yqB/o
 uOn7NOFbObtIZjAlx8sS2+dOzFtTLfojebf69PgAGdXsLS52T6Ucs5l3wa4ByxeuHcu1GmuUYiY
 YsbH3pv7P0K3f7NfNYJ7390mVikTwaw=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a481097 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=NeIE-sOIGFWZl2hhsKQA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: GMZJJv19lsDiN5925UesM9v0-7sxoM1V
X-Proofpoint-GUID: GMZJJv19lsDiN5925UesM9v0-7sxoM1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX746fpv6P+KDW
 zzv1Ng3mSUmsQFwAzB8PVVEP3o9Lc8qXBWeUD3K0xx94CK3hAuf0wmpPxACq+JvFnkDBrnziuDw
 H0Pos7ppo6sMzgqbvupVRG5Gnt4IemFyzgIOspd4+dGHd6Jt4q++3hTbAKjT9YnPBIMc1WH815i
 fQMSMqu4ehzEfrz8Aeavs3MnWH+ax0YfRG5pQSlqiLQ8ARFCpqpqi9dVz7rfr/goiCNe6R0GTQf
 LrbGBFPp16RFTxGXFmvzTDOXzakEqTnNXzgaNjbcFEnnrbT8zMcpLxlE1Eulve6TFiP6NNhv8NR
 u/02RgJayeFtY10t1O7NUUOYY+CRR+NiX+5lXqbH0OzuugTuvWb69Wiq+aXhxqFGZ2bjMnki3RQ
 axMfeJY7kC3r8vcFjFMR3MIg9c4rTN7/X+/rTgOfEFdOdnX1vOLGBrEmCZzW1/ubWKiBGSm7JGg
 sbBFE70XQh6vP/i4gAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198

Replace the hand-rolled omap_rproc_mem_release() devres action with
devm_of_reserved_mem_device_init(), which handles the cleanup
automatically. This removes both the wrapper function and the
devm_add_action_or_reset() call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/omap_remoteproc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 6ed0f28edac9..74262f873d40 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -1276,13 +1276,6 @@ static int omap_rproc_of_get_timers(struct platform_device *pdev,
 	return 0;
 }
 
-static void omap_rproc_mem_release(void *data)
-{
-	struct device *dev = data;
-
-	of_reserved_mem_device_release(dev);
-}
-
 static int omap_rproc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1359,15 +1352,11 @@ static int omap_rproc_probe(struct platform_device *pdev)
 	if (IS_ERR(oproc->fck))
 		return PTR_ERR(oproc->fck);
 
-	ret = of_reserved_mem_device_init(&pdev->dev);
-	if (ret) {
+	if (devm_of_reserved_mem_device_init(&pdev->dev)) {
 		dev_warn(&pdev->dev, "device does not have specific CMA pool.\n");
 		dev_warn(&pdev->dev, "Typically this should be provided,\n");
 		dev_warn(&pdev->dev, "only omit if you know what you are doing.\n");
 	}
-	ret = devm_add_action_or_reset(&pdev->dev, omap_rproc_mem_release, &pdev->dev);
-	if (ret)
-		return ret;
 
 	platform_set_drvdata(pdev, rproc);
 
-- 
2.53.0


