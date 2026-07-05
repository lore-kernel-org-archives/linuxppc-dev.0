Return-Path: <linuxppc-dev+bounces-23577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75342C43602
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtdCG5pK5z2ypm;
	Mon, 06 Jul 2026 05:41:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280474;
	cv=none; b=Rhj/i+ZmaKSyuycL18bow8sQFLj/QBaKIF2PYdmnDvM4pNUPsU0PRdEUNI2l8Io1iDGWqpcyMifQLM34GzfoEa0JI/bwbz1i54WxkzXmQF71agYRt5fLUiB+4XjcTSOgpVh6hdBuhQrApg33h5KhrXE5DqepUdgBGOzIGLeZYjFpcRkQ3vhUVnKKl5hMsQGRt4Ihs/PyfkrDP79ILfMluCntTBLZomf/Id8Uo3rjf6Ugr9mfvYKumAD+Hmiqhd2NIhQsGiEpdZWsy8I628Eswl0kdd2c10vAp8BI7wuEp+Y3cZOrkDQOaQrWJ9/zXlg1DzBWgHjK1KZXHWEh+xgZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280474; c=relaxed/relaxed;
	bh=SRfBxbqW9WovwhSYimxYWcInLCKkOQsnOkiyjjR+6kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzcagVkT4rktXQmuxHi3F/Z4rB34ObrtAkNuWgayMduuFsA6ckuEtU3f4iY1jQE84YlCtz2rH446AqoyotmTMCpl0gPkU/LfW7o9LFEyzSRMBr3eJVK8RKjqgtNY49BJnfQJCn8h30DbE02TqBh9+AUtVrW+Lw7mF88MjYlsk0ro2vhUtvDmYqSg/9ARIIJ1NkgXByEiL9KwSKesoQM+VKoLxAMkTfiQpxoJQz3vcPndwLiByYw8ybfIToDFITHWx1UqVhv0imjGuFbx9GYPpoVzhJ4Hh/S4RkbLjTP+e2KepOkk2HV1noWHiOPgoaMuGIBpYz0TgxjoWsVmo/vzFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ct1DBvNs; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H/y/NNvX; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ct1DBvNs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H/y/NNvX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdCG0p2Nz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:41:13 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hhukp2343277
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Jul 2026 19:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SRfBxbqW9Wo
	vwhSYimxYWcInLCKkOQsnOkiyjjR+6kI=; b=Ct1DBvNsXtjXHhkOELxVhlpg6H2
	368Ld+75DkSj9KAbDdr+dccgJj5ELmVwXoWTwLRHuHRoMLG38NZA0i/dYf4N1Wwc
	GWDVGhaX3gkzJ/KUCjenkhf61SCvn7auxPGY1ifqGqoeJGMpHLM7TwdqAnd1zKxe
	XDmUTqO6867KN13WAC/hp1ycv49MufxZfENMTnh8m78LYIQT7d23L1S4XHIN449b
	smnhxYrxjaGQqsh6wd2AOVf/dnd9Fv/6+cSQqRdhbmEolxNJN1SJpi8Ey2Pa0lIw
	zunl7f6VOFaCAF/wwQuLKChNn1SjxkzDZMRnVULom/ITViFNtbylQf31vYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3ba2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 19:41:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so3254666a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280472; x=1783885272; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRfBxbqW9WovwhSYimxYWcInLCKkOQsnOkiyjjR+6kI=;
        b=H/y/NNvXcPPAlhXcXkr74z1dAm2oenSOCdJuNWzh1TwpL/swx7QrPkjpnYOmP2NJmt
         Wz+kYfh/cu1zbMJNJcKAzpsDOYfZA/gWdwgfm2TBUrqRYetCNmUDbFjEn+WN4JJJMQOl
         n9ubNXaGn+S92xA9CGIYfeNA/jjYV5QjZI3LctTGeymajWTHo5eBVcOi5fuMzpub1Gka
         cj0f13pRINnrGI1CDsfX5rAQQp9JFyhUqCKT208i7IjwpE42FMbaOoUIeyBxHRmGuK9z
         4YNdqeEkPGkHmfc2dY5uoIXinZXt5yYFvQCKW5uVU4GdaYGtD8X7Svk8POJTx2t9ZZco
         cymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280472; x=1783885272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SRfBxbqW9WovwhSYimxYWcInLCKkOQsnOkiyjjR+6kI=;
        b=FjeZhXqxpOr7CVAvgN6m4mAXNi6hIHXi49DiZDxCTsLvAqkMwL+zl/vjguEZMBL/S/
         gCgITWMYlUb8uyDvT9+5J8WIkTzGx0yxMfow0lKuWk76d5EYfITx47Xp/vwoqrLYYaM5
         +eOLsXodFS2ZUBw0PwxCYvueFRnjD8evlkBhnwxb0OZG8zTnCHojlY31kJLnHg3mF/PB
         YnilFpS9jcYzNgGCLLBlQ/aqV2XtszSbCmX1D+/ZUGTffZ/TJbF7wx9Gv5MOfM5nJNoX
         cGWPJAPkfBnePVcBL+gLMhDVdSONFdpZgaQ/Zmd4uZdF/nFQ9x5ZmREvY5a+I8lw5cjM
         GOAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSdYnwWKJ55lrNwR3qbo7W6QwBVBIE6UJ9Jbw872apqY8JpgOZvJUdDI/hRTPViZ4SJ4SvRr0ZRp6938s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWrbAAhMRQMWOaPv7WnRqQYjtxMiJZ+JP/YzLHyDqrgVCKMv7L
	3L/piYi/ilKhKO9dgoAo71VkixS+d2WAZTbjUMe3q5GpZstlFplA39eX7WhUg3E05EySQAuiXpK
	TLd3gWXO9TVqUNWk9ijjjzCq5bV3zAIRrgVYGNbWOQXF0cAKZnE2gvEWIWIkf2p/vLRCz
X-Gm-Gg: AfdE7cmSqM250dQ5IBcB3GBNMQ1WDNgVAZb//b/4auA6xj9sYWXWr0HKHmGIDWjIlRJ
	lgdsbI3qs9Xip9fAt2NcqZMkrHmU/krTA84Si/54KzYf7osrMxFhvQFTzmET2DZ5rt8XDpPs8cA
	OC9DKjCawsljItWtpQajnbuuBFffb5ZKxb645ZYrtIdWlVKnA6Ut2TLzwqegz2kM6GkZucn3fDT
	6cKavIW7klpifk2Ev/CT/NQm1DPpPZwXt0hQ9oVrSZQjAcLw0XJL+Szo3OqgzTbIzv67MKfKT1K
	ytFWUCuALd6E6OvH6EujJS68ILGtjWEGJlOEUUP9NvEQ9dovAn6eKEMs/dFA94FDycfC9ny0xkC
	Kzb3gASPZ2Ejlq6XeRL6AVcxNAaeYj2GHry2bZw==
X-Received: by 2002:a05:6a21:6f14:b0:3b4:8cc7:c6fa with SMTP id adf61e73a8af0-3c03e189935mr7605443637.10.1783280471648;
        Sun, 05 Jul 2026 12:41:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f14:b0:3b4:8cc7:c6fa with SMTP id adf61e73a8af0-3c03e189935mr7605425637.10.1783280471121;
        Sun, 05 Jul 2026 12:41:11 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:10 -0700 (PDT)
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
Subject: [PATCH 39/42] ASoC: SOF: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:15 +0530
Message-ID: <20260705194019.2565498-7-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX13SkYRcKbBmP
 ZqvZARD1CHh5wUNC9Y/L3agK/uUFhKAh+JqWONGKKs6zPcCen9MtqSWdUDBbHd6aZ65yoC8socM
 ymJ/4YVwKkR8hI42tl5GF/Yq4XLyAm4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX+Fe00YgR8O3Z
 4SPiD9clLf0JNYO9QbGjnVTmF7GfzGzp9XIykrF0zli9WdADoub6qNJou9w/QL2/7AAofCuKfHo
 eBzPIePxr0TkLi7afSIvVlijiNBdWVtAdAuJ5qKpPtbd8palwXJeiCuueHORJQ25e+L/DMk2nMK
 GKLp1v66yf3gKxfjBCOZxMT1pPMf6MOJ9YDXQLGQ+a+SDUreGHXHlVNlbxJ25bK0hkgk9etFArw
 8acXtH6bxrjcyI8Wt21+i1yxGopiz+/A1FXWKw4RVVWHDCNaKVhP3WqHNhlaDlnsNBB8tdRCQQG
 sWNORNcxvHsW0KroAjdTSA34kzrnrauG0KEoi+XPpDPuodjSDGVNjlIed3xHeIrNEE/eb/OKojv
 McrUWpqfOR9PSnYIxnhoxNzPQh0zlSUGV8RJAru+pwnN1OdBfs4lz3Rn9Pa34Wd8mcgD+0zcoHh
 jJ9Yb0WsNix0cCfkhNQ==
X-Proofpoint-GUID: G9MOWusHYTxEPkQo1KyNSCtQxQjAUwDA
X-Proofpoint-ORIG-GUID: G9MOWusHYTxEPkQo1KyNSCtQxQjAUwDA
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4ab358 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 4d6e9300a9c0..e4b6b6c18e02 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
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


