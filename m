Return-Path: <linuxppc-dev+bounces-23067-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BEDC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:42:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphCX1qJRz2ygg;
	Mon, 29 Jun 2026 19:42:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726168;
	cv=none; b=fp/oTSTSCEqa6g7dKcMSE97MMT46xjYFgV2jHpsMsF2Bp8wf2L+r5sDch6wf9uWUyFm+hdvXd+MPTAmd0BxxPh20bf4/dA4A4iOc2Ce8ABd/4LkVA5GDdRyduKGUPaj9XP40sjY38lCVAaDhFq209I6BQEvqRWLSjXvmnnvS5Gi+3y5EXH+0PID5lZMD4JdxrHXiTi6lLzS+RzU6zbi0Mj6YUhUyqEZM56qOlpkZXRxFZvp8azPfj4/0IZOs49CyrvpU1baoySS/CyLX08vkPEdkTDfxfIyDJxqHQieQ/+yENxzEkABXIL7X+UI0b2difTYoY611gAhKqeg4bzzzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726168; c=relaxed/relaxed;
	bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mabtv8i+yDOgWCXj7v4hZOiKmbIcnGgkwSJp772+VRhZxbiT636R6g/LcUuZ8wYEOzK5FlHgTmat7OgvA6KyAW+cViah7l1xjGNk4wS4fQ/Qv7COz8oEnXIRaN/LHQPkw15GQB82j1ksvKS1bk/JNr2ZccbjccDj5qljORkliQWAEE6eCchiSihPgfeOZ84hpcSQ7k3VsONcmatuuSGg45/yB+wHxM8s5OAULTIcgQwqi3xD7ICp0o4ckGGq5ma9zGSUkKqWdq3P3fCWMVk9ZGzsWCPKIPflK5WShcoJ+Snoq+iEFDQ/8U8bbEo8CY3w0pJ3MizloLorg7CsaO/B0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IxATTOPD; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gKmVHcQq; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IxATTOPD;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gKmVHcQq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphCW4zbHz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:42:47 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8O7et2348330
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=; b=IxATTOPDsNWfM1w5
	9Lm2bZKmIqww2ual7Bo/WyUgK8HyaoF2qRAFIIopreJj2AvB/0rKOsvctFyIzuAW
	9JgB9/LsEBbIHOzfl+qNj5Q4p/TQObb/sILpwFHUfFDmeWKzRtQaMeCxrullAV9v
	RCAxZix9ZCKbdU/Zo5xq3OS6SQHSMXAb7Kq7xRAfzwNcskEBWXWtwsGxKF3OJHWZ
	wkGCy7pdqhNt/zo3AeqZeknkyQ0XliC3BX/ne5a9fH9EmaBoCLSIY6MUqqCS/XQs
	pLLcqWrmMpggVrZcksC0P/pR9TxyRlxaYj2xxnXRYVHQrrSwEKT5u3tTFnw/3s9u
	WmCNnA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s07dg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92b797ce02bso558450585a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724407; x=1783329207; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
        b=gKmVHcQq9dukHV+eElvXEkyNcSFe/cbw20fROvZtreQimPLZlpsXbYs4rHBwpApjKy
         FmijuEJr0LoRKWUas5m/zl+fMj7UyNHFdLkoe43oaHbnNeM01h+ZlBVVEitZKWLMCRUl
         13KcxrTNkfEFCTIzo+pT4ThdfGAE5QTASDAWeBmgT2bLcKRFcHXyRJs1YPbRvcRUmoPB
         pAos/pFfw0ZoGhUw4ZLix57wZ7BHrQSiaGN2gVB3/qnGntJJIJfiLr4Fnhieu+eGAYV+
         NYCnLo/LyIQFSN+M2ywMMHgeEOmqX60sizKQD3Ow6RhljvbWgcgigHD9jhrOPD8RHwf2
         kA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724407; x=1783329207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
        b=Ll/Y7pQlVmjHCCgso7wy/S669Joqyb5sU4AQXbmcv0z7UtlDy4gtge6dFkflXbeKJo
         7w4bM9P+hJDFKAcGaHz1mVAmHXEbda+pFeIO0lUtgvVyvgBB+K5IosFmc8qsCzmjDdvS
         +fcKIwDHZRyXLoCnsLIYysGFK+ehafK05KvXEGhGhqjIKIeXV02Lo/IWkLPu74kdgmg8
         mt3xon4VRuBw2k9aBO6gLVUHgWkLzDSVRAWYV91o4sZ9B7qdPmUiSwZUN7bIi6yJSla6
         xW3NDsup/I/2eMqOs7TY+d3ydw03tLOEbWAxPO8CVTTbHbvA+eBvkzNP53FnlP/ONSPY
         ejSg==
X-Forwarded-Encrypted: i=1; AFNElJ9MSHl6zjydnZ6RXciEdtvAApkA6TashBej+Ead9GvbvKiq1zZPJfyg4w6rkGUmYDm4jZq848uA78gBX0k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKeJz8GKAR3eBxscxnECFsMSt3neqKtOPyWlm18O1SrBIwqVMC
	VfSrnXJY275G3WwAKFZdFW3idi30Q4K4DM3St7exL0k3x726Nxm1vFMR7GyEhw5DHgA+MEgDpJA
	OhdeDGIjFtV+ByLwqT8AqXHXYUo6BhdicXP+kycWIJys6S/+fBDGiqnuzVBtfOEWTBKeb
X-Gm-Gg: AfdE7clMRU3rf4zt2dWhBIAB7vlKHBwUJHN5zNpa53Hsc3tDjHSj/pC3qPvQVlGayoc
	fch5w/yG0ddZYZjxhzNESZduJ/naGCXMrEbp9nICGcpYQVqVQNZ8QJ59aQtgWzS2qGNghuOQjK8
	BRDgRm2PoPOf2e9gCkhaevUfz0iU4GW5WF6oNQ5XvGNWJxbRsjAR1fgxYqNEitFPpVaLZgfFF0N
	WGzf4FHXbJhgemH993Ug7rkmuQoTcR1Ycwb/Q5SUHffgMaI41q/p/8Is5jeKWUnPPYcs+yIyxfr
	kc06lo5Tug3tBop+9b6g/59XiKwgT7CGNiIh729JYkF9zjg6P3jhkRmfSwb+Oc/4Jk2DguXIiaB
	/YnZ1WmY7AgL2kVT2liev42ASxsULRqktzdQ+cawF
X-Received: by 2002:a05:620a:2611:b0:92e:5554:a80e with SMTP id af79cd13be357-92e5554ade6mr210126685a.39.1782724406654;
        Mon, 29 Jun 2026 02:13:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2611:b0:92e:5554:a80e with SMTP id af79cd13be357-92e5554ade6mr210119985a.39.1782724406150;
        Mon, 29 Jun 2026 02:13:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:25 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:32 +0200
Subject: [PATCH v2 09/19] net: bcmgenet: use platform_device_set_of_node()
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
Message-Id: <20260629-pdev-fwnode-ref-v2-9-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6OXt4TN+oyzNJeMucuDRbXfo0ddns7kCLrcZYoYbhVE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcPi8u6RDiDExgcO0jHLU6ko4GFAYWUMb1Ut
 WtM6/fX5P6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3DwAKCRAFnS7L/zaE
 w8RYD/46lV+0Hzns8J26Syo44iocOUu05qY2fPdPuC8prnE4zfS92GVnMhoqtkvlPY7sGH4KNn2
 Ibwj6Wg321rdUn2dZZp+d/zO13w+cxd32X+8z1xhJxQz1rivungGh1GEp1C5cIj2eRVIaov7cHQ
 ARah2+b1gMOmlOdtTcfyxsW5CRYQ0K7CC05tKmKkXOWKyi2BALmIDUCOc2podn/5LvSK9U8Ck3t
 E9yxSgLb9H78kRhhHSpbziUPZrrIjXQG9mAlBfePXv7ljvsmx/5Bjv/iUxHVCr53QEgzZdgeWrM
 TO6EOWGZGNiUNEUOD311a6wk2XDVzjQSCKiWxUw3xWaOu23XEQzRxKL5HcAVNzLKSFgEAqMGYQF
 1i+FFtc1SkiUv8YwoBDU351b54WTSo/ucPjrfje0V1mwfBZtcXOptbgCUCpGVXdq4YrWfrJthpE
 KiRDcixBoTXo7SKLrwrdWCwY3KaAl++WrP2zbz2WQIgtBc2o8fhnGclCRFQyH7syB0WoVe9UnGp
 EGMD49EykyK4KeeIj+XL8GllWKEK/O2hHpu6vRE8GgU6foQhj0vXB/4ROIlnFsoFmIm6sWqxh1P
 TIaPvgSRlrbXNW9J6k3tMiQKv6DOZeCtH31ELMaXpJZlXaw1Ks+u1Gh35Qb/Hay8l3nvD+fpVaq
 rNfTpzNjv7R/6Aw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX3OKDs5fnc8Cf
 q3hcjg1xEUs7sNjNgEewzJxs6Fhq+jBy5qKdDF0c23zVzyqVrKA0ElwutJRr3vlklfXUq4K1llk
 +h/0MGPjcX64HsRyCfa1vfpXgMTi0Hs=
X-Proofpoint-ORIG-GUID: Z7hnp4OLoqenAYn8SwruvG5j-LJLM8sU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX0YDlyORwcEYM
 4Nnjvab8lznvuZrorLks57ZdWlHPwsnGw1wo60Xvd/5I6tw4/OseacIF77Tl6gOpxsKbCuuOGyF
 WdBPSXHvJ5WncoFLngv2Gl8B+u6iy73574MVjfX57Nvb4G7y9y+fksPgfvoUbIdGpQa9MMjYNDf
 wMAHVebw9G6uv/ouvD3HEJTx7yOPsB2yeGvSbISv+sJiTZApZ0sn/Lrq7KXKFKDKMyZQ/S1GMAJ
 CIfyPad1IEvEslniuHhyYe1aue8H6w2oxPaN6+p4MhoPLwQYxYJ3izZ0h6N5rO7uGHw22oQ/x6l
 53wdhEljocFRTx3TkCZX8sW2DceiNYauJ4BPCgfWSAXZNztLrR3z/tSdr7TZmmo1XZUAJz9W1PS
 YpVs53zmVkZjY5xvCDSQ+eA/1onENAl6yxREQOUNC6BRo1RRw7iYnRyv9GGTjdmZ6LsXkQlfMG+
 wE6vb0zQO5mnW6SpdIQ==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a423738 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=_l4veLwUkFW-k-pZneUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Z7hnp4OLoqenAYn8SwruvG5j-LJLM8sU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index a4e0d5a682687533a1b034ccf56cdb363d6b7786..451b23a039cebb777f356f64924838230052dc45 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -490,10 +490,14 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	/* Retain this platform_device pointer for later cleanup */
 	priv->mii_pdev = ppdev;
 	ppdev->dev.parent = &pdev->dev;
-	if (dn)
-		ppdev->dev.of_node = bcmgenet_mii_of_find_mdio(priv);
-	else
+
+	if (dn) {
+		struct device_node *np __free(device_node) = bcmgenet_mii_of_find_mdio(priv);
+
+		platform_device_set_of_node(ppdev, np);
+	} else {
 		ppd.phy_mask = ~0;
+	}
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3


