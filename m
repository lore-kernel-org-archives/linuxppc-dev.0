Return-Path: <linuxppc-dev+bounces-21294-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32889CD5BAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:38:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhcJ3MVwz2yRF;
	Thu, 21 May 2026 18:37:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352656;
	cv=none; b=kxw2RBKJGFAFl/LFkOT5mfKAimlu2EgAgNSQsoIhlxet2FOdV6739Tske03GX+xGqBYQBxASsivZCOPW0j++z/6JyvCGkNqssCJwxjuI2fmEJsZxRvawml2+i47NYhVQCBZNdgBo9R1YDXTS932A3kVHWmTdN+au6I3sNpT13IphxtjQt7sNb28U7cXnWZME/duh1xKYSlLyDxh7Minsos9yFo4GnntcEKi329jlgWgODd7TxTrVyxfGGe4I/j43/RQYyPAmsELh4Y5hwHpqEIx2x6ftzSzWDGkJ0TaErKIjkBzUrfefjf2QrIIjp4OLuGGXq7Nl1iaMhLz74rZ59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352656; c=relaxed/relaxed;
	bh=GS7X0xr9hoUTms20bP858Mqd60XRacxhnK7wjblq9wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jczn7JfmVPmv4mxoZfUfrIE5M9B/tamBGVW0qQkWWAOObFTqhl2LObQDGi/QWzksDbq3ACsUKwjQruGKgEqzQthBOrDdoVVGXhpw5/zz8zKeGyxMStkTFr3KG8TvSbPMi7WmujYtVnyTzGZmrItgMkC1ItusjzRjS4KgX88JOO8U23wANX39i1FPs3Ut4mskM2t2RaYN6CXbmnOdutCSvz8JOaktyUHsRVjWZjsVrNqr1VRo+wFuWoaL9NAfWKRGzdBGXf6fSP6Z0Xk8R/fLYK0uBn7STT+qvDjZImARI1lnwGJJIz+DZWTesAKEhX/l4B9yw92sycs+LMVvLkm1CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RpJqCKOQ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMDVzGaN; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RpJqCKOQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMDVzGaN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhcH4wJPz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:35 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6Fams3680295
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GS7X0xr9hoUTms20bP858Mqd60XRacxhnK7wjblq9wQ=; b=RpJqCKOQq9IjMBeI
	NaUmV8pVneazD/ahQBrqvfJzEXvEdnfk8sRv5HiBPsutGW3ZWL1eakO5x5DWui/v
	nDTFgHBIYNg1ZOVvxjY/t09M8Z8r2UjxxOA7sjm6bgVjc+pfmITt6G4UsKYy//mp
	lCf05vqPVt/Emmfa3MMfL+XgpjD3OcXU2irG3Lp+Qedki4jY0DXfvMUanelej4o2
	D6YVAnumiEwn+Jfi8/gQT4auodm2JP4r9kFQ4Wgl0iA9Q2aJXgolbKGmPB819LgP
	15yOzw+iJgu1B6SIhaEjisDGvhNaxO7AznpJmlWjOK1tlp6YkaJtyWHuhYZ7BgSE
	57ENaA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j40xh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d890580e1so127507561cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352653; x=1779957453; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GS7X0xr9hoUTms20bP858Mqd60XRacxhnK7wjblq9wQ=;
        b=TMDVzGaNHfFBcNVch+eK0ddSFi9glQQbhcjq0mXI42t8BJJEe9YyfoQMLxFLgvIpy1
         /qzScUBNNE25xyAbMTEIRczHwIdDSbosX+6Ff5d2t5UCo/dC+DzLLFQ8FECeyAbYGkcv
         2VgBi8Y9Fq2DFLeKV7nwfeK++9xulFcEO2+EuTgitDRKi+IFTSY8uq9AciGLu8TjchX3
         0Tlk3R63Mum71CHMeFSO6KjAT0a2zKDORpCs7CSVI3oUDOmOBZaQAYwHZk9qZGOwJ4Tu
         fvb/TwLcwcg39l5QTkXOpp+g0wrYxjSnOiFTkuu1BkfYvVEu31hW/Q0awuJqE1ZbnzP7
         HaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352653; x=1779957453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GS7X0xr9hoUTms20bP858Mqd60XRacxhnK7wjblq9wQ=;
        b=VNPyc2uThmRNLboHW0aiIa7L8hNpbRTcJCUjbR8sK+IdQXmA8BXCbmLol+JICBVYNN
         CaeMQPQD5hYAYsqtX809YjncqizaYWnxLgov+MEkXbiJ2m4WEiamenNhKNjGs2u9Uans
         CkXoRqgD1L/X14M9XUu7EGrPEefyEpAuIdVeC+z2CDq99EVPMjzTkTEBclEjdk5j6cO0
         zwkCfVtIFPohEu7MzFpka7qyrP4s+f+m5GZBBd0kP6Xf9NSw0TshqBAwwpQJvbTH0O1S
         t3Sg+L4zD6k3diuk/HgOvmbz0dQiQZ2lghOxGiVJipC8/WijcICqZuGcQhJeuyENdlC5
         xuSw==
X-Forwarded-Encrypted: i=1; AFNElJ9XMTrbMCYS++J2PwA4TJ+6/HQMezIxJfG1c92CNDWt2eRpdURtNkBcPPKA51Vy6xa7QOSoTphPiY3+bDM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhS/xRJioL71xpE1RmJeWjEqo42VahRrHblWhdqGoAcvNUs/CE
	wIsa40WSv3l5dANRsOEMsQVwuh4MyAwxgDl/eVZkPYx8GP5xCzse19hWqSoR/vWpcBYzRcihCU9
	104H262via99JpbpGfitMPRoy3nxHLlg1BAPO5kBD/8sWpqnfvtW10oy+aKDhRDIoyIhf
X-Gm-Gg: Acq92OG1lWyZ0TgJGIKC2FLOFa1VP6rJVQNr4bAmrpCLP+u21wTCETo3nmugestE23D
	kJTps1RgYaA9b2mtH9bc9GrKiEDcjwD/qQFTULqBwyXZpvu2pCLg6AqgZqNo/+ra/1zvHWhD8RW
	OOzWYe/vKJhWC70zo/XDRHRXCYsW9xQVSJF5U3XZ5HuSHLWwwbewbwpNRM4iKxsrhNqf3gSRUGw
	caHWN18u/iqhs26TeiqDXl35T/M7nv3SnOmrWW2HvehWfxGMGoZgzAmuOQBCbQdphC+N0Z350Rs
	FdKB1FhrSvockSxOk+yBpBRwlW9PewcH5Hno11O6sEy8N8b0C7DFbKShTkC2Fw+3tO8QInpZ+en
	xapQSyTLyl5vOgfi83Pi0BQkPCuAjNtZDjFOd7lDuhP3CwKtumPo=
X-Received: by 2002:a05:622a:1f0f:b0:50d:8903:ae6e with SMTP id d75a77b69052e-516c541246emr26414031cf.5.1779352652671;
        Thu, 21 May 2026 01:37:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1f0f:b0:50d:8903:ae6e with SMTP id d75a77b69052e-516c541246emr26412971cf.5.1779352651284;
        Thu, 21 May 2026 01:37:31 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:31 +0200
Subject: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
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
Message-Id: <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CP8cW3hVyUyBk6KqxcfnwpcDkHgTyD0WEhhuAHWbRgw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQmR59ng9ZNR5OHp6pe9/iBiLI17IMmOUyhJ
 8EAIIWC2ruJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EJgAKCRAFnS7L/zaE
 w7UhEACvBFXwsGANI1Ib/eMS7OLOYiNJGoi0+qsSwHeOOk3USSuovHrB6FXSsC4LAGC+GAA5NWb
 aCNZGLDNdaeLPQjG4T601JVMjYXjB9oekRjFpJj3nwrDY/nE0scU2xXlcxl5l6VDKfdKWzZuQJh
 GGuAPfluMMoOs4pPXOw9rAa/Vi1i1LnUS1QpoCeZdRYuWKo678shNQFWgEh9NsMVaHSpp6nONzq
 4DClQ1B3iJiZBQecmFxAyFAgjvfR5PCYSICb7XdS55GHrYkSMvwI93sLAurc1363iPl8OO2DIHy
 XGjow1moTi/Mxu8z5AbQ2YMuxVz7EgumVVA9+1IgK5jrXg8uaQc4c3URjsHh22NNTOUusK80ECM
 VxfuM2ll3rkpLGR8oBfjX8F/6tfH9OHdWYeIITbC1oAXnmf6xeGpsvSFe8EhHNmvSWLaIzEgO0/
 txbBXyDsW5QErzNf7RVV9nI+XRK9Vvori7LTikzq8JHQOAluFRjM3uuzcMZBx12p4Xh0uuEvN/V
 VE1un3bx3mhk2gtkHann2FK2nFlYoaljscYVs0D2diCC9ran/CLdiBYQ3HQkzN3st8vLX+KkH8R
 ERIe2jcuu8qftX0Pj5PDLKrW0xg8HbbxQlW0J3jMT1NWs9nDmkZ+gm65hiSPfOqUQOZY7aED7My
 7hqzdDwbnU6qmLw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0ec44d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=nFtAjRmdzOROD1nQPfEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: DcgCM40pYj425wAY61IHzCgiJ6KceGDa
X-Proofpoint-ORIG-GUID: DcgCM40pYj425wAY61IHzCgiJ6KceGDa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX5x2XJof9yvtl
 hiqtvD8/iePrdxuHB4Lux5aMr2lVVT6a9/Gjntuu7mzuDzMxWwWQIvJTcTzE6euRUNm7vN2j3zU
 QFEnTwcoqb3iMKbc79kynXTyKkltCIjUJRavlvwzGvEClS+b6d5llHzAn8KOEduNDlYa8PBAIX+
 QKVKBfMCsm7D+Czaq/tsU6hP11qrBVRzKKaNXLLK4xK2HwkLdTWm/d/qf1XmrbS/Xj+/04AdPCi
 3BHcrJefgKlz6mkigkNMB4llktZBjjeDbZBA4w4MFED9qs/pKBOR45Dj9owBFHxmPJkaklVbIle
 J+kHwjZRR4y2o31XprMrI0aKDdLegxJ/Lf1TGzvHuRK5WFGYqWq170t5mGmIWQerzEqFJtaHoVq
 M+lqWPskh92/C2srL/M4i/ox7iaPRTJeO/XfjCz4z0d5R5AlSTYfbuq63HW01/Kc9Hvq3O7ugkG
 2G30gnsPQrhZVYXWE4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083

Provide a platform-specific variant of device_set_of_node_from_dev(). In
addition to bumping the reference count of the OF node being assigned,
it also assigns the fwnode of the platform device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 16 ++++++++++++++++
 include/linux/platform_device.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 449914e657c9c58cbf030208e60583dde728d6c0..b14f707f077bcc535fff9484d1ec904616d0a1d1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -730,6 +730,22 @@ void platform_device_set_fwnode(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
 
+/**
+ * platform_device_set_of_node_from_dev - reuse OF node of another device
+ * @pdev: platform device to set the node for
+ * @dev2: device whose OF node to reuse
+ *
+ * Reuses the OF node of another device in this platform device while
+ * internally keeping track of reference counting.
+ */
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2)
+{
+	device_set_of_node_from_dev(&pdev->dev, dev2);
+	pdev->dev.fwnode = of_fwnode_handle(pdev->dev.of_node);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node_from_dev);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index a915a6f2da71284b60a6595dfeb013ca0dba542e..e5ca686f23998a3182a9573a7d1e84c6a6fcdafb 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -268,6 +268,8 @@ void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode);
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


