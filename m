Return-Path: <linuxppc-dev+bounces-23062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547D7C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:31:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpgyh700kz2yFc;
	Mon, 29 Jun 2026 19:31:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782725500;
	cv=none; b=EnyY9sK96Jp/JfxZFI+cz2Ls1ywL61f71RVIuhRIfavZegbVKUCRUOl8PWPanLGAXzqf3btrJZsuAAfdYNLG3bWYyDASJ8yfXMrJNbmptHAO+CdRFnNevGfYbFv5Z3/LqwwMM6fav4dC3jcuw/kxVfwbz3m0bIoIt8ME3FaHne5zathkONVcHeEmQBx5j4ofDnIoFlQFyasE7doUNFK3Fum/IZgAAHdOeh0IUPs0o3UHN0Gmjq1mh/UTn9yry/LMVAr7L/V7IjVEb+zfmFDVX7YcNWrBG7wJXbfQA/ar9SXTxDGNXlCPoEJWQH8tZQ1QuFs/OOgu5XDp68cbMo3dzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782725500; c=relaxed/relaxed;
	bh=v+4KHmmud2JbAIr0kznde3AKTH3HBGJUAAvtWZHpIWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmugBWJqunavssW/EzvodFknbf1ItBKuWXMS6BDpu7V77iW6tPu2DIVp6Y72P0Ol975U91lY5s3yem4zCLRMIu9GT+f/rusBlMI8Nyv/vggo0nQizErrrTPHfBidXT+Mclltveb5DOJpdI9SQoSPiUu6U5raWqI5dB+xu+ohgtWH37zI3j3VfyDCOXnhhojm8htaz6Xhij3/tLn0PcZcZGoajYhBg/mOOH5rviF7r4qdFyawS+wU/EYUv/dxk1xm0rbaeW2zGvChs5SOuysMYIjZ548vMAJ60o34lKTFf4WjZFLDLaSx19jOFq1JfjpfI3SlYWg8QyJL/TXE8xqS1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e49x9dge; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jPt5ZkJ/; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e49x9dge;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jPt5ZkJ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpgyh1fkjz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:31:39 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T90c8W2434546
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v+4KHmmud2JbAIr0kznde3AKTH3HBGJUAAvtWZHpIWY=; b=e49x9dgevQ3cG9iG
	Lkj/IXiDOCjyRPpFLYPYID7dhrpbk+iSA5taIkgY6Mlrk5ptpQhi2PCxrS++NyCr
	j7AIY+DUsDYgCvBLNbDdOX89qLG32+hXZcZDllrLWGMryBTHjnyqgNouP+DK9q8G
	A5+RTn3AlDL3xbGZEV7v4QPykHh9MOpwOzfBeycwCg/AQFQup+OivOuL5T2kudbr
	SR1C8Lsz7aiqSc1djzkUXOrSMEcAJgQgapxM6Hv0zohRVnHKFEus6/p/zWUMd9GZ
	NinwucbDLPW44K0sEoc/+mwMWA/J+LaGL4B5oMe1ojSSmc6BGaRJI4/cAH5OwyD4
	gQ7JYQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper21p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92158791d14so378907985a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724397; x=1783329197; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+4KHmmud2JbAIr0kznde3AKTH3HBGJUAAvtWZHpIWY=;
        b=jPt5ZkJ/kmFemAMUgYZy+RLLcULcNEAh7vxCAYG+7pKzQQszGxhAsuZ8B87ANFTXZk
         rtbJ70AvTRUJntTu7xsYHZvVbPr550DFYPjryM4X26j6GRd8cvpm2Id9Z3SfrA/x1+8f
         sCw4LFRuOLpJqPtYN04TLRNGCDxL6HrwYAjmhV1RIPRTh7C7STc2mpmXzdrBkC3w81OD
         khLabex6teTUBPKL3r1pojhkS8d7VZlLSENOC7lxHWEtdq3A1gm4pzVLr5F4acoN/pvs
         0buDrjtuFIvgF59scWq47n1xBJhJzRnkDvCA7lgMIfD7LY/qQceVVeduuxPqvLv2Yq2+
         pl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724397; x=1783329197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+4KHmmud2JbAIr0kznde3AKTH3HBGJUAAvtWZHpIWY=;
        b=XfkgHnmQHz17OgGPL0gAHHQFs3iIsuZAM5B5hvThO2mk1VWIIKZc04AFVHoc3xeHKh
         daepLVLYTmcojA8xmqkhJR4UJuNFfsjClbaX5SO/1aGNT3ir5ahpGV8dA8Iq30pBALkD
         uvYZRa12GFeGqJFaCHI79QDF7eVOLUayZTtNc4R0tc7lpAREqKtDp6s8zHc2M7CdPijk
         uLI8Q1iKadUXrEDAfXEP+qiGuoRtmOQZcP4E3o2AdJ0x4avOe8IW5ZoGWTubVrT206wA
         +rE8XTdQB4cyqK6R6sfa8TACiKTke0JY0l8Jq4NNjVdYqRFUrXwy/qB0P3hNc1hVE0Y5
         6CaA==
X-Forwarded-Encrypted: i=1; AFNElJ/9bRp3UZfuoYAbwjBP3c9FDC4F9yO90oUaqQqceNw581xJRM41/SYR7KQQLmEW1R2dmhlk8kwaukRyRKU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyofPUwACfmHolHi62FmKbgffvNDiaZiaXspuR1lUNjm5WLUVE5
	Qjcd5l4uCsn7lOpeYh1xIMR3w9gzWpBkMHu8+pa+rc2KhUYAgyZpYHN6mhPaaZm37SaOhjdb2VX
	Hgr5r7298niigqxwIHk5pbZzA/Fizg2bAKQx78jDmUtZ7logwknVf81oAokno1yZ+n2/g
X-Gm-Gg: AfdE7cn3vDUoJV61q4R32Rz+V0LKNGG1Dn+ZthKW//dKQ3/lFXUBbWnuYbh+BZpFHAB
	LAS1q0/zJLzkQypXhqWGJ5iWAueD4KmmUM1Zxmr9ZRtqFQlAynISPn5KSnkcHjZChaoHybshNVo
	JFGxpK4h4elAr473qcaKFUmAPX4l0ZHRWT3KQSEDV3OSUKUUPfW5npZct0SdKlQzCDl8ROq2skY
	JgcOPN91H658T+vy/Wy7UZpf0aC7cLC1y4gHKKN5dPF+ihfTgkjoWosmequB4I0Ae1jr9jftKuZ
	humnsQBRXXQZZarTPXaztFOmBx+ee8j3+/Si9NBrctrav2FoKoqDoUfc/78R4QbjSUsPvwrPOXw
	+dWm1conjv6/YNWy0gbAui07+IPVOxfzwgtKIxlzz
X-Received: by 2002:a05:620a:2601:b0:915:fad5:90a5 with SMTP id af79cd13be357-9293e5df82cmr2398875885a.54.1782724397483;
        Mon, 29 Jun 2026 02:13:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2601:b0:915:fad5:90a5 with SMTP id af79cd13be357-9293e5df82cmr2398869885a.54.1782724397008;
        Mon, 29 Jun 2026 02:13:17 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:29 +0200
Subject: [PATCH v2 06/19] powerpc/powermac: use
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
Message-Id: <20260629-pdev-fwnode-ref-v2-6-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ig8bPnwIF/mjSMvpWWcGdfQJeYqm2NUWFW1h+WHRo94=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcMDhYRt4vSVXRm8SXMUBqWTN4fu9NU0CYjk
 RvsANfN67iJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3DAAKCRAFnS7L/zaE
 w2NXD/9lRtVJg19v8VXQmSDry17OwgjxIADNStd90IU3BJymBaFn6uKZlSDyZNAN61Sv1vUpYbt
 gBiZxsoOwplweM8GutmD/BJ4zH6IEJMTok8pVeRaVr95QvimqKpAltLt7gILbF61IqVety3vnd1
 ij3JBKhpmDwxAakI65pteui/qIS4c+gzd4hTRcSMc6FP6wrIWgiA8PU4iQRn1O8jrO2fwKeIl0G
 g1X+9ujm60pPVnP2M0Hyk4UOS959i0RZuvrm5p6C6bsrc13KQmbqakL75sPmziGIKPRumLqWUCc
 ppKaIrOem114J+vdybIf2FJZbNg1RE4C+ZWaCjRdpimkp39y0fLLliI2lv7zGYEBvBnGgHglZ0H
 mE2dakd3ROg3q5D7/wKq7kzPGL9CuaHiniuR6jmAjxDDb/uLkQ2gSzR4LmrwyOrh2gMcRACavuO
 cAI/1JjBnuWS1rfCL3Av1cRlzGu7kl49WviXJV+CuP2Jt8roh9+0MyDDotAzxC6TP6k9C0iGw/Q
 HeTDr2r1C6sTpUzIoWxW0F2LlnG7VPkEfDmf/M09bcfa27HdRql+A54QzgbdrR3Y9gHdrDMQL9X
 Rdbqm4kG80vtQFKa8yhYV4YHJkNd+sPtTieuhhmR+XGDVwv15BymMtt4OytoRz6kns0PQy+M5Sm
 K9bZdIkgQUPvSxA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX+2oKf7NPDhu4
 AwlTUmcfeszagNTNZHW+0rARX9Vzff+ICwt2qh2f0bFNxXtSuLLwcSjmLWcs9eRBi2nvan1aCRE
 krqJg0IaaHyHrh3wIWYzIrxmUgq/t0VlsTF2OsjuVwbjs2xIgqd67sfuX0B1EwqJJXX6yShFWqx
 pZX8RNbO0D9Iva8pq1HutWxVPEWwwb5uVBfghsg58UDtFKIcEeA41+eUib7V6EB/yqJLX9K4I/y
 P1VW5XXxCm3x0TwI/G0Ch7lT4wdFq8kesp6gCRd2NcTw3sR5bNhfm7fIYAaEIQzw4b2lXk4mZek
 QuHFqwQAjFL28xisTejU6t/k+hUk+i+18O7ePs9acgOch0yghg/VJCbKa0JtXYOwN+TtCE/cjy1
 zSzepkh15qm/lmoboMIB0cb9EbgsX5eteuc4z0c+LERntl+pm+YvOu7RmtDuwYcQQL1cLMyULZp
 /iZKTLbf4hbZ8uyw65w==
X-Proofpoint-ORIG-GUID: U31of99I8xUqVMRkIBagoI4OUPFwJhvR
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a42372e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX5iILclnsXDVS
 L+oOpMIPZIB6G7yYP9aXtQqPGfM0xBKZq3oqkMSxk3DGaSLT6FVy+2S1oR8gjxiGvh3gDSXykz4
 xfREB1MkU9+ZQi7xhbPeKbmP1hNHXsM=
X-Proofpoint-GUID: U31of99I8xUqVMRkIBagoI4OUPFwJhvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 973f58771d9636605ed5d3e91b45008543b584d3..a175a32a222bab4cc7400f6ab6071f5630db2cb8 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
+		platform_device_set_of_node(bus->platform_dev, bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3


