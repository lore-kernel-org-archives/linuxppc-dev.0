Return-Path: <linuxppc-dev+bounces-23342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29B1C43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:25:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMhz61gGz2ySl;
	Thu, 02 Jul 2026 13:25:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962739;
	cv=pass; b=UBxrB2sZR5wLU5J1wLARO+D1ktqCgBBinR1Ge0ZTJivObgtwLQppi+7PrDVUSxxtPNy7kMIHGI2mqWONRAlTCatEQgqDXH5N2oc7HtoAw4xQJ9OBGmPsExkk5aJ8Z1ZTdNuJhWJ4BqaDbv7gk0dnIZEm/8SLYygf3P51krTW3isHZakjdB+4k1jsIyC2NRmenWu9sZ4jBI8XjHrnGHMmXUCJom90+Ejc3fyG2Mdq2NQXF8cLwYW7ELrzLlHq8qhKtCnjCoEH3KgKDlhFGKivuUSzqSrylSDxINPCPOJEgs8eRlPLvXIMkBEwFnlAzPdpMee9Kc+ilH7xY2GIEd15mA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962739; c=relaxed/relaxed;
	bh=tMUXj3WzI94PwQrLVQLTMGCnlEF8ja4dtmXdFXxmtus=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jHz6r7ZFNipoz9Okelmcsj/B4IlITbxsYranZ8+iqSCKrVXtb6+CZbYNSIW9v9kJuNs2V4PcNRTzmS08svLKD/Gu1q/HiwyZVIXw3Yi8YcwEWIwtPKhsTG3vGUxrKEVdy88gdWpAv58y7/3svmV6WlJmfM33qZNwgbP5FcsZy9MzJuS9jgnZ21rEMKhWJW5IwuRQ67m+xOvQKBKBRjBZvO9DRpq/wADRRSrI/TZLUFd9MSI0pjhSKNxN2i/yC7rI9uGfMQJiZXwXsbs0lU+X5gUzD34QC9md6d+cNjbf/JHnpTxxcg7EmBteGhLeVVFGaPZWOmWnNdfD9nNox4cCZw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iIWq/hl9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iIWq/hl9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMhy3gFNz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:25:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFTnzY3+6Tn93YsEbzwaS+xRL4ar/TGkB3nFAFBxxbMfDnfjsEoT9i9UHx1txaJLZ6K3nOj9VANFV7wOB1Xvv6pvORXtSwrVDibRjSY0dPTx0TOXQt8XF6c9UhRThCc1ZXYluIh36oxP5EW/UWJAXg5OXYbBEj6r4IQ6OgzNoDY0iEv2kZp0bqRABTj0OBvMBx0BvSwgF3UNKLJH/k5CziFcQwUVUFDMkuq5RbVBXNHCx1KDIUimmGhEMkk1UjYr9Q6RVAw8IQzf8fTKlQzRUp5ZLNgsp8slxROC0cqmai/TO5ENcMSTJIUPeK4g5QQflri0hEeXSdtdhbCmjmMH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMUXj3WzI94PwQrLVQLTMGCnlEF8ja4dtmXdFXxmtus=;
 b=imYn/yO0z6yOAWAV2z/0KDjKLsT66IRQ/GvARlpN55pNl8ajv/x/I5tG7tfeBc0aiDmuCM0+oZ1mOhnj6YQqFelI7vtE4qXb1g33buPBRJhgQZtp+5rfajTKCV/epJCrW4JgQbm3HFqJW8rruPwY4o92GYDZ5WpqTS7FyK0akeKaa4fODfRs3AlLsI/TjDd+6wAj1kj4aWz1U2h0v1kFGS6HaoLr4h9fahrpSUcywEbPKYJiAGhBBCER1/CiUoHGF6L5LaB2YDfkxt9gBt/zUqjsSNUKioIO241TBHIajDABubxWI7MA2LqWVKQX9EB+kPao85LMisqdVuP4RCFQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMUXj3WzI94PwQrLVQLTMGCnlEF8ja4dtmXdFXxmtus=;
 b=iIWq/hl9o9qztmCov4ojEjTtBewK7zMs3UWbfrdd7TdcbN+ZhDpqZMrizMXYiBCuDTjPkW/oaeK0cZWopaXYxAbDsqses/6a1w0WXkxj54SmAgjNcIaPslM6fqNXg0Fh7apTO1ZmvzJXsSPcOT0Pl3FvGk1lZAhFPOOc8NFa/HUbpANRxNL1Mm5oP0ZF6XjB6HzeBHGeG++DgBWT8hin3VK/xRjkyUP1PLG6PnxYIMpWvmcum1ynL5BTbv5O1jzJhDcPzNc3uuffAH0I6kvOaHnVv/hi+NofZy3jVZ+Nk5dgHf3O/ozKineSun5KQaYSlG0cWDY3k6ESaqD14YOicA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:25:11 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:25:11 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 00/14] net: enetc: cleanups and improvements
Date: Thu,  2 Jul 2026 10:57:00 +0800
Message-Id: <20260702025714.456233-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef7e238-7820-49a9-b56c-08ded7e98632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	x4nPOvR0fAv1y8OAQ0uW1f5prZwoPUHTLQUMK3KzQmuIgu4WrWesy/KhZiUI3Vh0ifV64uaIYWScY1bcTqD/0lPdvX4tiRjOQSDKQ/WoBqfP8Vc795JKHYaJ1dihKj4hIn4oHTZIvd8ZBNvQTrGe5Yzrkyyv7bx0mcsxzt4UQti+morFWMLoVDPj3EfWqjJsSk20qwFPchHvAZUivsjrk2TdXXdKD7iMW0Ofw6dFUsQkFRA1EsUxgurfEVqCl/le6e9Ote9Y5LyILl1QfY5FgyB+8/ztNYRV6a+H8onjy+QV1atIG3FBZ0NCJaH4EVuNL7S1D8uB9Xgz9j4y+U7hMQvtw7KJNzs2MaSpZnNRcmerwpaT4MOXlwniPB/iaMZiQJRzKeOqjgC8QzY1tDZXVzNuwovvS1VRXalhHZI5k0ax7uw/e2ooMFbmbiz3k1WqOZzr6+ZEvsBexBwpSYUJ5pJq1CHBi1HpsCYU5prB1gILmYqCHj6CeFgvWxsvJTxuuzS4Chqk+vwuA6nLNAgnwXaxdgLzvgfSLHmGJkkQzQg2SnyQM766bGILzEdCcRkWc6JVBctJ1az8O3zngam93x++3LrKD9HMyixBUbVVH9xRX813YjxlTq4vqNLufJrVDLF8mfa5iSoP83op98PloBU8lmNpLl4KVxHwe8ur9YB7uhB4vQEkV1QUOBp6qH0VLDZM6CYefWWCGjBgxSNrSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5rvT44AzjEl2N/8/AKMZNt3lO6ujtgkbfQGxzadULRowOiw0WI6aKO2lFeC?=
 =?us-ascii?Q?gICv2dzQdEKPEWY9e0LJIk0O8K9S2t/BdGOJNTUppSrpN+8qQhJnEIj5u2JW?=
 =?us-ascii?Q?UGNIatjdlhZHCOTZ/8+RuvabofnqKmnGi5wuYiGYECfTEcwPgD/8++LwvGK2?=
 =?us-ascii?Q?z3ggAHEpVoOHxWTtuHFiZrw7zlPxKxjq9Z3GPjwllCG7rhVSV9LVjHYiQaaE?=
 =?us-ascii?Q?PF+VbE+rRJtq9Utu9s5jlkZVMCrbB0PhshPYEuCNDWtfqFYtirdua88stzxn?=
 =?us-ascii?Q?PkIScwZMfm2dW2f3m75euGbtdBqOuBwqhLP1nSMMeT4gND62XC5yUYvij2Qa?=
 =?us-ascii?Q?ISjPDJPJhAru62a6OKlYQh5JxJu5XiiPZjHWlR3Tnyxa09SGu+B42OlX5iIa?=
 =?us-ascii?Q?nShryxXnYQjDdVN3SJZranTeld7NlLlrL6gy6+jm+NNiKkg9pbKqSVAt80xB?=
 =?us-ascii?Q?v1V2LIOaRpsElX3t2rZpZBNjd6WmznT6TFpedZ4Ronzn9xIQVjVV4hPyddk6?=
 =?us-ascii?Q?3VCt2wNoC21yho7OakhuP8r+kIAKhzLpGss1GVnjqMFBQURJm8Bwhhp9Bu7N?=
 =?us-ascii?Q?4U1tYnxT9ZL0sr1LobNtVVusyBCm1Ug8tdYFwAM+tD3mVQr/vLI5GiFpS/yV?=
 =?us-ascii?Q?5Lbbt1cVzpJ2KrDEsZKYQHHiT0vRouKrNaIXyXFYcdnDcbO/ygiY831xh8JB?=
 =?us-ascii?Q?4NjI6yKbzkFVANllR7vq1XF0Nis63ox2YdmMykJC3ef+/nxkinhgkJiZEY6h?=
 =?us-ascii?Q?yrtdz40H9M8AmO+4mPwEZnOjhOto/33J613bACBrcdyIoE3VzM56n2WfTNoe?=
 =?us-ascii?Q?zcZEVyvVoSwe332Pfl+YBBcv/DrP0qNCRVmV02/TapL/4TaF0cqjDc6GqzgL?=
 =?us-ascii?Q?NwB6ahArRTsMPXoVFinGvmyTE0mWLaIOfJbDY9A+RQzcJIWNFutJfHj7qrJa?=
 =?us-ascii?Q?tKHNyup34zbjpnKpMMWJAOak1m0hofG4Hdzy2llgzUvNi1TRAE4fsKt/imeK?=
 =?us-ascii?Q?piIh/y2fF/S+AH2PTuU4nsdwzMlt6TbxnmA0rF/OVLhtLiY9qSnS16YNAZ4d?=
 =?us-ascii?Q?cRfVF5GyQkjSgQXsQAfOQmyv0phAsMUtA21dcZWOuMl6EN6Nk2MJryTAwkOA?=
 =?us-ascii?Q?zXth2glRCxlcIERMWvBG7KAimc2IymMxxwZLjDW85rY7XvGTZc+l/BRYnMvy?=
 =?us-ascii?Q?scWWhkjyH+afpXX7tPujVhfrNHjIAhgKTihgw7aCWpJVHefbArqHC1/+2E0x?=
 =?us-ascii?Q?qfrwNXmFQixQh1gD+z8uT45vzCznF3ClWz1fhx8WB2r8+0D90TAg1C38O/bZ?=
 =?us-ascii?Q?UMgYxx1Aq8zUy7YII9knM2fxaWVq69phMoxHU3i8vMyBOAaHbyTfGF7AcMor?=
 =?us-ascii?Q?TDKIOReuitz5cH7vrpRXCVtWv2IjcchcZ3nUhzE5tmt5xyrRAnFdOQEek/bv?=
 =?us-ascii?Q?Ybv7/XJ1SW/SzToTmjF1SDoyFzlsRmLG3NUqlflM8grHzxcQPsimeedfSWYx?=
 =?us-ascii?Q?RANGIRRw11dbGCSrjsAVRkVubUMEZSra8Dez5aj0C6B7ROUJplvoYscD2Xzv?=
 =?us-ascii?Q?5Pvn2et8tD6dGdTujK08AwF7+e4PVOC6/gjqP0Eevp7Zwkb29J+UTv7kI3wK?=
 =?us-ascii?Q?iJbyTnLft40Y/QPZn3JkYyviJSTFrv4JdH8Bb91BUKmYOJPB9EQLAnUk29IP?=
 =?us-ascii?Q?gNvDSXpLvEqtfeRQt9wW55ZiMaS85nJgXsn3iS3lDpcGBYUdYhIYmayaqCQa?=
 =?us-ascii?Q?R6lad7cKLUHyzGd8d7V58tRvc5ldxEkH0+/tQUPiLUmtt/oQMbsd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef7e238-7820-49a9-b56c-08ded7e98632
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:25:11.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITyOmS4GQhp5JHceply8IO5RpOjjdUhlPDCHvsCUfiF7CDaT20aD5ItD+BGMvbRohTpQS8yITow5jwMxawmj0n1RTnr5a0CgylLt5YhJu4SJo+hQcg3V18iJJb7Cet1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

The first group of patches (1, 2, 5-7) eliminates code duplication
between the ENETC v1 and v4 drivers. Since both hardware generations
share identical register layouts for MAC promiscuous mode, MAC hash
filters, and VLAN promiscuous mode - differing only in register address
offsets - common helper functions are extracted into enetc_pf_common.c
and shared by both drivers.

Patch 3 converts ndo_set_rx_mode() to ndo_set_rx_mode_async(), removing
the dedicated workqueue that was previously needed to defer MAC address
list updates to a sleepable context.

Patch 4 replaces counter-based MAFT entry tracking with a bitmap, which
keeps hardware and software state in sync and avoids partial failures
during entry allocation.

Patches 8 and 9 fix phylink-related issues: removing invalid code from
enetc4_pl_mac_link_up() and properly differentiating phylink capabilities
between pseudo-MAC and standalone MAC.

The remaining patches (10-14) are minor cleanups: removing a redundant
VLAN promiscuous mode initialization in probe, using the PCI device name
for the debugfs directory, simplifying port speed configuration, removing
a redundant num_vsi field, using alloc_etherdev_mqs() for the VF driver,
and using kzalloc_flex() for a flexible array allocation.

---
v2:
1. Modify the error log when enetc4_init_ntmp_user() fails
2. Only set PHY_INTERFACE_MODE_10GBASER and PHY_INTERFACE_MODE_XGMII for
   ENETC v4, including MAC_5000FD and MAC_10000FD speeds
3. Improve the commit message of patch 13
v1 link: https://lore.kernel.org/imx/20260630072036.382761-1-wei.fang@oss.nxp.com/
---

Claudiu Manoil (1):
  net: enetc: differentiate phylink capabilities for pseudo-MAC and
    standalone MAC

Wei Fang (13):
  net: enetc: extract common helpers for MAC promiscuous mode setting
  net: enetc: extract common helpers for MAC hash filter configuration
  net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
  net: enetc: improve MAFT entry management with bitmap tracking
  net: enetc: use PCI device name for debugfs directory
  net: enetc: simplify enetc4_set_port_speed()
  net: enetc: remove invalid code from enetc4_pl_mac_link_up()
  net: enetc: remove enetc4_set_default_si_vlan_promisc()
  net: enetc: refactor SI VLAN promiscuous mode configuration
  net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
  net: enetc: remove redundant num_vsi field from enetc_port_caps
  net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
  net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation

 drivers/net/ethernet/freescale/enetc/enetc.h  |   4 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  42 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   6 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 412 +++++++-----------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  12 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  93 +---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   5 -
 .../freescale/enetc/enetc_pf_common.c         | 153 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   5 +
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   4 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   3 +-
 include/linux/fsl/ntmp.h                      |   2 +
 13 files changed, 353 insertions(+), 390 deletions(-)

-- 
2.34.1


