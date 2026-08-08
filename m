Return-Path: <linuxppc-dev+bounces-25626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D28C5AC82
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 03:18:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH5nv2FB6z2yqL;
	Sat, 08 Aug 2026 13:18:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786159123;
	cv=pass; b=ibu2g1CKF8IFFDC41bhrfWhbao4ayDzJyBIkXhy/igP5QWbASrU87HrxqVBt27J9ji4Q/ocfcEmfM2+/2o6TpRsKBYrsOFPrvsp9zDTZZtrTemNsJQZSzx/mzRRk/T+MfmzMSq2klPU0fLAmmW7qopbri8vf9Ta9lILPDYnmjzfzg9ANhsiSgVZZAekW7cYE4KUIZyz6mgSYZc/cVJfK+D/OHEZhO2l61QSIwyYTmZn9WnJj7fOgRIV84qcayvxzmyjY1OwAejYlw7MXoXb2LAnsUZMEOsCXwaCMwDxliMecPzDjjPuLfBhYkbvXx+qfXwV3WgP0cB8IektuZLnAOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786159123; c=relaxed/relaxed;
	bh=bdioCon70PuUezzxLROIeTJwV/awMUSpnt0xTZfqOKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baLO6nscvMhYuTD413ke/imDhMg5mKYphctRU4q7cdHa7WvyUMmDnqfJTUJdh57yWT9rxiyUy0+q6P5dRHQXGfJlXjxLBAKnHVU4K178XH7nOHj621rDI1o0f47xozKF09ZxL4P5sEVcE7bhlZlIiThneFXE9jLNib8kz0Ww5wJK5M674ocqHItg0GLOygumR06Vw9FCn1QVljgLkJ0yoDKFkcBlhNVKwqU4YgD8JHHp2lKfrezeNtboNtpv88j2tSUwKDWDgfEIhM2/xmQH1/2Euklf1wgc3tvBsUE4RDilynibDsgzbAK1otf5CHt33DDRTlCTM1gPO2GlHL2xaA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZZy1gXMz; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZZy1gXMz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH5nt1t2tz2ynT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 13:18:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt7U+SqM4xjBf/Fsc9tyMkiGDDDOgbpXR9LUIr13IbhTTrqBWITOUrmUDVyJq61IC86MCoTAdvgfog00xe5jZ3zHAMHmoNk4NxTIc6IWfsUH85kpLwvzyvWKNfAI3GVgOURvRrBscsCS7YGJsf/dUVKRKrMRkIqiG2f/o5yKmW7Okz07RkapFNH5fInQHRptmKJcAzY2sfxSbUQ8k3yinhgvt0cd2hqJYRdcZBDJQxnc1XAW2W2KYFiYhqg073ACutycnts29JhcXjxj0OPVInpV2OXG23UTV9ekQ5fMyky0NLNkAWB6PTuS7qJu7so8GottezgQAuWW/W0OvLmkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdioCon70PuUezzxLROIeTJwV/awMUSpnt0xTZfqOKM=;
 b=CiVnrDvac7f4AdagFvzfj+hWKHmEuOqR+t+h58hGW0Ci4vUWCbHi0tCDwA15SYEz4p24ZYOLyfdExeXFEPKQWSuUzlzhD5cR4cQjzd575rMDNB8+vaOUczW6Gr+o0RlKV2+0nzyrA4iDFPKWQLIlEKc/hnOy3TrDUKzYKnkAyEIbHfR5nRCE5rLzVd+fXLDMjQ6P/Gv6eLBBxlg7/D1D1w96Gimh2LpS3H9QOMevFyq0ct+KG8Svuqg6eLVbqA7Ru435jXf3fzbHN+8enVRzGbf11LsLpFAp+LefOmw86QhoGrqDXG8YLcx6UPWeL4s/0OX7xcqsCDz7oHJLH7hd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdioCon70PuUezzxLROIeTJwV/awMUSpnt0xTZfqOKM=;
 b=ZZy1gXMzc+j4l7P41oftO8H78JD+bOg2wBZljjjJqg8GG3+MSA548Fha7qtt4hNfa+PJnqS4SMR61Q8mTxF8YL52bG5mpAK6f2t8fgirw3MvyC6NNnIksRQdVxlXln6sHef/r9kmddXuFsRBj1LhCR22GGIYXmzDGnXEz+Fsdz4CBXoTedhvPdXNdyJrQoLl0QyepXxrkXc7mE6tL7nBoQ7YyL8vHKir6DaIJwtmfWeJyQMfBazAQW2GCf9duLZQ8qn3AcbI14cecvl/5zYoVBPg/F4CDofhNT3m/xOkVsJ3RM+NSekJR35PRy1yL1nH7cOLfSpGJFB74Hwn/H35xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 03:18:21 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:18:21 +0000
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
Subject: [PATCH v2 net-next 1/7] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Date: Sat,  8 Aug 2026 11:21:40 +0800
Message-Id: <20260808032146.2335723-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 646b52ee-49c1-4d1b-d487-08def4fbb2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|19092799006|18002099003|22082099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	9uXSOGpPjkeCUdeiPeJOUXCFJDgdsODVFk8OxftF0RDj0Tu5YkhiOmJ1EnbxLNSoyL4Zo3MfozcuMaHncA8VMaDyHnTu7MnjN2XsV/v5atSNvBHLB7rIYE6fSVzTu+uRjSTkVZe1rZqGA5H5/1OHLJvohZT9UPkbUXWQqGJkFHP5oyJm7HTR87Hi8Ehqr30HiIRZAko5basAXx6jDthpf8zkMHFTmRFc3iO/ImNwzggD1jfeyEJmKc5g7qLocdM4tgYLHqLn9d996wSaUsLYkF/stTqeTpXxfecmMHhvzckbTg8OfitnP5xU+MhPlnfiZYGIjAddpEqa2vfBPIDso6HH1CCPQscqibIYcdv7FPk/MsOXE7NyMupFKOSNdAeD70MuHMXLK+KBYtyR1yPlVU32/V+nsqZ3Nvt9gBi4k5mGJD3oGH4HEmkwQ5Yiq2wu2ywptoH2eAdots+3/l1zr33GdYYW1kDZzV3B7ruFDjry0UNFcbVpmS46gd/Tw3ujPPH1azKx5pZuxV/YEWn9P3Z6BKl7CWpvs6e5hrpzgdjnU898d7W2PFS7dMOK/gf9JwR2aSHdVoEPOLKTePKWywOk8KsMbNBWqsNuNSfXD2Wjg7/mCHkTT5HswyPIdThMbjqH6vmBMLfUF37pLFUi0495tRRtPS4d/Oej9xSestONr6lVQ9XM/3fATux6plUKpXwthKoPR5SMsm433E4/Lw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KxoCwxNIPyfSt7Rt3a0QBXN385ByDM4nyaTXE5U7h03n4OFAyVR2FXU9SCOa?=
 =?us-ascii?Q?zf9WyA+sM669kA18ITp6pXbFIAkUQhF5hLBDxxhJQeoGzSw9K+zTrNUONDrh?=
 =?us-ascii?Q?lfntBYIOWq4elvOOjFKLfqazKxyGwyAfx90FDqPp/41ZWkx/2CO+beiKvEkz?=
 =?us-ascii?Q?SThZKQP16+SdJUAfvRwu4lIPqJjHTxpydjeuIKojaAMm6ZkWsECyIZ4KyqSh?=
 =?us-ascii?Q?FDZA3YvoMn1BPZlt9q8SUuc5mgbndmFbrfHXfTg144F61nTMZ+jbCYNEv8HH?=
 =?us-ascii?Q?kSZ6Y66FKlZYc3w9vbjOJrG4O71Qo5x4KGTDHVjZtwJEL8knYNeC47pZ7B1R?=
 =?us-ascii?Q?/00AdICZgw1jvcsXJQXKdXEeC+PB4bK5nvaKN+TDBE3GzXmNXpdtRFabsAyR?=
 =?us-ascii?Q?AKZX3n21jo1VuOvli6KDwFK+LM7s07BE8BCFHlP7lmudGd4w1NgR8eHNOzsy?=
 =?us-ascii?Q?fOUeSp0CHXYfaX2+aQHgpG3BsmCCdl0figCzmo57EhZSN6I4tyTZirDKZYxR?=
 =?us-ascii?Q?ysEmCKDlZuuxd+eQS7N6wYNJZbaBCaU+Yjh4mkdQSDn95TuYSD3Wtw3lKZND?=
 =?us-ascii?Q?tU3YmN+GmJKTZq/QGkufKjm05bihk/K3W2kTlaDwRZC5yfupPmPmhJWBbW0/?=
 =?us-ascii?Q?KIcoeebyN1hZcwkpGtyi9E1fgN3xBczh78SXNrItL56x2XEw/TyPCw7Vhh/4?=
 =?us-ascii?Q?3jCjxeEft8dYNvqxAOzZ/rC+9jJAHEZyMDQUk0sYGWUomU7qCyLiovxf+0do?=
 =?us-ascii?Q?ieIVUksGhSbhgxYTVX9LvfJ8sZZznNSMGFnHVzoAA3bxCL7B052iyfhud1JF?=
 =?us-ascii?Q?vh1vpuab0G+2JEzd7bR3mToVBJrkzYJfpuY5qjonRaaBi2zOn4xejwXyAI5g?=
 =?us-ascii?Q?JEGBQRcXSKqpun9BtkwAG3vg1EzTHVlICs+dD1i1I0iit1qZ8MMaMWlJAMma?=
 =?us-ascii?Q?MALr2utOHdpCm6d8ttW2ZlVsWcGWmnet51AdHgc1Kc8Ax0ceoUXDxKsM4aTM?=
 =?us-ascii?Q?oKtK+qOHWpLeSwAcb4jFYfGJlQXM6sbqDlwGDKgX2mLItZ66MPyF2phSBbQq?=
 =?us-ascii?Q?psAEBJ6PypmPFWEPUDfPEPwozkheQZI2+sdW9AUy8OR9mgSNAZlzRRWeEPCZ?=
 =?us-ascii?Q?esF9t/jCJBJNgOyEdnC1KcJ53cyhLQFRZ42pqEtzuZHL5a+L5d/qy3pQBha4?=
 =?us-ascii?Q?IFWkcd7iwUl4N2VrqssBLIcDQR8eYGwp2uKzxxfUZb/xrYxZjO0V/a7+M9QB?=
 =?us-ascii?Q?QV7VxeGVHzN8jqoo4hi+MlJKI6qpX0CdN5vpMQW3JtPN4gDRAhxWuLnjxwrW?=
 =?us-ascii?Q?HSbW82FPD9SK8Osh14q1tC7ttsAamTFRYYZJtHChHcqHaZXUIH6NUNKqGICs?=
 =?us-ascii?Q?8iDNvvy9KicfHcUA8Rnw+l6sqiKy7t0I73R+ZeWlc1k+hs0DkX+S/z3uNbQn?=
 =?us-ascii?Q?+mbt5eqfQU80iAiP6mnF7YiBkwVQgmmeGWC+gTLry/0RKuy+VA8EM4HhSrm8?=
 =?us-ascii?Q?8pZvQmjElpsunnH08LWZgeunGFwXMjDYLSBe44XOy/ni0ezKwYYN+zFCLJu0?=
 =?us-ascii?Q?PblCzTwCoPieoKQpJyRWK/zV1TUYjV4LADb1pfTzafikx/LmJ+ULyYWX7BHS?=
 =?us-ascii?Q?a0AWCTrdbxG366LdKmfoZHwIEjnb3HTUIsKE+TPat75LbegQt8ECpd5qI70a?=
 =?us-ascii?Q?Q12Bpqz9nWqWHc8zsoZHl6/G43GXiVTL8hrQXXcAtgaT2oMpEKp5CpOgV36i?=
 =?us-ascii?Q?mqb/TeS5UdW14UW6j2q9zQYPBBGyqGUWaI0Q9PcKx7sNP4M0QZKr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646b52ee-49c1-4d1b-d487-08def4fbb2ee
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:18:21.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFPv9hWgfXXVuQcECiAGMN/NE0Mu8sdKFxEReBVJ9vLo121ztVr6FzVxRqMGADYcM4IqwW8zHgeeFvHKIs+bBvU5Qtj56hCFpXA7TJas6aSQYroK4MaWHjBMPCeBlwGD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded 64-bit register read/write sequences with
ioread64_lo_hi() and iowrite64_lo_hi() helpers. Introduce two new macros
netc_timer_rd64() and netc_timer_wr64() that wrap these helpers and use
them throughout the driver. This reduces boilerplate and makes the intent
of each operation clearer.

The high-half register defines (NETC_TMR_*_H) are kept to document the
register map; they are not used directly since netc_timer_rd/wr64()
address the 64-bit register pair via the low-half offset, relying on the
hardware layout where H is always at L + 4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 72 ++++++++++++------------------------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 1c20d7efab92..0e0972596d88 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -127,6 +127,17 @@ struct netc_timer {
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+
+/* The 64-bit timer registers consist of a low (L) and high (H) register pair.
+ * Hardware requires a strict access order: for writes, TMR_xxx_L must be
+ * written first, which latches the value into a shadow register; the write
+ * to TMR_xxx_H then atomically transfers both shadow registers into the live
+ * counter. For reads, TMR_xxx_L must be read first to capture a coherent
+ * snapshot. iowrite64_lo_hi() and ioread64_lo_hi() enforce this L-before-H
+ * ordering.
+ */
+#define netc_timer_rd64(p, o)		ioread64_lo_hi((p)->base + (o))
+#define netc_timer_wr64(p, o, v)	iowrite64_lo_hi(v, (p)->base + (o))
 #define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
 
 static const char *const timer_clk_src[] = {
@@ -136,66 +147,28 @@ static const char *const timer_clk_src[] = {
 
 static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
 {
-	u32 tmr_cnt_h = upper_32_bits(ns);
-	u32 tmr_cnt_l = lower_32_bits(ns);
-
-	/* Writes to the TMR_CNT_L register copies the written value
-	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
-	 * register copies the values written into the shadow TMR_CNT_H
-	 * register. Contents of the shadow registers are copied into
-	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
-	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
-	 * register first. Other H/L registers should have the same
-	 * behavior.
-	 */
-	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
-	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+	netc_timer_wr64(priv, NETC_TMR_CNT_L, ns);
 }
 
 static u64 netc_timer_offset_read(struct netc_timer *priv)
 {
-	u32 tmr_off_l, tmr_off_h;
-	u64 offset;
-
-	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
-	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
-	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
-
-	return offset;
+	return netc_timer_rd64(priv, NETC_TMR_OFF_L);
 }
 
 static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
 {
-	u32 tmr_off_h = upper_32_bits(offset);
-	u32 tmr_off_l = lower_32_bits(offset);
-
-	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
-	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+	netc_timer_wr64(priv, NETC_TMR_OFF_L, offset);
 }
 
 static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 {
-	u32 time_h, time_l;
-	u64 ns;
-
-	/* The user should read NETC_TMR_CUR_TIME_L first to
-	 * get correct current time.
-	 */
-	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
-	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
-	ns = (u64)time_h << 32 | time_l;
-
-	return ns;
+	return netc_timer_rd64(priv, NETC_TMR_CUR_TIME_L);
 }
 
 static void netc_timer_alarm_write(struct netc_timer *priv,
 				   u64 alarm, int index)
 {
-	u32 alarm_h = upper_32_bits(alarm);
-	u32 alarm_l = lower_32_bits(alarm);
-
-	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
-	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+	netc_timer_wr64(priv, NETC_TMR_ALARM_L(index), alarm);
 }
 
 static u32 netc_timer_get_integral_period(struct netc_timer *priv)
@@ -497,22 +470,19 @@ static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
 					 bool update_event)
 {
 	struct ptp_clock_event event;
-	u32 etts_l = 0, etts_h = 0;
+	u64 etts = 0;
 
-	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
-		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
-		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
-	}
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index))
+		etts = netc_timer_rd64(priv, NETC_TMR_ETTS_L(index));
 
 	/* Invalid time stamp */
-	if (!etts_l && !etts_h)
+	if (!etts)
 		return;
 
 	if (update_event) {
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = index;
-		event.timestamp = (u64)etts_h << 32;
-		event.timestamp |= etts_l;
+		event.timestamp = etts;
 		ptp_clock_event(priv->clock, &event);
 	}
 }
-- 
2.34.1


