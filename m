Return-Path: <linuxppc-dev+bounces-23574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FACC43458
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtdBw5gq0z2yf5;
	Mon, 06 Jul 2026 05:40:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280456;
	cv=none; b=U86Oi3pSFdGnXOOj0LC8dSxtXPkNU4rheHvBJH5rJfHwG9sjqc+upFr49y+J2DWwQVQtQ33vkIIaWccThI9aT4nLlBHpvZBHVszFEa3KQgIQxCyOvAbEkRVCtNLHTOSQtLscaDE9zIdxC5TW8435OdXlnQdmsuctTJXhRrn78+VrCgZnhbGfFEPy5uy8/mzteIDBocyg+3Ldz6s6n3nY5dzqHOzeE9n0IsJgZvCFZ5ORk3dTt41Czxq9RmhwDmVDJmNsa1u8VLbRpmNE7m1qBpFbI27WB+LIadkb/yKqi+55haycK3cPhAV7uyjYOLVsE84+gQtUpAKH7x8sIlOrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280456; c=relaxed/relaxed;
	bh=hN6fEXJ0a4tH3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEmcPJe8UVDcaai0BG/FufCBVIOyQr7mtSrNMJ2cqiTqRAEL+EJfVPfOKZL+QQ63uEMWTRLqh4AkGhv71R+BS8E2SKUHW8XOeY5ikQWeLpXMw+rUoWIltaTeELbzv+SBucUzLjvImNZ8a7ZIDiLF/KaQLWNPWFKmI3XIIZz3jDCUC5POjC1l7gwoUYKKJZweMWW73Tq1LjIEIfZrYWKyV6oknRV1487E9oHr+qUjRzNe0GYE76c0rcFn+tak3sWdXxidoW/vhutgNcNcOh5FRVX4BK69NVDZpoxTE9DX+21F+eYp7OI9zkQtaQMD/iGe1+RmsGQssbPgI/VWafDmZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtgGyEI1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZJrjYBG9; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtgGyEI1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZJrjYBG9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdBv6WLPz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:40:55 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hhrca2326806
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Jul 2026 19:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hN6fEXJ0a4t
	H3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=; b=FtgGyEI14vKK9OqT430xUfOmGLF
	J5bdRwGnYlPPVp42isHulDlrVXRumzlXOnWaKAvEqFlOMf4WK0t/UVb0tPS4H/wS
	PtxzMba7S17DNMo9ExtOcv+rJsW93dNgj/CIpMpvyCzFyneGj05+u1GK8iECoqyK
	WM1mPqrqXajrrVrH8/J9pdvK2VoDaXNIt2t74egeo5x9BAqNhYqqiB5QdwrFv+QG
	jv/TZ5nh6enGJUvvqqxYx00YdVL+37mb/7PnZAc+8iS+maLp8PJIHST5NiO92D5M
	ugD1/b8iFPnLJM/Dv5JgaqSUO0Jj7Rg0n1nlkl2C0BeSOL69BMELnoL/dgw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh3ct5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 19:40:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so3254365a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280452; x=1783885252; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN6fEXJ0a4tH3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=;
        b=ZJrjYBG9YSUTtG4KJ3Eij59kTqyM01kkR8kQk0erLCloD5h6FkOYakxNMsOyf2eftg
         JsNtsXtc2pM4Xd2sYntXRwSHg7wQ2HvHR5rLdkNnGkKvroOzZYEeGgI8ooBlQCMTtc1e
         1wFXdYylGg/QqTWTjqkNg5T/J2O+eNO67ey2ruLOSXdcWH5ReYSseMuak98AbtgrrDFh
         oDrPDaUzqUrTrpY9mKMaYpLW22KpvCOMQ1IW8pfeW2PStnCdjzW6a7HzioA9SOT8tKE/
         FYG4H/k5Jd+OEIuxqXaAQ/xjLL6EIIEB0Q/0D91lOQcciGchWnIaQaf3CC+LyB0BBUuH
         3zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280452; x=1783885252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hN6fEXJ0a4tH3MRwTjmjwBZxQ0G8Nv14FZEH67BaPoE=;
        b=nugn7w5beg0XGjYKvXKPfgk3m1Do/xrgWbbnVDDikdGk4egnUkJOhxgA34VJkp/e8f
         Om4csHq7F+fbxR/JoZVLaBFcc5vZfX/QvkMZC6Q1WTNAf/Vh75qT4YHJh7o+ob8wqSJQ
         rswiKm2kg1LxFZM3s6GClhDCBvzVKoimTDmFwCUXtoTQ2+U+vohVGvzjARCmuTaHyVW4
         HHld5ElCYlXX/sVYUzlrkq+ZyDup6CIoP6O9Z4S4joLPIu4JtmlnvDVjU36RbI8tdz/s
         dERKleoC/OVRBbzaE0JuIszPnIpa17Pp9CWf/6JlaqfNF8rq3TCwr4OSy0y5zfDeXzRF
         v9JQ==
X-Forwarded-Encrypted: i=1; AHgh+Rov/gBzGLEXQF9ZoaySvnuCq1aGUyluF1jc5AHEJJzZ3PWYXUX1WbzqmlgCRHMAJWdfGWDKPcv/KAwSDdw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx98iYDr8S4RyyzcyNT/8hXJj3ytZ/beSeAQtXflYmU4xUD2uyd
	6CisOZtUyY0BdXCIwCJkWZL8gZPWS4Lv1gDXIGxs/w7p/R1vIhUFPMxJqJp1ypaYFaoiXop3gHn
	yHPnsWY9z0Xl/uqhdldTZJvgfbXgRHw9J7ikHPCBzDhbjznfj/6fL+tu1S0VnfmT4gIlO
X-Gm-Gg: AfdE7cka7+i72HnL+V9xSCIjxGEIsa/qLY5WwYyHCW2uN7dp/cRuCrXnHHBJ+3I4euH
	uzpkmiCzuqy8l2edB8NNXoeQFYbnjHT/RbFBhLVXbL++YeVqS9qxKSIxlSaOH4Tc3uQP1UEfFY4
	Kn+1FK8wVkvRzYpwijtmS69mj4RKRy1EjSMYTpw9pMKjZkj4oAq9jk2EqFFMTGNcGFCJ+s7z17m
	n2YGfC0e/hjz080CxkuIRv5CKR5a3OJ/cC4iuU3vxPuu2Uu+Bp7m2nw31qSop/myDssVhrK5Huz
	PGBl4G7rVwrJ4IeBSdMwj+vBl7hoEdF8TwMrSfSru4cOq6R1p+N7o49cB96ETjVDELffxdKTvGf
	koC9Wt43VfOx4BsVJkDHMgC95N941/AjgDJJlqg==
X-Received: by 2002:a05:6300:670a:b0:3b4:9171:2573 with SMTP id adf61e73a8af0-3c03e4218c2mr7386820637.37.1783280452360;
        Sun, 05 Jul 2026 12:40:52 -0700 (PDT)
X-Received: by 2002:a05:6300:670a:b0:3b4:9171:2573 with SMTP id adf61e73a8af0-3c03e4218c2mr7386810637.37.1783280451853;
        Sun, 05 Jul 2026 12:40:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:51 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 36/42] ASoC: mediatek: mt8188: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:12 +0530
Message-ID: <20260705194019.2565498-4-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4ab345 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=16fIdGUa3qEwhQSg-dQA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXyftC5Yw9OScN
 wC5hQ7x1rCB4yUbvMEMN4FifqvoxhzzREJoAMMOXGleHMxhSbVaY2FrIS92BuGXQa+HEBKygANF
 ObRDu6K7x8o8oFr83xs6LaJMfTh0f0XU1zar6WpPe+G5DtzkhFZ/bYCOjnps0P4Lr289MdjcHV6
 NLhRn0QfVDi+I9dWxPWRLTBz0Tta8havzWnkwTtzXeMiLqEU1A0aOCRsCeciJR25+j5JQnj17j8
 Ac8KhsN8iZZ6G7jcn/nFSraYo4h6CIpXpvwGRXWP/+VCmZ++yD9tEEzEW2v1Whsmn2TwzeijQuE
 08IsYmfagPEOX8vjAg1WF8x1xykgmyj58w7CJzAbQYlVuebAEKTMcv17dKkyccGUR6Ks+Uq2cA0
 zq7hrjMwDKd/lZaFCdnYIJTZJM7aRG29nzrWc00btBcVIMhn2m0j9YwIEfChoatZxKeVWbRDDbt
 Hr3atXdn8tMqeENVh2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX3NhGyaT58pzK
 yST7qen9HiupPy+hNHWWseYT1N8T1l7ksH40uPqFRdYab2qUYa2uhJcLEQHWd1BOl0he9lQfM0t
 GseoJaFB8l1El2cUmBjcM79wSVSVTkQ=
X-Proofpoint-ORIG-GUID: 0tDrzKbqPQn_TCDnKiIUgQLURMQxQHOT
X-Proofpoint-GUID: 0tDrzKbqPQn_TCDnKiIUgQLURMQxQHOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index 7b1f5d05f4d6..ab4ce5e86b9d 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -3199,7 +3199,7 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct regmap *infra_ao;
 	int i, irq_id, ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret)
 		dev_dbg(dev, "failed to assign memory region: %d\n", ret);
 
-- 
2.53.0


