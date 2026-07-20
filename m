Return-Path: <linuxppc-dev+bounces-24502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAF8C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 14:35:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3jjd6j3Cz2ywn;
	Tue, 21 Jul 2026 00:35:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784558133;
	cv=pass; b=RsVQbhFixcrB42lEO8MzwK5IzxmZ1aMAu8/nf8E56TjCb44gvYL6OtcjHhDYp9rSkEZ2DIT48qChxBrePl2Pn3vs+jMCIRdsyZE9sda/o2ctZsQxEW2dhxFOSDiLXNOFynvaV3SqgJFEJw4vLFomk1ommjCXwE0/hzeHx31qCPFbOs+DO8763DHP4H5MFrypoegb/dC3a10Dp96qqgldLKyjwM0cfP5t/yNI80Q5zKzxp3SfrXJM6QSbjVPIfj0GoH/ubQ1mM3RpnGENtIKfmOYyVP1ncJGLPe93jV/T5r6ExlyK7kkMp/kUplVBhdeOz8R0nCx3UD7PjztnLIPnWw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784558133; c=relaxed/relaxed;
	bh=4buzavQmBOsvKA+P2fCknBuevpV/NJpO9RF9tWfZZ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dRoP6YVH9P2dpOuPWk+8MCtvEf6v2q+dYS4D0Zz/4XDfjn6Sxvbq6JWQNANnUdh3K9+qmmyDhLTYDAUt1pTQcccQ+UVpD0nRhdj+CbkFmifkCBgkiYC1dBOGZVirj0kBbbSIcDuqN9df6eGNvhZ9aIHqi5nryOehwrQFIwuY8am8+uDIWipdDJP5RSxE+dvszwsk90W2bEhirPacg78G0vk2lRmF4/w/QcjYu2gqNC3G6J7S0S0sN+T5t8Lo92PX5nbCENsLKEhY49Gfw/kn2RIhRhO28mL5RY9VhzhEZpojiY4acQAjBUmwiGbHnTtYWJUJBhW2zOwIL8kpa1J5XA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DZy8kHot; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DZy8kHot;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3jjd1g0qz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 00:35:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL/tn1TszvJBv0ZV7bISU2lTkJfZkmKIhTNuuIRS2LTVYOpRKwMrj9Vi7rcegtJGmRzYB3GRu2qIbVAcmeeTISdWIMDc7atDpOfsxMI1OE2bBFMa+QcfOUDmbo8afu6oCgiy6SRr1+Tr4jHsfUkG2r6PfCluxc+Q53P/OeexcmpnIdieB/pa3lQJXIYU7eqMrnGv2EjXkXlE6LkrAC4lOWHsjFG24LGuYe8gWCS20lOFNKdgZBAUJg3gixmVuixPQqEL0H0VNkJ2DVx2jx+t97hMlSYAug6OQSNBQekeNMAaRjieARN035szRmJ5X8nBYwuaM63ZIl3PHCmFPdZxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4buzavQmBOsvKA+P2fCknBuevpV/NJpO9RF9tWfZZ+M=;
 b=dmv37NE3wb1LCzHM9M38FLUSjwyCQ+Tp/EFdKY3WNJICFAxhZPiarDnj/y6kqhufR8xIdaaTDjebqXc/N8nFKY7fSslT8bX0DG1A7jkHq2XMsVWwqrAge1sqeub9xuftMiGY/FZmqRRSARwpuZQlQY4coojprtgr0wIzZUEiXhpKQHfU4zxzgdsyyb9FO90Yvl0ehMXhtCYh2OXuIUvB2XR8rNSCIgNUMweqcceh9X1xoejuR8IsjyPx1cHKPieL0rWDBTM6UlqSfxaa6bd5sdBdbtiVfOlIBeWu/rRYxnau7S9lkDmJilNHHkvd9BiQnlnZ1EAejSA8Lfz0fRzDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4buzavQmBOsvKA+P2fCknBuevpV/NJpO9RF9tWfZZ+M=;
 b=DZy8kHotCrvtbraDVW53IL0t1Z5Z/7WCNq6mu661bcDDV6MLQlpWTEZqXWZieSKrNRGZcBQoDhpjZAPL2PutH9pHwpnK7H/y39vkTOEPHdcltYMjq84dtu/DBdeZasO3T0d943wTBOB1jxQ0xdGVA+diysRviC9lMUnpSxnft/51nopzuAUwRs/uGAS49PzB/HI67H1j8qW296tmUlj/0erIBz992klkoq9Acl+U9+Mjiy6GHwT8lIq4HKDyxDsGAR7r+8xTWLDaTSnM4C9SEt0yloF5WtrRHF1kx3HfE31mB4TJg+PhoYi4qoNSa9WdemhAcBOxuhF73aZl35Qxsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7753.eurprd04.prod.outlook.com (2603:10a6:10:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:35:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 14:35:07 +0000
Date: Mon, 20 Jul 2026 09:34:51 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 5/8] pmdomain: imx: use platform_device_set_fwnode()
Message-ID: <al4yC_7tYA7o0Rh7@SMW015318>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
X-ClientProxiedBy: PH8PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 8971c63a-ef23-40a2-8038-08dee66c1839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WgLZOiV+4F5iNrISqigI2at69w0viXo3DdCELDvgzayxPhH1qu3NmsFxPsgl0RyXpY9tFBZaqZwIS8X30OLz+oS+jgUdEYiPeoidha78JMkcZpW9a4m5IM/8iiF1g+HOUOPiqNwSAMn7OJNPr2Lx+EL2SvwTilfYw0UbfQk6Enj2PwY9ngIDMAsCBGGz/61DgOItq/NkFB2CkXy+ng/ILMNns2pB9oEYyRrAqMors1aMd9dx5mcU6PTuX/eO5qFfGrBKu1h/4Fdj/jXDzIj2rliOlV5+crfcxMX/ITK49pwFTpnBPAR8ogeCC9u4yFzflgHuOPekdNMOCvSKWIIgaz3cgVsm78hZ/m2avQuG49Oy32LPRjJEpi96sIK5YP7VFTo6N4WceA/29+dQL0JEdn/UMzIhWglvE2ePnmXlA9W6kdDDPUGqQtjjjU6V7oXOkRA4c1pk7lznujVDLm/rmJu7mqMqp1QOldPhYWe0rz35rdSj5xAQGiwspymjSYJmHhKhbL5yvBFrA8RjaeCGL11nZSckU2oVZ9xZYXXsVzPxmjp6/MNElhjAf6/9c+uy1DMmJ+1qmXcFCzy4ji/3bs6a3w4nifJYbl2zbAiDED+cG6QiyxhnLYSrQaHvtnMBv92onIpFz9QIsTjIUP+w3OUc2bGpt1NztNtKtSvcut0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?caZcaaLwL2/QoYrpuY1zaLKQl26ZG63W9tm2VOc+18byTECLUloFrJFPs8bl?=
 =?us-ascii?Q?4J37aNAjA1CCZnYg8f4IuITOGfu7qgrfb1Ve+WbTOcMOYXMyyTnZLAXkZa+T?=
 =?us-ascii?Q?TqzlUgXGmH357YMlK2O9gEVD2Zqtj+sVK5FEdD+ZFu50MERsLrw5x6cqLNtK?=
 =?us-ascii?Q?HlMY9oEPTiIstccg4yA4X9yPqoPw63lDvBikumwFcFb/qSQokOV03jysNJx9?=
 =?us-ascii?Q?yJexzkIYRcFHXdjMUbw8BhjiOxF4p700swEsXUW+Dwqr2ILIT36BizI1BRe9?=
 =?us-ascii?Q?gSZ6ivRB1nGvLx/Mwuez+ciUVe75Zdw1HCWGLcjszVsLaMOZvCnkld5CJS4p?=
 =?us-ascii?Q?JRONVWTumZmOvJX2UVNUhzFYCwYNfAj3AW9Fmg/gE0UfeqQV+2HEn3odByNA?=
 =?us-ascii?Q?tOmcizT8/dD65FLvQ9q3BC3mr/tGMZWHYlBqlzmpka5i2PP0tbsDE1/V9oyN?=
 =?us-ascii?Q?qwHUQoKwiBEqBBr4HAuwnd9TApADhBEcjacSlSWPDzREvtv4uNmNBxfO1jbd?=
 =?us-ascii?Q?ZtMAmYQO6SpUXnHbl3QbDZ1ewuERIpacnJPKwVg9SlKAH7rXMhThmsg8ShFF?=
 =?us-ascii?Q?HM62x48EK3CveFUGGDhzqwyibohvtcQaQsWCrqRhTXx3yO4mSBF21/kbAh9T?=
 =?us-ascii?Q?LimdZEwPL2ND9GJ1fEBRLt04P6uwyVO1tVLEIaQ09NIWdTKYDBXJ7YpAkKA3?=
 =?us-ascii?Q?WtCdPfkOPhJP4aiZ3Qep96nWW8oF6BPF6Fm4c2scGhrIZrEZTVOQxCeSnaj9?=
 =?us-ascii?Q?c8ggrGDal76ywIe9/0hsDnFKu6hiByg/Znvsve60VUHMhLgIPFXA9FgdGVWV?=
 =?us-ascii?Q?PuSgPDuOSNPrABeYcCD0r0QZdTKaj+69BklMcPyBDPyfZwk/aWrmKFiWX/rD?=
 =?us-ascii?Q?zeOAu8UmCug35kuMxqUz3Scv36ITONtZtHfxVDHGRXjGGWjYF+zFZUsWW0WS?=
 =?us-ascii?Q?PaFi5k4nFLf2LvkBBX1e0tSE4dGM30S2JozKFV8TZzOajnUe00HxH/oYutuu?=
 =?us-ascii?Q?Ip8lCUy6Dm0Cdu8fz42KB6F3Z+zusRPFuldI5DOB1/fDgdJA1vhdHROatOIb?=
 =?us-ascii?Q?C+JzRb0hm5c8MKM+FF3FHVE51d/YE5hDx0d/jzVzfbvC2cxwGcmobl2V8b6E?=
 =?us-ascii?Q?BptaQ9kB6sozk6xQXMRN+Z9E4yobF1+6yi9toUzkxarPG6RIJDiHKGddkYQ9?=
 =?us-ascii?Q?OZZ8dfXpxvk5Mfph+4wHQTv+mdQ3s8EvDZCpTQOdap5fCv0r1o+3Lccey43c?=
 =?us-ascii?Q?/M+Hblwq1S1cnW60ccd/7J1gFL+Lm5xAJjxK5PLyMtrJe0BXZLJjSYWIeeih?=
 =?us-ascii?Q?OPOCfm+tPyQ4M+Ckhwmlwu8x8AJwqt5boqO1XywW3XrYXMCb9AhBNVGO7ryG?=
 =?us-ascii?Q?d0456vvNC+dr7o8wlBINgM37R0qFGmRjhZKnhbQsOy5RzQRwoMyjnRiZtnMv?=
 =?us-ascii?Q?22haLU/JGuARjVbsdmyq22awjBYs/on2oo+bbtBGbQaqJoI3UNwYzAmGgAQQ?=
 =?us-ascii?Q?bXUVHLQY4VABQLF0A4M35AovvwMx+kMhky+bc2uO1mYPSt22iN/raS5K9OTh?=
 =?us-ascii?Q?P7xKEDrk0JjCdfahaq0xC8WH4u6biBNmE3DrMrokz4MhOUDeh+sb7RYOBhPd?=
 =?us-ascii?Q?NMXlRph2HWG3aQHbQiRxqTbUq6vDk3AgSfcQ85/gHwYOX8Mnoo7G1fJiYZUX?=
 =?us-ascii?Q?oI3rtKs2+L1tDZg1TbuMmmZwWYTwAdbUWmGnlLfYmkWJ6cbtAociavrbT8C6?=
 =?us-ascii?Q?ZqY4mpsgjGEprDI28L7ScA0H13UDQxvjsHhOgOumEZ1DINdC7rpj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8971c63a-ef23-40a2-8038-08dee66c1839
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:35:07.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiDtpCfI4ba1fwNZFLjyxu7z4QcAjwPBkIYIQ+2tu0bqWIoyiJ8p5WEyfSy5/+cRb5uqeM9UDYS5dtEAk9Grhi3Tj1+gI2B7UrTW5BXlpjp4/tztTJOEtgBLhEPGBmOJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7753

On Mon, Jul 20, 2026 at 11:24:52AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a226fbae4213926e1395c413160c950..c147eaf048ba2b79a744ec87029420981581e48e 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  			domain->ipg_rate_mhz = ipg_rate_mhz;
>
>  			pd_pdev->dev.parent = &pdev->dev;
> -			platform_device_set_of_node(pd_pdev, np);
> +			platform_device_set_fwnode(pd_pdev, of_fwnode_handle(np));
>
>  			ret = platform_device_add(pd_pdev);
>  			if (ret) {
>
> --
> 2.47.3
>
>

