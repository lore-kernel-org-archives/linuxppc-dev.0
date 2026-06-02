Return-Path: <linuxppc-dev+bounces-21850-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6327ECD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:21:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2Lp5dWVz3byt;
	Tue, 02 Jun 2026 17:21:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384882;
	cv=pass; b=mpE5BarszfoPjjvja0Bjk7gMuJyj9mmqjMp0LhCXMg9c66JK5lruN8DnGHsNQDv5ubnLzL6kMsQjrRFOooP/5yGOelrwYjuRjuZed8o2m8BH7MTlZJsc8ABIM2vdC9zegVW4h0FeDRhnP9PsPSHHHlivr5NanXQYD9Zs9ZQJ35QB8Xar0XARWubYSRGJSd4lmaUHlg9q53U0U1lljG+8Z6leiOnR2Ehr0tOUKQ4AT42utfPKn9Kd9qDhPs1TfedJu4Fhc14CZ4PUwvwecAf7sU75SF6iFOvqNpJkp9kSIGOF44CvBOZbh7qQnI7i2jsu3dPmHUX8WF3sMs9i8pZ2tQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384882; c=relaxed/relaxed;
	bh=jxj3K617bU7hUnYm7mnUehfUMFdVDgldUwtWqvKXtaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QC1j100P0WCMK7my8hk95ym5vlDhV+WMxX7i650QCgjxwTGjDRYQAeWaznZqe+HKb3GkCBpVwH+yutSGEjmJY0b0iU4PJ+v39hELPEL2uiBUw3FmjzSf0zZWhygLyqf5BHq//MVfzi3sBhB3Q5YKsrtfY8ctGQMJBjEIHQp7QmrteuTjiIoVbsF34m58UPs3DOmmiXd1jYECTcpeiVDdiJN+eG3Y0izt3vXRShxmWM5TddcXpxajm5agRgNhL/v5EPPjhjuYzfXbSXpc9CzalhTF5rt2S4/aBzc21B2jEdOEgl393OmnIFbl9ckVtPMIrXvrMx9CL4+DeMxhXRwbAA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ll9BFNKy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ll9BFNKy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2Ln3Npbz3bxl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:21:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HomAqDbW5AUWAiASrmgLJvH3STkOWcEdQBHBfWlpaAYcu8Kd6tEy/oVYFRFWAASCgLtAbTCty5m5iYgokjakLT/hhuPK6rCpSH/zH+eSgJh6lNFRUEvTJkxu3ncsj80Jb82wwOXt96zwWjto8C7W2fIuM5M4J5mU9I3dgRlnBvvarz7/XlJRoGMY+MWIb+tvh5EDU8KVNslGHIfq8xhfnEjlSSHZ3649G3c99EpGmXtDA9SoMPElOisWE0UiSjOzK0NlXhm6Ewy0Qii6m3G5Sk8tXSGAHCk10wUbt9zNr5xLm0xDYvI0dFZ2Hq4AZUryB01Hk0j8HPge6iyDZEE2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxj3K617bU7hUnYm7mnUehfUMFdVDgldUwtWqvKXtaY=;
 b=yCeAakNODM41plHLIQXNUPGqlQOJjVmuyZpQBzgEor9Dz6IQbI0rTIzHwGf9vlLaGdEYThKB1AePHJSc/mlFDCR3R//Y7tDf/j2GDS1PD3SGXZKRoNQIZoKtsfZU1B3muOSKp9y2kHZ7TbnSH2r9USfIcWfMOOWeuHhNQxczevT0Zo0kklTqnSG6jBT3H9R17Yg2Nf/JYuhPRP8DF7nLUFmI9FP5OX0C5CQO3am335n6OqAz5EnZ8Feh1RnLgkIPHUZ38WgtLTV+A/RGTaC36PWy4hVLu2zJlVKMHJgbw8DvJFHqmuFEG5IdFhNr25gs4B6+4HIYgAKxXKDyldDu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxj3K617bU7hUnYm7mnUehfUMFdVDgldUwtWqvKXtaY=;
 b=ll9BFNKyJVRPvch48XdQEzBb4bgQc6BTtRuSMD4SfkyEPq0d85KibIde48F3E899MRXtk6hOLh1HCb11MSn1qpsWWxHeSmNevY08bjafBod/Hspuqn9Sf9FbwZuEEnCcd1akd+MQh8Ql1d039X6/EWEVc+5v2Hk+fFiGz+28EHUdAmB0pcQwFOVdZQWQFngicneM6jjyYGLuiS3EEshCwFklYfE14BIKRjlIV7//fgBJ2yXBpg+utnuJabRnMys5HOZRNMreibzyB3HVB6AaG0l0ZcVIAUnjN5AkDBvOdVrmiNwlYPROypgcGnuC2YZahFxiao84rHwkMq4ICsR72w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:21:03 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:21:03 +0000
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
Subject: [PATCH v2 net-next 8/9] net: dsa: netc: add bridge mode support
Date: Tue,  2 Jun 2026 15:23:12 +0800
Message-Id: <20260602072313.3162120-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffbfec7-5e37-4fad-5c63-08dec0778104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|6133799003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lC8/wPA3bJA8oB9MZwdyONMA3pATokzvo0cLot71U2Qc53wgcao4z6gzkVAuUGlQsCk3CYnRKec8Y47mM21P46fG+6501Sc5Fs8NDdG7qEiavFY3QT8LXHd3SRzyBrMGEOm8A+ohZYqOXY3POQHT5eCveslGLrZV2xFZqUnAzR3Y2H7S6aaiwuSBudh3jo4HFSir3QEchr97RQWJ2XFoNKgfFmwVo7Ec0b/tj7hkOsnAqpuhM79agzSNPDC3sbn8afMRGEy1wbYDDGWAsRGj/f9yemeYTVKmubz8Fy82XLIXv60wcOsBBD2MQpBQxt6RGxfkFMdLBDsC6OvWYkoEpDMbu6XEThph1hUlWL4uM32NTm7F9kGzMYCAqjlHrxkO7MoCDis3i11OD5B72jBDMUJxjVpu0uevIUYzk+KmjX99I2ILu+Cqv/q2H9suZa9e5xtkkwkwo0BmxmNR0GswOtqwy6Gw6SllkP4ej0pMbO/mv2IpGdjXJwkpcSA3FNkA06nWX7EjDoLKVIgw9CnX8edFxPdQ1X6lqq7lF3m7Je/++ETJvQ96P9rvvcWFB4gtVn9T9vyja+YYjQD5osP3myLr+3QXZNhjf99zVPGkOQmBwVRE9AS9yQPWe2Xl1JrZzV8aKM4fSq6VzHIFTQcrqgFZc+wvjyeDHk5t7uPDsp5zBIZ0x2hQ5C+U3e892ixwm/2gzIG+/Km5XbzcxOY08o5d+BI8NaFDS29ksGFcH3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7R/bU7bH4VhDSr0yTyzf+clpCJBB9dIANR53q82ineF0tfamtXIUHdnryVbQ?=
 =?us-ascii?Q?P9FirziYxuur6M5FgcXWOvMzlY+/QcDbTi1NXsBSelxpZ4MlSxYkCCJckbWm?=
 =?us-ascii?Q?xV1Dhksduq5qzVYiBnFhI4avlzPrQgMRfSGxRBSAaqgnwkn1IEYEMOdl2R2j?=
 =?us-ascii?Q?PhwEad5ET8VGAfLGzdE2J+ph1Z8T3PU1w1ff7nwfONAnat7Nv7jYS2SLMkib?=
 =?us-ascii?Q?kXB3LoyIuygh9ePi04HhX/7uqOlu42OfIXszQBsO5Ky1wC/NXlv8XCvToEY5?=
 =?us-ascii?Q?hMadCZ4c4YONFa9BKXvdzN5kNlxzm/TU5NCozDh3NWLv0mv+RhQ7wn+WUwMd?=
 =?us-ascii?Q?eU+bzMaSsCyg6KHwI+W/IrCYLw6PdKvWtxV7AXeBlbui8SsA0VzyxK+mSwhM?=
 =?us-ascii?Q?ZE6jFNwsseSO/nrmb4PjE+FRim8d/m4uSuwcTQH5kSgZV0fhrtiQsesmbE+o?=
 =?us-ascii?Q?brbRrGAlREcD/zkKWOB0mpY+Piyazk+iBNqqFcMOgddmWK7RXzLRBkq7EBFC?=
 =?us-ascii?Q?9Pnsio1OE0lomyKxn8eB4fZJC0GC6x6wwjWcsWuT43okphUpKXyNZBoqXaJ2?=
 =?us-ascii?Q?GnkR4J5NjVxR5zxl2kvfselyYB4oZGuJ8Aq1B/Oxff+AargWR0RGrcrUa7kl?=
 =?us-ascii?Q?GGRVfqbSklf6boqI4+wTxdEiP59Kd9RWAqk+YiOUhWvzwRMtrNlQr/EOvcF9?=
 =?us-ascii?Q?mFuU9mw8A/RoS4hP+S3v80IPDblTzcY9Pw59gXHL+pEGmLMyHNT+jalk1933?=
 =?us-ascii?Q?mAQcj8s8ULfbCNY8VdJNpJorhckRC3ftM4wRzORqGsJ4HHwQJ6pmdUub9uH5?=
 =?us-ascii?Q?pLAjPJLWg1FAL03xQN3QJhlzVHGMxxNFthM6571H1n69xArDf9nRol1Ocevx?=
 =?us-ascii?Q?lcJoCGsGo7VMmDMUld4ghY9P5XfF5FhzFJXMrYfJO1OKwUlr2sbukuxDyeWm?=
 =?us-ascii?Q?uckvrKrVRO+wHO83PnkfCeUvve9/hZwoqy/WdEXBQwJT3pzqT9I1LZmaMiw5?=
 =?us-ascii?Q?M2sdVqrUuvifUrUAU89kQoI38n2/We1EE/g/ygNehWSmoITJl4KOFA9dC7M+?=
 =?us-ascii?Q?Dq6Cp6QvHJ2QtV3lGziFkwfxMZi3Y9w5yXu377I6EWY08xiiZZZ54mYUZhxX?=
 =?us-ascii?Q?t8mix9b+zgntZqU46x4EMqc3eMnmLrT6UyL4ri/8zf81ZTp9VJIJ67F7MGpn?=
 =?us-ascii?Q?/AiMUo3rQoDmy6sIIACGX7HUs3r+1gDK00B8/Ro9pRSb5e0Nrx4JvlBnlIkr?=
 =?us-ascii?Q?syF7//IWs2BQej7Tt5tr64tv1P6eTHuEn3OTsTqa8kpU6lCOa+PWfGy8dI6c?=
 =?us-ascii?Q?KwzexllyNw0pwNZPAjZS2HKBWOtxiTj7SkTTZyQpWVi0ItxYT6WX3TuDp0UJ?=
 =?us-ascii?Q?xb7RXF9iWFfxpmu6vADpKxDVeLoK6d9EjbWPcyIzBWzOwkZEbXn6lCWrtoLS?=
 =?us-ascii?Q?gDPF/hJxf6aHvXutsOva2bc2ZEMYA+0b69X1ZURcN2WPrWcbT0fIaVpuKLd0?=
 =?us-ascii?Q?vAjIwc/A7bXgY9sOrsKZpyTSnfj7nzvGPfRViyoQhSnNpPvXjBz6NXAKw6ns?=
 =?us-ascii?Q?UxMkrLB/v8Pcrg1Gi61rzJo37jVwU+XDuRehH1JpXqKkeAXL0Lvi+G7VfYKV?=
 =?us-ascii?Q?eV3BjAhYy2uwfdk8kYuiCfOueibpEsuKfb5PkLSX1/M8HsNv7UiwcdOrXiZ8?=
 =?us-ascii?Q?ZMBvBJcibSe2ydhl5PLPeEuEUOfEHEU3BxglgQ9KZyP5TCp7soC5ZU8tIvxx?=
 =?us-ascii?Q?LNBJ80KONivOZGvGODMKF2quQPhMPVEp1cW5qSsTmB9nZRqgDLLB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffbfec7-5e37-4fad-5c63-08dec0778104
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:21:03.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weHqhSqVGNzy9u4k44XT9ke0RyerWDso1ZF1MaZZ8OpHtZ9dW6h367TQZPAWRRVnj9LTHUKSBIDkyUv6AsvjCyVA5X1V5F/+5dYaUotU8w6eE7FxgNxzs8IVsFLL3v9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

From: Wei Fang <wei.fang@nxp.com>

Wire up the port_bridge_join, port_bridge_leave and port_vlan_filtering
DSA callbacks to support both VLAN-unaware and VLAN-aware bridge modes.

For VLAN-unaware bridges, each bridge instance is assigned a dedicated
internal PVID via NETC_VLAN_UNAWARE_PVID(bridge.num), counting down
from VID 4095. A VFT entry is created for this PVID with hardware MAC
learning and flood-on-miss forwarding enabled. The CPU port is included
as a VFT member so frames can reach the host. The reserved VID range is
blocked in port_vlan_add to prevent user-space conflicts.

Only one VLAN-aware bridge is supported at a time; this constraint is
enforced in port_bridge_join and port_vlan_filtering. The per-port PVID
is tracked in software and written to the BPDVR register whenever VLAN
filtering is active.

FDB operations are extended to the bridge database: when vid is zero the
VLAN-unaware PVID for the bridge is substituted. Dynamic entries learned
autonomously by the hardware are handled by falling back to a
key-element-data delete via ntmp_fdbt_delete_entry_by_keye() when an
entry is absent from the software shadow list. Internal PVIDs are
translated back to VID 0 in port_fdb_dump before reporting to
user-space.

Host flood rules are removed from the ingress port filter table when a
port joins a bridge to avoid bypassing FDB lookup and MAC learning.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 310 +++++++++++++++++++++++++++--
 drivers/net/dsa/netc/netc_switch.h |   2 +
 2 files changed, 297 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index a97121dda237..5b58ce06beb8 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -695,10 +695,16 @@ static int netc_port_del_fdb_entry(struct netc_port *np,
 
 	entry = netc_lookup_fdb_entry(priv, addr, vid);
 	if (unlikely(!entry))
-		/* Currently only single port mode is supported, MAC learning
-		 * is disabled, so there is no dynamically learned FDB entry.
-		 * We need to support deleting dynamically FDB entry when the
-		 * bridge mode is supported.
+		/* The hardware-learned dynamic FDB entries cannot be deleted
+		 * through .port_fdb_del() interface.
+		 * For NTF_MASTER path: Since hardware-learned dynamic FDB
+		 * entries are never synchronized back to the bridge software
+		 * database. br_fdb_delete() -> br_fdb_find() cannot find the
+		 * FDB entry, so .port_fdb_del() will not be called.
+		 * For NTF_SELF path: dsa_user_netdev_ops does not implement
+		 * ndo_fdb_del(), so rtnl_fdb_del() falls back to
+		 * ndo_dflt_fdb_del(), which only supports NUD_PERMANENT static
+		 * entries and rejects all others with -EINVAL.
 		 */
 		goto unlock_fdbt;
 
@@ -1274,6 +1280,16 @@ static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
 	entry->ect_gid = NTMP_NULL_ENTRY_ID;
 
 	bitmap_stg = BIT(index) | VFT_STG_ID(0);
+	/* If the VID is a VLAN-unaware PVID, the CPU port needs to be
+	 * a member of this VLAN.
+	 */
+	if (dsa_port_is_user(np->dp) &&
+	    vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges)) {
+		struct dsa_port *cpu_dp = np->dp->cpu_dp;
+
+		bitmap_stg |= BIT(cpu_dp->index);
+	}
+
 	cfg = FIELD_PREP(VFT_MLO, MLO_HW) |
 	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_FLOOD);
 
@@ -1311,11 +1327,16 @@ static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
 	return err;
 }
 
-static bool netc_port_vlan_egress_rule_changed(struct netc_vlan_entry *entry,
+static bool netc_port_vlan_egress_rule_changed(struct netc_switch *priv,
+					       struct netc_vlan_entry *entry,
 					       int port, bool untagged)
 {
 	bool old_untagged = !!(entry->untagged_port_bitmap & BIT(port));
 
+	/* VLAN-unaware VIDs have no egress rules, so return 'false' */
+	if (entry->vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges))
+		return false;
+
 	return old_untagged != untagged;
 }
 
@@ -1338,7 +1359,8 @@ static int netc_port_set_vlan_entry(struct netc_port *np, u16 vid,
 	}
 
 	/* Check whether the egress VLAN rule is changed */
-	changed = netc_port_vlan_egress_rule_changed(entry, port, untagged);
+	changed = netc_port_vlan_egress_rule_changed(priv, entry, port,
+						     untagged);
 	if (changed) {
 		entry->untagged_port_bitmap ^= BIT(port);
 		err = netc_port_update_vlan_egress_rule(np, entry);
@@ -1402,6 +1424,17 @@ static int netc_port_del_vlan_entry(struct netc_port *np, u16 vid)
 	cfge = &entry->cfge;
 	vlan_port_bitmap = FIELD_GET(VFT_PORT_MEMBERSHIP,
 				     le32_to_cpu(cfge->bitmap_stg));
+	/* If the VID is a VLAN-unaware PVID, we need to clear the CPU
+	 * port bit of vlan_port_bitmap, so that the VLAN entry can be
+	 * deleted if no user ports use this VLAN.
+	 */
+	if (dsa_port_is_user(np->dp) &&
+	    vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges)) {
+		struct dsa_port *cpu_dp = np->dp->cpu_dp;
+
+		vlan_port_bitmap &= ~BIT(cpu_dp->index);
+	}
+
 	/* If the VLAN only belongs to the current port */
 	if (vlan_port_bitmap == BIT(port)) {
 		err = ntmp_vft_delete_entry(&priv->ntmp, vid);
@@ -1507,17 +1540,57 @@ static int netc_port_max_mtu(struct dsa_switch *ds, int port)
 	return NETC_MAX_FRAME_LEN - VLAN_ETH_HLEN - ETH_FCS_LEN;
 }
 
+static struct net_device *netc_classify_db(struct dsa_db db)
+{
+	switch (db.type) {
+	case DSA_DB_PORT:
+		return NULL;
+	case DSA_DB_BRIDGE:
+		return db.bridge.dev;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+}
+
+static u16 netc_vlan_unaware_pvid(struct dsa_switch *ds,
+				  const struct net_device *br_ndev)
+{
+	struct dsa_port *dp;
+	int br_num = -1;
+
+	if (!br_ndev)
+		return NETC_STANDALONE_PVID;
+
+	dsa_switch_for_each_available_port(dp, ds) {
+		if (dsa_port_bridge_dev_get(dp) == br_ndev) {
+			br_num = dp->bridge->num;
+			break;
+		}
+	}
+
+	/* The br_num is supposed to be 1 ~ ds->max_num_bridges, see
+	 * dsa_bridge_num_get(). Since max_num_bridges is non-zero,
+	 * so dsa_port_bridge_create() will return an error if
+	 * dsa_bridge_num_get() returns 0.
+	 */
+	if (WARN_ON(br_num <= 0))
+		return NETC_STANDALONE_PVID;
+
+	return NETC_VLAN_UNAWARE_PVID(br_num);
+}
+
 static int netc_port_fdb_add(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid,
 			     struct dsa_db db)
 {
+	struct net_device *br_ndev = netc_classify_db(db);
 	struct netc_port *np = NETC_PORT(ds, port);
 
-	/* Currently, only support standalone port mode, so only
-	 * NETC_STANDALONE_PVID (= 0) is supported here.
-	 */
-	if (vid != NETC_STANDALONE_PVID)
-		return -EOPNOTSUPP;
+	if (IS_ERR(br_ndev))
+		return PTR_ERR(br_ndev);
+
+	if (!vid)
+		vid = netc_vlan_unaware_pvid(ds, br_ndev);
 
 	return netc_port_set_fdb_entry(np, addr, vid);
 }
@@ -1526,10 +1599,14 @@ static int netc_port_fdb_del(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid,
 			     struct dsa_db db)
 {
+	struct net_device *br_ndev = netc_classify_db(db);
 	struct netc_port *np = NETC_PORT(ds, port);
 
-	if (vid != NETC_STANDALONE_PVID)
-		return -EOPNOTSUPP;
+	if (IS_ERR(br_ndev))
+		return PTR_ERR(br_ndev);
+
+	if (!vid)
+		vid = netc_vlan_unaware_pvid(ds, br_ndev);
 
 	return netc_port_del_fdb_entry(np, addr, vid);
 }
@@ -1565,6 +1642,8 @@ static int netc_port_fdb_dump(struct dsa_switch *ds, int port,
 		cfg = le32_to_cpu(cfge->cfg);
 		is_static = (cfg & FDBT_DYNAMIC) ? false : true;
 		vid = le16_to_cpu(keye->fid);
+		if (vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges))
+			vid = 0;
 
 		err = cb(keye->mac_addr, vid, is_static, data);
 		if (err)
@@ -1681,6 +1760,19 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct ipft_entry_data *old_host_flood;
 
+	/* Do not add host flood rule to ingress port filter table when
+	 * the port has joined a bridge. Otherwise, the ingress frames
+	 * will bypass FDB table lookup and MAC learning, so the frames
+	 * will be redirected directly to the CPU port.
+	 */
+	if (dsa_port_bridge_dev_get(np->dp)) {
+		netc_port_remove_host_flood(np, np->host_flood);
+		np->host_flood = NULL;
+		netc_port_wr(np, NETC_PIPFCR, 0);
+
+		return;
+	}
+
 	if (np->uc == uc && np->mc == mc)
 		return;
 
@@ -1702,12 +1794,87 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	netc_port_remove_host_flood(np, old_host_flood);
 }
 
+static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
+					 struct netlink_ext_ack *extack)
+{
+	struct net_device *br_ndev = NULL;
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_available_port(dp, ds) {
+		struct net_device *port_br = dsa_port_bridge_dev_get(dp);
+
+		if (!port_br || !br_vlan_enabled(port_br))
+			continue;
+
+		if (!br_ndev) {
+			br_ndev = port_br;
+			continue;
+		}
+
+		if (br_ndev == port_br)
+			continue;
+
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only one VLAN-aware bridge is supported");
+
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int netc_port_vlan_filtering(struct dsa_switch *ds,
+				    int port, bool vlan_aware,
+				    struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *br_ndev;
+	u32 pvid, val;
+	int err;
+
+	err = netc_single_vlan_aware_bridge(ds, extack);
+	if (err)
+		return err;
+
+	br_ndev = dsa_port_bridge_dev_get(np->dp);
+	pvid = netc_vlan_unaware_pvid(ds, br_ndev);
+	if (pvid == NETC_STANDALONE_PVID) {
+		vlan_aware = false;
+		goto bpdvr_config;
+	}
+
+	if (vlan_aware) {
+		err = netc_port_del_vlan_entry(np, pvid);
+		if (err)
+			return err;
+
+		pvid = np->pvid;
+	} else {
+		err = netc_port_set_vlan_entry(np, pvid, false);
+		if (err)
+			return err;
+	}
+
+bpdvr_config:
+	val = (vlan_aware ? 0 : BPDVR_RXVAM) | (pvid & BPDVR_VID);
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_RXVAM | BPDVR_VID, val);
+
+	return 0;
+}
+
+static void netc_port_set_pvid(struct netc_port *np, u16 pvid)
+{
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_VID, pvid);
+}
+
 static int netc_port_vlan_add(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan,
 			      struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct dsa_port *dp = np->dp;
 	bool untagged;
+	int err;
 
 	/* The 8021q layer may attempt to change NETC_STANDALONE_PVID
 	 * (VID 0), so we need to ignore it.
@@ -1715,20 +1882,129 @@ static int netc_port_vlan_add(struct dsa_switch *ds, int port,
 	if (vlan->vid == NETC_STANDALONE_PVID)
 		return 0;
 
+	if (vlan->vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "VID %d~4095 reserved for VLAN-unaware bridge",
+				       NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges));
+		return -EINVAL;
+	}
+
 	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+	err = netc_port_set_vlan_entry(np, vlan->vid, untagged);
+	if (err)
+		return err;
 
-	return netc_port_set_vlan_entry(np, vlan->vid, untagged);
+	if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
+		np->pvid = vlan->vid;
+		if (dsa_port_is_vlan_filtering(dp))
+			netc_port_set_pvid(np, vlan->vid);
+
+		return 0;
+	}
+
+	if (np->pvid != vlan->vid)
+		return 0;
+
+	/* Delete PVID */
+	np->pvid = NETC_STANDALONE_PVID;
+	if (dsa_port_is_vlan_filtering(dp))
+		netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+
+	return 0;
 }
 
 static int netc_port_vlan_del(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	int err;
 
 	if (vlan->vid == NETC_STANDALONE_PVID)
 		return 0;
 
-	return netc_port_del_vlan_entry(np, vlan->vid);
+	err = netc_port_del_vlan_entry(np, vlan->vid);
+	if (err)
+		return err;
+
+	if (np->pvid == vlan->vid) {
+		np->pvid = NETC_STANDALONE_PVID;
+
+		/* Set the port PVID to NETC_STANDALONE_PVID if the VLAN-aware
+		 * bridge port has no PVID. The untagged frames will not be
+		 * forwarded to other user ports, as NETC_STANDALONE_PVID VLAN
+		 * entry has disabled MAC learning and flooding, and other user
+		 * ports do not have FDB entries with NETC_STANDALONE_PVID.
+		 */
+		if (dsa_port_is_vlan_filtering(np->dp))
+			netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+	}
+
+	return 0;
+}
+
+static int netc_port_bridge_join(struct dsa_switch *ds, int port,
+				 struct dsa_bridge bridge,
+				 bool *tx_fwd_offload,
+				 struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u16 vlan_unaware_pvid;
+	int err;
+
+	err = netc_single_vlan_aware_bridge(ds, extack);
+	if (err)
+		return err;
+
+	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
+
+	if (br_vlan_enabled(bridge.dev))
+		goto out;
+
+	vlan_unaware_pvid = NETC_VLAN_UNAWARE_PVID(bridge.num);
+	err = netc_port_set_vlan_entry(np, vlan_unaware_pvid, false);
+	if (err) {
+		netc_port_set_mlo(np, MLO_DISABLE);
+		return err;
+	}
+
+	netc_port_set_pvid(np, vlan_unaware_pvid);
+
+out:
+	netc_port_remove_host_flood(np, np->host_flood);
+	np->host_flood = NULL;
+	netc_port_wr(np, NETC_PIPFCR, 0);
+
+	return 0;
+}
+
+static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev = np->dp->user;
+	u16 vlan_unaware_pvid;
+	bool mc, uc;
+
+	netc_port_set_mlo(np, MLO_DISABLE);
+	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+
+	uc = ndev->flags & IFF_PROMISC;
+	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
+
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_warn(ds->dev,
+			 "Failed to restore host flood rule on port %d\n",
+			 port);
+
+	if (br_vlan_enabled(bridge.dev))
+		return;
+
+	vlan_unaware_pvid = NETC_VLAN_UNAWARE_PVID(bridge.num);
+	/* There is no need to check the return value even if it fails.
+	 * Because the PVID has been set to NETC_STANDALONE_PVID, the
+	 * frames will not match this VLAN entry.
+	 */
+	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
 }
 
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
@@ -2009,8 +2285,11 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.port_vlan_filtering		= netc_port_vlan_filtering,
 	.port_vlan_add			= netc_port_vlan_add,
 	.port_vlan_del			= netc_port_vlan_del,
+	.port_bridge_join		= netc_port_bridge_join,
+	.port_bridge_leave		= netc_port_bridge_leave,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
@@ -2058,6 +2337,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->fdb_isolation = true;
+	ds->max_num_bridges = priv->info->num_ports - 1;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 9ff334301fbc..982c8d3a3fbf 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -33,6 +33,7 @@
 #define NETC_MAX_FRAME_LEN		9600
 
 #define NETC_STANDALONE_PVID		0
+#define NETC_VLAN_UNAWARE_PVID(br_id)	(4096 - (br_id))
 
 /* Threshold format: MANT (bits 11:4) * 2^EXP (bits 3:0)
  * Unit: Memory words (average of 20 bytes each)
@@ -79,6 +80,7 @@ struct netc_port {
 	u16 enable:1;
 	u16 uc:1;
 	u16 mc:1;
+	u16 pvid;
 	struct ipft_entry_data *host_flood;
 };
 
-- 
2.34.1


