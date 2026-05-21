Return-Path: <linuxppc-dev+bounces-21291-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40192CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:37:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhc5648mz2xYh;
	Thu, 21 May 2026 18:37:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352645;
	cv=none; b=mpoXjBt74cDIJSJ7HjbrjhAbUgzds3P33YG5TrbTKocsKpGU4PNpzqZ3r7sxjbdJmYBWN6LXM3KcS4yMATeHMp6UMjXGML1Dd3PZ5UPK0on8vElpGeJbdC61m4ghxCtTx+QzwVxzuSx+AwoEPMn9piVuAC4Q/6/nKh3feIyo+NaT6cLbA05rtVyMBVVywyjZo3PVQJaKlGgx70HR7BflEhiKI/NKMyjNxF0vZHYGphWo64fdktY93kaDc/LZyYb4sg89UcFHgL0IUG9JPBHqTLyv9GM8DNVwJ5WDlgPHDx0+ZZYnE9H9jdD5ca4z0RfFDQ5uvCnvRoEX8+6KZUoucg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352645; c=relaxed/relaxed;
	bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Amu+CIkagRgTICx+zwKpwkXSGvWp/1/b32TW6Ytf3hVbpTY/e74+rBFm9doeba1siD2Ze4h4vlZMqOO2yfDPTP/Qqfpqwrp9ts5F/51ywwB7cNo5q+iLMPc6x5RVt3YhYKTptApIz56/EYV7RR+4jKlhR7jjzQ2Pw8tQ/37k0HzPzZfhjF2FZLbo+RS0lsjdqW0GIGstj9u4I7WNtXLQTqKFqDSkuYDwOJDfozei1sFKFg2v7L4LVv6lWqeqz8PNxrQHMY+hftSMUD+zONfn77wNwCWlXNkLyKbLIGbW3SfYOrPOTbLE7VUsPQHGoUIgruv4d6qWx5L1P2aDPL7U5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SdjF4a++; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxoYgYKL; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SdjF4a++;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxoYgYKL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhc50XDrz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:37:24 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6CDEA2157882
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=; b=SdjF4a++R9b8Imh4
	M50gCFCW0es8kE+PRhzsu2IUk1csQfkF4V/6z7xG3YVTpjNfX/FdQgJw91FtGDmp
	k9o+F9H/tC9kwoUMlnjCMAzagYOfOb9z4PpX90oOtPpjcMhtCJ9oN4Zi67xTunYr
	RiCN3SuaU53vG7krEpjKUJicnQdvkOsKxwNxHDbUGDL3G5h0Tu5B+4wjQwKDL+gO
	Kg3xPNU14w4iBOj8Va9vS1r1drJyibztFx7S8CVulTr9f+zLqNV6/DB/o/UCj6IG
	dWnVFr2hOHZp3MU38CH3ubZG3lkrooNxrIQn3SErxclSxBUFc3foFsk/iuC9/aeO
	3iX1kA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma428vj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 08:37:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d890580e1so127500621cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352642; x=1779957442; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
        b=bxoYgYKL8hcTkG2bCtDfRFigQOty95Z20AkBBx4TdM/BxPtTc8Zx5RrNUe+Tm8txK8
         u4sGSqTJ4DIByWiZSQm95JrVWjvO5eR9Kj8sc0HFTzbToXkQBvvrJO1j7UwZxeYQk5z5
         OU637PShXq12pLwMdGt9FWz+9Nl1HbRRY9xzj2ZlVOyJxX3i1AwWJXoE0GtY+emiBeHd
         2z8+nnB4D6NryY5quPvSwbMtSjubQuhqFgHskRuGQNcmneDDC+7mcxGC/dzRUwrbZrdv
         nLNHnI9IumMRg6BcTWHq+QgN6p1IJG4V2w9KbDbC3shSpCPcJ7593ozy+C5FUjsob17h
         1SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352642; x=1779957442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
        b=sIiXy9ovVWHvwrglZDyX+J6fQMNvbyZK+tAvwEPtzM5YaYEB6VTRa7nbmUN9tLsBLM
         P5dnX+9HxUhoh5rC3/12odljd9GjXUUSCXwjPY38easxQ1p8DLXy4P/TzzjY6FNCUocV
         x7d+++oUr0z7QCtTTSWRDppKS15ErDcmvjy5XRtj1U7OGG+xrrvYiVt1BUPkUO2sNx3V
         wXt0/wNtEF9tCeRiSNgj3j29KGovKHHj6aJhhO6Z7BQPZnZcEH5uaRe+BqDgOZ11nXu9
         6FCl00DVA5Ks7QKHCc4Z4wUwYRIkDLsPO74JEsw9xr5cOMz8SMtij3M2dlL+nfdFdaE2
         95ow==
X-Forwarded-Encrypted: i=1; AFNElJ+Vjb7Nvub7Tqp6DHk4TRUt0xwh7KfKkN4sXE7epIMorix6MN3wdSKeJtSkMvuxyjq3nTM6CqnDKlDXs8E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz46FbVN4w1ngujVvpd4GvdxlYg0CNFI7D0nwLwxwnTgWkl/Hym
	E03ZiWTQlSXyW6O4LOW+cC87gZSatDBy6CSq6CoZsBxkBmzNaQhol22F40nHh+mNkedbCaPAHjg
	EnXsYjUu8oA/L1B5VdO3GODrMKJlEl+nQmXogJ6AhKztNDkgKxfdkLn8+P7rNCTrkmG4Q
X-Gm-Gg: Acq92OHQVPOZ5NHlKdGyYygRloD0dBO3DGdNTpyAW70K3UXyvkuwmBm+8Dkqkza3ije
	gyoUuv4MdXrdSULt1NGMwuP5+aRMdzp27Wd+FGtUPbLVqxWUxJW/IQ/IhHfyF/y8UIpTccDgbOL
	RuuFq17z0kMJLr3bEuw31PSM+v1CkCu+rnU3gfAkqYuJ2WHOibO/yXDRe0rJdBUX9BkFNyeKVVy
	12xVFvBd1V0ygGxcqUJo7pt02BhOaAvMvhU/sdUOgX0QYdC+GWTBxGfAQ6sSRBf4sOx6RFc7+Kz
	zXwnLHABd5znQIdkhxI2qrl+xp8WHkn4eUcgURtYm1FgGU/RKwZqm+3FzqayQIOZUEf2OXBl/8a
	eCeiZpwYi8bmzJNVrWLv+IQ/wvE+SSG+o812aGlokI3KU2U5yU1c=
X-Received: by 2002:a05:622a:2590:b0:516:51da:ae52 with SMTP id d75a77b69052e-516c555a195mr23279651cf.33.1779352642342;
        Thu, 21 May 2026 01:37:22 -0700 (PDT)
X-Received: by 2002:a05:622a:2590:b0:516:51da:ae52 with SMTP id d75a77b69052e-516c555a195mr23279411cf.33.1779352641766;
        Thu, 21 May 2026 01:37:21 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:28 +0200
Subject: [PATCH 05/23] powerpc/powermac: fix OF node refcount
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
Message-Id: <20260521-pdev-fwnode-ref-v1-5-88c324a1b8d2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=d5jcui5x9J+nHSVyJps5DuSu5oenM0O/Al9uUGEdnso=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQiYCDxIrOzFNRB+zSgbriyAtuSvWozaQ6JP
 bdrg27xjuCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EIgAKCRAFnS7L/zaE
 w7SsD/9c6wDjuVBS5Sm/VFhqZkK+tS0GvHXg+zY0D2yyFaXX4voIhl4oa6+psFsIHJX3kjbj8gk
 2NaBcZj5v5qpmW4jExZj22fpTdHOKFtVnDCK+8UF2T7u2gqPrZwH7Y8YQBBFHmQGJLOoPuLHZSJ
 Ic6H+lisu1XnF+Db/iCRftzqK+Yj256ww6xHyvHM0eYPDKNcHh5k24Vw+F5NmEuz8DDwWPy314p
 sKpJutaZQ4VvhNThPdbll7B5GU2V9eLiV6uG3hDBVj0rKkZETI0tpdV1i2MNBoLEEmjm9lLgtxS
 H/iU9SJJDHlslkgKRK4iIa6Givk4naromKliy+6A89h5XzhSVPELLtqZVPirswCcj38GXkDDNhx
 XdQFVaJ/Sz0+LeyiysiFYFgpV0q2SxNzEgM9dj/cin64KeXZn6O/32f8gdOxs4tbIcgBGZtHonO
 wlf4CnKF8bhdmRMTSssJYsH2zxYaYoK13u9LnsjPAmWUH6rRYorVVYEj5qcJh4TgHv2isVLkrU0
 DrfnkK2UlqMZmTEfCWPTz4USoMsl8R3ve3p5uaTZjKaxhuvE8U0Ok+U7ZGIMSMm1Y20I+yP+qFo
 WCb4cP/9+Eh3SybOcfnPyGnHxIFTEkX+zZNkZvRTcLA1Ik/aJdRAh+FEsokxVsD6vhm8fvFsvIk
 p1kCeIIqXvMimtQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ec443 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: eYG89ZSfCnBEyHA4zaOfzS2ZY5QrA_TV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX6gRqEZkOESFW
 pLWsPlKEuNYllT+ORPYH7z8cGf5Gkv0kjlh9e0azKNt8iTX9kGMtmIiy5YKQ03Z8Ll0eKY18SB3
 kUH+8EkpTAz0GZQAsJ3+cMutjFfkdyyhmKuzVTusauG3FdGw+8ZtAJoGgJVxHm0UkIeK105JKRm
 RgiI2yJH/IMlAX9wg1ZEesy9Eo5iG8VGjHBJo4K+9FqlOs3Ne3rHLOwMtG/ypMSjouw7mRnLim8
 EFuOCz6epo51M2Ift9F6tGXaM9/NvD/70Ob50PoRvgFehVaAAozuNw6u+sih4a5nwQ1LkZzToC4
 sAjDQkIoNeDvwSF3ZxL4d6BHn1j6X/rNDrmGado9Jz0Tmk+2XLw3EAn/UxRPMml/jeul6wOgpZm
 hEdrTAUJ3Bws2Y7QHOas7P+36snoRu9vzwMqUttZKDoAZEtv5lxCdcIf4f4sFWxKyhh0tw9hun0
 XBdOSNm695M5k3P56oQ==
X-Proofpoint-ORIG-GUID: eYG89ZSfCnBEyHA4zaOfzS2ZY5QrA_TV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index da72a30ab8657e6dc7e6f3437af612155783d8f9..973f58771d9636605ed5d3e91b45008543b584d3 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = bus->busnode;
+		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3


