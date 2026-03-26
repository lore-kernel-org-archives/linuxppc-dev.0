Return-Path: <linuxppc-dev+bounces-18807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DF5109E557
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:29:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDQ02W9vz2ykX;
	Thu, 26 Mar 2026 17:29:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506552;
	cv=pass; b=SCFW3RxNLnVa1xYsFIlyHcztZ5dj0PQ4iFo2ZP5Oyv+X6ARGTLjubzPDoFIdsl3sSvH37Danv7Ihg8BT0YhCvfq+1KwFIlPZA+xGR1nDPa9XJ+oWB6VGXidCLyYe1dxP1dwl5dSyq9jq8bXIzCgdUUfFhFU7ZCs3LdWpCvOrGt7Sv0SMsWQUxhIgycwm801sb25+nxDR+/YQyOgl7RXu0nsiopsD5cYuquOtgFkJPnwFgg2wikCB2t1MpPT095LF5+Wm5fTQdPp895VppP4akWZ3ms5rrUKKY3A37yPHa7+gIBHnsuEYF/MzP8UDmYRJyMLRvzuuSy8arY/j5hvsOg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506552; c=relaxed/relaxed;
	bh=xmHvBUmVU20yc5EpzfL97T4Jip0rZQBOGpCZeBwrrfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEnxijQLftb+LWBNGUC3/ZnzePzfkaamqEUVwjT7thE21/nhArrQuheNnCMAlq684nZ9zFJ9q6GETmiX9Bxt69Dzw7MXD5LW9sEqw25GWSNaFtse9lP8UBG8FKtRzDMawc6ZWRHLnhMkHeVJ5pCBd3MpNjw/b4gOtYBMd8n77qKUlibQaeE7nzs6ZilQsCWWQ0popnqfesvA0qUJz7TSYtjk/pQ1C6WUiyaYfZWfHCw8JX352vse5Duorl2pL9KYTIRxfthh1W34d3hb2dnmBNofZ1OtbF9day8ZJ4CnUAiBkA+pWzrc9ODDzfYxcd4GvgT7+/K/6MFyt44n65HaiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=mBLDHws7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=mBLDHws7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDPy5T6Mz2yVB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:29:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvDRD1S0qCWUeTmU3o1p0lN4sMZ0OcyVFw2pyrrtEWoqt7X+FKt2B/gOXO6sZ/Pj79C9Y/nn02whlfXzs2JNRkkzf2AfWqTj/TlNRW6jBJxd0xWcBfnERGxVjDJx5IU2NXm8kqqqaZ0nxp1JdQ+a3IEtP0ceGOinpyDGvwVNTQ3HgWTNPSjXGrrFQenUP6hnuNUDciiYq+zhhRTa4EoydvBJLJSkRykf28h5LeQFzB1HSyZqSd4xKjGA04F7IzU19MEdxmfGDgXlxlwv1utDNTUm9Tmj8dvYoTWmbWzH0S0YUm2thV2MRH7gFKUuW2DsbFY3VPqAXBzWgspM33g8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmHvBUmVU20yc5EpzfL97T4Jip0rZQBOGpCZeBwrrfo=;
 b=IiIg2YaNMQa0KeNaUzn97jsYNSkB5OoTFU5YVxvB/MCdmzy2MyrR6gH5XVO7THBkaAjCJSwJc+Ewgo0qZyoy4auWINCCb5gHY/bW1m6hMmk6hMdk6c+TiQ3BKcQCLRbwJptLHpKcnXbd61gB015IdXCHXJC9HUZ0kb1+jUi1lO9O46VSYYOMviWG87wMWEmTxmjVTXBNp16bOrIkaGjeN/jSJFHNAjhvconHBuIpRHjVped4JWXr7gYuuapHvvuN2LMD5LGvWnGPwzCRgajjnexkjPaKbzs8E1a9l6bqvK+gfPmXo8h8QzFl8R8RtoTyhhkxX+Foi3ZYqpO19l95HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmHvBUmVU20yc5EpzfL97T4Jip0rZQBOGpCZeBwrrfo=;
 b=mBLDHws7PMZvuLa8a2Er9hSbS0uWngW9ay8XrKCGeUKnsSmWp1uv7G6CMMv16H8cXMSaj6VH56vWreYz5XyAnaMWmR7Z81Fcq/D+wXHyjowG4OmtLHgnuFMzIR9q2kGndb/bTuHXppQ15xSPVJS74NHIHeXD/jdleIsC2cAjkOByMwlH3Kz661hR01UEj2Y4Lz4iP7HdkquGM3tmMV+ujLbzyHnzlhlessQ89TeBGG5j6UGv61AaXRdRI2HP7xub4qYNPHyNna2tp7WlnXz6NgGZep1bonQ+uQ8WQyGXs6MVCdXIUwuy0Ckds/QBYhYwu/6LtUIJcuZFA9AUYwAQSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:28:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:28:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 12/14] net: dsa: netc: add more basic functions support
Date: Thu, 26 Mar 2026 14:29:15 +0800
Message-Id: <20260326062917.3552334-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff00937-f224-4e4c-9ea7-08de8b00efb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IU8q47AFpZsk35KABLELgB1qh3w/sv+PYJ96i+D0vZA7fufWoiikL143Ur77NAX0A34y0uT/FOdz68YUVIURvEwxF8UFotqmWib4mZ2ji+/okUKBSSFBOo7eDiY+FSekXeXWu0Fp6DAgP2GXJvSNywC+Ls6MtNEaGh9b71RRbyMg3cEUKAfjOXNrRGEPKqb8ojHEQFA0SEO6rqk+rewkd2+6kglG3nbjGll1rr/Eo9PwP+1mq1LwXrByF6zeevMKAIgCFXnFHfYLaAqkJaB5lWP5tMtQJFxWO0AYUTV/o6Skby0h4anBGlT871PdVvLy62oWsXQbzC6ju60wl/b8f+7i4aT84b58XR0mYcw4IcWEvS/qM7faSkmJssNsbHZbJD5uvYIVvdx4ank1o4dj3stWoBb/9L3FYZs9o1GxfVwTGdSovm2MHtoFO0Qqytg7BzzGyobHulbzAmY8Ph5ZlE87vPtJNU2JPdp0Jh6IcVDQrZaubRvUnc6F95QeL/0Uily4YfRgPThdaZhTw87WYzOaRKx3SWAf+xyjKlGL5L1/V9+HA/RS33y+bfqQmE1PZrh6IG8UrhPSch3GVvxPLxszHKUBKOf28JZgoEj4PvxFlJXIaZHSHekbSASDzHPtR0+tMYhMCaJexDKFpU1aRIX8ZxJIobvo0WwUK6gfehg8ePEB+k8KCmhBzw1+DyWW8sygcq9MNN0zE0hDGa97296yguJ+aT4Pg6DjXXg312ofcd52HAsA1BS84h0zzc8Xla6GWx7imgvRWWSYPXpwwN9Pas79rNE115p74Xj5T4itPWezFsiTITd4Ta/sNX1F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkwG6ZBjEJ/BFfrneg/0HCD+AX0ch5aa4oSuiZ8+yusx6LvR4kRGJUc3dOGw?=
 =?us-ascii?Q?MJshaPisrzipk3unWV9tvM/1YTST8OHxXhh4hZAuciFETmugtIe3sZue0gnU?=
 =?us-ascii?Q?F00kDnLWhwa2s0Gle28gMNAFRBurZOR1rl3yKrglx9/MAzUh6UoBx4Mk/BEa?=
 =?us-ascii?Q?Escs81qFIhLalxW7fjexkyxgmvInOmsGXXdPTFmIf2s1i3ES7DZvMVN1j8Yt?=
 =?us-ascii?Q?3ZStTvOTzsHmgFCNE8XzERYHq+TC55hC+PYKvX3L//Cyiofq4LlZok4WqARq?=
 =?us-ascii?Q?NpMu3RH7eW/Kh7Syza8A0EG4NeLNKv7Vz0mgwKfLXbN91g7kpPGr7atlMwIR?=
 =?us-ascii?Q?Mrc7ds9jU3hkf3kB6GacKSWtwUGHkhw/oByS0YCJuNRrKkhlAU+BMDpOShpl?=
 =?us-ascii?Q?6361XowTochhg7aAloRcLsHqR1lT0WvSDmy1oJftOcfmrWjaGdm4PurKbS7j?=
 =?us-ascii?Q?1+68wZ/WR2HF96q4HuFEHTexBIKT5BcGtJW8bhvc8D0X2pEh1HGXGvthYH8S?=
 =?us-ascii?Q?zV28gTNIFPD7EpngTmOV54i52FTjF6U4sN9YhiIyebaFWbf46tCWsYtWxtMK?=
 =?us-ascii?Q?TMEHIkXjoRg79clG4jIoZWVsFJ0+wYaOU0z4wAOlOwNehK2qmKDskVa54m5y?=
 =?us-ascii?Q?hPgIxo3fkgpvRZWtCtPi2yjZUA9ABwcuVGujTK/ZT6Bikhcp5qob3pq8+u7W?=
 =?us-ascii?Q?s0IMcBJlEBHFca6PN1NGM0sP5FD43Kbj33LIHsy87aa1kM8MurlEAeW0onGg?=
 =?us-ascii?Q?8w4PDfF7yJFd5JVoI7UWVhSXBMGdr1I7yKe8TiXb58mOYJ22QK2A+KyjYdd6?=
 =?us-ascii?Q?cQuE2kbOb2dQVvdwT1UlTebP4BvahUZ+RTVVFaKucsJrmDOTBCc42OeLW7iP?=
 =?us-ascii?Q?A9kgAVxDUYUx4freenS88P9Ur3NMpi3T3AHzwmP7KIt/jjATrEoeuqa0GTjl?=
 =?us-ascii?Q?ltQoqda/9plswb2lE6Ci7jDPA6BzPcrlUq7o3UP+aSmfXFnM8DWBufhMKz/z?=
 =?us-ascii?Q?42t5Kqz9Ot+J+OBoXeFM8uWndxx8E7806dUe5o/+4WIQZpzFrAq4TENgkfbT?=
 =?us-ascii?Q?jRUCQ31lvq+otlsS3lrYEAhUR8Z21Dx7EqmEFPNF5T74mKsA6vXIJKhB8AIB?=
 =?us-ascii?Q?bm+zznBc3pTaTSDC0KM4MAh4Er7f/GUR1iOHeSuhEyVicuGQoZ+/opafHC/+?=
 =?us-ascii?Q?7ryLHs0mFOhyjzq29OQAPA/BLqclDqEfR8JaTtUd5N+kvNO9Aufw40St6hIq?=
 =?us-ascii?Q?+U+pxaxBWMjvhg+CBcFlgz2dORf7IZi2KlNzF6B83ADZy/gez/+IGf/6BJPL?=
 =?us-ascii?Q?d4BopHAuI4hqat3T+1sa+HgnKqCfVK1QNCMUpH0oo+P+2iZ/bW7SBoV1nUqo?=
 =?us-ascii?Q?i5uO11zGpHNblZO7p1YDSq8K/MRKhOigDPxdICPiXCHYb1RP0ArOMg2hLIVQ?=
 =?us-ascii?Q?54Esvvt/JZ4MaJORApmh4MTyruppkJ7gM1oFjYdvrPrUFZj3o2T0l6dFwfYS?=
 =?us-ascii?Q?mSa/hdSUAdlGbqPr+uEZopvN4APJFI6o6NfcCihGzkFa/ivrT57lsPUJ9+TY?=
 =?us-ascii?Q?nz7HMrB6MKa4wgTHEdtsWNgH0bVecgqziX3GkTLiwN/+v7pCyAKiSR/9r4r4?=
 =?us-ascii?Q?KKbcwoFiH9+ShrD3cozDly4M6ZE+8JBfsUko1i6FlaR9JuVRGfG0UC4cSYBN?=
 =?us-ascii?Q?DrKJNmG2hvcel3jZlBMy82gLwfi9pFdtLmblqvalaYFbDw9I5wnnA3iGV+mt?=
 =?us-ascii?Q?l7D71Fcd2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff00937-f224-4e4c-9ea7-08de8b00efb1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:28:47.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtpQRg9PUTkJ5R8Xz4YKhNvq7YyoFEWE+kSc7gtYsTEZugbS5fcA/yz8Wt3igTt+E8lmZpIXOI8KuKKnsFIgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

This patch expands the NETC switch driver with several foundational
features, including FDB and MDB management, STP state handling, MTU
configuration, port setup/teardown, and host flooding support.

At this stage, the driver operates only in standalone port mode. Each
port uses VLAN 0 as its PVID, meaning ingress frames are internally
assigned VID 0 regardless of whether they arrive tagged or untagged.
Note that this does not inject a VLAN 0 header into the frame, the VID
is used purely for subsequent VLAN processing within the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 540 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  33 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  11 +
 3 files changed, 584 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index f11f5d0f6a6d..3609d83ac363 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -7,11 +7,36 @@
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/fsl/enetc_mdio.h>
+#include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/of_mdio.h>
 
 #include "netc_switch.h"
 
+static struct netc_fdb_entry *
+netc_lookup_fdb_entry(struct netc_switch *priv,
+		      const unsigned char *addr,
+		      u16 vid)
+{
+	struct netc_fdb_entry *entry;
+
+	hlist_for_each_entry(entry, &priv->fdb_list, node)
+		if (ether_addr_equal(entry->keye.mac_addr, addr) &&
+		    le16_to_cpu(entry->keye.fid) == vid)
+			return entry;
+
+	return NULL;
+}
+
+static void netc_destroy_fdb_list(struct netc_switch *priv)
+{
+	struct netc_fdb_entry *entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(entry, tmp, &priv->fdb_list, node)
+		netc_del_fdb_entry(entry);
+}
+
 static enum dsa_tag_protocol
 netc_get_tag_protocol(struct dsa_switch *ds, int port,
 		      enum dsa_tag_protocol mprot)
@@ -386,6 +411,212 @@ static void netc_port_default_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_POR, PCR_TXDIS, 0);
 }
 
+static u32 netc_available_port_bitmap(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+	u32 bitmap = 0;
+
+	dsa_switch_for_each_available_port(dp, priv->ds)
+		bitmap |= BIT(dp->index);
+
+	return bitmap;
+}
+
+static int netc_add_standalone_vlan_entry(struct netc_switch *priv)
+{
+	u32 bitmap_stg = VFT_STG_ID(0) | netc_available_port_bitmap(priv);
+	struct vft_cfge_data *cfge;
+	u16 cfg;
+	int err;
+
+	cfge = kzalloc_obj(*cfge);
+	if (!cfge)
+		return -ENOMEM;
+
+	cfge->bitmap_stg = cpu_to_le32(bitmap_stg);
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	cfge->fid = cpu_to_le16(NETC_STANDALONE_PVID);
+
+	/* For standalone ports, MAC learning needs to be disabled, so frames
+	 * from other user ports will not be forwarded to the standalone ports,
+	 * because there are no FDB entries on the standalone ports. Also, the
+	 * frames received by the standalone ports cannot be flooded to other
+	 * ports, so MAC forwarding option needs to be set to
+	 * MFO_NO_MATCH_DISCARD, so the frames will discarded rather than
+	 * flooding to other ports.
+	 */
+	cfg = FIELD_PREP(VFT_MLO, MLO_DISABLE) |
+	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_DISCARD);
+	cfge->cfg = cpu_to_le16(cfg);
+
+	err = ntmp_vft_add_entry(&priv->ntmp, NETC_STANDALONE_PVID, cfge);
+	if (err)
+		dev_err(priv->dev,
+			"Failed to add standalone VLAN entry\n");
+
+	kfree(cfge);
+
+	return err;
+}
+
+static int netc_port_add_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_fdb_entry *entry;
+	struct fdbt_keye_data *keye;
+	struct fdbt_cfge_data *cfge;
+	int port = np->dp->index;
+	u32 cfg = 0;
+	int err;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	cfge = &entry->cfge;
+	ether_addr_copy(keye->mac_addr, addr);
+	keye->fid = cpu_to_le16(vid);
+
+	cfge->port_bitmap = cpu_to_le32(BIT(port));
+	cfge->cfg = cpu_to_le32(cfg);
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+
+	err = ntmp_fdbt_add_entry(&priv->ntmp, &entry->entry_id, keye, cfge);
+	if (err) {
+		kfree(entry);
+
+		return err;
+	}
+
+	netc_add_fdb_entry(priv, entry);
+
+	return 0;
+}
+
+static int netc_port_set_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_fdb_entry *entry;
+	int port = np->dp->index;
+	u32 port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->fdbt_lock);
+
+	entry = netc_lookup_fdb_entry(priv, addr, vid);
+	if (!entry) {
+		err = netc_port_add_fdb_entry(np, addr, vid);
+		if (err)
+			dev_err(priv->dev,
+				"Failed to add FDB entry on port %d\n",
+				port);
+
+		goto unlock_fdbt;
+	}
+
+	port_bitmap = le32_to_cpu(entry->cfge.port_bitmap);
+	/* If the entry already exists on the port, return 0 directly */
+	if (unlikely(port_bitmap & BIT(port)))
+		goto unlock_fdbt;
+
+	/* If the entry already exists, but not on this port, we need to
+	 * update the port bitmap. In general, it should only be valid
+	 * for multicast or broadcast address.
+	 */
+	port_bitmap ^= BIT(port);
+	entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+	err = ntmp_fdbt_update_entry(&priv->ntmp, entry->entry_id,
+				     &entry->cfge);
+	if (err) {
+		port_bitmap ^= BIT(port);
+		entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+		dev_err(priv->dev, "Failed to set FDB entry on port %d\n",
+			port);
+	}
+
+unlock_fdbt:
+	mutex_unlock(&priv->fdbt_lock);
+
+	return err;
+}
+
+static int netc_port_del_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct netc_fdb_entry *entry;
+	int port = np->dp->index;
+	u32 port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->fdbt_lock);
+
+	entry = netc_lookup_fdb_entry(priv, addr, vid);
+	if (unlikely(!entry))
+		goto unlock_fdbt;
+
+	port_bitmap = le32_to_cpu(entry->cfge.port_bitmap);
+	if (unlikely(!(port_bitmap & BIT(port))))
+		goto unlock_fdbt;
+
+	if (port_bitmap != BIT(port)) {
+		/* If the entry also exists on other ports, we need to
+		 * update the entry in the FDB table.
+		 */
+		port_bitmap ^= BIT(port);
+		entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+		err = ntmp_fdbt_update_entry(ntmp, entry->entry_id,
+					     &entry->cfge);
+		if (err) {
+			port_bitmap ^= BIT(port);
+			entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+			goto unlock_fdbt;
+		}
+	} else {
+		/* If the entry only exists on this port, just delete
+		 * it from the FDB table.
+		 */
+		err = ntmp_fdbt_delete_entry(ntmp, entry->entry_id);
+		if (err)
+			goto unlock_fdbt;
+
+		netc_del_fdb_entry(entry);
+	}
+
+unlock_fdbt:
+	mutex_unlock(&priv->fdbt_lock);
+
+	return err;
+}
+
+static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
+{
+	const u8 bcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	struct dsa_port *dp, *cpu_dp = NULL;
+
+	dsa_switch_for_each_cpu_port(dp, priv->ds) {
+		cpu_dp = dp;
+		break;
+	}
+
+	if (!cpu_dp)
+		return -ENODEV;
+
+	/* If the user port acts as a standalone port, then its PVID is 0,
+	 * MLO is set to "disable MAC learning" and MFO is set to "discard
+	 * frames if no matching entry found in FDB table". Therefore, we
+	 * need to add a broadcast FDB entry on the CPU port so that the
+	 * broadcast frames received on the user port can be forwarded to
+	 * the CPU port.
+	 */
+	return netc_port_set_fdb_entry(NETC_PORT(priv->ds, cpu_dp->index),
+				       bcast, NETC_STANDALONE_PVID);
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -404,19 +635,61 @@ static int netc_setup(struct dsa_switch *ds)
 	if (err)
 		return err;
 
+	INIT_HLIST_HEAD(&priv->fdb_list);
+	mutex_init(&priv->fdbt_lock);
+
 	netc_switch_fixed_config(priv);
 
 	/* default setting for ports */
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_add_standalone_vlan_entry(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
+	err = netc_add_standalone_fdb_bcast_entry(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	return 0;
+
+free_lock_and_ntmp_user:
+	mutex_destroy(&priv->fdbt_lock);
+	netc_free_ntmp_user(priv);
+
+	return err;
+}
+
+static void netc_destroy_all_lists(struct netc_switch *priv)
+{
+	netc_destroy_fdb_list(priv);
+	mutex_destroy(&priv->fdbt_lock);
+}
+
+static void netc_free_host_flood_rules(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_user_port(dp, priv->ds) {
+		struct netc_port *np = priv->ports[dp->index];
+
+		/* No need to clear the hardware IPFT entry. Because PCIe
+		 * FLR will be performed when the switch is re-registered,
+		 * it will reset hardware state. So only need to free the
+		 * memory to avoid memory leak.
+		 */
+		kfree(np->host_flood);
+		np->host_flood = NULL;
+	}
 }
 
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
+	netc_destroy_all_lists(priv);
+	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
 }
 
@@ -569,6 +842,261 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = val & IPBRR0_IP_REV;
 }
 
+static int netc_port_enable(struct dsa_switch *ds, int port,
+			    struct phy_device *phy)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int err;
+
+	if (np->enable)
+		return 0;
+
+	err = clk_prepare_enable(np->ref_clk);
+	if (err) {
+		dev_err(ds->dev,
+			"Failed to enable enet_ref_clk of port %d\n", port);
+		return err;
+	}
+
+	np->enable = true;
+
+	return 0;
+}
+
+static void netc_port_disable(struct dsa_switch *ds, int port)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	/* When .port_disable() is called, .port_enable() may not have been
+	 * called. In this case, both the prepare_count and enable_count of
+	 * clock are 0. Calling clk_disable_unprepare() at this time will
+	 * cause warnings.
+	 */
+	if (!np->enable)
+		return;
+
+	clk_disable_unprepare(np->ref_clk);
+	np->enable = false;
+}
+
+static void netc_port_stp_state_set(struct dsa_switch *ds,
+				    int port, u8 state)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u32 val;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+	case BR_STATE_LISTENING:
+	case BR_STATE_BLOCKING:
+		val = NETC_STG_STATE_DISABLED;
+		break;
+	case BR_STATE_LEARNING:
+		val = NETC_STG_STATE_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+		val = NETC_STG_STATE_FORWARDING;
+		break;
+	default:
+		return;
+	}
+
+	netc_port_wr(np, NETC_BPSTGSR, val);
+}
+
+static int netc_port_change_mtu(struct dsa_switch *ds,
+				int port, int mtu)
+{
+	u32 max_frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (dsa_is_cpu_port(ds, port))
+		max_frame_size += NETC_TAG_MAX_LEN;
+
+	netc_port_set_max_frame_size(np, max_frame_size);
+
+	return 0;
+}
+
+static int netc_port_max_mtu(struct dsa_switch *ds, int port)
+{
+	return NETC_MAX_FRAME_LEN - VLAN_ETH_HLEN - ETH_FCS_LEN;
+}
+
+static int netc_port_fdb_add(struct dsa_switch *ds, int port,
+			     const unsigned char *addr, u16 vid,
+			     struct dsa_db db)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	/* Currently, we only support standalone port mode, so all VLANs
+	 * should be converted to NETC_STANDALONE_PVID.
+	 */
+	return netc_port_set_fdb_entry(np, addr, NETC_STANDALONE_PVID);
+}
+
+static int netc_port_fdb_del(struct dsa_switch *ds, int port,
+			     const unsigned char *addr, u16 vid,
+			     struct dsa_db db)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	return netc_port_del_fdb_entry(np, addr, NETC_STANDALONE_PVID);
+}
+
+static int netc_port_fdb_dump(struct dsa_switch *ds, int port,
+			      dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct netc_switch *priv = ds->priv;
+	u32 resume_eid = NTMP_NULL_ENTRY_ID;
+	struct fdbt_entry_data *entry;
+	struct fdbt_keye_data *keye;
+	struct fdbt_cfge_data *cfge;
+	bool is_static;
+	u32 cfg;
+	int err;
+	u16 vid;
+
+	entry = kmalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	cfge = &entry->cfge;
+	mutex_lock(&priv->fdbt_lock);
+
+	do {
+		memset(entry, 0, sizeof(*entry));
+		err = ntmp_fdbt_search_port_entry(&priv->ntmp, port,
+						  &resume_eid, entry);
+		if (err || entry->entry_id == NTMP_NULL_ENTRY_ID)
+			break;
+
+		cfg = le32_to_cpu(cfge->cfg);
+		is_static = (cfg & FDBT_DYNAMIC) ? false : true;
+		vid = le16_to_cpu(keye->fid);
+
+		err = cb(keye->mac_addr, vid, is_static, data);
+		if (err)
+			break;
+	} while (resume_eid != NTMP_NULL_ENTRY_ID);
+
+	mutex_unlock(&priv->fdbt_lock);
+	kfree(entry);
+
+	return err;
+}
+
+static int netc_port_mdb_add(struct dsa_switch *ds, int port,
+			     const struct switchdev_obj_port_mdb *mdb,
+			     struct dsa_db db)
+{
+	return netc_port_fdb_add(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int netc_port_mdb_del(struct dsa_switch *ds, int port,
+			     const struct switchdev_obj_port_mdb *mdb,
+			     struct dsa_db db)
+{
+	return netc_port_fdb_del(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int netc_port_add_host_flood_rule(struct netc_port *np,
+					 bool uc, bool mc)
+{
+	const u8 dmac_mask[ETH_ALEN] = {0x1, 0, 0, 0, 0, 0};
+	struct netc_switch *priv = np->switch_priv;
+	struct ipft_entry_data *host_flood;
+	struct ipft_keye_data *keye;
+	struct ipft_cfge_data *cfge;
+	u16 src_port;
+	u32 cfg;
+	int err;
+
+	if (!uc && !mc)
+		return 0;
+
+	host_flood = kzalloc_obj(*host_flood);
+	if (!host_flood)
+		return -ENOMEM;
+
+	keye = &host_flood->keye;
+	cfge = &host_flood->cfge;
+
+	src_port = FIELD_PREP(IPFT_SRC_PORT, np->dp->index);
+	src_port |= IPFT_SRC_PORT_MASK;
+	keye->src_port = cpu_to_le16(src_port);
+
+	/* If either only unicast or only multicast need to be flooded
+	 * to the host, we always set the mask that tests the first MAC
+	 * DA octet. The value should be 0 for the first bit (if unicast
+	 * has to be flooded) or 1 (if multicast). If both unicast and
+	 * multicast have to be flooded, we leave the key mask empty, so
+	 * it matches everything.
+	 */
+	if (uc && !mc)
+		ether_addr_copy(keye->dmac_mask, dmac_mask);
+
+	if (!uc && mc) {
+		ether_addr_copy(keye->dmac, dmac_mask);
+		ether_addr_copy(keye->dmac_mask, dmac_mask);
+	}
+
+	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
+	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_HOST_FLOOD);
+	cfge->cfg = cpu_to_le32(cfg);
+
+	err = ntmp_ipft_add_entry(&priv->ntmp, host_flood);
+	if (err) {
+		kfree(host_flood);
+		return err;
+	}
+
+	np->uc = uc;
+	np->mc = mc;
+	np->host_flood = host_flood;
+	/* Enable ingress port filter table lookup */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
+	return 0;
+}
+
+static void netc_port_remove_host_flood(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+
+	if (!np->host_flood)
+		return;
+
+	ntmp_ipft_delete_entry(&priv->ntmp, np->host_flood->entry_id);
+	kfree(np->host_flood);
+	np->host_flood = NULL;
+	np->uc = false;
+	np->mc = false;
+	/* Disable ingress port filter table lookup */
+	netc_port_wr(np, NETC_PIPFCR, 0);
+}
+
+static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
+				     bool uc, bool mc)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (np->uc == uc && np->mc == mc)
+		return;
+
+	/* IPFT does not support in-place updates to the KEYE element,
+	 * so we need to delete the old IPFT entry and then add a new
+	 * one.
+	 */
+	if (np->host_flood)
+		netc_port_remove_host_flood(np);
+
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+			port);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -751,6 +1279,17 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
+	.port_enable			= netc_port_enable,
+	.port_disable			= netc_port_disable,
+	.port_stp_state_set		= netc_port_stp_state_set,
+	.port_change_mtu		= netc_port_change_mtu,
+	.port_max_mtu			= netc_port_max_mtu,
+	.port_fdb_add			= netc_port_fdb_add,
+	.port_fdb_del			= netc_port_fdb_del,
+	.port_fdb_dump			= netc_port_fdb_dump,
+	.port_mdb_add			= netc_port_mdb_add,
+	.port_mdb_del			= netc_port_mdb_del,
+	.port_set_host_flood		= netc_port_set_host_flood,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
@@ -792,6 +1331,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
+	ds->fdb_isolation = true;
 	ds->priv = priv;
 
 	priv->ds = ds;
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index eb65c36ecead..4b229a71578e 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -30,6 +30,8 @@
 
 #define NETC_MAX_FRAME_LEN		9600
 
+#define NETC_STANDALONE_PVID		0
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -43,6 +45,11 @@ struct netc_port_caps {
 	u32 pseudo_link:1;
 };
 
+enum netc_host_reason {
+	/* Software defined host reasons */
+	NETC_HR_HOST_FLOOD = 8,
+};
+
 struct netc_port {
 	void __iomem *iobase;
 	struct netc_switch *switch_priv;
@@ -50,6 +57,11 @@ struct netc_port {
 	struct dsa_port *dp;
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	struct mii_bus *emdio;
+
+	u16 enable:1;
+	u16 uc:1;
+	u16 mc:1;
+	struct ipft_entry_data *host_flood;
 };
 
 struct netc_switch_regs {
@@ -58,6 +70,13 @@ struct netc_switch_regs {
 	void __iomem *global;
 };
 
+struct netc_fdb_entry {
+	u32 entry_id;
+	struct fdbt_cfge_data cfge;
+	struct fdbt_keye_data keye;
+	struct hlist_node node;
+};
+
 struct netc_switch {
 	struct pci_dev *pdev;
 	struct device *dev;
@@ -69,6 +88,8 @@ struct netc_switch {
 	struct netc_port **ports;
 
 	struct ntmp_user ntmp;
+	struct hlist_head fdb_list;
+	struct mutex fdbt_lock; /* FDB table lock */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -91,6 +112,18 @@ static inline bool is_netc_pseudo_port(struct netc_port *np)
 	return np->caps.pseudo_link;
 }
 
+static inline void netc_add_fdb_entry(struct netc_switch *priv,
+				      struct netc_fdb_entry *entry)
+{
+	hlist_add_head(&entry->node, &priv->fdb_list);
+}
+
+static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
+{
+	hlist_del(&entry->node);
+	kfree(entry);
+}
+
 int netc_switch_platform_probe(struct netc_switch *priv);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 881122004644..c6a0c0a8ff8a 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -67,6 +67,9 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_PIPFCR			0x0084
+#define  PIPFCR_EN			BIT(0)
+
 #define NETC_POR			0x100
 #define  PCR_TXDIS			BIT(0)
 #define  PCR_RXDIS			BIT(1)
@@ -122,6 +125,14 @@ enum netc_mfo {
 #define  BPDVR_RXVAM			BIT(24)
 #define  BPDVR_TXTAGA			GENMASK(26, 25)
 
+#define NETC_BPSTGSR			0x520
+
+enum netc_stg_stage {
+	NETC_STG_STATE_DISABLED = 0,
+	NETC_STG_STATE_LEARNING,
+	NETC_STG_STATE_FORWARDING,
+};
+
 /* Definition of Switch ethernet MAC port registers */
 #define NETC_PMAC_OFFSET		0x400
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
-- 
2.34.1


