Return-Path: <linuxppc-dev+bounces-23055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280B0C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:21:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpglF3sdsz2yFc;
	Mon, 29 Jun 2026 19:21:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782724905;
	cv=none; b=k9T0IZS88BQOFk19DE63HKwWHvLrMhjikUY1pnyLbNWgjMqSq6HcqCj4pE8Y5H1pYxzU7YY5dg4VFTb+7QQD3T1KJAAm5v/aqY/Sd4MT+0V58mQ9Are+4J32i7abTfxAaTbMAPAYSYdbPjpv7su/sbqrCr0nNZh+ty0FqhMwyDbnI+7AWKqe3Qx9e66am7qnh2XlNfQBPbTDCswRZUO6Aaxp0XkeQQ7i5JXIpdX5rHz7F2WqcnCDVGXZL4UDvmCunWziYbY2nL46UzBSCaKh4T0mqSR7T58cn53hyJMYTg75X5UyM36MJxW42DSm9H09sVFMxLYd9bZpx552hoNnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782724905; c=relaxed/relaxed;
	bh=NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LM0hU1Q5owsZ15yyledVCqmht3r/VRDpZ9pgXHLallCzqEIOsyshcy03yUuvYTTWkL4beeSMltTSwv7dnx0yNw4vDnqEBk9xafveFxbcRBvRb6VLTqNsgQ6OlNSpMHqbD/VZ7HqmooKyn6bUPxVEIC8io5reOtLYOsJGSNaYp0iJD0QJyjCyIaS3N4AdMBC15S+LzDvXpKDjfDcYKFdw9YcH+GJZLazYg9P2Mb3hvkUMS7U/Tl8FT6vUvBCw/EM+GlBga59mX/Htkz9QD42AJqfbH0ETUPSy8X4Kv3bQthX+JLkMfilUj4TzSAp3lJK7b4vOBlAK1d4oTXGp3ZANDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jwWIPkqU; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vt7eQBps; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jwWIPkqU;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vt7eQBps;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 521 seconds by postgrey-1.37 at boromir; Mon, 29 Jun 2026 19:21:44 AEST
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpglD3gJqz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:21:43 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7DqBR2188823
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=; b=jwWIPkqUfbIHUw4h
	qxXbw5MdhJ7tU5kAgvYT1xcyQD+B+MVZHIunycRmvl0cEsDfMzPPmmnNY48Ad3xm
	ZGBZEropJlIWYP5tX45jciHeyvSG9KJhhJdCEzNBBRNprWleIidgiUf2qq8ff8dM
	kvhFKuGq3RtjOnh643ig1kYJscniNaflHGpGwVuYOmU3POpqQ/6Tt9D9I0x/rHPE
	0CsoOG4YAVao7+vBDic3flhV9alXhJDUWz42OITy2PJgaGwlbFEXuC64Z7AFr701
	XmoIgFjrtmInhE93fUYcHj8QA6C6b4fqRcgqtRc1TCgMdtpu+5eZns7NlOENWCZQ
	MzmyZA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trg6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92d1cae5740so139251685a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724416; x=1783329216; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=;
        b=Vt7eQBps8X+7yE3OpouJQkou6zTjDmOysknD2Xn+EmZx9Zu3oP531bC29EHdPb3HkJ
         mI9aWvayi+VaxjnSAlsC8/gxnGR+yD5MgZcKRtirbyBJGVtJBAIqC0n7/mKeqvtWousZ
         cI/DRotAgbcZ73NlncnJEZ0CRn/Ndntu4VoojunnmRb/r/L8pNQMrn6t1OluU6S2Z6n6
         8AuKEbcg1svNC181sK7zX/bTKj2ztahQKOfBhKMyrwSnXMt4Z+PlGwLFvdhG9fn91LvR
         uIbNd7pu4mVP2sWScwPP0EUyb6/D6jYOfUXVLrZzBHyVJVzSeffpO2CgteVcGSbkZf7/
         QEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724416; x=1783329216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=;
        b=P0ggDglAoem0CHt4yL3oqtWRz6c+aAoTxtwQvLtQ4mJxB+YLgdsFaWQqaNTA7Bf9Dw
         mP5OwkVJ9T5HLXdbjcEWzjq97JpUflVjJlJuu0+mc/CoqTUQizKhwtEks080zm9cc2aB
         jj7xFvrWKEIkn9Si3poPYyEH8DyDlbKnRg23uzjetHsP23XwQ5Y7SRS1vq8jKhBzh/Mc
         fd0uGpfcOsHTbhj2o4nSSsF71j0+i5+/RYS0iTqpxhvTT81kbdhkuOv7ten09lcX43Mz
         LLD1GFKuMOGGTtuwzrJoSPFm2Q1AtZ/Rg8Sd3FuRRTY6tKjMeMxr4vXCvpHiBLUOySXQ
         k3Dw==
X-Forwarded-Encrypted: i=1; AFNElJ8AnVParlqfTgokvwJuWN3G5mfyUx/8czVx4DWK7qssxyI2OKcIimII1pG0s3L8HZ/DwcZY+Sc8g0CYYN4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxlpsTAr6WNtlAYYK4/Ti1Eteou91cju0HA8QhBeCYXJ0tIeRn/
	rxCGtLa0Lprna9OS9lSQxUtPK5VLipXgux/i40CiH1YoB+xEs2OtthdoOgqQf2ke5zDeilLhrcW
	jST4vhiOongCINO2ldyPzItuMOHnW9RdIpRHiZkXQjSrL/ZxXVgo6hLaJP93gFzp8dzDB
X-Gm-Gg: AfdE7ckvUuQgikei0skEYUFqMhuO+AaaYQPnUflDu3C4XUb4F4xTIHa6P0nmNLoV2Q5
	6SKkJ5PJL8GvLNSMiAe0J/l2KolAkya6SJbKU3HCKzgId7H6hYodULIS6XIgzDf1w924RTxFqXZ
	sWeQHo9il6AQxL5wx52sCAjj4ZfEPgfMaMswwb/4NwwMJHS3wzok+gRZ4Ro7IGawBCap79Mkpkz
	UxfpTc0WLfrbOMAK0uboU/qUJVC2mNPKEO3SkvXcQOKnjzUPN9uAYQ/ZPPAzCWJn2lHAjnZpzon
	4+H0lsC96/n0GyPQUYWAdZ99xYPG5ETt7ecyYvVRucCqu/Vramdv4vbLg1pWCzocvT7cbtp9Xsn
	QbjO6XWF+FoyXIUQ2b1v4+TeUzDFxQn6uJK/cJhuc
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id af79cd13be357-92e51ee8ae6mr323651385a.30.1782724415966;
        Mon, 29 Jun 2026 02:13:35 -0700 (PDT)
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id af79cd13be357-92e51ee8ae6mr323643585a.30.1782724415437;
        Mon, 29 Jun 2026 02:13:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:35 +0200
Subject: [PATCH v2 12/19] slimbus: qcom-ngd-ctrl: use
 platform_device_set_of_node()
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
Message-Id: <20260629-pdev-fwnode-ref-v2-12-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LAw6TP+//tnDWpTcxlgUU+E8OF1oyUbi54CbVTPa5rk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcRvVGm0XjHzeekMWgCSmedmQdOuB32YFAod
 HQ6XNyVL0OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EQAKCRAFnS7L/zaE
 wxVHEACqOwp3yO7AptcceX8k/naLnlKxs+wmgitoHHSTRNa8FE8HkJ7lYPPwAwc8lovQLX9q05Q
 6hcHOe4n4CZQbTxN15/qEZ87njRex4lLYPQZ0AuWZzlrx6rr4WQIRBarM875qSv95m5BL7AR3Du
 ENPTAKbTTX+n+C25UiY+ayBKtWsSGo+kpsjN3X3Z05TthGI8MH1cQqBtpCXwLDDDxk5ZJE+28wk
 Nxr04r/bKCTmFTKcAOLeZwe+n7OBQJiULX5aNGFND2NKf6gYXCLrX9uSvrOFKGgahmbtYUFZVrS
 aMQrMchr3DV0mRgFYqENcBrCgGeMZt6rZXDuQ2/lDEmpFrJ3JHsNtYzXygqcuHVQ31BjA2JQ+DH
 nrcD2BYjuGhGKUV7Wzayp9U1n/q6PJkAxKuVsOJx/jGmJeJsjfbNnyBY2f6dS7cDV583Hw7Z/tx
 6SzHZBOe8r5iHFsTvsP/CvjXUetP8B08c9s0WkwKNh5vrqHQt9jegjzDY6LZM8GsreGmq/SMB3e
 eED8xB8DcdpxLmveQkgTC7u5QBiF4N77Q3Uk9jZ9zLfJLSJF9y0iwK1d98Kp26FrAvtSsukjHkf
 /3kIw6Q5xTb/Yzc7/yv3Ccc1iUgJCOfnZ0rWZVZ+0ggxeXJ0kK2eg4UsUY7GtJTRNPzxT/PdftH
 otsBKzVctyCmwZQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX1b35/CQ2OnHt
 2uFFhgZEEyBy1rDOsrq7I61j3UljtR01DynmcRGpCtPxkZdX4515ayW1UnTjMIOL/JwWjMH4xee
 i6XVBjQCdX/+SjrWdlLs9vb+VpoDplzv8vs1/1r0L3Li4uE6GfjQBSXiQHia+CStw+h4C7loFLa
 gM9z6QZQC8K+axoSx8xRzKpfre1l0/pvCmJbf2cuOeNrQaV0yiIcEUQIlcqzk5ZsmNXrxfkHfBk
 2lr6aUG221E3YiAEvotaO2NPvjHXghPdL8WrdFFAplOc9CeeJ0l9kOFc0IsFf4IYlluAyb2ooCM
 wD+nloHVwtbAJqyhFnjo9yxVQvGhzmvL+y1nW/rwytFGHY7QeRgxGP4sExPt8xvtpdWlXqU1Al9
 IdP/LXqXyYFWDij1jtdV4aGHQ2HPiqzyw3OEW7tkjmEWR2WBd/Cg+GBAy8dDDsrmb2nZu2D2Qhj
 iIzimhteVOKvLfp0iSA==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a423740 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=gD7B2NV2fXQl33RD-VUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX2TsQthM7VHCk
 tjTp8q1JIg2FoFug+UfPTV+PlhWeVrIv0xx2LCL35+BV3fOSKgn9vuPW8uTiX1D1vzdED82gX8S
 BAtuDohXTpg2PFb8CRRucFwpMSBtxSc=
X-Proofpoint-ORIG-GUID: 4haUgrRvQNBd0vMOCi07Xc1gEcTLHa4K
X-Proofpoint-GUID: 4haUgrRvQNBd0vMOCi07Xc1gEcTLHa4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 3071e46d03beaaae2321e858c564b512c22e820e..6e89415712ce1a7a7781af6bd0eaf0d6879da52b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1539,7 +1539,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3


