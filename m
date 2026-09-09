Return-Path: <linuxppc-dev+bounces-26956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29F0C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:02:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg3vH0bdlz2yty;
	Thu, 10 Sep 2026 01:02:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=67.231.149.25 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788966155;
	cv=pass; b=UVDTRp57CBfkDGYLwYkQAmZppulkm9RlIbU5T657rPXk88a/QyOASG635iXvEmopZkkbJGwmo+/MlPP4TAWNPUyxhCzt+aJYcrWAu+caQdS/OL8T2NlQjfDgDjJmmC3zk+FrO7UW6Awx5dWBLbolHlSDbDSc8XQ1sASMDUDigQCMI3iy6TzWNaDm6+nXIoMvFxwknTiF3up6/VW0kAE02Bn+UIPrAQl0qbiEXoMorhpW89keCdygZJFOsYRuPIj5hABydmFRdIWUoe2fDbKWRhV7cFz8mqBdCM0Ljd/pubshAGnTdNtZHKDI0z+30uHYqXe6b/MwKJ7BUrz3sfVEJA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788966155; c=relaxed/relaxed;
	bh=iLxABrejSUqDTt1/QHDrlHY0R8rI0yqLu3zIX8J+ing=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHQmSlZY03g08p1eAWE6Ebz4lWqtBPxGW+iUeDqVmKXdQN5Z4TCVAQvzAicdkp64lveXCXL6pqSrCn/OUmsU1HCtHI8g54S/M5hW2sTCVgKqGvezJfsNvSK/aBntYKmWACJXJ+vVDZpC40rhDmngPg3nz3hbtkDYwPFIT4EvTGWIR9OjfxijclrzW8zTldJstly5Aj+ezLaqQPBYb3dcV5eFprRLAGvYeat+hyTk86Vh//8waBckj+UFgY7KN/jaZzCULDCNdrMkzEQwLkVyjO0jbq2UGRbVRIwh/BYg24ofdT/K4kxosFtc94Kds6H6BQAJpesguaFzgiDmIpY2vQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=TtGGPJ5I; dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=FDUp0aca; dkim-atps=neutral; spf=pass (client-ip=67.231.149.25; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=0712d89377=ckeepax@opensource.cirrus.com; receiver=lists.ozlabs.org) smtp.mailfrom=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=TtGGPJ5I;
	dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=FDUp0aca;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.cirrus.com (client-ip=67.231.149.25; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=0712d89377=ckeepax@opensource.cirrus.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1361 seconds by postgrey-1.37 at boromir; Thu, 10 Sep 2026 01:02:34 AEST
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg3vG1dn2z2ytx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 01:02:33 +1000 (AEST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6893npgp1578475;
	Wed, 9 Sep 2026 09:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=iLxABrejSUqDTt1/QH
	DrlHY0R8rI0yqLu3zIX8J+ing=; b=TtGGPJ5I0/tPslm98C45xdSDDX/dh1/rcB
	pw3p5/lg35GZ9vBnb7zGn4rqv/biZVYRNEcqWZMUl69bpug9HqiwXoZl8kJfLMOC
	HK6z/SC+bc5cNuk3NFyhaHhSYlGP6E25W0jVz2raaeEOKOGD0X4ex2+lZ4f481II
	Q6SzgKpFm4lcRdDxCQELcqGrHYoHLBGLAIlJM+te+d1hWkH18yQZuzopmECdNA0m
	cl1Ts4zbYmCmAwqa5dc3X0xLASUd8cx86cky56sOBHJd8Q+V2u5m19Oe0Fm3E18X
	bbnQPnIwhEzsdj/MEm/LSVgazVsEGuqf6bGzgDjKoGLkVzycQzsA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020110.outbound.protection.outlook.com [52.101.85.110])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gggfwn796-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:38:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpD7cObPJDqnGtvmuWP964XJzEzwsVY0y0WXrUS4H2+U1cDIqPRJVilJj1LIGEjogh+zZR5gE5GEBOSvBiK79Gtr9uOKbpBiNzJ9iAmZchHlSUTmjatHAOMHLbiDTJ7rajWt9KNAcfTn6mTJFWJertUZcwiZJB3GarTqNgPFDZiMKCgXqMKuM0zmC88xW2tiPhyajY7umO7i2RhpEQvpbLtSiVOfHildYZb0QjWtqnW76+rC1469F0YnFuND74eQNN4U9nadO36fgIvU0wUw7n4EYdqOfGH0Po563YjGt4SlVfe1CJA/9w/pXbuA7iR7+cicnFD5yHmN81mA0SHXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLxABrejSUqDTt1/QHDrlHY0R8rI0yqLu3zIX8J+ing=;
 b=lmDGFUjF3uYe7h9+K/15lCfvlvezMBk9wlrslgJgoTFcb9StZtZKADvvBWfetKXh8YqIgjBtFzB1tS5Jp//LmtenWjAf4pg317RDi5zLt5j28M2ySMhJN+vye/9eMCvsVq2HORziDy2C6cmQu7y8HRocfCJCIiKmQ7r9aqA1nyAK6/IoLiscXS9vdzUYqmgndj9khuBEceHXsUdBnB+KvUsP3J+hPnP2BlnsszMKKg/6bYxr1iqWQByxl9eYhcRlctY+v6iGMKOSdkZAR3KOKhXg4SC43I6cvA2BIT4XxumPGkMzJmYkO/NPohnnG0QVke7JmNVwGG6Try36kM4wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=analog.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLxABrejSUqDTt1/QHDrlHY0R8rI0yqLu3zIX8J+ing=;
 b=FDUp0acaoiGa5YHU1dS686D9x1BxMdrgL8Bc4OOrtg2kNN5h/0OS+d8COpbSQ9SBhQgTHuyF3qFc81MotVwGe0smw/Q3oQl0tfmMoUI0YLS3kkV6Kx0TbyjOwIjYc3CCp7aUhHRP1hMultmL6i5F+o0uTuEJ/TaE2bdBNMgqOLU=
Received: from PH5P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::11)
 by AT6PR19MB679231.namprd19.prod.outlook.com (2603:10b6:170:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 14:38:55 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:510:34a:cafe::71) by PH5P220CA0011.outlook.office365.com
 (2603:10b6:510:34a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 14:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 14:38:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id AF99B406543;
	Wed,  9 Sep 2026 14:38:53 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8F5E782024B;
	Wed,  9 Sep 2026 14:38:53 +0000 (UTC)
Date: Wed, 9 Sep 2026 15:38:52 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 04/14] mfd: remove unused wm8400 driver
Message-ID: <aqFvfMcocLR4qU7s@opensource.cirrus.com>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-5-arnd@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-5-arnd@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|AT6PR19MB679231:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7fac24-9101-4f11-927f-08df0e80133e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|61400799027|4143699003|11063799006|56012099006|10067099003|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	umTZJUeE244Ysy4jKRn57ca4h2aKB79jfm6ciPHGP5leBO5wHA28Nmy4JqBwfF9Uqh/ff5J7lbX0RWtuKdvsocfkylpRPGFX2Hw8HDYfF7W3yO+TYcGVL+Fajd+ognL01CmM+mNXv0RU9r+3AQ/7KSfLkyGEX8+Z0ElE1dreBCydVrKcIcoSaLP0s9UYt/qib1T9V0sOz+C784u/S1RcGzm+UpoGYqYiVEs/XGI+yKGvv16siiWoVVgNkiFWbhwCDc51eahMh+86LQWy3ZAxv00JvmWVGvgFAv09HVHb6TPT7HK5qMqijQI/D6wotW2/kygS//+vc9vgeld/oN6u+TNyQcZtjcA01cwLyraBl6BLIbU7w8rEophz/quN8zNRf3TSZGVZwxx7+lzHpVwYkyKgF9zKOTZjHGgMxV4Levsyb7BNSIELadD/OlxeGNBCygS7IP/duFM6ErzAw5fuCdw+6LS/8a7aLdZfXAeQ7hXvEU/O+KEjGeKL3QMA2DsxBrgQEx/jQ+0DluRtJuEbs7gHZ8xA2O0uCf+eUu41mVXa0saQlAXOPZKGd3zGe42owMIb4HH+nNA6uL176FOEk6+/dLhFZbTuAdjhdSqZd/O26c71x7CQmMgPfUW/WKbX4KQYjkYv6x8wNUjkCQ+l4efMhCfHSAiFAvOUwann9b1hyrhhgj/b9J9+Nutl98yQcOFhsLy270njZPvi7O44FQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(61400799027)(4143699003)(11063799006)(56012099006)(10067099003)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W73cWf+nadA/TjwpKvQt3TuJx5pVAdLs1N5g52ywoVzP6/7gOfiBYcQDqfh/PBmEkBxKDq0NFwUrFM0OGDW3GtFzH355tgzjie/rX2UBmqj2yNRj6u505FSVRH0fToHeF5QsEYK+SMy4sF1IzYS6k9WdxoDImnQWGe9zIMN1OisW9qXBDA/0CwOB2sxE/1zLLbhiYHFZ+crj20416vGmLtm2C+O5M0BFjxkvKnp4kGTnzijDNDottAnTJfp+wF3o5wzBR/LuT5Fn92fEpIrXcxyD4b8/77QK+FDcfr2axvHkkrQGOfOZrkiEIKuE9g/fCyR3KMS7O6OSifpBKf5k7hqwxw5uvBGxEjHrqrqeadULKth63TLASklIvtdRGuJXTF+CMmt/vq9PBsXxAjmrxqSGiH+r8tVivEvhVrs2lN5WbYMoGOeiRJspmTJ2C2BD
X-Exchange-RoutingPolicyChecked:
	eWFOBkeid2X4h02brkV7H0m+IyHpFtaCXGSSavq0O+VCN7eNoKFNvudS6UcGSqBnBt3ZlynMScvrmdPGau5d0T+AFZIq8Dxa7DNmn7Kh1e0v6rXQnYdgvrtyinlixbX7MuBIKesS64DVXi3o904xhFj0wMycYWKTppSdvpcx5qtLE6pGpEuQljf4kd9gSGbhbsGBbatP2mH0NuSFHL5ej1CluEp+rN+0jRvdFZKEIDWQe4mGLNnD4nDzcXAupNOsSCpspan+qqJoT8bSbkwAHwOF53pGmS1k3YgkAtVfDWFEyzD3wLqJyuF1S8tFbR1bdsWL07S/ChbIWQdQEOJO5w==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:38:54.8916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7fac24-9101-4f11-927f-08df0e80133e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR19MB679231
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2MyBTYWx0ZWRfXynIz4HG4D4sQ
 MAOkhMS5r/Buiuc5nK6CHoF/KLLcibYq2FV8rnJ/OxmvXnKrVAZFGhUqS3JpzAjm7VorTzHDIgs
 MgAH9215NzY/uPRmL/N0rnhtcLhcbuk=
X-Proofpoint-ORIG-GUID: cQQGe3MGS0BJVNfkCGMGTzoPm8s29Xry
X-Proofpoint-GUID: cQQGe3MGS0BJVNfkCGMGTzoPm8s29Xry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2MyBTYWx0ZWRfX43Pxx/TTOfCS
 IhixKPi8xIbQpapsUfIpYMmbOObdn1D2rgvoLtG5wnECczjS8n34rJY/HXMTtjwnvC3MKz9EaY4
 ujTyqv+iOV1lIUNWUJg9wZipVlSmB6Y8U9IxE3XVcz2TlPAKhTNJkmNxu0EXyFLeu3KhAZ999Bc
 RsowwrOMMSL6Id/i+N3NINgR926EaGziIyk74HRGslz/q60npQVRz0V6LNt8zWQ91XenZ01a3ZY
 HhsYn2Aobf8bZAB0va8b6r0F1pm11NicCMhYJvzWs2nlPomlJVi0TZVPDm6CIiEU3so23RNz1S1
 p4Eu7TflpKaI0RMzavJQYyfZZwYEI4mj3iQVRGebaBE9IdWgE/LzZiNtBQe4jI9NSByGK6rLabj
 yhFM16nAsobUDGhRe+2pc2GM47wskz5VydWQKw3kpQ8ucPXvCLsGMPg6v7VZQqFRLTeq376zUyl
 qGOjXybQ+Z07ETUdWjA==
X-Authority-Analysis: v=2.4 cv=fK4JG5ae c=1 sm=1 tr=0 ts=6aa16f83 cx=c_pps
 a=54yuESksmrMaP3RwvbuPCA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=w1d2syhTAAAA:8 a=3CKuFnzYrga0DEbIuDIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 09, 2026 at 03:21:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver requires a platform_data definition, which does not exist
> in the kernel.
> 
> According to Mark Brown, the hardware supported by this driver was never
> shipped in production.
> 
> Since this is clearly unused, remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

