Return-Path: <linuxppc-dev+bounces-24990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A62C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 11:22:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h990K53zlz2xwP;
	Wed, 29 Jul 2026 21:22:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785324129;
	cv=pass; b=ScuyULecR4irPAkwM333MIrAfWlWp9GCj69IIdAcTvsCvVMBwcDnrSr4JoPKkdRRZvpgjsqFaG2V4/yOZDU3NmmbT8JI/JE/jn3b6Fset22WLrLktIDGWVMo5+fPcDgsAbx0mMLQeV9/bM8Gw1bc0zL6LitoyUbRRPYe7BJwE/0k7yFHpwjp0TCDZwX9GdUvvou12Dyz4/ErFzNBDyCpwHJ6E4PqZO6OS7fcXG+6hr6T1YfJBCwkvwBfG+y9MLqAQcYAEbJcHIrTIXqepRi10rCN4+sv9rmNl9o25JQjLeZIciYlyAeY/qudI68sxB70K9Z3ZNaEK9RWDXD0R5PBYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785324129; c=relaxed/relaxed;
	bh=jQI5cHNmt+69lGqmBrBzLU15gIo7kmo9k0G4wIIHaqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kIHdG9Md3d0LXnScjQ3oOnHBkaoSgIa8DArpinHXPHIse9JmVgNge7o/3TvJtJQ6rVxnPZoQX3yUYlKDKVMagZ77czVYpxrewQiW6/kj4U3nAed+UuYsAk+YLkNe/Bt9iWQBawouEZUw5zPxvH3PZzexT/b5s9kxrJJWFVqtoSJmSx2pwWCmfysmd5NBl22R4yXpuq0CSain51GM8NkZINAyT1FO53GV4bHEdlNCu7ynr604MW3L0yI33liGsYFeJWJslZ5oOL9PGvO4THcJkov7wOMWBzmq9vWYxTfFVgOIbhhlI613cd3l8zLRuIPZSIB77ZRRaefhAv1/QAukBA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nZXTko+f; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nZXTko+f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h990H2wS8z2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 21:22:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqH+LJUDdYTM3CLHarP9ieDXvqJAfjBS9ESefYrae64I4r9hRxkiyrR18Tjz0R+frhw28Os3WtHSl6l8lrPCHKqtAFHUFPTIZ0FNMe7hz9j0mwtdSqnVvgSj6IBvcuUUMn8Nb3SSZF3F5t7ZLJj2uPvppjZjhx6yIZps43D/Q7mVOps2BzddY0qD8V6Yi3fiCavtgbMhNz6LJN/GgOt+8ZM9S4TBDZcPLj51KUXJLJwWyVrXg/ZNZWA5A+w8kaniNxSkHXeTsGLj67VRO/JvIl++bAoT1SLlCDe3m0D1izidljh7E294lfLvwG8fYWVYBYJ1cQaGvDofXCihf8jxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQI5cHNmt+69lGqmBrBzLU15gIo7kmo9k0G4wIIHaqc=;
 b=mFJp3t786jVB6jBnzGCpxavFeL26PzCaQ7kEiOAUhPak7J4jJ8WUAQPef0Sq4puzvjobky5OzM7fqRORvzQ9a31Qm6SeW1KWX0DdIzfytzRy32fKfSVVeiw0jd/k28r2n1qQTjXY5XYJAsIDbRquvA7h2INiHQeyFoqIOAkUK8Q/Rx7sobowxjFIbZKONlhtsKjL/mVNQcsWD8fckIAsVov3X9SuQBEqhlCovra5lk+o/cL35edD+gJ7fkelDCbvLiAhpiKE5e4rnz/xenxt10eZsqIQeBuDMBgAT3BId+oKg8mXAUE426yqZ2W8eiQAuNUMNCX0FybAEWVuqm1PMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQI5cHNmt+69lGqmBrBzLU15gIo7kmo9k0G4wIIHaqc=;
 b=nZXTko+fGmGkBqFv+KjcPWHYP0wc6hN6ZWrUoullhdR7dnftmrKHbEIRoGqNDIYL+9Rg4bM9FRaHOR7LD5fy6dPc/lFlE01wbkga1vRwAbU2oUfK0i4oU77GVFP0yYhggOqlm5CtDCB9PqCQsadCB0aSigdTJHEOgfjFNXSQNdEBjs4Q4lF9KwI5dzyaW6N4jQS95wF+uOJQgHAyi+BrqYxVyittExYbCjG7v+UKlZcO0kzae4W0HmYyAnD3+x6rOhQfPJ1MB7D+FDxShD0f2vP/i9SVp3Ce8CvI42xXRGLezD8UjhHVeK8eiJv2/nPUxNTDoDEjfiYOfBUDNfmOPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by GV2PR04MB11093.eurprd04.prod.outlook.com
 (2603:10a6:150:278::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:21:40 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 11:21:40 +0000
Date: Wed, 29 Jul 2026 14:21:36 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Frank Li <Frank.Li@nxp.com>, Guanhua Gao <guanhua.gao@nxp.com>, 
	Roy Pledge <Roy.Pledge@nxp.com>
Subject: Re: [PATCH v3] soc: fsl: dpio: fix kernel-doc typos
Message-ID: <lwmexm73uer6md654ov3f6u2asmrkzzyyzh2dckikqvohfnxup@jydxhjbw5kvg>
References: <20260728004938.905415-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728004938.905415-1-rdunlap@infradead.org>
X-ClientProxiedBy: FR4P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::18) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|GV2PR04MB11093:EE_
X-MS-Office365-Filtering-Correlation-Id: b1589cb7-2339-4d77-6290-08deed638fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KbAq8XFD4pZzS5zpKxREEbw0bwRyDxdoClFkYdRHbc9tI+RKsq+N613WVGTgUCyKOPFD042YL7Ccr7oPXyO7TIOh//Q8j6Rfsr/aQmpk40IDEBL8ZLwgTi/+s8TDsS/FaloKbcJvay3+cciFWJtmrgeBNHja2lQwkBGDsoKZb7+kdrlwlgRTLaIiiYcPuWzIpaPgbxo60xzdCIt59dnxpKGzh69zDqhesJSHd+SYba8C/JsJCmMhRFqX52R2N2BuRC1aYgPaO2sQFSxqbKxcrfjTzuPO+ULpyXMU0Y7xE2CWCfREsANgk5BwSwhZrbiCJ/V/iy7BGxF0Qe8puDOnlr5vdC4JQ+GEiJmO0KK4ZEf/4Fye2VcOVNLgi6SeQngT90KmTXyloiymKa0ZWSPAtkhtDogz077tTTyFUycRJX7AF+zpRBwfOCsrQmJPqGNOzwgSgf/wrVLD/9gUaAxGxAwWpRpoPX2Dc7MfZH+lXkOE7qmZXaBzPpT/plsusZym21N7KL9ZcnpBhwkcGL32PdY2DEeBSJndBCE5WAC0T5WStOXy69A589AqtCFE3dQG+NfxZ15Zh2hultEQZII0YZ4o7q3StEvxrNsTti/9zQCbCfJgGv3XJfWREJ66hBxoTAiFRWyq4tMzb5o49DR/b34r97HOYhiKmhF6fCLwIxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tZ6RWl9Bw5woIlRKSlO6b+RPbJKXYAsveo6QAY2s8MG6N2myYfvkkEtIfKQm?=
 =?us-ascii?Q?azygY+sDvwBl/x1ywh3WZ6kiriE/iG0jlwRRTe6nyXkZY56C8zrhtn2g67Gr?=
 =?us-ascii?Q?1qtCLLNjIb5LfwbBgHOrg/YmsLoPoMa+ssPNvrjiYPr2HmRrIbTc8qtu53Yj?=
 =?us-ascii?Q?xWrwu3HKFRJ+9Uc+K1pUkCIsuyD/C/GhLsupohd2OAumCw8b9Gkvi3LADu9H?=
 =?us-ascii?Q?Ur22CUczUWWo3PjOzASuc1EUAr0+7zTJcfqhK/Rst0ONbZA/+omNoQbv0sb6?=
 =?us-ascii?Q?gPZ1u5TmJ8EQC3o6axhYHjEDaWxLy+E5R9LZWHxGdOtPuQfqVgBzwG7U3Pxi?=
 =?us-ascii?Q?wQKUxfaW3+NdfQhbXKVyDjfMOsnb7eiks5/TGCgz6P1xQzLG46XBwB9uMM+v?=
 =?us-ascii?Q?OpoZarNo4UiLR9g2xMjYnUzbHKCzvYkmcDiV8DCa7XRWWu0TqGYkKCg5m99o?=
 =?us-ascii?Q?SOBKSrcvHqarR8vdLJbp79ODFE9xqjXWSUInmzDJi4390eI1h2UeUoQhEtAh?=
 =?us-ascii?Q?ewZPjjuIqWbmnJHgwbKlbmClUCZtPxWIQ0n+BULrH1UUeTvDPdRKu+3/kVgl?=
 =?us-ascii?Q?AHmfF12bL9IjH5kQpcuHe4FVg00hiNMJiUmg6tKUx+yrgT/B755XxsjPvnM9?=
 =?us-ascii?Q?osAbOmP9RJqH5JFxw8sbIaRo1KpS0qZPwk+jCDWGBNbEW4eHNZkT4a3L0mLS?=
 =?us-ascii?Q?208lKUR8qJjA6Zc4Rfx8ogfLQV0nvmwyRreZS/biFxwLqsyL5M1F8KsVE37U?=
 =?us-ascii?Q?1xEcIJ9bfKXbVRQYEdNm7G950qH9GpwroXdEtUUcV0fuBa4+/cSiYDHCL0EL?=
 =?us-ascii?Q?0Y8hWal+9LkLXalAjntb24d8ysjOlEgwMf0t8qLp6BCKKnbClksn9L3xcbsz?=
 =?us-ascii?Q?IY3ohj/Rd4AZv7gtysy+c1Vpo5lAAzu5r11DDXrsf9zshM5KJzG2x7mHJLnX?=
 =?us-ascii?Q?eotekxVPk0yywKtPlBqCU1/OQlyoDYTNSfQIbRNIMwcvmfwZltSBqluktFud?=
 =?us-ascii?Q?QIhZPzmpyio9gXmV9fxb1BjXxRdjexpsLLjHuszl0uIxb+RKxeGDzLtlR1VK?=
 =?us-ascii?Q?xLv1ZT7fDirbEXwVlqB+h0uczQa6NW2UggL5hLZsFsyqouWdiTfo5cTJcwRC?=
 =?us-ascii?Q?APxu5Vzfeps2LNMvn9JwHd/23tisABjgftIyGGzxR3/qmzKHxq0HUKfEK4gj?=
 =?us-ascii?Q?2yhALXDYGbOvAurJyrR8wZqIN/aLlcuABamKIHQZf/3XmrWZnguVoF+n0eWX?=
 =?us-ascii?Q?2NmioOy8VBaXlM0aCMnThs5KfFs/J6ICoqD5LsQvqj/emZIJw4KROJQU9lHx?=
 =?us-ascii?Q?iDqVYFnLvDe/ns6vddZ3pRZbU0jaTS3SlX9wv/KbMOmoecDriFoPWi6zOiAb?=
 =?us-ascii?Q?nPUTr4482m5SBpDcSqitjth0hPyJY6H1BWOf5RImNmmgO/jWOp+5iPC1C0c6?=
 =?us-ascii?Q?vqaHjXO2VDuThooBPNrb7p2Yw/cS2O/ehTKH6t5Q+Wza2G5c31GwwqpP/4py?=
 =?us-ascii?Q?1YdQWtMfCDjCkb1mkUNv8ohyWTUetIHAU9za0HyK0MNYlJHS+Bq7B5OrndZl?=
 =?us-ascii?Q?gf/YPZUOqgdF3V7ITF2w+RdvUR0YOC2olOwuUd9xuap5ePDSxW6CQ7LdxHIj?=
 =?us-ascii?Q?xgZh6xkybEzorTLHvHXPSRhLo+juwDSPU1Hdn1+9EHmFmZHSHok4CbYfaduB?=
 =?us-ascii?Q?YtqBv8x+0OlfjSZrpk44bcHRhUq8xniM8QyglhSnC7+qNYbctnEfbAmwHJIl?=
 =?us-ascii?Q?muDBWQo27A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1589cb7-2339-4d77-6290-08deed638fda
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:21:40.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN4I2P+cyF+mBI2Cb95biXxMGI2GYihCHV0jSeJUc/UxdFKnOfHjmkcwkGEigdnbWoHK56yK2h3ez5enTj0NcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11093

On Mon, Jul 27, 2026 at 05:49:38PM -0700, Randy Dunlap wrote:
> Correct spelling of 2 words.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


