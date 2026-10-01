Return-Path: <linuxppc-dev+bounces-28668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF67CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 16:31:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwcqN5H3Vz2xfq;
	Fri, 02 Oct 2026 02:31:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790872272;
	cv=pass; b=Khsci8DXh9eVX15cZZ8ApcPFQbtWIqS0HO4xfAntv7fYDiIaNlGzlAp/gzpVUEgWk9labVZdlEKHiCbSu6/V4LMjC+u/zrKlFjR33Ou/io+OFKmou9JM0LCpj+m/iV0MQ7kJN653KHAh6D2nS9ubmgvEiH1y4+ypD4JmdOsqJ3rIbvC7uxvHk1MLmXDmto+pNuj3AiSxktKt0hKwyEqE7DVhy8960RwFCzYICPf7g9/FkngV0oic5To3/B42BoHU2uVhJVXqsQrtBXwu/x5Z16P/Gh/n2oKmxrhuh9EvfyqtED6nLVyzAToN8iSBM5KpEwUUjPJzYTAr7Y9A2AEGHA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790872272; c=relaxed/relaxed;
	bh=pPdsI+9ngxx/DXb9f5gVXjmuXNqPHX2f9c4dLhBsLJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jNviI+hErY5du1VLMpEcpsTlESWPHIxeC/tLBWfUKqJ89Wt1wguRVaIUdXtn/JeWKDd8fIiEqF4daNIHua2PevNtETfYUp+mnjKuH3DYIMutUjBMgnf9uMwn7f/MCYX8iQxUbFWNSgvWP0WkC9oURscULJRhhRlQeUJRgEG4wQnSAncswINNNuvrCbLXpJrw9ONDenJtNhjbSWBbSiRzC4VU9uV5SXhlhfad11UO2if/rOFiwiTM1iA8XaJO9ZO6MV1oAxIPmvuH4aouXWWFFl72EGgAaNAYCs6pBBqujWUnBM2b/vEkBNhZKEByZiP5RTYt1v2XKP6mUG2PJTPjOQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hcr0bLn4; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hcr0bLn4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwcqL49Xgz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:31:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T15+XZmvr4uLsqX+N7gVcAxmeqRUMl68e7+p2MzrxY5zXE7vRSad7myZaNrWtTXy47Qb9+b6sjgaS1R8JUwfFGiho06rAMWrjSRHex25Vw7VkWqjCMBSNDZrLVE0GEVIr5CKUmSZP2IabPsob+klgA0TmuX/ZhqKIALFUf+AWCHYSsQg9MuieHqeqOac0fxCvzS6rmaHg1MCIymWMb0lA+0+WRISjiTQc9AgLMOFE/2V7KIkLdRsqNkDe5brCAGyZpG+fCwYTbUv3nO2whNWOe0Cp4xD8dvJWG6YWGYHoz9As37/1nIVz/fo4bHKds4/sNCzb8Viqex5a3xwCRyq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPdsI+9ngxx/DXb9f5gVXjmuXNqPHX2f9c4dLhBsLJU=;
 b=hc+cwVYHwtDZCYkD0RJpT0ORBjPd77+NZs23lYsy4k1uvmQnTYHIsAxjKLfmuG1Zcpr/KwiD1DDdXAFJKwYISMFcfbZMBhZerBesHh1f/zHD/ue38ALBMA9w35pLHkuz/QBEFDwd54CzHrd8KpcczHKEZRYLpF4FN0GUWQp7h4y3jfER4OpRTv7BV4rBTJp8h1DVkRNlUdKfBroAlmOEzD3j/WlEakUrgtkMy5gUcmedm+tFtk2Sgqs1TitIIc6QJw1KpghJp60mWCadnpkBcNoIk4uvXfFc1V0NzY9Va1MLQO1DYybeWN35g0sGF6I42+bsoZ+qzznwbhD7JuFfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPdsI+9ngxx/DXb9f5gVXjmuXNqPHX2f9c4dLhBsLJU=;
 b=hcr0bLn4JALeIIeHc2VrgKXepxWg7kIklJH67mYsg0IfTcvyV18Kr+W8qhcBGbzWnawVGY+6iqOHqmA5V2ebAMjLadWaq8QInBkAqzXmChEJZ0rPHQ1CnuG1G/AVAFie8BPeCgZgUgaRC6vCvKUzMyDAq+dj+yaCKB/WOWiTtx7yzte9gvZq0h7BaREiktv8RR/4+hSPBjzSnHpQF8+vJD7vGi1FK8IR1+q6vz8shUdxkKdo8se3oMZmigRhMK5DkM7LJpo/N9zEsE5bOnQAUYDk0GSjJpNtNL2OZTQ2HE7SkM60eVTSCcDzAcwL1uhSpSGIELzpd/2mylDngjMM4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB9045.eurprd04.prod.outlook.com (2603:10a6:20b:440::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 16:30:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 16:30:44 +0000
Date: Thu, 1 Oct 2026 11:30:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
	roy.zang@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Revert "PCI: layerscape: Change default error
 response behavior"
Message-ID: <ar6KqnfQ4S5jtqeI@SMW015318>
References: <0FEA6868-5A7C-4955-9FBB-BE9A1AE8D3F7@getmailspring.com>
 <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
X-ClientProxiedBy: CYXPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:930:d0::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc219e2-0c43-4506-9a17-08df1fd95703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|7416014|18002099003|22082099003|4143699003|6133799003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/6Q2+5SvetV9WkKkOdD7GlRfqExjzU3H9D0A5xy3GiCchYM1VycmU+yvPHGYznmVlGkGI8zA0sD2RuuxgE7aSOxI5M7GAWsoIlJBIZQp+6494z0jyorD6yQAcPSclQWPTFfLeVB8OwX+akbeO2yQhaOFVtZcjBezH9rD9UjWQVpZyoJSSXyF/NEyR+6FmyrfwhXMMNafrY0Gh637ifsMYWvWh2TbLKsXlQXnAfXPUlDbzFJNQagxmTmCh1AVueoX2KVXxZ3xzD7mSZwTjcIikMhzKo++b2u4pES7/RYOO+SbeKMaDG9Q/8jbCd39I6LLRO3BnRq8rWg3YzJjlWe2spA0dGQTXYBJSX8+h1+D0h3QSlQv565Ad9XLYTUTtqQph1imbmJQ58ENeAvxxx4KwDXkvOhhlT2N9BJ+7AsnQQDZnz62jb0ejVpMRrHaPw+zC9xAWflC0tKU8m5bepE55/BjA2WgpVSs2us+QjTdm/4xLdiSS/VpkgTbLzRPPXSKx0Jf9L5uLOmk7zx/UezvzTiZ/c+rIxErnW5KiSQrl/n/t7cSIglbFG39PrHcroPXuffixLbsG5Myh+7p6xcj0jCgvYM+5vU39Qm+5f53HQsnkKameZTb7iP0Wto27ybCNhlpoIMg8hooThU2/5QPRJf9vc5gxv80LozFaDDphNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(4143699003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hfeCt+UROdbbCQKO7Y+pCM5wQW68xsRr/MxYX4yQUC54y84ACl3OxY7dLf1U?=
 =?us-ascii?Q?jmmLHCz5sGlaQ0P+HMFNlGSmJYsKbO6R2UWib/I00wmgtHFRQ22C/dI838uZ?=
 =?us-ascii?Q?GkFTJdf222b/gexZYNEa5i5dVIY1RbTgGq1agw2Pm5s/kcIDVyNZNtOAmrHz?=
 =?us-ascii?Q?zA5I1USPgOm2ImnWAcomEcnXP8YPzWZn1lYVuJ2isb9LOmboEV0cLD2H7PML?=
 =?us-ascii?Q?ZbCedpptjOfoIH9fBEjPg1Tj1gta5fRa7pHsMcWSI0YVU20ULdtw/8eT0rJ0?=
 =?us-ascii?Q?X17BHz+Ke7b7Mg3Vvbv+kCKf0JzmX5Z22GGBUmEbq7hI/pUUKPZgS/VeNIbz?=
 =?us-ascii?Q?cpQVfJMWVaEQghtZS8tyKREgso9ryK37yO34bQZfULtvNkewqtu4mrKVfM5e?=
 =?us-ascii?Q?xDC0FnBS+czojot0elQXNqSaEyd2Q64lh7tbw6SQxuuyGIzStKUy723Xh+9I?=
 =?us-ascii?Q?yPCZle6FBszmC8kiyK8tb4lbKRBfIX47gcBPktzIyRwG4G93cR2WuUTax/YG?=
 =?us-ascii?Q?d2CNLdFcsL2cyDoziPXmEtJBNdBVJyuN2lR5BOUYutCQ3opOH7efF+QpNGND?=
 =?us-ascii?Q?XOWHuUcn68mVrqnwZKbcHTobIKqlrQnFaUK2vZelevbpa1yG+WOhNSC5L2tp?=
 =?us-ascii?Q?zpP8ZU1T/87/d+MdHORg7hVWrt14ejC4PYuGlcWukW8hZ6ZF+ccvDlPugSva?=
 =?us-ascii?Q?6k5mE+KcJxiZAjxVQelP5mzHwC8Wo6q1sqOoLtTDbvIoYBZC9qt2+OHaja9s?=
 =?us-ascii?Q?l7VZG16cMOC0RErccaNZii242onCCFXDYZqm7CXZ4tZtW8e4AFCUhZ2P/4+a?=
 =?us-ascii?Q?ueJQAxpW3yzs/z5+OE+W7zBAV3at9xgFvft7eUNelgwmv+UD9mXXh1Y0rXFM?=
 =?us-ascii?Q?1pmny3p9eopG0mnj72FmFwhSYLoW64gwT82IujefCn42MPv7Y5JR5LhBkLGH?=
 =?us-ascii?Q?W2wv92OewV8q1gf39QKMNyWunoi7ga76ofMTWg0Ml7hgF1ZQXWQk6yLkhKBf?=
 =?us-ascii?Q?1s9hdqOK4DTOmD+8RQhuRgvLiz8X2gtadogQSnJDQcmPZuj9jj/wxJ0cLsTQ?=
 =?us-ascii?Q?zbxtJSPka12sOhtFt3swhTrbmEQ0Ma+vOxLeZaKOK/VRnvhtI3ga2wo/yymc?=
 =?us-ascii?Q?djfLgBsIFXVYPXeJCm++iE/ZVYXP+RTnDxmce/kIp3pDZVW6fKqJ5XOdTq9X?=
 =?us-ascii?Q?F0DQZxaq8B8+UMQdMdZMqBmpCO/PGUw5dgWLfuCB+9HYfD9GOZIE+gHQ/2vM?=
 =?us-ascii?Q?SJywVyTN60Zrtsb16ZWJKivML7WpkihlslmqiA0Yh5cdHGe4gs0MLRXe7g44?=
 =?us-ascii?Q?cT3+Afj3QLkbnBK/qkuOZALPRoIiloyw946DhPk3MiaAOiHA0XSo4uDxZcHq?=
 =?us-ascii?Q?cZXJ9QxsmgVsuq4OW3JFzsvoqUyiLOZGn44AMgIqhcVBHTUCTifjkf7lzgXI?=
 =?us-ascii?Q?3A4LKO2d1AqC5LygW1sBYEwQaj5k6RfJMvtbdBOWitwQ1LmwM+uSa5AZV8wt?=
 =?us-ascii?Q?3U3O0ExmxYW8bT0y26pwYaK/pixxKhzoyKn4WISxe2i0PK9WSWcn1afpgZij?=
 =?us-ascii?Q?SotkaLd0Ahq/Cjuju3jrG6eizY8kzDTbcrShOMQ2151J3TfNty4MuWzfxBf0?=
 =?us-ascii?Q?ewXg/nGQDYBslhAlwamBkDdCK+1BADX7fIeyOf1TsTqGtw4EfKr6Vjwxo9dS?=
 =?us-ascii?Q?6FnzBLU4NDmgd935T2sIR9SjA1TNhYV3QeGlkD63qIXDGZGuDvDLXcK+1cSZ?=
 =?us-ascii?Q?AVwlZJZdigSFIvrqsZc6AriwXzyYvNg4lNIRJwpqyaVzgwC8dfTF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc219e2-0c43-4506-9a17-08df1fd95703
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:30:44.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpCI2+HlP1dqP87RXKNomT7b31lsP5KNH/ax4pHNGCkIDvtuQS44GCReJwoKwu519A5YFS28jd23pPrsji2A2v4HroYUxbz8NfyIHGw/0X5TH7v4LxzCGYCegW1AE4hp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9045

On Thu, Oct 01, 2026 at 11:33:23AM -0400, Jeff Barnes wrote:
> [You don't often get email from jeffbarnes@linux.microsoft.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> This reverts commit 84d897d69938
> ("PCI: layerscape: Change default error response behavior").
>
> The Layerscape PCIe driver programs the DesignWare
> AMBA_ERROR_RESPONSE_DEFAULT register at offset 0x8d0 with 0x9401.
>
> For AXI, the documented default with AMBA_ERROR_RESPONSE_GLOBAL cleared
> returns OKAY with all-ones data for errors on non-posted requests.
> Setting AMBA_ERROR_RESPONSE_GLOBAL causes an AXI error response instead,
> with AMBA_ERROR_RESPONSE_MAP selecting SLVERR or DECERR for individual
> PCIe completion errors.
>
> The value 0x9401 sets AMBA_ERROR_RESPONSE_GLOBAL and maps Unsupported
> Request, Completer Abort, and Completion Timeout to SLVERR.
>
> A PCI configuration access can race with the link going down after
> dw_pcie_other_conf_map_bus() checks the link but before
> pci_generic_config_read() performs the MMIO access. If the transaction
> results in a Completion Timeout, the Layerscape error response setting
> propagates it to AXI as SLVERR, resulting in an asynchronous SError and
> kernel panic.
>
> Reproduce the race by obtaining the configuration-space mapping while
> the link is up, then disabling the link from another CPU immediately
> before performing the MMIO configuration read.
>
> With the error response override enabled, the overlapping configuration
> read results in an asynchronous SError and kernel panic. With the
> DesignWare default behavior restored, the same test returns 0xffffffff.
> AER reports a non-fatal Completion Timeout, and no SError or kernel
> panic occurs.
>
> Restore the documented DesignWare default error response behavior so a
> failed non-posted PCIe transaction does not become a fatal AXI error.
>
> Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
>

---

should be here, maintainer should can handle this for you.

Reviewed-by: Frank Li <Frank.Li@nxp.com>.

> Changes in v2:
> - Change the subject to identify this as a revert, as requested by
>   Frank Li.
> - Document the DesignWare AMBA_ERROR_RESPONSE_DEFAULT behavior and
>   decode the 0x9401 setting used by Layerscape.
> - Clarify that the setting propagates Completion Timeout as AXI SLVERR
>   rather than causing the underlying PCIe transaction failure.
>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 14d6ac4fc53f..d333f1ae8a41 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -28,8 +28,6 @@
>
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1           0x71c /* Symbol Timer & Filter Mask Register1 */
> -#define PCIE_ABSERR            0x8d0 /* Bridge Slave Error Response Register */
> -#define PCIE_ABSERR_SETTING    0x9401 /* Forward error of non-posted request */
>
>  /* PF Message Command Register */
>  #define LS_PCIE_PF_MCR         0x2c
> @@ -103,14 +101,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
>         iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
>  }
>
> -/* Forward error response of outbound non-posted requests */
> -static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> -{
> -       struct dw_pcie *pci = pcie->pci;
> -
> -       iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> -}
> -
>  static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
>  {
>         if (pcie->big_endian)
> @@ -180,8 +170,6 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>         struct ls_pcie *pcie = to_ls_pcie(pci);
>
> -       ls_pcie_fix_error_response(pcie);
> -
>         dw_pcie_dbi_ro_wr_en(pci);
>         ls_pcie_clear_multifunction(pcie);
>         dw_pcie_dbi_ro_wr_dis(pci);
> --
> 2.43.0
>

