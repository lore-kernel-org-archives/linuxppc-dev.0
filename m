Return-Path: <linuxppc-dev+bounces-29612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E558FCCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 20:04:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5wrn48pSz2yfl;
	Sat, 17 Oct 2026 07:04:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792181081;
	cv=pass; b=JkoXHsbE+91uJUNDl5BVb8BO6kElS5f19VbltVI5xSjYOsdGJ7TvHPKPITENwhRt+Gou/uyG82phaQ0TFSzXsRZxgP8DnY7iNYiMC2xYRdoHSE1GuBwYHQI9xKyKA5BJ2xZDZbCHXHoGVfxWRMZ7VqtNvWZ1+oJxARDZgvP4CY1fUJpnEsn335dxJp2kZBIDLLHqCM+cqG8zqwKwQWQ7ij5qTieTOHpwPmaWKXV16qncXy5Q1s0UkI5r5AoTcKBzA+rBY/h70Bu2deJIysaY5wI74lOP8LUj36CPGx8rDlo4Ue1C8qz2oiksluCt7RdZrhKlZgeSEtxxJKH5Wm+Vug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792181081; c=relaxed/relaxed;
	bh=hWwisaTYUIwZ3OS/8NuzHKqZ+RuwFfRPzT1eJ0ZVf8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D1eBasI7ZO3eB8L1LEfKz9h6aDj/nS7cG5PUCIsdLRtgGvnH45xuKAXf7EjM07itWHMmFA22XgOxQLlGgWINIEYr7M+ErAbD2JBMZV4nZFES0cymfnPQcW+NiFHBafsfuLTP7cp/24N7MUePe6dd7P9rYmumzrG06IqwSw0zmWF2HVcDxEzihcOKvvLhw+q+n2qf5rFfWxcv8OsZBMuKxsof9rFGCRJXuhO/xgOoZOljsfxpQyG6oMK0pCjmlIeHtFfy0BQZiZRIy56qOy1mTmozx+dAFJqBnMd5famAMoUg5HfN0Q6KcTc7zQW0TgPQOz4mcaYX8AR8kY6GlyFODA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DO7VVq6f; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DO7VVq6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5wrm4mqDz2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 07:04:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBuryLrL8w5Ani3y2tToHCizuVdW7M9ug8Pgme7QacZv770ZoQgTZ8PnSorG7hImwxd8AW8TzorlgyUIl0IYc4YenKzvwpRFBimyubp+7VCK5Ukzfj5WKgW/fAa+48hLTB0uB6qSqb7fQrqP3ehK9sSJhYcmWhURolj8H4pl3RbGtmqlNcCTI62O8w/Eih9edTEn8W+P4sxMGXWaz3ssEkeIbvK2J/Uo+HNpeh1LH7iLYXHBi0wikv6P7h0hKXZ9GOm/o516gLUfNRVg0YPYFUMphGcpRt0a7hKc0UDDpa3Fpl0yEtGCV6mlP01RAyZPz+o6oBJb1KMVoHS2IdYw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWwisaTYUIwZ3OS/8NuzHKqZ+RuwFfRPzT1eJ0ZVf8U=;
 b=Vpjthlkan4EZVMlyNYz5afmkwN8WCkYRwJ5lxvZlfT3+s5ZENox0hUgnFnV4+se4ZIIocNOExra4dW5IiepxoSMUIZwVHiqdCYiMFVIUeLRcwZE8NQoPSmmfzPN5pPB/rBYO4OpZA/dLbUCDXhXSXI80XOuEmQ7mDZ3xAK7fCifKrEIYGg0VpoZnUA7bAJ4CUY6BUOr9BW71yRRl9y7iaKS2k1s3JJTeP7pOvOXY1HzfgmSqxa9k1JHy99F1DwCaMSDawOeGfYVq/URBCO8vREOrXA+e4Cf4v8uSpLJ+QTwpoS9jdSXnlw3KQvI8S7/rQ40KfVtoDbQSU5CmPVrw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWwisaTYUIwZ3OS/8NuzHKqZ+RuwFfRPzT1eJ0ZVf8U=;
 b=DO7VVq6fLGmy3LUT7SHty/Lmf1re8cXXz1NQVsTn2DJb2jf1J+Xudljd0CASkOslh8dTblEJJ++9fIM8p9qjRfbzn6hqj7hi70akgIouZtXol0zMNqfU7Y2ZYlN8T27gMVqZuTmGFGPHQKoJTG1mFnXhDB343o2WqQxmpHREP/dJ+eyIIOzbGYWZqerA9mHazIXIEy5DOqrlHzWQKihPabmaYdCUpC4amMPZfgn4hAeN57X6fotEenuRv9CUZ2J6Nh1hptuThgHPm7N4OiTbOd5vVZojIt4CcGjhYYqU5k3lZLdltwhuFV/VPpKKowUsx3MYQkXNkJWeT6xt5501fA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8796.eurprd04.prod.outlook.com (2603:10a6:20b:40b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 20:04:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 20:04:15 +0000
Date: Fri, 16 Oct 2026 15:04:05 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Message-ID: <atKDNdxl0w65s8yQ@SMW015318>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016193344.115518-2-marex@nabladev.com>
X-ClientProxiedBy: PH7P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: c24913f2-b7a4-48a9-f101-08df2bc0a78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|19092799006|366016|56012099006|11063799006|4143699003|10067099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	acwNeZL9MJWg1Vc9XzjdBo69Lp9g08sAt+g0KQacxzvLfHyfVELGxBPqudxBwPPkjtSsJawRD4C+mp95BWT0Yly+1p2gmYett3wEIeEd+rAGHAkeg41UHBBIicC5YMmgqLy2zDkOAftaXSR/vx7UJHzW/lc+C/RNMPVnqSiNt0QWWBglEs4q5VpWlJXhMidNtFZqvcpKHelf6LW/eS2qK6Hn6o7gYWDDNqcr4DMnC5FOD8lUnm8jPuZYeNJ/1XfDL6Z52IcZd/AZDPfjWGqPYOB2k0WGTMRZ9axnQjHUcXX3T7L0mpmIPvagDG/5aF5VJ5ZdSfeBHwf5dCDJFOLt+IRIWa7QJkIFPnats8U7ttAIh9tUijJDm/IvVeFJhYyNImAiAGHzDWxw8PkO7U9U71iYIZ8JaXZifq4PSKcMpmqtw9p+t34BA70O+sMrlxaOOD24md4Bpm8u+AfrJohcxjmlC29HZt2svnECB3HEhXQvo7QUUltyGvDG8IL/j05rTULWkCviEDbSI5PGap5LOyEC99s7LHPvOmYXBnChKknG6uR51WmTCK9j2Z+tJE9pHf9XOI9ZWqvlOrYkQ94ikIGIzoJLOCkr+3Yvo1Il1ucblliKekh9Ipq2E6MJw9KYNXyqz2uCC5Sv+ulbMnQ57BHI/iYUJPtLyGc1h/jhGvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(19092799006)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(261009223027099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fMiSyx5k7aZQfZRwYkZ1M5cwLXRzcUm5n5nIwN36X2zTWNNfMQqA5Ixi6GxQ?=
 =?us-ascii?Q?7fB20BkRs5JGMb90oMqY+7jcUukIU2MKpq09cXkSi4i0MB5fPCv3nc/px6rX?=
 =?us-ascii?Q?uOOi4rxC8FRf6Y5quJSR2NiBCuSDs526Ti6vV7Qi5t7aSqnbrkeX9HaEK5Kp?=
 =?us-ascii?Q?UVvtsT3VkRh4ZRepuLVPUQfH3TtAqKWQz2OUjp5Gnt7E0/lu2SdsygiPkAxp?=
 =?us-ascii?Q?4Ujl57Exor5SqRYgm3ShFi/A0tvHMVB4M+im8vga8P94/wdFBihHxUCdVVxP?=
 =?us-ascii?Q?C/R+tB6J0GuJgcCGo+wzEwoaJ1Mw1pb3ClH7TNrmLULT6b38kJaD4y74B8PC?=
 =?us-ascii?Q?CYog9tFxzGW+Xp3+nLcDJW1e9qrZ6wkHXAh4NylVbVZJoI5eKA+q25Jkz73y?=
 =?us-ascii?Q?oSXjYFhOduA1/Yw0AOhE5YANUEE/v0644deXWffJke6RalBoP8ePgu9DUEbb?=
 =?us-ascii?Q?9mmyAMvzIYO1N1en+Ovvl32YFhdp2HT0ens5jqyoRxAXyXX///Q65NuP2Zhb?=
 =?us-ascii?Q?v+34/JKxQIjUByP8qRd4VLYxctCzOlZtAEX8GSOFoRHwOATEN9bypUT4K2bn?=
 =?us-ascii?Q?lLH2wk9aeVQx9BTZLgMAVJVoS2ySAf4b3WfwoJgFPPQuurA418bS9av8IFWk?=
 =?us-ascii?Q?gtWeVSgDf77gHPp54Wo28y4XpXJp6/m2v6x2W5bFfexrr2wolX+oXA1yXRwo?=
 =?us-ascii?Q?SFIc5RKbYVHm2cy7tJb+NzUY6ogJhAuGIRYG6wDRNtuGNt1oxR2m9S54FBab?=
 =?us-ascii?Q?iCTq8a54XLk7UHUIn8WYxICedoSv1/7ghItGWH0Mt0O8CjeF+fMrpgzFsh7e?=
 =?us-ascii?Q?3YXaYvWdUpw+t7P+IYsvydrrU9fU0cUO0/KnFYDuiK/Eezzw44eSFcoZFydK?=
 =?us-ascii?Q?catjiTHX2rrlilddk3rE29UnzSefw0Fid/rXV3KhhN1b5DQ1aFjKyIXgPfXL?=
 =?us-ascii?Q?UvRJV9QMKBi0qTjJ4y4N8IeM4lWWnEgBp1R2clxyDODtwIGz3caL7Hg5bnLJ?=
 =?us-ascii?Q?Ybj07uVHOduEmExPpodCgQOKiB+mjFsOnZ5TOgJzVLsPzQpG6xKCCdDhagvn?=
 =?us-ascii?Q?29gmLAEiiuwWtdUYbay84ckPJeMXhuX+/tpVubEjgfIb3ghtmC8KRsSuR7Ic?=
 =?us-ascii?Q?YU43JvcJjYl6wKkcM8smlKXP1aSIcQ4sB99j96dCRI1+nIxWQzSYagQKlTyP?=
 =?us-ascii?Q?kVRy3RC126zL3YwtJ7OTWUXw1aMGEl6jugsEaAFRxkAB+c6hNMYIiX38hwEy?=
 =?us-ascii?Q?4NPe7lJziqZ0OQP7b1odOrTRMD3OjqyfVCoShllbwnzmQ5xfe2F99KG8usvA?=
 =?us-ascii?Q?tqEj+gTNWwwrrE6X5H20hR+QfYyMZZBkkS4F2tzwmnwqEagzhg9GgfzERyGG?=
 =?us-ascii?Q?w9k3gTAfaNGzDDZV2J5HYDJJqnhvn6cvlSWF0arNeeAXelUaoFqtWlZItDWQ?=
 =?us-ascii?Q?JWfpF05Ci5bkaESfkQ3gIxkWPpIE2zFBjmlGE9M5sxz+OslPIckKioOIFFUH?=
 =?us-ascii?Q?bBM2oQRoS82s69CdhBGof8aFvJLYCT99j7MamotYpj18a+BZZDdDX0ETO2Y5?=
 =?us-ascii?Q?O/S7GvihGxp2RKvkpnIEoiQS9f0LTqI0GLxeksZFKw4EdcKrKmPILwhNnfx+?=
 =?us-ascii?Q?FbiGL0laZbK9BIZnXqDMX1DcFvZxiVnj/UouZPNSaO+v4nzLBqMVX3S7roG+?=
 =?us-ascii?Q?TvV7iyCCPof2wfWhrolulj9O/O2Md6en27qTOf1uzu9n3SnmmgSVujpb1j6z?=
 =?us-ascii?Q?R3WVVO8EoCZ376B2ATLZmYho7d4pNfublK+E/WzIcoWzYR8vLRwU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24913f2-b7a4-48a9-f101-08df2bc0a78f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 20:04:15.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4E4rb/9zlWPr/VBQ1LpRXsWzAbO4UTeJk3XKl/bVeDSEPkL9qY8e2TjQEZqvmEKb+aAiA04lNHzXKCzJ6Zxp8Nyhxq8qkPJYn8AGHqs0KaZDuNZMbk8Ulb7wRTb+TnB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8796

On Fri, Oct 16, 2026 at 09:32:01PM +0200, Marek Vasut wrote:
> The current eMDIO MDC rate is hard-coded in the drivers which use the
> eMDIO MDC, this is not flexible for various deployments of SoCs which
> use the eMDIO interface, for example i.MX95 B0 MDC clock is currently
> set to 644 kHz.
>
> Introduce enetc_mdio_priv .mdc_div field which contains the divider
> used for MDC clock and pass it around, including into functions which
> configure the MDC clock. This way, drivers which use the eMDIO can set
> the divider as needed. Introduce enetc_mdio_update_mdc_div() function
> which calculates the divider from upstream clock and clock-frequency
> DT property, both of which are optional to retain compatibility with
> older DTs. This is modeled according to xgmac_mdio_set_mdc_freq().
>
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: UNGLinuxDriver@microchip.com
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: netdev@vger.kernel.org
> ---
> NOTE: I could only test i.MX95 , I could not test LS or Felix
> ---
>  drivers/net/dsa/ocelot/felix_vsc9959.c        |  5 +++
>  .../net/ethernet/freescale/enetc/enetc_mdio.c | 39 ++++++++++++++++---
>  .../ethernet/freescale/enetc/enetc_pci_mdio.c |  5 +++
>  .../freescale/enetc/enetc_pf_common.c         | 10 +++++
>  include/linux/fsl/enetc_mdio.h                |  6 +++
>  5 files changed, 59 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
> index 8387dd208adb9..dbeec1b229325 100644
> --- a/drivers/net/dsa/ocelot/felix_vsc9959.c
> +++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
> @@ -1008,8 +1008,13 @@ static int vsc9959_mdio_bus_alloc(struct ocelot *ocelot)
>  	 * starting with the proper offset.
>  	 */
>  	mdio_priv->mdio_base = 0;
> +	mdio_priv->mdc_div = ENETC_MDIO_DEFAULT_DIVIDER;
>  	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
>
> +	rc = enetc_mdio_update_mdc_div(bus);
> +	if (rc)
> +		return rc;
> +
>  	/* Needed in order to initialize the bus mutex lock */
>  	rc = mdiobus_register(bus);
>  	if (rc < 0) {
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> index 998aaa394e9c4..93d61c2f1464f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>  /* Copyright 2019 NXP */
>
> +#include <linux/clk.h>
>  #include <linux/fsl/enetc_mdio.h>
>  #include <linux/mdio.h>
>  #include <linux/of_mdio.h>
> @@ -22,9 +23,9 @@
>   /* external MDIO only - driven on neg MDC edge */
>  #define MDIO_CFG_NEG		BIT(23)
>
> -#define ENETC_EMDIO_CFG \
> +#define ENETC_EMDIO_CFG(mdc_div) \
>  	(MDIO_CFG_HOLD(2) | \
> -	 MDIO_CFG_CLKDIV(258) | \
> +	 MDIO_CFG_CLKDIV(mdc_div) | \
>  	 MDIO_CFG_NEG)
>
>  #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
> @@ -63,7 +64,7 @@ int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id, int regnum,
>  	u16 dev_addr;
>  	int ret;
>
> -	mdio_cfg = ENETC_EMDIO_CFG;
> +	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
>  	dev_addr = regnum & 0x1f;
>  	mdio_cfg &= ~MDIO_CFG_ENC45;
>
> @@ -95,7 +96,7 @@ int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id, int dev_addr,
>  	u32 mdio_ctl, mdio_cfg;
>  	int ret;
>
> -	mdio_cfg = ENETC_EMDIO_CFG;
> +	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
>  	mdio_cfg |= MDIO_CFG_ENC45;
>
>  	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
> @@ -133,7 +134,7 @@ int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
>  	u16 dev_addr, value;
>  	int ret;
>
> -	mdio_cfg = ENETC_EMDIO_CFG;
> +	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
>  	dev_addr = regnum & 0x1f;
>  	mdio_cfg &= ~MDIO_CFG_ENC45;
>
> @@ -176,7 +177,7 @@ int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id, int dev_addr,
>  	u16 value;
>  	int ret;
>
> -	mdio_cfg = ENETC_EMDIO_CFG;
> +	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
>  	mdio_cfg |= MDIO_CFG_ENC45;
>
>  	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
> @@ -231,6 +232,32 @@ struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
>  }
>  EXPORT_SYMBOL_GPL(enetc_hw_alloc);
>
> +int enetc_mdio_update_mdc_div(struct mii_bus *bus)
> +{
> +	struct enetc_mdio_priv *mdio_priv = bus->priv;
> +	struct device *dev = bus->parent;
> +	struct clk *enet_clk;
> +	u32 div, mdc_freq;
> +
> +	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
> +		return 0;
> +
> +	enet_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(enet_clk))
> +		return dev_err_probe(dev, PTR_ERR(enet_clk),
> +				     "Input clock unknown, not changing MDC frequency\n");

binding said clock is optional. If return failure here, it will block
existing dts, which have not clock property.

should be devm_clk_get_optional()?

Frank

