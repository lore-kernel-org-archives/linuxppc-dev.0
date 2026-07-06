Return-Path: <linuxppc-dev+bounces-23626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E45C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:46:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3xS4t4Dz3bs2;
	Mon, 06 Jul 2026 22:45:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341948;
	cv=none; b=RiZ583dG5ORKWaSUJYfNOkanpNTd/J2+9Oa3Xjh8bdYxCiBcYa3lZgxll7mYRrAOjS/UMHJtA+DFwhHBWLjmnD3aY6iX40rIOsqZhQvcuO6/5OZlOBn+zsukYyq9LaxpkNp/hTbmCrX7L8uD7o3U2N699/SseFTp5ag0VeJsgc7FNPUpgr4CCWjMPHyy8CFGYJKY3O3JvXZPqyZzo+DTFcGqGq193CBgFc0eZr0sC7D+bLmSA6kwsYJhUvcjcTXfxza84LQ1OpLiaVq2k58u8wSFm1cJOnkfqw2ZCNbPKfIO+Zp7L438CtB5jxBqkoz6FhR8DAvCtHi4/Z4xFFUN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341948; c=relaxed/relaxed;
	bh=/bw1TBf3fi+dzITRL6JxlDKqLulHveM6zognFCNzexM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFFySPhU9d2jq5nGrjGJQvILSWhKqb8itKjaFsYaHXKEmCxKgfsuW3CVQri4y86q7RSm3r3cJNw1T3k8DiwJZAFcBJgxqFaUEAT1Q8hRgIaM0nzhrS8O3CrHTTdyVaw66/QMI1EjcFtakev6RQPxwLfi9M0L/xNdjEuAWZCPItfHQnSgpq70Icd+du1HC2S5K08/NW1E2oGZmPSWOdoXtXQfwdAsKryKQ9OMzzVpUGuCRk/EPRFW4whCYr5lkVYgklqXTmKcI4bzZiPTxOYyJmrrtOgVexUzkQGo+3g451vPkWuD9dabrkxSaLJuxJ+l60MVyzb2vEKaNYXwClerTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cAHAxf1K; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jycblrUj; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cAHAxf1K;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jycblrUj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3xS0G5yz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:47 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxFop401628
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/bw1TBf3fi+dzITRL6JxlDKqLulHveM6zognFCNzexM=; b=cAHAxf1KaFEH1dEa
	Zhonjd8lqW6rXiguep/wVXHJv97/js8xqR9yyptCdQVInJaPAnBHvZoEKVIGZG/E
	qgSF+FHGlGvU6aovk1R/J/uA0v2CPgen+Z9mAC3t8u33m12/GLMnDgxlwg3pE/nH
	zqY6fTyIULWXeaL6LLn37EhcKQ1K6A+edqKbz+9tIvAfqE02EV14oNcNACqTDRi2
	TM5LzVGESUu+nlBifs0+XJ++JRYAw5ohDvpImiOvmBdIDVK3k0geXaXXB8IvY8Vl
	pDe267XI9IoHGh6Y9KN2BD5bpYAi21o0zNNM7dzMsgizVN/2D2h5RThVAqtgzAKR
	eGj1ZQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3grm5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e52306621so213692185a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341945; x=1783946745; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bw1TBf3fi+dzITRL6JxlDKqLulHveM6zognFCNzexM=;
        b=jycblrUjcLASludP3ttj43Xym/eFCMXeb3enWyd7MHHWJvupRhli7KkOvAh7b+JXsL
         v0gNHcLIEiB1XxdDG6zUOSkj06+JMfJ8u0hgX1kfZXZQSJ3dwpR1vMugn/f4UuSO5HVJ
         LCxe8K5P+RV92n/mXggW3cv4chvOgyNbM56k9Zg6ihoeyrJxltYOqrNkUV0aKYgy/TlZ
         pcMSeY7F2SXTpCiiJMXYs9xU854TsMGwaQz9vOXe/n8NuFQ9JW/jqJ4sUJYuuzNx3lyn
         Y0NSSS6umftrwsqBnreA0bGnk3sMXFhFwwk2uM6OHsdlAK/+tUgVnA0fHHPl/ksfIFLx
         rWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341945; x=1783946745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/bw1TBf3fi+dzITRL6JxlDKqLulHveM6zognFCNzexM=;
        b=gkVkKxog2S+gz8m23+Q1tmSQV0jTAgWsSGfNmDGRjKyyJLxh2vo7ZXVvjxW3Dba9ii
         E1bH6lOtdhi+hjOEGe28ME9mwf8AbYPKUZxpqKt82RVzvFUV7ktTqNmK0gml3liQRbdC
         52Yao3if3wKDG4aUkdEhC+s0kCGbxQlcqah+2kmNFNv4u+SkthNf/ZXVf1vWqCGWhrdt
         bebwH7nURnms7fitQR/ptnRPCGQRj3DCB/Pm9jDaLg3xSBrDBBlbY5yL5fwRc2x+57yF
         10jUIKME7rm8NtrSQuCBEoONgEgWhJ+NXrBQTY+nMemE+bTNMqNagJDSe8XMgMIiiSn2
         EKkw==
X-Forwarded-Encrypted: i=1; AHgh+RpdGCP/U21avfOHOF8QDYHywaimlQgwE9ihFbr2O3eMXtcUBNpBcGsgLTKTiZn8thMCfdRG8b5u6AjFzEQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFR5XW7yih2Tt9Mk4M1YN214IQ14CBen1nyh5QEZP86h9qjQbt
	FbRBK+T930F7FRhYRuX1Y3LoujQDqBxRZn6WauyzdmtVtdLPx/X9EbF5mIv9zGFK4NiJKtmANaD
	gyH4gMORkpT9XOB+hsB6ihbH0Uf+N4JKvea5UzEUKatakrVsD97JEa0/zoyLsyIuzFxHS
X-Gm-Gg: AfdE7ckG0GZsuc4aFvb1bQfPgCB+Tbe0Bq4xEp2jFF+/GWDM5+GXpf5+mJOQZHh07Va
	YhciNPNzPWWnzmZhXZYsNpfDG3kpKSPU6oTlHWDh0sqCR1gTjM1hCzbPSSGgOZQHQx86DJLdexv
	OOI7GTL6mj+MS5Qn2ADl0UWsOxmiTY9h2CDk9/yIi0jiKPY0ACX18xrWaAhbX2KH+V1+LHAYGtE
	f67GA52EheI4/JdQRTJhoYAWZ3xRPdwlN9FcRpLZjpykv6Pofos9d0TYe1UQ9yUMhV2BM6e8SJ2
	bZEt6qCs00O9dkXKB+3Kcebh4TRUntv9uwVLymg7+ePqIXaeFFbpLwsXDJT09teziOxaDJr0j2v
	+3NVzR7PqhwDUor3UXGRn91CULHI7nv/tK0lEuPh8
X-Received: by 2002:a05:620a:1a19:b0:92b:7420:bd5c with SMTP id af79cd13be357-92ebb49abf2mr55500885a.5.1783341945023;
        Mon, 06 Jul 2026 05:45:45 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:92b:7420:bd5c with SMTP id af79cd13be357-92ebb49abf2mr55493985a.5.1783341944411;
        Mon, 06 Jul 2026 05:45:44 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:30 +0200
Subject: [PATCH v3 18/20] usb: musb: use
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
Message-Id: <20260706-pdev-fwnode-ref-v3-18-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=XyyiviFbpKDvWYZ20ZXbahVi66ptZuiXaKVx5fy/wOE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M8unH/9uMVuERAbDU7JQgdVNpF477whb/qV
 h2sU1vkV0eJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujPAAKCRAFnS7L/zaE
 w3ASD/917v/2dp9sMu0sQ8gKP5j4d3vmNIIb1xOTgzEHqv0OsHo3Lb9hyL7cLuo7aJkCdKEhLC+
 tyJ8mOcyTKIzMIjnNz7P46mrgIH/Ez2a8MsJaJNtUn2vm/TdGDsp6oD0Z27+aqXvIIBJ1x982k9
 tYW1zaY82nmZD4doBZESwvmet+CCcH4uFFNRXKjknczQUi4PR2ati7XYXfrvn2JAvTNfnOxiFXu
 +SrK4u+NByEBmygBJuoyXbcpqkhQ09hZTQeyT+0mwp4oX468xnNL3RXSyFpg3qy9EUoDtozrmej
 1/cpGxHdGtr++fX6VPEA7p4WO/hAcEgCd5MjXs2Yrc2PMwYDQivAniA5hYQofIrg5nZQKJmLY9F
 QNE9IhjwU2eo8lhVzgaG70/sH3LAdFOXIcZgF0m8xyobA/nfvsy2ZISzyb6muZr016il2N5Sk+r
 r5qk3BMaeykc+A5j6xoNzT5gz+bPiK3MPqOyAq6iir97S7ZSS+X/+jwqd7uHtBp2xLe7bxNAHQk
 N+3c/OzFA1YPhT67cX60BoP9wwOAw3IRlBD23N8m1G8nEzViIeMSygW12u1/EWimFokxYzbDni6
 pz5ci1zOxl74U6f0ojOB2Tsdx5nRwx125VBcJdikdRrs0oLWZAgJnw7SnYRMJAAW4u4FC5vZxEw
 bhsT20MM2rZ7M7w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: _6JWVh5KmZk1VXbuKqMvbY9muZRWej2t
X-Proofpoint-ORIG-GUID: _6JWVh5KmZk1VXbuKqMvbY9muZRWej2t
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4ba37a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=ndL-XpQVcrS1Utx7N0IA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX3sRZ1PszIERU
 AUNnsjAUULTwNCWhUPAfneKno1QRGIHIav0WWslX//dc3X4nd3an6p3GmDpuRq9IJZLvBZ/WHDD
 fftFFQz579E7I8MLaU2/b2aqXsPNWURCoN+RPRQ8H4M4zgLAaRqpkhKNpki4N0YoE8+v/sN9yP2
 /A+u+/1UvS3dM0R/8GRp+YyLLBCnSFyRk9xqjkgcOcjjvYnkpPSbo8tJYebZZ4vq6QGnOtQYHE0
 p89dwtiVnwvMNRx7gHTQv9/jhoyjATxMrINneU0aEE2uq6lxpwZ6gdXgE7/NiWKxd8XP18iX4Be
 KHnorHXDNlLG57rqWQOpPTqidJnZI8Wc0zkxtwQ8w3+Y4HrIhUTailmT6Pc/BEvAz5X8yCpItEb
 7boK8YjW0yEBp9/mB28y2MryFYNR9Kla27D0laZN2MGuYHNNjH+Hu+Ecmziy3juycupLlyOyHjs
 I9kSvHT+7S0vwW1b0Qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX1Yk8UVhyCV23
 AKYXDUb0JEM8cRnX/PxOGI4HPuHjyBMJCFbVTlfFTSq6Oco760O1vn1cNLkmyQSPXFAijhSyl0j
 GmeVsodQdUSAlE0yd2x5qe6gSW96qAM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/musb/jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index df56c972986f7c4f5174a227f35c7e1ac9afa7ca..c770ba576f05b6b672836753cd9b696b752d017a 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -273,7 +273,7 @@ static int jz4740_probe(struct platform_device *pdev)
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
-	device_set_of_node_from_dev(&musb->dev, dev);
+	platform_device_set_of_node_from_dev(musb, dev);
 
 	glue->pdev			= musb;
 	glue->clk			= clk;

-- 
2.47.3


