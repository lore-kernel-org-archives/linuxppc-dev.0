Return-Path: <linuxppc-dev+bounces-18173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F83105F7A8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 13:44:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXQh45sHgz3cJk;
	Sat, 14 Mar 2026 00:44:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773409460;
	cv=none; b=W+KvsXIJyQBl4FHMpyAAV/zMbw6T5x9QoncC1OyRVLAT7DSfwON5JN+eEODcnaWGMuVa6iouRn2EB3u4Jdyd1t4a2sHk758cLwuWluq+fW6WyQJkg7utYBKnIWu0I5KNN1s1KnxC/h5ZbX1+37nXe+LToq9/3YZE8Og5znfjGXb9pFeRegKJwqZXzQwRVzUCGzwUxebxff91JzgVDOfHMSVAibXMulNWuvLryR4P3BVE4zlMX7IE15n+/26fbpTQgvBwfSpWa5eem3MvkP1AVF1/4eke/9l05loauLP+BccjaN62P1xLYgQaLEQocnLIheMGTZf1GGTlhtrf9dDaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773409460; c=relaxed/relaxed;
	bh=QoZHIkugLvxBFz6S6an3vh8XxLW2VljccTx776RcMfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5vi/MQRv2+TTFYPVf7Oinu/bjWYcUW5EWEzl9AMeBLbZgxjrt+4lzT43TujeYkWrMArcl9dHbxh4uO9iw3w4zj7P7CRg1b01A2e5zIyuLSe5wpfJUiT29ZXtLt0WHBzMgfYMWT+UA36Frjb44+bMvKGh3D1tgMRXWkXQNEGZ+ebX/2Ll9LBs5wKdKW6BP7JJOn9CbzAI9Pw8ZO1s0qA0CQ4hCFe93F0vihkyyvTysadDmz51ZRgNUdRi39hcaE+EeN5HQfjmWOXGpFTqiSqrIfv+3bHTQe2V+QXwPc7dY3k4N+EaMNb1dsI8Abn+Y2OFqqPZoqYz0o8EfqohXURCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KtbSMsLt; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J/YpR2hJ; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KtbSMsLt;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J/YpR2hJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXQh32QCvz3cDg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 00:44:17 +1100 (AEDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7JM04238405
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 13:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QoZHIkugLvxBFz6S6an3vh8XxLW2VljccTx776RcMfw=; b=KtbSMsLtNsll432M
	ZTzKQXe8T/DK/n7b9XjI6u2X8hEFxS6+vToHFGAIETMkOYmiyrVQx1Ron0HTNUGw
	L/7hqLNFcZtO+7ieK6wWqj/GrMcUMTkirbNDQOXKEyEzX++Y07x36vS4BckJkiBw
	i0e+TKFjJYkL6k4y12GD35M2kL8ToRgaS6v3aDis+sQW046oTfw6VRUKYvC55XyU
	GavC+gmfdoZZxfCSN9TNUX7z0/IKdGFuTV1BuxzhmfyaKB9OzNJ/1nmkV5iIg9BW
	H8cIWU+Z3DaF7xCU6hevUNHgxDD88Y9uGNl2srLPZ4lN68ffEs3Qj3IQtVVXyVOS
	oZVnQA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cve3d9aw1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 13:44:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7ea0bb20so1203276185a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773409454; x=1774014254; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoZHIkugLvxBFz6S6an3vh8XxLW2VljccTx776RcMfw=;
        b=J/YpR2hJJIpORwDKpXo8PE7UiV0Mn02ZsPg/N2nSiuQcAK1iTxz94t96EQ92Biqeqh
         rktlSWr2hq3VEKlLMJete3V8YE5cY4OccLgPWpkXsVEojn0W8r4v0qQNFo3z9qrcqTJX
         6YSB5/La2WUdUFn+PhmD2r5B/QnNxHerZTguXg2iuDtC9XB4opss+JZZ2hokmpWSb5Sz
         xWanji37chSGrScSXwOpxrhYf2IxfgRmmvniSTH+IGsPn1hgt0wAQo6Q6MjN8OzAU9TJ
         UJ4C8KZJUY+PALVABmT/KUSCIHF4Fr8kWh/+vyJJz7A7V/BIhg8YKbaRo3aiXEkm7tw8
         gFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409454; x=1774014254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoZHIkugLvxBFz6S6an3vh8XxLW2VljccTx776RcMfw=;
        b=st1X5k6/gKzyL5doxUXN2T0Pu1q7TtkPKLp/TEVF+stNC5gyQefTvk7xgWRjGgargK
         75vIlcofsyLUx6EFbJIqEWQNE0mpD0Zk0Bpi1aJlLmfsMKIA9pV9NLG6ZSlhNnsyAR0R
         TsTrnFfRJyvVaoqPItguJRNqksuk928FXIAcvwWE53kTKUyR+xfAAumXZIOIE5sCAsF7
         0IzGheRP87chM0jxb8T2HDhmyRvzbWuO7y3PGXlnSHmnvgA3vZcloqcV4g8ZZdx85tRP
         G1pFeVDCJqgQZo9JetRxgp0ekl/tMFkcdEKld4BwcAYuyvo3IbfNT/Hzg6ph4BfJGnMV
         igUA==
X-Forwarded-Encrypted: i=1; AJvYcCWTk1aK85vFmQBGIc8G+D4qJDBUP1NFDwjFJIF+lwAEY/9wpzbdHMLOQan7rmYleHCWs3Eyl6WqgQlAC6k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTrHrbG8Fkpf1c62UJ2wcj9af9UnLxJ6CKZuyG55XxRA7W++1k
	EdTTwZLkjSM0Aa6Tx0SJqS7ceCj40iTCbAQfh42Ut5ePYK8g/BSAg8UlJdLB9tG1uWzkUHU544D
	Vxjfa55bClbpvAHwOJzt9lZHo48dC3Ix2igUJBQl3e5Xf9QXH8C1pixIwkjACfYNJqz6T
X-Gm-Gg: ATEYQzzUmIHHmk+5qYjwURqhZtDiPNxRZ+aajOvlQXUI6brWwblMPCXDo7hWAK0JJSI
	hm92939mxaReJRRY7G/cbnkvy8rJJAVsQM7yeqJrCy0H1bpL9Z7A8yGWyROyyX32e2vAd6KLu1T
	btlqmAi5pKHOs9OXpRDcAVQ19NO9bwRibTKE/qLRPcrlD0/sCBK2b4WyG9qM9vwHj5QB4QIfFlc
	21N/2cekm+bt3K3JBAzrUPXxoGO48hbGrMN2S4nDWaIuLalShwGMFwQ7rQ+XUGMWIB4SCk228fh
	FcSmMfuve6wtM1Fgbiqb+U0ok7Ql61ecSSqv3evMQpXIe3Qlm/bKJ4WtxrYBLqoC2ar2j/y7p2l
	WQ9aBTOiS8Lv8kBbw8+2G32tLnnuvc2PMxzPJd1AWEfd6D1NDwVw=
X-Received: by 2002:a05:620a:4623:b0:8cd:8fb7:7aed with SMTP id af79cd13be357-8cdb5b5fb55mr457718285a.49.1773409453942;
        Fri, 13 Mar 2026 06:44:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:8cd:8fb7:7aed with SMTP id af79cd13be357-8cdb5b5fb55mr457712985a.49.1773409453455;
        Fri, 13 Mar 2026 06:44:13 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:f055:6536:e7d6:661c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b4dasm17696873f8f.18.2026.03.13.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:44:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 00/14] gpio: remove uneeded Kconfig dependencies on OF_GPIO
Date: Fri, 13 Mar 2026 14:43:53 +0100
Message-ID: <177340937994.51547.9424773605486301589.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tnjvzbUJFkTjUqgBoijkzEqcAEAE5ikb
X-Authority-Analysis: v=2.4 cv=FLwWBuos c=1 sm=1 tr=0 ts=69b414ae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5BVL746LnNak5i1nQvMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwOSBTYWx0ZWRfXxkZhtC8UdzSI
 URfhjaMVvNRTwFY7OF0slKzo70uQrItm09qDCEHOiT3HtYOaZE9b0ag9gBfqrfVWk2MQQyIlgbf
 hVCn7E4aU+s072q0olbt6N44Qenvs18/1VYH2gMbMQb44/jMGY7ppBGMKVpVPGXhO7lAzPwOqRI
 6apoIIoMo4cBtGN8gFQ0XtNWtcoUJIuz2BStUdNT0C8OWcQ5ZmvWszfanRtMQithRjOoeCOtTYa
 pFgJ91vhOfOnOTvsxfMxnJ9G2OViQe5+2+72UEh2cNSgf88M1E+k/VkVGyhOQxU6lR3Ash8KbsV
 +GytVzIUa1ZFQh878yDdeEOVexMCItzqQ9E9bv3yv/AbdfiA5tjnF5rVGdvMRQ+8Yh/I88oU8Jx
 o7ZyTJ2OnESu8M5EefeRoXXgAuMCYNuV0CVTqDvepOtuK5Uu+Cnah55FhR30F7QPQFnRbtVd1g6
 +XJMIpkksQs9bW+6jVA==
X-Proofpoint-GUID: tnjvzbUJFkTjUqgBoijkzEqcAEAE5ikb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130109


On Wed, 04 Mar 2026 10:02:21 +0100, Bartosz Golaszewski wrote:
> NOTE: Each patch in this series can be picked up independently into
> maintainer trees.
> 
> CONFIG_OF_GPIO is a switch that enables the compilation of the gpiolib-of
> module. The module itself handles GPIO lookup via the OF-node tree and
> is automatically enabled on all OF systems. It does not export any
> public symbols to drivers. There is no reason for them to select or
> depend on it in Kconfig.
> 
> [...]

I'm picking up the ones that were acked and will send a smaller series
addressing the issue pointed out by Guenter.

[02/14] arc: axs10x: drop unneeded dependency on OF_GPIO
        https://git.kernel.org/brgl/c/d2cd20f7c2a4e4bf4fca844c01e925b112c5a2c5
[03/14] powerpc: drop unneeded dependency on OF_GPIO
        https://git.kernel.org/brgl/c/dd1cdfb20e44e295512080dea508771b6a1f1c0a
[05/14] regulator: drop unneeded dependencies on OF_GPIO
        https://git.kernel.org/brgl/c/bf017304fce10933f18fafe140bf749fb9672058

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

