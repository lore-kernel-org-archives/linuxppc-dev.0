Return-Path: <linuxppc-dev+bounces-23687-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C19C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:47:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZbw0XQzz3c1C;
	Tue, 07 Jul 2026 18:47:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414044;
	cv=pass; b=GNEqvVMFrviTIuhTfksU8W2M0EELodNWAO5E1k69klPYrErfwgusidiOnhRPgBB4w+A0yis725ZJ39N5PMwvNQ78OHm0bRKxyL8aQTaYYrDxwiHbGE3X1dL5SWd6cFPvESZ/EYQTgEGV0c9wlORSP5f9dYxbyD8p0M5Vkka9x465t3sl79XwE3VOkufBXWnDYuKWEccYa8K0lDwV54pG+n2uSJhtB70V6rqr2EAucfR2lccbLr6G0T0edzHMxxZJwJPKI3+/tM0ornpdwRgQhezDi4Jmpe0qilS/Tl9nqIlly5VUF81lGUsfp12hbWa762tTvfBqj15f9QU2VupqiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414044; c=relaxed/relaxed;
	bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MrbigPSvLDF09xai8ZZVp7R2GCJTZ9oYGEUlej49atccgM1d3CBR6DWRwIr1N5K0FSvTjFE/Pv/qoj6EwRxqM/9+HeXbNCpv0dbK7KTjTiIq+beLwcUXPimwhrPl+w8MNKGkD4SmJc6Vz3Pi+JYFkPLdLF2yMPVR/Z0prYH3EeHfIaCcAxQIsfzDs+WPuzGU42VLNQQaZnJAltXTXH8QJ3cSADDB2r9OlC2ydzZMeVv/Wq7X87I+oBWrn2x5jxD08ICCUmC5nASaGZ5QeZ/l2Wp7OnNQaOd8EXp4GULsmoJcK9/J3tlXz/qDZEnHy96/0mSr/u7amvmSYVGFZOJY5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=w0c2zxl7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=w0c2zxl7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZbv0hCBz3c01
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glAEf0TBfiD0hu58PgWR5Z47osR9BqEFWYEmqL6EWhPkCLryyH5pb4BnIZm8QESI3wYKS5GJdxkwPb5xFurYOFXguSRNY+h7kufuW0QNIqSJWL9LM4QrKx7qenOBlWnqB1TZ8sca+UF5PT2DDaN1Cp+VHKagzSLmRSmYk7cb8xI9PviCYZIGNjvAZsLdWacgM+cvWFcgrus54wsFUrDL0wpre4IaSlhVVwAiOvl6pPopbSlInJC4NX+rY9wMfjI9MNwRdxkwLkWexWzp2JQzLPvP0kfxFRnEkjnjVt+b/CA38RWVKpeBf0uGYBS8nGzrQAcfx/J1oX1ER+XKxbO5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
 b=QjttU5FYsrtG07jcSjNObf5yLMmJcRUTxp5xzNeU77ZUd8zIXYgGfdjCaqEiDgYNZPnVmjvswuxG5d3U07ipeY1D4UbCWr786P0+/ROkQspseU0VyFkEsS5V2DzaVKICwwvmCCSMl1tbWGO7CXKeNSZ5SWoWaqhEwyuN0r2XPIdWL1YxLi5bQuexVqvNmOgquhy8bnMxRl1Yd3vSb/cVKnrbuhKb5bMRi0enruuNKtUhQutcLiUUDC4d/5rMdaS0E5mR9Bu+LS5o66BBmpffD79JUsGYFSEnlX1/DFEOjQ9zfyi6UPf3ITIfBmQ9M8zqhUg8J8tKhYB1R+U77g9xYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
 b=w0c2zxl7t/q0KpdnrmW7eMnJRHDpo0HYOkK1cclnQSzgxz+iZVEYlkXt5LOko/nAPoZ2eDPrLNRZ3c5FUaAHoWId7JzMY9FDHWfJP4d8uY5XnCQcNtsP15QWb+Tg/od5G6XZu+ZTalvhu9W6FBs+RLPK/Hz3bGnSQxbhUYHWa/3Eoai4k/YZH7xyCGcLkGDJZ9oKW29qnVJzYPj2iY0Ee4BjD55dDxMg5mbIfgbymTF2aEU6uorWaaU9kXUrJjFE5PUILMAWwWhkNh+9vl4KFpsjfZqiQQ9dagZwFA0nNLO1bWZBw1irc9FWl1P5lszkBt9WncaVZgkl5zhUnTVTrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:17 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:17 +0000
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
Subject: [PATCH v4 net-next 04/14] net: enetc: improve MAFT entry management with bitmap tracking
Date: Tue,  7 Jul 2026 16:18:24 +0800
Message-Id: <20260707081834.710730-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 8012c216-090a-4d25-d8f1-08dedc045936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|11063799006|6133799003|22082099003|20052099010|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Fpl960NXkfFYQVo39QVorgSOYu8RkBz+SECveuYNtgNfUhbLG8DNQ0fblIoh4rjX7BGd2DNad1Mx0iJO8yVJ6MaNoamyb0cwUOx+ndEJFepp0QLUO23u8eTR75QeVRp10rA4ZBuPiq6fwQX3pUMrP1gk5TPjAB1f7ZKM14HAjKAcAJHr9JYabrky9jd4T1nFm7qUpIskMl7nX7rRhaPi6shdy0JF7t6G5cQcE57M971fIgR83LiqWb1ap6f5zgqi/uR4ExmWJkmf5UqwyU1ixdWumKeI+44U80pAbkLg9GlYbGAKQYNag5i3YwzKEp3BsLVuVkmy0WSHSPUM83cUSJEn371Z0SIzlE65nhESKAztDLWwX0ojn7g1gGqaw9bWFTyMR8RfDN8iYGczv4FpHlW+oicLdE6RdibEKBF52VFOqdQQQcjLacPTIJXkf+981E6q2838WKsQznIAw06sXdJsvjgfgcUbyMNjTYFtZbYtFEvX1uPWafO+dHyUPhw4y2UT2dNo7pQRFdSDAiRi9IsecCv4WU+jFGegeJJpU6px2IwCECwpx3AX/9hztkt3Wqw7Emj7iFbgyC7zp//QTb+5SbxMm5mtM/3rM/EusVzGHvhruHHOTF/rHubmnkN0rRXRlz2XORQiRuub8mYS3pcPJEa96WHSoAAiyT4JF+1MYvx3Mn3TaZe0vvMSWCuoKwAkUMPfssLEqvOWUgm8Rw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(11063799006)(6133799003)(22082099003)(20052099010)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Amc0YC2YVcvuIytUkaQ+UpDdez2eMRPKYYLTs5Add0OxCB1Fvbg94AuTTR+G?=
 =?us-ascii?Q?YEFK4oXPwuc3HybX5CeWfkyossSG8XRT9bKlcm63bIwVTpMP8MqsVZSvJRBY?=
 =?us-ascii?Q?/vC5zXDXSpqyasJ0kZj/tvBKyrihYt4IfFoMHJenQeq93xutdTbAc2kuHh8t?=
 =?us-ascii?Q?1UR8zv586twMQyBovi+8WMdrwZCoFr6551FwFH1ASFFkVW50rm9DJxWLbhAU?=
 =?us-ascii?Q?cutjdBUzalZFvaAW00KhJX9WXbsbNgP+PEdLK6Geu1dAS55Ec0nZFJO3DUWY?=
 =?us-ascii?Q?gCDeqNVRHSsG/Uu2SIQzWmjV8wEbCn6ZP/3trhDKQUl6eORwtE09ZjnnSVJz?=
 =?us-ascii?Q?lOwLA2lZGiZJr6pDEg2e8ItZHTjxVzxlSFM80iI5UbtY3ksSBvri7CZfXTGz?=
 =?us-ascii?Q?kaZGWxG1/P9R7kScxSdwYQboCGDQq6CVawEYMHxAhLGpaArubGr1KwpNN6d5?=
 =?us-ascii?Q?lgBjSNVhlYHbJfQL1XBWR8w0jhkkPFbgfn3ud/IY3oT2btCG5bTnvdtnTu0u?=
 =?us-ascii?Q?rBTo3kcUvijLH65NotgibmBL9mVAe9Gk7SzoHRhOmgt5IErVoWwkFzTlhEXz?=
 =?us-ascii?Q?IxT8AaumaHKuVnP5X04tpgUatV4OKsIME2vsK8SywxomFfjHjquwhi37h9ys?=
 =?us-ascii?Q?zWJRlTbaDUN+N8KdkQOhGixHSHeEQYk8Vgc8VohKEXBP12dAiPWvEndGcJRT?=
 =?us-ascii?Q?5LYGF4Ijx1Cd7OwyCcIiKiGIQip58ZvL6NLMLj7zGSu3QZj4OCGk/iRpgYoB?=
 =?us-ascii?Q?kFVwbRz6OS+ZYN8jvqIwJoAVKSXMYbLNJiDBiON2dumu4fTCxMoZf+BbgIhE?=
 =?us-ascii?Q?qi/rKMsn4nWAApm5k0HohGF3snoWJaYp5JFh3snsBT1fUNqRFhDUK9MMZKPU?=
 =?us-ascii?Q?J83peBaLNSlqm9Bdhzqqo/QR8/re8u7IwpXo2Bg3+48hfZl1yYmhRQMSlJ/p?=
 =?us-ascii?Q?mx7Ah4YKC/mENBgH9uREZbzWozdoWPRkmBD3CUJ4GPxbPkWWdwm0ArVXuoAH?=
 =?us-ascii?Q?5EeAtTlEt4e6wcMRShsJZvwGnYPgOMfd9Z4V/48DWLQezV/0VwxPonO+bgIH?=
 =?us-ascii?Q?oPcAgYR7XQlC3XDLIl4JgT6LVJvlK0jV1Z172IW/786stk79BOYmpO6hShso?=
 =?us-ascii?Q?Ub7Eyjpmq+vc5bgOcLAh82qYcm+cemB95J9ZIka/6D/dZMLB+niwUm1vL/jN?=
 =?us-ascii?Q?pcunPn9d5JMibRcWcYQGH6CoytWQTydfNaXv8Toqk9eba1CltiZsqg1nJ3QA?=
 =?us-ascii?Q?SouuXzCVzKQ1DhSuYU7ShDwZbuQWeGO0sSDDlastfPHEQvaaVQC1ffrWqDTJ?=
 =?us-ascii?Q?5HOShmL28VONpVv74dfYD6oNm8gwISxq3Q7dvDXZTHVqRrWGknbBXh/VFNxQ?=
 =?us-ascii?Q?x872sdoqeoQ2yc69ahyONJTtpMiqUQf2Er2AGrDgVWiJPkdxB1o+jrgVEx65?=
 =?us-ascii?Q?msTVQrVTHzcQov9jKGh0wNHnXCQEZnHsNarECoFzFpliIZKA5uVfVIEkkuWR?=
 =?us-ascii?Q?R80YhzDa0fo6vzAnjHe8/tsV0gdg4ECxz3YZY9YOzRzPor9Ca3+2BV+8jUfP?=
 =?us-ascii?Q?v6FHi2EN8t3MWnnQeqFSnIsI1/8WebWBtFfdOf95X4FA9UZeKo6Kp/HMtq81?=
 =?us-ascii?Q?y6GJ8euuyrpgGaikNtyi1SrfIoxjEMqinIc6bvaw5CQW2NIZIGJF/da4X2R8?=
 =?us-ascii?Q?afMOjo6aF5fjxjBUE5bOqC6rpir7oP61R9yZfHrScQASeeLuHfgDPGOY6+j+?=
 =?us-ascii?Q?IsUp5Vr/ZT//KjIoopADQNJKrl6n6zUnX1YwDR2tdHKQC+3pO3fg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8012c216-090a-4d25-d8f1-08dedc045936
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:17.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nb6K4z6ty0J9aXltRgwxgd/0xYYT1xlK0wyDtKCXG3V8Pmb0D7oiyuLZdjHBRBLgyy+Pl0nfwGTJqM6Kh59FAEO0Wle/D3FX7fDLHNPyM38P6eUa9lgWg6nJCrMG4Y4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

From: Wei Fang <wei.fang@nxp.com>

Replace the counter-based MAFT entry tracking (num_mfe/mac_filter_num)
with a bitmap (maft_eid_bitmap) stored in struct ntmp_user, which is a
more appropriate place for NTMP resource management.

The bitmap approach brings two improvements. First, the entry deletion
in enetc4_pf_clear_maft_entries() now checks the return value of
ntmp_maft_delete_entry() and only clears the corresponding bit on
success, keeping hardware and software state in sync. Previously, the
counter was reset unconditionally regardless of whether the hardware
deletion actually succeeded.

Second, entry allocation in enetc4_pf_add_maft_entries() uses
ntmp_lookup_free_eid() to find available IDs dynamically, with an
upfront capacity check via bitmap_weight() to avoid partial failures.

The MAFT entry count is moved into ntmp_user.maft_num_entries and
initialized once during enetc4_init_ntmp_user(). Helper functions
enetc4_ntmp_bitmap_init() and enetc4_ntmp_bitmap_free() manage the
bitmap lifetime. The debugfs show function is updated accordingly to
iterate over set bits under rtnl_lock().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 30 ++++--
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 97 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 -
 include/linux/fsl/ntmp.h                      |  2 +
 4 files changed, 96 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 1b1591dce73d..4a769d9e5679 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -31,9 +31,11 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	struct enetc_si *si = s->private;
 	struct enetc_hw *hw = &si->hw;
 	struct maft_entry_data maft;
+	struct ntmp_user *user;
 	struct enetc_pf *pf;
-	int i, err, num_si;
-	u32 val;
+	u32 val, entry_id;
+	int i, num_si;
+	int err = 0;
 
 	pf = enetc_si_priv(si);
 	num_si = pf->caps.num_vsi + 1;
@@ -50,22 +52,30 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
-	if (!pf->num_mfe)
-		return 0;
+	user = &si->ntmp_user;
+	rtnl_lock();
+
+	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
+		goto unlock_rtnl;
 
 	/* MAC address filter table */
 	seq_puts(s, "MAC address filter table\n");
-	for (i = 0; i < pf->num_mfe; i++) {
+	for_each_set_bit(entry_id, user->maft_eid_bitmap,
+			 user->maft_num_entries) {
 		memset(&maft, 0, sizeof(maft));
-		err = ntmp_maft_query_entry(&si->ntmp_user, i, &maft);
+		err = ntmp_maft_query_entry(user, entry_id, &maft);
 		if (err)
-			return err;
+			goto unlock_rtnl;
 
-		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n", i,
-			   maft.keye.mac_addr, le16_to_cpu(maft.cfge.si_bitmap));
+		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n",
+			   entry_id, maft.keye.mac_addr,
+			   le16_to_cpu(maft.cfge.si_bitmap));
 	}
 
-	return 0;
+unlock_rtnl:
+	rtnl_unlock();
+
+	return err;
 }
 DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index a02b01753ff2..b966637572a7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -32,9 +32,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 
 	val = enetc_port_rd(hw, ENETC4_PMCAPR);
 	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
-
-	val = enetc_port_rd(hw, ENETC4_PSIMAFCAPR);
-	pf->caps.mac_filter_num = val & PSIMAFCAPR_NUM_MAC_AFTE;
 }
 
 static void enetc4_get_psi_hw_features(struct enetc_si *si)
@@ -92,31 +89,45 @@ static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 
 static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 {
-	int i;
+	struct ntmp_user *user = &pf->si->ntmp_user;
+	u32 entry_id;
 
-	for (i = 0; i < pf->num_mfe; i++)
-		ntmp_maft_delete_entry(&pf->si->ntmp_user, i);
-
-	pf->num_mfe = 0;
+	for_each_set_bit(entry_id, user->maft_eid_bitmap,
+			 user->maft_num_entries) {
+		if (!ntmp_maft_delete_entry(user, entry_id))
+			ntmp_clear_eid_bitmap(user->maft_eid_bitmap, entry_id);
+	}
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 				      struct netdev_hw_addr_list *uc)
 {
+	struct ntmp_user *user = &pf->si->ntmp_user;
+	int mac_cnt = netdev_hw_addr_list_count(uc);
 	struct maft_entry_data maft = {};
 	struct netdev_hw_addr *ha;
+	u32 available_entries;
 	u16 si_bit = BIT(0);
+	u32 entry_id;
 	int err;
 
+	available_entries = user->maft_num_entries -
+			    bitmap_weight(user->maft_eid_bitmap,
+					  user->maft_num_entries);
+
+	if (mac_cnt > available_entries)
+		return -ENOSPC;
+
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
 	netdev_hw_addr_list_for_each(ha, uc) {
+		entry_id = ntmp_lookup_free_eid(user->maft_eid_bitmap,
+						user->maft_num_entries);
 		ether_addr_copy(maft.keye.mac_addr, ha->addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
-					  &maft);
-		if (unlikely(err))
+		err = ntmp_maft_add_entry(user, entry_id, &maft);
+		if (unlikely(err)) {
+			ntmp_clear_eid_bitmap(user->maft_eid_bitmap, entry_id);
 			goto clear_maft_entries;
-
-		pf->num_mfe++;
+		}
 	}
 
 	return 0;
@@ -146,10 +157,10 @@ static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
 static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 					 struct netdev_hw_addr_list *uc)
 {
-	int mac_cnt = netdev_hw_addr_list_count(uc);
 	struct enetc_si *si = pf->si;
+	int err;
 
-	if (!mac_cnt) {
+	if (netdev_hw_addr_list_empty(uc)) {
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -157,21 +168,19 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 		return 0;
 	}
 
-	if (mac_cnt > pf->caps.mac_filter_num)
-		return -ENOSPC;
-
-	/* Set temporary unicast hash filters in case of Rx loss when
+	/* Set temporary unicast hash filter in case of Rx loss when
 	 * updating MAC address filter table
 	 */
 	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+	err = enetc4_pf_add_maft_entries(pf, uc);
+	if (!err) {
 		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 	}
 
-	return 0;
+	return err;
 }
 
 static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
@@ -393,18 +402,60 @@ static void enetc4_configure_port(struct enetc_pf *pf)
 	enetc_set_default_rss_key(pf);
 }
 
+static void enetc4_get_ntmp_caps(struct enetc_si *si)
+{
+	struct ntmp_user *user = &si->ntmp_user;
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_PSIMAFCAPR);
+	user->maft_num_entries = FIELD_GET(PSIMAFCAPR_NUM_MAC_AFTE, val);
+}
+
+static int enetc4_ntmp_bitmap_init(struct ntmp_user *user)
+{
+	user->maft_eid_bitmap = bitmap_zalloc(user->maft_num_entries,
+					      GFP_KERNEL);
+	if (!user->maft_eid_bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void enetc4_ntmp_bitmap_free(struct ntmp_user *user)
+{
+	bitmap_free(user->maft_eid_bitmap);
+	user->maft_eid_bitmap = NULL;
+}
+
 static int enetc4_init_ntmp_user(struct enetc_si *si)
 {
 	struct ntmp_user *user = &si->ntmp_user;
+	int err;
 
 	/* For ENETC 4.1, all table versions are 0 */
 	memset(&user->tbl, 0, sizeof(user->tbl));
 
-	return enetc4_setup_cbdr(si);
+	err = enetc4_setup_cbdr(si);
+	if (err)
+		return err;
+
+	enetc4_get_ntmp_caps(si);
+	err = enetc4_ntmp_bitmap_init(user);
+	if (err)
+		goto teardown_cbdr;
+
+	return 0;
+
+teardown_cbdr:
+	enetc4_teardown_cbdr(si);
+
+	return err;
 }
 
 static void enetc4_free_ntmp_user(struct enetc_si *si)
 {
+	enetc4_ntmp_bitmap_free(&si->ntmp_user);
 	enetc4_teardown_cbdr(si);
 }
 
@@ -422,7 +473,7 @@ static int enetc4_pf_init(struct enetc_pf *pf)
 
 	err = enetc4_init_ntmp_user(pf->si);
 	if (err) {
-		dev_err(dev, "Failed to init CBDR\n");
+		dev_err(dev, "Failed to init NTMP user\n");
 		return err;
 	}
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 285b7e5c48fd..6f15f9ea1664 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -22,7 +22,6 @@ struct enetc_port_caps {
 	int num_msix;
 	int num_rx_bdr;
 	int num_tx_bdr;
-	int mac_filter_num;
 };
 
 struct enetc_pf;
@@ -60,8 +59,6 @@ struct enetc_pf {
 
 	struct enetc_port_caps caps;
 	const struct enetc_pf_ops *ops;
-
-	int num_mfe;	/* number of mac address filter table entries */
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index d3b6c476b91a..764ef2892608 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -75,8 +75,10 @@ struct ntmp_user {
 	/* NTMP table bitmaps for resource management */
 	u32 ett_bitmap_size;
 	u32 ect_bitmap_size;
+	u16 maft_num_entries;
 	unsigned long *ett_gid_bitmap; /* only valid for switch */
 	unsigned long *ect_gid_bitmap; /* only valid for switch */
+	unsigned long *maft_eid_bitmap; /* only valid for ENETC */
 };
 
 struct maft_entry_data {
-- 
2.34.1


