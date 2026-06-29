Return-Path: <linuxppc-dev+bounces-23063-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA57AC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:37:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gph5Q1TF8z2yFc;
	Mon, 29 Jun 2026 19:37:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782725850;
	cv=none; b=isOsCB6lN6Y0YQ9BHDPburFGaMNHyT9hreikLJLCSvR8BelE887NpWR8+9qUrlT3QKFf8A4KbPDubtj3IpGHRALBGdyYgJP8W7PHp9BwgEaHO9+zrPWPi2c89omCeGs8Po0gYX9cTuFdNKCWiV5Uv6nfsWo1IMwmBthRxGII0MvY7Hkvxs+g9gQqOT4PhTpk7FTOoCHI5yIt1Y7xO/kKdyitVNzQWeiqFnEYeoRg4QFkEJPCi6gc01+/lZDHBhY3DiVNWSHpGWWBgchOXfXhfNYYBmj11xSt9HL04avyeeeCmjN8detD2aTFVZoLUuoYh1dOMT/l8gUwnKYQ7YTtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782725850; c=relaxed/relaxed;
	bh=9pHsHj8j3f9AJ4gGh3rvQiL5ZcEANVsagK59YcLlw7c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BV9Mnahk1cZcdOiZP3e6Wg8XZroi+yHhsDJzRtgTq3LYEFQsaz0VHeJKE3ux4nrb5eOukeXgKW8PWLdCehYEnMbpQicAi/6SDWomsO8VU5PczqembLWxowgwjF70ka6Z87z2N2eue0mWnaiFYFixMi7Bc6zisEatHT7wkwqZzcigeySfKMB/EsRXt80NwidqoYgTMkcgEAa3BOxlaNwitEssOyYuUYL7jNKXdTqDX7p06BwSx0nn9S70ecnhy7VXEoAJvDnLt9hkayaSU9qmtIkJgIK1n1o3VRu/n1b7nSI6K81lWQvihKtZcb9ycR0XUQelXJC12qU1Yt78IuKI5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=REa1Sqeu; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iMrHObvP; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=REa1Sqeu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iMrHObvP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gph5N62fMz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:37:27 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8wVaw2391252
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9pHsHj8j3f9AJ4gGh3rvQi
	L5ZcEANVsagK59YcLlw7c=; b=REa1SqeushWSQer8aXnmzptQdlYOnad/KzZIbr
	rVjM4xb7i0SX74d0nA2b+w9XRvBwQkqhep6aT+ltZ1ouyDakYMkRa+VyocWigHdo
	ECwkr5q1JXG7+mfowPxSQdQs6XgnFgiHD2IUwclaJNx1g9ZF02zxTaIFo6yBhq56
	Hf/eR9yqJ/wbPWGBiH+qs6pHrsCT+T18AtHMuqpDZMwZNXa7J8/pZ3lT78YJWlPO
	BYhuTeqodcjSJqaSuoP8RudOhsInRwXgPAPoYeft1FxenH75SlwxfQp3KgcyJJrK
	52n/t2iwdFpv0jMUlhS+1DragxFC2Cru9FOYXkTn8lAor5kg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw81xv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:12:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92b4b575561so537206285a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724378; x=1783329178; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pHsHj8j3f9AJ4gGh3rvQiL5ZcEANVsagK59YcLlw7c=;
        b=iMrHObvPgkRoMp57CI/eSnQZM1fdpajo7sAVf2QSIz87XXEHFwB3IRZ66Z8JvO6zTe
         5ycv8XirGLltrAOobA4BSb8B7qbrcsCSnJChOEz6l1CE9jHwlmy56ZIdVmZIH7pDT8DA
         VFDEh5/yCpTZrjFxutSWMFSHYWZ/PgJ9PAA6TCgaH/23cdy0KC5L2tz+BMjnndhEGxwx
         DQitgbl4md+0/q6jRvuGmmAy3Owwv/7SmBNslpCIzoSVoofmCHZncVroi5fRSsSvN7Qe
         aqjndfbiqXr/zsjxsVmd1+Z74KHPrpLym5akFayiqodQFeZZvbY12Ndc3nhAsTnw2yfP
         JWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724378; x=1783329178;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pHsHj8j3f9AJ4gGh3rvQiL5ZcEANVsagK59YcLlw7c=;
        b=p+2FtuvF5ydxE7wV8NkGm6MxV9mewdQ9TgHp4DlCFGinxHG7u+rbY5yDvIFUcfGXKW
         Ruh7LNd2weLw/U+Kd/4qdvVsIG1VoUouGi+sFLwkRdCw7xnzQg7Y7jEf9Mx0cpeXxjgZ
         l9Ds1vEhu2b32dxjDo13hfqREpTpIWeYKHFElmABpuayWJqc7+XxfUdMuSer/Z4tz+1d
         xJNFreIMSmXbAi06qsY9hyfwdN7XS7ct2FdsWF3daV6l/Hyj3xAKkSbaY1WUxFITgd+U
         a/oGLtfsgHKvhco8c4ZZagBJqbYc2z8nE836qyd+vfsHnKfjoUU72HUv1fm9/HlHLVtg
         9/oQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Fqq9vnct+oDlGJo5zmQQhqti0FuLI4NJHwnYIkVR+bn7f32Q1IYd4jrxXZoNUDNciESTUhTE/nCNLkB0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxD4/eP/pXgyaNhh3VObVISVjIAKtFvwBz119NTpOb493rn8j/C
	EZ9REBJG6E4BAbT68WFPHv2lxVJGN90pCIfmRQzxPifIROcrxI4F7vwEyULBRNR7RL1Zs/LVjkg
	hYatUME0I2AreOI9271xXdQh5O2da0GFAj+eJqTV78cxVc86kRved/OD8vc4p0tJejmSE
X-Gm-Gg: AfdE7ckOwfO/zELuwfGDuvaUBsX4TY4smh71jyQ9Uw517NBtOgzjrIO7p6v3P+Z8LOd
	q9P5eOHp347JhF3BCiahEUhvg+BufxwsvTUObzKxqw8E2GQ6a4yP0BohmP+bCxw/EMwokei6C73
	jJWCt1Nwb7JP8UWZoYAY4OVqsd9Uebg0Z/NX7LWtAmI4l5Vl2B1uzgXLrttZLIPZFimlBhw5jSG
	Cb8HdNoPCtLAiDbdwIbm1siqzp7F6qJCFi1R9FZRBrFKR+DBdZ7g+I3tj8V7K2+TP1ZKw+/Q2UX
	3/EVE4JaOn3UsDAXPqFT/16Rer+Ikj+jBclHgTEa5FJDBAlklOVM8Mob9deHaCXkvyjWHRgS36z
	1FC3BIF5pBjrf8Kq+gKsxFeGOvyFPZfq72AqKsHv5
X-Received: by 2002:a05:620a:4693:b0:915:fc16:2ae0 with SMTP id af79cd13be357-92601f1b941mr3700623385a.25.1782724378004;
        Mon, 29 Jun 2026 02:12:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4693:b0:915:fc16:2ae0 with SMTP id af79cd13be357-92601f1b941mr3700615885a.25.1782724377393;
        Mon, 29 Jun 2026 02:12:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:12:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 00/19] driver core: count references of the platform
 device's fwnode, not OF node
Date: Mon, 29 Jun 2026 11:12:23 +0200
Message-Id: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAPc2QmoC/2WNQQ6CMBREr0L+2k/aolBZeQ/DorQfaSIUW60a0
 rtbSVy5meRNMm9WCOQtBWiLFTxFG6ybM4hdAXpU84XQmswgmKjZQTBcDEUcnrMzhJ4GNLJuZFU
 fG0495NWSS/vajOcu82jD3fn3dhD5t/25+J8rcmQopa7EXvFeGnFyIZS3h7pqN01lDuhSSh80E
 UEUtQAAAA==
X-Change-ID: 20260520-pdev-fwnode-ref-d867836971eb
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4368;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=SVCO5gWvclBRpZDymBp3Xgi/Iwkz3WPRgBlCjAVpAdc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcB3e6fvH8ZvfEeXy1YHmy9qNmpXNBrMB4kt
 LmEukvHaW+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3AQAKCRAFnS7L/zaE
 w40lD/wI6sh/lZCL9bUVUVfhXHR/FqEMavHUiaEtY5IReyg186SG0Mncc66am9ylUTBeWqQ/Liw
 PzdetjPKGkl2mRBV79p59svntSoPYTxm6bDfJPTylBULVfRbMV7zUX6GR1R+9sMsAdjQHtttUXf
 ZBYlTf8+D4tdCF3nYWHuDG6oYuVSuhppnHyCuIBenJainf9Et2R1oilvSiR6Hk44dtysCxxi138
 A6o/fQNZwJLNbc3o5niJuwb3gwBibFPBM4cUBQAVUlDHNnBKyZCxcqxvDR5Ded0FPvaLw4EoqSz
 Gk3oBMfE6C7nlRN1JjX9mIG6cMstinUsYDiLYHKq78u4qimbUdoG0ZCLgugigHzUfVQzn6Dk7jq
 iO+7/OLu8FPESDY773Btr8TTJIEPdZtDzxzBMfpVVf61+me8i7ek7mzZjdn5o0vlajQPr2sqeQu
 GU1drfykhuySyrVsiDuF5zWfbXZg6txYZ7r4Xxxlr2oR5fqMX+olKS7JxDu5bUDCkONRb2obyvO
 aFVU2bR34ttE1KlDGhTcuXUbyvTHH4mMDh4sHOCLfxYHwZgXl8Tx7JwiJ0biQHhZLEwRAlBTImw
 4dVDIoHBWFRybmqNGjB4p+CCdmZWlRuXhakcLbWo01E6rCLmZBNphAu0jdgsDfCGFnENlKAoNdd
 L4/8S38znNlGEZw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXzZY3TcSxrAG0
 xjVXd82vngReGvof1XOmwisTaLZ9Ew+25o2jXVkBjDzSlCy2u4x6ib65cF3v+fwFhcvpCmIsAtE
 qRNSfQH0edNaH7k6dHS7IXlr0GNzbAs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX9/vucqCYtDci
 K1lMNr/QxpGefoFFFuHcT9CkHLBCFanTc4h9qHEoam204mdzXoLCQeI/p0LTN+ncM9ToxvdJh8n
 GNZE9c+XVgMLOvjV5TmJ/Xcu4SgX9NdmWWfg7cVdryLAJ58aYSIg4InHCaQzEgw+i5O49AKYbU1
 4xIbgT77E1npbIkdwvBqEsRGVgGmvAsg0rBuPRlfZVyKU4xqmRIR0wng3qfgpAyU4CO+oZaH3a2
 OqgK76rQEnq4AnJhyLF9zCjbOcA4m23XseWJfla8tX4pesPVcf++oT6WoTv91jYOxoOV1WDJZFn
 LO8PwaAK8ayMBE8dl0TG5CkB8tDxL52z7JwwDIU9YEu6fkbdXctHDnboSdkKPuRDWsPb798YeCm
 XqP32AaKGn0HDpQ/uq8YZifD//RB2J+pWCFBzrp7KLVGoIkSymkBp2f7zYpFZ43D7sYCHiKplDx
 3swbFonyct98itdTlcw==
X-Proofpoint-GUID: mJUmF3RvooQu2gNL-_6C99Uh0SvkYgA3
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a42371b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=rL0NY73m5x218zCt0XUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: mJUmF3RvooQu2gNL-_6C99Uh0SvkYgA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Platform device core provides helper interfaces for dealing with
dynamically created platform devices. Most users should use
platform_device_register_full() which encapsulates most of the
operations but some modules will want to use the split approach of
calling platform_device_alloc() + platform_device_add() separately for
various reasons.

With many platform devices now using dynamic software nodes as their
primary firmware nodes and with the platform device interface being
extended to also better cover the use-cases of secondary software nodes,
I believe it makes sense to switch to counting the references of all
kinds of firmware nodes.

To that end, I identified all users of platform_device_alloc() that also
assign dev.of_node or dev.fwnode manually. I noticed five cases where
the references are not increased as they should (patches 1-5 fix these
users) and provided three new functions in platform_device.h that now
become the preferred interfaces for assigning firmware nodes to dynamic
platform devices (in line with platform_device_add_data(),
platform_device_add_resources(), etc.). The bulk of the patches in this
series are small driver conversions to port all users to going through
the new functions that now encapsulate the refcount logic. With that
done, the final patch seamlessly switches to counting the references of
all firmware node types.

This effort is prerequisite of removing platform_device_release_full()
and unifying the release path for dynamic platform devices using
unmanaged software nodes.

Merging strategy: The entire series should go through the driver core
tree, possibly with an immutable branch provided to solve any potential
conflicts though these are rather unlikely.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Rebased on top of v7.2-rc1, dropped applied patches, collected tags
- Link to v1: https://patch.msgid.link/20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com

---
Bartosz Golaszewski (19):
      powerpc/powermac: fix OF node refcount
      driver core: platform: provide platform_device_set_of_node()
      driver core: platform: provide platform_device_set_fwnode()
      driver core: platform: provide platform_device_set_of_node_from_dev()
      of: platform: use platform_device_set_of_node()
      powerpc/powermac: use platform_device_set_of_node()
      i2c: pxa-pci: use platform_device_set_of_node()
      iommu/fsl: use platform_device_set_of_node()
      net: bcmgenet: use platform_device_set_of_node()
      pmdomain: imx: use platform_device_set_of_node()
      mfd: tps6586: use platform_device_set_of_node()
      slimbus: qcom-ngd-ctrl: use platform_device_set_of_node()
      net: mv643xx: use platform_device_set_of_node()
      drm/xe/i2c: use platform_device_set_fwnode()
      platform/surface: gpe: use platform_device_set_fwnode()
      usb: chipidea: use platform_device_set_of_node_from_dev()
      usb: musb: use platform_device_set_of_node_from_dev()
      reset: rzg2l: use platform_device_set_of_node_from_dev()
      driver core: platform: count references to all kinds of firmware nodes

 arch/powerpc/platforms/powermac/low_i2c.c    |  2 +-
 drivers/base/platform.c                      | 56 ++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_i2c.c                  |  2 +-
 drivers/i2c/busses/i2c-pxa-pci.c             |  3 +-
 drivers/iommu/fsl_pamu.c                     |  7 ++--
 drivers/mfd/tps6586x.c                       |  2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 10 +++--
 drivers/net/ethernet/marvell/mv643xx_eth.c   |  2 +-
 drivers/of/platform.c                        |  2 +-
 drivers/platform/surface/surface_gpe.c       |  2 +-
 drivers/pmdomain/imx/gpc.c                   |  3 +-
 drivers/reset/reset-rzg2l-usbphy-ctrl.c      |  2 +-
 drivers/slimbus/qcom-ngd-ctrl.c              |  2 +-
 drivers/usb/chipidea/core.c                  |  2 +-
 drivers/usb/musb/jz4740.c                    |  2 +-
 include/linux/platform_device.h              |  8 ++++
 16 files changed, 84 insertions(+), 23 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260520-pdev-fwnode-ref-d867836971eb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


