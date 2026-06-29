Return-Path: <linuxppc-dev+bounces-23069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C49C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:43:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphDd2wpDz2yT0;
	Mon, 29 Jun 2026 19:43:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726225;
	cv=none; b=mR+6zaKj9puMcE91H6UeMDAmim2gNaIg0AJfJ03uDyeU55OfaNMfHoPt7wOfFlET/X1f7gT+sY7OrQQH9bg6kYOLXc/hvpY334x3nXphWL1CmQYITuK8W5F9wTVxfMeVjvyXPijzWNYjbRN0CyoyLF+O4DI5ClA3KMdHCXI9Dsimm0zQP6l8k4S1H+Mnwcw3R+Pi7GMUU7noVB1R84+q5UmjPZO87v5bsfiCktSq1pLfYAE1bNSDMpuABdZno//B4ZgbVifJ8czxR322GiGYTL55O69f470PsWGWYHIzvwuPrS+HKNVXU2uP6bs5JgtX5TWJB8kinJ2yGjARciSfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726225; c=relaxed/relaxed;
	bh=DAKuWZx+T18TOY2rS0sRqaqFYEplRl6oHhyQKHcNh0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHaSz5O93NkIwfesRoezsk98MX53onAVpEFiUL6NlXLtvmoACAW1xUXfi7iAdpTXJg5ksqnk/v4B5Lzxd/BKS3l3FuxChdGckDqRH2nPsOtspzElL3CrrQzAC5Wp2Yieo2skTjA+S4bLxD9JAiCFH3/QoltDwkHTjYo3e/13YTKs08zA6Fd6N//grW7iqyJ8di/H8wCossEadmj4jYobftM77ENaH9sMRVVhxqElpm/olJVrbh+OF+rjGxcBLMcM1iHBfe+LhHNZey9mBH2eoqPIVvJ5iF5EMk40opPQyyd2jMwg7zwSuKS86I+5En8b6WZoeC/uCIzCTTymz0CCng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mFrW072M; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LQgaF6ab; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mFrW072M;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LQgaF6ab;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphDc367Yz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:43:43 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8wY8o2391272
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DAKuWZx+T18TOY2rS0sRqaqFYEplRl6oHhyQKHcNh0c=; b=mFrW072MsUbz2SE/
	g0JY11fw1mkJsULAeTn25ITeMacgLdxqboxaoBI+qy0hki0UPL8DouFfc5NnmDFT
	J+RJLr/CCXP9bRUec60EFi3Tu4MBN0uqYWYR2mYS02xSypb0tkHDA3MkTFAzyC0z
	6SBeq+/95E7jnGnVD++/2rMl5NSUarslg5T9suvycoQJHQp153DsgNEVuMGa39V/
	dtgp5KxwUeztYoCBPeIF8MIkY6VM7Oc5qF9H9PiGZwdtFOKjRHTUBMTyXOfC3ePS
	Q01qZYGevpPULHIJxnQRYWoOgHtv3UMt5LkyC22Va5x5IsoM0UwyT9hjSMWkPEM9
	u0kyxQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw822q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:13:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ad11e2197so578846885a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724400; x=1783329200; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAKuWZx+T18TOY2rS0sRqaqFYEplRl6oHhyQKHcNh0c=;
        b=LQgaF6abpOz9telP7BeeIFQonQija3CRGd8HmMxHTZMp7r5JptG1QaOcVMBT8pHMeS
         18WIoYBPOpCF5bpp9lCnjUOP7gHFcL8Cm9fJ9mbyyTUjIm9alHkeX7PuIwuR4No8ygCn
         kiKPikTpkRL4xiT+bw+No8MGHgpzcdPRGnYkG4k7/Nuk8ouI9XUt1CKdwkecZ6Ea10bm
         MUIiGWCPKZrAoFmU6E75gf186ofBqJRQOTTraXaD7uceLgbF9DcZwL6/7uO0jg4WWvqL
         KNGbkuo9TZP1Gn8QeVT1Spj9j1jnzASCrsfZm9i0V9xyRvKwsFG45t2WSDT5KmPxAsc0
         RpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724400; x=1783329200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DAKuWZx+T18TOY2rS0sRqaqFYEplRl6oHhyQKHcNh0c=;
        b=Ifu7UallWyTHjWAVAVgvmRjWJWN2/kGV8wJ3iImrLtaySMilD3FerZybuzZc4qKIba
         KMpqv8l+MlvPzBX6maCGKDLgSnS5WuOklHhaY/+60ZJA8WjUBUC/wynqsDc7FAgiqDLJ
         PBZ6JK33dRXMCJW11GG1KC64K+N7YUbGV6mEZvHi5gLNo8VGfp58SZCRqUuWkyCk9WIz
         NE3GKtLi2IkgFpUPADyo1gLab7pFtPGS64w2wje8YptkDUR4/rNJuuTMQIehdAplvbAM
         S984NIfXejthPLcQdbBN9aX/cj4quHwjHyqkycBovsfC4C3vFNRKs3tQouGfvVCE6vpb
         aS9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8DAS+VM9GT7/bH3kkWm47uEntAP6zg55b2JHTzBJTPdc+qt5y5GaHzgVNwCcY5tiSqpoWc+RM9x87epHU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz6WoOmO48CRfVe/h9rAp7F6ol6zH1OllOYyUWgudgCot703Ko+
	hkETOYX4Rkyet0qkodJ2e0zvYVX7HnQSKD7hXLAGklc8gnJM8Ib9HePMmAH252uzm3xGpLLNzu0
	Is6FCNPQwttzSotp3H1XtTMQ0sLUte/G2jvPE1gJvsoutIGSSb2iSBCFbJi5BVpwuIhoJ
X-Gm-Gg: AfdE7cnnedrXXJQvT9yV5/y2JQXQ9N+PnTCJW90rZOf3Rd9NzPuo6d3Mxaz8b1gj6Eg
	2uGTcKTQs4PX6nwCDkzGIESBmLe+YTw5Ne9AMG68EPaASmu3EtvQ2OK/TZCpFjdo/HlYxcSNR1/
	H5mXqEGgHg+YAauRCs0j0rsO81mDwi+16+3nAg1bAHpuLOy/8BUjDx9UXww/ZswiBdhFcJFGhCO
	y2jzJW0xrKfKDt3Amxu7QFz/HAe+Oe6kTBspnArb33jYufJwV15IS17Tt1KBcwRojLUAFbtXkgq
	dPogp4Obf6WNvipHsMlm9lUGQe5SehZTyLCO1FxopgcKjB7AstfLnEZEZlGeufwLDfCAppaPD8h
	D82VBjfn71/NYW1BXXs69Z4eBmWcd14MbQA8AP36o
X-Received: by 2002:a05:620a:2a0a:b0:926:e8e6:3b09 with SMTP id af79cd13be357-9293dea9e7bmr2334277585a.54.1782724400607;
        Mon, 29 Jun 2026 02:13:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0a:b0:926:e8e6:3b09 with SMTP id af79cd13be357-9293dea9e7bmr2334273585a.54.1782724400118;
        Mon, 29 Jun 2026 02:13:20 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:30 +0200
Subject: [PATCH v2 07/19] i2c: pxa-pci: use platform_device_set_of_node()
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
Message-Id: <20260629-pdev-fwnode-ref-v2-7-8abe2513f96e@oss.qualcomm.com>
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
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=3ExHxG1MR0P4M2pmAxXchKYR4cIG078TjIhJpQx2T/Y=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcNxd44/sOnB3ZQUb+HxYFRS/KtwYPACD8iK
 44tvCPGXbyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3DQAKCRAFnS7L/zaE
 w0SHD/93ITElIUICiF4/3GgOrqssN9o1Qh2VzmJpQ3angjTmd/bLPNcbWO1I8zxNcV+bsJvn1e0
 WmAyCF13gxL2y0QjWrRmuAPwBRcgd8x/E6WpSzRwOhUUnrw3APQf7t5N+HMHHSrcfZvnO6Nd+OS
 GyD0SD2lRz6xSq+RIJi+DAvXUq9DLkMdEMcJuqQpQYWYqQxe+qUm9xdGu5wYZkUpOam1ebCKsnI
 t/S8JsyhX8NX0yviOPELnPfeIgHcI0roxVF0xD4hvnAoiQPlfH+zz+7Qu2wCS9jFRNJp9s6Q7d+
 +TIOj8knCk9LnV+0awUwbYrwNMN25b1vwdrtrpi3sWQOJrxYGVcr96Exqg9RjA2QG6IdyyWW0C4
 NbhKtgfxITEWqCun8ekCjWmb693zNn/0exqIIB4yyylN9oGwa9boqjlhmjIUjUURz9h8qNRYKRc
 PL0Bi9zWqYxSQpjGEU0N/Y+fD8eHpYwy89oHInlv4vsydp4pqsWzdre5sCQxAl/I5GDHuzKTA+E
 dfWdX5WTZG6gy0gfSw+4QtwwuxWiLh7nvwksKjfjaHRoRIzgv2bF04OwIg2zvLbchEV/U1HAwH9
 blEe8ruOiEIHHeye1oW7/s6G7sYQE6rB2FOrvn0O9VQICexcIyofevvqa8FS9JR6qmXGcwc3hR9
 S0k+pQj2uVT69dg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX5LYaybDdtO4+
 c1hFrt5o086Wh/WmAQmUJmDBRqcOv3pHqQQxaMTNLAwyNs3sWXgMKkprPMLFdbMA3Q5mDhNK7g/
 j4kpQln204l3jTZROijuzudusX1GKmU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX8wrYUrCS1wDM
 ofdfF6KFJa4wZ49gmU3qtJLDAkj83EEIzPH4GbP8uRcDMXWHbKlnhBEljWG9BFRjXvcMi4x2GtM
 jVlMKzQHi6KcW6z4XVut3HHKvWqqRAR1jrVsbNYcZUDnLYiIinILTeA4VJrJ7jCnyqIbVilBBLG
 j4JsC5LpycvWWmiTrV7MIW4KONna0tgWiKHKM7WH0+8z2VdjlJ/6r9Gc/FuqmaJqWcCoGlKPDhR
 JGIvYjtZxSPEZw2v/6rUwy16MPgfSuHPZoGsFKMbFz9iaKSD//k6ob1l4id1vmP4RFSjpGesTTB
 bAU698m85Y3Tlrfnv2W0zhI57Ux3WXBUd9S+jbp8JC1EJD2CJaN+C88wfQjv5+nColGCoF7DdIs
 BJBmftD/YU5eyVRzAFUnec4N+fsmyPZn1LULbXIPEJTcXn87HbuvP/JuaTh1y3eduy0EOYv5V/5
 SADD0wITfnEwQLj7TJA==
X-Proofpoint-GUID: FCar4TiAITrVwb4l00QeZbA4T2T2MIvI
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a423731 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=LDBv8-xUAAAA:8 a=EUspDBNiAAAA:8 a=aMVJyI47E4_qiwhfJDMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-ORIG-GUID: FCar4TiAITrVwb4l00QeZbA4T2T2MIvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for I2C
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-pxa-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index dbd542300f80043c6bc65a69fa27ca7b3d5fe787..92a0647f08c69f841ca99caca757c1728b3f6fce 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -76,7 +76,8 @@ static struct platform_device *add_i2c_device(struct pci_dev *dev, int bar)
 		goto out;
 	}
 	pdev->dev.parent = &dev->dev;
-	pdev->dev.of_node = child;
+
+	platform_device_set_of_node(pdev, child);
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret)

-- 
2.47.3


