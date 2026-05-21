Return-Path: <linuxppc-dev+bounces-21300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28858CD5BAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:38:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhcd1Q6Yz3c7R;
	Thu, 21 May 2026 18:37:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352673;
	cv=none; b=kI9Ix7Ug9MWhKz85SSQ48j0R2nnf1j6lddcIQc6uXH8Fk6xXjyuVP24f81SfYTpUWiooyU3tL4Gqfym/S26db7woZwniXCnNzEbaqkMcIIZt8ooMfeCf04CJW9iutIg5fubidIOhCoSO8vajKsUfqvUY3zTQAetmzOoX4LV7HPrQ14pBQJxsvg0Q2qN0pPvnulBHPqrsk9tDRYaCiPf/Fp7KGyF0lIifaPAqcwD2FnDSoEo4vwAehrfeqCAMOzOWPbk+PTyG89HsNM+ytqZeOVis1/cO3nG6bsnjUkJk7GGjZKoNmJuBIWYC+nJS4WUrjWSyzUJcwsiSllGM0n5jMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352673; c=relaxed/relaxed;
	bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+h/ERIf50nPqdKEuCdQ27YgjTXwXtqlRa6JCpoVn6/z1yv2z078454XQSaNXUg9bDQ4nKBDLfgOHxaR/I/FK8iF1v9M9RcaXjmcid/dGrQNCym8KERjW3Vj1WtqrMWSPDmtt4MzeVUMLgCzy/mhY5ofOu5NhShKGsqXuUtEXpV3i8AILmNuXEZRhNJxhd5SAX3ydNoipAIMoyHR//HNlzRDoa9IQrjugLwhot/EhXKTbgThobqY1uy2Ojl7qp1GTMUKs85z+DE0L4OUx2MMy8ztkcLvEZG1SupDIl2OTJOOR+qGWiPYy6ny0sLY6z5XRapEwrshA0EFJpnGnUK2Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U38oypav; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Du6+P7wx; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U38oypav;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Du6+P7wx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhcc4g3Yz3c5q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:52 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6rJhS3680313
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=; b=U38oypavBMQHX5RM
	5DGo6FDgcziIR+bFjcD66h11aj4Zak1nBWnsmmy4BL0uNyqk4OOoDi8VlViPoqNz
	gcwUjAXUut08G0bW+Jku6vIOsM7mx3MUO9LbNdjuEZdKCkz3D78xRbBA3XGVKW1N
	+EU8lo1LerY6ObmfBqMRLu64nJzLgMwhgfJh3ZiTCZU2WGPZ8qbTCCKXTru3SBCm
	tmaKbCMYgNpPkycbfHHImPSC1aF1Jexy47T8eyH109lN+2ndPMR1gjwtHffYbIcm
	bX7/IKe7UXVgnq7l0bzp1rMYGM4p3cB0TM4ANHgxZM2WX3OtuoEDEOEn+WBO0Lna
	hdw/gA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j411t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516cdd89225so294161cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352670; x=1779957470; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
        b=Du6+P7wxdEECYYMc22RpL0yIFSUTXKMwDUvwy3NbtFSJOuaf2j6i82Le2f4shHCVLi
         5yWNxv0AiYbxSKdV609UQ6P+8aD7+y6HwzYXecfsxJ5iNda4zeDdznL2DdQ+HPHPZS69
         0nCEGv6ffhvu/SMqQ6kl2QCzk4KrMtmblg2xGn1QgDY0KCAzQAC7QXy4HmGobntqkr48
         VHcv8saIVeyt01qazTMXqTNChlJzhd3iP2tc3hahHfcn/+SEazhUb5L68gDgJ37wWFxE
         4H4nm9lAX2E0vvoFkD5Bfd1G82j5gZ4SEOZ7KmIHMWdYFUGyp77g/NZL9/6zaaK/fMFX
         EaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352670; x=1779957470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
        b=S+z8fiTB/ih8WZJYHLPEMfXTdmQhPAxbMeo6d9f1M3kpIKdTYBswICkhV5G734Gc/o
         GW8visM9wniwGXRNPlYRPmNpW78pCUsdKXIEVFR48lI1TWQX16PVHu9kMRaXboPDfHsC
         3W9+p7kRfRpHEOrT7UBfCkj6uiFA1QAwwduyp4LcDp2CBmWEz7iTJCSw4+Ug/UGssu/m
         BNLQxTda/Z/WZZ8u0QVYrIHC5Stq6kVNNXpkutMep0HbHeJrc7oLOF4tCCl4wwjv6K29
         jHnwrLUMirMr9vymbYWlZ6sW8BiRaFyeeb28+7IWPBQmsLXtOyTj5aKybAGAyfr/v3Np
         Y9ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dfhLztHEB+2TlyRHsceNYC+YT6SdnuVoR9nTc/fMaUk/DgUQaavIJ/f2LsGZuzeAMSTGXDW4ZAtAj/tk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzTXoutEdehMqC/0gZi4RdGmyIJ8rC44J4EmvUSH0D1uF+MrgI
	XCM/ArGR6lsHbog3blcB28xCiwk+ahvQ82YqUhuz+vqGCMhd7k45P0IkUOA0wFbseuTmBov4r3W
	GK71A4IwRyNzpJ+dyTR8fpp2kA7I62/PcgIC2G/SCBflMiHcVUlEXUJ2kksyjW2sWfpWW
X-Gm-Gg: Acq92OHn6WXwLjidIm3faFV+TZO7kQv+GMHCJoMU+fuzB6nbcC1OydO8Pm7eaZldiie
	baaC2BSvVDhFHJ1pDBCA2bVxZgwhiIT4jrmAiWON3NikSbnwNLeoqho0wC7D01KFhGD2coovlr8
	EvY+gs/IDmrG1C5je3eYP2Cty6VeEzu4xISBsa8ZKk1tHeIRoohl+cyCMhX/upOMTQItnRo7MtG
	pKyNiRddZMw4Pon38SiJXUSfqFESOG/5Y7Pq8Z8G0cH3oNGSfCgHRR4T9UF2cTZ5Zsab2m7KoyI
	qZW3KdFgNG4Zpv7GiU0bTvyV+kbk4LJ71hpCbT032mnTTGW52V1QnkdwfGLXyirNyvl0iWlzTel
	x+Wjay61HnCxUhMfoQtyTyg8H7N3MX+gzEqtJfA5el9qq3nV8W4A=
X-Received: by 2002:a05:622a:4a8b:b0:50d:7f66:dca with SMTP id d75a77b69052e-516c559259cmr24616571cf.33.1779352669719;
        Thu, 21 May 2026 01:37:49 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8b:b0:50d:7f66:dca with SMTP id d75a77b69052e-516c559259cmr24615921cf.33.1779352669133;
        Thu, 21 May 2026 01:37:49 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:37 +0200
Subject: [PATCH 14/23] pmdomain: imx: use platform_device_set_of_node()
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
Message-Id: <20260521-pdev-fwnode-ref-v1-14-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1m0AW2cExEyKezaoaqpg9M8Sd9W7xIah4eoQaNoNaio=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQpYiqSx3VXdqiHIpIBUXjGa5jIwrjLGwoyq
 Gc54yDrEJyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKQAKCRAFnS7L/zaE
 w87wD/4ovbkfGrByBExY1MPjO+ImreTVfGSAkWmqsKw88uLrhkyEKGHDAQSZTZE3i+FHGY/E2yW
 vuQTwIIwn0C7jebh/ZrW5OyqlKI4SfaTV8SUVza9v/w9itsoAjqdwFfTCAYtkNU0wl3z6zPIVZW
 eC5a4J3DiTbAuwujwfo0CkVMKKHGy6dNnhLhd3c5wk59h91vvRJDexswgzczEKYHYVvQ5PwEm4e
 1v1iYFCMc+jXWVLyMZMWL3qxn2LKbLI3uzw2KaE5pLc6qjG7WxuULz1fW5kc1tPHEt2UjXdtXoB
 Bu7Z+OiX94cgaD4jcN5Qf59TAYUWoTBWptl6Az7wCYIDSl4Zd4dfb/jPCgTBcEaoQMRxdT7wBp6
 04C+yAy6ZZFgQPV6NKQYtrhr10zYyMFhXjVosvUBV+a6Ji0EiFri1X1eKbRIDWPoxE/pW/NgzA2
 EIK/OJH+xDImj3AWv689ACL46miN6U4MXZhQgeeo20WrtwVz6rOsNHISp9VfDNfODARqNyRDH4y
 gYdC059xHRA7PTGRRZGWyRdRrxEDYxRds5O0j5sxjShEOV3/CBXZC7cr7dJk55o60cuiR1C1RSD
 DTE3n/guGYAoDroJBWU9vFEHo/tJTqZkDlWp9VK5ukHDUrBufG9yMNLg0PxfB2qf+8O/s29Yr1k
 PBNeRIDE8C5ssiQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0ec45e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=J9-S39C9qTGxOfEZqScA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: XE1rFDg62pAp10kN1NDH0hC_a9bPEqc1
X-Proofpoint-ORIG-GUID: XE1rFDg62pAp10kN1NDH0hC_a9bPEqc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfXzdE8GC0qhOUF
 THUW1j2xbB7BL6/wnLMfAkn6plpjjTD7hgsaKC/SwQEVK4ijX33QDCzkP3g/jf3qEXX5U9JHby1
 qGnBNWEiXlg21fXckPvEcXZ1WvDw7/nPQCXS5iDkdQnVa9kM1aalP5V1lXM1FVoyXnk0iDncbMg
 0WD9ojH47opCtSssNnxp+xZ2pKgVZjoUXH6SMAseqADPIifwqrjdbN3KFuTNXwRTqfuo8+bGgOn
 EW9uvC5TJfIkiCevShOyDPAxwzQx1v1y1DOVuRh+q7yWVyxcUE20DnjyOz6a1DVIyM3RjoEKw04
 eqda/zswXawFgH6zxashfuGdHFcPUtIGe+cIi3LfEa0IH1hX8rlc6aG1kZJYPz08Zj1s6ADJKyG
 00ieXOAuLHtHNs6Egf4tok3IOD2DOqxAVsDkwAm5xYcSvP3iXElNHIVxg0OcJpYzpSmEJSBARo8
 WWb2lqlkuGqkeGO0ZOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pmdomain/imx/gpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 42e50c9b4fb9ffb96a20a462d4eb5168942a893c..abca5f449a226fbae4213926e1395c413160c950 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
 			pd_pdev->dev.parent = &pdev->dev;
-			pd_pdev->dev.of_node = of_node_get(np);
-			pd_pdev->dev.fwnode = of_fwnode_handle(np);
+			platform_device_set_of_node(pd_pdev, np);
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {

-- 
2.47.3


