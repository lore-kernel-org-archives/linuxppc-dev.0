Return-Path: <linuxppc-dev+bounces-21293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF34CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:38:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhcD4G6Dz2xqJ;
	Thu, 21 May 2026 18:37:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352652;
	cv=none; b=N2YDk3fGEGkRJNtJ4i6Rv6T8y/D+mhqwSvgNSRh3/wt2P0OpFIgFmTi8ou/VuPgytLoShAVuksatzqCfDt1gAYi+/Q/RZ7vW4rKBFneDRjDV8Mr/5L3mPNTwSWDV4JQ039OqsfAnkBignfzM9N3Rk663vO7Qzx8du0Zxe66Rp0Xo1nTnVIepweeAuPgLbOO/g3dD0hcLOEy/td2pm1gmhIv1bIMogk8aV1AG5LrWz0HU8KHk4bzPu/dhRPgFiswaNeFkMPwdfvAaeSP/PvoLX81sU2fuuVoftF/MK7DhGNwE9Tu0KLDy11lkvTsKbcXJBoKKHE6hRcDUwJReyqRXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352652; c=relaxed/relaxed;
	bh=7EUKjmOXS5ZOlGKfB9pplYhxFGreNM66ecTz9UnZfAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfzHKFzCrPwrlj69Zguq8OJDy/5Q7FmWUkmnOIbFKjrBV82MJ/2WabepwfG/UHfjg/eAkD/iPr8beSUv9cEZCHbyoWtDSJYyeXYg8tLApkQ1ATHFiuDHecbU3vTD6m1gh/EnD5EQNv6DC+/1RGfAVtJFe0oFo6duSdGvTlpXhwHXIHkBX/3sCEBqjq/RL8cMZgIedy6z+hmQMuio9afvAvKC0BubIUM3Aum2DOhfzJDJalppVf5ZoQMvIsLUDVndkFr3uIILyGe+gTnVPEEaP6D+JKzZIwKyqJq5ipFLDZetUEaWx3Ot7RJJSOUPwhwaZtdTwioDbJ7corXC60mpVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bUc+CFFy; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UyPfH/Km; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bUc+CFFy;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UyPfH/Km;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhcC6BLkz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:31 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6CDEC2157882
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7EUKjmOXS5ZOlGKfB9pplYhxFGreNM66ecTz9UnZfAw=; b=bUc+CFFyd4NwxGHF
	Qi5NpLvFwnhpE432xJ/qoye39MdlOPIeXr0d/NdMc3KixWDczUm8hlATjkig2sQH
	IhSjxFtRx3DcL1KhWUfKPa9vUkz8ZdBHKawUbUdO2rGmfZ52aigtGOvAWJyVCISY
	sEQ+MxYmGqtCrX+c8O96WtZJIEkd5EBQKauCcGQGKbnooaUZswFac965DgQNfpgo
	QxgB3qfNRvh88702c8zZflqZ8/TAjVMKNh/+g1VQNg5txKJdTqUewSdwZnJPG0S/
	NgcxmluTwdErf07ihJfojQZqBQmtB1wMmK7mtHkf5SXdfz4fyUoB2ibGkSYPiXNw
	0KZxIw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma428wd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5165d10e036so83050101cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352649; x=1779957449; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EUKjmOXS5ZOlGKfB9pplYhxFGreNM66ecTz9UnZfAw=;
        b=UyPfH/KmDr6sVOKot1M+wm5YBm2Gbz1Pj46mIIhD2UQsuOXDdFP31Gbmd/T3vbfWDT
         Llwygccw00sn0AjM30pR4TbUV6yQ0LIT0+L+IFZLXpxzZ1cbF+nqVffHO8HJUlK9po2Y
         7SYglgsjBWZSeAJHWEfhR+MOkQPHZzQA9V3oGhSUxtyNfEz8JfwbcOVKw25K4Z6bCdXj
         EBUbp9kcMeLdFQEgmfHZTsI256KGQOCy/5KB2ERMAbzj30yOnzB0gAPUJpL3qrro1noK
         ExwKP0K7RLxmmY5qTH1Tz/mIaMSZwnBi9Un01Gg1ytZnKDx8LyOLlJOMdAAkhupQRex3
         KE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352649; x=1779957449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7EUKjmOXS5ZOlGKfB9pplYhxFGreNM66ecTz9UnZfAw=;
        b=MF/TxFi/ips2h05eEGKfz70lCeGpPH/gBb4LrTcxSVt2UP38oKMV3xfknICnLIrvS8
         cj1x6u6v+t8bm30p81taUN2Z/Ucg7KQA4eVfRL5pYUQcbtuObr5/iygn/P05h927rROD
         sy29UWXbzu2D/5EJXyLdHJb6JEH1y72PcPI/DgmDNbeseqDoFs5P78Kso1MezRH+s9et
         9OAyIJkBtpYQMpkKULI8nY7i4NNZVskMdKdWu2X4dPizZmcGS7XP+DMOlhPrLBQXMqme
         s2ztBB2FLrXhNhQoVPDq2waCDvBL0H8+pkByN7s4/bqwT48nxfve+KroW9pEyBkMRTVI
         ByrA==
X-Forwarded-Encrypted: i=1; AFNElJ99/8GOohMY6gtmMia34IFSzSrMM0G2JWueBeiYjZ2sFsPNH3r8RSu4nQJ20qcs2ST+BboxXXinGlqGGvw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMv95qpqtj5q5UehjAaWdNvNKcrHHJENVsFClK1R3s3V80KfRX
	puyCJH/iMD/G3hyDnScmLwve9BAJD0iEZlX4gKLKWH7zdi8UszRvxmzkA+cBDXplqCHEE0CXLPu
	UDZxd04gv0atT/zB7Yo5vXPmXg5A6hbJSUHB3lh/O7Ds4cGCUZtIgvuGDeaJM3J5Kgr18
X-Gm-Gg: Acq92OH7NXTtND2/FA9Wyf8rL/5ege5poO0jo9GkETwYhc0NiD62YOl3uHDzJYfSZOh
	tWmn7EDLV6uwgblvVTWmMTC08/RMFXx/z4iBnTgXyjNjineno4PCas7rJukRWTSYntdLik65/0K
	FCOTolUky0pWgBcMOC/qy6fIwPLA942AaR49tj1eUyqyF32J2MqNDOIelO9QnotyvOOR45AsFJx
	oCqVGLlI2XQXxYj/hd+jaoQJ8Qoleny+bMC45KlntD3Ef4HPWmjz6S1hDovC2RUlMdXZjNtWO9A
	I0tEaCXTllo+66mB9VFnvvYZrE4lUPs6196VaRZME8dR1+/Gd8Ru5AeFi+jfkWx+66BPR9dZ8a6
	EoBRLQyXVPbC2qH+4HbYxgn+bxK0WxkYEbjJY1ZaJoPDUx5z4sL8=
X-Received: by 2002:a05:622a:6116:b0:50d:8b23:4948 with SMTP id d75a77b69052e-516c55f9205mr23939781cf.46.1779352648977;
        Thu, 21 May 2026 01:37:28 -0700 (PDT)
X-Received: by 2002:a05:622a:6116:b0:50d:8b23:4948 with SMTP id d75a77b69052e-516c55f9205mr23939251cf.46.1779352648468;
        Thu, 21 May 2026 01:37:28 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:27 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:30 +0200
Subject: [PATCH 07/23] driver core: platform: provide
 platform_device_set_fwnode()
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
Message-Id: <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rRd9j74OjQyNdk+VtFlh4dylTyLU2CAyFlLnnDIdtUA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQkkNWy1u0nJDfBnABQIB58pgj8eKnciB/gZ
 7KCSi6M5MyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EJAAKCRAFnS7L/zaE
 w458D/9fxBKMlVNMNuWz+dazeEqvaZtdDlcsmiOnFPfj6M7Og4sIQku1pIhqWg7R5feeB1t5KVF
 RWCKwpG7q39Vd2yli4ed1/N5s8xsernpMD4OztOcwq0tqXB5zaXhDam7ARfrsNIAdl3RCZQAH0a
 UXY73ce/1dp9+wn7bNqRNMILkBqt8lBrdmG9zFStxK3XKwwVgsXk5+a3S0FIeFa8liFp58I9vPO
 hWFJ4iJTQtAQbh2a0zCFBvlIaE3SsK4PJ9IT8ZDijnKqj7IrJIbOLzaJ67Y2+H+aXIDP0eSpxID
 BSutxdu0Asj7BY61FqDuRTZu0vWpxf/AAKk741QLKJ9YnDaLfPB0DN5yvUsigFSl3+pMCaCnVJt
 XcW+lNCQbwsuqvGUNL+BeSoe3Hx3iZOriNNbF1jFZKRgfW9dHLlSKg/UjO0PV9uPYt5hvqYPLP/
 47kDVDCqqil/ygTtOe8ewtH7I8SAyDdmzvPZfzY8gofGB3ZTCYg0UxaX6wPQUEHjhOai29xZYPc
 U0iw7mIdVm2FgWvXoklBlTliln1aFrDUbajr/ngh99C9qU530PBGuuA/QgKe9UflaOdMelDhUwd
 GvWyZXhDl6Nla/IdzMolpNgu0mSi5GihflL4zLe14h2czjXmLhHVNliOTu11GDnkSl//3aS5cpx
 im4np9+GZQRjxzA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ec449 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=7s1i5lxVbzGmBzMXG7QA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 7gObJkPhIsYg6ov0dSdxEXSyvm07zkb3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfXzyeMjV7vK77D
 SD7I98XNClS45L4OLrX+LoWMZmtn9zWyBVJbHnqYFNESO4gnIdYIF+lFcb0t61R46YGFNw/c6yK
 smQ7eT3CIug13TlWQI6u+qosKSZiRml4bb0LhUbawYehrwhKD6jIMASynLSgWBn042p58gNCp5t
 eUyMnYCHqQDiKtf8Cl2rBXECQWboFDfTyQ+xfPIzNzV/rB/F9SgmlCsTi1cKp85qPi1OJ9JfUJE
 8B8yg+bKITD+UkKyVW5fOMFT7vK7cNJBlx6d9lDnoEXdYN3NZTOdX/f9N17lnM2H+k00/QV8FNE
 p4NTEf3RlGwtgd5W7ZZsvO1I7CqIPgdFVcuR5aaGjTBZYq+ArlspcAGEw9I4CpcI6zYgZXE5mxl
 lUwyLV3ZoPjvxCDZXOXNGBSgun9nzk0LbS7T0oIduNeUc1e01jf/0c96+8nlGHYS//Pj/xzMVPH
 oyAZ/r5J0t6BVhQCwRg==
X-Proofpoint-ORIG-GUID: 7gObJkPhIsYg6ov0dSdxEXSyvm07zkb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Provide a helper function encapsulating the logic of assigning firmware
nodes to platform devices created with platform_device_alloc(). Make the
kerneldoc state that this is the proper interface for assigning firmware
nodes to dynamically allocated platform devices. This will allow us to
switch to counting the references of the device's firmware nodes in the
future, not only the OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 19 +++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ec53383fa17ac29ea3b15b61f97ae65ae8ca22ac..449914e657c9c58cbf030208e60583dde728d6c0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -711,6 +711,25 @@ void platform_device_set_of_node(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 
+/**
+ * platform_device_set_fwnode - assign a firmware node to device
+ * @pdev: platform device to set the node for
+ * @fwnode: new firmware node
+ *
+ * Assign a firmware node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		platform_device_set_of_node(pdev, to_of_node(fwnode));
+	else
+		pdev->dev.fwnode = fwnode;
+}
+EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 21f7d8a7f4b5c9a47d56d80a69802b3f84457ef7..a915a6f2da71284b60a6595dfeb013ca0dba542e 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -20,6 +20,7 @@ struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
 struct device_node;
+struct fwnode_handle;
 
 struct platform_device {
 	const char	*name;
@@ -265,6 +266,8 @@ extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


