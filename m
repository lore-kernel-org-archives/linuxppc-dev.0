Return-Path: <linuxppc-dev+bounces-21309-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A834ECD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:39:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhd66Jvqz3cZg;
	Thu, 21 May 2026 18:38:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352698;
	cv=none; b=MEG7f8QToCfvuuZdMgn0pJAzXw85r7d718JD3VHXbCXPlJdJV8gs/FjnqoYOLPwS1/ApXskq1IoFkxGclkMqrNbOp0mKV9uphReLGYcFIfYLYhCN9LjllWG/yXiwQjNap3MFcbZw08LoSKVMrIqrezd5ovXcJOsAd97IKUqvQHS6AwkvZlonY4qnGcBl58xdIF7E09gRudEHXTExdDtTlhtCr58Oz94LQISOr+S9qi5kI8ESXms7rllNILLHst+lwdVScDFRBPnq/7YWIhhxQJcVy7uvTKPU/w4ITd2p8OrkjVa1zrfK14O7LHdd1UoE6nC5LMxyTKjRoDKamxLrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352698; c=relaxed/relaxed;
	bh=ZtxQlK7p/R1CF6Ljia73lN4Xy0wFZa6+gfpy47TBpjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnWPDlzCHd6JJmxIwhSYH4L8qMoqhGKDzhF2K9zrdekMWoWjuTbyuQxokVy+C4v9JgcrJBhGrIqliHGncmT32YZ7/0p0XREmJU6ZK3ZTqSENPGUeIUiX1/ZogXauLB4wvTnNLPdkITtHiEV2VNOOiXG69Bbtb8GtxsqXI2BWzKJCnNhW7ilCXzk5w7FJfowxIrkHOB2152BZZmVJPy5oyzFCnjomJljTDD/uVYJv/iuewnxpBRjmqTH6v4NuMzZEDhuTFr31dVe3tdA0uIOmeRP+W/6YdjrUFi6dkJXIBHcF+FKeH4FEGCWh691P+2WRhXgGOBzSwMAWIG8aGPAqGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GWDhCsBL; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j+RmddAH; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GWDhCsBL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j+RmddAH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhd61nSqz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:38:18 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L5WMiW3085008
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZtxQlK7p/R1CF6Ljia73lN4Xy0wFZa6+gfpy47TBpjw=; b=GWDhCsBLIGtPgv2W
	c9gVxkym+zZjL9O4PUuVE0sF3TxrrJ6W5P3YbWhFCYzbbTfeqiCKQ+7SjTWsibzn
	nNNxjDvPT7iIjQZ+n9MfKwkkhIzayMl54q//AsstKcgDfnUZQVuOxCMKVlGH9lw9
	PZiM2P2RNKg7Gu4ga5SI8yUCy2o1Alc/GuZ6YDxT7crfbaT4vwtm/i9bxzxEocvd
	fOD7lEaiVoCth1jh2crUqVtYTKIJ7opGwu8BeVmYBKATumsB560irFMWUIIgRWfl
	Qi2+v+b4ajc9hEwmmWkVKbwJcgRWW50ip1+KMSm14d7jLWoHZoTZz3V+xv7FD28u
	phe18A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f4f3m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:38:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-914a8522bd2so63873385a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352695; x=1779957495; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtxQlK7p/R1CF6Ljia73lN4Xy0wFZa6+gfpy47TBpjw=;
        b=j+RmddAHr5zxv0ETpxU98POND6CA69RPaDW6x9l35n9YMU96YRkwZLq0IaXmEh8fdW
         r6CzAUmf96tiYjjzu9wF7aoGg/qyTVvbAD0l46858SnZj6ofoS6FeA+wqtBS8BgUUT4C
         XuFuDya339OCEjajzNAegl6RCjulqaqa3I7LWOfM1g1UYk+KlRBfu7OklWHSyuzLulKo
         TDquQgTwbBvaeMoTwfsxinGhQUVCUkivpeQxCioitbfbxIpSu1yaQHTdpjAV1TAXQHMv
         TlNQrnHnljiJ6ns/NjmClwOhnJs5Qp7ZGUknS/enQMK30icjrYhxswzgnQeh1frNLwIb
         ywgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352695; x=1779957495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZtxQlK7p/R1CF6Ljia73lN4Xy0wFZa6+gfpy47TBpjw=;
        b=auFTtBiUqXW8bfR1G8jDdecvatzncRSe7e2+vW0qntC7AyMpxoRfhgNAfZ288Vozn/
         upI7hmUUKI3+XypSsfbfUhkZ+hcp9lqvRHTa491VuT8SzljJlwYrup4lMonGLA6KnEOs
         o3lLT1+LKi6pFo//+i2UTe4rraPITZCkLoPyR3oQ2zZGhLHoNmCbENJj544BbJsRdCYK
         k2lpx/Pg6jmrPaYz9d+tGrjCJ8fTqKVB4gU6/B43uYU2rGKmoJyk+zGnVXp54YeP1Udg
         1J0KM8JrBvjsx++RZwd6BR/zH0ob5FZPT92g9My7F6RYPiSJIQnbWMxBuZZWehb21tRm
         xJuw==
X-Forwarded-Encrypted: i=1; AFNElJ93sjUpowxFnG8tDyF70P3ZrBm36rzvhH8/FFaGIxgKFeqWxLK7+Ez1gYSRdoY0Om+ruOLB1MBD4EoqQac=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdfH/Zt4WdNp35eguKe4356x3jMS18Lf4F3VIS5xwNl/kx9FKf
	XxQ011ncY4ogCNPdJoTP2Q3rN1NwswOBcrh5NLR3SzJe68IWYKD+KKhbfIwaY4U6Qh3JPGebjdF
	MdQv0602ZIyzMv7DqrAhIM8x5sHFC1yhhHWjvl+9d+vPRmn2rEIJYYUcPoDQ0VcMG1Cjw
X-Gm-Gg: Acq92OGXMGKS9zApGEMWk1vbKKGCefweZvIAi+4DP+2LZVLocTB3H/lXjYiL5n6hBZC
	QQstjkBQbX77odvEh9ov7Xjh/8Ema7FCkcn3tw6Wt6oENvw+Ahdb4VkVVI9ypBu06TC/Ge4oMtk
	Ztv4WSPngsXxUikUpGZfLIXoNL0WWZeOWH4Kasr6sdTPkjw1H4T4Tj345yRHltNQhoeAF6qMrto
	UkDBct77TALWjejB+hOT1m490CIuNn6sG0bFeA0i40ttYGs5nC4xNHJCXvyNfH9wsNzNQyaRvCf
	6Q5umb2YzTKAZuLCiqoYTufvdQbKvQaKczzW2UA+MZDxllihrdcTqesPCEjBI94kjiWDUAFQ88O
	maZIt2mRMZGCgs3ytO0iIc0tr9gtfD9RW0TDUhIWm/Dm7vEOi6rc6xqf81YaXOg==
X-Received: by 2002:a05:622a:a90b:b0:515:7d69:4c0a with SMTP id d75a77b69052e-516c54cdacamr16055651cf.2.1779352695399;
        Thu, 21 May 2026 01:38:15 -0700 (PDT)
X-Received: by 2002:a05:622a:a90b:b0:515:7d69:4c0a with SMTP id d75a77b69052e-516c54cdacamr16055371cf.2.1779352694912;
        Thu, 21 May 2026 01:38:14 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:38:14 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:46 +0200
Subject: [PATCH 23/23] driver core: platform: count references to all kinds
 of firmware nodes
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
Message-Id: <20260521-pdev-fwnode-ref-v1-23-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wJdZb8+vj1m+b+x+FZVXzS56tnroKpQQ8wlBgMpo8tk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQvywAOqGOhQtns88s4FBMXaMUo4jbwN9DyD
 kRRxvjg7imJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7ELwAKCRAFnS7L/zaE
 w4SGD/9+gwveQq+/mlMfCiUitFiJRq1flDEf0vJNh9aBWt149vNSL1T8VDY/lOW9NDE2gZ1k+MZ
 JdADhVpNlL4M9I8vqMk/LDuOM9lz0fB8NFhRkPH1xW4zmgtjdYwt+13FVlDs/IBQH/Hm7ckUoSG
 huJzETXgeWiXzfa1T7R2PdUfzVp+UKttU9KJ2EdakgnCyQt0lSOc+wM22TMQRMtX/mJW7CWw7QO
 sUVAv4Al0K4BK9tKQhdd1KUp4kJ4F5ZHrJeF91QGJdhdcRGQne3vkE+fkflalspO6rd+fnSCXaT
 dFaB7eD4PFEFbn7OiTETNfps8uMEF6sz7P/CYX2u7Fu/x9VHXGuLhHe05rMwNi4cND/uNbxsoyk
 kJb2aBlDNL+QlF0bKrv7s1K6Yqyr56o9gHv4tqjc5avOoTQbqhhJaEhONnXha8/kQUB5ye6tPel
 6AhL2jn2ZBKdNJRSbbS32aWWlLlMF6GnoUUBF3q4J7akrmXxbJNBoWUC/g4H/PM2b8QWJoSTDWx
 ObAX2bZ9TMgCFdvJDlPIZrQ/7RhHM4ySdHYIx34eebl0A8224pPJoOPzFkT5dvf7MTfHvmZsv5p
 Ayb19s0ChWVPXSppfxym2p/f8ro/874bWyD0S3JyVxkIeRz2d+Gpwqty4SNJ+8NJn95l8/hU4xg
 3BVRH8Q1h4ZSD4w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0ec478 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=2sGp0kyKjRk1obZUzdUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 3uy9FMkiw2NSv6rt-dSHGAazkgytjIq3
X-Proofpoint-ORIG-GUID: 3uy9FMkiw2NSv6rt-dSHGAazkgytjIq3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX9k/nYVsrFTdd
 Az5Zr/vFhI2tRaM5k54oZdp02FByXxc/dQN2GkU5qOH2m82L3344klfUjAfYug6QMWFEwF94Sde
 kG8RUZzd1uFlcW/A3RrVATtv57Ph3BgL7XudUtmjx66AWtd6dgLroGY06xo41zMpKtv8RJfvtcW
 fxNhSWX4Fxl2nrIPRdEtrImaS/u5uPvNTlG8qqYewajdWeghSPRJDZIJ2IYcLUAMz6ylzFS0A+d
 7CHP4HdKBWwQkSPCN/VVTpsHMcbXfKFLfDN2Cf9mz8L1etp6gEeYX8keHMAXGqEe+XlmUZqnLpk
 3IjP2U33ePsI/wc8PU5RCcMbrj/Nzbn5Z5l3NeShJwzuB9XuCZsV6j+1EiSYU/FBy8MqPTTGX6m
 fSO+xxfB7IkfxjZEmHfMMDmucAQsJzz174JkXOzWuOn4F/y2qZLG1wj6S/pypbqn7RwR2yxZTy7
 BHvOpJ08FajF8JT6Zhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

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
index b14f707f077bcc535fff9484d1ec904616d0a1d1..2a99162263e95f026830a437047dbf9fd347a27e 100644
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


