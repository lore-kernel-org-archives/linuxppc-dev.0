Return-Path: <linuxppc-dev+bounces-23057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AA2C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:22:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpglX3BDfz2yZZ;
	Mon, 29 Jun 2026 19:22:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782724920;
	cv=none; b=fhNDXpnbfLQAmIycRRqhp+bfcGONWjl94Hy4eEzc5ZqHEj3wIRzj6ToQ5IRL1rjo/ZezIFRQEMZcUd3cIKH58+cfMmRIhmWjoxngqkKgy8KuIQb4qABaU868re5eUAHc2mnVf1pROHq2hPG6OyCDTMhInk/3WCkSY+Sr2XXhLz0Bt6O8725WnuGeMsgauBiA3wDOVcsL6u2KqnLhkB5LHyKFpak/M/eq58Q9rpcwA1PJ3HEtoHPg7HS5orF8e3aQVAFxmpwFHrmq9QmMZExqyqE8dCJd14HrpG4HHPJ3eflps9kWHOQl6w+WRibfILmRepVdV9YP6TX3vQpNRGB3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782724920; c=relaxed/relaxed;
	bh=p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVZr/JNx+ThQvu1y4iMebDnacXAlVw3DS8Y/3vqRIQ8jtmQ21sV22YdAnnbjKbD4gf57ZwR0WyoSt/eMe1j4VbrGRkgjJyHICSji1IdHtpbLbQTJqVz77KPRAieDFU2FiMC1zul35R4fuFPCMZ/99mJCApuT2jAwIR/wxohA8DjFmGwQhbsh6EJzdMUcphWLKrcFTCBj5WvcWsnl04OAtQi9A0C9QG1F3za4ksaf4aWjlkYmv5Ojm/TMNlegJRiYBKTQOyvTuaFawlxoiEoi5m3Y/FCQjRAjMdV1bUxcijOeghlgKMdcGA1pWpswPaJ+6+hRPGYi8jJL2W80eLOfIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jXRgvZnj; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VfwXxiY/; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jXRgvZnj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VfwXxiY/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpglW2m17z2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:21:59 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7DqBa2188823
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=; b=jXRgvZnjw5GcHWfE
	EdU7pqnfu1aWmT1Qn83DNUkYLXZwtGxZctz5Pk3eozOWBd2IJevGjeFy9d+S2RDI
	b3b72IXqCckD20juun7ZhHEfyVD5nJtyyHcSQOMo30hCVGZxHgHELkthlpER1Vz6
	0Eb5Qv15bCrjQT7N9QhM13gtQQB9/4AUtNto0lbiDQOJcoHuuSzbNTdq8XEOHe/G
	c2tEUTwdqe10fVkez/t5upUYrbnnxsM4T48AAdSfvA9y+NZG3EJ0istb+YJ+knp/
	bBGVlhKOwCxw3JF+ZskQRCKUV8AxFXwVEJSQu3IZqDJMPo9bQBuN3xDFCfueJBvB
	aptFDQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trga0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92b380149c4so247797785a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724438; x=1783329238; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=;
        b=VfwXxiY/GtDPZTHwfR+BNPv4GJdcIeFrx/BkJjRIA8sqUm+uoMumZ6uQZvH76sZIi6
         dMFm6M6fWNv7qFD0Eky28sh0CCZzU1Pr9bOWvv5FjR43V4y2GH80S77ze52xEdzHfO5w
         uY7z/KOUsKGk/lqP3GIXGnUe5Ade/jd8YKaNlflf8SLxvM02OUK3ixbTfBVMwZu33r+n
         IsQD+1eqOWPYlyGsdhTKyAz39dP30NXGN9c0rRA5pbvDpMlxWe3xTN+ODjeSCpYPfKcp
         6hB6IiGf5sIs72oQVJdKt15EaiFdfJOVXpxLmsu+auCJW1xZyTDAECfQaopaTpVzdIec
         MwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724438; x=1783329238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=;
        b=nZASPJJbRgEPDL1EHFNnvn9SMeLg49Lr0ebNtmhAwvhnVBYb3my5eIQjiZx283GHmE
         ucfbiE1bcp0nESAqMgbHjuYCgS8Y8MVzM+zqx6G1jryOsgnowCy+J+W8aXgQ/pIVV6nl
         bZllZDnTuM3K7XpxBvQDFqRxORgip/K10BcHqOy21uMdDuts+IU++RWPvpMDKKDZZpat
         ELTZoNgWSs3j9lbkVAFjDUKuKn6cUNo8QhxB3YhsHYG4HAv3uzJSYwO6L6zWcKfFy4jx
         iXJqSry/nvXXj4OVVodGs/azg1zIbk6RuhauKJfpSYKQ6L3tj1AbAfBx+uKEezXvyF+x
         ppfw==
X-Forwarded-Encrypted: i=1; AFNElJ8i7+Ln2C51R0kdyZJ1wLh7nZkVIcgkPWpZclEcIzoDe2LbU9w4d5dnw4UfYk7PYsD14U75/KYpg1R9veI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzc3EYprbxIbpTQ7gpCYc9Uw0C3/CD9XezNUC2tv86nbWjwgmot
	KxWByQkXxtqns7zx4hWK+oJe0XNshOQa8cCXDWx924CgNegUiuyj9XdGQvy7phzDgEhgO69P6Gv
	mUvCTIJwYjNqhILEIKrtSLarNpbh3eZnV0OUnSG4QGG6fP1ztAwVL8D9T1yJjyTwi8tsT
X-Gm-Gg: AfdE7ckHEz6aHrV951dGSxmopnjwmsRa8kRzrGDfVOxPjpnjRTYZjRgySvdPTwH8s0L
	D4GzQh4rgvznIOiD/E4LSF9wVxP6kQoigb43hBD+ax2/DtWkdAw759WTk61URul5cdWd4eABGj8
	63E/Jh91ygnVITTrtQ52vAkygwWDd84pIejcF1+XhF6fg2gLWuSaJZ9Y2iNOayMbTu3ix7Z8Ehq
	Ex47xRCRb5e6nL10U8LldJQLwRQ1QQ2FWf+S+/IOP6s9DVootvocHqY/hGNwgJJa8btoTC/o283
	h3t5dMG2pHZVVBAwZW7xKWA22fE1Lj7BLTkyVYM5nS4uYHyVDC8surQXpL+dcRqkL8RBIAH/IBw
	bPvRxxVr4vUGndZbatzpxhPr66DXnZiD80ISHTZvf
X-Received: by 2002:a05:620a:6499:b0:915:9273:9239 with SMTP id af79cd13be357-92b3b6eeaf7mr1315073385a.13.1782724437206;
        Mon, 29 Jun 2026 02:13:57 -0700 (PDT)
X-Received: by 2002:a05:620a:6499:b0:915:9273:9239 with SMTP id af79cd13be357-92b3b6eeaf7mr1315070685a.13.1782724436678;
        Mon, 29 Jun 2026 02:13:56 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:55 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:42 +0200
Subject: [PATCH v2 19/19] driver core: platform: count references to all
 kinds of firmware nodes
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VEyUxYLMr0/kZUc3hQzqiXRE39K4YPDPrI9dGBJJGzo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcV2ZO/mjVvS7fscrieifMk6bWNF2AN6BkT5
 4dxIfGu2nWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3FQAKCRAFnS7L/zaE
 w2YpEACbPZSAaWOfh+OuT1Zwlgz+BsRRZZy6cDhBoTiUeYqKdcPmZxipz2TsAMuIlfYPKLh5abm
 46zQkAaG1vtOnsxm9+NTs1QAQ6xkDAoZzhIZMDHqyOPOoG8Gr+0mG5poyrmzhIJ2gZetsvDhSUg
 9BI4HNO2Ya2KjeYG+sFBfGfeJBAYbg81BgstPscXYSUTtblGBlW3R8dYSpD0xb5mS8spl+VhdDC
 3Eyi1jA28rzmPeRic1GeilgXo2ivpXQ1UGz0YeY2OdeZ5bq39rMU95OrW8kxMNV7LqUcxiPdxrK
 +fmmam/m3oLoXNKVFHp0LsKRGjrxZAtCV1oUDuNsQJqoEgaj695Gpkmr0wyk53BDm+QyBQTKJ5a
 azgRvH9HAuBxKvtCV+7ZH9BC/fDFaMPQ1RHKQWg5aIVDBh6TePB9H7+5enD4z+jF2LEogBad/L2
 GCZHbciAEbPm7xr2qYxHLMIgDFckOP8wAQjTjPZzrk8O6H/L1KbIMZEro0kRYsSBj/ofkZho6tT
 2RFWYf+OCFS23k9vsQNHX6T08a2EQEIL7w6cyBp1iSio1pHhuMvlvnT1iKOkYXSPxDK1FPJmjOi
 NZ2QX1sApJPEihNT9LGA6nRo6KyHttwNCAeYh/bhtKB4gUErD3iL6L6N2RotJIEEZbbdzq5OQma
 y6IZyLYWBBndyZg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX70BTg0acZwLX
 nYlwcILZRBPuVDChgmd8RqaJQDU41YmDbetkL5bRwM/2HMsK4JWZJ6iHD6neCGOHF7RVIZLog8I
 ZNH9sCA6AxAF7XnO3S5S8Jd0lC9RqUZwZzNvsEjxs6ofIvvDFd9fKOjmH40PsfHXjdghNagZarl
 YOE4SG2fwQ6XvcDDSYWwoGp/ibEoLQzrYqjWdpQXR5+4uXdiaVAo9X5e7CwvR64QbNg/LFxuaXQ
 O/bVXGk0GqSIuOIasPMcoqqsUl39IwG8pMoqkLHrOq1BBADgpiY9zFN2aWtSR7A9dgMe6IpmKrc
 wcItqAvN8PJZqm40iw5DsF9/6WNUamtdGTQxfEW84arvp7Z/gmg+L7fJqCpF1hG7t139SPIxWWp
 2Qs201IscsMn/DcXHXOd3jQb7aFSa8E7drn0xgU/9dDRuJ8UoreawqcM5DVgr/cYchjl9Sdjyz3
 EQgEvYHOw2g12Ofw2hA==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a423756 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=2sGp0kyKjRk1obZUzdUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX9FoSHWNkgQbT
 cC8OSTHUoU5Iu8aoqhe3KHOQrVBroyTo2dGZiV8QaFeZ9mnW5PmlHzzSPQExm/Qo0FUv4azhhsQ
 88O4Vcxsy4ew2rqEq9vzI7LEo3PeXzs=
X-Proofpoint-ORIG-GUID: vug_yMUNLf-TVZPukp5uTx0LpAr-N1f-
X-Proofpoint-GUID: vug_yMUNLf-TVZPukp5uTx0LpAr-N1f-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

When using platform_device_register_full(), we currently only increase
the reference count of the OF node associated with a platform device. We
symmetrically decrease it in platform_device_release(). With all users in
tree now converted to using provided platform device helpers for
assigning OF and firmware nodes, we can now switch to counting references
of all kinds of firmware nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f24a5f406746b53ca9eaab9472f6dd1345e04ad6..bb5f5bddd047d4ec6f238e36dfe4f4ea36b92a76 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -599,7 +599,7 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
-	of_node_put(pa->pdev.dev.of_node);
+	fwnode_handle_put(pa->pdev.dev.fwnode);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
@@ -705,9 +705,7 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np)
 {
-	of_node_put(pdev->dev.of_node);
-	pdev->dev.of_node = of_node_get(np);
-	pdev->dev.fwnode = of_fwnode_handle(np);
+	platform_device_set_fwnode(pdev, of_fwnode_handle(np));
 }
 EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 
@@ -723,10 +721,9 @@ EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		platform_device_set_of_node(pdev, to_of_node(fwnode));
-	else
-		pdev->dev.fwnode = fwnode;
+	fwnode_handle_put(pdev->dev.fwnode);
+	pdev->dev.fwnode = fwnode_handle_get(fwnode);
+	pdev->dev.of_node = to_of_node(fwnode);
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
 
@@ -921,8 +918,8 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 		return ERR_PTR(-ENOMEM);
 
 	pdev->dev.parent = pdevinfo->parent;
-	pdev->dev.fwnode = pdevinfo->fwnode;
-	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
+	pdev->dev.fwnode = fwnode_handle_get(pdevinfo->fwnode);
+	pdev->dev.of_node = to_of_node(pdev->dev.fwnode);
 	dev_assign_of_node_reused(&pdev->dev, pdevinfo->of_node_reused);
 
 	if (pdevinfo->dma_mask) {

-- 
2.47.3


