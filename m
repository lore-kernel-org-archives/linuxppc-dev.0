Return-Path: <linuxppc-dev+bounces-23576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAE1C44501
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtdC945rHz2ykf;
	Mon, 06 Jul 2026 05:41:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280469;
	cv=none; b=o1qRIEVdyZ7FjfACwXJH7Ibsz/AcvtTBQrJGVXAgL9KFbpc16LQ4F2dFdRj6EnZO+Tr3ay4wErvZQEn5d3Z6OG3kW1fyCUsVXoE9G7Nos12IY75Z36gjDlL2TgFVIj5HRXLjwp5xWhaIRIMPgPBxkNREno/LFtvC7EVVhZmcc04ezMcTbI+QXVML2DnyxJCmeX8Bw9qqY/Ezrm/P2GkjzMi6E23o9ZQCDPaoGOS0nttPvrpODRxEc/5Vd91eusfLlSDRodFm+t1xyFp2kWFfo6HKw0C+Wpo+jIfgOV87G5STgNXplUf/4EOuelbWC7swSc3X3pXgVtDUlfeEiQZwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280469; c=relaxed/relaxed;
	bh=YE6y7UueLsf6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB+96ozmCMsnO5cYnZz6hOl5xN9BtaXfNM83bikR6sGP7YqCcZgl7+BdapJ5duSb9KMU0p1Dbw8L+GcMVNatsPlEtuXG5Urvqe49khScTS02HnL/xhM5vkKASA6lBKdNqLiI1+6q547msHYLzCQ+8mFdNYN0abFRChtKvkXsgWNcY4UkMcHoejVvyU2kGykYSryPC1pJBhc57gl/Hw6FHP1kg4RaFYqHQ/zEEdpUn8OpvVY13bDadZgUG5lB7V/iSaI+L+kDrwWqWLUUiY5mhe8jLTAnG7BPKGdv9qVSzcgiAytTCJn4Qg4DPftuI4dQjW49js17DV+QBCqsm7xfig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gu2AUpMP; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hdd++mhf; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gu2AUpMP;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hdd++mhf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdC83ww0z2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:41:08 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hi3uA2353179
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Jul 2026 19:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YE6y7UueLsf
	6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=; b=Gu2AUpMPsdWihBeIKFaHZTQdE6w
	3hlEj5FaB6LO25HrrwgnnnhbotR4nd9Z4wSGwf4UfkCGQV/6ByGXzYxc9t77t1UR
	KxydvfiZRzO7LVQt12P9iUwRudBr1BpCa8xRlWA11APsaC65cFh9VkqkdXLfhVEu
	RS7FUpWGXF4DoGxxuONB7a1iHQSW5kUybFXNTGlhVzncQd/ITVBR3Qzh2FEbhv44
	Ssss7TOOyxh8WnUK7ITPBb/1fcoeLek05gTbaYXanK/TXcrfcsX30aor/3gRRzD7
	xH/7V5eC+aAPsHQJS4BlpVVOM2yO5umWhzidCMbdBGwQ6NruQAfsY+kAKHw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sudvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 19:41:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ca0481106cso24488045ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280465; x=1783885265; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YE6y7UueLsf6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=;
        b=Hdd++mhfami/rVLDOCpTZ66anA/s7HTnejgsrMi7j+CphJRhzW9IcyVeCnfme+2vhk
         cNLvZK5bVyanXLWy+CfPvhYLHtT3jVkgOpm4QNmSuj2Y+sGPb2CJxc6dv81HU/iiZ0Ls
         DEjc4ozJ63IMrBilKirIJygLtVmLapboYgvotSeRx9YfcEVXIOl0QV+3tZB2lLuxaCgp
         3mRDe/0quhGEue1qb8M36nilD4p/AY8F9kNYU0g9ZttxWzbprOqj78oF6sHF6NrxtrIT
         hXsO4/gc0LPAarJNnp11M58nj/hM8paZ5yAtsC0V6K/ZD2sBmsiyVJC+S3udW1ONHiB4
         wWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280465; x=1783885265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YE6y7UueLsf6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=;
        b=h01r4xDXb3ncoinQr2WaS55gOFKiFSb0n6sSzQCzRucY6krkyW5nguI9a6xdy0t1Zt
         nHkX3ODa2U8q1N/v6/umgmHYpPy4G2Y2N0bBfpOx6rw6+1E3LvNAReMrWHiVUsnwM5e1
         1Pr5AeyTHomtGHxu5fedpnAkFAB7j+y/4bgcoqk8Xd4yNNMUoQZyNSGDAd8SE6+EaIQ9
         kSZ7fpS3JZHJO3IFLyPJklZLCWFi4Kg6bSGA7M96BPe9VyeBbWm5sRnORCBVUxM7IQZD
         55kjNlFIUatGavrNFO8Hv5fr9a6NL0bkWXRJlQjwlFV+s+Y/cwBHqzZ5J+QEXT0UHBfg
         NZ6g==
X-Forwarded-Encrypted: i=1; AHgh+RoR8iKxZz+S40VTPh98x+AFARPMEWDDAXC1tDCHy6Kokx7M3HO0V0xS/UAeHUhgkvt4RdfGXewY3+cVL0w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzNZDnb6l/9OuCm6VZVQCphkXvJTNcZ7XrF47WGT8/wmgHNtE8E
	89uUvW8Ogqw4p4ym4BwHyk+Tvp7yITQVMBPGTIlzsjBNWn8Ea6E34wSsRTKxIaBkZLNrEGCJo3Y
	mN5Xp1ihTv1ybpOQZNhUmaIBi8hPZLKlmmDMZSuL+5Dkw0uNx3JlYItQPIfCbKZdswgpm
X-Gm-Gg: AfdE7clCobrsTOIXIxJGcgFJ4ErU2t42LGWtyp35nulvhrog3y30mD7DdcPW1+cVmaf
	PaRPAPJqKFwTBJ4SO0CKxxEdar77IjR6kVWnA8zInDiA01P1zt8+qyqWhry0/iHe4Z+NhR+6zCQ
	8CjKUVyDNPbBa8653fw/KDu5pVAcK9U+VqioPK7uKzzzPGqV8vZmG2PdnihbdfL3Yxo0AcwyIAr
	4BCYIKBv9ibt7f1z9Pz9IiDwtUNOEmxqX8CCEgBH0mMHb2rM27hNg8v+MkxLmJKcvi7VhjIb/dq
	SiHoGtQOfnKSD0vtvyfu9f5pjl/f+KtTB/03mOBUMdMwsAL2O1z36CNH7pWQNe9q/WjVidxiEW1
	jFmAO6J+xb9OSpIn5Ny9bKAZ8RQK5pIEXU/iQYQ==
X-Received: by 2002:a17:902:f60a:b0:2c7:f12d:5d37 with SMTP id d9443c01a7336-2cbb9e264d9mr68673575ad.17.1783280465194;
        Sun, 05 Jul 2026 12:41:05 -0700 (PDT)
X-Received: by 2002:a17:902:f60a:b0:2c7:f12d:5d37 with SMTP id d9443c01a7336-2cbb9e264d9mr68673415ad.17.1783280464710;
        Sun, 05 Jul 2026 12:41:04 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:04 -0700 (PDT)
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
Subject: [PATCH 38/42] ASoC: SOF: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:14 +0530
Message-ID: <20260705194019.2565498-6-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXyb5ltCu2XzNg
 3NQOYfBkQ2LOZZ22xJjJQPY1V9aFGAj4xg5FZCX+nYCjxEeyXSQlBT+pGMUOa1/MMzz03+bLoEn
 jsyAs1CIHLaN2cRqUKjKMXdWD3+1wek=
X-Proofpoint-ORIG-GUID: zR6seIU2MQ38k695HVFiM6P9W7RXHflu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX966V7kXDHFyF
 ehV3bjOlAhtIP0onoyjuSZ+RdXXUv8Y/ipZx/A7MUczrU+6kEtzoNpvk33SDhnzqDu7UhW2GNsg
 DTQXEcDOfc2YoZW/UErcGMX5D/y+8xUCK9dPvpJ/AGQFJhFs9mI1JyIxhK2a5mXEquMZHh0rV7X
 /CJMb57vNsBAdk5rl5tqkeb33TRSnNVKkz5zkzq1jRMvqQrAHvMIaGVJP1FbRpra845fAKMdR/W
 tDASTaUYjSV1HigkrRTeZfc/T9FNtNkU0tVojE44j65hC4QL1C8yuwFpLGQdGI/KAbXso5Kqfqu
 m1WR8uhv2wh8vyXUnpdaQcl35+eYaU1mhx6qlolQGdAXqxkRNeHMiJLL5BU18NQoYU87/hti2kw
 E6EEW6s+UkLePcB+5RWgRSjbRjVy/yMKGKZsaQpDXzrMspN8cUMjETASB+bQb4UzmVES9fzVKCT
 YWNX58osGIWysqxNGhA==
X-Proofpoint-GUID: zR6seIU2MQ38k695HVFiM6P9W7RXHflu
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4ab351 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index c1bea967737d..a5ccee87e684 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -49,7 +49,7 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 	struct mtk_adsp_chip_info *adsp = data;
 	int ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_err(dev, "of_reserved_mem_device_init failed\n");
 		return ret;
-- 
2.53.0


