Return-Path: <linuxppc-dev+bounces-23621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7764BC43602
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:46:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3xB230dz3brZ;
	Mon, 06 Jul 2026 22:45:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341934;
	cv=none; b=NNvR+Ev63dXt8xYUuNjReQGYe6FEzCdkpwE9BCSo8G6sy1MpKEvnUt5eZOF1X/VkbTrn/ZAvK8olbZ/LJWj5hq4U15DkloU/YbHR8cP9AtYMx2EbLXbFZA9TQ3lqzEhhZgNLTTWboG9syRJa/jPLE3l+aOtmyYrSGtD2QV5CTH6iHi64rh/B/9LgafEL+T8v/90gsMbORI3aVqpwpFROUMi+IFkiKgIM0Ds8enb8+DuweS9OOziae7aIm/R+IbIfpO5Msbp/1+JBHyUR9Qw5rt1ZLXwSEji1WiQiQZTivwcdtKlHiIMpmg2EUHZJuxCiHZA1ybUmvbJn7sR+K9BiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341934; c=relaxed/relaxed;
	bh=9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDIAopqDcNDKpTk0VlG+Ud4VRnyEYUamVyluPIoQXLNaNLdHlUpfje4QbudXHnM1T8JYreB+D5UOqaWAbeeZCMUxAun3wHGicZ0RZnA2cnJtanEiboLWFxkkTn2W8wC2jpwAoi7Ar1moHoRYrO6Rz17zgyw2YPC1JNWnoOvDnpQXSVGzxVMujvLU81jJU6bGleNSTWx5j5v+TQUKRjDfI7bMlUiSbTXU+0X4FywvSegW22QnKs6/xdYWkqm5AbaJTiY8ZCMzT6lrSIKKE2mjZxHF5eQMNzdcE3RYsOczI+lIj8BR1G6L2FbxlCg2hy24KQba0DPR92d0y8G3mw2P4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PEZWyDId; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jJg2BtON; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PEZWyDId;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jJg2BtON;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3x93FbKz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:33 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxJaq361440
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=; b=PEZWyDIdayoRJtJf
	Gm4yCbdBU/Kg4fCwmLvwa54Sk0sJfN3hNtb89B8sTjEQLLb7/NQP1FY2m0eE9nGh
	LdIH/gTsiQ+Wzh8wjGQ2vHc6+RNH3gineRvsHArNGv6/67/yH3ZhWSQLygU2RVUT
	al+kCmSgvmGNhPOOJjv+KVucWx0X4EB21idu1fTE9R/CSLy28ScyY72eHbaYuWhC
	OXDuIkhJVtUuTbzjXakzMsNOMrKY+8+Fw06v1ma+AuvP7I8BiqHsyiSSRZ6WD8YC
	NTN026qYSv+N5mknEhi/Fn7IR2T8k4UjxvMEa3K6XaNFaf2HCmxgQwNVgUCgNKtO
	dPmBYg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h512fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e53b8a302so278861985a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341930; x=1783946730; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=;
        b=jJg2BtONqL2X+TDWtAP8gJPnYhb6th+/DGTe/QqD2x/nk5Z1vCxu5igZ61aKtWg6AW
         9fdQCUQ4K8RhVfSl82ucZ8V0DVcHrZlYEeMhVrn4b04hA2s4Jjgzg6ikGHXozPbsbY98
         j4kj56m6qxvJigL8KRithUTMjfGSo3zcihgDVVZozSIB+Je9nN07A5ky1GSmn0egcgcx
         bfIskgs5v5EEKgbPjoXyDtPoMgyEDLPwu+r8ioU06aro7yMr6SsZClAVUtpYYp1uKdz3
         T+6zbEfD8xc8vIQyFioI2QGIIXUOaf7DpKDsM7liks/D3v4SPyLU0JjRtrSZ19yM6ynS
         jfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341930; x=1783946730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9S/mbrIgVqWqtPP8kmV/asLO7TrMZg/IRbAXVUcN3IA=;
        b=MhdTzu2sYNNShJB88fdGI/ZGaZvR4/rr4cAb/ObTPVfMoD7xwAfuiHPStpFcM3YMdo
         K8TRMT2tZvKdQo7H1ryg0wGB+x1zt2yUKknLk4vGrQkyn1L03cRFq9Q0IZ9HvPEzfVC3
         3swfWALG5VdTekVSvji6AeqaVSmMZb6mbg9fGdbJ41ejG2k0pllflYIdi3VCogyJ5kBr
         QRsPjaKZm7KA4KaHKpYb0+D1cXBWulWvjt8A49glyWBXx8QIUak5JPF/mE/5sz3kU10s
         ga8QG7fnhgkYDmuH4IN2IGyNVZJeDSfcrFsC4sO/4+AyeA+1049Q9ERCbk4QU7MJ5Xr8
         5zsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqg7ivFQw34ysB5RmLcgJ4NGN7k49cRqVt3rgA4KHVwt4R9+oLCDLZH9QI1/qS5z7wuutPcFxL8X8QbzqE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFtSnCtbjJbeExLndM04dKd3kdpUAOxXOPBPZ9bzvnmUXps/Ai
	t6f/3zt+q/JVVHXXGuVyYaSYgSnKlMO3d14K6a6AXmz6V3iQAZqtHZk4TThgfsx3d5/6G9Wff6/
	V3NnbBvWoZgeA0rrnDnaCqvmbEEZAANalHlKaySWJbd+5maPqz2Kt5nbimV4wJbp6yqx3
X-Gm-Gg: AfdE7clZh8Ryy6XUFRJwJmQ3qnYN74rnqTLl20Kvy9czWN/fBdLPiV+JeYG8HgRyDe3
	jAm7P5Uncna2ODK6+6ILjueVY601NyTBrJVq6v3VI4IR/iz4TYOzXaB8mq5O/fE7CFGPXx7CBj0
	T/gHtWWNWe4fQwGMYjEP9SrGW/MfRuOyjJ4H6TNSEkS3ePgGEWHiG0eqpVrcj8oYtwIVmqG6wJ5
	Nu/wH0ijQtVd2lINMIyJsQQBtmPySGTI51imUxlz/3dpCxPVxIrqdMDVQrmEVIOnfiFGhuzbT/M
	2WyjUARJzMIW3Aag7vXR0+LMqb6eurilTGkNbAW+mXLz2FJWt9377nyZrxSY0hRBa8GfiOfuXUQ
	RkYqwKtnVE3f7ZZFjMDGaxkmqcH1/XlqFmgKcPRP1
X-Received: by 2002:a05:620a:268a:b0:92e:755:d962 with SMTP id af79cd13be357-92ebb5d4187mr48762985a.38.1783341930397;
        Mon, 06 Jul 2026 05:45:30 -0700 (PDT)
X-Received: by 2002:a05:620a:268a:b0:92e:755:d962 with SMTP id af79cd13be357-92ebb5d4187mr48755485a.38.1783341929743;
        Mon, 06 Jul 2026 05:45:29 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:25 +0200
Subject: [PATCH v3 13/20] slimbus: qcom-ngd-ctrl: use
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
Message-Id: <20260706-pdev-fwnode-ref-v3-13-1ff028e33779@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=myAnAqwQCy13zr91xzLXDTsphXD+fJJQlPI5uzrj/NA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M5z0Ug8HOo/mkHEdX5hdHAVCCSCQf4Zf3oX
 n3oOYxuHpOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOQAKCRAFnS7L/zaE
 w3iPEACZdFohB8aZuD4IW+KDeK1lug9YxM4fLxuZ9O6Yfb33xfInCQVl2ApM5yjOlYR1aCd0+Qa
 AbVaSInI3iaPi+SncEH9JMf7ZTeRmER/WgArjBmflL+CIM7gxLSQU6xLWGauYhQcgoT1sTgEB9Y
 dpaBCfKeYebINsFU5fXn3qZlFgPcwdZmhf/B5Xaqrzgev8Nia3f6SMW97i5ZEbJ1h28CZk9ZgJP
 9RrwhDRTVnaeug7Ijoymji1apZrmeLx7lOhjnkCGfWU1TaiNKmD9k02kNyDV87OE3sfgIldLUYg
 q3QORtezKqe3rjZ4tcZuK3SWxhXWnH+8XsmALd9gO/Z1sKlu2aNRuw+1VB6RyeiYwpzdpW/DBLA
 49Bb3wFrM1kV8E0mDSJwkFGZxFntMCoOMzdNpwfy1pgqN0F1w9EeBAITB0EpppPvfmP1oXDxj9Y
 rc1Fjv7Ynb3T9JjeP27MuOV/9qSxIf+yRFC10bWS5y9uwjhG65wQxbKen0HeyfOX0EWaFySASEl
 dU2UpVJHwYe1sFJzHyEsuYDOzfI2jkOt1+X6qHmvI0pROFoHdTZqwqdKNc5nrfE5rqfAKcyBojj
 cXlCgI+BzXTtkebexgsr97tfEB9ov7RHoUHR+zYPli7W0sLhdqgM3IOYnY+jcAaRHOC6xkOGXTj
 WJkCB4LVwH2aUgg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: hjTMRN0d9nbQqGLdpDcwDBJoNvT9elQ4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXxK8CpwefdyVz
 NkCiyDeW7XzI3j9sRd6bWcMPfPevf6GOR+2Gc+LJYMjx4i6ZJXhFho6+tVCYeezU5j2cZZDQOkx
 oTpr2C919oDf2tatHClVxHXmxWkt7sI=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4ba36a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=NrPIdse2iluhyRvnZrkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXxpj51XPOKAiE
 1QEGpJslXW5qvHc0+zoONQo5enJoJkQVKBZ+CpiGrQCyGuKmZPxPjehdVL4XFdmmjPB2VfCpErS
 FfTOCPI+2W+sk3ywP7M2Tq9knUwVxW6hc5S2EUoA4z/j//hqQJtR63N7Cbl3skWhVe471G8XiHO
 ocaplYM58NaM6K3F9bMPQSI/giPWFHbgjSX38oHbXwnUnI57A8u7W9AQ7F8m/6gIWW4I67vRqdj
 EQDFmd7G7uvNonzb6KFU6u11h9Mv2f1WcsxGeaqNo0WMD3eK37k1NfDi7OBkOdrr7FDl24W/pDb
 agx2z/SvJqschCdy5tJdpgMJPiSDUO/dd4sId70GoLj5fGq0gSK4g+ALqC9SH8JebBD4ujX81uh
 QVBbkvYesERPJrPZomDQGgXfkPxQmAQCDIYJks9+MO5dU9iKYWbH1tMDpYk8MutPP1bbSR/tmIn
 HcgYOtIxlPZ0YgYETTQ==
X-Proofpoint-ORIG-GUID: hjTMRN0d9nbQqGLdpDcwDBJoNvT9elQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Konrad Dybcio <konradybcio@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 3071e46d03beaaae2321e858c564b512c22e820e..6e89415712ce1a7a7781af6bd0eaf0d6879da52b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1539,7 +1539,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3


