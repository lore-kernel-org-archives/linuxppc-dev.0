Return-Path: <linuxppc-dev+bounces-24500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BECAC4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 14:35:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3jhn4hXSz2yYd;
	Tue, 21 Jul 2026 00:34:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784558089;
	cv=pass; b=OWlHq91P1o366gMjZVnNpf2ALM/iGuQ9Pe5Vmo8byyYjcW/iMP62vosOpd4aNvLSR9xWEJn+1ZCxNdMeSxQYkU5/uLUpjZ/wXDo1vpcpzv22fIKSbyififIjwkT44s4pSVAyaSMC4tGIFnXR5rcmiPTULFQUlj+/vLG/NhCQGGqcnBJjYX+nqNcz+Zlu2psF+WlNlLrhaR/90fhIw/yroh/8gJ9/11XcmQueMnRb0qLsA3jzw3yr4ejdTG+klBAGNVIkqaZna5ImD2BmgdovLwDc63Ln5ddPbj3nfKKpQ/DQNauInRhFRFyO1x4YFpPhZizz1QZXp4N4s/nxqcBlBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784558089; c=relaxed/relaxed;
	bh=d4C9Byof9W2UGgrTzIPNEkz5vcoDqc6h9sGuEKRkefg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tsp6ldPF1PAZyQtRf7p+9JlUMYegnawvVo5JjaxIHXaJJKTYuTx77pxz7Z/UuTZFDN5mqnLsc51Sk4kbbu8I50eGD3rRnWMY8mwvJfTUw3i6HK+dtZZugk1X/vhi8FsZNQvgxw8QYrCGdqDGlg0Wu+rua+IqraWmMXyCvyABXzOJBvm4MeyoumqR+b26EMW2mEs60dCtslhxgyGxuX/99jf3apj7NR4/UHBpqrebhuG9nP9cO1pVOZ5xIBC4XpIrineXbIatwrgilbmcu+AqL8rh9izjmYN7gKB+euhQvVQVp9cx2WwsVFG9GnuGQKQq3BBSO4xV/ONIdAZmEmVaww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OiGFw6Am; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OiGFw6Am;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3jhm4P8Sz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 00:34:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npJ5hwnWpOHWizrNOIONu0IiEgJvWApxJt7YD5Tswq++pY9Ci8w0OkCRWt20greESs4BoodniiVOQo41CIoRvCJbjWLAeEgHD2Igm6t4PNjR29I+bjg9IThjmuO6Lfahb2Z734Z82ga/lpoT/vaBjnU0ZbxcDkiPb76eNqTEa7uAUp3UN+fsfZJTElLBzsDTWeXG5qOM6Hx9yZBvuvC/vSgwEYmcHg3EnmkvjddBf0OIaPrAVHxjiRlExosz3FIHRUJN45IQX2XmWzfYGT8FN8L39e9XXukXitKKq/EanpMVyRreHczw1NMCAzYotb4noRE0rdPjqHvsahob3fcnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4C9Byof9W2UGgrTzIPNEkz5vcoDqc6h9sGuEKRkefg=;
 b=rGhgFlg+F7Nl5eitz2De1eWDaPpOoUdru1ZjAamM7iSepOl7tt9FWFgsLNf3/hopgHkrfQcUHTXRiDDGF5kKN/+8L4wLjLEJbqOQUNxKkZAzn42jKs89/rS+FRG4H2I+QY4RodMKU4h7RXWPktb/NxWQKcKjDqppf1RCjKzvWjoxNaYrmgkX4cL2poDS1fZFOqS4/ncasIK0l2f8Ll4W+2rQWDDAz2Pk538QAsNEE4g2wZFNtEc35LGFsjZzQTxS/+l5bMGEMDcUrLzZv/oA2XfmpY6JQ1zVg4/cv/e5Kj07uA+Xw550F3am5ikgQwVMBXh38iiMbFUSzj5pJ6Tgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4C9Byof9W2UGgrTzIPNEkz5vcoDqc6h9sGuEKRkefg=;
 b=OiGFw6AmDfHjNH6oluaSFV4sdE1KgzQ61dDiB/zM4FtkjLODBjAZ+yE3Gxg7d8C4aynO0Ynto1cydawFNRRaCalZOXaRabq9GBrrfQ4XTGR+5YUgL4mg2QjIJrNrKr/axVFlItNdK5n77ycXhnhXnqho9qfya5IsIyPBDBMvMZ2n+ij2/m5qeN21x0HPYKPGW7vaq33Jh4c2Pq7Z+MtvagtAlLaG+TNA8PYEvlJ1X8IQ/UmX/L3G1NCJRmwM526yoQCl/oxJehsMFjgLEU0b/7JYODIcpkLdAxWWCG2sW5FgFxb5a0NZdDGaGIQ3RE9UBx9ADLkJvXM63Mv8gdqpSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 14:34:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 14:34:24 +0000
Date: Mon, 20 Jul 2026 09:34:07 -0500
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
Subject: Re: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
Message-ID: <al4x32yFNcEAAbVM@SMW015318>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
X-ClientProxiedBy: PH8PR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11360:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae80a3d-438a-4ae5-5c2d-08dee66bfe62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	WRb6A5pvBydH4WQFmnEhFEuoc2JEjUBx4mxuUs1acSzrtnw9/7GrgmBchC1ViEavD02uFQW+/gJm+C3cyPsRlS30ehMRDkJJqNyZSRQbatmYB/Jt5T9N5bnQ4XFyQrMDosY/cWostcrGKfQcYsCK1AOCXTOQJX9blnDQP05Zq62sxrzvaKeBBWL9u3lOd/CYxbjRdsrpcpUBMknGK6+b6NUtxjmxRYZDzg/utRpJGy6wdbnEDzBST+oCe5u0oQoGVgxUB2+EngKEnDxmymoMS3E4e0UL9wce+zjghHQpkQsnivfFbO8nya73nqRuICd2BXus2uHk6aD6FTv/GDNhrK3QRZEBM7QOpjXKEWAMDuDR/wtxueNHbT9oi4oMIqobfCcSwI5lO7nvmR+T8YHD99GyNTl0XiUKR3EgOZf+Mpd4ij14bEKce3m/yQT+T8lmkhOc+SJPQbkDuh84hoGIn9T/01F5zuvjhF9NcMDFSnJNS4t1X1VnPxSOK8SG4mtW09fdv4VRVd+R0wGLOAzhxrx23z27gJFSdQ/Jt3FWFJa+BLW5cHjlc4vo22MjuczuXiXwR93bX8MGuSSO+thB0CaeZC2c0PxQ6DdLoZt128A5snyXAT7bOjpTWlPpGxriAq8t+Ev0W55I4DZp0fQ8IvpWrLcH8g7d4gMw91KIiv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+hegIkEwIIFo7w7TuB3JEfLvx2dOwcwj4wc5imGMZXm6zr5AO7O8UFDhg9o?=
 =?us-ascii?Q?VlXFAQyhdjTOelUvIDK4xYevNakSmJMq5rg60UG346rTvZCdJy9lsgxWzWMU?=
 =?us-ascii?Q?k43fV6lvBAYK7H1tdU1gEmlhOgT2bevLOieaLcSXtV+kB972H28p/LNxf3Cu?=
 =?us-ascii?Q?f/4Vkn296AAzeN0UYJikpFnRhs36pxivGo1WHpLUbGxHVNzW+JrcqUf/MbOb?=
 =?us-ascii?Q?QpeFemvdNkDJEtphaUkqJIx0ztxGe9dCwm6cNfrluFuz0lYAJ6YlMn7UbdmA?=
 =?us-ascii?Q?mefJRiE7wvRVSq+b4/L1w8OIhFIQmeQcLhqje0lHipZixtwjgXhdhvxRqg44?=
 =?us-ascii?Q?iFrjrQkR3KEu0l/MAIDvUYWXqjK+Ez5NrhSbQPtFM/pjp05GijNV3+q81+a3?=
 =?us-ascii?Q?S80hinhnW8NdK0IblNb6Y/hra/NXi890jv0s6ppXxhAvaidis10c1Y7pO4Y0?=
 =?us-ascii?Q?a/HUFGfUMmUOlMDgRyaMwlK2bpgpdFApKN1ViQbLvXS0YufUDbppNYJHWkSc?=
 =?us-ascii?Q?+g7QETYvOWnE1oDUHISeaz2KeTCs8byTt3wacn8/ymSJJ70IyQ+Pci7+rGdw?=
 =?us-ascii?Q?1fmF4DgDxyNWfC/BPXOE8MgyghT8Q2Fmm0DOwsza9OZrgXHmLyDLByxHtbhK?=
 =?us-ascii?Q?W3nhBQhOM6KQE13jnnOQRNq1mUVr62WSG11w7vWpeuutrDwXX5kq0zavJwHP?=
 =?us-ascii?Q?e9yqSL9gQIPV7Y0gJR298GkB3nKrknOL6yA/MkSxPzAUw4l1WmVL7V9jmw0O?=
 =?us-ascii?Q?rk1tvW9xP0WRiRYnMrRaSdze3tph/baovzLafgzQE/l1evONrOc402SOpy5U?=
 =?us-ascii?Q?keuH0ZCQ4whIuiejW/giSTMWSLJbKkQa39HxhWea4vW5DlZbUH/C2nt0d+zO?=
 =?us-ascii?Q?NzTBezV/9P6vnaZ+sq5oMS+8E2pL7jqRfAPLjC0hZSjPA2KIcGz1oItd/nVq?=
 =?us-ascii?Q?hZHFuwZyObLHtu7EYAuJcaK/AmJ/QnOdlnHb9enVCXDQuSKwmWD7hCFxfVC9?=
 =?us-ascii?Q?vSmcze6Ey3pmT3h6A6x+KzpaiZU3t5+VEAH1TV/CQjbomk0EL/bxdMhyfm/k?=
 =?us-ascii?Q?RvdPRkiHgmGCC1oFvz57VxOjSs/YtQte49Y0J3RUjxykKPVrBvBsDiaSt2/k?=
 =?us-ascii?Q?lsOlR0QaG+OdV6vADm99hM1OGfmoYFK3vl3KzNB2E68EPC1yUOqxJjOalP2g?=
 =?us-ascii?Q?djJDoZeIpssPU5YdJF1pxlJbWuwTe7pcrQfDsAAX7RexQEAFfqn/pn2xL+gs?=
 =?us-ascii?Q?Pl7gtWQVKQ7QqvWdI72Jm8la1IdY+2U+P+2TUFPVtyoA+B/wtFdgvzwYjUNW?=
 =?us-ascii?Q?beyps+ScdK/4TLi84w6fPR+n1awNl56mDY5/lat1mb6AOBOPXEgVaQH92nZx?=
 =?us-ascii?Q?tftlXd2NZ6f2GDZYG468TMSBp65CXGZiWUUIonf8OPnYsVPH9tgTUWC9duLU?=
 =?us-ascii?Q?/zQzOho6n99ecycuQnSwv65BLAgxZojrOuCbeF4yWbT1HRKDjGALye9oQI5K?=
 =?us-ascii?Q?5wOxqKTq9Bc9Fm2ekyFvz8z40V7rJdPIjo0nDPey0BQCEykd+/V38B5DRenk?=
 =?us-ascii?Q?iNm8fx/ccpEQhT7RU4vbXXu70LpPfhRcqwYybK8S9uVJN9CX+d+n89qpGRSw?=
 =?us-ascii?Q?mFxhyeaNLtLYgPBDULrmR71CmS9U1Iyjp1cCQTw6kmy/ybRH1YwRWz+/Nv9Q?=
 =?us-ascii?Q?B/3LvYfRBaycxg8zyZPqvbMkitUf0/mlqQIbxFJSOpi+CVhiKVR8G3JTeCZk?=
 =?us-ascii?Q?LU91EC4kBMm00PGwPO2tZQHPMXTiFY8nQxAoEQe8lJelp2vKXrPw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae80a3d-438a-4ae5-5c2d-08dee66bfe62
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:34:23.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD8dIvZ1xYQfQWk7YYpvAtd8CeFaK1cZ25yqKWZ1TNKk3YSRC3eJnYqvK+IdPMxDoAllIWREcsrQfUZ25j5JetMULCiYNCpiYueMVlEIDLPAyYRPa1hA4oicr6Kf1ajE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360

On Mon, Jul 20, 2026 at 11:24:50AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/iommu/fsl_pamu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index c83bbc3faad56d6ee1c89b0a7f74028af02c81e9..268a1f752fbceab4fd24013aeea5df1b6982fbb1 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -975,7 +975,7 @@ static __init int fsl_pamu_init(void)
>  		goto error_device_alloc;
>  	}
>
> -	platform_device_set_of_node(pdev, np);
> +	platform_device_set_fwnode(pdev, of_fwnode_handle(np));
>
>  	ret = pamu_domain_init();
>  	if (ret)
>
> --
> 2.47.3
>
>

