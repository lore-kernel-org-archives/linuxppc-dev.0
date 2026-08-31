Return-Path: <linuxppc-dev+bounces-26254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F127DC61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMNx3618z2y2f;
	Mon, 31 Aug 2026 18:20:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164401;
	cv=pass; b=J1BqJzAz0hbH293jWWPKWNo2C8RfdwNAPZeeWTcW5mTnKf2PaZg0UKq7W1yZpm+KZ/5LBPbIx7Mg10Kz7eVghmwmFYJv2lOsU2emmxVOf5GlRpyyHXR3WL5g8N6CgGlVVj2yc1IRsCT9awz9LIBZu8fgfKUNTqgOo9be8AuB5NvAkgJVtBiOVM2yTqenBw/GCo7aXxtM+jqlodmkZ+urdxiwkWWveirC6AlKmLdpNxJeYuMUx7pb8GDsQ3PYLxINWZ4grv2mlJh/Da5sJLlbPdOrRsS1RnH3J4mmm0cqF1er5fV0WNhHPfXpXVXN0lS4CkwHojAp/vdXdDcq/6dxnw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164401; c=relaxed/relaxed;
	bh=zvCd1HeStVVuRONl3XXPFG70tv6/PVaRgDQCkr0Fp6s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NRM8QrZvEwBijA88bdzvcVIhYJ17sJq8xIJP54LLAWHq3X8y/8t4IidKlNBk4XDBU36sj/k5/0VKK2C30ydelVpB8OZLF9hGc7b+1QWYqwnL6ilVCIIvuz9c/D/mIIze6mYysGf/Yha6Bxjltp0LXc8cuOBvEGnZkr31Pe3LJs/BBNqB9APfh2F/xlYxAzEnTigzIRxWuw+nfXPSOPktZBvGRx3Yoox2cAuQ3K1i9raPtZNBmU6kDZAEfNV/oeTy+f7tcqElrRyWl6mah5dIDFMD9PC3262JLsA5AnPomIvdeF2aNKcCQ6zvcoUn3wcVKkUtX4UR4uMBgNJyhkTzNQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PDyRyBoD; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PDyRyBoD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMNw1SSwz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:19:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2oRqvh/2rPhWICV7vAggTnOSnqATk1vN3hSt4Pt+va6p1YFN0+bKciA3T6mR/ygg7yj8LidEM2TJiAYGCHTBfy5nIHQzH6sq20yQYYa0VBfcvAbSRfKP/WNA0PaUvZ6Y9riUKMhFal74ML/QRecPvC4HWbdVaCC5ThSdAYro+nHURxSaqZNVpWjdPBXTXftLYIdyfgw8n5jseXSlXKQPs8zOU3x9rQ0udEAZARfJlo5NKmCFHaFAPT7bWnap/JNf9xo7wsvYQn+nKP6PS/bBGX6PQ58DScUwAdMxBR6yRadCQBgEQvYPNnD7M2uv+RdZU4E4k8lEExhlwbIbQSdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvCd1HeStVVuRONl3XXPFG70tv6/PVaRgDQCkr0Fp6s=;
 b=jCdaMgXKFrqrpvYuDi+wOoT5cWbPRiiTJk1eLbPVFDW2ez7D0/9xUfQMHulwpyakqw8CXsK086MuQGhw0KXDsDbIiMFsJGduextC+5mdKoDx0E8uDghV9ku8QS49NvN/wfuLFedUWrudz8WcoOtVX3DVGhI7Shv7b7Sp6GdJoqlnGgravYzY79keSVOoUE0NRf6lt1cd94ZADJmPgWP8/gGLn/B01uA9NWLe1yDGDweI+MWjroehzAVJl3a83r99REhfCvoK8LkvL3Qb/QqScS50uWSKDcVPM/0yMDeyKtb0jEpFfhEP1F3bjXSsNPvnYKvK3y72y9OxQV1dsO1xCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvCd1HeStVVuRONl3XXPFG70tv6/PVaRgDQCkr0Fp6s=;
 b=PDyRyBoDlSrJNnEaDLWYiqxcEXGstGajm0WRKjEXDCb2FumP5Rihc+KwL1gpzy0m1xrLF9jVnWYKSeQX/KWiq/xUa4CGIkRgQUOEXSzdSVuLIRPOFjOxN967NngEmhvaSW69hZEpvxNCUFXaDwy84rR4m/LmVbj3Sghfxgh0zs1Bl+NcnshpPggNn/z0bofElRFSUatjhCggrWxXX/JGbtlCuvSvvcHao3gjCt85ZkkBTd8GOhRoJzzz3cnImNCpmWNJscj/zayfvqeJhbpXe+VYn7mR0WGiUzoblgz1zTHTpJcQPK+FkSzDIi4dU9FTgq6JYXyTmi7CPs1pcFQOYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB8440.eurprd04.prod.outlook.com (2603:10a6:20b:3df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:19:30 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:19:29 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for NETC switch
Date: Mon, 31 Aug 2026 16:23:27 +0800
Message-Id: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f11b4c-3ba9-4d8c-b413-08df07389401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|19092799006|366016|23010399003|376014|18002099003|11063799006|6133799003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	jr5ZHd1GM5TMbqe28jLC2TO5N/SuJWljaWTHugAPVUMOyNhl04Bq32woMISKre0nnnup/1l+cv3r1xPkLGPmvzwGIi9wTdEQQtxRkdk2gTswunDk7zzIiYnFYpbv1rpYaNLNGg/lrsZHIj0U+/pj1ZCUVz/Avvc3FjYmy32EOEwizFIG4hYEUHQPRJNJwD8BvAl3ugyTxgZ7aV8kkFbvSUCqBQGbbosmdGMjATgZYes/7u3nCTu1ImZXb0IOiQOzC7nTpNQ8yfQE0H2eFl+25HUbEnYfto+CCNB59P39TzgROTHmqqALmspcPkEVhk6dHabb0JJG5SzhRvC6OxSbSt/26Wj4ARHKwF3a0guDRJ2U/BUkGtWu6BWRVOzUmXrAXBOdIUW6eg53TO9bfKIVMsnjdi2EW5Y8j7eFImLpRKqyqrPc/Pyt26Nqk/ZZxLLS+/cgjiFNmUKJ89GNavQIiGLGDoZgXD8MYcW/5nf0OvBwBEhOBPbBDLy0NuuFl+1vQbcb+NEkKTvILbiuvLaDCCxlLOm/qDXhYKSzLtI/Mm4ohU+GNmkk4MlJ9TTrb4d+6dbGM1WNraqgA78OO4Ff9q2slurspl50H977WP4H8ZpyfrbSnxWQnj4KLXzVd8eZl+4po8NWE6NDccBfunCOOs6o4JgXU8AVerRlsMvffPedWPJZ7EuBFsaiTk+v/HyHwAFcmYczsJJ4D45F1X19aA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(19092799006)(366016)(23010399003)(376014)(18002099003)(11063799006)(6133799003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpYKZnFUP+Akn924VvofOXd2ZTdH8lIPvkF4U/Dj2knmB918h5HQgSE1gwck?=
 =?us-ascii?Q?76bxjUmKarbJopjJyytEQJdhODBKctIPXbNB0oex5s9TDYk4merGA304RC1Q?=
 =?us-ascii?Q?Jd9LX4Htpqqr2ZPEsXdIp7B1RnrkfpGh6/qvKvWDgink5vqGT9qrCw8nv68z?=
 =?us-ascii?Q?V5DcDlanDvnGhkgjEeGxZThkVpJzFF/jjvMSFjLnC8+4F6EEu8lKZNsv3nAj?=
 =?us-ascii?Q?AAWfPrn4UNPgzbQ8pgcKxSsw2mhTcx871NhcJmTXuTvSAoWWSXiBrHQa2hx+?=
 =?us-ascii?Q?Mde/aiR1CUDjfNbEGDNpIkO5P9K9hoaVxXhqqYyHC6VFZk6ROoVYLbNT0Nm8?=
 =?us-ascii?Q?y2gkhYoH5RrB0dboShNE2kVkyA6+oHmYwIsPFUoVWgXPxY44pyYzYo2OWmwQ?=
 =?us-ascii?Q?aAEF1sb4E6ZgLbBG0/262+9ONUoX8eOWn8hcCGgvidt5FLUkb1r2L+D2BBD/?=
 =?us-ascii?Q?M/xQbOZlwArA9k8LFhXiGyZWnVmY5vKt0X4IqIU21jab+YgtObFN4AZYMBpy?=
 =?us-ascii?Q?yX/iLK/y7Mpx2Lx2MYFS3DhqlhI7hsn4JHBYA8Z/BNslLqSauhzWPZzhn2Tt?=
 =?us-ascii?Q?8UC9Oqr4ZU5hBsUitpTnSn1PnV4L0BoVlNl4JauWNZ7hsedusCgqLV7ZoTT1?=
 =?us-ascii?Q?j1Z+aHgM1+Y07dVjewBxVMo7mIJuzJqghxL7XIPct4fNPDY5A+5OJJKriSCV?=
 =?us-ascii?Q?qOO5y62bdXYuPoDzcMnqMsktk3V08yCki/3L5cn5Vo4gkP0fVhtnySqE/isE?=
 =?us-ascii?Q?rfta2MwublEoHJNIxHEzeptbZLvbJUN2CnCqKDWTHD6mV4Gbb5nun8bl2utH?=
 =?us-ascii?Q?hcsjIg2nd9MgOXQxXLNI4scgHnt0u1t+o9o9DDDBJWNhX+oBUZbXIl+2b9BC?=
 =?us-ascii?Q?C/ZnMIWMcriZ7Q36saQ37NLLy8PnswXRnLF18objs/uJpw/Dapx7Vlp6fBZO?=
 =?us-ascii?Q?567bbVxkdDNu98eo9T7nl0/Mc5lkDnKWaxbs34ar+vWGvI1uzpIF+1ELeQzP?=
 =?us-ascii?Q?OOYv+qthHW6QPopqldYmLQbpPIgtg/M4rJdsLOwFstsb2WygX8xToaGaa+eF?=
 =?us-ascii?Q?7wojKPFsMW1Rko8NIxiDUDhSZbvB4Phas8lLWbzd2Njowdm4QjGdI3bCuAN/?=
 =?us-ascii?Q?N0+i7dFGOhdM/chNTRnY3RuqH7WoJKXwGV7QnFtEKfGzxm10mexlhWHS+3qv?=
 =?us-ascii?Q?M1j0yoh4hebkAwRlgZBYlNAmZcJfL12iBWByBN+KXxEcFnYDtWmVDxI7692F?=
 =?us-ascii?Q?QO+Bww2RCiD99Dr3jseve4l8/75cKuMXVUngdaB89gdS6uXNupUsmiCq79hA?=
 =?us-ascii?Q?mGkRhuhats7TB7+szuKY5P6DIqVhDmxWIG59Rblh/ix4tcgWqZUuXThzA9ZS?=
 =?us-ascii?Q?kE7yd/6vfxCDIMfmmVRUqlLst8aa9g+4Vuv3n90mLSEK2Rle62KvIsc3nPHN?=
 =?us-ascii?Q?cvhGN3+sKChUx/SEHhEChdx8Y1alTOuMd0Mu+qyZF2a26n2KELFCeqLxDO5p?=
 =?us-ascii?Q?uXx2QDi8ySUOB4K9PwtkaM6LpmOwsANAmNiMwYn34xJkrprE7shuWpUYL4u4?=
 =?us-ascii?Q?CCOu5genZijjz1hdFGcpwsQ1EjEVL6V04JA6Ux4VXOuQTIWl9aZoPVy83I65?=
 =?us-ascii?Q?zAATA9xFWipJigaIzRUILQPj2QcEYBNykYgEOuTGMxW40Q7F7t4xefCvGCvK?=
 =?us-ascii?Q?9K1TVBSbJ23wFdfzjke1NXvztjeenKnh2Qn3EGAFYiDuMagLLrzOSxL5HFCO?=
 =?us-ascii?Q?ca8sKo2AR+Pgxgvy1CXMurzDvWRVk8FKX19HWc1W/Iqp9jXluOsa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f11b4c-3ba9-4d8c-b413-08df07389401
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:19:29.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S161NEkG1XshDb7h0RVD8NFOnnyYf9FBmp9oj5mx6R8FRa/7wskUd0MdXmE8NV34eAINPfe+ewCLb8X3AWrAzLn03QZZ2R8Th+ZHOuQ4nDY2mXuBKNW1CgJmLOgSrdFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8440

From: Wei Fang <wei.fang@nxp.com>

This patch set adds PTP timestamping support to the NETC switch, so that
the switch ports can be used for IEEE 1588 PTP synchronization.

The NETC switch has no time registers of its own and instead shares the
PTP time of the NETC Timer, which is a separate PCIe function driven by
its own driver. The first 3 patches prepare the Timer driver for this
role: tidy up its 64-bit register access, drop an ineffective reset, and
export netc_timer_get_current_time() so the switch driver can read the
current PTP time across the driver boundary in a race-free way.

The switch redirects PTP frames to the CPU through the ingress port
filter table (IPFT). A few patches harden and simplify the existing IPFT
and host flood handling first, then enable the ingress port filtering
lookup by default so PTP filter rules take effect without extra software
tracking.

On top of that groundwork, the switch driver gains RX timestamping and
both flavours of TX timestamping. Timestamps are carried between the
hardware and the driver through dedicated switch tags: the ingress and
transmit timestamps ride in To_Host tags, and per-frame requests ride in
To_Port tags. Two-step TX matches a queued skb clone against the
timestamp response echoed back by the hardware. One-step TX defers the
Sync frame to a per-port work, where the driver reads a fresh PTP time
and writes it into the Sync frame's timestamp field, then programs the
single-step register and transmits the frame so the hardware can add the
residence time to the correction field on the wire.

Together these changes let standard user-space PTP stacks drive hardware
timestamping on the NETC switch ports.

---
v3:
1. Change the prototype of netc_timer_get_current_time(), and check the
   pdev driver before accessing the driver data
2. Patch 5 is a new patch
3. Add netc_port_tstamp_timeout_work()
4. Check the return value of ntmp_ipft_delete_entry(), and in
   netc_port_add_ipft_ptp_entry(), check whether the entry already exists
   in IPFT before creating a new entry
5. Remove netc_port_purge_onestep_queue() from netc_port_disable()
6. Add netc_port_purge_onestep_queue() to netc_onestep_destroy_work()
7. Add try_module_get() to netc_port_onestep_alloc() and add module_put()
   to netc_onestep_destroy_work()
8. Use consume_skb() instead of the err_free_skb label calls kfree_skb()
   for NETC_TAG_TH_SUBTYPE2 frames
9. Add subtype check in netc_flow_dissect() and update the comments
10. Check onestep queue length before enqueue
11. Update commit messages
v2 link: https://lore.kernel.org/imx/20260808032146.2335723-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260728104548.3301214-1-wei.fang@oss.nxp.com/
---

Wei Fang (8):
  ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register
    access
  ptp: netc: remove unnecessary pcie_flr() call in probe
  ptp: netc: export netc_timer_get_current_time() for cross-driver use
  net: dsa: netc: use entry ID instead of pointer to track host flood
    rule
  net: dsa: netc: check return value of ntmp_ipft_delete_entry()
  net: dsa: netc: enable ingress port filtering lookup by default
  net: dsa: netc: add PTP two-step timestamping support
  net: dsa: netc: add PTP one-step timestamping support

 drivers/net/dsa/netc/Kconfig          |   2 +
 drivers/net/dsa/netc/Makefile         |   3 +-
 drivers/net/dsa/netc/netc_main.c      | 252 +++++--
 drivers/net/dsa/netc/netc_platform.c  |   1 +
 drivers/net/dsa/netc/netc_ptp.c       | 904 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  93 ++-
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 drivers/ptp/ptp_netc.c                | 125 ++--
 include/linux/dsa/tag_netc.h          |  43 ++
 include/linux/fsl/netc_global.h       |  10 +
 net/dsa/tag_netc.c                    | 236 ++++++-
 11 files changed, 1551 insertions(+), 123 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

-- 
2.34.1


