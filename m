Return-Path: <linuxppc-dev+bounces-24426-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3552BC44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:12:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PD35tqBz2xF8;
	Mon, 20 Jul 2026 12:12:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513539;
	cv=pass; b=hKAR2+7OABSGN0D8nuU+YADkRwih/dUj/WiMW5CvktiXCw8BoQDNIWIbVLZ6N8WfpoCQeVHOIjhRbGg+5yk65u3S1/Ohje3Rter1tcCzBEfNKApaBINAahyJLX1CpdtJTFU6gALJhDjRPa0wOu6Xg0Mdd2CFp9Vv/5PoOOXffMVai72OIAibuym+D4nkUiYt0EvJTXFhJTdXhTmEKLf0Stkk9Ok//WOctONt2MsnvHZ7PEjaJNQ64+7eMFtTCMx+7yA5+RwRsdHndVi1IFhO1lsgDSYFJ3WA/XU6uQucks3dJAmj5fXDYZbiXhhmW+42fCOvVmv5Eh5E8a7tWCIBbg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513539; c=relaxed/relaxed;
	bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwn2gskXuU8ISOD9miKLQMVZUrfcLWRQ+s3dRGbsi5ubBFuLZ8BgL4HZ2l6miKy19mmwonz5azpw1WMQahnVdxhA/Mdh8WKX/YE/K0f07KffiatBtv3qdQcoy2AcruWL4SfRQ9RVZBdkMDm1ezvkn7pU16uSomTQJKhBB0NSYCxr+aYIQ29TKMZnh5kCUdP6kVxUPndvDjsTB5Wbew5WEExzpAtrdso3vDEHK9D98Qu+XPpJWLnu5gX3qAJOlkdOUeodevuzx/h/8NdaT2PQKLBMWMdhF9vhgD8pj71QIX5eLh/NvBCUhWfiBbhXSy9Nk3b3tvulq44v9NgdVdu3aw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rtT87fB1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rtT87fB1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PD22qFKz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:12:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNG0wnWIvfK0QAfbUYt/IOaCFfwjztl7AsNJp9Zuue9muQ0iTTHbP/cahxFua3dzDGcPXPS3m2uaoOqPy+hzs0C8ANJHbrNTalE6r90IJSUpPPVXtv7TdLs1DMmLvQ3W9wb12RZOD3So1iM+xpAZAjf0IjwfdWFN56hepXz7DmeLAMicXxWBa07GARS1Qx7M4gxbvpW2ZAGEeAcPtJo1bCK+KXK0mlAL9lXHyGu/KEoITKry0e46VRsrh3FM0v+dopZP7sHeX0O9jiM2Y7gcVfu+hrpIQ3E/ZUS6Y2RqF2bja5phH5ue9cJtBqTlejz14jwT5XSig3kmQ89romGRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=Df8S5jT+hHgqymn27dNPl/oG3dyNV/gSRQ5UasicQVygiASmNdn6CWVxExN2clXV0o2n/27JMCBjKB0qpzcrTYopn6VG5vSY/XNLRLPdt5jRkTWc+E8Qc6bpDyIRe5yDFlefaPFJnhiWXEFTDfz+zYhuakwzLjWXB1c9O+2LL+vewfubaVA3gOtoJ1wznbyUfbRKm+h8V2D6uCOY8cnTGGb0HlJWTDBB2i9Oj2Ns9o7lQY7Aqd7DlTPzi63S+nbeK7/MXn5XcsBt9lIBnJr8Q41HvfGdYh36U6YvNrkOro7DKSIWoe5eAgAm6tPFu0xDaIwT11bcpY7fL11EfrV7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=rtT87fB1iGvSPriH2t3Yt/hmzWzGp73uLiS8X1Hx+MLEcz8RejOB3XuRnAGE//tTsrAc50gnHdAl8fbe8sFo81/9WurBuKntVnclf76ek+PT4fKF7CyuRGLrYtgEha3fq5SrzHEz9D+nnDzXp2XaeY37HJyPqAx5v7qe0XIBXfeQVd2LJRD7PF5ypppaW5mBiNON83SBWtZ55KLLRXUYxdTYljQGc6RkWLBwXrudUzRHJFkNYiTsFQXWakhgnjw4ADK1vUoyV3Qf62u2AYQn3wLiNMaDw6dkHoXhSr69NjW6ZbvlLv2Lbqasc9Vr0NjS3QL7SbyHYetJaO9OPB8EKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB11580.eurprd04.prod.outlook.com (2603:10a6:10:608::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 02:11:59 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:11:59 +0000
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
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v4 net-next 01/14] net: enetc: extract common helpers for MAC promiscuous mode setting
Date: Mon, 20 Jul 2026 09:43:03 +0800
Message-Id: <20260720014317.1059359-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB11580:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de51be8-0846-4b0c-c3e5-08dee6044791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|6133799003|10067099003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XcnybYiA/YgsTGrkuGfHcJueXzvR1ImTljJmpYAbBR8t7vyT3wXcwh3XN10/Ktz/9ckoUGS/flD9dDsDCsoYAwLgJR35F9M96aT5Aq58+RHXI1m4N5f04bU/Krs2nHhbukFTrOFXCM9eSeU/PtXk9DYqgQw4jSDYopA+gEpQgDofo3MnVl8ZV+OFCScB5ySvdvA/Dh6/5/KOZnWNH4B32TpwAgFYaD399k87YdRmvuMtis/wTkYokDbXKNBAzde7lSQaoABh6UDhfjYb1Spf6B643tM8vZzfveJu5epik3gQkhC5YenahgIRh3v5jHGLUvvBKTeS+m5weyep4LGuWThk4dJsIc1FdjuXg85Cr2GHn+riTuIKmE8mA4bIgjETecQcphgmgKuFIoFS1SRbtOKPRaMEYEEsD5x8cdlI0x/lW/OjonFmTtl50PjtP9Jtgq+F1YpS/TFNEgS6AXbaDl2K0+BNh81l8sxwpOIyRosoPlVmdEJ+YAXRPrMz0neTonw5/A6J2IS4/lHN49yjItImzj5HgXl9UNkJoM34QbRV38Z8b2PBxmFY8GPalUBrADVWXNeNGfh5Lu+LAHbGY1xHJhboy8BbpO6n5oSBHX4/dB52gK5AhxsWK26lSHEjiBAoRyz/0oN9ZJ4BQn2KqBP285F0/Ikq6DPWw9TujnmgpL5LQIMxFfRmqm8Y7cAfAFTSQcAAxq62tKhTv9Qolg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(6133799003)(10067099003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QSwkSASqv/wog7QEEGGtzc1qE9B9BZxEN71Sa4wilLIYf+o9A1NYUPQEtXkG?=
 =?us-ascii?Q?mpyjBNTDbRUv1oN+HCakZrRs/JTnGwVVrkVmOGmbsx4IuxRlW0d/m/L2rkoC?=
 =?us-ascii?Q?Wobi7ZHAX80c61VjObSoiUpHSNtH8igXxBBizG1ZA1I+EU4ToXlO6wN9ZO4F?=
 =?us-ascii?Q?TcHXyzQxM6bnJmJbYSKHWg3EqwVCJ5Fit5R7GHeG4WtX8ejlamuoCar9LFAi?=
 =?us-ascii?Q?zTgDBHEX2M+qcZRMW16SPyoK6i6pv3s0g3MeAPDn301HmCOz/H/lMNKH0JBJ?=
 =?us-ascii?Q?jxD6aE8hpIEKhI9YgdrqyRgygynXpgG7FNCQaafi/jSeV2EUT6KenK6S17v3?=
 =?us-ascii?Q?g7Qmi9c2/hbuZcS7mcAKe8mBkhdTG3tcKY/6GqPORR7re1dUiW1ZkH1VgMRu?=
 =?us-ascii?Q?576cjx3oZAp+zItHvcmeMitR/DrL3GS6NuJ3LuNda8htWODAw7o7Us+jpC2A?=
 =?us-ascii?Q?OBEsNy12N7EMPpXRTPyxmF9O4+Rh8NaSdL57pqNDAWhp4XEnLxrPE95ONfzn?=
 =?us-ascii?Q?1vtbOSvSXQZuULqc18lVOm5f09lxmb1nTCYrjAalADYU8f+EkxQLjJa5AeDB?=
 =?us-ascii?Q?VatEA1uLs5yOj/W7Duv+4ohNGXfMOFGVNloq9miQL248d80N3urcc5PGXyza?=
 =?us-ascii?Q?Me3D+nKmZ9x7A2G//vw9shQ3/asyWlUnFh40yRhpQw7faeNyGBQIgj27M2J9?=
 =?us-ascii?Q?DrUCWQpEs8Ws78tyVtpCCdy0OMgsZQSvF77t+mJM4hwmqK9FCnDD7NUhhDwr?=
 =?us-ascii?Q?l0I0uuGCJQU5VfcM/qH36fjmeR+1qS8v1P2/DVnEAnS0IsjqOF5oLBXz2FVV?=
 =?us-ascii?Q?aC9NsEvglfpmdEFyc1+gIPPfZvY2ETXaO4N5gGXI1SUP01xlZjTDdCuXv0yu?=
 =?us-ascii?Q?QnLM2DqTTvceW6HWFkITZ3kFcbXfK5OKAPN685WRhjYIWiBPyavAMKYArraL?=
 =?us-ascii?Q?foDBSrH5SwVnLHdVOENHo0Dq6KVtvEnYXm+3Eg/OYpCZNDR446vNf2/NaLtN?=
 =?us-ascii?Q?C1olI9rGzFB+FCqxzHMP8GrnbdkLI3nKvDNav4lNeeicuuC4IK5aSYB2vZar?=
 =?us-ascii?Q?TkhguJ1KYQkbgYn2eVCaSXzjcVxjXJR7wOJ3VEQzVfZJLU95VW+sMOkJlirX?=
 =?us-ascii?Q?6FeEfsLXisJA3ooxk8HK9HzfdkiedgnKJYwC45H8KJ+Y5imF/szI69tB6ySp?=
 =?us-ascii?Q?4EQzrJ+LcjnLsJER2cOyuSwg75+sBgne93sFM9tWsUAlSlvyrX2S+uKIMdhj?=
 =?us-ascii?Q?eTBNRDlWg2EQEzNpzF3NV9pB73tL37rh4h8Xa4R4IdusD2eghUzsjwm1KbPU?=
 =?us-ascii?Q?uWhXlQV8qsikwdW1eGFiMjrfiyt7ivh6DIlaRa2Q75XJ4uRJM7c1AAtdLyrc?=
 =?us-ascii?Q?xEclCeKdNuLmZofzBMyEZtyQ6MoYkqkAmCmrzbtP7KogCRmgG733R2GtVms8?=
 =?us-ascii?Q?VwownCGyAGjzZbf0keqWv5DdIMAdTeComcelcE4dWCemcfltnNwq0lovqczr?=
 =?us-ascii?Q?4abPlT001RK6cg3Zmq0MWNVdB8WTjgcVLGx75ZnbkP7lkkaOCmsBYWNQSjWB?=
 =?us-ascii?Q?s/7ZO/wOhYOTZvPhmmk7KOEKdiirEpjuIV/+3xtaUubr7buPNN1kjiSQN7Im?=
 =?us-ascii?Q?ri2PE5Hg9DR7wOBD/ErD030se1ALgSp45DQ/0F+03g3OPB233sSQdXnj5SjX?=
 =?us-ascii?Q?ct1DdkTchdbgEZsLgeo2PhosbzJWCQ4xeJ+9pr2XH+X9qGzPtttBjgP34yFT?=
 =?us-ascii?Q?Hpf/Z0aoVium7GVg0y0XrutDy42Re5bE+IbmeE3p541gG6YbW1Lq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de51be8-0846-4b0c-c3e5-08dee6044791
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:11:58.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zekNw2qJnjHjsxqfE0qZevM14pzCdYPy3YiEc7T+k+LZiNHb9iRFs5Zi+ao4xPu1ZKmtusHXQA9qvFKqIPSAJD7b8DLj8LFmkbEQGFQRsNtSfIotEjSL4lVnNoA9/bV8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11580

From: Wei Fang <wei.fang@nxp.com>

The PSIPMMR (Port Station Interface Promiscuous MAC Mode Register) in
ENETC v4 has the same bit layout as the PSIPMR register in ENETC v1: bit
n controls unicast promiscuous mode for SI n, and bit (n + 16) controls
multicast promiscuous mode for SI n. The only difference between the two
hardware generations is the register address offset.

Since the register functionality is identical, the MAC promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Rename ENETC_PSIPMR to ENETC_PSIPMMR in enetc_hw.h to match the actual
register name used in the reference manual, and extract two new common
helper functions, enetc_set_si_uc_promisc() and
enetc_set_si_mc_promisc(), into enetc_pf_common.c. These helpers select
the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove the v4-specific enetc4_pf_set_si_mac_promisc() function from
enetc4_pf.c and the duplicate PSIPMMR_SI_MAC_UP/MP macro definitions
from enetc4_hw.h, as they are now superseded by the shared code.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +--------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  7 +--
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 11 ++---
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 7 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index f18437556a0e..6a8f2ed56017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -69,8 +69,6 @@
 
 /* Port Station interface promiscuous MAC mode register */
 #define ENETC4_PSIPMMR			0x200
-#define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
-#define  PSIPMMR_SI_MAC_MP(a)		BIT((a) + 16)
 
 /* Port Station interface promiscuous VLAN mode register */
 #define ENETC4_PSIPVMR			0x204
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 437a15bbb47b..304ec069654d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,24 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_mac_promisc(struct enetc_hw *hw, int si,
-					 bool uc_promisc, bool mc_promisc)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPMMR);
-
-	if (uc_promisc)
-		val |= PSIPMMR_SI_MAC_UP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_UP(si);
-
-	if (mc_promisc)
-		val |= PSIPMMR_SI_MAC_MP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_MP(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPMMR, val);
-}
-
 static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
 					    u64 hash)
 {
@@ -515,7 +497,8 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		type = ENETC_MAC_FILTER_TYPE_ALL;
 	}
 
-	enetc4_pf_set_si_mac_promisc(hw, 0, uc_promisc, mc_promisc);
+	enetc_set_si_uc_promisc(si, 0, uc_promisc);
+	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
 		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71f376ef1be1..07b7832f2427 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -29,7 +29,7 @@ static const u32 enetc_rxbdr_regs[] = {
 };
 
 static const u32 enetc_port_regs[] = {
-	ENETC_PMR, ENETC_PSR, ENETC_PSIPMR, ENETC_PSIPMAR0(0),
+	ENETC_PMR, ENETC_PSR, ENETC_PSIPMMR, ENETC_PSIPMAR0(0),
 	ENETC_PSIPMAR1(0), ENETC_PTXMBAR, ENETC_PCAPR0, ENETC_PCAPR1,
 	ENETC_PSICFGR0(0), ENETC_PRFSCAPR, ENETC_PTCMSDUR(0),
 	ENETC_PM0_CMD_CFG, ENETC_PM0_MAXFRM, ENETC_PM0_IF_MODE
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index bf99b65d7598..66bfda60da9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -180,9 +180,10 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PMR_PSPEED_1000M	BIT(9)
 #define ENETC_PMR_PSPEED_2500M	BIT(10)
 #define ENETC_PSR		0x0004 /* RO */
-#define ENETC_PSIPMR		0x0018
-#define ENETC_PSIPMR_SET_UP(n)	BIT(n) /* n = SI index */
-#define ENETC_PSIPMR_SET_MP(n)	BIT((n) + 16)
+#define ENETC_PSIPMMR		0x0018
+#define  PSIPMMR_SI_MAC_UP(n)	BIT(n) /* n = SI index */
+#define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
+
 #define ENETC_PSIPVMR		0x001c
 #define ENETC_VLAN_PROMISC_MAP_ALL	0x7
 #define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 2d687bb8c3a0..a97d2e2dd07b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -159,21 +159,17 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_hw *hw = &priv->si->hw;
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
 	struct netdev_hw_addr *ha;
-	u32 psipmr = 0;
 	bool em;
 
 	if (ndev->flags & IFF_PROMISC) {
 		/* enable promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0);
 		uprom = true;
 		mprom = true;
 	} else if (ndev->flags & IFF_ALLMULTI) {
 		/* enable multi cast promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_MP(0);
 		mprom = true;
 	}
 
@@ -211,9 +207,8 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 		/* update PF entries */
 		enetc_sync_mac_filters(pf);
 
-	psipmr |= enetc_port_rd(hw, ENETC_PSIPMR) &
-		  ~(ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0));
-	enetc_port_wr(hw, ENETC_PSIPMR, psipmr);
+	enetc_set_si_uc_promisc(priv->si, 0, uprom);
+	enetc_set_si_mc_promisc(priv->si, 0, mprom);
 }
 
 static void enetc_set_loopback(struct net_device *ndev, bool en)
@@ -474,7 +469,7 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
 	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
 
-	enetc_port_wr(hw, ENETC_PSIPMR, 0);
+	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
 	/* enable port */
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 6e5d2f869915..b0c0dc668e34 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -87,6 +87,50 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_UP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_UP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_promisc);
+
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_MP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_MP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 57d2e0ebd2b0..a619fb8fed9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -17,6 +17,8 @@ void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


