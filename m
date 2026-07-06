Return-Path: <linuxppc-dev+bounces-23620-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A16AC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:46:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3x76NGnz3c75;
	Mon, 06 Jul 2026 22:45:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341931;
	cv=none; b=AZa6A21qVG05HXDA3FOOXuIjbBrAibP8lwySGm6Kdjw/xtuRJAD6cZxR2E5lv8WSLTgVk4WVrgHLESvImwSmRfGB1ek9elyYBHBfpCKT3llluweXCYSENWUEPskGvCeAPOloPdG1tFG1q+EjLC7GRBGjCNg0C/rBUga6ozLYieteMvw4k6AIlY7nS6xqLwCRDF1n65B8/NBZskt3oW2VVuRV/TvRkMVvaK+REg4TFwdhIkQfE16asxx1YHdAL6pn8ML4iLmAdYEDywnpn2dJtkEiYgoV04EPcQqPgJnKhMenTWB7JBF6ebXaXWlywdVCDK9C3VHVMeOK2auxzLJDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341931; c=relaxed/relaxed;
	bh=ygsrBoZ5Msq9mGih2gcNmJUG+KH6qwVJkoNpq3S1CcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2phQMnX3F3Oaa2d+fwT0v2/HMLqtYUPh1UbOnWO+1DVCvJLYKP59fvIid/2+nUk2p9ZMoyT9VuuWtQanrYmcL8zKH4xFJezYaKJHHOVw0izue/gsDbkQqDwELTZ4qJamx+QWGJUJC33s2kkSAkEPczO0G0KvKSeCaIlUWc3YqLF3GmqJ+YpaXP4kUCvA5q2YjinloqafpIoB0C00+UWZAswfM0K2PBenEP0qBHQzxLW28dRv/QEagKBcI4mR3LDIJ9PuwOK7IA7NP5RXLl5D+VGtDNefsD3fVm5+fP23kJSywr2YakMRB/RnUBMi+t09mHH9513ZYFrwua9+JJd+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MjFrAnhn; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D84fdLMJ; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MjFrAnhn;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D84fdLMJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3x70h1Xz3brV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:30 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxVcQ219069
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ygsrBoZ5Msq9mGih2gcNmJUG+KH6qwVJkoNpq3S1CcA=; b=MjFrAnhnTzb+xV5s
	v+4J6CGSB7Axv+Nr58UzsQpgwafsybZqVyHj6wa6qd80gwGZIVaDIPIu71l1pwAs
	2Mkc5NH/bOSZrO15edr08Y9srJOJX2R1XayYh0b4yygYdSpy7EfuSlqjbaUz9DjA
	HrL8KBUsmxXkhX/v4TIQzIYw0FIR+PZnYBaGVMIIQpSGWE5teYcUbkbrFKyZNhg4
	bU3CEXzfLm2PPlChvI0t7Izu2ovMdgX5HZfe3YF/E3K5Sic6J1EkpbAggWyM8dPx
	ariZaaWueCZsLX2beqMa2/FpzW6FHOJiITC4zMbnd7Tj6PsJlwjElOOZI2OykkVa
	WIQehg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs93fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e66f9e2baso290750285a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341928; x=1783946728; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygsrBoZ5Msq9mGih2gcNmJUG+KH6qwVJkoNpq3S1CcA=;
        b=D84fdLMJtiGK3cIvncGkH8Lm4yp7GO9sT1oqbNKL/VTR5kKXN3aAN+bNmkyFZiqmtJ
         LUeuhOpie8B74j5vGhZkF4kKXKw77FMgMHG3ganh0qBc3Tv3FAj/JuoXG2BKVdHOOqJR
         0jcJpYl7KSqZk8BbPiiAQ+6VAxprk8Edwf+WAxcILRmKlfuTe+V4l5ezaDv5s0bpAOiT
         1KQpWTWky5cTGWEIWDYQnxbFGWAlbpm+IPCLQzcSLhF0YpMrNqgjvS8VV4u5k+JidAkD
         vDCmN0U0W+ANdJ6JhNoZAY1eg8uVx8YQkxgSgV2Pk9AR+twccIyEQWEJMofYwhm9Q8ve
         /X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341928; x=1783946728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ygsrBoZ5Msq9mGih2gcNmJUG+KH6qwVJkoNpq3S1CcA=;
        b=acM1fpPq0Rir3tkoF7VQqM+fIUCwscHqZCZ5V0nBLyjjS/jMMBOugQA8DmQSO51Bl9
         8EWUQuufsufERjQ72eitwmZ+z8+AFxuTCSC8GG1j9/6uPzAqw4FMiXUka63d4B/8MoE8
         yDQ0Veh8h9j1pyzKTrP58FUroxGXi6B45a9fnumedXIrsdGuYw2HkDzb6XmIl/Ypm4Fp
         qg2tYfwNNyf9vfkRMb9luPzykLDS6fjT+yp9hTn7DtICDskeBf9iYjeQzNwBiXYblbAo
         g/BXkWNhFwQqQpSvDLZZIszYoxz2evOFNaK/RI6r0fMSn0fBy1ppLNz1/Prq2csMDF2w
         4gvg==
X-Forwarded-Encrypted: i=1; AHgh+RqDnNglqcLMMsaM1gNfPn6apAG3W0HEGjcWzAJxqTpfK4+SWhMqphDdzJM6iSLhe7zwMWFdYw/hqnzDzDA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyXDeVIfEDvYu4nw+/oAjUtZ8ZNpKB3YY545HizI4L6KTDApD8
	A0n3aLJHAdwwewtk6WCk/21KBEhe6Yc1PlmdRiU+XBcAl3Cd0zfRYzhkyVsk9xudaKRy+BCeOwM
	ep15Icy/8PLN12djjyxUdnYML+kQGW8OzH4zpUobFa97JCjvPdjOQzWnOnzJbii+MH1hA
X-Gm-Gg: AfdE7cl5rfbluzinWGwXP7G3OPqlKFZyqCsrt1TNjVtfRwAAtnKUkYne19QN1MD40Sy
	mx+L4irZENB3EzMgZMlT3XDoheOKgTt3QNaSaA4zA2cRTwX1aA5fL/wqV67kPow/3m5rwXI4YoN
	0ua9w5vpa4Wr88eR+QhOe87dJw+EoRbPFlPmYVPl8MIU4yB3XSQV7cUVGHH6gxdfa9ez3D7fSxB
	gvlGaerXAugtMXy2kfNS545tAnbW40y9LXGNoYhiwCW5c5/oWYT/pvKaerTNdF1aE9sHcINbKGC
	tvgXzaItNXMw1Bp8Bc6SVyf45BIBA/AdocAH3YGm6Gw/xOCk4FAFN6l515ep1DsA4d0NMtfwELI
	sENrHf5PXWWAmtitq2NF9+fVWIuVDvOacKh5q/ngQ
X-Received: by 2002:a05:620a:2725:b0:92e:6637:db5 with SMTP id af79cd13be357-92ebb4c7b4bmr53420885a.16.1783341920875;
        Mon, 06 Jul 2026 05:45:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:92e:6637:db5 with SMTP id af79cd13be357-92ebb4c7b4bmr53358785a.16.1783341917264;
        Mon, 06 Jul 2026 05:45:17 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:21 +0200
Subject: [PATCH v3 09/20] iommu/fsl: use platform_device_set_of_node()
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
Message-Id: <20260706-pdev-fwnode-ref-v3-9-1ff028e33779@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ToUoBuUJoS1vI9JQbupGD9AhsrfiD0t/t7tbmkvJ+bg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M2nbcqYQU2rto0INZYhmejKoOnH4JJ+foOF
 gbtQ5diyWiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujNgAKCRAFnS7L/zaE
 wz3eD/9zvS34vmhbvapxOOuDeHkgoWjbwClrYYz28lrOOlhdhx5lHNAE1M677a9LnxVGFTNWSgn
 z/9TlTUdzy917cFnaNTfg70HD8e/p303kaNPl4g8CNn4TxYUEHm9ktX4btw0hsN/hTGOEb9xrJt
 YTxoQgL6mPAoTC0Lw2nQbw1KUtKQD1CFXM5HUF3lWAyZyOo0ZKAUpQ60eF/hC31K9znEizz+t6H
 MDZ3G2qpJhCF52wAoxmhehajnKaeHhV16Ecs/vtwGrv7Yg7zibDx4RVD+ggasuNS3h+wjWclE77
 a8ascuOrwRU45/+MqL4dliFlZ6Ybby3l8MDigKYin/YAH5vuJF1HzvySs9WsRdD6C8Lq4t75DEm
 HXFZJ0fB1GZp0UT7ayM9xHCIglviy66c8S07wtLg6kkkLq2x3VnHMgPUcoT7h8f95M59G3qXUEA
 8ATrnqHYVAYpH0WshNgZ4U5bJMUAVg+VeidCRa+lK85JtBU3wAWCTEqc1gsfTY3+XhDRr5yiHx9
 Q2zV36L8qjBGU/KX0zn+aScN54PuQD+Sw8Fl8IgXOOnNdr4kHuA1+O3XIlVqm+rrQ8GKb7n2k0x
 SL5YGsI5Tya0+tbYEXhNPxmRmzQHjKyZL7455KsB1CiWGQk3FpnaykdRAHJuEVyv9OmujsnRceK
 xP3+XsEnk3J1FyQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: GYkqKryeuoT7V6kpV_Q4e8Ue0WLe9qvc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX3Ae+7qU4QTbC
 IhWuFDSGmZ/NKBvoqqnsWudvCqGIU1UjA9P2uruB0v6q3jZtjBPvVqyz8RQIbe0/lwqJBJa4ZFw
 6/sUwrBxfRmZynKPc2llma4bF5/HRotk2XTLVRUlKNV/IuS2ibUbfcR3Ck0pef6OC0pRVUaEgyM
 6ZHyO0f/YH2v5+tfnXV3dn3Lz+7vAQL4XhNSt3ImIXmckAQJR0re7whnqSACzrO3ljUyDzyvlfo
 CoaKKS7V9cXnWxvVeu3gyzf3vHtYcbkg1TLqd46vKbTEfHUgWBIYm0XI2gkUPHEp0QYEzPICC6j
 +aGS1BiCTf8qpGQ8Dzd9/jqmKlTQEYYsI9n1yDQ7j/en3Ca3luDi06YbpV1mbZ9ASbsJkUmjHq3
 YQHPJL3Xqha6rIZcEXZ87t1Fv9IFyAotdmWjpgb1dPB6FNrpXqTywtJEu7gUoaNeF9lHVTNcU8Q
 DgHvt72sLlBZ+yA9msg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX8RWz1CW6ZGpu
 k8+5aB/KwX5OBWks/pi2wpwOb8BXTDvQjGKbgPb8ej9EhxiiW8LZTsUulavz0m0qcnAMmtWtpVi
 iJwHw2PiZKTtNgxYvv3ESB9L4FfeAYw=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4ba368 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=7CQSdrXTAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=31kahzM04Zwkpn2euDMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: GYkqKryeuoT7V6kpV_Q4e8Ue0WLe9qvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/iommu/fsl_pamu.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 25aa477a95a95cb4fa4e132727cde0a936750ee2..c83bbc3faad56d6ee1c89b0a7f74028af02c81e9 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -8,6 +8,7 @@
 
 #include "fsl_pamu.h"
 
+#include <linux/cleanup.h>
 #include <linux/fsl/guts.h>
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
@@ -933,7 +934,6 @@ static struct platform_driver fsl_of_pamu_driver = {
 static __init int fsl_pamu_init(void)
 {
 	struct platform_device *pdev = NULL;
-	struct device_node *np;
 	int ret;
 
 	/*
@@ -955,7 +955,8 @@ static __init int fsl_pamu_init(void)
 	 * PAMU node would require significant changes to a lot of code.
 	 */
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,pamu");
+	struct device_node *np __free(device_node) =
+			of_find_compatible_node(NULL, NULL, "fsl,pamu");
 	if (!np) {
 		pr_err("could not find a PAMU node\n");
 		return -ENODEV;
@@ -964,7 +965,7 @@ static __init int fsl_pamu_init(void)
 	ret = platform_driver_register(&fsl_of_pamu_driver);
 	if (ret) {
 		pr_err("could not register driver (err=%i)\n", ret);
-		goto error_driver_register;
+		return ret;
 	}
 
 	pdev = platform_device_alloc("fsl-of-pamu", 0);
@@ -973,7 +974,8 @@ static __init int fsl_pamu_init(void)
 		ret = -ENOMEM;
 		goto error_device_alloc;
 	}
-	pdev->dev.of_node = of_node_get(np);
+
+	platform_device_set_of_node(pdev, np);
 
 	ret = pamu_domain_init();
 	if (ret)
@@ -988,17 +990,11 @@ static __init int fsl_pamu_init(void)
 	return 0;
 
 error_device_add:
-	of_node_put(pdev->dev.of_node);
-	pdev->dev.of_node = NULL;
-
 	platform_device_put(pdev);
 
 error_device_alloc:
 	platform_driver_unregister(&fsl_of_pamu_driver);
 
-error_driver_register:
-	of_node_put(np);
-
 	return ret;
 }
 arch_initcall(fsl_pamu_init);

-- 
2.47.3


