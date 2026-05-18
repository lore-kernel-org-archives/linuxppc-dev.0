Return-Path: <linuxppc-dev+bounces-21092-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487E6CD4F55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:25:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrT813R4z3c0H;
	Mon, 18 May 2026 18:25:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092700;
	cv=pass; b=n84iubgZCH4/dPwTjnZg4s3bMX/E/uniO/OvjfsSSEMbZdgmyTMxxIgIWKgnUJJYkDfH7llPIpflFv+gqY6ct6hYleHxIWhUJH0QrOlCY97iAIDoD6n+pjduWx/NYoOdifN9nsS1PN6qinphTgr7eTe+ybFJ6fYAdKNNtxIAtHHndepMDf8PxYF7xy1N2aIXTeSGK94KrTUcTLjZyDKBlJ3ph2SAxRvfvhLF8yh4SUj/Z8T8w3lV6o6KVYd/BtK1+PQhA2m/RIJ+EEi4qPe9ba5AUI993a67b6tV6b2/9aF5CDx15Zu2236gLuk5v2dT8idtg28UQvmzJloSqvy3zg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092700; c=relaxed/relaxed;
	bh=c421rWvztxm8xBPKK+QASSeP39jqCAl19Bx80fp1zXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6ovUsjFH39vxE9fdiJan8dUv2JEq83IVd3+aF6rrDdvLBnBGYu+GiWmmhOo9cEIwQcs8cKeP63rl8o0YntNmg3iKM9OkhfF/jxx5tO08syaBopelrXMPGsh5v52DJXbpK4WkoXKCYhD6nxZpG5ZOR4ZnakYnPPy71kFlcRLo1YUSoiKb2aVYNeRtjLYlU/SFklQTigSSnAFaUdgcHMEcbj45tAmTgy3U/LP+ODqmF6SYD4jWpN25GaD1ZWhEsYtiQOb1DyJJ4ZoxzrtDlsKuk0yBIMjkTP7l58/A48ZdoShexioRBZqSiAxoiGclI9YofGZA8CdDupFIJSo3xmFkg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LETqk3U1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LETqk3U1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrT53Fxtz3c3g
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:24:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KySHofp4CPTOoA9W3MxfpmRciQ2j7cOYoU9LZGJxRyKB0DhA/Md04pSuopUXEkRVsO20QXAqc1naF3gzPDkDQWXP3tbVh58EcnQf9cHoEnwngkfami7wxxY/yVr/Dtw4RP+3aeZp/156dRVl435xKJWmokDxJvEd1tl3zhaGYPFZ/0UugjtlSB1UVFPlqTnd78giMquqc9rqDQY7SM5c3vjfAOlQz0T4esvoKfGg6VqfReHkO8Xe6T7I65bXW3iskI5X6fE7Ln5I7yOUG5PaZm88sY6QalrhzgTPgSh96oUGo5ATnEkEsjdWVlBXyPsnLNxzXQUcYlk8svsWKW8P3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c421rWvztxm8xBPKK+QASSeP39jqCAl19Bx80fp1zXk=;
 b=R3bivfjAm7zH1cOdG53jZhOuIVE4rKur6Tn4xr2YzQhY7zJNxIz+v+DeHPVBmZxWsMPq5jBPHciiKEx/b1D2ztR1zkuOIxhm+aG/QLjbO6byHYIG42aaQfMfLhmYB8sy5rCnFsKMxwvWKms32V165lJrRJUtrFi3mqUnPfy/miu36JKNVUUWiYNVADjJxj/SuA0ADjGcBZj1aNfk3wR+x0Z8T2a5W8H7WNi1GWZ1YAp7EA8qxCZ0FbFHuIwNWhAq5O2GKItTGQzKYdw/Wg0G/uEjGnQxni8OzsPPMDpC2n7wBSfeU2MWdvhFUXHuQVB3uZacGS/VVI89qcyuqUTGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c421rWvztxm8xBPKK+QASSeP39jqCAl19Bx80fp1zXk=;
 b=LETqk3U1Eq8fFm8aIn867KYoYAibJDSNzkK37p2OfnraWfBL0/iiqJikiAqOq9MaGtmmt+dgSLtmzjIs1RanhS/f9nRzuxtCShgArSWBIsbidMTJtaKqxvZmOcYKxUIlKkkqpD5kBKYHKB/eqlbEZmg6+ygvRzu90W1l1EmnnXxeTFhSUJwuXH+ZiBSkoxufrDrMRMhzC6w49+lPmRWVXK0GEpLIkFo6UGW+gqmKoaEP6dEDDK+MoXldszWd0G4isi+kZkM4Gdm9I8+PZCGSETIDTP/4cqaWs84BI0aSSfv3eRjHZ62Wsxv2WVWomST1f9j8puY1uyn06IGQw3LbiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 18 May
 2026 08:24:43 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:24:43 +0000
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
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 12/15] net: dsa: netc: add FDB, STP, MTU, port setup and host flooding support
Date: Mon, 18 May 2026 16:25:03 +0800
Message-Id: <20260518082506.1318236-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf31e44-ee78-4c46-9a95-08deb4b6e945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020|22082099003|3023799003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	ZdZzdf19MCC7ICbiO7AfSserojSf+gwC7qOihdCYyqLaVx5wNtkOnmczK17J69+EpGQQourP1rDMwmTtp4vx8rJjTGqtWUq/DchhcMngoq+0T3IHHvCcn8duvzL9CBHHjDmzrpQyuZuHi34Zf9U/6cCkQQNWHCrdFsr0fO3yISNCLGIXe3xgEqBbnn8ZrIK9XQsblzaE8GgzNy6UFpOvq26RnVtO9ZYkvDuRHZsTnKo1PMCI0tnzGyhzr+Kl1P8BsQsmpelxvykK0390OXfG8YZClfzVtZsZWCYMUvyFiHSWcbysZcNCeCS/ZF5SjG9ayJDlSZle4xcOOHiN6pSy0+6yZyebMLWJeUp+lGEDKVCdR+5xLs4xNZCS0d3EhzjxAyszOO8SzrjZHA1Z3SxJ8LhxRGNKTeM8LZ78YKnFiq4TeZXNVCYg2VNcW2ivX0Gqlj76iImsydJs57mGAJ2Td6YO61Y7a2wtS6iwYrS8bFLZ1kGcVVU0BWNbTevUSpj06cHRYUoVtePPTEEPKG/TqnsWkUFdUIgOZVclr6tLVpANjMCpWcfQIPKp0wE5vpxv1Z1ORfs2lYEBbxuq+peNIqSm5YEnTOZcDCNNsbOHtCYoSwWCWRYDeGAg44ytCCVvNR/3616Aho4Kb1EgZxYth3gMECXxWBOu+ucwd3DcpXDjlQdBeWcxX7AHMB5qRQK9TaKIsEJzln1rXDpQrvgTV70hyQLv2hUButh/DF9WLh7x831NOnnRS90Mm3+rhJzdveLFQBbI6Dtqp3uhgiTflQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020)(22082099003)(3023799003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ehPH8hOLtjlgS1t1bUjB03fGXekLXrB2ZMTk3UePsNBGznvRs0rv8N8IcXx7?=
 =?us-ascii?Q?S1iNXClVSek2F7Q5tsIGp4K/wecrCISKx7cLOpuceuyKdZDpyupLQ+3/3bAj?=
 =?us-ascii?Q?+mk2sxob4U8Gf0I/R1oWGfZnlxXpi3ZJSp7WkxnT3KKojyEGK6VzApIebphQ?=
 =?us-ascii?Q?xTXmikA/xUXDGYf3XI2c4VrRAB+fKIYjOYf9PatrUKiOKL/G1cNd/SziNufk?=
 =?us-ascii?Q?SA+Yj74iTR0gaxuwET/U7j9XHWib9j5QrzjVmvCyqfjXRj4LyvoddC628F6r?=
 =?us-ascii?Q?k58G4kVr9HNQEiAp1lQGWauD4nPWrIyRNk9pv7aNnE//vIPG5W2NTJ14VD6j?=
 =?us-ascii?Q?KErhGxkX9tVup9rlKIrEu16IVWIfgXh4JjBmSCP92n4l5i8STtVrsQ6VLniJ?=
 =?us-ascii?Q?hprJlpIUW/KHyluLyqH8k9cGMiDOQ5skG0/EbkjAA2jl9hWMaBn8yeM1V8Gt?=
 =?us-ascii?Q?yl8UxIDG6UWHjYD1WjcXwNTf1Adsl2ShYbPglp1rlGvq5ZDutfFoiz9qRMFP?=
 =?us-ascii?Q?8JyiXKORQZQdBQaGZ6GvV+5r4Lstrep4H2lOId8wNLD+H4HQbFx7M8wKtJDK?=
 =?us-ascii?Q?rhokHnqwN9r5DV4rPn3MgMTpGSs/XJprmd1W9y4gYXCvysIvo1rL/tUXACtY?=
 =?us-ascii?Q?CMqZsLzOUEfjimfgAyIHfNyJQM2Uew7L52j7NEYpJesIsYguKoRdiRuLSJr6?=
 =?us-ascii?Q?mgd1ddbwzh+ZRxe7msUPJU7upsL92sgTbChb29Iw/MVe+V71c6lWD1BpzEaO?=
 =?us-ascii?Q?ol4rzKDX03eJrVMXm5YD80uVPGW13aswFYguH3IlHXeLN4OtD+3YUbINbxTB?=
 =?us-ascii?Q?3nxL9rZlhq7t7j6uhHFLpfD7idCJ6URkU7YmObFNMHRIY391uNISslqqyH+B?=
 =?us-ascii?Q?eRVtKO/6baVnM7DT0BXs4RNpm3kTpjcD1KTXMNw0M37Qf9ykjiNYd2oCAyqZ?=
 =?us-ascii?Q?fE/LncFSzDMRMEMeFartGWOGl0RVeMQptbSCesmvqu0iqtR4OqNMLRdUQqVJ?=
 =?us-ascii?Q?AYrrDBuAj8XdbOgEuLPKLa8bdzgTGZvDLLDPqky+befxNolKibctrxXqqu77?=
 =?us-ascii?Q?gjMd4f4PmVn3evHPB9hHHdNZZgqsOoHdHL3mL/hYJ2ayWb0CuHqI4gnzY9Yv?=
 =?us-ascii?Q?JzIvQYpC1FXcgnQK3Hjc/AJnDLFW+XWedS2I7W3mLk2FtMgxDQGCarMsGRrT?=
 =?us-ascii?Q?ecMfjuzkY+N/F/Z3qQrtH3I+m9wEX5ZBA7UeQyoEMY/7Va4YwUR7LGYRftUi?=
 =?us-ascii?Q?CCZGUvyvVMX0kZg74u5ZI2Xz80YwYz7iQnuL5fo5djQJle35i1cAGPb+z3zX?=
 =?us-ascii?Q?Qpiv+5O3R++xKWJl/vZhoqbM1XWdrqM+BxYCcRtMpuFS8ngdVmEVCK0FZ/iY?=
 =?us-ascii?Q?cdhU2yVMHMVMRiImW/PNRB50cKOjqyHkDtDCbFuumoV2wXpuj54yB2zzHvVF?=
 =?us-ascii?Q?9K/HOnQLGTYvjwHKfZDWwiyrQtTIUsFPXH4VEglN775WX6CRBmvryJNlOkE+?=
 =?us-ascii?Q?k7ACMObq3xbU7K/aKUM/g2v6O9+KxMLj9afJHQGvlYPEFTlDt53oZMkI6qYB?=
 =?us-ascii?Q?gVYwmpxDKdSz+Bbi4rbDq0ktZXAXoF8ME9F1UCt/lsNDfjfAAkENDEBWcSQr?=
 =?us-ascii?Q?SltR4kp6rUKE4RheM1S5+VS5dH/J+tUgTwTL4BvndQVzA5QHuE389M0NrGOE?=
 =?us-ascii?Q?jGjQlzglfmbnR1bZ3oT4xz802kfLyqdYLapWcFBlR9J4Hwgm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf31e44-ee78-4c46-9a95-08deb4b6e945
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:24:42.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qak2MJ7YtjB8JTy1qA7VWCPN6EyXvBPBy7HlnZVzYjFOrUEaD1qkkMLytbTyz0CYhgYi5HO7fVujb1q+ubi2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

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
 drivers/net/dsa/netc/netc_main.c      | 601 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  37 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  25 ++
 3 files changed, 663 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 2141b3aa96b7..9dcaa04d9a65 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -4,13 +4,39 @@
  * Copyright 2025-2026 NXP
  */
 
+#include <linux/clk.h>
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
@@ -83,6 +109,22 @@ static void netc_port_get_capability(struct netc_port *np)
 		np->caps.pseudo_link = true;
 }
 
+static int netc_port_get_info_from_dt(struct netc_port *np,
+				      struct device_node *node,
+				      struct device *dev)
+{
+	if (of_find_property(node, "clock-names", NULL)) {
+		np->ref_clk = devm_get_clk_from_child(dev, node, "ref");
+		if (IS_ERR(np->ref_clk)) {
+			dev_err(dev, "Port %d cannot get reference clock\n",
+				np->dp->index);
+			return PTR_ERR(np->ref_clk);
+		}
+	}
+
+	return 0;
+}
+
 static int netc_port_create_emdio_bus(struct netc_port *np,
 				      struct device_node *node)
 {
@@ -163,6 +205,15 @@ static int netc_init_switch_id(struct netc_switch *priv)
 	return 0;
 }
 
+static void netc_get_switch_capabilities(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	u32 val;
+
+	val = netc_base_rd(regs, NETC_HTMCAPR);
+	priv->htmcapr_num_words = FIELD_GET(HTMCAPR_NUM_WORDS, val);
+}
+
 static int netc_init_all_ports(struct netc_switch *priv)
 {
 	struct device *dev = priv->dev;
@@ -198,6 +249,10 @@ static int netc_init_all_ports(struct netc_switch *priv)
 		np = priv->ports[dp->index];
 		np->dp = dp;
 
+		err = netc_port_get_info_from_dt(np, dp->dn, dev);
+		if (err)
+			return err;
+
 		if (dsa_port_is_user(dp)) {
 			err = netc_port_create_mdio_bus(np, dp->dn);
 			if (err) {
@@ -367,6 +422,220 @@ static void netc_port_default_config(struct netc_port *np)
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
+	 * MFO_NO_MATCH_DISCARD, so the frames will be discarded rather than
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
+	__le32 old_port_bitmap;
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
+	old_port_bitmap = cfge->port_bitmap;
+	if (is_multicast_ether_addr(addr))
+		cfge->port_bitmap |= cpu_to_le32(BIT(port));
+	else
+		cfge->port_bitmap = cpu_to_le32(BIT(port));
+
+	err = ntmp_fdbt_update_entry(&priv->ntmp, entry->entry_id, cfge);
+	if (err) {
+		cfge->port_bitmap = old_port_bitmap;
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
+		/* Currently only single port mode is supported, MAC learning
+		 * is disabled, so there is no dynamically learned FDB entry.
+		 * We need to support deleting dynamically FDB entry when the
+		 * bridge mode is supported.
+		 */
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
+		/* The switch has only one CPU port, so only need to find
+		 * the first CPU port to break out of the loop.
+		 */
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
@@ -377,6 +646,8 @@ static int netc_setup(struct dsa_switch *ds)
 	if (err)
 		return err;
 
+	netc_get_switch_capabilities(priv);
+
 	err = netc_init_all_ports(priv);
 	if (err)
 		return err;
@@ -385,19 +656,65 @@ static int netc_setup(struct dsa_switch *ds)
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
+	/* No need to clear the hardware state, netc_setup() is only called
+	 * when the driver is bound, and FLR will be performed to reset the
+	 * hardware state.
+	 */
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
 
@@ -531,6 +848,278 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
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
+
+	netc_port_set_max_frame_size(NETC_PORT(ds, port), max_frame_size);
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
+		if (++cnt >= priv->htmcapr_num_words)
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
@@ -757,6 +1346,17 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
@@ -796,6 +1396,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
+	ds->fdb_isolation = true;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index ac9743da2a1e..bef356500329 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -31,6 +31,8 @@
 
 #define NETC_MAX_FRAME_LEN		9600
 
+#define NETC_STANDALONE_PVID		0
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -44,12 +46,23 @@ struct netc_port_caps {
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
 	struct netc_port_caps caps;
 	struct dsa_port *dp;
+	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	struct mii_bus *emdio;
+
+	u16 enable:1;
+	u16 uc:1;
+	u16 mc:1;
+	struct ipft_entry_data *host_flood;
 };
 
 struct netc_switch_regs {
@@ -58,6 +71,13 @@ struct netc_switch_regs {
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
@@ -69,6 +89,11 @@ struct netc_switch {
 	struct netc_port **ports;
 
 	struct ntmp_user ntmp;
+	struct hlist_head fdb_list;
+	struct mutex fdbt_lock; /* FDB table lock */
+
+	/* Switch hardware capabilities */
+	u32 htmcapr_num_words;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -91,6 +116,18 @@ static inline bool is_netc_pseudo_port(struct netc_port *np)
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
index 7d9afb493053..5137187ee8a0 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -30,6 +30,20 @@
 #define  DOSL3CR_SAMEADDR		BIT(0)
 #define  DOSL3CR_IPSAMCC		BIT(1)
 
+/* Hash table memory capability register, the memory is shared by
+ * the following tables:
+ *
+ * - Ingress Stream Identification table
+ * - Ingress Stream Filter table
+ * - VLAN Filter table
+ * - FDB table
+ * - L2 IPv4 Multicast Filter table
+ *
+ *  Each hash table entry is one word in size.
+ */
+#define NETC_HTMCAPR			0x1900
+#define  HTMCAPR_NUM_WORDS		GENMASK(15, 0)
+
 #define NETC_VFHTDECR1			0x2014
 #define NETC_VFHTDECR2			0x2018
 #define  VFHTDECR2_ET_PORT(a)		BIT((a))
@@ -67,6 +81,9 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_PIPFCR			0x0084
+#define  PIPFCR_EN			BIT(0)
+
 #define NETC_POR			0x100
 #define  POR_TXDIS			BIT(0)
 #define  POR_RXDIS			BIT(1)
@@ -122,6 +139,14 @@ enum netc_mfo {
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


