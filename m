Return-Path: <linuxppc-dev+bounces-23084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9184CC43602
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:51:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphPc2LVvz2ygn;
	Mon, 29 Jun 2026 19:51:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726692;
	cv=none; b=mAKX5b0w/C9yEndHzkfGEda077Y+plxKWJSnu5FRmBWOlsSKExS3xvG2WxY1rEMnel5HautDfshSh/UqJEtgivnzLbednsH0ViDWrVy6q6z/2JdtqdEoEC12e0df2JLXtkjb/HGays2plTOQcUL/9Nh725+XfJbG+wG9LQO0qOBi4yFSOfKGfQuVFcazHqAU/o+br+EwTrK+LhdexjWia7kUdGndOHef+DH0+Ze4gx12Pb96Zb3rlY0j2oDz9osFxxsR59Tve1xixtau7q0Aps3GqeAWmOoIhOLjbbBsO1mPO3j4hgGQpOLzuoJhze1UBgXBFmXTzXXxlHdqOs/Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726692; c=relaxed/relaxed;
	bh=6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxyYxO4Y78KYAMreAYUrgFMA4Ta4NMowjHVA2U5sIW5VG9yNWT/R5lkllq98V/VwfkIDvD0c6GRdK3bBhdt8zaGD1YVe/zgA/yQ/qxUVT5h8RFjfHrFjj2zT2FSvskDOJsmroWINoyb6la85kqmMMKPMeT/J4aqU1KSVI4bzh7qctftPprIYnw0y8XZDZm9Qz8YBr1ciR71hNtQEny1qXtWcW6N+qWEwfntjltx+O8BhVbpWGIfwpf6MW5mbKhkOT7BGft8mvt4TaN3hm1UhQkLikThW/rng8JOLB+mgACl5Ux7c89yazNueMhnBulbfgEOdRb9M4uoJRDgucCDFUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bnbHwr2m; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MpdCiYEq; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bnbHwr2m;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MpdCiYEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphPb3wRkz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:51:31 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6r5mt2076419
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=; b=bnbHwr2mSRvwhRpY
	T5Fs/qtEPzfnJLoght+lyWjGjZdvsT/Du0by+WEYqMVeHRDStN7RWrbgCO7nPrGl
	M4aulqBeZTNlOK5/1DeV1aK4ffO+kHFYu7AUE3fGhK1+vFuCQ0/sM/kwwaW2xqV+
	dWsjyBGlqaDnSMZWllZdExjlEdI0DJ4t27Zzl0aNRhQH/e6UCLRcq2r7o1F+fSf5
	Cw/VIWryBIdPMFR3FBA1V6fvHP1Fmt4SiKCh12fivPyC5XxkEec1HH71tp12j1J+
	e9YsdRmlxaAHZHhxnxkan14UOGA+daqp//l3w2pRTzBT4kUgmwyw903LhzSYcqG4
	Pi01cQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7gkqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92ac0a54110so485577985a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724423; x=1783329223; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=;
        b=MpdCiYEqbcjsuIOEDWE1LVz9CIqrmLOvjH8Qaq/IlVxOyZX5sBICo+oNg6oFX2aYLe
         dOxw38IORsL15Uoz7z968apTf3er/sSPqrnYKYw6DLokq3prpqtuZ2GErJsT9I61vVdO
         3en9is5UrDDk6cOj173TpEcjlq1WpYoetzBtwFX610Ccepu3s7N+aEiK9jfSfeB+NJAx
         8mfCn0uWZ34AFRSTUb+ZB10F0eNdpNWk1ta76DIlbhzUffwUHz0+fW72BmH9wnUHzhKG
         qMtxbzJ65SPEe3pTwUDQv3KiyEYLGzBx72WpwYq+91+lEVe4piYza03xmUZyyLbUDeXY
         +WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724423; x=1783329223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nG1Sji42mne2H5wEre1safG9ubwm9+aubw7cimzGYY=;
        b=f9ThE/jpPSS3jdCZYUpT237/8ReKnKqe1CeHAHVEX8HmTwuSHvzT8fCP4WHpi+yVJu
         Bo73CbCHfJuKh2oiclGJLw8BiDicqV2EYdzWtBNIMJtRrloHERxqDfUFdiL69l3+Zz3S
         slenugAzWc1GA/k9EUS08FD/nXAJCBsU+1i7yWxCc4PTZmmbjoqBxK0cE6wEgjaVfyaV
         uyYaiNDrjIVysRX3DH932aIZ2ZUAR6IjYKhQsWgqgmPQdc8uesw2wNung2aSQZ2uk6O9
         GMkzPise9QQLJ9DAKSXeiYaot0XTc+oDUkNUDeaq7zhb2dFEVR0ZkAajZ0RFWWXSKAzX
         0KAQ==
X-Forwarded-Encrypted: i=1; AFNElJ96WUIc05lhFLKlTW8aI927AvK72i1lBkFsWZ+K/GlMYP1g951aMzswBRdJtOBJJ9y2IljYcIH32K73vt8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzo13P0mGKZjOJiXKsqibCIeXTdp08DjVw4eNri70nQ8+jmzkYZ
	ro8jRrJVF+IiaNLs16qZHOHg+JHTtUwMgZ6L5r7QTIY1kxUAPmHCTduPFwmj/LlDCZ7gtjX1rNj
	LxRbyiznZrW5dCUmOcrSPyWHqfVbpZdBiqMqP0/fwydanmzFuVnxV7GDzc1ZJShJLlN/w
X-Gm-Gg: AfdE7ckBih41zSNSde6Czm59OVhTBQQC2Piqt6sTyQTuM+PoaENNPiSQx0U7FcPA0fW
	ntkpxvhNanfsgNRw55qSnG5el/xAsRDWcQuKGYCz3YpYupJEoMm9mbVBDQot7aMhxswslDagJPw
	MzW9mrdmELwoIqyOmovY4OSEsNN6Yhl+5ulZYwWZ9eZOlCAULIkkGiyVmS1OnVEuZleyDv1hwZh
	OSMqG/Fsgn5w+Od1HwVvvqAxt1JPGVlgdR1EEe0Cu5Y39dhd6keiJ5Lb3P5KMw2ddL+6mrKyB4g
	fdAB96TQd3LPXGPlkmuD5awMxSNE0IVAUMVIf8kdMpb5ZAY7DCtwoTqdWTV2Hh0jXGQIeR30OrQ
	ars4r6bBILcN1uZfGpIxw696bd6BnNCS6/IEWpunT
X-Received: by 2002:a05:620a:26a8:b0:914:c226:ece1 with SMTP id af79cd13be357-9293a8a9a21mr2392767785a.13.1782724422583;
        Mon, 29 Jun 2026 02:13:42 -0700 (PDT)
X-Received: by 2002:a05:620a:26a8:b0:914:c226:ece1 with SMTP id af79cd13be357-9293a8a9a21mr2392754885a.13.1782724421604;
        Mon, 29 Jun 2026 02:13:41 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:37 +0200
Subject: [PATCH v2 14/19] drm/xe/i2c: use platform_device_set_fwnode()
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
Message-Id: <20260629-pdev-fwnode-ref-v2-14-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=AwfZgG77y5F6PYl9qwo0/ZCBmtiBmspJvlFnU9x6+ng=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcSMKdRKoFVH1MgLNJk3NI477IXVrggM2yrf
 qWMIi3XU0CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EgAKCRAFnS7L/zaE
 w85gD/9rbl5AkgwjwdNiBcra1438gWnkZ4eAmKSEAAJXU7zcuofXfASHZOd6zPIW+DrV9r1TlxD
 KP0DeIAOqZ20FbPa4NyxJsz30Xni9oH087pgaDFHuDULWlH807p4z5IAByNWwQO401AUTRLZEDh
 pvULOi595BAoeJMAXJniO09FF8cacJPctOpdYnHd55I9oOmtmKFTxrnCVZIsIsYPqaZdiZADWPR
 MaMoJz6zjDB1IFO0JGZAdHalp2rAkmTTrhr0WgrQx1c2MoTAB9hTqKuVrkc89Jc5wP5ebIgPsuD
 qFljQKN6317Sh2FiMmSKEKGVCihn0H/EGe1vz7oCAE5DFhyZ8ofFKPx85kRbjBbmqg8gHi7KbrN
 lyej/lWRwzx48gMqGXqbW/DIlRjdBRiKolImRNHlpBCy79YAgtKvC2CuWTrZaRq9+1po/RT67Tf
 nqTjAXj4XXZKLtNGgDAu+Ifc36Grr7zKcD0+2sIZD8B+aUjQYuPfQxJOzYZqB2zfNsFGxhjQweL
 RBLurhlNBBwIH6X1Pyzwfheudxf8HN3m/QyOHbct5Z6O0IJ7n8oG7Ed4pHsw7m48/K4pPMB5ViE
 G5xtCnPpLGA+nNR7tqS+s3DrKKnkQo0eMI5JgGcUj+jVUodDfAKTd0dDBasosoFU72LcyzV/dVj
 ZVn6U4/QQLq78kw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX4nG2U4z7hDqu
 jCXECoUokLQpayM6s2x2z6KbrpAnTJl8yTxwx4AhrN+qHMNtpKhFHyaP9csFGNnUY3mdOazWAC8
 H5TocmZJOo4JlheYJjeIbOKcZ3o7meM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX3ms7vKkUgS7U
 X2vRpOX9z7Dex6yiRev4BWmafYL+1UeZq80uWWitGp/76AsjoprTv8yYRjKLL/qK59HWJ6eV3Iq
 asgNweuXO5N1g+FYZJXFZLIbhdlrEWMzOeML7UaCAv2jTYIkaLep19w0I49Lyh5zHt+CIFonn92
 B0e6MwYGS+lAnjx+e+nmCWO1XWxOXtl1/p06csL+xGPSc9KdGtETFfxoNH14xn/wlMuxfE92ENL
 k4huD0NsEjJre1KmYiT5P6KP1wkeQFynv3/GoMp3qIldGj1CBSp1V+lQ2ISBo3zipm5Y+0TIGuC
 ohm4EF9UdJmMkPRW+PZJFcjGM3sJc6505Rrt+Da7x+/hwz+v99cDlzB2o3qkssQxgoU0e94pJLV
 HA0gdpWbKqAC7KaSlGrvw4WZGZVG9RsR/CAci72/1MYsichKoTdser7qBtRdHBVPJY2sBOW9AJ+
 a4K5dVHnoclgMlNHVAQ==
X-Proofpoint-ORIG-GUID: TbiTJnpSqgnGM-8xeb12hdRcqOiZMdDQ
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423747 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: TbiTJnpSqgnGM-8xeb12hdRcqOiZMdDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 706783863d07d66b4685005d6649b3cd143ecc3b..af4ebd93ad8e68c95a14cdf99de0959fbe080354 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -123,7 +123,7 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	}
 
 	pdev->dev.parent = i2c->drm_dev;
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 	i2c->adapter_node = fwnode;
 	i2c->pdev = pdev;
 

-- 
2.47.3


