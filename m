Return-Path: <linuxppc-dev+bounces-21303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD74CD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:39:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhcn37mgz3bq4;
	Thu, 21 May 2026 18:38:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352681;
	cv=none; b=U3u9Sqj+QP//LbuS7efi7T3Jl2LsRANEQ0igeKcF79wIaUYzOumLxcaKybrw6MKnbNSVSbmBa+MUASjbBqk4BJ4tqcB1uZmeCrE9AKl5Gh+X09nM03cPgMC0m/TN7miDX1c1zbXG9SYccTQN80gCRCh4jY4smqGwxxWvPuN/ON+xWOxJYQz3TyCThgQtmyEu4FMywPD1JyjjM0X/h13eN9t3DKxmx3CVh3mM2R0x5UHr2DPHiFK8Tydbkyw2oOatplAuwRPKYps6/oKCGv5pxzE4GU4OLBV1RnG7AFBTUEPrTTz+17UxbsWz2vnMWr+g6/qCkBsgu7eTjPEZQwMmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352681; c=relaxed/relaxed;
	bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqLnxKnle3S3JrOS/WD2rL3XtSmIhRTC1ueSZGI0oxr1axMaejmnfe37FN+XXnRufBaPeXC1tEQeAqdaI9V8OcQRR/7O6znNlrlA3sCsJa6UfT116OYrdrPd0IJL/OxRvYPcPVCOKIVZAY2ic/IQI+JijNz3vVOQcLRTqKEtjYU/H55xG6dZ+LRt345wEFNsv/OHyXrw+VgLHe7oMcAGSlzJ+4SJOAQkq9BS/4hLmUnaiTavc0hlHeF2zuBRJKSN/iD2WFqebPc0D7C4cUEt5BXjVzCvM9Vgo8RsVpvqAZO2rxc8H4FRzgx3jjdYilk+aCXcgITonG15FmwxRcO5aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SWGFOeBT; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JloUiPgw; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SWGFOeBT;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JloUiPgw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhcm466Dz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:38:00 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L75BP63680286
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=; b=SWGFOeBToZLVCsfU
	AclGf01G3MMPajCTFPa2NbUKgtwHkcfo05wNMqK4mTngoJ19FiVJSJIsdmlsLRnF
	UTS5hflujNJKf+GLZUpXTmOIOODszeTUyzkDYH5lRyVCjrv8biyMBvDqKnyA6cUR
	B1MwZVtqtJ6ZQ5C8cKyWqtOFfriRbCIjY8sk/YdMjRplzi0eIV02XDAf9o+Mk7wt
	ypK1ptckarndPVVFRuQSzrpXfrh5JQ33mIO7EOBPTfQ409d6ZU+TxnRun3zbhUrI
	SbkBDVuhVva/nx4/w3KeLBtmaXLN1johEvs4uv4afYTH0Umf4ApQvWJmlzn0q0gL
	Clt9eQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j4133-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d8e8c47a3so29688421cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352678; x=1779957478; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
        b=JloUiPgwIbnOtBeDqIBGIMPszxP2pZrTONZxq1zuKle/+K/E3ygjvUdBIczG+sqEib
         ng07bJ5+gbY5ZgxISLyGDLuYZan7S1U+nGDGJc67xDShHqIfQ69v4SZIxZaywR+5vsVw
         SCzifI0Bu6Vom0aEhTtdkqwqEr3/5Gb5gQoEgs7ZIcAhAVkU1bx0K75/3DE/ZaHdzHyk
         b0tAGinlKP1ERgg/p/ppAD8E5pP64lXKlGzjDJw1h8tcLtN5DdJAs+MkeGI5H1M4YNBJ
         b2uey3I0royD7MfMgOpaau6srbtMTB4K7uvBG5HP8r30S397i7GApSOPFXUfGZr7heRX
         mE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352678; x=1779957478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
        b=lnh7m6tmN7CYwK8yPfGSlRkQ3az5kq0skuVRmkasZw4nLgUVA6KcVUqDU9hiS7AThJ
         UquD3/cKaguaUpb5pgb0lG5Ee8Orlw5uK59xZ7UHUpEl1SEI3YjoDOnpqHADlXTMgx6s
         9s+r6nhbLKjRjyEhy3NG0zr8ZDsTlr8WW9WW2H1fpdNCfh+bFYjf+SEe8rjgxJ4+PaH3
         IqtxoH0a8K64EWM6iq0Lh14tyqhhMT+TgIbEmDBz6dmgTDHiuJ+4zUjmVTHvqeAQ4Zrg
         2lSuuV9LOVCzpWb44dKcjtBejV7tKQxChV0CsRrlcrt1pyVzZAkn38ysNSWHCE8rIY1a
         9EPA==
X-Forwarded-Encrypted: i=1; AFNElJ9+CSizWE3KMcZDEhN1Wy+LFJBRijSnSDG7iyvPB0HePONI9k0w86Wby4uVdPHwWo7qfuwe8pg4NVxGR08=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwrmNLCV2AP7nN2m/Ft4MR/iidxCSOUyYeI0RP2CVMANEKNBB7s
	SswVziFtAJWnvYI75oRtMcaYL7fVH7W9oJ/3bCjJpM5R2XoY0IS+hgRe63qSMY45W8aygZwKt7K
	rzXHrHu2ZlLk4gz5z+jApt+gSvh/NqGqr4WPGf9QP0LDyQ/PRgNLBB3KhUQNqfe3g6doo
X-Gm-Gg: Acq92OHJZqCLeM4y8TL1HuAdJlBz75+aNkYWEj/nUz3LjqAZGGoB+BpTZZRkrBXmgwq
	PDwdLeLw65YVJ4ACwi033L0nXRmSyUBdFrTEedjmmmUghr28mqzntf99sp2JK5rZk54DkNwSaWw
	7qUky8ajr2O1RvIXkXSrkOzoIlEiCSgzve21RSrMbvfbaxyrDCSiGAX4vmoHDAgGfg8+tnZenTC
	IidtkNeT4fwSkZuwPlmWhHVvclI+m13psDO/Tf9fBA2D3DiaY4RstPzFFFEtNxZK3S5fKMiuRC0
	wiN9FUUYWuYSyF1FYK/wsKDnCK3p7nNYMHBN5G8ebHDze4MEYBr2GIv5bF+aJsg4P10W9w9kEcB
	9aKK9LhUNO7/spwmlSS4dezG84NgMs04OTYDHFLqyEe1rpx3mOfY=
X-Received: by 2002:a05:622a:95:b0:513:103d:3808 with SMTP id d75a77b69052e-516c545476dmr26297141cf.22.1779352677898;
        Thu, 21 May 2026 01:37:57 -0700 (PDT)
X-Received: by 2002:a05:622a:95:b0:513:103d:3808 with SMTP id d75a77b69052e-516c545476dmr26296871cf.22.1779352677380;
        Thu, 21 May 2026 01:37:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:40 +0200
Subject: [PATCH 17/23] net: mv643xx: use platform_device_set_of_node()
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
Message-Id: <20260521-pdev-fwnode-ref-v1-17-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+Q36/R3+axSk26qNg0RKgcggtmrfBcF0QjetixEKu48=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQr7v0D29hL0tmocOaZkm4AyCQrEw14ql7mO
 8tYfriVLeyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKwAKCRAFnS7L/zaE
 w366D/4v5c+pUzv6avtkL6q+xKqdBL9umLghKhBQ5kt5mjMgzYly3eyiiCgjeCEwSWWdfTYN6t8
 MDk5oxdf4dZTDqe/p0EFtWy4qVPnsfckF5Mgtv2EfrFY/JmTxCrEMhvKl6MDM4OJriNxylX3tbW
 pqSlkS5Mjcx2c79ZfHLJ4QNgy63fKtrYEP8jXkM/bO+zd0VvWHV6OJgGTp1uNfEKKD7Zv6W9jXs
 I7NhKYZRcZud8P5CCUTX8ofTjAVM6BslN8K1m+1TLzAyAQoFdnTaP33aW6oTG8rsJsFtPqJ3QUy
 wl7xZWHSGDbNFObyxHawwwedXKh8ziJ5AlEss80+ejJ7Cuj4qI5W8oSo8Wwb4/vbNVIzFAn+uyH
 zmH7uZ29ujLcnvmBxqZIGFKjQiaMTKwjmXQIqwL9bFwKLahbDsLpo0+FNGfYHYmkqwz6KIUrLh/
 4dRzbuYGCsoGuw0Oql6O23EQLf/YjisobOJzrHLLyRC6qvueCdjZm4rjiIfBL/l3WA9rNztpXgA
 591GvrhcF2BWHdz40g9Fm376D5h1+nFi/hxT753Yk4qZ5tHoInYYJt67skgbVjixR21R4P3G1VO
 BNHf9MuUxDhXR8xWiil5e2yLVNEpIh/547GqRXAJOq2vGoV9XerYZFXgnsgia4YoruDBFHM9Hcc
 iFPMjG1LS8Y1p9w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0ec466 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=deS-VIKRvcGxR6069T0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: c2-VH5OWgrtj69XW8m7_nAyCLgBAUymT
X-Proofpoint-ORIG-GUID: c2-VH5OWgrtj69XW8m7_nAyCLgBAUymT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfXwr1caqXLoaF5
 6AgdytEdLvs4S4rFoUDI8I3ezU2pk5zME6Uil7TfFSLf76Ut5Gdr9KnEB4ObQDqk/cbwS3I3wB4
 HnOG0n1iJcI6boNQb/rky1weKd5ODp+h8kXUdVCvIaVyvLWh9audREWuB5SfWrN0oozvHbYt3+J
 LFqzF9lTEnvcEwUSO4EkHiGu81pgstE9S3Wyz+79n8jl+++FHTkfZRgh45miYug6SbRWOCcVL79
 hBffiZrnJcms7yBiRmbvNfi9VZysdT57ZI/9buwKPWuKEipa636YoQGF2VdlDjEN2OQidEfA01D
 jz7+M8mp02+eIvHHhaPZ3g7SwuJ91Q57X49wIACRoTzJvCviahxTxr8klVwPzq4o8kF3cMG6zkB
 aYj4+s65q4Y6zwKbQ1/N4K4KyeERqQyu/0UYWmBe7IS6ujOazb37VrvO9U60lcri/KvJHjNW3Np
 E3jpP57zUxmmaxCn11g==
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
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 1881583be5ce2e972fceb14c2b8348280c49ad1d..9caa1e47c174c9d7a161b7f2e2ee12a829b813d4 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = of_node_get(pnp);
+	platform_device_set_of_node(ppdev, pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3


