Return-Path: <linuxppc-dev+bounces-28414-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF30CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 16:15:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htmcR3yfwz2yMK;
	Tue, 29 Sep 2026 02:15:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790612119;
	cv=pass; b=aw6LVY4jr0bljcZQ9CLloB5Q9Z23Zqoe1g4axxPcSSkEhCoaiRFBXD3B2jSr/7u8eFTbvYtA6oDpUXQOXuDSHKkZlFLFXMr/X8V6A7t4xoEFKA2nmdymv3Pz+BioOr/lMVBDoDqOkuI7K2w+OS8NV7drKmp8YArGhRZ/17+8Mg3wgzDA/RlhBo4bi1x4QT+MVszYHgLDJAat6Dxgwg1ZCLUB6Kpm0mXH5sV5LXoAHYuM7ja7dvGJilrebSlybfwMGBALSriXvSmXFak9ez5voQTX8C5yD5z0Bgfo0HcVkTspUxOP8CD2gjiF6+N/I+tLS/n0Ec6l7KTBsx62uYATRg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790612119; c=relaxed/relaxed;
	bh=hp8s/Z2cG2qvqsJd6O/O7K57B1/8Hgiys/biJPvR1PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cml/WWGuMAAYw4wnkVPy0S0KhrI7q0v9VxVF+KvhzzLxlCd9KZ6wisKm+4zRqOSBdfM2t6kny9BaN4yya7eQBQPMXI+e3kMbazVbngHXEVM82OldEkIl0nSwk15j5xtFTLEmvJSRhLs2cpWY67AD1MFajmUoe9dLrbevI6K7m02tsEcmSkGc/VQLnLuZp56nAxvyhDnu9D/B5MajRR37FZllsWhf81gqqUnyoBjOx6syx2df1DxPG8bEq8n0RvNwuiEYgle1lVZNJrlGxJD8/ye0/753lbJeuhSrQ2FhEaRa14/E1B9qepdnCosnDUFBLt+WpIs759seH456yMBQeA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=p7mQFj9Q; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=p7mQFj9Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htmcQ06Vcz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 02:15:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0CLeaEIBc28YYc4uObHMCSe+R80aejltqPop1pGqGU88E+DjPubhk5rGXF47YabzzFdy24AIsEAVImrbcXSfOub0+w4PXw2f19e6tUEMkh74HySK+0ZBLBEnXycE4KorBanFwOX5SKa25FvqK95optd6qfiQq8oaHTn7kMCxH4EAwYVY+fWgImdHVCi/oBYuBnrTu/xPGfDPD0qe3B5qBq/fWXwXN73e75Zf2gnyn3X3EbfgYFVTzkuvpsMG4YzIAuMoef66xBhwX3lozK6wHZUt8RCl7+TeRHBoyJ7eh0rlc3RqCz+bT+XlT/PtUDVMDrTZOaoYw4/Vnn0gEK4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp8s/Z2cG2qvqsJd6O/O7K57B1/8Hgiys/biJPvR1PQ=;
 b=RXJ+KUfc64sA1+XTNurG5KsDiEPpgdbud2p2LbMmAMDptvrAlvhI6zdyW+b4npmj1gw0MSwBn3+u7tcbgTRrSiwLSsGr2KUbGtUhxXLe6R5Fs+dbk5U9Tf5uz4+8fB+hwqKkK3CQJMmDpzm9z+Sr8bQ/qrs96Wx1m5vvYCvDtqoDQriEukA8dpUx8AcXbF3eBMrQw7hiYozMdcBxnieHZzH79RIJDlVugeblbL8q5Ezx7Acxb7zLa+uCI3cxy0t1EUlqmlG49vEK4fZFqZ/f/wCLzFFmggcLgWXANnh4fTO7aWnz3CR+UnGNBhxrQuIgkkgSxoGElKE7WyyzFoyrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp8s/Z2cG2qvqsJd6O/O7K57B1/8Hgiys/biJPvR1PQ=;
 b=p7mQFj9QyCDgEpENUWU/B54LAVhJlVhdnAcHsQKVhUSs5fFtgRfeKhmNRvnY1poWQ3+wFyWHoenmAdbUdwtHaeCoWSibe2FRVst3HsxoFhBD+CV3dgi3tpuEux3ZT4yVFnPEAlHOXjIzrxymxWIbanIG+C1S/oNzNN8KsUXjUWQhZKVabdRWY41RsUAXWa9kKsXkeLvldOORSDn38FSTKetPnIcqRho3cOInKyBnAzGIkiJ653TPafNYHmwVxboUXdZhSNhp/E2+tMT4uMRmKeKIQ5OcxX/85TH+ZO7vujounWfE6cefe63klCgNBcdxqgn9AQKmd++unuDkqlx6XQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 16:14:47 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:14:47 +0000
Date: Mon, 28 Sep 2026 11:14:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: vjardin@free.fr
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: async probe by default
Message-ID: <arqSa0OwMd1Bx_Ex@SMW015318>
References: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
X-ClientProxiedBy: CYXPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:930:cf::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 591b2b35-c871-4458-4ae2-08df1d7b9d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|7416014|376014|56012099006|6133799003|10067099003|11063799006|22082099003|18002099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	dwgqyct3blwYNqkBhsVA1KFGsroZzQwoBdRrElFXAa7Qy6j/iEicYloqP9Z4YoVRDtvMOpI8rGGcbVII8oUlIi8at8ABg/PB6+ZLtJePvAZHydqng17lMq2S0VCbWE7K6HpFfLRhHF8grq3mfpRyOoQ9NXnj2X72MBsYKdmUvpjcw/ATuZ1Xl1IQ5IszBXsQ74TSaZi3SMoFVbVURV8DGsfIrIOmKjf1igR4ZClSyqeROkZ9MyzInfQtZbyj4KYe+OiRxHw3h0vSpC3tfGdXLigz8I2SZYeetqSkZ+WpQ5/0NWZyId+bVlO/OTNzMfOEz1Rd7dxSORt1stXt07r5QwbITf3oA6b3/3RhnLZ258+/Tx6ZzVNA23ce0uV7t51t9JQQHM8MquY6JvGNy3MUrumiKSRt+X+xii3VQzrkDtIF30ifiZ9fbRVU09h9bKuGypnqAlWgaFagxmV+QvGGSi6dZXUdmJtMuN+cyQyDF0Ciij9rNpJLlMVWlWt4uAjCaHP81SF0RkU2dL0NHC7Y9MKIfS+W3/SNBeWNdaMCDh+4pFpXu9jRqGiNr/T7ZMWq9VdRcTnnyVua5UKTzUTl6xKmGTVOsszgeJ6sWCWU/0iaTFtNxnWJbPOAHh7+hd2YbKYn2n4t24MGZkEBQy+d+m2bl7H29dzNRjk/Bff0phoxjBrOOSsFYEeAItgIdMHa0ezjP8r7cRtRA/kFpodVIX47zLHd4CLifKKrzX2G4BSIZ0T7fiHNNbwmWK+Za/Hc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3sqFpBpF1TCdwUtIHoqjulFmC8fNk4bJUtOa50z4XNSbNxYMrEVsMyda1bSF?=
 =?us-ascii?Q?gou8sTPUlcJvTYlnsTxmNxZ2f6iB/IKnakV7zsKkjMeH2TRE+c7EL8c/xKN9?=
 =?us-ascii?Q?XJ+yvteydqDvI4a16tpvXzn0mv6KRCINUrtRwmIpuUY+u/vnE38lXSpCm0W7?=
 =?us-ascii?Q?llQsvBp59s6/uhUk5Z5Z66ifsMWmAxvSDwZueMgqs+LyVGAmtEmJ312PBuFa?=
 =?us-ascii?Q?N6MOTXBcD+67BZ0+Befro9LeH4CgZy5IWX8Q+TUvccUisvH1EUJ+3vJYUB3+?=
 =?us-ascii?Q?o+6pFn2vTFFxyyK2mU0LFgHTLPJnWHgN4c3lQbB3NDW3s1wQ6fJDIsFrFdEU?=
 =?us-ascii?Q?lWzhkE6DRYHP1Pu/RgvTYhV05i5gC3t4lTA7cTgKQ2Cfnec0ci9MJ+xPn7LK?=
 =?us-ascii?Q?TkyHxZaOfQ0ACSL08y1YrceS+jUYzWUdp+3oLe19h+K4EC7H0DDtLljzL4ii?=
 =?us-ascii?Q?vzLN8DGMlOUyMq8WCZ9fsyjzJvHZ5CjXu1rTcGQCwQC2RxN4FXDI6QRKuowK?=
 =?us-ascii?Q?1F4YzCzUHS7fhfTbor5pbIHltV5siSAfMMb/cC3UqtQ9L6KJ0pqE73bVTgHv?=
 =?us-ascii?Q?t7UMWHC8zBGncZLTDickc+0hz148B4F3U0ZMvSfP0VpIRhRYnxQMkHFyY7sc?=
 =?us-ascii?Q?LJXwwHo31q7virBPSzwtbVTZR8fe6cpGsdoKRVzyBECJjujVzYSQ42PXGFbN?=
 =?us-ascii?Q?hvDT6sZv5fWFxcMwPzZkcOzj+U+Nkpon+3nwe1mdzGC3HXQLdqcCneo+RDPw?=
 =?us-ascii?Q?cHRFfghGSYjqMXxfoqA0o7StYVbtWJ5ikZURGTEUMsaFwkjJ4sCt/cXNamgz?=
 =?us-ascii?Q?6DVuqqeW6ZrRmwuemDxewh2X8zWbkGPEh+nDIODJublTB2hR1pD+xKYCRaO8?=
 =?us-ascii?Q?3CXpWGy5vkZ5DkvuQcmlfPzE1Abce5wWP7xeMm5uLUqqdYpgqKkLtn7x+h2U?=
 =?us-ascii?Q?CbSZZc+770h/it5yReuP1Y1dNp0brnrS1+88Gtl4DiXHpwDWR0ZlaDaFhe0X?=
 =?us-ascii?Q?BAomM++SJ91ZfwJSIaOMHLSPU8gDR0+bEm6pimV0dk5XX8mXkOzVpw5mOj18?=
 =?us-ascii?Q?YazHBjsl7ySR64Q1nc7jXoxsbsS6vRObt0RoI10vAneopqfygDC6CnsO6k/P?=
 =?us-ascii?Q?Ng6MDkMxGz71kr8TzOpypPDP7DgsXQL+/lgK/0JAokAPprpke04t1wKA0Hhv?=
 =?us-ascii?Q?VyJ/V2uQWr1h/Z4yHrvqS/Rkz4dSoum5dWr/EJiZcv8gERqBxerD5PiY5KOB?=
 =?us-ascii?Q?pyYVN4aUAZZnpPNpLLtFAtmrEUQEwjLjNtJKpPVi0JXrc+GpPmEeRUGM4JDg?=
 =?us-ascii?Q?oOT7xb+7w/Difkj/I2zhH472eRy78N1UGEHWOL8dUUMyLOQ20i9i/FUTMS1J?=
 =?us-ascii?Q?/D2MP/ipX97C42H4RIJ20Urp98jmdW5VOv8W5m2Fc8LRBdMOa0goeW2sSmpj?=
 =?us-ascii?Q?F1nwX0cuOs+LqfgBJim8fngj0Ef5XiuHnJesWDc1SVNCRBEfkzPeGZVAm7JB?=
 =?us-ascii?Q?bNoRIo5qUdDRsm3X3nGYEpXaBRsSxyUpRYfULqeEnYrMTzbVWsuUdE8jbvL5?=
 =?us-ascii?Q?tKTFYV8QLY36xNJq/UevpOyYDX+ecBtuyzMXm71uIFLzk/AZJhzYLriw/IZZ?=
 =?us-ascii?Q?SpfO7y3LkAQbQDmjwXqr4GwTi7sxMwdPQzojSrr1gNaQjFqlMMG3VQn3a2YU?=
 =?us-ascii?Q?y88oFQYVg7DC3RHfvk2Qlu6wZEE+1E0QMfSyZIfytK/vZyGjCJ88W6O2YR/6?=
 =?us-ascii?Q?akJE2TWxqDqfe9io+cVT8NLn9OaNIIWcToBKOUXSols6+uU67d//?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591b2b35-c871-4458-4ae2-08df1d7b9d40
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:14:47.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST2sqHFkCZcFZEFngrbBEiYWy28mitJZUgp/K+Bea/bPQpzWhyJSJrV27Lr55whByj7kCF9wW6vXSg0UqKAokX49wHrByZAtIeATPnVVXeq4MAqmVBPFqahlFzDUAi3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9135

On Mon, Sep 28, 2026 at 03:48:09PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>
> dw_pcie_wait_for_link() polls for up to
>   PCIE_LINK_WAIT_MAX_RETRIES x PCIE_LINK_WAIT_SLEEP_MS (10 x 90 ms)
> per controller.
>
> The controllers are probed one after the other, so, it leads to slow
> boot time.
>
> On an LX2160A board with 4 enabled controllers and no link on any
> of them, ls_pcie_driver_init took almost 4s.
>
> Probing the 4 in parallel allows to have it down to 1s.
>
> The controllers are independent, other DWC based drivers are already
> using async probing such as qcom, imx6, s32g, rcar-gen4 or stm32.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-layerscape.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 14d6ac4fc53f..7f37a0537159 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -419,6 +419,7 @@ static struct platform_driver ls_pcie_driver = {
>  		.of_match_table = ls_pcie_of_match,
>  		.suppress_bind_attrs = true,
>  		.pm = &ls_pcie_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  module_platform_driver(ls_pcie_driver);
>
> ---
> base-commit: 94e8d4e94266bb9737a5963810a3f9365cb2f39d
> change-id: 20260928-for-upstream-pci-layerscape-async-probe-084cae5d0907
>
> Best regards,
> --
> Vincent Jardin <vjardin@free.fr>
>
>
>

