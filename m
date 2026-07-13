Return-Path: <linuxppc-dev+bounces-24109-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1BBC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:29:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzJZq0Q18z2yVZ;
	Mon, 13 Jul 2026 20:29:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.180.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783938562;
	cv=pass; b=g6x4C59jWma8NhumXSpcUKw6iq3pJphOJa8dfUet1UvYpKAX2uvQDTC8GB5IFcDzmJftxnZLcdpIrcWWIokJUC9LMLZIrtzokax4LvuV1UlqaVtkKHkIIsPK5+33YaYQtMeTk0fYr7JbkneVKFrFa9RWbMGEK1Eml2SNHKTnRYbCM2FA4V7bcx9A80DmW/GyIxLzBuuWEg6JCeRYLPWj5Jj0UY2BRRtVEf6EB9dXwrMxTR9pFcRhdUM61jWJxQ4homjT+Pl9TZW8yFziXiP53ih6XJtFyZd7UC6dhhZ4Z1RWl0GxmC69uTC5iNA7dhaH/KmhPF1sImCCJTjcR0FxIg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783938562; c=relaxed/relaxed;
	bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQ4d8HFz7V+vYrQmV5K6dQGkwjQXTMdZawvUy5ebyw/CH/qZLG1mJIaKdiY6LWP23pMYPg2+4CXIpY+fJdNr0ZQ97O4fzsLW0VdgTaB857MA/HY7S2vrHmU5VH9wL7rw3fjz4BPxGCgx/1AnBlf/+7tCaL0S7bCO99bbVpD8CWWcpKBtPYQQesepa2L743XA+mYboRCK7Xrf0Zh2XxhWaf59jSDXmChys06m/fUtx02ssUXdSmkco2vcA/Jt7vMIbGNc1s6L9VLqRb38GV7Vd4vtUu0LnVZEN5i5O6c7Dwy4Ge5CbtrdaAIe1sONPFk2wr38qgI6BHlOknF5VY48YA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QNFOxgh3; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aoCd7NOU; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QNFOxgh3;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aoCd7NOU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzJZn4WW2z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 20:29:19 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9R8Bw1122940
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 10:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=; b=QNFOxgh31F+aQwWH
	ovN+MuWYrQupUnEJ4E05qCBe2S9rP7KHAIzWX8QuWwVLkBnQCTy1Hz9uUXC1S7DF
	8ziWPWrYXfAPxVQX7yIQ90tkfXiCc0VPr519QCrHicbq5mx/va6EOAY8OJvHnMC3
	RZF+ARzvL1gWrkTRgAmMOSEPMRMgnJsk3tSucarsmgrls/L4q+xlgyoSuIM/bgkt
	B+B96eVD2U0ghoOzlEzmHlymMGN9Zy4snq+v8VItrjMOWQ4hjzJIFO+xwOz3UgBn
	1yZtKxrH/rfPDe0dXOHL2JQMVO51Kqi381IJox02JTjVELMpumm0HRsXH/c9hr2z
	cyqT8w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda07ck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 10:29:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f08560ea44so46289186d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783938556; cv=none;
        d=google.com; s=arc-20260327;
        b=m0/T5Ab+swinMVyyJSRL2LIviGHABO1EB0gNXGI1vv2L8m/lSYGB8I8yiPEBKx6Ebi
         Uqugv6JpKEhNrfHO6Xv99YivZMWdzEPGU4OmXnrvXkIpy1rAatZlw8ir2+pSnHQ4e+KY
         xe2fFxFD4/DYX0ATdFCdsUFj7V8ZHh4gsYVFEGa3uHQVoA+Cb1uson4vpD/kr3nEuF3t
         rla+b0NAJ0rahmfV0JspHOmMunBBX3ChAHIeK4YJRe4qYexMdu35jAuXu7FUl3/nxkMG
         CrUYst6N5bkEsDruPwBgsDn5hMo7CelaucMdNtUUCqXBObT3wTN63gtdftfoCNRZqrza
         VwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
        fh=GEri2gPXZkeXcSgTYAZnKWVVV40rUhi4eT1yhxLTXZ4=;
        b=MS4wZQTV/0jfUFp8+hdVPn6YWGSlnXGA7xI22UMFvLxcrhFuQBTV7zpVIliQeI+NRc
         tKd96IsonaT3JY69KU+jn0vD7FDq070H5g82qZBqF3/8Wp5OdeFQK4/rDtSe/X7Cnx3b
         jZU2KEEG5Vh98+LSYrxdOF4z9V01GkcNRgG940YnYYhBeXY2hU8TInSReM9HTtfPb6rS
         Mx4U13B9pnh+7CvBja15+IJnWIJFZM02Xj3jCmM7sB9WRI4PLLVJQaFL4d7ysrw20k4L
         rscH32NIdB9ABPWLhLpaoUqNToQlICW7Q6Y3qEUB/VfMMoGnPCRGkRhlPp+hPC0VKyLz
         DlRg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783938556; x=1784543356; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
        b=aoCd7NOUtZ6caCK8IFEwGBeRTaTJemTNBo3Kntvg/TUsJbEXflWUUl+fgTfRKJwHOK
         aYw8C6vUckwNqI9jNr1XqlW2LHcMfUQ/FmtT9sGRm7nDxgG1FdT8rVqNhjl35FqIjy4w
         izRHSs5fvg6rqOv4zM+QzsHsT9cG00XZrnuXiH2IeFhwYyCNH4RX/Fmop637GQdEotIW
         GAfLeh9Hl5x/L6KeE2GkK7R/xPEVCjhJAG2jicMZNuAdGXpYDLWihvSIee7N3ma0z7UC
         U0C4s6R0qZb9iDjrEVz264f9A7Ahxd1kG9klrYnTP5AXu81MpGBZZfG/2qXjCQccE8ut
         EtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938556; x=1784543356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
        b=D4CqUoQrmZ3a7iHuNE3py4PUp5HEpoic6CnugHCVgNBDWuGBWlFAI5w6Jps9DmQ8EC
         10M3Qf6HGadFlWEhSLiXNaMNJ0kbNmosaOo3vPOuGvPmAqTl1VfiEUy+wRZpVRFsj4OU
         cxobVE8Jnxvsp5Dm0PkhGiVLkq0E0xbva1TIj8L5fuIrMMtp/VjNNzcCOT9Z4E6HpUcP
         E2Z/gZ802JyI4znXO2xrzNkrrwJAwxM6DW+Aqmxq34JQ66WD00yt7vg9IKy1fuQYJLp6
         5xb3qEu/B6DSktPo/h57azOH5CYrDo8R0Ffjt8LMbPgEDmig+wMd6iL01Ak0z9mlXOCo
         H9Og==
X-Forwarded-Encrypted: i=1; AHgh+RqZtoMk+h4v2D2mOHI0HiF/cLL81siUp5k7aQuNkTONTerh+aTyuUGal8/c0yXzd2LODnMc4fvhVhFDduE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwclMiLXRSWii693tyetHCGAtnJ8S0oQ1r7jAI0++2yYbf9lM4Z
	d3rLN8vIG8WxVOkLj2TgvZHChttRbNkYhmi6yMXyF+TO91xIY77N8cBm5acUQxkZSyZmtCBtUul
	wMT80iYNhPLOmK6KHvhxEOSihNFGFov2NvoyqnGiPUhvznqxsDxsXY/ynzxZk3VXBRW0TTLK7lr
	DwY9OaH0bbnlNXfepuQO9uHzXJDbPhXUExn4o2Yj+uFFg=
X-Gm-Gg: AfdE7ckg563fU8DwqEEkf1A/uzH8mZnUPeDehuL65Q/FxhRrfbrfZH6H/A7FUUMUuvf
	9ZkD1F5sf7QcVEpg+oQLik3wTuN2YIt/tYCPkKuw+MMl5gvPNZPKePjIKJoA5TmQefmjx/gQUlv
	uLHjg7+KrPZ1nZzfA6Wgpe9onTmFlwYHXlqCMMvH2MZCM7wIsgZVSCLu22CvJs3OwAWJbJ
X-Received: by 2002:a05:6214:238f:b0:8dc:2c21:32bd with SMTP id 6a1803df08f44-903ff76144dmr97564936d6.1.1783938555919;
        Mon, 13 Jul 2026 03:29:15 -0700 (PDT)
X-Received: by 2002:a05:6214:238f:b0:8dc:2c21:32bd with SMTP id
 6a1803df08f44-903ff76144dmr97564106d6.1.1783938555502; Mon, 13 Jul 2026
 03:29:15 -0700 (PDT)
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
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com> <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:29:04 +0200
X-Gm-Features: AUfX_myf4-1EuuJEsM9iEruoBmhvEE1_shBmpnLHYi6rPSO8vgxEgiRb5eZm2os
Message-ID: <CAPx+jO-P3Yt6T5Kb97MjmMB1mYeEgjStCkSACM_wsrqsBVFEvA@mail.gmail.com>
Subject: Re: [PATCH v3 11/20] pmdomain: imx: use platform_device_set_of_node()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
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
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwOCBTYWx0ZWRfX+VnlJcn/2iFB
 SnAoSctKSxYstH3TROHUl+rts5uCFwEScPviBWqGBtNEoNPWgFvFVZAok3nhRTGaeeCQrefXJyV
 L1jdLmP2AP+yhTOGlT8BqYWfjWiqiQc=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54bdfc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=-ghbRyKqcrg4NgclPfMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: Ly4fstZD2ND21w1E8w_V9K8Y3Cdc1qOP
X-Proofpoint-ORIG-GUID: Ly4fstZD2ND21w1E8w_V9K8Y3Cdc1qOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwOCBTYWx0ZWRfXzIgkOr1yAHIn
 iKyci5Tlsmf5HgwRF4rHkjOQgGEiuaciy0tIboJxJI13IIbx2jyRXtj4yWPsBETdI+xbT3Y5F/x
 GfQvx4IuyLLmWJ9rlSsnr5pMj3Rwb4WsPMY3mC/IUtMskgPFpWQSAu1a3giCQ2CYR0EjcPWM1XX
 mKwLHqpoXhWKlUXVcD7IfNKl26BfYi9h88niFO71zpmE39HMpWphaetOTzLdT10BKWcNkqtivOC
 /a7EU5XqlksHsNcXehP3S3BW+0lfdzkPMPsjTGcLalH1X3Jr1ZVubshUmpLmqPCasnT4I08WRO4
 6jsj90/GzS2GsU0kJrutHha6vZSt0t8p1qXE1RSoy571kMjSDLksCJwnYCdXJ4l/2cOu6am4cCE
 qezzjx2VvYZcWxEZbzoGf4c9ENFMlH9Hep/C+fccLfNoUqzJYqFAf9Mbte0Fa5bI3g1ii1n7riz
 WoHRBx815spbuXRBclA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130108

On Mon, Jul 6, 2026 at 2:45=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

If not too late, feel free to add:

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 42e50c9b4fb9ffb96a20a462d4eb5168942a893c..abca5f449a226fbae4213926e=
1395c413160c950 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       pd_pdev->dev.of_node =3D of_node_get(np);
> -                       pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
> +                       platform_device_set_of_node(pd_pdev, np);
>
>                         ret =3D platform_device_add(pd_pdev);
>                         if (ret) {
>
> --
> 2.47.3
>

