Return-Path: <linuxppc-dev+bounces-23580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE7CC44500
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtdCf0pxSz2yrm;
	Mon, 06 Jul 2026 05:41:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280494;
	cv=none; b=aaQQz3HEnwmWpxAsbH7cONtni3lAjXa+EmenRaVIjWFBO+qbzXFYRi7Rqmhs6HvzA2fh5lK1QrZ+ARrXRqaercIVU3eOnyHmMSpDb5vVPKqbOxLAy7+9a40gnVG9QONq269ZmjZZlcUibJcdrSfQX5dJ3gKbBvp8G4WUdZBWLiCLmv+bcH2ptQXzuvQDHI2nj7UUnknA/TQf05KBAIaLEmprX3NEQQEHIotSjZqeVFmpJ8AQGr9XAZqbof2ikxaoqpPWCYtFd6Gdi1CaYu0kGWK1g9N8iwjpoIcC9pta7dXpLTaK5SLchtx/3Gir4D2B10iUpmXvT/fgiD9qOL6IGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280494; c=relaxed/relaxed;
	bh=keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hi8Net0MqbH7gVyjBYAlTtrG2JDHHKF+gd6ZzTg4Nxpyh3ZT+E4W/ceU5f6X2ejgzzpjik6D2rAv1MmHEnfX7q3sE2whsH87HCRuXEpzc5IHj+g37OXqjxDOkaOmtUGvW4AX2KDGFjX1trs/WwfhcxRejuNCe5WT2QWscMClZiKdDoY3Q01317gj7c5qBA41TUyWoxXZniPOcWcBG6UTbccDG1gGaQIZsfBKja4dlykWZ1ryeL42KXS0VJGq52Q3v4wTekQ68SHRE0qFrWQ8JNryqJNWXY9g1tba32S2mbGFeTlzVntt/n+xNtwunu54fNGs5MB1X2FNT180FLHOQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LEH8gBGq; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U6MY2Rns; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LEH8gBGq;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U6MY2Rns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdCd2v5Zz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:41:33 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HhbsI2189477
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Jul 2026 19:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=; b=LEH8gBGqre98aZ5S
	R+gXIdM13wWVBKCaHBPzQIy3YO16XtaM2Yeu1rWWcKE8Ahh7phGi5PdgSe6faHYh
	NZ6WuJayU3dm2BjN9bw+VBE+ZM79Gb5/VMy0wrJmVG9PAL4oi/vWr8CCwZvut6LG
	bgx8kYmZdMLIw+hO7G1imKVsWOK46Uaj/pGQFCjPL0CK5llMYjmxUaWFjupRdJAp
	DojiJvRtFxtp1fbC0Y51KdHDxd4iTgLcudGv/2y9joceF7NK21EqPuFhp9vBp/DG
	Mr1h6o1uwl/xqAgXXnlbwqyx/z4fTFXUP1+eeaAFH0RCQyOQiLqKrFrdvXcDdzoo
	l70Dvg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf835a4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 19:41:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so3281138a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280491; x=1783885291; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=;
        b=U6MY2RnsSNOoahVfEW7+i4+gtHThFND5EZeGoHX22Juk5Kdv9GYHEYftBiel/Ez5dP
         htcEE//e1UGpG651fuTDppvJ08iHJOgrxVzejYj09TnLBdhiReEKXBxRYb8NlpSBQAop
         48ahMgE/jWi2uV0g6+tXqELuX0VlaAaCVErWt2AQF5hGvIXgED9BpOaB23tgdHHf7kZI
         gyTPhTcJRInfCosAd3gfu11OwWTBBh+4PWUF0gJrOVZ7Mngn9c38xYfMPyp4QsMOCYv3
         Ll85q7+yEju6AOBlxaDVqRPyHy3GygEqtTw8C1Uqn22zDuNoL/BJsKbHsy39JeMLg8eP
         9e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280491; x=1783885291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=;
        b=CQj1q7t4ZT5TacPiLUQsaDawHb1tfwdJ/KmZxrLGYO5zUnjIGA/yr/IZ4GcdEcqNA6
         wba4rFdwg2AYPruZKPyzs/DTTrHGJqKpzRrO20hZmyeugtejDSeCbWLEP8IcFPD4ZRqe
         lsVHiIUL/G/cyprkm1aTLCnam9v0OKCORNZRFUyoTpnpScbjxUmhRwV+csYGF0kZ0WmK
         GlQyk6OyVoJEH6ODn+bmFPYw5nCEatk6nrfINGFHLRSlu7XHfNb46CzDyhHMMGlO7Roy
         cC4Xcp/aIZoyQZtKaUxykW8lwEA/OcDD3USjawCiTBU8h1LY1js8vt7SaM1EOUHhAvMA
         vKQw==
X-Forwarded-Encrypted: i=1; AHgh+RqwNup4YQyVJsk54GXXjzUG7UnFvA6qmcbt0oaqsn5SfXk1A+SIhGndi6DcyYNUm0sCSJRYRjyqzyhWFO4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyxkUVEN+kOEDMcwM0TMKoxOaxijc0HheIeGFbiYenP9/Jxeyh5
	HOtVplCWDOet1vo6pdUpJ2gmU3v6jKe8MZGGGMxB1WE1xDOFtbm+rpXaxfRxQWgsOU8DIwmVk4a
	Qg2N5uYWjlCJIS7JUWAcs5ESzAG+Oyup8InwpLVAgnD2o1rvGG+aFs28wagvOMjJ0saYJ
X-Gm-Gg: AfdE7cnQWAPuVDDAZqpXL0CNAI9cYDr2z0V1npcnhPYDlBWfNkt3GXP3jNQl+YNsH5X
	1qtESD4YAqw6LBGhfnDYl7QgP3U/1rOpR3zUMLol3rOq/s6JgaDxExqIDuyK3dN3rqUGqrO4gdk
	be0bDzPIIgjvlBi5Btt9sosOJYv6Vr+uPkKVE8RQbLatDE9KT04G0qtX+8IZhuvvgttmG5xB5Hy
	6JGT0XP0BAQ3vEJC3ZJ12HRzESgG5l/lWW76KcL9wLVp43irFP1Ujgux8K+IfqgjNrwhK8aPo6P
	nCv6nD7BrX1w3KSN2hla86pxG8CBA9QxvW4mLJCB079nZTV63qKENGnSuB+McVVeltlGoNL0JIr
	IGrvqcSE04wFLe6IGY0npbe9dvWtbmeqgF+Z5AA==
X-Received: by 2002:a05:6a21:4cc6:b0:3bf:a0e5:99a5 with SMTP id adf61e73a8af0-3c03e509089mr7554479637.47.1783280490845;
        Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc6:b0:3bf:a0e5:99a5 with SMTP id adf61e73a8af0-3c03e509089mr7554455637.47.1783280490326;
        Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
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
Subject: [PATCH 42/42] ASoC: sprd: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:18 +0530
Message-ID: <20260705194019.2565498-10-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: oMaByULk5EEqL5uH52CBF1Ck1kECpkCQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX9oxrmZAEukZ1
 P/QhETjU122BXmDiLDXRhlUOY4QkQ8+tbYiHOuURDf61kvjSGuyAXz477wE2WOomZQkbc5KrON/
 2+yKoGNbh/gW/tOvY02bEoT0H2Zh7qo=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4ab36b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=99hAX-h0IAisWkWT3OgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: oMaByULk5EEqL5uH52CBF1Ck1kECpkCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX+p7l0mdHlrmT
 yWUwFj80kQIw0JMTSIxtrLosUNaIm+kA7nxK7jVPduPwW95pXNzR+NQQ4Uj+5mGp2vJ1Y0Zz34L
 FrRxq7kEda6uyltFGZxfpyPAKfggvXmXb/Y/ezcHmLPazZGf2igf6pfuLaFHGV7JT3idOXoS4BR
 8KEbS/JPVsa2q4EDL4Z6Iv5K0vYJHTBSh/A4a9OSYjcBzeOpk/GD1oZxMZ6m+jJKUhPJbg1Pjjo
 mm3FZIAbR3fp7BYXkZSCcl4zYqslwzBIEHna54OeY1/mWLp1SCLy1K7ADcE9tt9it+6vekdyfJM
 WTZyX6Ljk713C1EgRqn+YEPouIrNseLpuvrnvu7rq04gZZaad1Q3Scik9kTbAnsCiJLJCUHPseB
 5unjrwU6NG6Z/zYGaHQ2mz1Q9NKWpyPIl2qSRaya93VWXpRO2Sn0SaksDzRbD7LAm/7oOvykpN1
 A8ytRiD50l3pZVS0uVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup — the driver has no remove function. Also drop the
now-unused local variable np.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/sprd/sprd-pcm-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index cbf5bf82d96e..220f55d475af 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -459,10 +459,9 @@ static const struct snd_soc_component_driver sprd_soc_component = {
 
 static int sprd_soc_platform_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	ret = devm_of_reserved_mem_device_init(&pdev->dev);
 	if (ret)
 		dev_warn(&pdev->dev,
 			 "no reserved DMA memory for audio platform device\n");
-- 
2.53.0


