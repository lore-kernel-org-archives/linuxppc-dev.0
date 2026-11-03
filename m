Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57062606D2F1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tUohNNms
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJsTK3C3Jz2xSZ;
	Wed, 04 Nov 2026 02:10:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793718645;
	cv=pass; b=OQWCXJ2QeqQrqVRui9CSBzjPytqryF4uHJkS8DrIb0bJQ/ZwV0fVIYez+FEB5Mo+70sjGKNB4EZdCFGleeno4vIuX0kGvsLFQF+BL+Mh0t5WYt9llGVhJPr7hBi/UyZqQFg3JJwiG3J/R6kxH3EOTTA18w9wIF5DPChjUJ2iOwmFFknpCN7TShlsbGgET7reJ/Y5p732xs4gZIoaZTagaYw0Vx4ZhNtZZZmu6tXBzd6/vpgMx2NJZKU2A3arvT6VwDoHZa9+sp1pvjqziXMd3lcLOJ41WnDTpktgAx5XB/ZjZ6xP0UStz9Cm2RfI5zBcmYRbNF4oDDoQ/vdxc8Gyzw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793718645; c=relaxed/relaxed;
	bh=P5z+vX/DI30NToAck6Oj47chrAMcMfCen7lplugD1Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bQ0QgHaxmkZnwiKfKhCdEzbfCrL0CkwJ10yRw0NRjJi2S2h6eP6qShhcMcaYPOSdIf3kSFJP7H8kyBTPINXYHbM7upqBA1KJS2QDhFJyW4bozNUzq8IYfap0N73YPvRW7V12vrp7ec4s/a5tgd6yz/BC+Kv+jQMs7g+RTV7RjV6iKc3QavrBa51KG5gqqpw3sszxO+KgvWOOhiIANz9nVlaE1JOOe/NnUCW4l2zy3sGT+Tfvnq9bLNJVW7N+vscxI4uNVD93eqBTG3ad7ET4vFA5THgkhRroskWCnx84jFurNVbGfCvO3JQWla3dTzhm3Lqli2J4xMxB3IJ6EFGcdQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tUohNNms; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tUohNNms;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJsTH2ccsz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 02:10:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evwNdRoYPd7XR+cOTLumL28NXkvoZ4nuQz4ZHR9Dc8LfJx304hdnEVOJH4dL5vxZWHYmeuMDms+AjyGJF/dYh6vmwZ5x8X5M6uQ23uxgV7Alh6L7gmO/zfUJWcRCOyS8ztj42wpGTp08aclhlm5HcXeillod4pVs/JcLtUSQLHqjrN42Xqn+hlTd+PUk3YhP/OYOKkOHADqOYv2nz5tH1t0mAvKdS2+1ecqQ2pS7tMtsMmEAb37TODoA122oQuRid4rXGky9Isq64hgq05M5vlV5T/tSQwjXYObVPFKct5GbHKeG2Orp8zMfsqB2i7vRZLgai9WtorseMoVSwYd32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5z+vX/DI30NToAck6Oj47chrAMcMfCen7lplugD1Dw=;
 b=ie2WKoMrulrMIPCO9hKb34KYcJ3VgDKs4QKjpYzCOT5Kmrbu1Ke0S07Wbied6S/+sWVpkUlSI5aawXVbXebRFVuDn+nrE55NP+lFLzCHL2/9uHeaWwX4LeJ5drkOqriVS2J3uapGm19IDX1J/Nm6y7PM5ITwnBTiFU96JZxeXZOchiibOb6mbMhtm8w1E/x2DV7HbKBL2+CFfbW8ZP6iKFpVVvGMCNX6wNeLjfZWAblyRSNpCD8tL1BeTWWfuSQJU30LUJrX5Ugb8xgcegCgE+KjfiOWTxp3Bl6Xxn2SJll5guT1TgjnOmL3qUrtuLWIS6F0jwyvgRFhGDZbT/+Qcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5z+vX/DI30NToAck6Oj47chrAMcMfCen7lplugD1Dw=;
 b=tUohNNmsrAkKGB14Dl3bIbKTSRxCq2z8KuX13zFl4tcPjzDmciYEcRqUK18mzWrbotD3++0IYZDFAYRewx/JmRLIwpm/UlN4nBradvYT7QQurHUGuNoaEZaRazEIE5WhQEi1Ui/3y43a/cvSMqkUi0ToLORCENYdsVPqXMwcXbYfC03/ngqbG56ISRVECGx19FL4AoMNi3ny4JEngH0Xx7un8Gp1NPJEfEZjI39x7aou3fovW2eMC70iFrSfDQm1Q3LpuYMtsvhWv0dfBHjyBdGeHjAWV7TscMEfgJPdnNe1AZJjzAzxylgnYqJyQ1KpZw8h6YiuoYM+jRpbIA4cfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by ZR6PR04MB993147.eurprd04.prod.outlook.com (2603:10a6:910:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:10:18 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:10:17 +0000
Date: Tue, 3 Nov 2026 09:10:07 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: add the NXP LX2160A RCW pad mux
Message-ID: <aun5TzN6kWdkr5x-@SMW015318>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-0-0a61a9837744@free.fr>
 <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-1-0a61a9837744@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-1-0a61a9837744@free.fr>
X-ClientProxiedBy: DS7PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|ZR6PR04MB993147:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a9171e-0f45-4321-feae-08df39bc9190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|19092799006|261022105027099003|4143699003|11063799006|56012099006|261009223027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003|3023799007|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	Ic/ye3IXTPUusTvpv4iq8b3Rc4BKATQaeufHPa8ReTsI6/Er5sxdmWs6yCMBElRIgWafQT6celSwOK89y39tW7CXRzBDrzSkg+CNKsVo0itKGzK9p41z6PK3DifkTZ/k8X3lIydUC4QbC+cJBSm44Z1f23csKX/Ccxz63HQ26sruHEr+oilhiEOGNXjHnXYo7bENfm+AdB/QGI5tCc8pFsmfEF8iOBvsbrJRNygR2yKongIf04S4vdUp6dDnH2hWLa8XYcTM+Epdoqb/JSuRVy9ImtEtTn8UeoDp/F4g+5eoH4GnO98L9qvEpO8AsVgN5S0lOFEhib/LYMxZUkOTaRAmKTaIxP/du1ya5K2Zb54UvaUM9CxSFMXNmTwgt04JlYnDIt1OoSevJJuYQiD/DnkcAJmc4QOb5/ciQNQ55rCG13e0BQyzsbvxq0g88/GVIy0D7EXk5PtH5aUKW5IO47UnrVORicUcviHjwosqbGabqoBrdxqzEJB35GI7U8w5LTK0ma6LP0sNSkYL3hblZaSFBwOnu5/m+7WJ5+sbC4n/YhntVherYgC5Wxq50blZryYzArRRpHdFxz63GxZKH7dryah1NWEL5tnlRx4gCfZFNBrHITSUvP+dpfD15g4Kja7QWmCeQapPFSpZDRYCWbmYWpe8b8Z1dDieShmaU2I/dW1B7oAizxUaDEdnpnBJYFtbxggMHctFOuMf5lnN8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(19092799006)(261022105027099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OroDO4NcD6MSTyn7h3VaCkXqslRP1+50Y1QSGF+GxI/wvcdGpptBk+fpSdMH?=
 =?us-ascii?Q?aKW/djoNdf6b8AzijBIvdFlx5i8yVaKOuCM5z3zV0RpbREx70NgT2eNSApEX?=
 =?us-ascii?Q?aQB0u7aS7XQr9pNq8dgqnrdiZ1G44M3c15887kVTN8I0G3ahuwAx3e5VxUpb?=
 =?us-ascii?Q?9rakpDDAaIi6oOqsPNKRsgzHVTG3AnoP9/RvYpyhxVsHoVOvJXtudlgFIXg9?=
 =?us-ascii?Q?2+rRaKNBYynHLIHOLssbkywtse/sNzuBxvfZeKzfdoSqxaEdykozha1agCAs?=
 =?us-ascii?Q?tSELMxEA7C2U+/7wFit+l0H5gcvhZocL4QHz+QgRJcqmNfnXbWsxD7DPQFoj?=
 =?us-ascii?Q?GBo8aOdNb4DDc5+MbteHXBCLlCaSTjyif7J63QjDNIEuSQjT1bLtPpKps91x?=
 =?us-ascii?Q?yiB7WoqsGoNNI4G6pOmdHMJvpXZu982BPxPBlzeA229EMiu6EfjoTr9Ha+Jg?=
 =?us-ascii?Q?JAiDr2wCGTJ9Rjfxm6H/hje7hf1QZ+AHPuNcpoakd+MDNGHCRGp5H1J7vsi8?=
 =?us-ascii?Q?raZFvoGAl0M/lyKSfqxPHI/693jT6CyNNS+lUPMWrNnucxXquH2Pyqwc4lGG?=
 =?us-ascii?Q?88UMCKrZJgkqbKtR+3Ki/UMpG/3F97vC6wsD4ADVnORRZzb1bNft/5Pu1n98?=
 =?us-ascii?Q?Mq1mc0FH4t6tndViaSI/3ZGxpMCDJL+y44asxU/PF0yIP4vxMSqQ6g6OfrdY?=
 =?us-ascii?Q?RXhVEBo4FG2P/v5aObvAIkiBeMeJQc8Q2UTCxlxqKd3GHAuD15M4PmVZCLh9?=
 =?us-ascii?Q?0bk5KlWZ7BzgEKQ9K8whz6y8Fhd7Xh7snaoJ8bp3omIqB63fkTA4Mpqjsvf6?=
 =?us-ascii?Q?ZQ11Q5nY6T86Z1CNTVP0jIRJrmit2xsEGST2LPvQ0Bs+IHfOfwNZOFa5XUx2?=
 =?us-ascii?Q?Ym6+71EdsAiKEvFFEGf25qKwrIO2fzIHB5xnmIA5SksUOdAZ4peg8QI/EVCD?=
 =?us-ascii?Q?TvKVLChacwx25RmBmNT9htlTF43ptR4F89xyyJ+eNQ5oz0uzAZ/YCoi1YfYm?=
 =?us-ascii?Q?Qwfz56vNXT4o/Bgt9a/Z6Mm4oEdA45gVxGdFSeA/dPofLVaO6UaS+WjQyQfx?=
 =?us-ascii?Q?iEIdUdSfYkFjXMLu8IOEowT016T6ZydfyoLmxqetHOEB4yscPHNI+BHxn86D?=
 =?us-ascii?Q?sBodO6+EeFN3zDuWKmMjNWFP5Ti4d51o/4aob5iDjc4RJ1InWo81ZoJZg3si?=
 =?us-ascii?Q?ZY4VIZoDD2g7Oncj31sgAEMGG90SXWi+vKtn+05bUxdOa9j6ky0OWr9C8+1n?=
 =?us-ascii?Q?zq9LVu45gQ9NeMrcSkadBPFdubeM84zyWVottQY5yc4hoCNc95X8tfE1p2EP?=
 =?us-ascii?Q?XQyVe9IGoQ3zjg77i1St5HPwE6yvIk9s5fBvve8eUbExr+kcWUYozODXQZR5?=
 =?us-ascii?Q?SfedxITB3dz3NuVxwtw1CwYZ9JJCKrr+83JKEzUk08lXveTAr3LaADt3HEnU?=
 =?us-ascii?Q?meBphutiv6utcRs+OrFxiQz/UbDpTbcGrFtJYpSvXBG2Ks1M/Fx8ZFV/O+/7?=
 =?us-ascii?Q?BM9NbQYPDfP3Qg9nSiPGgM9CPD420bh64U1vUpflIjI8GFIPCDT+/jmAvdyO?=
 =?us-ascii?Q?05fPUdD1J4ezPval/PafDksRB6ofSwvQ6YeVhLZSzUQKyef+uhj2FEc2i2s/?=
 =?us-ascii?Q?e1DHnWaVM7gX9i7tH2voXC31psqvYXXAhAoSviacYHLShMUFZWdQCqtlSAkx?=
 =?us-ascii?Q?Rl3Wcx0KT3EyAW8vUC19Qx3OrsJ7VjVyWzJtXX3aqTjSdxj8ovTK7HdWYXYv?=
 =?us-ascii?Q?DH3qBSiEhfyntk/vicqMrt6GPj3opix0lQ1AA6l/CuVMAKI3YXy6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a9171e-0f45-4321-feae-08df39bc9190
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:10:17.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sKEYq7gwVOwXCUW+nrRChYuMu7EYk68mthwpHkGBPAajDGfivC/SIMBT+FC4ttxa52ZnVLqvdBtmABgwu180Eu6cBn4o4i5IxyllKN14xNQs3CKmi2Mk1bhoc/K/Hwf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB993147
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 10:51:54AM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> fields of the RCW: read-only in RCWSR12..14 of DCFG, changed at runtime
> through the override registers of its DCSR view.
>
> Describe the pad mux as a node without registers, a child of DCFG: one
> group per RCW field, one function per encoding.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> new file mode 100644
> index 000000000000..d79edcb077f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LX2160A RCW pad muxes
> +
> +maintainers:
> +  - Vincent Jardin <vjardin@free.fr>
> +
> +description:
> +  The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads based on its
> +  RCW. The related fields are from the read-only RCWSR12 to RCWSR14 registers
> +  of DCFG, and changed at runtime by writing the RCW override registers in
> +  the DCSR view of DCFG. The node is a child of the DCFG node, which owns both
> +  views, and needs no registers of its own. A pad group is one field, named
> +  from its pads. A board selects a state of its own with the usual
> +  pinctrl-0 on this node, a hog.
> +
> +properties:
> +  compatible:
> +    const: fsl,lx2160a-rcw-pinmux
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    $ref: pinmux-node.yaml#
> +    additionalProperties: false
> +
> +    properties:
> +      function:
> +        enum: [ asleep, can, evt, flexspi, flextimer, gpio, i2c, irq,
> +                reset-req, sdhc, sdhc-clk, sdhc-data, sdhc-data4, sdhc-spi,
> +                spi, uart, uart3, uart4 ]
> +
> +      groups:
> +        items:
> +          enum: [ iic1, iic2, iic3, iic4, iic5, iic6, xspi1-data74,
> +                  xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
> +                  sdhc2-data74, sdhc2-base, uart1-soutsin, uart1-rtscts,
> +                  uart2-soutsin, uart2-rtscts, irq11-8, irq7-4, irq3-0,
> +                  evt4-3, evt2-0, clk-out, asleep, reset-req ]

how to know which function belong to which group?

Frank

> +
> +    required:
> +      - function
> +      - groups
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pinctrl {
> +        compatible = "fsl,lx2160a-rcw-pinmux";
> +
> +        iic3-i2c-pins {
> +            function = "i2c";
> +            groups = "iic3";
> +        };
> +
> +        iic3-gpio-pins {
> +            function = "gpio";
> +            groups = "iic3";
> +        };
> +    };
>
> --
> 2.43.0
>
>
>

