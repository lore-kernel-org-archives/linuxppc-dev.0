Return-Path: <linuxppc-dev+bounces-23617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CF6C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3x40ZBvz3c4C;
	Mon, 06 Jul 2026 22:45:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783341928;
	cv=none; b=L0E0tUNJgJWJi2JCvMJTk1pd9YHNqLcr28FQiTZNaXP+dBN3Ij0XSh/abxsHvgg62NP88iuNr8sWtPz7DCXA1UQhddm6PZkgST640qZV9arDJEs0I02wYoZpnas7GL2+ETS8ca1vm0Ao5w4HFN3PKC0n5VZSgiJK61uzA6sqDMj0py1y7r26WoPMRN5v0IvvVEJp8JdwDtfBB8rSNWaUkL7L5K0ATXoAd6XmOBFN3aAVaNzReYbySf1Ceq81Q7V/hmiu6sujM2NvHtYLNtxQa+61pq3mU9fOe2cXlNLwt6xXnMl+OpoILnhphg5yca1ShneNZaJIC9i0V2rci0Gubg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783341928; c=relaxed/relaxed;
	bh=cXUi3uXAyC4OxWqNWLbh5atOLaQPfv1B39yCRWJbLQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/pUDrboQaxkt6AH78pkPZ14EOfCShIidpPqJnw339IOa/Edsj7e4jz6AipioVwbqwVC/uScvfqhjTnSEDLx13Sh0B3E3UbDNhoLReko/UdjSaWxT2OCBF6+C85O94egZf91RZLsgDrErPi29GqfrmyRAvQ7Z/uXlEg8T7GRZgsoSZVoOyvtSiZ+D+viLtmFs1vwDlnNnpos48za+6vF/zmUIRrwGQO7IOUYGBJKH6sYd3m8jn072twazFku6iNeghG3Y6rBQqNpX0HhoTXrYKwcETGsfKBBYNJaixa8O7ANxF+s3r2I+8ValOqWHolnBce9PrbfHeGe8dECQPFBpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iwyNy+Ih; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CJIKLBr3; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iwyNy+Ih;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CJIKLBr3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3x31ZVvz3brN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:45:26 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxLa9218452
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 12:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cXUi3uXAyC4OxWqNWLbh5atOLaQPfv1B39yCRWJbLQA=; b=iwyNy+IhGsX+O0T3
	2kGvU6ImOgg8EjDd1o5sbToLqJ+h+J42bWw11oOKHn2iza+sGFzhlFcYywkcJUBy
	HeSBI+6jTPzl0z0WmeufrDDA3k5b/geFNZabQnp2CL+Ab9ynYk2AcTRksJQ/+rYe
	E8Hctc/S4ThFCUuD1dnULxTglMrmx1+pljFRLfA8vCQppBG+3/6+TAL73/TG4DsL
	cBQEsCgQEGltOsP0Mr8x83YCo0df0mU0GDYCtse3AL0b0s8CO2JFE81P1yUgB4qM
	HoK/QkxTOUS1TNlrlhR8hFCSBgrY6afF2PMam+drQNByb/XsozJ0CPCVjg7gkHjq
	5vYUhw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs93e5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:45:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5fc4c7e9so325856785a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341924; x=1783946724; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXUi3uXAyC4OxWqNWLbh5atOLaQPfv1B39yCRWJbLQA=;
        b=CJIKLBr3Btlki6exw5kdvXVd6QBVnlo4lyS/fsPN4dGTKO2ihNq2tx5iToQtnm6TDE
         gniO1xYfxyg7E67CHzez1xN9OMNwCZmA6dPbRZHRl6PlKuXqLmPgf4vmrP7JZeRUWudo
         LZ7kaEEKQaYnTe03yZiudy++Ccqqui7+OA0a9yvrzankRdpbv6+j4M9zb6t1lcLgCeuB
         drR7iDz/YSc/9Cn/HUAjhrYNXH6msO6+omb0p/5ccOkPrScFK2+Mvk4rqzhCbrx9My5p
         LOkLhlz/ex1JmlQxmUTUP260CasCe6Wr4sHIbzfDwq0V9y0GMVHbiwcKWLOGyGbdYOvb
         dLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341924; x=1783946724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cXUi3uXAyC4OxWqNWLbh5atOLaQPfv1B39yCRWJbLQA=;
        b=tM8uKY/OSGlT62HXMQ9c3OPHg5lWuM+kEDoHP25B1rv6dYz4Yk38UAFkAXIZuiLT10
         B+VmN4YXORb+CP5hQF33ZgZjNth4U1a2Mwm1wIqPGE4hlQcm/UVlGKftOn3nPEpJ5/VN
         g64Z4r6sfJkpK5VtFFMXrbF1OesDgQl5l5G8y95TLrgN6eElT48aiGQaaec0A6vmx5gg
         czHLB8EY0y5lRVPr/QoDzRfrgTure8XOC0ZlXrga87P5AYwNUJgT73G9VW5eYL6Kmhv1
         LUqEA6r8t4Jy9L0d8Awy8iclHaZJHdXvCEq1+CQOaLG3DuVt5Kabrx9IJ6RtNUQRqgg+
         8YFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpveXcGCj+nd28hNWQUC6wA6JK6bnw7ywj4JOvo2dzS4hkXIB9Jn2TGaebAlvB7WMKta1tjtWsXlcTZoDw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwUrrt7R2eTnNIms2i6uLTwAOOapNZ5npHL9jgQ0hc/rueeOSzy
	CKqhv/S2TNUWRl2FPCSwbP9Bdnc9TamznT0Z0HAkiTTpckKgdPWoPvaopLUGKxfxrUt4XIawiDD
	tZvsjl5+MR6FIbfixLayYl8lRrd7GmhcqX/TBcyVaeKa58rRtCX3M72TdJm/uHYVcRybl
X-Gm-Gg: AfdE7cnWUf40XQmBHjyiDNNn4CI45XFokYnkOh/zSUaXyHQRFVYXykYLhGjlsERLhOi
	cE7verMhbUUqhzS+XxU/7gsOAB+ZQaxhDihe9JyB6hdPvnsZ2CbPMowGYIgrVk336CNBwo9mtg8
	j5s+g+aF6MQAKJzFaumq2Hn1qzCWmwbEl+eCqHt+7Xrbv+VoeOxbdqa3WBxOPHoNMy7U+er/uaO
	oBAxqTr/bhLkaPnYULIUUy1ONn1B19Qxu4VvA/FmPRa9qRtp8KMLrZfeocytQrxBxtFr79PbRZS
	k9GC3OvZP2U7wzMqkiS6nf6VKTpnxSQHgI14IyAq09WcDLpcm0Ikt+YvKujNWoQb8EANrMQpOXS
	xkQPd0HhvACksOkTX1fQgeqqddmZ7hBiv1cVBmQDH
X-Received: by 2002:a05:620a:45a5:b0:92e:6a8d:38aa with SMTP id af79cd13be357-92ebb715eedmr45289185a.63.1783341922247;
        Mon, 06 Jul 2026 05:45:22 -0700 (PDT)
X-Received: by 2002:a05:620a:45a5:b0:92e:6a8d:38aa with SMTP id af79cd13be357-92ebb715eedmr45258885a.63.1783341920254;
        Mon, 06 Jul 2026 05:45:20 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:22 +0200
Subject: [PATCH v3 10/20] net: bcmgenet: use platform_device_set_of_node()
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
Message-Id: <20260706-pdev-fwnode-ref-v3-10-1ff028e33779@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hK6KuPL0Fkp2tcUxylzP/EXq5M4YtzoXDw8O6icggM0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M3t0pRyIvWtZ3y9/kmYZJtWQnTZ1JwDAy//
 CsWsDHHr0OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujNwAKCRAFnS7L/zaE
 w63wEACOGysngK2nm0QicOyzdn1brppnkLrfHtIsrAcQ6K/s6NderUhLDryX4rcF0Rlw6HmXmNg
 epZ48Mx4J3UnU+PRjfDrDnU7GawDhxMjlqB61QqqSdtHlPaKbywufH/xrDNwSFspkipSNtateGL
 pbsRAUIsu1IhDvDMuRPtomMEHwKt3wvaMhy0QEkDyZF4RLJS1NjqlqECOHe0BRxBAP+OmuzQTpa
 oMxis5dLIqamCrsgjaweckAFttguLVhpVoRa35V3tgqh6G8gMSA3vYFajE3vVwlk9P5ts3bhHFz
 tSISSzP80joTF3QF3/3hyxGvP1lF2NUBgNAJ5TISmI2kZoyGmzcZ2XDRgjMtgfxjq6xpnwDjRIG
 9nKCfeqppxo660tr7LATQCxUco2jllbHz+6ma7aeybYxfpCvOfBoanPl0fme6v2jXuG0kA7S0cg
 Qig0wTZq3jZ+0WRSOK769hUG8E8M+56X+vajU1q/woTmsvsIhotoZ/IPu3Q7pTh9TZMfRHz5tYg
 JfQANXNXaMH/V5XUAU4mzYNu7cq102DojDBd6q+pQQOUvFmIsFFHwxAPS2aUMGWPa1Cb/FdACap
 rNKF8e6iN/oRaSKbqvIh7KwkYlPtsbqdUYAP4dxlBT7SznOUKolCzhD9ioxnchcLdrjasucBuUZ
 iHW2JM94Uq8jnbw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: DNNZZ_ow2ozJonbi448RlVEmJwAXYPLB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX6Mq1fhXUEfto
 BaZ82a4a7FzB3Y++ZWNZSrBS5CSvrscpKJVLTuJryNMNrTTgON6pczpHXT1S0+5Q6k1X6rd+ZJH
 fpBWAm6HJ0cLh3ZVtyj3vg90elv5s8PPk+73cjl47wUNRhXsZHmOXnRd9+8238gyVtIfewf6gqU
 iGmDbBTU+KFU/Vp6TbYKwAZR4XN0BilNqZqO5Qc3BDtgKAiTQ+Dm+CczggCJT4IAgg9S84JciGI
 D9athOMxHInHTmzSouGzKRKHZCDaGbuEsAOivsPFI82YZbcpEOQLHPpMq4C9vccobYDDsRF86q5
 vebp4Bizi3km1d8rt1+JzxtQzpAeiE0YCwZGgwuXA9YpFPtC+dwpy7B1k4O7u7ih3Z+MtC0qK/M
 3ucdPT0VCELKcjf5F/IP+akRl+A8fYlhuJMSEumcQHdfxRpbbpNla3BxSDA17zSplcbmwi4BhzP
 fPxxwNNcPX1HCxyaJDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX6Vmz37BhMZl1
 S/w7hh0m7LATP7AAO4hd9yeVqCt450BTk50P6n+Ufv1tdSb6LKzFGOH2aYb3sq1E0VHwKEo71Qg
 a4Bu0d7j9vIQ32qYrt2awPQtVWNXjdM=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4ba364 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=S253l8tU-mt40G6jxkYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: DNNZZ_ow2ozJonbi448RlVEmJwAXYPLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index a4e0d5a682687533a1b034ccf56cdb363d6b7786..0f0dbabfaabbce3469de79af91d7731b8476709f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -490,8 +490,9 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	/* Retain this platform_device pointer for later cleanup */
 	priv->mii_pdev = ppdev;
 	ppdev->dev.parent = &pdev->dev;
+
 	if (dn)
-		ppdev->dev.of_node = bcmgenet_mii_of_find_mdio(priv);
+		platform_device_set_of_node(ppdev, bcmgenet_mii_of_find_mdio(priv));
 	else
 		ppd.phy_mask = ~0;
 

-- 
2.47.3


