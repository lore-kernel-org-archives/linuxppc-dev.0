Return-Path: <linuxppc-dev+bounces-21290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55837CD5BAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:37:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhc30gs0z3brP;
	Thu, 21 May 2026 18:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352643;
	cv=none; b=TwumGdcqyKE6PBbD2zPRpRLAAaXFKLgByZQKtQTtCUXzRPMSGpogGum1h1jH7pSaKrO89gpz/sxR6nRVjfbOCNUvQGx3l/Q3M95rRhC/ehJcxDz2O14nmzGEBchdalP6XJsBnG1wBNx5ZqFLu/tFDkmDazmnEn6Y/03mqbqNqJmxOIXzg4L2SWIZx/mbQcaqBHrZJUx9swO4DPcx4L4DPZmSEq9tYXZaj6nOi3J7xDsk51i6bswaGaFCNTP3feShAd1xbT9uY2WEfWo85LlMOdN3eqle+5m6MU2op8xn/hgQgwOec4KhcXu4GpoXiOjD8ylf0hmIaJN/ENeSJzeThw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352643; c=relaxed/relaxed;
	bh=7/ctKXvDvcUgQZW7V3LpqjnLay8t9Q9hc/bk2yC/dt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kO8IextrSBYnUEb/Ny0UztEMLA6/eeluUarsUsUsC1grf1apCfeZTsbLNpMMtG9IbQBHihhtHn9ZEJsBdCmsobR9Sw6WK2RArXhfg7T8WL4d9FGaIkh40maox1sB6DB+NU1E8vwAHlMrwaTGUqEyvJ0WS19dMag3rTlltbA9fbSrnxgmWGTEG73iIkzlISfybBnYs2FnIRbicsl5nhRlmpILGkwDsrNwmpNJIkaUjBoe4yDJSi5BZWDCVVxnuKrubfMICQwjVbChAPIbvPPQJZ1hyA37G8P84c3YobIg+ZPRtmQXhowJTK++rCt9UY6jL/svV81zQasYoUngfu1ptg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=djQmFj4O; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TahJj6ed; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=djQmFj4O;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TahJj6ed;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhc23GKwz3bsy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:22 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L61HPG2157503
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7/ctKXvDvcUgQZW7V3LpqjnLay8t9Q9hc/bk2yC/dt4=; b=djQmFj4O78Kw61Af
	ZTRwyYsSq1FlwApquXAjrrMNV6MDYgIBSnNZiRtCqTVIosmFcxjAkb1ty/75WjCK
	YhtUfvmst1pJLM3GcrvSe0ezIW7Y50K4lTYcWo33TJohgKYVSUOZ+WkqzTwOCbCo
	gSbIPnGGTI5VqDzxpucso1RxtjGPhan9P3mqO4xk4xxPWE95nTbckAEOX/Nhkh6A
	zpCTWRZMwjoYJuZP0mtrLG2RWeFPWj/XrmkVB+nJYoKeg7L7a3JorUpO1077eV9g
	V9PdzC9QKLJxRsQUorxPcY9EMEzc++ifXfG4xJzguDOQbn218aeX2vyAagWRixO5
	w5qyzg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma428v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e423a05c8so160875801cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352639; x=1779957439; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/ctKXvDvcUgQZW7V3LpqjnLay8t9Q9hc/bk2yC/dt4=;
        b=TahJj6edFI508eXx1Rctnyk3wsWG4p0OVkMK+vKw3HL/l4LpbvBnkUEvvRbqzq96C9
         eNuE9Nu1yIG7ffSEXmxUyHoF/b/fpNHchWROe0SqDmcVgYigk6a/SgUg/Ph2i1qroLLq
         sfkSgneRlEXpc+S2d6WON1mZwCb+iFXs6+fAMkuwj3kaA6M5KoIPpm+EDTFyE6pe7BQ9
         +3hm2AoCQqSE1Ha+AefOz/3iqHhg7yCzVTeHHP+nOAo4WDjEN10JmYoNRsbaaZnHfQFa
         TbPHOaeKb2W+aZ9Q06M7tjE1JuGewwUeRa53N7Dd6YZxoDTyg4mNynFnCSfwbJ4UpkSr
         tbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352639; x=1779957439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/ctKXvDvcUgQZW7V3LpqjnLay8t9Q9hc/bk2yC/dt4=;
        b=DG/2YFlKWVAjUJ4PVq3oL+LOXcbV3qcSJGbY4KOXIcrJUddx5/HpDhd3ZvHyVu5elF
         0cCpcQPOHG0aDd7ONJ7An77dljbd0/qqG0R1cyPLjqH+rb6l26vto9NUwrMXSfa27s0F
         I0jP0aL7cdC7VFt+xxBJC/llaEVdxQt4IAZ1e34lgOqoy4EDq8cK1+wEyNCPrR20G4wD
         A0tuuDlcKRcfi/UW76xlYAtLe5ThMIwTohVepZCXGhpu3J8hpR3LXE9SqojHRzEjo0Ut
         qki8rmSFTtmqdu6nLScMxnRPW2DfQtzXv4KQ6TWw2496Vl6hSNiQyzrHCUxoa8VNxYoE
         erAw==
X-Forwarded-Encrypted: i=1; AFNElJ9cK7b7TUE0lqhs+Kkz4NRDepyLeaQLDLoigmAuG9ShsulgEDeWB0nBIfacUquK5pf7quvMBIa1KRVkDyI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyb25EJVP2DOsRvqM6p2UggryYp4Vy3Qt6u2c4NTKDeo7IHCcYL
	I9vk6hEEqyK2u+ykDRt5LiJ6wdGAmocDjpu/bbR/hFo2HZfJtamCRdtTYlhuU+058qHvI3ycPOy
	jZCowQoSkQDMhSnQ6dZykRTXudmWL1OLon1TAMFpo6xzZzh/6q4RfOj4wHBXrNMfrJUB1
X-Gm-Gg: Acq92OHLBabnQUCAWSBawSlOApVSlBJCxDCJ2eSoktTSvx5bYsQYQ5+V7T5feyC0gCz
	l80mdPSA3zJ7xHiQR3wPK/cfvXf1RVjH+C3FEKuw6PDNlgUtjwG6aIwcxWrgDlrR8sYE6RCju+Q
	z1/pEOMRWSA+2K/k+GgYzv7JzU4YgiuBGwumBIK9TDMrIAux84WAzFm0Z1Qy0lIfD+JBjTt3NMr
	3s5p8Nw5iqNAD5e7nvCqcfIS4BzgqbQnZ4sLk2DcVkmPczWZUxvd74m8NpoY2HFR6G1YEWSnKwx
	vElZPCOStdiT7xBSA0Gq+ED5hvENH16iF7bdO+Uo+JRpintLIE7Skvjz83aIdjdWSXOmqTK3Tmv
	ZSz1HBvSbhFcmQKNk+LGtnKij+7/wpr8zMP/8Pk+h9joy42PwVoo=
X-Received: by 2002:a05:622a:8356:b0:516:7a83:8c37 with SMTP id d75a77b69052e-516c551754bmr17064001cf.11.1779352639488;
        Thu, 21 May 2026 01:37:19 -0700 (PDT)
X-Received: by 2002:a05:622a:8356:b0:516:7a83:8c37 with SMTP id d75a77b69052e-516c551754bmr17063841cf.11.1779352638906;
        Thu, 21 May 2026 01:37:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:18 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:27 +0200
Subject: [PATCH 04/23] pmdomain: imx: fix OF node refcount
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
Message-Id: <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=S6soBSVe9KjUpY4fV3w6m8V++eYkYCwWMWeUkaW05Ts=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQhtpU/CqYzAaq1jp+LLLiJjIA5Qt/YY/0VT
 S3IUh2uDoyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EIQAKCRAFnS7L/zaE
 w1etD/4l9O7wUTmpxjRT+gvruneHUxzYHEIhXscwzHkmXXFaTqlBavoUQKz+sPAmBcudjOXscQZ
 mu4A2CkrCOVZtrepbcDAksLfqo0RIXfw8xZ6iNAc7TSbIK3BuxmxPm9SM9FrlfFCYlcXIlQCPU3
 VVJ56YN3+53SSoxDlaWqJqOl01UWof5ledWKTH8dzoqTxaxB+LlTLL2+tl6wzT1hIGLaHrq0NHx
 bCcVpM4BywkAyrn1olQuZt9D+PmGCR/zu4IqxjWNsg1Ik47sX+JWSrJCCDlVs9WzwSP6edRFsTr
 eWVh9X/z0Zp1hPf5XkuxC8WEE+ciQUi1ZtOFxOUY3Vjfup0mR2EWcJYYwcvH85XbmRz/VZugYMl
 LhAXbqUdasak8C0n65UmlfBHkKOBeIwN23suD7Yx+Q0ORyAUBdEQEp4N7QpNWQpHLr+upEQjLOY
 2MWtqbCVH++FysZ9T8ZwTwT0ndcQDFCyMi2V3eXQjB7KVSGpXFzWPg/SFqJSbL97xhV84W6Izaz
 hKCOM+EEUU296NZs3+u5L2wPfjObJIqYpxM9fKJuc1oRI1cjHoUUBAbdGLhOXXnN62XXTsUqhLm
 zCKbcupHSwPo+aF8UgCOTdYr82ZFVr+ZBQa5PZBJSIY2Wd4qB0rRonQwRh/TRYIARXk9niYp7WR
 TMEzEazWVqpnxdg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ec440 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3puIpDhKG-71yv69WsIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: AA_s7O3azYfxmNIkDg26nY-6oNVsGOlu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX1pHkTnOWwxeM
 opq8TCNZkiOTlAIdMhXIy1QHvHoWgADqFCQkugSfuslNtEZHdP6Sq8lfUODutdFBF55GPhJk4VG
 BE5QMuBeuPWwhvOKhLYY3F+qSETZajb4uThZrb4ASEmvSZR2qXhRW/VhhqQaJY9zsO0jVCPt5yd
 83tw+qv4n3VfSSKZKt3EcR8TYLF5B+9cyEyUW0PoJFzPGnItutMCdY7K3ay4bIvOTnbmCRioC2S
 rxZu7L8iQcVF/w8v3h6rJqLLeiruVBKWNMMVkNhwkdD1o+LBRXmzYMtU3iKorRjP7eFoZaB737q
 4HneAD9evSMF43MCtX/uC6E2eAM71J/LC0qUQ0YI8oH2cMClAWXA7GlpP343Xb5Vvi2MUFKEq30
 jqYPOYmuQw64QWv0GdJx600kR/I6j7C/MOJ0he/131FitWVpHudmOIF+uaV1i1REKub4z44eUtL
 SJxE4BV9L0Tg+BxBhnA==
X-Proofpoint-ORIG-GUID: AA_s7O3azYfxmNIkDg26nY-6oNVsGOlu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

for_each_child_of_node_scoped() decrements the reference count of the
nod after each iteration. Assigning it without incrementing the refcount
to a dynamically allocated platform device will result in a double put
in platform_device_release(). Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 3e4d109ee8fc ("pmdomain: imx: gpc: Simplify with scoped for each OF child loop")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pmdomain/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index de695f1944ab31de3d37ce8000d0c577579d64f9..42e50c9b4fb9ffb96a20a462d4eb5168942a893c 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
 			pd_pdev->dev.parent = &pdev->dev;
-			pd_pdev->dev.of_node = np;
+			pd_pdev->dev.of_node = of_node_get(np);
 			pd_pdev->dev.fwnode = of_fwnode_handle(np);
 
 			ret = platform_device_add(pd_pdev);

-- 
2.47.3


