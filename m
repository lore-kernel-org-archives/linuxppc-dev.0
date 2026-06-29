Return-Path: <linuxppc-dev+bounces-23060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63682C43327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:29:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpgvm11dVz2yT0;
	Mon, 29 Jun 2026 19:29:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782725348;
	cv=none; b=BfcW4lWq8Llau9OMUc7LIQJf4oM8Z09Oe+PeqjzAAAeLjN8X+qcsGq+1AWuIbI7TJWyPw9hL1g6BZBDcRhJ6lklFu0mQUXW3L5tj3UPS1CLD4xStVlISmIDfJPPrZAltnLEeJs3SURUO5H2CcEoHUkn87P4xAIfxgkMSxKSFbM8nv6tHRK4Cpo5Oftj8YdiyGaNlinZGSfg6HBTw1jZaKPm0LoHTEnE5cbs29fp4bWwaSb3ujQQCzAnQfNNUPdA5wQnJldzAZcRb+GU7Ld2WvruVpmlDA/pRZtti4Vv6KBczs2b9SVxMFrqApC7B5tMo9Zci/tkDvlpQ/wfq9TE7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782725348; c=relaxed/relaxed;
	bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFT+I09d3O2tF1dYXRsTO6FZ002bW49lpWojE4Zqr1UvXlyzO8ZRQqud4o/V5SazU2nkNGSbFyhookiop0zqrBwORTwlhd8Jb/zbdknkRbPG64leRZav0P5rXjpjKueevALbpHqU5f4GGiu2SgypGIR3njCcF7lHY/fZktsyJ0fCrH+4VSz7dZ5qaPYukq3ZlSArbV1OQvzH60n7R/pDA+a8eIt38swvY3E6mRpPE8rAmbTkKI9a1Fh7/dANhSmsvxSexhvNNhvQ3BflOdJ9GEoFKTPtQOAqUSX4NQkqfybcQ8MctYeySzpVK3GNK/uLGrNRrozBvEPzjWGfyqG+3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isT3VW3/; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jFOY1vEv; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isT3VW3/;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jFOY1vEv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpgvl1W2Bz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:29:06 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T9043B2433806
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=; b=isT3VW3/K/PEvzSt
	0eA9gwQkZ8kGNcHXyYP/wm8BjPG1k2/0bZmE8+1VRn8sVkzUKeHuemwQ+7Q6iNaW
	g4hP1vbZNgohSVU4LwijTPFCUGCwC334q+d9wkz+u/1W3s3Bry317p/IMW2eXaNo
	9/dY+oE+w3vrNs078sXFz/YBaNmRtbCOJkQ2fp5B6/B4hLkNSvAr9oFxQwffENlu
	187qH7MGU2hi/VBn4z3yehsAJt2rFyyiXaSj7y0CPtxHy89C8wPDdEAt0M9nidlf
	qeXHCGlQa05Wx+S79iWEve+eNIoqX2EK+5eUadVOBM8IH25kg/oxZwFqn2kJRM7x
	vK+4Gw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper1y0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92da6f3cc81so343161285a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724381; x=1783329181; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
        b=jFOY1vEvIfz2cF4u9bHj42AEucUXGs1dF2Ua1Qo900y80nWy/Ur2o6TpSIc2uJykUw
         Z0wIeCivplwc0CFLX6qblYFsmft+1JEeLB3l4UQNsBAesa5DtXEFvFpOVMAJCnHJddmT
         zBSrloFkHHnuqzmAHun4ZpBaMZE8SS/2lrUFDXnjlNippCOk3SoKdyFVsnUV6ooyRqs1
         2mgcslXDKMOZ0JnJAaAGsdKPO40rRk6hF+cZJwbum2+WgBJOGZRlwfPyULnl9YD6+U7s
         UFxWi1a5jggaSoakGQsBsFdXnlio87UAAb1MWBNWIg4I41ZD25sqOHMVP07IEXmVjwKo
         f8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724381; x=1783329181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
        b=UiFIBm7IjuivjIsFYwlHa/3KZ1IaFiwVUNJ+NdLaC2+I9v6UkEbebRghImMQpVUgv8
         adbRU6mg+//TCYTNgnKTMeSASCHDj3LcAx0zx2hc6VBYzhW/9oXtQTVma8oAd1Asxbyq
         xQ0iABsYdybofaeOw+HPdfTfW+MYU42u7/Dcq4xYo1VNIHpnI1IqUY4MR0QYOLnRXBoz
         lzpBYonHfELyY9uAstt0V23XpjxdnqEDmQp4zhSSOAcOExxcg0fs+gwDIWhEsy71ugNW
         mFOsRq9uHCmkxOAP+lUsm/CKoOI8VtD9hjWTtH/UZ4+ylzHGbQRst3GwGIbeUdKyvbOX
         nHAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/A+D4iV9QGeVIWH3i2agflA7Wdurlbmt3FQlC36OHwxCNunK60C3rWzbq/88BDDR3Wm3CQAAJYY40SvIg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1/YgaXrJy+8S9Q4vH55+pFO1g/PlZXTkuo0hadm/yE0Vke+Di
	KVDPu4iPBDQ+EBy0Rxx+XG506CTOYD6zzNHGeWD9v0DvBmAF3vVFWiXBFB16u2I81E/DMjyWEz1
	M0iUMR8acpldYx40IRQ/OnmZbBfJi7ioDxfUZuKIgOR3CLupNmZnIi/keYIbqGkri3ZuG
X-Gm-Gg: AfdE7clLfLbGp3VkCXzHaoesSLyuTIG6uSL3RsxByOie5q1wttZUe7WXAHPX5En0gIv
	xhk6WuAog7Qmh7Yv1aOJWb60+h0efz+DLQ0JxXRGnqNA/4IxZz2zjpzHdkMsuih1sfTZQfT22mc
	zxS9awFta3wSWhEA55YK40tMCatzb+kY5Et5QlTJwIPaIqS/TNXyL1ea/8mATCfGwOldiLMOh5i
	g7FNZn/cC+3SwNSNmlrBZX1FoI3d7DFZ5LJkkrk5M/4G3Z2rJ4iHAcR23TNViQWva5YmzWVACm3
	lWWUuAwEYyE5ASHrypYV12h8DuBZ/ZeXrQ5SFhygHr1GQoJg64eP4GNNb3L4cJb3k9yrPmAcs2F
	jgaAh7Q9leC03EL7abEafLhc7t8Gkd3Wu8KgZQcSm
X-Received: by 2002:a05:620a:29d5:b0:92e:46e7:79a with SMTP id af79cd13be357-92e46e70a7emr695286185a.2.1782724381104;
        Mon, 29 Jun 2026 02:13:01 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:92e:46e7:79a with SMTP id af79cd13be357-92e46e70a7emr695281985a.2.1782724380556;
        Mon, 29 Jun 2026 02:13:00 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:12:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:24 +0200
Subject: [PATCH v2 01/19] powerpc/powermac: fix OF node refcount
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
Message-Id: <20260629-pdev-fwnode-ref-v2-1-8abe2513f96e@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=d5jcui5x9J+nHSVyJps5DuSu5oenM0O/Al9uUGEdnso=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcGKkeSuvIIpV/DPVwpxHoLTRKrAfS3RpiE8
 glH24pgdmqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3BgAKCRAFnS7L/zaE
 wyj8EACLmIPboyJTTr0o6LOahtd8r1OD1ezaEmjdr9MNJUTSB3k2wDSW0EQmYLVfEyIxWFqTHHQ
 5em3qpvbnfRXSUTJK47zbWG9K/UnsiqlMpjX5BO2mxMlnhYLAFPyVULoWSYAo4JfO2VgNDIxVPQ
 NYJNAPo4fTyS1JEL+okr8KZYFPtT3oUZ1JPZCcrrYlcxTh/PMXG6kxw61fR5aPve3RlVUy4q+cu
 xDHqpPRq9+YS5DOUYpIJ9ufFDc4vabR3feAsDHsFOQqyqXY7sjjr90XFN2LLwl+PI1CIDGSY6L3
 whzLq2A4djBjppjKi4TTwI+3zzMKrtFDRigP4zS5NmCdTy6qGYl7JwcDlQbluwfgemH2ry9a+3M
 3z5f+rfhXQNTX8/esd9xzkVFTaPeL8ICuj1FxrYaxXoeTFqeyiIketmNBN3700viVsmhjoRgbe1
 9wSaJr2PxNmod6oepFw5/rlmqPndAgbwuSsvgexu2OziA4AgA/oltqCHu0SanP3qC5pEAy/c1du
 cr70pKyU3od2xGUpnPOkWsxtWotnF3EVvY5Lm2TcMNoj4uQLY+ursm0qNcqoGpJc5ct99YHcLF2
 tuTPMUvUHkuoWGpprlKF8rxr/TJgkGTao/Eah0YjzNcsNjZCXfJn95wN7lxX4tVoQLUtvLmUYCv
 b4yTpi6iddu/94g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXygMtQRdHfVFt
 HmwkUQ6a4DwrGvsE77fKhbOSXbDwnQLb64V9yjdCISDhyVsFvmq4Y6ZNBHGpVz+nFzb0IwJusDT
 eXdiRxfGIUsDN03jnYCNyjwoQBuvAt4edqeVlrewcWSm9TM4T6KXHTE1A+Ocaf+KJKlmIy3UeQq
 tJ9gIKSXGtZSDRmBt7CXk85wBMIyIJaPCyjAN7LTTHotyDrvbO7qjdfItDHL8+JymQEWu1vn+HF
 wijH3cDcK84CrzAh+iyaa9aVUC37vg3UIhvR3MwOPT2A7M+FQZkC047VzT54kCl9dirZ+leGmZ+
 xPuOzLOGLcDqclEN+JGZtzfbHVUM1zC34JdqABsNcWBcgeXNei763sGtkMX3sHg4EJx2VXP3Bze
 y8uOGIA5NTGrqEMTJlX2xXcVeChOx3dOIvbW301vkZ/Rs8gE/+ufGSTutmo0xw+rWrU8elQW9VW
 lAXk9fsYaoAdNi8OMSQ==
X-Proofpoint-ORIG-GUID: b5YPjUuhbJ-3LJzbxcJVxjIeaPsrFb0z
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a42371e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX7OZk6J6QBOvX
 grojIBUuQrqTJ7B9zeaSi0fwFJUjXBzupt/PU2ZPia52WGVsw03gqf2jcIQVoQ5hOkwZUOd8wV9
 DNWyOILtqzVBtbdMKK/SSLA2jt4NvVU=
X-Proofpoint-GUID: b5YPjUuhbJ-3LJzbxcJVxjIeaPsrFb0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

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


