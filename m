Return-Path: <linuxppc-dev+bounces-21288-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B65CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:37:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhbw63Lbz2xGY;
	Thu, 21 May 2026 18:37:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352636;
	cv=none; b=Mm6NU42GXBJ+ckHanykWbdkRTk0lMjIi8FNbujLe3fcxk0bDYbbbyfrTwyFnDoTQXY2PCBHHyUGShsLyvcYqLoKqURI/GUlu5x0s5E+EowlXqg1HyRxSc9ulbgxtPcd1ALbxvZQrFijmvbdw3emXaE1MHqn1nd0BgFj/bKsJoU3+Smy0wQg1Dq6/nb0kLsAAo/A/HKsDt3FdFvHlergxZhzxhNaUTkWo0ihVUIVmWqorKClGREGpxaudPcDkN0qRTALmMakR100q01eShABkCPlhlSvGeJG9D6n9/ZNmOtCBNcOFtE4+IL7VGF0M3z0GqTK1nwHkHsmAWWcc8+faJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352636; c=relaxed/relaxed;
	bh=Wfw1udEagj7cAx0swsN1pe6k67tQ0Df7+z2byi0rBCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZwiezicar6mt0YWV4s6VhXKj/SGKxtt6D5cYnRto8+wCL7hTwswgb7jcsPnIBCvCxCXxIfk+Cnr38HSmQjEwLUvw9Hw2CCYfhqN7j687vdkTyJhivd0najhSmYnDK540JUURrZI9u6hI2SdFghhe6EsBI976QIpM+6pXpwm5Z5RnAlhhKIezBpZkAi5bDH6ECFjlr9ErA9iWBnygq3V1lMaaqA6/qMWmCuTSjXSDa4SrOWUX8+h5/Pcv7js9zZFedCpbz6bJMzdkp5wP9LgZF/CWY2BNsvBWS/zCXl4mf4F4/Yx8XDF7ev08QI2PVw3VHhp4Emfo3NV6tRJv88MJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D6wMyh9G; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PKPWuHwJ; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D6wMyh9G;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PKPWuHwJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhbw0xGnz3brP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:15 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L78mV4119131
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wfw1udEagj7cAx0swsN1pe6k67tQ0Df7+z2byi0rBCs=; b=D6wMyh9GV2fJQ0Zx
	f4KBiA4rm8ahVwft1szX4Pu9Nvj+9vf727ddYumyeLD0bzMfrAE0KZ6oHgtfqiSc
	R/Z06LkiMRARLiTkVZikUVyqsKOmr9dYD61LxYNfvUzMQJF4/TSfkh+8Anc6UMkV
	HLqDvBgreugoJt7iZIgoc+bYNdvsOfM7F0O7wQra+ECBQo6ps2B/n9dILSJaBJqW
	p9EhZ5DCZ3JyhQ3ALihI8Wq49SQxDUpWP43KWy0dtQQSSDgN6tWae6KgXXih3U31
	TgBtZjBrQOT4elKE4UaqnfddJYpqylEtpJQzRFXRHCI4S6eoz2u+MlPmc7GZCH+M
	ehUt7w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c16q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516cdd89225so285981cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352633; x=1779957433; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wfw1udEagj7cAx0swsN1pe6k67tQ0Df7+z2byi0rBCs=;
        b=PKPWuHwJeGTwBqNDrVc8pPZoSp3f9yRX39gStQV7RzVxMdVTr8hsut0Ep87ookueK7
         xBEi5CRVNPHy7tPFFZ9Uj6CHKu0+063ftFiZlRNt1sd7ODls+2EgdmnwQJ3ftD4q4QnL
         vhdYt7A7txnVHcPyqF9awXtV+rkOV2EBYBU2nDU3u/Z4GoWVtOGeYgkJdiaxkD4e4Hv3
         UcejxwMjJxcfAfTi6x70eVzVsL93B3PL/7394YDu0SwOKcfkI0QHtHY3z1rBQ9hHdGxf
         2TbwADyIMk007l+THsy24UF8yLkus3f6BUr106FTgmHJ6hTUO0ItPIpZbqFrpFZ4Pkg0
         uVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352633; x=1779957433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wfw1udEagj7cAx0swsN1pe6k67tQ0Df7+z2byi0rBCs=;
        b=RGxN/DsZcCUEdJ2fXcvI9TEYtz39cdpv7yC7UuKdR5XvHzpZcmgW0D2AUnvDyIGuks
         IRRe1MiGQd2jJkQwdq/2K4sYSlO6fuD9nC91lu8Rk3cBA2ElW5Zx6/78KUMPWySW2URX
         /s0AvRVaM3fMC2TWKDs4AWo7yumJTgGuFQeqsF1O6ift2H5c+XKn0x/toaKKV2/Trc07
         SzUHerylj9ctvhxUXw8uDAXZx1on/LKBQitVLt06sjPfP9p0F5J5DwvKFylLP3N41trb
         5bq0lyBmN0z4nvlPmb3avjnuVDWgQYqYvtZqr9deJg1vV5aPmL2JgjV1748KTESvUnKC
         5zjA==
X-Forwarded-Encrypted: i=1; AFNElJ+SNcWeLjYF9WJ2Ys12IFE8SsuHVcHJfA4Hiv63nyOpsamA8gjNuab4VjTdaTj5a0mwfhI1dsXx14HowIw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwIHP2y3sQFOIEu+HAzkXrc+QIS6R5Hj5lKjJCtA9RhE7Er07g+
	25xUtFsyONqHXiF4eq0kthN0eKSwf4UIVOnFDcYljnVwclPQ0oSDnzMDt6uzf1oxDLT/VEJSEfb
	vc2ix7wEHZrcgV0jQghQwF4xU6cHWnuRFzYDmPiRUTcEzk8SSnx4bje0b4kWo9jjreb1B
X-Gm-Gg: Acq92OG2CVB9vB1synBOPr+B2UQEvva+u/GontttLCw4fPzc3i4XnVm/ni114VGxpQC
	wxbu7cm7RVkgwwCBXsiePCfLYFPz9DuTEVUNX/SZIhtOfxoD1sDP4AZ9dH/bSDMtUDx7aRkSJqc
	RzQe3OkUJOz+a8RQw3TY1aoUDQ5D2p+gvURWKpgiwxpWA7LrFz9chKBLmi8oMyqrwIO4nZrmhby
	gTH2T7F+smlsmnOjpOmB2vL5LjcbA4SAAz3+PPvN2LJVgyRRelmOXzOLHmsgI05mSWxyQIF2sJ1
	PhwAMhUagpC17+n3M8jw72J34oJC0iOIFSYtJvHro0KdUwSpI4pigs52hYTjSbOu3jXMcKK/c0x
	s6T1pgcg5VgIIrLhzVUnz/nGPVEW9Tu0XzbFkzgQ5ko+X+sUPTxE=
X-Received: by 2002:a05:622a:342:b0:50f:c65f:a4fc with SMTP id d75a77b69052e-516c544afb5mr24558481cf.10.1779352633339;
        Thu, 21 May 2026 01:37:13 -0700 (PDT)
X-Received: by 2002:a05:622a:342:b0:50f:c65f:a4fc with SMTP id d75a77b69052e-516c544afb5mr24558211cf.10.1779352632852;
        Thu, 21 May 2026 01:37:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:25 +0200
Subject: [PATCH 02/23] net: mv643xx: fix OF node refcount
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
Message-Id: <20260521-pdev-fwnode-ref-v1-2-88c324a1b8d2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Vq0LogXtRhRUgP5LIHiwXCljDYw8Y78nK8IIxKqwPs0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQeyipWeVwe1gZ+CShmDvyxkCw/2ac+wigtc
 yDfWrx9B7OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EHgAKCRAFnS7L/zaE
 wyD4D/96Sc4XMe6BqcGdeU5XMrq255mM+2Q9i1CnFxUGJYNsHRGALjwq4agMpWWID3Xz0IFWadP
 f9cYo4zSx5YrZJ3NC8aBSnDFEgSpaoPv3vd9dR2i8safu4aQx7wG82O3RVcGqAtL3shTrfG+ziV
 24wzbVP4UKjc4kcw0m4sVpF7kpzz7f5uypJ40k4tC22VMdLsN48F2nNloAOonMA1CRtVwaegwPS
 +LUzSr8fUVE+Cxwfhm9M9QMbPPQV+Xz+9D2lIV7JibUmMSyMlUkkC6W1WGY+EE+y164ZvEPQUQ8
 pTOt0/CtDCCs881XvieaOneXcOv3CZKeJfbv1pyGp4onPZPod1ja8YYi3oKqQoKx/gipqSIa+KZ
 Q/NIA268QzWCrxR8+M+BFyghvPzKE3QrjxrAPc3rcoL21lH4E0UT10PFSpkt6UoABVUDQdVTK8R
 RrccYHir46M0LNRd0CQvLxeHCuup/uV62AYyq1es4haCqR+Sd8PD0hE4YjipqixdOX1d7vlbeSE
 rgk90YNfpnJQ3q+VJCtHjTCKFzSuzfumxnfLZNPUSMSvUO20eJ4PT3Lo1yq4VTiixwQqm6Ev6wg
 dUzkMbEHmGi4j5dxcRVozkGO2hBgM1870hwtdEda5YSqgm33yqUq5FDx8pa0vrhMYxaI4X/Iwcc
 +Nh8Ur4nvc/+Ing==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: z4NgE5Q920Co4viu4FtbO5VwzqpMsoLK
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec43a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2glh-Q7MoEu8omcI7JcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX+CrF4PlcyMrG
 qTE/2y54/h6vSqr8NeS6kHb3AeB8SgDrsZLp1sG5TNUVeI8j+Yf7kuPLS+tKWsV7JvWvXhx1+fe
 P/6Go6mlYqxowH+KtXzy02kFn1z25lZx2BhiVTp/HgwJE3nLNWlfPmlHJveqEerrdf8MZvvFeYO
 uPKzhAC6xZeNBNoHzq8LjifxOiKRlzkh+/oR1I744CclDEunYyOQ2vBkBLTi53XDs3RZgNqg2vu
 90BG8oc2eGUBYJITjF5jvhC/1cB0bOqcqJ7FMBGNaRODcDBI7iAfxj9RsGwVuxsfR0w8DNJ0Los
 5WasinDK9XKtCQOt4t78FbUtMBNcvFKWO0yJXFYwm/RcnWPTLSDcYnz4VU8lDoPrfg9Cmmz253i
 33vO5Bl+Mrj4JQcwV4PwfwPX8nGEVrPW3OLNHCKBcmNpa6rP+8YJOEVRh8VS5M5kfdG7MVNnc+S
 e8beDUYrMEVIVlsSr9w==
X-Proofpoint-GUID: z4NgE5Q920Co4viu4FtbO5VwzqpMsoLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f9055b3d6fb102ebc695dce9c6c8321889a78dfa..1881583be5ce2e972fceb14c2b8348280c49ad1d 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = pnp;
+	ppdev->dev.of_node = of_node_get(pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3


