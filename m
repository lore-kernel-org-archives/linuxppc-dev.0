Return-Path: <linuxppc-dev+bounces-23573-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22910C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 19:40:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtdBn70hfz2yjp;
	Mon, 06 Jul 2026 05:40:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280449;
	cv=none; b=iI1c09mH9y12bvyF61ge7mMd85BGMcRfut+Q2o0McK6AZ6nQTZc9GJ5nX2Yar4QwwDEbV9MRrDHSVWyqgROQeNTFeShPQUD1HFBOPHJFBLiBGjf6gjcEs8cuJdK2dXkJRSftNt8dNo24l8mXGkFanQA5SjDjYzrOqax1Ff9ACsjH8zP1zLwI5bdCZ+q5gOJ3NxoNTByxxIjE6TX+oJhb/yAow+1qh4v8B7RJVgtcBP1n3ye6JGzNxWujSn8l05lnF0I8hVojA1DP6U91u28OYn4cx30ptzGYyZi6LoXl6joJAE8/VYjYjvZfqWKoAQAGSP+dyxGOlqNrLDBor6rxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280449; c=relaxed/relaxed;
	bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQJ9la/vulO/mM1P0Axm/5wm96M+pAbzIV2x69P+2OTeZZUlOvvwcqKZZcACbOK9yPdLrsx2ifVJxbKo4GlYf/VslgIODTNG1XzzKJpMBt7kCfmaBos6cgOE421d8+hiKOOMjj1uP9EtxWblIgOLFyU8e2h9WSdQefoX8imdhdSGu4fwBKKLugA2FWH0MgQFnCZnGeLshMXFQFxMieV4WvUAbzRzbHdjGBe3/HdFWd8xj5ZAHWfBbODalHbFZfHYg37n00JuWszudYhPgO0w93iCBOo0AxVDc2fER5UDTtaqW+6a7jtt7CMgVypwl/2zDQZ+EkmwD0duigrplR+2fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lc/WGFTE; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIucv+xL; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lc/WGFTE;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIucv+xL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdBn0pd7z2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:40:48 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hipe52316884
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Jul 2026 19:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7OthzF5yzbE
	g8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=; b=Lc/WGFTEsBR6FyBf8pb2q2cTo/S
	IRTkAnMpy4BZluObjv10Ds1+8wWUnkRZLMFnZfxn4lwUf9wNpTCxvblYHfxq/YKl
	Ovc/Cj5jLSEuk8ulecmXZk1CDgTUxGIQtjZKnuWR+K1jUu+ftDDZonwnoZEjSzlk
	ct1xTk+NVIo42IekyeGwdAr5vq+YHarJ6RB16P36dz97W6pvhWCceSyR2czSTYp6
	hSXnIp2oW/ZkZTxzubwpV++50pKMPkSorshnXRFfqderNm50KPgm9F/0EgLX4x+X
	hMm6Gy4Wmztc6y63i7GrlHroXX0TGdaLddDcR9h9VbzCKd2rrL7p6658Gqg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8uk9su-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 19:40:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso3250198a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280446; x=1783885246; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
        b=AIucv+xLUQhEsADc0rVsHFl2Adsxwq1j3/LTmRC209BxH9sRzMWd0Nc0gHpaH6mMNj
         URkVavNT4vARWI/PrG/BauYNXo3qBZnYSCoO8g6B9ptvk9b1sSf2lRJQm2wjxh+WFszp
         aCC7E2eAb5xorvATod1BD65pYkRb6hJux/qT3lhzx9l1ueGbuiqCHDHnc7GmTXeX6+7g
         Whvex6qbSMRYjw0kLjFLZ/eWotBF4GDZjU6bahfnI+J8YFM/zLAqTcelnj1QF/fzwsng
         huSeCs3LA68wwHoR4deLS96WyB7dpHMSXeLR6dHoRkgeMhVlIzrdVOHamPSjmRKSGKj1
         wQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280446; x=1783885246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
        b=eORsM+4BT5ipOjTGZeJCK6/LI+r+NUKJWSu6hVN7e6s+fO2RjW5usTbDYVdJxOiv0x
         ZJVdtjH/7wmifcWlR0pfsW7b2pLgR4WIU/WRsmGqY1wrm9ep3rF7JsxTTmztjPTtiV1n
         94FdnE1CQZurbyinDPN+ZxZ1aoTuVwNhWuNeSIPURlugz5+/ApTuQvLuyMLSo7vQKGDr
         6hAhX9HEQIIpzkUM4bGG55xEuxHc3hOf/8saf9kgy8Eu42NwBSOJ5tTExfMKZ+XcfCe4
         eHJzSRHZvj8HWu9TuuIJJHpwGG7jiryA1Ee3zMmwG4Uj7bwIrjZitVQHeA9SHRfCCQ8o
         18Mw==
X-Forwarded-Encrypted: i=1; AHgh+RrnFiy5UPa3DnKO/59ys5gm14njCUjF+suQD90WUWOiLowl7ZyD3EgxL2tPT5xlPr9TuRgNfB8g9vk0yEs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzkJqyCjP1gSVbnvZImGuCXv/ZcXTkACk5EDAx7pUT+qhbZa2ML
	cMgqqbU2DeQtUijPz2GNycisQBaibahX0N62pFXU9ULf7++0jJSzBO26WvDgSr/qTfeQXRJjiaD
	3fIE9ru6aOK65uSrwSJMdJQi3JKwEAiymYbChWSY4UcGFUtJLeeLniqOkXeBDnP465H6m
X-Gm-Gg: AfdE7clmhd2xPwUkkzGgz520gGHxinck7TjMTXswmzTaU57Q2nq0Pgh5SWKqOQfddU6
	qo+opWA3gaWy83WN/x18iK/jHzg7TQBasLD53Shz/yuUt7XCyiX85YzSVP/YYRr3BjG2k3Ro0cd
	HY07zzFlNhJIN5oD64TuMYbcVIjbqLzZu1Bp87aVOUu6BaL0OmYgLD2wArRpeiV0FOPQtkQCuip
	ZVuY4r3Ho80Ivn9Jj1eyFYsseHVU8ZlHoNc2SYdXf2MsGnOfa+jH7nC3LE8jP07V5ol4AlL/SFT
	82noETWmYjcFghTwDfafuVrp6S9nBY61vZT4PWJwTvMyHZklv//hjtkYF1dZJGV7WIK9jkItgHl
	DfGd1wjGUZzRqZoK9Er7oKbCYCixhYoCMaia7kQ==
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id adf61e73a8af0-3c03e521435mr7049935637.60.1783280445927;
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id adf61e73a8af0-3c03e521435mr7049907637.60.1783280445455;
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
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
Subject: [PATCH 35/42] ASoC: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:11 +0530
Message-ID: <20260705194019.2565498-3-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: vM1Aox02MNIyBb5YWRhklX9FyGlCeM5X
X-Proofpoint-GUID: vM1Aox02MNIyBb5YWRhklX9FyGlCeM5X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXxEUSJ50zAFhG
 JzOvHo56b60vzu2eLLLEofQjMUIzL+SBLLnwg+d7yzfb8B5HJ1WfMCsHBB8yIcQvuSLg9xz5Ibj
 Jxy2ZJJ85nXX+maXN1XXeE8VhDnobp4=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4ab33e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX3bhMp1wW4I91
 nKjRzKUkAogrW1Vj0zrMoTevObMv1DdPtIZIB1nxsMDacQKz51Yk9zguitOr0JuwwCratW3tM8r
 7q7TY/w6wgl6K9RIUilFdH8ruxK1NPJ+gmS7Oggo9c/3Q9kGBuekylpFwG2mDb7S6rwfUTXoFl/
 5mXHv75hbw2RnjDkt+42n+5FoKKXIygb6Ct5EDhW5W7z+w6zvlJVAqwJsVDYHzMxPP5PK+BRemr
 BDj+2yOhpYITHLKlQXU9oC3SrT8lU3OadrDZid71cjRP7Ri6sIyahU50ucld7d6ODXiwbn6p7li
 q663Q3Nh88ynM02U8tdMP9LRJptMMg9msjlgS5KZSUBOU/DErfsEaj3tcjadhMiMgtuNTpKAZ4f
 dGRd/tk9YV+7fZdtK9qkwzlXHPVcPDKpL3paDXfRjlFlj593g2HOLqonQGj356vOz9rVVNaIw54
 lDloWuH9fXAkMwNpxfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index 44a521c3a610..60576f885acd 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2836,7 +2836,7 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe_priv = afe->platform_priv;
 	afe->dev = &pdev->dev;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
-- 
2.53.0


