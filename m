Return-Path: <linuxppc-dev+bounces-20315-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E801FF887E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:49:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5dsk40Vfz2xtt;
	Thu, 30 Apr 2026 12:48:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517338;
	cv=pass; b=oVf76W9vOC6JbuU+ByGbuc/rnDSGPCx3X8VrNqV9zbXivrh/cRutDQb+Fg5xvpVBPko8W6W6H4Zt1qYJnSqy+Qp4hE+lMPQ3bZlkIOSAncoQpYoalPxd0eq9xankFCCKXGUl7D7Es4/7UyGNP3gE9omnyp6Mg/EwmZdnwUa46vpJixEvUHMt3atJ+y1lQFXsnEmiTu7WYfvgeVIAW+aZLG19DNEzppZzr9jv85u78VqyXDBRsl4LY3wdq/EosDknDh4+UQjMT93RqBqWotZ/xSA0QW8az3oOwq47QT2VarqNIT9FqOc9hQbSi0z03DErOWsP5353egPnHvc8TseRTA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517338; c=relaxed/relaxed;
	bh=FYZvlqohtm1cNvxbiISAo6twb4bmcR00GXL7nA+pDB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WBjcXD9grjsue46+jBhbiIYsUYMRncSNVyhODDG1Q5PNF8wL0+RgR1awzPDdHAcItod+ul0ZGClZIjB4FJiW0lo3SfMP6q2sFsRbUq/YnEANN8wyECE4UtpedZPWVa67wpm+arUS6KaDzLvvi6qfnDhV/xig9NWTylT9iu+jktloqqzrrQXcdHFchHca50LYollxNyjWy2Lc74LoFdmOW+aQEwoKVR1WxTJT5jHoJYeu1wckj1DvXN8PWixCEGS+Xqqmuy9B6HXDGERO5VAYLyysT7Oiszx9JHO2mF7jdIRsxg1rLHodyZ/jFHLvsMZVikVTefTpznqLH7CE3vuSng==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=booOGDsa; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=booOGDsa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5dsj1fw9z2xtC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:48:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPphvdBFkAjTIx0DR5wW2foXz7ZxtvtZVFyBCNoHatf4TgVJSunbOYehFiRzJGuGrrh5A9TKTlbHW7Mo9wGnqAveLItI3n3hGcSUoC+vAoDiqrUJHZpgLwCP/7ckog058c7m5JcgRJotBWHK8h1LNGjnntddJFNNLghqMkKMy4bJt6TBEomk286VVhPKaAeTEghQ6+7F3/H98Fc36ocwK/B8B+1NWMwCWlNrOHZGObbWI4IHz18s6aQnJ0dJNgle1Ltja0ZUscMenktQCay7lhAnbXbpS+FeViS76PyLbeVqQSbC6cLaJZVK8uwQikAOGoLxwLEl775M1RQ5qHQ+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYZvlqohtm1cNvxbiISAo6twb4bmcR00GXL7nA+pDB0=;
 b=hYg3blkDJFhexgdhe6qjVdnL1ieIZfcx5FaU+HlZHGRBqHGFhAdMZE6iOSfBLvCON0kAbb7CYiqjLKO/9fSfG3v4B4JiHxSpZp++810mzyICCrna9e8EDwIdtsCOdVz4/zq9YGYsrj0LPTrOIb+wZ01ElNoq/HVxFHOHBp/RqwhnLkJeSthTJD9kUAIaaUd+sUgHC2g/kS7nxlO0WkDVZD67TM5ehVOcegaQXHPVcIt3PrE17Pdx62AWDZhLhw+GrRaDUxmfgHIhvu4sisOTMCKn6+D9PugayXe4waZaIGyaLHK+omU/SMQQOfokfJ8/epppkd2zQvau8MkhXx4+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYZvlqohtm1cNvxbiISAo6twb4bmcR00GXL7nA+pDB0=;
 b=booOGDsaia4CCGdWjefWFuDY2Q17zzGhJE+YMdY8ErbBdAfY7AQ1eZkRAD012vAxUtcPmanmy327GcT0whCNtRqA+Xl1V1stRWZa1z8gcfvT6En8OjzrHYHKgWEmTEDF2kOqT+99Z2lYV5xChLdnZeC/bb8knherg35yrC4bnOQ0b0AYQKb69XGKsYt56GGJtrfkte+It9t+NJX3TWChvQxMm+5pjbCWegec361kWFQZfM6aSfV1XkxhCL216OM47jwGT/WDea6mfj+kvG2ZHPBS0pq306HYtgch6x1a61hj/KlJGwH1pKtH6PdWLfyZEJ7icWCCBtin9B1IV1vtnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:48:54 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:48:53 +0000
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
Subject: [PATCH v5 net-next 12/15] net: dsa: netc: add FDB, STP, MTU, port setup and host flooding support
Date: Thu, 30 Apr 2026 10:49:42 +0800
Message-Id: <20260430024945.3413973-13-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 19f1c2c5-f57c-42bf-be78-08dea6630435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pwbQ+5jA2DmfSvaDRw9j3kApSxgdJHvyS3u8/0UtSo6GvrZyKL0tMxQKBa4MPy7In6QE7H0yC1TFF8PK8PYZWVTLPfH0cVct4SqWqvq2cuSiZ3H+72A5JiKFWxFpu/hxRDEobuKIzeemBGp/j4CUfKfyrqyZpNTBRnr6JaulKkV/nZz1cptJTSr92wb2oObDmo7pwf3faoLFmcIm6SumvT0nvTMRTp+ky3L4onc/EpqdFpRzVDUz1fe6PY8T4afo/LS3G5rUgagwWEsd5Mh5/KInv4FYohKK6StlbeXXHVxpmn/9LIw900vE+buzjauFgkd3ORQSl34JeesyjG3hFNUZjzRA8ypU2t6xQMO/j43Hsb1cji1g6p+XvaxkFeaQksz0bR1qIVsUSRQ7ZLu2uhS7vvCuhrOVNZg26N6Qp6jlTbC+xlNNheOLpfC055rTMVdVDlr4ysS9461qruwZJDrIkrW4p05cHVU4N8cGtzhmaclSVUluX80FEXuZpPtWv1e3r9Y0VDghbSpng1bV7kNIsFki3Lb3sXhwoDrt0b1wd57l8pVi+RVtmZwrJwFIXEFt1N7BepVuNo2C2stOIKmGcyg2th7n3/En8T2EeVe8Y9vjjM05fYb55mrTcCpgXVDcGwU832Ka7gtJg+VnVJnTBp6i7UFeBj97A9XCAQPNyqEocxqapItcKMCq2/Vu7xx/t5W0CWLzqfebAcL1w2dF3xV4sP54yoemZUBQgV9U0HKf1ELv9mkGWS6hgleRiCrUoob5eW2LIYV+yEttudMrIHrFTZx8XIFeJk5neh1AqWiRVCs1Po1O5kZ8JOYg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtisJxxdSnvahijQEaXtPxxguJfgwwWNfE+Kn+yU03hbu60ZZy3JJtVva9yE?=
 =?us-ascii?Q?3fURQIIGUTtBRhq03+tk7wWVwHr0JBqC67+Ss+G51AH2c3adv7VkceSKeFIW?=
 =?us-ascii?Q?/Uar0hoZMjVQR+S2tuy1x715jZ2NmOeXzYA/m5e5GMP3sAloQuDE10pAaPYg?=
 =?us-ascii?Q?I87UNl0sFpXnchKazL7NPl+Bt0MRJN4UfzwUQmRft7pZvxkjZ/fVRBXxvCM1?=
 =?us-ascii?Q?cge91hL0TQ7UPcNPWSwIFcdfeu6xJukLWjvx552hdtXRVqBWkY71o45vrfJz?=
 =?us-ascii?Q?Y4eZnZfIRAWHATPGXEV2z+Vif2qoaplho9CUsWxjZr8wli8NlI8uLyHHFuQL?=
 =?us-ascii?Q?IqOFC7LGsuknlpvviwuKLyQt8gP4c1pJvxOm+F/B25LTybfXfC1HsHEla81G?=
 =?us-ascii?Q?lQGkHonMyEUjwPtkVEOU//ghPDv7/VgfgxYK7qwrp/8UDK/yBfocF+gao0Wz?=
 =?us-ascii?Q?28tenoMd233mJtcJblwv3Klb9qD2LNKzDt0kfCDIsfqc6oF9j2/ExN6ZzSO/?=
 =?us-ascii?Q?mykHOCKMu677zHCm55DtvZB56hEwqZtY7O+rh4/jmBZSGE60B5ZSlR3008rp?=
 =?us-ascii?Q?fzmL36HGwCzdgrRO4QHVnUzBHXMZSUzt3dNXN1EXQAAPNM9/0PwFXL8B7MFU?=
 =?us-ascii?Q?A1AFiMNe6fs87GMDoGjc29UN3qpmN2RQnx+HDJWvfHStEIli8aen8HnBbtyU?=
 =?us-ascii?Q?zSLt5xsBQ8XuENTVGhSp9rAY3iFsDC5vwnGoShpYadZsppXhudqcAWacac0F?=
 =?us-ascii?Q?kORKaVhE2nQsWKn9dchV0uvsHdRwvKTfsxC918UTIdPYU2RlYYDIgMG++8LZ?=
 =?us-ascii?Q?/IpA+ii+aUZMSyVrB8cjKBoP0ktbYx6zLTr85skthNSezvRZxEPFthfeOXGW?=
 =?us-ascii?Q?vI+mRikO1BmURdl4BLvoVqTN3v2yyWeBTWFUaezpYhmnRxqSNw8xghQ57CJ5?=
 =?us-ascii?Q?S4OvlsZNcyGVYGTwsKQGhg91BS2szHP4btNXGLqOazskvBn2z+rEV0Vi8m4Y?=
 =?us-ascii?Q?P6rOSZufVqJOsTtFKuJPiQZf9sOSPqjqB1TA/NQqW6soFVOQcCyihxDLO3Ky?=
 =?us-ascii?Q?d79O37IKqLAlplXlE4Byx1sUAIkAme+IwEA39LgtVRppFgMltNOK5njCWO3i?=
 =?us-ascii?Q?LmMz42LcKhdnIvCOQHLqXaS72UIbMopgBJmruP/6h3in6xVma1l0+4+lMBro?=
 =?us-ascii?Q?qFNU95d7uSzGcKnvMKbZH3DFMajZSsjwBIwRCkzYnMqIx9bCknaK1ocz6nFO?=
 =?us-ascii?Q?q/drg/3/NkmwUHKHuleP3aQ003WzNM06H3BrHdargkzrmhCpT5u2IdKd1i+S?=
 =?us-ascii?Q?JFtyTN1fTFXUA6E6OEbdbko0EI3UNUCSE0ELDu82RXa9KWyBf4tirUAVLDUH?=
 =?us-ascii?Q?GdQJgBYbui1JZ1fJTe2cONZMvPrAneszNs14ym5+n6inisjarO99uFItLvZj?=
 =?us-ascii?Q?9lTcez2VfYcCXr73+xWOPi3rwYtzuGehWb+uzNkIyrFUFB9w36V2wQDd7H3s?=
 =?us-ascii?Q?ve7ozypSjLkD78igOhqIrzUFL+Z28GguMW6G7NQJOV6tvXmG9r03uSV4YRcm?=
 =?us-ascii?Q?WraL2gVvfA//z8M2R+spuWeHB3ShRll2uSVvQ6/UpiaXyXr+A2LgJD8Jf57j?=
 =?us-ascii?Q?2GAPprAo243jqOUJzUuahR7oLxcncdxcIn/hv9XKJXzZo5WlJDVoQpPgGIbc?=
 =?us-ascii?Q?2elw+RxDArkOa84w5S8TIZObGiM3u9g2pwN/7er/4nYVPylb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f1c2c5-f57c-42bf-be78-08dea6630435
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:48:53.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJyktw98t+Ut89Jl3rH4HgtUnYVkGs+zqPVKfwVvQ9nGyk46a0kfICfAPhOHia+lEewsXTFGqcoQ03omPkmI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

Expand the NETC switch driver with several foundational features:
- FDB and MDB management
- STP state handling
- MTU configuration
- Port setup/teardown
- Host flooding support

At this stage, the driver operates only in standalone port mode. Each
port uses VLAN 0 as its PVID, meaning ingress frames are internally
assigned VID 0 regardless of whether they arrive tagged or untagged.
Note that this does not inject a VLAN 0 header into the frame, the VID
is used purely for subsequent VLAN processing within the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 573 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  36 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  14 +
 3 files changed, 623 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index edf50cb32cb6..7f1ab1fbb6fb 100644
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
@@ -176,6 +201,15 @@ static int netc_init_switch_id(struct netc_switch *priv)
 	return 0;
 }
 
+static void netc_get_switch_capabilities(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	u32 val;
+
+	val = netc_base_rd(regs, NETC_FDBHTCAPR);
+	priv->num_fdb_gmac = FIELD_GET(FDBHTCAPR_NUM_GMAC, val);
+}
+
 static int netc_init_all_ports(struct netc_switch *priv)
 {
 	struct device *dev = priv->dev;
@@ -383,6 +417,206 @@ static void netc_port_default_config(struct netc_port *np)
 	netc_port_set_all_tc_msdu(np);
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
+	struct fdbt_cfge_data *cfge;
+	int port = np->dp->index;
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
+	cfge = &entry->cfge;
+	/* If the entry already exists on the port, return 0 directly */
+	if (unlikely(cfge->port_bitmap & cpu_to_le32(BIT(port))))
+		goto unlock_fdbt;
+
+	/* If the entry already exists, but not on this port, we need to
+	 * update the port bitmap. In general, it should only be valid
+	 * for multicast or broadcast address.
+	 */
+	cfge->port_bitmap |= cpu_to_le32(BIT(port));
+	err = ntmp_fdbt_update_entry(&priv->ntmp, entry->entry_id, cfge);
+	if (err) {
+		cfge->port_bitmap &= cpu_to_le32(~BIT(port));
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
+	struct fdbt_cfge_data *cfge;
+	int port = np->dp->index;
+	int err = 0;
+
+	mutex_lock(&priv->fdbt_lock);
+
+	entry = netc_lookup_fdb_entry(priv, addr, vid);
+	if (unlikely(!entry))
+		goto unlock_fdbt;
+
+	cfge = &entry->cfge;
+	if (unlikely(!(cfge->port_bitmap & cpu_to_le32(BIT(port)))))
+		goto unlock_fdbt;
+
+	if (cfge->port_bitmap != cpu_to_le32(BIT(port))) {
+		/* If the entry also exists on other ports, we need to
+		 * update the entry in the FDB table.
+		 */
+		cfge->port_bitmap &= cpu_to_le32(~BIT(port));
+		err = ntmp_fdbt_update_entry(ntmp, entry->entry_id, cfge);
+		if (err) {
+			cfge->port_bitmap |= cpu_to_le32(BIT(port));
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
@@ -393,6 +627,8 @@ static int netc_setup(struct dsa_switch *ds)
 	if (err)
 		return err;
 
+	netc_get_switch_capabilities(priv);
+
 	err = netc_init_all_ports(priv);
 	if (err)
 		return err;
@@ -401,19 +637,61 @@ static int netc_setup(struct dsa_switch *ds)
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
 
@@ -542,6 +820,289 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
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
+	/* dsa_user_change_mtu() does not add the switch tag overhead
+	 * for the CPU port, so we need to add this overhead for the
+	 * CPU port here.
+	 */
+	if (dsa_is_cpu_port(ds, port)) {
+		max_frame_size += NETC_TAG_MAX_LEN;
+		if (max_frame_size > NETC_MAX_FRAME_LEN)
+			max_frame_size = NETC_MAX_FRAME_LEN;
+	}
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
+	/* Currently, only support standalone port mode, so only
+	 * NETC_STANDALONE_PVID (= 0) is supported here.
+	 */
+	if (vid != NETC_STANDALONE_PVID)
+		return -EOPNOTSUPP;
+
+	return netc_port_set_fdb_entry(np, addr, vid);
+}
+
+static int netc_port_fdb_del(struct dsa_switch *ds, int port,
+			     const unsigned char *addr, u16 vid,
+			     struct dsa_db db)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (vid != NETC_STANDALONE_PVID)
+		return -EOPNOTSUPP;
+
+	return netc_port_del_fdb_entry(np, addr, vid);
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
+	u32 cfg, cnt = 0;
+	bool is_static;
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
+
+		/* To prevent hardware malfunctions from causing an
+		 * infinite loop.
+		 */
+		if (++cnt >= priv->num_fdb_gmac)
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
+	if (!uc && !mc) {
+		/* Disable ingress port filter table lookup */
+		netc_port_wr(np, NETC_PIPFCR, 0);
+		np->uc = false;
+		np->mc = false;
+
+		return 0;
+	}
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
+static void netc_port_remove_host_flood(struct netc_port *np,
+					struct ipft_entry_data *host_flood)
+{
+	struct netc_switch *priv = np->switch_priv;
+
+	if (!host_flood)
+		return;
+
+	ntmp_ipft_delete_entry(&priv->ntmp, host_flood->entry_id);
+	kfree(host_flood);
+}
+
+static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
+				     bool uc, bool mc)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct ipft_entry_data *old_host_flood;
+
+	if (np->uc == uc && np->mc == mc)
+		return;
+
+	/* IPFT does not support in-place updates to the KEYE element,
+	 * we need to add a new entry and then delete the old one. So
+	 * save the old entry first.
+	 */
+	old_host_flood = np->host_flood;
+	np->host_flood = NULL;
+
+	if (netc_port_add_host_flood_rule(np, uc, mc)) {
+		np->host_flood = old_host_flood;
+		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+			port);
+		return;
+	}
+
+	/* Remove the old host flood entry */
+	netc_port_remove_host_flood(np, old_host_flood);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -768,6 +1329,17 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
@@ -807,6 +1379,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
+	ds->fdb_isolation = true;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index eb65c36ecead..3efe37fca390 100644
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
@@ -69,6 +88,11 @@ struct netc_switch {
 	struct netc_port **ports;
 
 	struct ntmp_user ntmp;
+	struct hlist_head fdb_list;
+	struct mutex fdbt_lock; /* FDB table lock */
+
+	/* Switch hardware capabilities */
+	u32 num_fdb_gmac;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -91,6 +115,18 @@ static inline bool is_netc_pseudo_port(struct netc_port *np)
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
index 7d9afb493053..b04e9866d72a 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -36,6 +36,9 @@
 #define  VFHTDECR2_MLO			GENMASK(26, 24)
 #define  VFHTDECR2_MFO			GENMASK(28, 27)
 
+#define NETC_FDBHTCAPR			0x2020
+#define  FDBHTCAPR_NUM_GMAC		GENMASK(8, 0)
+
 /* Definition of Switch port registers */
 #define NETC_PCAPR			0x0000
 #define  PCAPR_LINK_TYPE		BIT(4)
@@ -67,6 +70,9 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_PIPFCR			0x0084
+#define  PIPFCR_EN			BIT(0)
+
 #define NETC_POR			0x100
 #define  POR_TXDIS			BIT(0)
 #define  POR_RXDIS			BIT(1)
@@ -122,6 +128,14 @@ enum netc_mfo {
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


