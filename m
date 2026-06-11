Return-Path: <linuxppc-dev+bounces-22436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2B0CD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 02:12:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbR433clZz2xll;
	Thu, 11 Jun 2026 12:12:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781143939;
	cv=pass; b=BnZX0bMvdkdcFTpfnbPBXDGBRZ1W9R8QoNCEyf3gEcZSOazuk0FuG+g5E2fvMhBAvEcJjxUiKdxmaNMMA9h1ZSXqMkAyblR8/NcUD1CaukmyyEuWmiKDRzlF576sLiIzQaSokQZKc50g/KZkUDLQHBvx0nVrQLmnxst4DhG0arVMRhKUWKruAHABfKRIfhqrQcnvYpTe5q6+JUAWSg+kjbwjRRVuHJSQx1pkFT7/zl/F8XzB9+01hfZ6/CXnpEfBqCnu9eYe/k5FFFgEerHlRHyj+uvTHWjJd3CgdOjzYTVPObqzJoyyGh625D6RVtjwywhlBumsFShEo+3I5yL9vg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781143939; c=relaxed/relaxed;
	bh=t59YXBABqSKBTMbqxRZxz5wbLxg/l87Z+6hLvH9B5NA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=afWDlkqIBqWX36mez8eU0gpKzldppfEfa6rk6of3YwMFfKYlNKjq069gQnEgG1TW8ZzfI417PAC3xARipv93lQT+smxdp60Jx2bHHHLeDp8tb8TnIWcDOIGj92Q+z7uBQvipxv8gCfg5dkjsjWaWP14JLD4Zju/9h5QrLUGaUxmmDqo3aHStHGItppr1bBuckT1xud7ZekIUV9CSsqq+52Fn+3dhWXUxkj6L7S44WIlew7dnCsipBGZihAIymB71vbzeKW+0EAWu4k8XQ0Wo8LWvXErBnYnSSdhnUpQ2Q6ak1gP27dBgAV01v7DNW75e3mL1QwYE4j2gckmg40ii6A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rEi6Um/i; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rEi6Um/i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbR415xZ4z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 12:12:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRzqhMdXTlNdg/jf9Y6o7RKsqudxHeCleZU3tKLuMZpyhtmFBdNgX2FvGA/PiSya7nBJF/z50u6uXRMtw9mH4mKeQuS+LvJduh9kK9dvMHudgfI/uuK4g8AqgY2Bc9wfAFgBtZ2zahcLjsxbplNLfxceu5kxVUMhCOCex2Cimb40kb71ZTQWGHl/JNtpsXD3T7rQyQa+sf5oJxmTnEyoAzhhO1KYyBiXqnME8bLZODDjo6f2KlSkNHO3aWCNGWnK0+Tdm4uMOw2DrB7g8KG/gaPrm92njuE7djuQMpMuMSLCA+L7wqHlTj41gqPTngQjXraaHrJJSr2sql8N4gR92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t59YXBABqSKBTMbqxRZxz5wbLxg/l87Z+6hLvH9B5NA=;
 b=LDUlFg2HJEpKbTC+SPIUlKoHQR70Wehs3ronqkVB6/2mz+XIiMGAgD3BvQwW/yKzIo8qvKfghbdNzzfBteA981ywhd2Dq3d+62N4ZRvZvIcjihc/hBGXh9T8DmvJ3ue0yfz/aW8qSPhX+LBKsPtAVdXzxkHhGnVz+Aw84l/Rhs5bu19v5b/EgZ1JY/RZQvjHaeodA0FpvckZbWJCBBd2fCATed6if3NlMiTFYv5mG6VpLQ3QoPFA3X9YNBnGIX3nsxpGEHNwpy8Yg3Qe8Vrqo3hKLY5EkKxROiNEtAIcc264/PsVjLEMzEav/OV+r7ciFu368UoRwtgcEJ1rf9XEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t59YXBABqSKBTMbqxRZxz5wbLxg/l87Z+6hLvH9B5NA=;
 b=rEi6Um/iZQIhqtB0Giq5SRmgv0mZgd4sKBg0+uOILDj1o8MQO7b/8hSLIDjIoXIeWBxZpEMCvupFP0WRmU37SagNaa/w1tGIBh/KyxWtS1Y3DB91PNHjQpaDzwTrIAnFBAtWhcZzIv8nvqnm54gthJ++x77LhJVmPXScNceLuSzEOQXPRRqAQFZaNkQ8Xm16GMiGdZvk4L5Yxjij31tvASwfxbP0ogHU7PvQCAsJLE0nbeLNOMtqy9ZmnRw5yxsik+VcSovlLm/fRGyClvzDW7ZNmTd6dvrKRGxJH+jTC8G014RZey7NwQwuGSDUsM49+CYfmfmrCXBjy+V6akBBsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:11:52 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:11:52 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 0/9] net: dsa: netc: add bridge mode support
Date: Thu, 11 Jun 2026 10:14:49 +0800
Message-Id: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: 59879543-159c-4188-3429-08dec75ecd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|19092799006|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	uLBOj7OiDCCxq3EZbFLDg23aSiq0c6q3Voy5MxqS34BKHXHWWNx5h4FUzzvRiXBmU14tMzD5j/nGKWBpJf8NY9vDk0JPXMwPXMuWss4VFFX9JhpSlOvaH7uv5664VlUScpWPMFR6ZhfqzxHSRn4IVm3dHVA1a/2dFKATbs1nodiY6DlZiB7zKJCv7S1GTb3thEqxwuABq/7QlSWDCPWgBKCur5nsqanJdP5YCapqZzNh18Emn0lHLmMT3RxD6ohmuTIcKDUXXKdx3/75bZzsMIjUZM3PKeZldUlaCpz0Ccz5pOj44oZNNPkfLvN0ouVWeijBF+WUkbyQmwSPBpAiJBHFe91xkvHZ32fI+QaKC0nhU8uXWeqjrYXznyLoGbSGR8RSa1STaFjUUiJEc6JvAlWMUZiObYB6P+cZ2YOukYQpqUguGlxXDBhjEh7u89QH+m2Ppk35aK3Cg0uKendlsad1mad6YwgApntuFhzT873nHsqvqsSLcffvAlDACAAJyzqBRbiwng9ibL2T2n/7dB8yjWP9iOngeS5DjnI1EXCYTAOhXobgZarbfdfXoikswiFj/KVhlNZ1Q124UXcNcPzWBpwKiJAOPQ1o2Wddmg+cj2eFWJhTwj6/+bM1Chtb1U3v6LIFCJpDZNY4rcjDCtAZyaakMe6V+zRJft1UCjoB8f3JFkeGW1L1iGWTnfuFH8PqopBBtL90/urmVPq8OsSEQ+EiGwESnVqNDS66hhPN1qa+54Xjnq00n2xwA1kQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(19092799006)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qg8uStTqe6lxItYQRDBmWoLotNsqd5dSQrsBmx6XQ3bsqytBdNIYxfRxlIWx?=
 =?us-ascii?Q?/cIOAncIKx4YOVBWL8/uHyp1sIv7zw4UNZBhqs54eJ2QZ061p2GHBKTF2PmT?=
 =?us-ascii?Q?9VzIxpAkwy42rS80Rb4jhrshW/zO5Y6S0oB3vy19sqdmjknqV1RZ7yvHEBH1?=
 =?us-ascii?Q?nqTskSNyuWh83YRhOU4SGfz2DoabmiazAy8GTgaeJ4s0bzOb63b7RXol30v3?=
 =?us-ascii?Q?vaQ4CdTR8TLtTtXLjfaV5glK4XW8dubVyQA1TjB2X+PYmzygVgR9Xdpt58MO?=
 =?us-ascii?Q?bGAB3MD29nULkQ3mhnws8w3p996Foj7+PEHG61rK1vJRRM/G6L5A3IO5KZdo?=
 =?us-ascii?Q?GtglDdDcbpHb+SE9jbOA7KgnzFbaI7TF5r7ncDGuIA2JuZ8pjYUemJ3E48K0?=
 =?us-ascii?Q?frOnI2EmLRl0O0eSppaN9mFrBZ6AZM3KJ6BwmBNyEST9DAaz0pE1Ky/fW0uy?=
 =?us-ascii?Q?A8Lg9CCwnF/6E6A/KYamsWqPPk1i0U+IpccphQGzpVcon0Lyu5+mwAeTlPjx?=
 =?us-ascii?Q?quSkzlMJsOzgjbk3mM3lni3thHoIzC707uZdgZ3XnEPOLpktvqqGY+YncvBG?=
 =?us-ascii?Q?VHcsDEMvIDdk3kM64biSeR8ypfSSHPdVm5k8TJrdnGSRqFNqInDBPy6UmqlD?=
 =?us-ascii?Q?qC/C81uTMQ5E7XKw/P9yXt8ChafkNvAgy3cHADLMtGsWpxtMZl3iLn5vh1sX?=
 =?us-ascii?Q?Emg8/wFTImmkX2Wt4JfJLUd51Yb/E3+Td15g8/1FAmv3xBPPIbFdLrCFBjXg?=
 =?us-ascii?Q?2/JFFnOI/ZqvZE0qN6r48k59C78lcOEmW+oEfV1zBbvl6BF5UIcIUq5Xog3t?=
 =?us-ascii?Q?NyxfvuQskQrxOu8L1ng/xIYtyZ+7Qef74s0rAsq4YrLULROww1K4zdn3p726?=
 =?us-ascii?Q?ZQ34kI0wVv3fBQ7OYb6b2D+AfI5D9lz4RrGHbwTujTTTRsPMUORbG48IN/qQ?=
 =?us-ascii?Q?M8Qq5uubhAzY0oQTnpDQBmH7ChreFivf8hmhYUpoGwRSCKLzJII27z13v5AB?=
 =?us-ascii?Q?oEx3wU06xnpoB2PXz8j3wfbDE3S9AuKj1WGaj3ia3km+ZuN21SzoX9rRdhLK?=
 =?us-ascii?Q?vg+cYfWMyqx0j2BmOts8dMW/qOHsg4QZJaCVS1mmNb7kJa0nr9g+Dc++APYH?=
 =?us-ascii?Q?DvfG4tgoYjKdrOXPgXPRPDxcKJUUAjjH8as+VtAThvcG0xu68gQnJjwG47l6?=
 =?us-ascii?Q?HJhd1sg9I9WvHHZ+bBLbGl2l+TF2Uno/39J3aVdYPcB42YOF5zdA99ZAV9ET?=
 =?us-ascii?Q?H5vQA4nIDXw4IllKjzqWtrumT6kHxsgTrnescdIg1iC/qGe++YeVMEf+1po+?=
 =?us-ascii?Q?na9RwnI+WD4t6693pM8EvmOvphVAQBhUIpmXvXygufYMBt4dBrWeH/+eXNEc?=
 =?us-ascii?Q?IIESjQ01FQvpuhOg67zFqtqNT5axzWoNVq7gw/6GuZhQaWGZnHj+RIDQIMlU?=
 =?us-ascii?Q?Htlasbr4z1jhe7cc5Uvn9DIG9WMUVaD+es3F30OgXefgimJOsnUrIFHwBnU4?=
 =?us-ascii?Q?dnxvwgikpwl/bzUa+KvuUJYDjFjM+PuBZgIRnF2DX9Q8hlBWNP141dRvwS02?=
 =?us-ascii?Q?CGYHkqtFPGhAjEbr3qMtwQpxBa0hyKfIfElKuP7ua1bziN1XzZtmiqzWb9Xt?=
 =?us-ascii?Q?nrJtQQywtuIPoKpOlbAMvECtZfEsnI4HI+T8uGWlaarMa386AxYdmhYYqE/5?=
 =?us-ascii?Q?feVj+gV6aasYDdSbsprl6qL+EYrDdRgeMKlIiH3VoAlCBRnFVDvbNqkZFHIU?=
 =?us-ascii?Q?iaDW8XjhiZiPnxZKixm2ot6dCEc66ZGrg/9Mx72qRExEX/36nmea?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59879543-159c-4188-3429-08dec75ecd0b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:11:52.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lf1LOva8qyJywprDfZqdCEc/Ve+jkKwc+8Fs+TLFBN5Eb3oT77xdyI9dueSPdunsNQrprc4OZHYFpaJu5RvzKPAfVK9ul3GZvfF2Dr22ibMyuWC7bj9gSZ1aXv5sVclI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824

From: Wei Fang <wei.fang@nxp.com>

This series adds bridge mode support to the NETC DSA switch driver,
covering both VLAN-aware and VLAN-unaware operation.

The NETC switch manages forwarding through a set of hardware tables
accessed via NTMP: the FDB table (FDBT), VLAN filter table (VFT), egress
treatment table (ETT), and egress count table (ECT). The series extends
the NTMP layer with the operations required for bridging, then builds the
DSA bridge callbacks on top.

Since all switch ports share the VFT, so only one VLAN-aware bridge is
supported.

FDB aging is managed in software. A periodic delayed work sweeps the
table using the hardware activity element mechanism, with a default aging
time of 300 seconds matching the IEEE 802.1Q standard. Per-port entries
are also flushed immediately on bridge leave and link-down events.

---
v5:
1. Use __set_bit()/__clear_bit() instead of set_bit()/clear_bit() in
   ntmp_lookup_free_eid()/ntmp_clear_eid_bitmap()
2. Correct the ect_eid check in netc_delete_vlan_egress_rule()
v4 link: https://lore.kernel.org/imx/20260609032955.2066089-1-wei.fang@oss.nxp.com/
v3 link: https://lore.kernel.org/imx/20260605014808.686024-1-wei.fang@oss.nxp.com/
v2 link: https://lore.kernel.org/imx/20260602072313.3162120-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260527100217.794987-1-wei.fang@oss.nxp.com/
---

Wei Fang (9):
  net: enetc: add interfaces to manage dynamic FDB entries
  net: enetc: add "Update" and "Delete" operations to VLAN filter table
  net: enetc: add interfaces to manage egress treatment table
  net: enetc: add "Update" operation to the egress count table
  net: dsa: netc: initialize the group bitmap of ETT and ECT
  net: enetc: add helpers to set/clear table bitmap
  net: dsa: netc: add VLAN filter table and egress treatment management
  net: dsa: netc: add bridge mode support
  net: dsa: netc: implement dynamic FDB entry ageing

 drivers/net/dsa/netc/netc_main.c              | 965 +++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h            |  33 +
 drivers/net/dsa/netc/netc_switch_hw.h         |   6 +
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 440 +++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  18 +-
 include/linux/fsl/ntmp.h                      |  55 +
 6 files changed, 1495 insertions(+), 22 deletions(-)

-- 
2.34.1


