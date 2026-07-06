Return-Path: <linuxppc-dev+bounces-23610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37ECC44503
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3wY108fz3bsT;
	Mon, 06 Jul 2026 22:45:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341901;
	cv=none; b=LM7uehQaYXFwB8EpU1AvgRLmpcFlcQm6NPbjyXHASE3m/5/PVt2D/n3Yy8Vi6p+1PugMeV9zMwtRNta/1NK+Gy6hiE/rFlj0MqF6svg0SErUaQTTNbC0rmzKkIbmwDYD0K3VDbOdI3Rk4SxsiZgEOPffRTTVk6aNg6HJx7iaAXmgVfo8zxLOcMTj2FqsgObWUyQtovUzHTVC+MVU1K1cSACLMQdnuYXp2/TDRa6R8EwYN3WeC6oUiWuL0sRPdv7j+SEqCsubIRBwiPQP58bHhVlGsBjUtZnu8A7OMTXmICDQKplyv4c7OwjVz9msWdt8TOn8bEWEmvU7nyRELXp0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341901; c=relaxed/relaxed;
	bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYP03GhGW9u/IdPklv5DmzB9SffuOKEJlAsHvTdm8iKiNWMn/1UEnQYqDJ5TvfGslVB9gg95nLDn8ekQK8r6pSx4Wecn5srgUeUAACZl/BfJMysQmuVuKno52FdZbiVgYPSU+dBjwohbA/njgsdeGCCdxUGZR8ZnXPxwMesl1uG9QMPamZgyhbaY4Nq76ch1S6caDb3ZcWTelvGrv2WNomnhGZRCVPUasXjqfUkAAmp1P1VFox9kocaThXoNUskh/UpIYVLHrtJoGmWqcO7U9f7ytdhOPQ9qZZDH9aehdlsY57JN9+wlZmdy/VZdEVND10i6Vuv+bxoFJFY1e8FU/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHERcCvS; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QPmL9uXS; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHERcCvS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QPmL9uXS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3wX207hz3bby
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:00 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxUHN361592
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=; b=jHERcCvSBjEX85+G
	wv+iLnRT6hHpxDdY0dS7R0g8NO+qYXJwcgWGOEQO7ZGvZOxy0Q7dy0Hba2un1PBx
	YmlYOgwY9VTQJpR7MOI1xAGU9FfZOlA+exUr6cSSSKOpYVYiMtNM2Oi81hDyX1lf
	rKokYFp+tnknPpil7j22bPQBqfzVNGQF+MkNqwFAcSDBWFQJvlTIgsN/6YOkjNfB
	2cVS3wfKyk97kCwPoRu+KpyRomaPWnLWCcagvpdzWONQt1gYmYfru2mmiQe7+FzH
	cpGKefaudU3KsN9qiar8tJGKvN6TLHIebow4FloHMH9JoqRDGUV9WltOTCKn9V5d
	TJqHog==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h512ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:44:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f113592bf3so58126716d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341896; x=1783946696; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
        b=QPmL9uXS6nBveR63A0Sdhx70SAIy4SicrLolRL8N8MfxUekNxDTky37LRNPmbiqiem
         fw3ns492KFPbPXRFfHy83r7Kp6w2JXcOLldnDUwl44o9lfZ5B2n36lBXMWy3LLwOwNK4
         YRSSljwF3JNfSYzVRRqRb7aJzdBqSDJ8K9/mBWFqq0ivbd0RwwVYwVH3qwjYeuZ0rJKZ
         Y15YPVZn5RJ29tYgTFJk0Lnl4YRtk4zchK0WxLRZR5FX18pboifGH8QZVwsjYqd09b0a
         xt1atG6Zw9rqwUJRzWH8b+jXKtYPtDRx/KGqJ0ZTN3Lg6pN6C2QL3r7J8Wf7n9V0wGQQ
         HELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341896; x=1783946696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
        b=RvNrfYwOoPcLYWSd2GNePwR/ur4t93WsGYfKUBhxQBMTauFsz97BOSSovUOfXqJBW2
         rLRSQrvHhHyEd74+QA+dRAaQF7Ubb6+1h2DcwfFw/IU5GHeav5sDGJwS+4muauWL5BoK
         CvOohktRy0U62GsJ4T1JO+QbIfOHHIVzatGmCWdqk3UI841CbcVK4Id7Xtgp15jBXMkJ
         8eNy3hggn3W/DbV13IuLDkmWkQ+D12kQZPgux7WMn07iI0WTkwVMhlW5dwF/vCcQKrxl
         LPs5M2BJY/67GqlLIqEzkWEQZG2UdvLO5RsTbgbCYYe9ofe1cj8s+WIFTXflEfA0H6IS
         Ee6A==
X-Forwarded-Encrypted: i=1; AHgh+RqYWUAKBmYQSRMTMKvmHRdJCPFt0wpUY1O6CnnEvSNrmnA+ZGuEoSY9BDLFsD0en6MIGTVoQ4IbFIXZjfo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yywtrt6JM4VM4F9FplqzhLrqIUucwkAWQDYX8liykVERQK14uux
	jk+Wy4aJ+sQRvMGI8gK49e2tnazTHPMB/YHRPu2+KPb93CtCIHftRwkcxwhVLTItSZ9nEdCZKTw
	0mgnM+D1g+Bz6PYXymW+mIPrrdrgab55zQtMQlp5HA8guGeQROTjeo174sBEO+XVU0yZT9dGHMP
	Tp
X-Gm-Gg: AfdE7cl3M06Dd1PM196wSzD+rXcc1yLwaTfTucneBXBer4Ont2bOorj877BhHX5eFyd
	8qtIn2ndqg90oRTfAELXgB57UA9IL0WO1lwmptzKMfhHBvvgQ2PnEWCV3BwIvKemOo8jXaXhAWU
	7S9EQEN9IEyAxwOm0Xk+X+TX8l4W5OI1vuaF3mgAMIzatBvLRPMB2xXTHJen3KmpaET9lhegZWy
	ixLu6vl42tVxHzY8m1j9kx9hILBoHciDd3w5P/3m76miN6n5G05tpfGVZ34yKO5VCRLcyIRfabI
	zDcXpfAI0XgA8rN3QBHGOpVF0/sdh7bv+1cLycFElCivy4tXc5GS7RvwSCSE1RQxCSjT56C/pl0
	cE+3Znp2vfQf1MPRqQKvsWi9+hEm1AsE44nFwuTIf
X-Received: by 2002:a05:620a:3710:b0:92e:8f7f:e51c with SMTP id af79cd13be357-92ebb60a590mr47342385a.53.1783341896223;
        Mon, 06 Jul 2026 05:44:56 -0700 (PDT)
X-Received: by 2002:a05:620a:3710:b0:92e:8f7f:e51c with SMTP id af79cd13be357-92ebb60a590mr47336285a.53.1783341895726;
        Mon, 06 Jul 2026 05:44:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:44:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:14 +0200
Subject: [PATCH v3 02/20] driver core: platform: provide
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
Message-Id: <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manuel Ebner <manuelebner@mailbox.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZvC54swIjtoLdWic7mjkHUk98Z7cygXvR6WiVNV09vM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MvV2oOwm8I6DyBnozXcyFSk9osOc4e2GH4g
 DJh76eJhECJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujLwAKCRAFnS7L/zaE
 w74pD/0f7wh768Ib4M3VSkBLYD7YQhvFxC2RY+MGZZP+VR1ZlemRCg9DeXdDdSnJSRDL3pft627
 DEvgLCBHwMElpwNSxsMWzEZhXl4R8IEAepNXoxVDXBTaHg3jl8EynFQEcWOeyg6HkMutGn3PMWF
 Wjlt68/Dol/bNnDNzQXKwG4dWAGXaKNln2ReAlzp6+08tymfFK0JoWQ+H+6GPkgzlbEX9CcVawD
 DKACpO8oiyAfEvlpIepcdNMc5lgfc3jv8gQ89TMoB5ERvz+ga96oVvwZQ3Q4ZPthgfz3wAkwDaB
 t8HLs9zAF3hupQ1CpfEox0RQEZDOa40SZwCBoEBN13BQBJ6AroiSGotGwZQQQ9aTWFrgZST4gJD
 SjTeZvyidzE87MxKKYkvxt8NanEKGvWihHCfVtXKt9yMdwr+hSGI96PqwLkOZqj3lOfEjy9zaLz
 Hj7GbbORQ7C6CvDBp8MHQJkkDKHKAE76uGcslbyA89nnGeDQPZQs8bXxFe5imODg7O3XpEA4Bee
 zhvO48lmfv/maHlAUdlg9HdHPPrS7lvHqXMB59rQYQQvr9aCZVoPUC/9+l0ig00xy3Q3MYp2FoT
 xOnkjupxjTDlvOP3c50tvOaWQ5NBcYARj08DrQz6gxBMoL8/9250lNxRls8cpxKP9h/3z02yi9F
 7ilBwmbOytfDmMw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: fSEtFyCrKXsxZ6zcxMMnB8abk7SySRIN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX6tpEuZ03JgRk
 qJH3t4C3ilsEEAfrM+2yDsQMcpoos13jX0qsgDUDPpPJVabsCd1V5vdO49Yx4x75BpU7gQPX6vV
 gyLUi7oEB8o/zMkBx9qvdakeX6jIpoY=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4ba348 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=b3CbU_ItAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Q8RKEeUEMY9O-VPP2I0A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXyQ347r6ZRoJd
 4RJA93BKx5bYpOssB6cbiKpaZOcra1z7YitzLm9N4QuPsD5ZO2W63NxsZ3ghMiEJ4FgsESsOE5/
 cW8wDWt9+/lprFyEKu+M8Pw8oAOGJTLQS7y7Ow5FRFSB8hTelBpijHJWtY70Mwrs41n4hoMIYyC
 ZTgiCGTsphQBd7q/LpNya4aP0gW1jimKDTlihDxB8ihRzrHA0xMyFLy4jstTdw3ORC9thI+6TI1
 wjgZGXZwvsnYky29/KhGbmUbZP4hg8K+e3/08qgldKILyFEOBxHBsHLuh4vmGzjfMRSVmZuHsdQ
 Uo2Uz+su0l17tqu3z/1gzqrrFQ46BSKh0FI/EaElBPg2tS/Jqk47lJxlsFT86Y1PxEV32uCADTC
 M2YgaTylJft4GNf80ndbDQRQzoN+TU9qXTVoRj0zWIXLK9bxKpKSHVZBw4Am2SYe3ghxM3bMsY5
 /6xyq6FS7xRxmTgG0aA==
X-Proofpoint-ORIG-GUID: fSEtFyCrKXsxZ6zcxMMnB8abk7SySRIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129

Encapsulate the reference counting logic for OF nodes assigned to
platform devices created with platform_device_alloc() in a helper
function. Make the kerneldoc state that this is the proper interface for
assigning OF nodes to dynamically allocated platform devices. This will
allow us to switch to counting the references of the device's firmware
nodes, not only the OF nodes.

Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index fb9120b0bcfe0e7dd9dfc0d29b91e0ad40a01440..3188d5aba5f90622f821c695049cacda030204fb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
+/**
+ * platform_device_set_of_node - assign an OF node to device
+ * @pdev: platform device to add the node for
+ * @np: new device node
+ *
+ * Assign an OF node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np)
+{
+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = of_fwnode_handle(np);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 8c566f09d04efe420d85ffa046f92c44c6d08526..e9f7baceeb4c8269dbc0143c4d8fc9d73ba024ca 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -19,6 +19,8 @@
 struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
+struct platform_device_id;
+struct device_node;
 
 struct platform_device {
 	const char	*name;
@@ -262,6 +264,8 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


