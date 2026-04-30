Return-Path: <linuxppc-dev+bounces-20317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EFAFF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:49:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5dt20TQZz2xy8;
	Thu, 30 Apr 2026 12:49:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517354;
	cv=pass; b=ko2QscOLnDFXKO7e9LDfLnOBVODI9jt8rOnMa6fXCptj/ReQ1h654wrMgKqUmTO5/77SM4KYnteDtu7J3t0WoSsGUKUqpxgEoS5R7SKQdNiYxusN4m7oW49LkmtfldOWYLVTYW2hVcsVD9m47ZnVZ+rEOENYfP+6yKQySW/Gjl2wzDwItrs5S/d4fsSm2ahzRSirSD2+zm0M6Ux3sTZ1uaF1sgPVBTRLcSmYvRq/v/gdE5ppdcbVdPvJ6QItugPlKUW4gZQJWV/9u7iShQ4ARqK7MeaDJx3xE6jp+fIUR18jK1HlbQEBfw4wNUsnOXSOxXcYowFQeVcQQ0hJg1mV/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517354; c=relaxed/relaxed;
	bh=+y/6cnLqpkUFe7wyuWP1LyPWHACK3fvzm0GLoe+qZrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUHMDei5jjypyhfbIrYtsfU98vIoW7lq/XdK8DkEeUIu5641e73VG4xyw4bLgOn0dwv0TOechQaNNU4iaOgKunnfOlsypt5qxa1mv3QPGzPc9GzEgVq8S8si50owO1pGLq8XDZ2l7A9ytbvcgKB6ykPxlRPk3MVVtXgK4sAmCUieAM4BgiSJRioAu+zUAtO3SN3LuqIrbTy8F5DNyXEpSSb0fAzT2sFZpvDOIAAiIgv0CXRP75lQ81SjB7hHYoMd99EaWNt0NOaa7syRl5oUQ4qcK7Hst1gRZk2qi26TWFH1Gwq7takiyeXuzPskhKgAk6skeLbdXU6HNeqFxT5NlA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EEq/N5w9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EEq/N5w9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5dt03lXjz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:49:12 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWs34vdaAcxtHm48vC2YetiMIfaYil2CTWUUr+TLJ5X4guOMhnwCRvM7FYLQtRUxS+OMy4swDS8yrJzq1MvbeHivC3prBFch5opYygxUHqGYQ5HkIPUnmkpBNMiyjaZUvsPmcFs291CufkVkcS6ZQdBXN2iFHQLGtujPvs2tVpYgNmRbH7a9pMkbc3TAoKPhdx87VZwE+ZBEUwwpfcPQ4qrOe6A+0wdPiSoMxq8yMXW+/Uf75GjdxyIi8Yw6ed3mHTyw9JfXp7akwZkv1rMSrwUgoLrz4h7o+FxAYN/4VtIO/pSeRgFwQb9h+71K0dAb8n8xPIqsVYn9CJSHeCtVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y/6cnLqpkUFe7wyuWP1LyPWHACK3fvzm0GLoe+qZrg=;
 b=X9xw+hVijivZGOSBIBYF9gmapKpFDEXYgGjbhHgWEWdxihZ23Sn0DNHqXuxFjoI+oCAO2lZhLVkoHONlRXMKQzbEF8rWmBZD89+FoLMa7QqQy4C2NfCHOq5AEXtALAj1j/UNS783AQ1+7njIxcnGLgBRGnQvPP/XvThL8B9D0R1lg5/fOLKQidOylTiX7m5/BsVI7cJVx32QHKyp5/WVSXYt9kEinNh/zBou0AAjn70U67zt3cHcxmAJHrh7tSrwuxXqRi9OlUpyD46MYkcY1glDg6vrt5hm4Quhg3fzFcNi41FLdYSdwC5iuMPhFnk6KwVpDCAQHDdM+gpsj1b15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y/6cnLqpkUFe7wyuWP1LyPWHACK3fvzm0GLoe+qZrg=;
 b=EEq/N5w9G32v9l0PZQMzYUsBxInRtxQtc0AUYaQ1n7DIaJjzsM4nBQCu5GVU0CPwnm9aUlEFPs822UOp5eq8efs9WTllznVcDuKEHjDsHkWYDh79cRylL4jgFk+0NGgxw/Dr+j7SuV1UL3ZBuHxeXFKLjwjkCb5lsuNs+V8IkCtva+MeWkHSnqplNAnaIW1MuvoduT+o+7fyvDXjzU9LvcfuHDd0wKL9QZm3mD/xkXHkvp+TSoMTO/DrkrYOqFi4lCx2T0bCDoBs+gVOFHl90d6s0BVNj8t49Pv7vuiaE8ceVWZghEA4ckUXTtWqFR5XFW13vKa8/YHsntw1jXPmzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:49:09 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:49:09 +0000
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 14/15] net: dsa: netc: add support for the standardized counters
Date: Thu, 30 Apr 2026 10:49:44 +0800
Message-Id: <20260430024945.3413973-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 7644d81a-2dde-4719-d54f-08dea6630d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AqFtvU5xGKQKM/eVIbdy5kP98L4lWBWhVxGXEXmfCGAydJCWQIs4MA82DPXkyPYmjeaLR+ATloTq2AmxQFb9nfxiin2Xkdexk4ZZhijFVl8ngBtSzpbDYqqdDyIpkFGXT/N8lOkyLQgCDpv6mkm7MXpzcJRUwu2bnb6wWCKuKv5tbF/UZupQrMd/phi8jz1gcLTF7NxHD9TE5upspr8b8UyLG15WVemnxVJxd48r+FdHo/KfBiRlJh9csISmpgezQExQ8jDBJZ/NQW7eU1cf9rs9+yZlYmpR3LxbpSxAsYOyK73TY0tHXDjzHnqbc311g/sFg3diY/bkqfFNqGfOT2thtXprRcBVXT9/i5YvPvRrPZcbvFlWfWPe86krV12wcEmlBxjWAgX+b7QnVWlXP/sDYuaXqkdaWZwlPSUg/eIeGWjZ6P+bcsKuhB8ufWmdNLKLmOf8uDC8Kf198f86XkzvX2083oENEVpK9BXmeAhAVdIIWiLrqElCVEq4RaASEgPRpQhg4f5Hf4vghg9uVo/Wr/soz73rebWzdJQwJs1WaPAisfWp/T0O2ZIXJj7CRNPmY7kShVXOp5YYYFpFRrZFonv7mhOjKAcjft0f3koBduSZsoRpRcWNnZGxNnAf9zKn5W63JnFEIKjtpFQoSciyntWemEL8A2mmxH6o4o+1w/MLcH5OV4KFYI0cBGTadPtXlUxYlkqjCRcTf95csJv06hvXe9zuROWy6uw/ZWe66Cjaag5UxEt8Va6SqVe04gcGCrGyJEbMShqQ3ff9BPTAfXBYzjkVnc1VmrSI53PUoeRjCTohjKj1v0pnmLHY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4BeZZgtzOUogvUzNlQ/OY2slzSgJ/PzHJTq8Xjk+FmCCtJXvyRu5EEi8ggDx?=
 =?us-ascii?Q?hprrts1tDrIYJ+Rl5ep77PTrp9fyOLElk78Hlx0ZkGjfum3E4T2nCM88GRR5?=
 =?us-ascii?Q?+Owo4RhgJobVp1xkwFJ6ZXq+aFjINOzGa/ucxN7B1FDsoyyqYPyKGyo5beh1?=
 =?us-ascii?Q?y3bb5nqbt0ymP6G3kZcXnpZRP1jqEEqs+yI+3yJ8os/JYwbA70P+YnoKyH78?=
 =?us-ascii?Q?ZsEtmu7PB50T7oHt/bDXZE6PiFBC1rm7wjWM1+ob0enGt5lAtzdTtbDfTTgm?=
 =?us-ascii?Q?WGjsk1JB+eNOM2milYET/5zok7dbF1TDhLJQJ0LmuHPfsoMsmh6RBEHpIlpk?=
 =?us-ascii?Q?YHfuXYIoDIBaFaHZ6RK3FEciv/HUf/6CnxTB5npwaP7xOmZH5ino7MRr0M/J?=
 =?us-ascii?Q?svmwQHi1Kf0NRCzbCEj1mLwv74jzHVWd5KcuPEcaR5BHhDJRrgqgsfhcdRxi?=
 =?us-ascii?Q?RKV07FNBvlE7n7jlPjHoEoOfYRZdHDMognnFJshvx4qXxkGrH1ARtRiyhuIg?=
 =?us-ascii?Q?5fc2DAswY53gMHQbMgOc4ESiAEqzK89dSK4KTDK4YQKS08tYZ3gmtFVq0e2Z?=
 =?us-ascii?Q?D8YwDx3ciHncOWxYF32LG9b/MWrRrLSMG48abLvlygwsO3KBSQUF0sDghuBI?=
 =?us-ascii?Q?E7YB7NXmi8ePvMS1t6tnEzmltYY9KeQkJpqMt6Zu/jwSm/kwojxS5CFen014?=
 =?us-ascii?Q?b7pNUays/4GQ8o+wz1CYX34/dIgaY1ZZXLgq8dLTxbWQvWPpt9/Xwq9/FA8G?=
 =?us-ascii?Q?m4PGjLV1NGY9i4FcMm7ekvBfdLsj8YXhSaH0/70Xvhqpv4mgcKBwdnFaF/nu?=
 =?us-ascii?Q?DtaS1qZ/GUTB+DVnjz+Xd77sBFt9esrxe7/XLF2fYV95m9U8uOnTcTpZp6D8?=
 =?us-ascii?Q?BtCjxuttJSoQ4dLbc3Plm9bt6c+5OSyEhvoeXVLTGF5CTKPjD1XcqFkouUFz?=
 =?us-ascii?Q?CbMBf16XEFe7fl6ONZwvzKXBngmgnGZ0UyCvWWeb1dmIIormOcB53fr9Jd3c?=
 =?us-ascii?Q?I+YGqU8ZRIvEMf6VbGK1aBMm0SBDH8PvFdPiilxJ00733mLkdHzIVtRwheAY?=
 =?us-ascii?Q?4pQ7GjDNO94OCOsb1Py+nJmzKtFEU+gYe1opZgeFqWouV9oR93Qv9Zkopn0L?=
 =?us-ascii?Q?Dy+yWWGjN0HDC48wHiEq6xSP2ZNM+eJMQWYT/dpASNI4Wo4opJmET+IEsk6U?=
 =?us-ascii?Q?oOZ776ZOZrGvlICUHiAt4fHLkx/Ymh6ti31LzGkar4tn6Knf4O5w2Pnl3wY/?=
 =?us-ascii?Q?/Z9O7jK6Qz6sUkvEPi9Mecx7PtcagRVl6zfUYhY20CxGY3w0Oyo8euPZi7in?=
 =?us-ascii?Q?rHeEXtGmR3ltGEom7xlPq5/1QZ8kDvflopJLjWqPiIEQIIzaiPjcZXeHf9E6?=
 =?us-ascii?Q?hiDzh7LmKVYMI/xZRcOTe8bcTxNDushaVU3whPOXzGK12mK+gy87ZcEMTzZS?=
 =?us-ascii?Q?NcqcvkFYo4LVH12ZWg6N/nGrJO9jiE09EUSWxctJ+6RfkTT8c1dQQM4e50Wy?=
 =?us-ascii?Q?RCnZhyR3gGZojczhf9ANNrGT1tx0XmAI8/X/Hh+pud+OSOOl/6h7EUFHnMrR?=
 =?us-ascii?Q?IiryNg4FcRDJSmxjxY2vv0O0ZGb2pJPt1hQemIaYnYoQA8OfZ7W2iDhzYeyl?=
 =?us-ascii?Q?uO+5eoTvB5uj6h5bxnAgEfZ9IQQjf4t0+QhPdsT3C3TlPllSZpZWxrWTc04t?=
 =?us-ascii?Q?H4DWCMdMG2+7VBSaGpJB6NB7cqfHO+SiwIKBypLJICzTcxxf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7644d81a-2dde-4719-d54f-08dea6630d56
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:49:09.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtRdoKAgVjhglxIWX8P1EQszBR+BZQRiW6P1ABEn1XF4BhY/IW2c4+RIlhNDPVRrfYpUV2F5IZZuZBEAa1+zPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

Each user port of the NETC switch supports 802.3 basic and mandatory
managed objects statistic counters and IETF Management Information
Database (MIB) package (RFC2665) and Remote Network Monitoring (RMON)
counters. And all of these counters are 64-bit registers. In addition,
some user ports support preemption, so these ports have two MACs, MAC
0 is the express MAC (eMAC), MAC 1 is the preemptible MAC (pMAC). So
for ports that support preemption, the statistics are the sum of the
pMAC and eMAC statistics.

Note that the current switch driver does not support preemption, all
frames are sent and received via the eMAC by default. The statistics
read from the pMAC should be zero.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Makefile         |   2 +-
 drivers/net/dsa/netc/netc_ethtool.c   | 190 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_main.c      |   4 +
 drivers/net/dsa/netc/netc_switch.h    |  12 ++
 drivers/net/dsa/netc/netc_switch_hw.h | 120 ++++++++++++++++
 include/linux/fsl/netc_global.h       |   6 +
 6 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/netc/netc_ethtool.c

diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
index 4a5767562574..f40b13c702e0 100644
--- a/drivers/net/dsa/netc/Makefile
+++ b/drivers/net/dsa/netc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
-nxp-netc-switch-objs := netc_main.o netc_platform.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o
diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
new file mode 100644
index 000000000000..ac8940b5a85c
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ethtool.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/ethtool_netlink.h>
+
+#include "netc_switch.h"
+
+static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1522 },
+	{ 1523, NETC_MAX_FRAME_LEN },
+	{ }
+};
+
+static void netc_port_pause_stats(struct netc_port *np, int mac,
+				  struct ethtool_pause_stats *stats)
+{
+	if (mac && !np->caps.pmac)
+		return;
+
+	stats->tx_pause_frames = netc_port_rd64(np, NETC_PM_TXPF(mac));
+	stats->rx_pause_frames = netc_port_rd64(np, NETC_PM_RXPF(mac));
+}
+
+void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_pause_stats *pause_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (pause_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_pause_stats(np, 0, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_pause_stats(np, 1, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_pause_stats(ndev, pause_stats);
+		break;
+	}
+}
+
+static void netc_port_rmon_stats(struct netc_port *np, int mac,
+				 struct ethtool_rmon_stats *stats)
+{
+	if (mac && !np->caps.pmac)
+		return;
+
+	stats->undersize_pkts = netc_port_rd64(np, NETC_PM_RUND(mac));
+	stats->oversize_pkts = netc_port_rd64(np, NETC_PM_ROVR(mac));
+	stats->fragments = netc_port_rd64(np, NETC_PM_RFRG(mac));
+	stats->jabbers = netc_port_rd64(np, NETC_PM_RJBR(mac));
+
+	stats->hist[0] = netc_port_rd64(np, NETC_PM_R64(mac));
+	stats->hist[1] = netc_port_rd64(np, NETC_PM_R127(mac));
+	stats->hist[2] = netc_port_rd64(np, NETC_PM_R255(mac));
+	stats->hist[3] = netc_port_rd64(np, NETC_PM_R511(mac));
+	stats->hist[4] = netc_port_rd64(np, NETC_PM_R1023(mac));
+	stats->hist[5] = netc_port_rd64(np, NETC_PM_R1522(mac));
+	stats->hist[6] = netc_port_rd64(np, NETC_PM_R1523X(mac));
+
+	stats->hist_tx[0] = netc_port_rd64(np, NETC_PM_T64(mac));
+	stats->hist_tx[1] = netc_port_rd64(np, NETC_PM_T127(mac));
+	stats->hist_tx[2] = netc_port_rd64(np, NETC_PM_T255(mac));
+	stats->hist_tx[3] = netc_port_rd64(np, NETC_PM_T511(mac));
+	stats->hist_tx[4] = netc_port_rd64(np, NETC_PM_T1023(mac));
+	stats->hist_tx[5] = netc_port_rd64(np, NETC_PM_T1522(mac));
+	stats->hist_tx[6] = netc_port_rd64(np, NETC_PM_T1523X(mac));
+}
+
+void netc_port_get_rmon_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	*ranges = netc_rmon_ranges;
+
+	switch (rmon_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_rmon_stats(np, 0, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_rmon_stats(np, 1, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_rmon_stats(ndev, rmon_stats);
+		break;
+	}
+}
+
+static void netc_port_ctrl_stats(struct netc_port *np, int mac,
+				 struct ethtool_eth_ctrl_stats *stats)
+{
+	if (mac && !np->caps.pmac)
+		return;
+
+	stats->MACControlFramesTransmitted =
+		netc_port_rd64(np, NETC_PM_TCNP(mac));
+	stats->MACControlFramesReceived =
+		netc_port_rd64(np, NETC_PM_RCNP(mac));
+}
+
+void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (ctrl_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_ctrl_stats(np, 0, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_ctrl_stats(np, 1, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_ctrl_stats(ndev, ctrl_stats);
+		break;
+	}
+}
+
+static void netc_port_mac_stats(struct netc_port *np, int mac,
+				struct ethtool_eth_mac_stats *stats)
+{
+	if (mac && !np->caps.pmac)
+		return;
+
+	stats->FramesTransmittedOK = netc_port_rd64(np, NETC_PM_TFRM(mac));
+	stats->SingleCollisionFrames = netc_port_rd64(np, NETC_PM_TSCOL(mac));
+	stats->MultipleCollisionFrames =
+		netc_port_rd64(np, NETC_PM_TMCOL(mac));
+	stats->FramesReceivedOK = netc_port_rd64(np, NETC_PM_RFRM(mac));
+	stats->FrameCheckSequenceErrors =
+		netc_port_rd64(np, NETC_PM_RFCS(mac));
+	stats->AlignmentErrors = netc_port_rd64(np, NETC_PM_RALN(mac));
+	stats->OctetsTransmittedOK = netc_port_rd64(np, NETC_PM_TEOCT(mac));
+	stats->FramesWithDeferredXmissions =
+		netc_port_rd64(np, NETC_PM_TDFR(mac));
+	stats->LateCollisions = netc_port_rd64(np, NETC_PM_TLCOL(mac));
+	stats->FramesAbortedDueToXSColls =
+		netc_port_rd64(np, NETC_PM_TECOL(mac));
+	stats->FramesLostDueToIntMACXmitError =
+		netc_port_rd64(np, NETC_PM_TERR(mac));
+	stats->OctetsReceivedOK = netc_port_rd64(np, NETC_PM_REOCT(mac));
+	stats->FramesLostDueToIntMACRcvError =
+		netc_port_rd64(np, NETC_PM_RDRNTP(mac));
+	stats->MulticastFramesXmittedOK =
+		netc_port_rd64(np, NETC_PM_TMCA(mac));
+	stats->BroadcastFramesXmittedOK =
+		netc_port_rd64(np, NETC_PM_TBCA(mac));
+	stats->MulticastFramesReceivedOK =
+		netc_port_rd64(np, NETC_PM_RMCA(mac));
+	stats->BroadcastFramesReceivedOK =
+		netc_port_rd64(np, NETC_PM_RBCA(mac));
+	stats->FramesWithExcessiveDeferral =
+		netc_port_rd64(np, NETC_PM_TEDFR(mac));
+}
+
+void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				 struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (mac_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_mac_stats(np, 0, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_mac_stats(np, 1, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_mac_stats(ndev, mac_stats);
+		break;
+	}
+}
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index fd02a943824d..ae8f28b82b72 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1468,6 +1468,10 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.get_pause_stats		= netc_port_get_pause_stats,
+	.get_rmon_stats			= netc_port_get_rmon_stats,
+	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
+	.get_eth_mac_stats		= netc_port_get_eth_mac_stats,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 9fea3d4287a3..d477b0cd2157 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -123,6 +123,7 @@ struct netc_switch {
 
 /* Write/Read registers of Switch Port (including pseudo MAC port) */
 #define netc_port_rd(p, o)		netc_read((p)->iobase + (o))
+#define netc_port_rd64(p, o)		netc_read64((p)->iobase + (o))
 #define netc_port_wr(p, o, v)		netc_write((p)->iobase + (o), v)
 
 /* Write/Read Switch global registers */
@@ -148,4 +149,15 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 
 int netc_switch_platform_probe(struct netc_switch *priv);
 
+/* ethtool APIs */
+void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_pause_stats *pause_stats);
+void netc_port_get_rmon_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges);
+void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats);
+void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				 struct ethtool_eth_mac_stats *mac_stats);
+
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index caf5977c5100..f8d436ad9623 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -173,6 +173,126 @@ enum netc_stg_stage {
 #define   SSP_10M			1
 #define   SSP_1G			2
 
+/* Port MAC 0/1 Receive Ethernet Octets Counter */
+#define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Alignment Error Counter Register */
+#define NETC_PM_RALN(a)			(0x1110 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Valid Pause Frame Counter */
+#define NETC_PM_RXPF(a)			(0x1118 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Counter */
+#define NETC_PM_RFRM(a)			(0x1120 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Check Sequence Error Counter */
+#define NETC_PM_RFCS(a)			(0x1128 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Multicast Frame Counter */
+#define NETC_PM_RMCA(a)			(0x1148 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Broadcast Frame Counter */
+#define NETC_PM_RBCA(a)			(0x1150 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Undersized Packet Counter */
+#define NETC_PM_RUND(a)			(0x1168 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 64-Octet Packet Counter */
+#define NETC_PM_R64(a)			(0x1170 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 65 to 127-Octet Packet Counter */
+#define NETC_PM_R127(a)			(0x1178 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 128 to 255-Octet Packet Counter */
+#define NETC_PM_R255(a)			(0x1180 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 256 to 511-Octet Packet Counter */
+#define NETC_PM_R511(a)			(0x1188 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 512 to 1023-Octet Packet Counter */
+#define NETC_PM_R1023(a)		(0x1190 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 1024 to 1522-Octet Packet Counter */
+#define NETC_PM_R1522(a)		(0x1198 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 1523 to Max-Octet Packet Counter */
+#define NETC_PM_R1523X(a)		(0x11a0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Oversized Packet Counter */
+#define NETC_PM_ROVR(a)			(0x11a8 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Jabber Packet Counter */
+#define NETC_PM_RJBR(a)			(0x11b0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Fragment Packet Counter */
+#define NETC_PM_RFRG(a)			(0x11b8 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Control Packet Counter */
+#define NETC_PM_RCNP(a)			(0x11c0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Not Truncated Packets Counter */
+#define NETC_PM_RDRNTP(a)		(0x11c8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Ethernet Octets Counter */
+#define NETC_PM_TEOCT(a)		(0x1200 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Excessive Deferral Packet Counter */
+#define NETC_PM_TEDFR(a)		(0x1210 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Valid Pause Frame Counter */
+#define NETC_PM_TXPF(a)			(0x1218 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Counter */
+#define NETC_PM_TFRM(a)			(0x1220 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Error Counter */
+#define NETC_PM_TERR(a)			(0x1238 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multicast Frame Counter */
+#define NETC_PM_TMCA(a)			(0x1248 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Broadcast Frame Counter */
+#define NETC_PM_TBCA(a)			(0x1250 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 64-Octet Packet Counter */
+#define NETC_PM_T64(a)			(0x1270 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 65 to 127-Octet Packet Counter */
+#define NETC_PM_T127(a)			(0x1278 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 128 to 255-Octet Packet Counter */
+#define NETC_PM_T255(a)			(0x1280 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 256 to 511-Octet Packet Counter */
+#define NETC_PM_T511(a)			(0x1288 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 512 to 1023-Octet Packet Counter */
+#define NETC_PM_T1023(a)		(0x1290 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 1024 to 1522-Octet Packet Counter */
+#define NETC_PM_T1522(a)		(0x1298 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 1523 to TX_MTU-Octet Packet Counter */
+#define NETC_PM_T1523X(a)		(0x12a0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Control Packet Counter */
+#define NETC_PM_TCNP(a)			(0x12c0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Deferred Packet Counter */
+#define NETC_PM_TDFR(a)			(0x12d0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multiple Collisions Counter */
+#define NETC_PM_TMCOL(a)		(0x12d8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Single Collision */
+#define NETC_PM_TSCOL(a)		(0x12e0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Late Collision Counter */
+#define NETC_PM_TLCOL(a)		(0x12e8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Excessive Collisions Counter */
+#define NETC_PM_TECOL(a)		(0x12f0 + (a) * 0x400)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index fdecca8c90f0..5b8ff528d369 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -5,6 +5,7 @@
 #define __NETC_GLOBAL_H
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -16,4 +17,9 @@ static inline void netc_write(void __iomem *reg, u32 val)
 	iowrite32(val, reg);
 }
 
+static inline u64 netc_read64(void __iomem *reg)
+{
+	return ioread64(reg);
+}
+
 #endif
-- 
2.34.1


