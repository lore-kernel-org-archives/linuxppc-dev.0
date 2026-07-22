Return-Path: <linuxppc-dev+bounces-24642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC7EC44539
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 11:03:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4rwD3MrQz2yfD;
	Wed, 22 Jul 2026 21:03:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784718220;
	cv=pass; b=m0cmqIIgA1VeassTY60TbgVAU7MqWnKNk2OFC1mH/T9yzC1FFviziRoWpL5M1/NuXbxyLqRBBiQ/1lN0+tW4f6D1KGd8/G82mCQ90BVrMmbu0+uEBY+ohGiRBxlYFE2LV0zLKVruJFNiLQSwXpcGTuIHneNDDL5b7WdiLL6nbFIfh8/6aySXbvIyyVrtMPA0jdyFZWCNzCOzgRSjmm5+/OM6ySJYjtIFmabqgJ9oIbrkMi+h3h1kiVNWbMAQDhWvd5I5DOJ+KBjgDoUADn2VScYfwwWx37BXi7uVBjkr9EujTNeXzo5sewXiAL9aUrv4Cn3HpWWIGV9ldmN+8JENbg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784718220; c=relaxed/relaxed;
	bh=IpXnSQh83GU/CBIeKndIc+oe0TT1sfhFtaz4QblZjk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FOr0vIMCThpJS46i/mKR5NIIbO0hByruMsh5TNnJycmHJg0kPID7YRataQaXKr7BGSA9rLv5ARNSAE4wdBmNUX9ZePHze+/hH4E1mGpV+E0wjPl/7ZPbYK+6WMZjmb52Mlz1Rt4H3a/iL9ikSJaM+j5yEn5uzSvaqE8a1iOoVAwWFnMItqCVgYZJ1SNUB76sKX38uQobIQ6v8gpK9CIs+EcZNJAoIuypGIayMZzcRSj6FBE6qyRaV8RzN2iVQsEtN2EzdpDzb36+hW14pJsdJg0L/LOQ7/VZk3WK61Qj+3skjWcLByuCzFCoOu0oOX4FeXXnCPtwjAf9FEI/qRr3yQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=etTTOTBH; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=etTTOTBH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4rwC4PjQz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 21:03:39 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJSvZEsf93plt/7W9ZBOMNJKySVxW6C/RLpSPQRniR9kIK6pXYhlANZDQyUpgh0KmmXGv1hGr0SFqnzCVul5uLDEvC22VbV5wSw+2EdWG6gR7NrGfuf0O+2TjBwuhSejqX+A5AupxCgJvSTeRWqWriUOMHqtA/0/lwD0vat5Ymieo8F0FIYGxAPuVjgYqMT2FsbpgaRmDO662SoLFnGlfLjnu9x08TSmhOKVeXnIM64XruEfeUYCQ3ZSGvvUkSAvzirCGtHnN0zrxaLsUoBQxdHCWKvaDrtMOAQfPL2b7eSS1zYmh7Ia/NvVIpJ0RYFjwexYy5JVMbgMH2uGIWewkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpXnSQh83GU/CBIeKndIc+oe0TT1sfhFtaz4QblZjk4=;
 b=IgRuslps/S2AfCaCgOx/g+N/ftYN/jmNZy88yhsItWNo15Utcxkjq7fRZ1bbuPVzY5Y6YYjuesXtVmfQBNPLB4jO+LWqS+w3Gbc1u7pFF5Ent33SJze93Mb8AsyTjoW0gV71r7qzlU3jK9VbrRhnJmdPesrNSduj1U4gGQ3Tsv4hVSmUYptJuPQLzOAou6B3L4vJ17e7AYuQehqLHw11O+w0UUBZ2CrtDKvU8A0o/geB65rVdYKGQFtpXa/04k9d7362pVIR5wJh6KGdTW7Pj1lb6cbXhH8fUgcygcfnXcGWbzjw7hdIRMZY3giIVvKBuqhYnmUguKoBADlo2wZLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpXnSQh83GU/CBIeKndIc+oe0TT1sfhFtaz4QblZjk4=;
 b=etTTOTBHjAuKXVCLazeKtMbZB4z78D7TNpK2FZOxqGgSMRz1f3GInXMQvhWl76i2k7KaHxWn7cfgygXHyhg2yI7fZBD9onOIT0lA/xqDMli3Mqa0XEvtQOt6F8fiMla9WUlQnDRQ3hAvtUHZolJCMc9/0KLhUdb06JHem/X810En8IcBtGyB4a09/NFx3z2T9mnnYvaGJWuCAWCPKdNCbKDV8hqHKeV0KNJwtwmjbZIyHzR+KOhKASOA5N3jO2YXa1oLOKEJImVHFRXf6dmvRGuSlJtXnKeWT9yyNG9fnLGhicNXy72vO+GBgDZWGbiCcH7ZqmgShj+XGrQCunqRpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AS4PR04MB9314.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 11:03:14 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 11:03:14 +0000
Date: Wed, 22 Jul 2026 14:03:09 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Tanjeff Moos <tanjeff.moos@westermo.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 phy-next 9/9] phy: lynx-10g: use RCW override
 procedure for dynamic protocol change
Message-ID: <dnlofvs46h73g6hlttyltsq5iowi7bkwb2pqzle5fhq4kzimij@7l6kz35l3fmu>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
 <20260721231603.67865-10-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721231603.67865-10-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AM0P309CA0021.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::30) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 778e426f-10d1-4c6e-ba12-08dee7e0d36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|3023799007|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d/YUHyxtN0GwhzLY5Y028kXwZiiS3itRGrIzQ/rBFTgMyJtDQ8PXeUz9VGt5vw+E63Nb0BMkgZ1JGtkRfdBOy5M2vq3mWmT5ZM45LvelG1UlKt6VOT+rK3Y/Ol68LO0Nkx3Kp/27s61WyR4g970o93oqqPCdKY3JI8a9mndmnxzC43YqImJ5f3xZPAwypX/mmaTrxzZbMukEMCH2UBYjxKR5NbXNFDeoKsT4aYeG4Sh1V5oq6yA2/6kHFB+/MwacPPedLjNfq/5xPP81bB3rD0Cm6cDqEmf2TwJwiayOEvGyW66hUngTLWtIXsfSDV40AgtlAmRy3vRaANZapg0DirzRI10UFoWqelGK+Y0iZ7umMt/2+xvGApLEvtCrJJkhEey28M7U0GAbw2wFnYKzanECdRA6iFZkZicgng4oiUYHwhWmijFc0jQfnWzOOfHOUypzGfn1YpgfMFGMQg5EYNc1Bu6Q0aMQy8xGVgC34y7Vw1sXoa4KZWf3tXQoWBu3+xUf6p/A4xAA3ymg9Chehnw/vRZ1Q3RFp5GMXAlvlYXBayju6Xgs7X/YW/TZx8+exb0XdbE5oF5wdB32fA7hnrAD60L13rys4YS7nQWi7LiW4XwU/NURKh8Z5s/urXFtNh6IyGk+rzwAEgFxZ/nYnCqjjWF4TowYHqprN5bBxKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H7YcPQbQ8URq2cMlN5LnsO7F8xH3cbLIB8mdk1Av7q3S1vqJ6KbXNW1ROZw9?=
 =?us-ascii?Q?laiVoU3g1Jw3gyfrSoFQjunn+qvAtC1MA7Zv68J35Kep0tldtQ5zzxieVj2X?=
 =?us-ascii?Q?4/ymVi3y13q6itat1FGoLQGAwDbAGdMoeQTcS3lxwN688mbqG9ihSJgmNSDo?=
 =?us-ascii?Q?9y+4bOfOqNszA5GxNFskU5vOcautfYINcH9slvs1XiYMUFi3g9V9UROKVt3G?=
 =?us-ascii?Q?jPBixY7roInYmtd1ZqtPrJzcQyu41mT77rngV0+LYFK9zhih4c09TPqkAvoU?=
 =?us-ascii?Q?qDwh7JvBxEDzL6LaGqH4n1mfqFGaYm9ZcAG03Ks+SzG24xC+w4MGUkcLLPj/?=
 =?us-ascii?Q?/YjlkuVseHAyZpYhnrMQf8kaB9GndNKP9sYQaDhnZjSa9Nafycsnv4bZKXld?=
 =?us-ascii?Q?FjbVNynt/yA4CsQ61J8efZf53WGjD8pZBhxDC/N3GPw7gFtjz81OSAXXHLkR?=
 =?us-ascii?Q?mn1kEe7l427gMviqUJ/+QSGz4Q5DeDmRSaCV2uCO0UgPY7mTIs86B5ldHEBw?=
 =?us-ascii?Q?VliaeehVCv7jbpuzRJU+KeWrWfcQoVMQUUL6/ca4EeGpWb8WpH2+dUOFmHuE?=
 =?us-ascii?Q?CbWiOQrmp3VGiuVr2ccqO4uQvQ+onORzSxmoERNcUp3LhJsUIKsAhxsGa3jR?=
 =?us-ascii?Q?PmsxxWjwqlZ3HKO8y3vSroIhVryyL6j0GWek5p+iXJ5EtjQyd3UDP5Dq6eyC?=
 =?us-ascii?Q?P92dzxtBL7rSbAAz/ArUuMNPqhxJ7FNI9kczEZPVAfPCdP5LYFN/4p53Wx8f?=
 =?us-ascii?Q?qQiJZ7WZZJfssvPVxr7JUr5xEFd+PyTQMWjRnSLLh92TmJkOoysRnK1Bw2KD?=
 =?us-ascii?Q?o5LB3R5DgYjlJvS74KtfBr0XZ9ClKrkDbr1QU50tAr8fMfa3KEDNjUy0mS7m?=
 =?us-ascii?Q?/Y3CGjtpG020llNoYfUxZRLAcVogvtlScqJ/+rsjGXXwFuG5V6aP5MJSnWDg?=
 =?us-ascii?Q?796uP/dEnQo2siyJtO9uavk/DYhsIlazPGtDxFvHPglB+5JmhrTATgjQp86x?=
 =?us-ascii?Q?pZCil4O93HW/3EGmygZqoeZQxxbqVhI2C/VvZrKd40OpQ4TN1HD0TH8prL+V?=
 =?us-ascii?Q?djsthzFAcJjUdq3l4xEczO5jiFWTNUg5XW4pkXewe6Qmo/sirmmK/22WqS0R?=
 =?us-ascii?Q?Z/10kVbukiXF29mQ/tHcgrKg9dkN2fjBYwGyFbs8xBfDPS3AjC4s8k6H0KW2?=
 =?us-ascii?Q?TTCskJofRHfM+XRR5JtAVW9J+DMX1+JLEYu2mBN0vB6wqteImUEf8MIO0JBO?=
 =?us-ascii?Q?8MfMGZlnrUfaenJKDy3/UtqYUmfH+M6xdSsbOANJ9J69jg6XSS9jusqqG0OY?=
 =?us-ascii?Q?G89ifeHCi9UDD3qpxEgUz9aCmMCNPdhqt/jCHI+8OqJ3ird34TS7phgzoKUc?=
 =?us-ascii?Q?seJkea6dCUMmZ7Nlgg6hKQKx1oLgHae5oHUR7ZimE/zqRm3+AMkrunMeDYcB?=
 =?us-ascii?Q?4cNz9/tFO5IPUPaODIw8pvL1goEhrANl7+69VDwC3oVTTjsScYu20pYs9iAF?=
 =?us-ascii?Q?Z5+kc4q/NwAVVAKJGD1pA3FJFif8Z+J5w2p8XRgFMg5xj6Mh6Gf3wKsif3SH?=
 =?us-ascii?Q?oHPPCuHuxmiN3hWkZEeZN0lrWeTt4ZSWSGg1TzjnpD/HqQOdZr7FK1PbgoAh?=
 =?us-ascii?Q?fOfUu1+Ymo0NxwPLM0br33fDY+Nu6B5L1WmETWWOjvFZoO+jPhXt+6/TUL2w?=
 =?us-ascii?Q?p/pn9pCFH5hh6uPKo+kk6gRVBrLRGqY0FOaSnL0X+oBYGHrIcfroEPCMfCF8?=
 =?us-ascii?Q?uXEMreM7Jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778e426f-10d1-4c6e-ba12-08dee7e0d36e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 11:03:14.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjGxkb2J+b2yzu9uhnGnjNpAKAW6zVzMC8Qc6XbvYJqCGJsR6shOVGyfK72HaCBWfhymPogPaQ2CrKt+b2SVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314

On Wed, Jul 22, 2026 at 02:16:03AM +0300, Vladimir Oltean wrote:
> Up until this patch, the only protocol change supported was between
> 1000Base-X/SGMII and 2500Base-X. The others require an RCW override
> procedure which was lacking.
> 
> Since now the guts driver provides the means of applying this procedure,
> make use of it and remove any comment which mentioned the limitation.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

