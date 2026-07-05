Return-Path: <linuxppc-dev+bounces-23579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C615C44500
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtdCX0z95z2yvP;
	Mon, 06 Jul 2026 05:41:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280488;
	cv=none; b=Ea6aiBl6HanzXsHbt0Qq3rT7yIbfyWB0IBZlkCAKlf+7/pLCvpkGNo0KAgIWL4607GKbMDFgMNZyTznWQ5bskAbTiLPy65xANLEL2nUS4W9s+M9MMuTzegyA8WyllCtthotvcdDaB5iizpGSDHMN66oaF4id8NmvzJRq/zJbSK/LsaZrdyqL7sE3nVFnpTNFFFTmjy8hTFvS1vvho3dxnlu54i55hxgUbzAX09DK6q7yvSwUfvCPm11rXJK4XHhJqaWBsFvQJtTjPT14cJxGQiaPzlU7sWXoWJ9Z+X1QPvjARuVsmC8JTNF+d9JMlSLgeN43y+/8ENvBvWZGHeWy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280488; c=relaxed/relaxed;
	bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0dQmwEayMAXiFpXQFmwkm+4rFAxR2bAilbOl1uXvLbGaepEr3AprGpF9zTPTKVIgtyzpsttPixx3rIDS2iwdD0vfD/WR2BshGkxv1zjyTbWp+NnM+6nMgVdXoa7Skjt6WFq9HHXrVhmj9MAMKSCKEdIjl/52HFxF2vtQgOTc6JHNIhhpqLKEB94LSJ2MB1zpgfnPAhPBAkLgXFcZyr6EXCq27Hfo+vkavUewyR8Pj9Y65fVNp4+9jP1I7RbiFaw1wyy94qp0SHpxq2rvnHPrM71cjVrVW9m5ov9Yn+NqxAd+xYYUScCpxPSioPFe3egdEWcj8ZtC14PUzzGtB/x9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLn6zhut; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fDpS3Srb; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLn6zhut;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fDpS3Srb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdCW3JW0z2yrm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:41:27 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HiC1r2325642
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Jul 2026 19:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=; b=TLn6zhutzCtePBXP
	eApN5L/sdm3XfMAHOZhP82YsbqE0e2xRcEAFk/+OzouZNGNfc26qhw5knDcbPcel
	BP5iZZDUvJOH4Kdt2QhgKPJOeoScqNJcXRyWCHIYBBbsIEBD0ZiVVQvHgMHBpB06
	KDdBLLvkRr12JNjMqEtNLmZCzmB3HEASAP+zwk9LWIkse6JF6XJ5aE2oTFOlREXB
	HWsjh1ZGAPgsRx3a1N+Une0Zk6nBS+M8q7Nzxb/+beCfZqlUhL0J/8be0mCDgioR
	WDJzt0GGrulk/kLFg2I0CGVxAo6WNnObMHMMKTDfE+fIZHUMdON7dtl7vgqPIl6I
	fMEfTw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgum7x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 19:41:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8894570b58so1575782a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280485; x=1783885285; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
        b=fDpS3SrbMv4PBw7portVoyeCch6KGrLT3jH5sd2eYazQUS7jCuOnwIW/deKieU8gmB
         BWhLqQiXxOUeSL0p7UeVuU8okHGGA8ZqWRrt4hM10+idwsUTm8h15Oop83coNF1Ivzm4
         ah/hGRijzA1k6doVCgLvrj4SasC9NS3tkKjMgAlCRtnmslxxHSO92MrEAyIL2JZG3PhK
         DxUyNoYV0T6G+/o1p/vNl7bdh8wjhELuN49BCGnC/kNG0DvUUCdBGUGbw+q1duDTr7gy
         MiPgfSxwLfTb4lVacNPEUIWwTrCcrBunNrbSWpT8zlljgILOwiqy37S2YCQrZWzP5w24
         Bshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280485; x=1783885285;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
        b=Q2stQ1SrlZA+NQ7f6on0a+COWef2QL8BJX2EJPrN0KgsP/kqV18cq4Hwp+oTRvUXRG
         5krmtGZ0ezXZx7UiZg8xxBWB/7dXjdZHqi+BBvuxt89v3x0MJQ7zVuKw7t34zItGrAj0
         jdmJx0ITWNgu7qVP/BcM20G4W3Rp2BeMs4xmePVIeMJVVbct8i+zfTuI0YAtr7tPoXHv
         EWXTopMZB9fWY7X6eQ5Ls8vVK6PPgZCInjG3lOzUJrFnSr2QTK+/UTkaP0ZgXOiMwTTz
         pKPmevE5aQjloedFfuL4XvArMiByT477q5LJr46o70qA2xrohU6DUbzWIQgOFDjj+rZi
         Fdkw==
X-Forwarded-Encrypted: i=1; AHgh+Rqn2zxFEBN7lAtbTioDHOy1wtH9TBRSrO1gtep8mA2Sf8MUKg0WM9xGXrTLxa6nLFndt81AOe+ShkaNwSE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyC2n0xgbYvjWp/ctYTJFTWie6FfUzn3lOwZFuTIT1N2W4Aka7i
	dCWzui7iad0oYZK/SYENy9lwPImABl1tpLeAFp4Pqz0aHEv7KfM1lNs4Ac+nDMjKvQNHMTgcyil
	QgAyPEYp+4EZ9AtSBpJQ5Tlg7KlkYPQw3v46XnnZmh6fv7MRqum05J3UoR0nAi5yZme1R
X-Gm-Gg: AfdE7ckeBm4nwuAxyxlP5SJ2OCllQdYu8XEmbPcuNVAAB9e6K+quIVA1PH3FvNjfoRL
	BsXUiJ9qVuOnfU26ifEFrNo6m16aIgErjbx0PNntJt2VWdP2TQVRFNW7CHltlFt5PjM03oNFEn8
	nJpPygZZrfsyrq5QXr3lscCZjhtVaHAq+bKZfZmIP2N33fyiFBd3IQclKTdLfb3WO3icsu9edp6
	1Xp8wo6Vb0ZczuiQHhpLwvA1+z52R3THq54BOSrZi0mpJ+UNRIPOmcQ9Iw7ZLSVg1upeZDxYKkz
	dEqe+X/c5gZO2vlfCcjRrpb6VUt3h//HpbiLMEH+KdbyDq172QOC6JHhyLwisDri3/76q0RkJiA
	P+qrKzoyEGoer6M0Owhel92hu0XW/+ixUiwrV6A==
X-Received: by 2002:a05:6a20:43a9:b0:3bf:9e25:1a13 with SMTP id adf61e73a8af0-3c03e26ff8cmr8745244637.15.1783280484471;
        Sun, 05 Jul 2026 12:41:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:43a9:b0:3bf:9e25:1a13 with SMTP id adf61e73a8af0-3c03e26ff8cmr8745209637.15.1783280483924;
        Sun, 05 Jul 2026 12:41:23 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:23 -0700 (PDT)
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
Subject: [PATCH 41/42] ASoC: fsl: imx-rpmsg: Use devm_of_reserved_mem_device_init_by_idx()
Date: Mon,  6 Jul 2026 01:10:17 +0530
Message-ID: <20260705194019.2565498-9-mukesh.ojha@oss.qualcomm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4ab365 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=dtkDxOtodmQ1SLiiO2kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: rkjNcQQPAT6AXXiBw8ooR_DmgCWziX_d
X-Proofpoint-GUID: rkjNcQQPAT6AXXiBw8ooR_DmgCWziX_d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX17CT516zZ9ri
 CHD5HQg77rQeqW8+q9x5btLLoNyqL6sIFj+x/iHm/M1Pi9yZ/p6Zj2HFCie+o+x06LQ88X1Ikw+
 kqZLexfBncVVXofyllYXnrbUYPIQ7/U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXx0vora/GJgn4
 K6ScCBlWH5wzKi5dpgqW3jqXFRsfS7ipVejt3QDvmztRbfgTFQxLINQe0BHVIKrWwSIqjoaxU1s
 KnySdpZiA4VRrnu+DEJjp7BHs4zSanpkoRLdA8UqzhNVTZF/xKjojtGupfPMVgKnGXeYHETNpqb
 idqHYozRmxTek4o61Hzy5H8t7HbBmYDD5GbzN+lmDWv5oJcy/M66ptuoysBqre7ffseHM28TFrX
 eKqb3tLi2u4gsxMzW5hEQTOAicer7P3HCTwzrSS2aBzrqjxDjiIjFVPPUW0XpjwEKudkhZRpSFQ
 7lgbWlPP2pGv/8QLkr7g4WlCeX2kXKFJXNHNx+L7vaNiP95osiKU4ueL2dnRkIUfOiiwyTitPg0
 jTmrIySgmgT47n1hALBaGTanA/s8UUR/Db52kATvN+lLzlJFKpDLW8gSDC7p/btdJeq0SAxcL38
 ldkgpihHDcPUyq8hWZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init_by_idx() to
ensure the reserved memory region is released on device removal, fixing
a missing cleanup — the driver has no remove function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/fsl/imx-rpmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index 5f1af258caf2..f504d94c4f68 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -199,7 +199,7 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	ret = devm_of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
 	if (ret)
 		dev_warn(&pdev->dev, "no reserved DMA memory\n");
 
-- 
2.53.0


