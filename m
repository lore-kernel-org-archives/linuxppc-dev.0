Return-Path: <linuxppc-dev+bounces-21306-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5978ACD5BAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:39:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhcy02xBz3brC;
	Thu, 21 May 2026 18:38:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352689;
	cv=none; b=FtQPsyhTobjDLu3vSSh6XMOaji6CPH/dkCo/Iy6mjiEVX6hdoxDl5EwYGN4mlDFOD6qHvW0jH0slLXp9qLjrDxEDV9sJycVLAq20Mm2ZNKPTDfP4Wfz44affFdPV4S0u8T4VYCPGst+99hpkIjC0ocb5pv0Mm/HUOcbN+d/jrO3DRxrIJuIribg6jLDLxF+Hk1WPtMf892LDuz5fBZ5mhojBZituQeEFJiDo0QP5p6/qyziPp/XtfLoQqSz3Vk1sCS7KICgLbaAIv3AulBi7Vo8qV+EWvGWVX5B2lTnd5VQkf8L/+cmbr93kT/ixxSYnfavAb42PcID4ZIyTTrSFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352689; c=relaxed/relaxed;
	bh=jQm8FjEEV1MO6cIIhFWA2fcDzddol+KMBCUaCkXjjmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLBc7tiLRSkTi0i58WHXQjToOrAM0OU9upHA2tHwVAlmIpcKXF6lV3QZ3bO82s++wy4hq8cwI04r1MRKr9SiqXyocYSFO9LnQGMQAjN+OJ+eQzprwEHST+49baE1+XjUVR3nzwH7QnREa0ZH4p+AI3jjCCarTrxqTId35Ia7gKDy7U/KPgl7eiJi8iL7kV8CDqSG6269+yg5b6LlwNAU2QfhKzK8HoTurMJBUfUvKRI1+mjyQS6H7itpXw3lZ659HTsYy9w4u8S61TGQgQ+DzCu9/AaEYjTM6PHPhf9eRFYdM5putL9iJwmVK+wAb8zSV01JIL05yEpGE18vCy2M+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ETMv0UEz; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cg6NM1Rb; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ETMv0UEz;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cg6NM1Rb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhcx3Hyyz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:38:09 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6srhj1798322
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jQm8FjEEV1MO6cIIhFWA2fcDzddol+KMBCUaCkXjjmU=; b=ETMv0UEzGin18yIO
	zOHyP7x8iY+OlWlx9nKmm444bzrPOPxKwh3b2E+AZUBPwvrz34RnxbQiemMT1XNT
	Nzaw5W04hcIM3aShKSaFmTXczPUAy1RwkVkuZEhrNUeN0B0utS61B7jMcxDL1MYi
	dgZ7uJC6QGv2JrzBWVq0ThUYemMcLrNROllJ0Td/q1IjYV23CRsACtchry7AwdpC
	99JE9KQ7duYxULEWMIr5Sw76zn4qf+i8X/kH6sFyOLBk49gRvkPlBf9UP1qGCU2a
	QEyls5Pg9lt1s+gyw3fKGWsm6VpskmbS+g6c7huGknaUwlmF4lft0+EyxIMpScFp
	7tiZLA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu424w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:38:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fbc70cfbdso170654091cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352687; x=1779957487; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQm8FjEEV1MO6cIIhFWA2fcDzddol+KMBCUaCkXjjmU=;
        b=Cg6NM1Rb6xiLgKEVBqyWJYJic1iaI2Q6qODUuJPdemWxnvUd4h3N/KuduBb5fvfLaY
         NwxI11+tKhiAGbGrvbxKZ3oSCLwVftBbnZT4cycFbxPd3HZPO6N7dNMZu287ktmh0Siw
         s33AkeVxuAY0fM7mmpV2MCBvWO3aKUVFqSdTUVktZqJpFYzigienNNT4RY0hKaXuSpmi
         tJna0UtNmUPJTbK7kyj1ONE+CdZMssSZsiK9TmK0EawV7IZUzqhutyNk6TVftfDhTlCD
         LqEbBBmtNhkQilKFOKZrcpJChwst1IHxL859ik82gZx2IIeUs+tfedRMAYJa+u6tQXSG
         tBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352687; x=1779957487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jQm8FjEEV1MO6cIIhFWA2fcDzddol+KMBCUaCkXjjmU=;
        b=KkPytZyTCgKHPyO60bQmN0AmE2oMqFqLuBNv92FQPaRfX7xHLEvqvDB8E+weyam42w
         Z0CfsGrYCif2jgEbI+8V2eLjjGnYhHZeJivjRAIbV2iaOG7MaLF60x1ibeBSHiHfPk7Q
         K23iug4pL1Y4lq9oUDJZW8J7R/EH/Ra7io8A6ETiFZeiehk+FnCUmywgaIV0HB9TXxll
         mBqm/mVmKROjIlXglG6SeGOZ7uxjhlWuYItptM0uRVSEeKRJzREoo+fq4a+YWTSmXeP6
         A1rBL9SHcxjPv7DjJDYxcGUmWw7Z3r0mh0S5WnQKQHrCGt3Ha5BlAFBv7WqzpxNAM0gQ
         qSjA==
X-Forwarded-Encrypted: i=1; AFNElJ/swziQuMp5SiKog2hjUzm0XfowYva1E8yg/x+mHCFuBSFVwHF7peSSzt0csHnj023tZ8jh/pbpRuQzxrI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJU3Ymi8s0VrHTYYoboni9nQnqLNlS6bRxjHOJNuFUGxHAj4Ve
	gBbEDSEq/Y4dI4zmVpfp89gCfBPP4XE+c+UgCkHUv19gVy/pZveqNV5DnrTu18t5BxN0aueBB6E
	b3Yq6SlKLgoVb86EDKgfzBcLASr1S9ugzY5OEN6N/CCeuMb8HHkLw7kYddBpsNyTHgODN
X-Gm-Gg: Acq92OEUAqmI3rt4iDSYvftuBvmYpRc1TMSKiiGjz60yn3EGwy6ooAbb5iams4XUNv/
	x4gHXjMbvmfqrMib8EE40W3B8HKKgFieWHMTaE3CYql8QUKDTwPiOCj9PVgsuhzv4ypx2axlfiu
	bzJb9pbphgeef50NDV4zJJUdIzQPCIUKR/1tsfC0bUEXqiyfFCb/oWJnONfHPifhsc0w2AUxG+U
	v84ZJo6/xvYGneTO2SqeBfzAprAftMBulRUFZT012/pFufmFxWoktqKPyda3me5DqJswtzRfEm0
	L8cQnnWBGir8VtpvFXvR2JGKz2oKmy53rseVQk3ZO7bFKzvl2i7xMpM2Wtm4ZXoviLiKQnn6wZx
	s05NaLr1QvGwNI60aWElgpLY6Pvki05GoP17RBq7OVqdy3Fp0jbc=
X-Received: by 2002:a05:622a:5986:b0:50f:be4f:465b with SMTP id d75a77b69052e-516c55a0cb2mr25069731cf.33.1779352686724;
        Thu, 21 May 2026 01:38:06 -0700 (PDT)
X-Received: by 2002:a05:622a:5986:b0:50f:be4f:465b with SMTP id d75a77b69052e-516c55a0cb2mr25068921cf.33.1779352686206;
        Thu, 21 May 2026 01:38:06 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:38:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:43 +0200
Subject: [PATCH 20/23] usb: chipidea: use
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
Message-Id: <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=919;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=BQp3BJQMi/G+gQE50h68jsUUyT+B8hxHS7036l8NXls=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQtJH8QMbFPV1dWqzeHalCAZ+RpZK0MKHRiJ
 e2Dnj28kPiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7ELQAKCRAFnS7L/zaE
 w4sFD/43Yx1hMHGpbYfxWKnFqlN/WdgLuFdPU6cY8Np++YZo2rYf3uPGYaOPteE7Q4cL5RynKN9
 tR0Q5pOUhbL/jLv9XdF/FeTDp2Wtb+TtYWM4RNYXfZiLtOcIW1O1RcscMBMDg4SKDXrB9nTsFlJ
 Ets8a398cI+pUsB6ZfjOT2KSJcdnUmMi+G9PftPgIVhNrFawhhoQeIPbZjqlS5xIYc7aoup8q/F
 cHF+pVR8vRKDG1fnQKF7uZujTEhgvA55j3FSZTVCZkxCsBX0/njfg8jh+9GfGikqXOJtpFtrqIB
 YRP/K01aDpXYz4urERxYGVxMrwzGzHwEGh2xWQFo4GyeVir0TahMIMPZogHAdeXd2fwtP0+Lurc
 oF92WGf2yxlTJfSUv88Hf+XvE8g1GANQ6YH6zrRxwkbaYi1lAW7i6pVPyAZsYPHERSHgjP+9t/+
 UJeBVAVjRDPH5bZtRjJSdOzNtuBlEvMbQhzXOo91V7kuzqQjqauwM0s6wHQTd/P0JuKRyXzkBbZ
 2WgOWEzaNqEGJyVsjDv9LxSCs8TCSw1CnD1brSHk6LTZZWG6G7GUcE6KkvtVssqWUr1hner+mI+
 /oFzTOsTFEXIwdUHSm5mfY+fzKnlCN4a0GHwdRITxW8thNpsdc6uikexiFWnwMcZhAW6Q1lW8wp
 aEsUt3Z9Z/xE1VA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX5PJQzUA+hJ/6
 6CdbFRLsNm2aNFFVc24NrycF4D3WUhn5HxFlD1L3dpN2JVhwMrrBRSu2dBCGwN818/Qr0sIWqMZ
 DIjCO9qODvbsTOD3kxChpRyAdVwMVoLYiNhrVAY9XiwKz2IS0leaAcntyQpVIBIBLcSlYxNG6P5
 B9wS+zP4m5svWjtcv1FVFKEaj/uChgeaHGE3nTVmknFVG4qAmsev+8glU4UViwrJsHYleEeGH3X
 zSD5Lq9guf1sde9MlADPGyjvnf07ZLRZir/ooJl0Tfq5dfx0bXhmZjaYSQotp0OeLdK32eMDytU
 SnDoMWUS6wFgPhFC+JjBJ0YRdsMvWpqVbi4Dlm8T2JhDR3bLcG1+uO16a3Zktm85iwLsq4244f7
 jB6NIiWACJh3T2GRk+UlbiyP3P8ZfH/f4JOwMYJt5/Hk5bI3XR12SmBbq7CQFJzDEM0ZxzfzK6P
 HKxTGk816ZNZng8V3Xw==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0ec46f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: c2XOzQfhdv6cz-IKeb6Au8axG0Uzr1jg
X-Proofpoint-ORIG-GUID: c2XOzQfhdv6cz-IKeb6Au8axG0Uzr1jg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 7cfabb04a4fb80c6db56ccb430d290dbac61b716..5dd415f42fe0dd026e8a1cc162357e42ba8ceaec 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -888,7 +888,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
-	device_set_of_node_from_dev(&pdev->dev, dev);
+	platform_device_set_of_node_from_dev(pdev, dev);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)

-- 
2.47.3


