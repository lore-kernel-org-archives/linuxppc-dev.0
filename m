Return-Path: <linuxppc-dev+bounces-27672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D39C88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:25:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPKM1t3cz2xYh;
	Fri, 18 Sep 2026 17:25:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789716311;
	cv=pass; b=EZQZsSdzbYMNanX1Xsj2JBO5tle1v1ACKK0KF9WoC7YKCI9cIsSrhcA2tgk8Zj0P9ZWjJZfY2ArPiiYmTlnbE5QDDiOEQsuSm2NtigbUNaLPDi+EMaBJaV0lx5Y99OZy0ltZmtpuxf7vlv7zc7WYeY6zGh1ayIVVjX7l8+E4FBTuy/nSRWLi6AgipiuG7cYlst2zHVhhrd22MAf6mZhb06Ct7gcTIh3OQoLl0Ounh2LrSPeC4P6K1mFH4il/BS+1T+hFHRKLzx8CKAO6u7Y9oLHE+6gmxaY+gu8d6QpyIDVpkJrmMK0x9chXMo6sIy+NSH7gEfW8tQBOOzyE4PynVA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789716311; c=relaxed/relaxed;
	bh=/1F1XUZsEvCOW7bQdCdNh5B86sIPtyCvmSruztoQPL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpiIDHD+kkPpZuxWcIRcQF70Vb269YSurJ9A54Q7Bx2LihzGk1cNGlLnmU/Um+Uzd6LssnjW2TbayO9mHaZLpLx8qjupJ0CKB5R0QHGwWK/yVvX3T7MIRXwjxBzR8kbeWHUVzESmuI/1ofGtaBuMb9pJxwbJyhoi+0d07eqK7d119/dUzwPsSrb2KmUt9wlIkzEuTIwKJ3uOSnxspDyoFKCfSvSeaUmQuQnORE4+kmS4fgUg4GUlBXW+PZ4ZA80gsxYayiZdHQrT80pmNupvUyqtZ63IaKstGsOxVsoHc4iQTZrCHXj3f3tw9YgD4vH0+dh9QVKhMj3ZUV89nDNohg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XabJ79nk; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XabJ79nk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPKK6y63z2yps
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:25:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8Vz1VUMhV/XxTJ4FDh+T3hAUiIaj5pa3VXtymWO8SwOMH+4Bzv6O5LjpvcH+oasZtD9eAQKljd038XVyjGjRY1sA1KB5SVUDqw0w2Y/rW+1P9F3LJrEpi6+PqrIFCmnUpHL5uztC8c8z5k5iCAF7tk7o56ISxo/JPnw3sj/5X9gFgjCvXJD5RUk5Af/oljKVMPnt0cC9sgdx4KihpJisZ0YpTmtnsxtxbX/2a5T2E7URPga4kX0eHiHCtl6dzfcQpDn8ToigBQ/3uwk0qkNqpKHt0i9oqLmg0Gic+S0OpZ8fWQZcT1p6HxFQIjWSCZ0Tu5JE5/Y+WL2+niDKiwDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1F1XUZsEvCOW7bQdCdNh5B86sIPtyCvmSruztoQPL4=;
 b=wgTBrBv/8U+Q/NMw2J8rBBQIkH46EZ4L+5t0C8MmURByLBVCIqlVWStCCAHqtJ2GGMTtueEbsubMGLry70eGKb6ZOU/1WZvsgCj1QnB3UHBLp33/u1XfrdoHpKMXKW9x+dhHubULKQdoP0R9Pchv8gsnj3NnSjF9JTmTcgRryYUeiyKEk9C1xCW046tBiQATaMVyp3f7FUenyAHN2X8RQJzvit0XGKbjYZE43BVCDLyeLQz18soizbThTxNBPLrLvJbuQHabStP5MxiXcswXkeSB6KHPOwD+L/eqPTWqvz71QNDsIrE7W0XfdwVcM25Bpfnb9CJqCd6mH0SFOIPN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1F1XUZsEvCOW7bQdCdNh5B86sIPtyCvmSruztoQPL4=;
 b=XabJ79nk/yZi1OUWRYcJ1a+pjaGKiW5dXp/Pplq5RxgUm7sdaSe0ufa/fyyS82UWoWEGLfKTaOUEO56rrv2NaPvhiyUDZ+EzxEXdR7AGVHqgjZkXB5TcHEEnYRCn+nBGS03RDrBcQg6FTS0r5T8OwB5FPTCtY+powdLWo1WUpvJvM8ICxsVOr4fKQurPfmJir2pWVQKiNkkKnKTRiOFKyGo1clEhPQPGhHtDkHaWqOM+xXnZnY0bqesltl8wTY8LywmnGQQJkHG73PXmuj/6selZ6RKzDGsP2e6euSoj0BhxIHtIhcu/si7GFCAcpQbO3xeM/dJCllM985TQ+Vx0dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 07:24:49 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:24:49 +0000
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
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 1/8] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Date: Fri, 18 Sep 2026 15:28:45 +0800
Message-Id: <20260918072852.501420-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918072852.501420-1-wei.fang@oss.nxp.com>
References: <20260918072852.501420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: bac80888-41bb-4d74-9fb1-08df1555ec30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xx74MVd7vFjpd6Qg04/dglXjoc+rYzd6VJZBfr0Za+iWS7Qmkwsv1Qlykp74N7B04Vp/uMedOQggj9BWF3jwSVC3QrMt1k1OsHbXgdLPUlys7qohRn7XZhmHBkv55VlWtYKogKKAGCiLSG3RZCFp1N3qNMsDxFdt17aB1vlC/xw38tD0x2TDeH/C4McLemtSARrhLlYY4AkmxbQ/Av8H9y7txoJnrXkAXRibDnYJ+hFQlvxtc+NA4WvfL2aVN/jOhRHgz2rpfpoM4kouq+cS52xRFI4Ug1qAd/VZC9d4xA1TL9UZIB9IMZEn9q6JRjoJeX97SVyBvHt4Qo1tR/qFvbmOSZDcAwlJarsgyFJD8nUCGFTpdWu89bFfKBVnaxPOrs4iSJffMfJBFeXYIVDcW08SjOqIN6KOXPDwVEggJ4HwzDOvyZv2fWZAsAbY9R7yGfxRUFzb1fs7C8x3XRXNXVEwWB2LhVQpdRErgzb1AhMGv/VaLUM3HYJJpa7PEL+CG7tfZs1ExHMr2rLI1GBYY+hnG5i3vJmkpi+GW2sQN/KAOPq3z2fvhS5PPa1JWitdAStQDx1GT5R85czc43bFXMfnD+50HmdwrCIMC9XHZ12mB+MH9hSuc0wVQbCbVUAMKO/C4/3xxOWOc4vkj/qM+AYwiE99VI4sQdO6w/tLu1WFxUmDbTqFDkY2CdDyg2zMFuAhTFS6J7EXYEBzF7W1jA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yx+eNxyWh+5oIXP0FnSxASdmgQg4LINWuiCpH7sLM/FSzoJsT05zkQKrZloF?=
 =?us-ascii?Q?/NzLvcV1moVXLkpeoJfPoza8L6luGRmFrgjV2nCvvZyfbkQDaVAJagBoI/M/?=
 =?us-ascii?Q?5U82Px+/0aDKoufFpA8YdwOS8WlZ5Gkav684LUtcDdCs357E+BnIXT0Mfn3a?=
 =?us-ascii?Q?7qReB6eFt4OLY0Rr7/X0QjK8xPB353UrNGmNXNz/SteZyCa2FCqrqEs8JciJ?=
 =?us-ascii?Q?69nusgYEc6jgikuH8KruM/Zx4b5KTkwrUMKN1GbTCmOq/FY2e+INJ6muBRi1?=
 =?us-ascii?Q?o1Vm4lRe7CtyPU7g9RRIAqoKNb18Gsyweeu6nOMpFaz/tl2PpYIJ+LP+xX5V?=
 =?us-ascii?Q?aBSL1dEdrrUJuLLQl7vqBfb59/9iG1bgWNRoS6RKtIfHRrgqX9bC31U07Elk?=
 =?us-ascii?Q?aqkOvNwfLtdkEJtjwII6B8j3qf8Hksj428+vcNLvwih8HJYnhK/7VPgnfost?=
 =?us-ascii?Q?IpBj0O0J9xLsDzbavnAucC2X9FpmLXJy5QS+314VX1RM9alWmoTMNY7nEFmi?=
 =?us-ascii?Q?+4kqYiQLnERENX847GDYEG0mAfSYmBwK/+0KTetyvJNOS/thnR0aNmedUryY?=
 =?us-ascii?Q?NOdMy8RtG1mG6CSitLz4SebrEdd3ITv0I+fdHrj/a2edg+kKfnLmySMEYqsq?=
 =?us-ascii?Q?92awKMRiX6GhLQAtdZuia/willzqrNKJ2bWFN857fdEZKzDqdJxRmHHGaRTK?=
 =?us-ascii?Q?syow34xC27yk8NEW5us1orVfxOebpQ5fzlfJOwOpmNih649VFeprbj5GrY1r?=
 =?us-ascii?Q?TzR/PsmXcoNbwzi7SNVVErYt1y241fss66t4U5SWzn46K0/LbtfzUB1T/PeR?=
 =?us-ascii?Q?GS79Fk5pS1mpSdk5dFCVhL4J6USFUdfHE3JQbaM864k6V1F5VN4bIUttWl3T?=
 =?us-ascii?Q?EAcTtuWAethKIXn0CPgc5BXzpnBdw4eHk2U7KAaxQKOdqcg8f9miEqR+LIrJ?=
 =?us-ascii?Q?v4dWdUC2dDLaow9ht1Y3G6CuVXayVH4CF2gahbEVZjUhaamz21zAzpLzzzpV?=
 =?us-ascii?Q?irKei228DLKrDG/NtRnidbltvkitK/7daC70UEvkHYu8Rr+u8KDPWe8+Oa50?=
 =?us-ascii?Q?QkghdeuYGWUASJMeI3E0QtS+l58DYhEAl/X1HGQCzz5eJSy3lEbFuDgGp84U?=
 =?us-ascii?Q?nxOcC10BEBvxangXjQGoBDJyb/ohA3EqgPRTZaRXRihAbisJ/yiyISCRx6QY?=
 =?us-ascii?Q?ydr6UFv+W8PcN3582ZLujZP4e+cyI+3aC2kyGWmp0u4OPb9/5BbEXM0rNLYW?=
 =?us-ascii?Q?E4vtEANXaf/zYXrRqZkY5v2Y+/udFKggMLd34aSF3SwZWGJSSiBJvqBRgQSX?=
 =?us-ascii?Q?4QR06+WQEbmROpsUT6XiYLfV0tzvItr7LWK7DlC6U4MNOWFJVF70ISCAY1gH?=
 =?us-ascii?Q?qVV4Eqa2t/AOL+BSmt/4gdT3BOn8gBzoIzLpeNBjrUE6FBae0uTAk1B9f7tf?=
 =?us-ascii?Q?JcKlOvwTkj7WvpzUBoYpDRp0XsBq/vv0dkegz4e8j8FxW9L+C+8KsB3ntGkF?=
 =?us-ascii?Q?mWQHFPXEoYy7NYhuGQpBrLvt0waIkT66h+KONr6NOgkljBaloTkVLcR0KxgN?=
 =?us-ascii?Q?NJr0TquXx8GkmFBZO5bA85hNZi6oTLXMfhE4oPeaLuQyKyWbu/BhHsmL/Vmw?=
 =?us-ascii?Q?C/dJnI/x1LkFviTQIkF/adV/odfEZDqv95qtDWPJxlmFbMqi9htAZiAG+KZa?=
 =?us-ascii?Q?4voD8p2uwmImrfXR6N5TDvd8qtVGC6K1Bkm2SFmby6/Xe8zVxuZGfsdShRfk?=
 =?us-ascii?Q?5Q5PPIwfcPypaUCcg/4z3EXx7MjkPxvtzrU5A/krOqTZjEH5wUU/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac80888-41bb-4d74-9fb1-08df1555ec30
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:24:49.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcU7S4C3EA+dRbzp+NNz1mBQKJi1c+zNKhfQlnLJScRbGuHJ32Ul/U9pJSUVfdKe8dFJL2mOfUYZ46xze71CBjSSCuND8L0v2hzu3Ny1rC3OX1B0DofFlZDSr2ibqGDi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

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
index 19ca99d80e95..376b3b0d1a38 100644
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
@@ -500,22 +473,19 @@ static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
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


