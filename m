Return-Path: <linuxppc-dev+bounces-18581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B206AD58CDF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:08:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN563M6xz2yhV;
	Mon, 23 Mar 2026 17:08:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246090;
	cv=pass; b=SylDjQ9C7Jjo6rsq4CQaGfzx0UZULmBU7ae77r9QRA70SVnd4jnkFs6v7sA26SG11+1piyrlGaJXomFZk2ys3YN4nahIWBdAlF/HR8xqD2h+yEMS/ayxK8eEuyjPMFB7tSR5QMqH5CluotTfkPGn8Yz64V14j2r/eJ4D/Hs4+7lp2AfSr0UkFEagduAr1pUcLFqA/1S8Kv3bGvet9s0fbM7GoQLqdMi7+uYEHZ3H3xgAcwKax4a0dK/ux3uemRADa9qLi9tM4JeZEVpe2/xtYL4C1gDcv2tCgdJTMPVW4Q6nbIKAASGGejGZ4QfhZmsDKNlA/aMatubxUMaRlle2kw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246090; c=relaxed/relaxed;
	bh=vI9H6zuxhry4burG4rZr1Q0beK4z4sMX+cIS7LmrB8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nG/OLSSoRplTdvV3bKTIFCjPv9TnxVEcYER9e2RBq3lJXNYV/C+QEkBDUe1JAu/k91d8HfQXH3+c2ZsABO3I8g7Bs+NRx8/S2O/SmEjSB2RwkBRcsCxB5QN6LG6JfgvKCm4L/QxTeDqlwXFPr/IbE+lJa1NJR0vTZaZO8eNL0LpzRe5Z+rvgYJbXzhyfEoz07aFXR1+Zw9/h0q/QMdz2UJR3+4WW2OeSS/dz19nNiUDFuuoPc/xQUZxMnyJUbOw2x9YN1hNIXov5gVY0tyI+mg5fzReMwXJVL7fxFVshFtyAlxkVNelICvwZKa8/oG2B8d443VR9gQ2dJ+1G+mXO7A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CM5H5TAU; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CM5H5TAU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN5516Nyz2ygf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:08:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQlrti97VmfZfPIRN3/FCgCeDEFNdovPatcpITyTU9uQEW8QTYNPIDbpJgA5QmHFENX1kQACsfYDPBIGhtUyXFjYleUsnZkq9ID3Mxl+zwWH/hdeZ/IPAfTxLUd/lj+cU813w/mKJRwu2hczazuxWgdQyBwDs4svaQThcbgQFByOzngLdM9pOGBBJpxjhUTXAb3zRwLqWsLJDslOCGtkwVJwH8L6BKOmgxakO5QnHTpaVfNPKMNBoo31dK96TMFy8s6v2cF1BoEHCN+LSV9KVJTMq6thYcBCFYWxb9dhwqdgZaMQA1qm/wrygxLXC1+Brv9iZ+WnydQCWO3pAl42gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI9H6zuxhry4burG4rZr1Q0beK4z4sMX+cIS7LmrB8E=;
 b=jOGn/dubxZhRzT+bDMWEmYkCr8x0S9HC56kRKhROnj9InbXkt6pdE/BqUl439ST5ackUKJFEVaSxowjoIYrCtIDLGqbD71H3hMOl/ZE1jXvXUY6R15hlrzgOfoZaGdekaqowzUCo3imvlIPAR1uDW0yyVw/5cDPW4wB61bS3p9f+Km1iwlmik+tY7/uivy14WSva/Pkhf4qQaMFRqD2In+mpOZ9vJOdopbbXiEZCtHHl08GU8SQKBRx40WvjUuUKN43Nd4Se91k1x2sGWmPAthU1J/va3S5puPqkj633HanL4e/m915Y950nAzC/qFUm9odfnUOmfWa0xZwy6yBVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI9H6zuxhry4burG4rZr1Q0beK4z4sMX+cIS7LmrB8E=;
 b=CM5H5TAU+PmxkUVCJutffR5mhJ3yUWe07DzZEIJSApvdKfBrHy7nU/3htKs9SmM2Cdgtf0sVtqML+FKzunWIMgFYY8kEiJCFkNIlQD1I85r8X87kijBx2f0bWaLeGZL5uhVqAW2bvN5bMEvb4RvUBKEhhQcjzUzOmMaGmoLo9yBQ7WaxhNRs9zeIw4RlhUGXsoW/e7HJhr9z6JCcgvmh4gKHvCBCiA4oXC3IAJq74uvmUKZa3qlWTSFvkfAZVXGcG+ukn6lNBJ+vtIwbjWest4PhMVcZ9eFGDJId0WXBNlpjIigAgcgtAUjgw14SopeYJR+jS3h+jBFbDlhU7UvGYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by VI1PR04MB9882.eurprd04.prod.outlook.com (2603:10a6:800:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:07:37 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:07:38 +0000
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
Subject: [PATCH v2 net-next 12/14] net: dsa: netc: add more basic functions support
Date: Mon, 23 Mar 2026 14:07:50 +0800
Message-Id: <20260323060752.1157031-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|VI1PR04MB9882:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8fe64f-c8ad-4cd9-09ef-08de88a27c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZCwTGzq9iEA5jTsA1HYr3mqkHBPIuU4a7oJK1Ru/Hc6RQvZAbK5O8IHm2R9195Jd3+dFG6pipJyRYJ9Xbt/s3reVSfpD76/CBu67ex/ih2gqU25LKHRfrwalze6CeixiuubgqAPn6BFraLxICkctCNcFrXI8nLsR8/ilzfIVUmUNrmCkAOAqyS3jFU0OulDQO8jQgrjFhazibcpgWU62Z0ljYSLuBkivhIPZOnOIMRkz78Nm8H829nCsA/vWyVqbhV51VYnN39u1bBT/BSn2DEaw7n3KpVeAKvxeVoA5xNVyqMpXm5Ka5TZg0IPIINhxKr/ql6nvX93BCR5pFAt46uILgicnx56OpDMWhtoSqXl9q/f+sdsoQTexZEJ4Aaqfn+eMmTqDPoNZlBdNANScqPLJXWW7vizsqXrddqrZcyW6Wevo2mwe+vaXATpXZnWX1t/GnPTeu1ZqKfi1HStkLplT6+C+btesIOIxVHeCteTPMcsSNc8GkdpZafYNJJlrwaaREaQEiFM0717MXUPzNilrgMy/BJvFDPSAEX27IXe/pX1xwUxMNOVqNAs0ygexLpj7g2zcRQ06h3k7w8IRT6iHGlAF7ZQv4Ez4PVnv9JsduL6BaM0K/DxyvN2L7zNRrDpv4DHHYpW7URLPQYb+XA+XIoH9TGMh/3NqRO97RyPu/DQkq/Heh5zdeAAsgyEADFhRIN3xpKVfOmR2+AYkkNP+AcstR8Ukkjc132hvcDGA67pvGHqJebux1V96cyZq6myJ9wQI2WrwCCmuC1+iVQv4BNLZo81inK58F0ON12J4mA4Z/Mt/dXx6mviO6c7N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSgizxMekDOisiUBRz3ywymnM3ulyMG2ordOt+It17N4UramZJXli3Pe7RPs?=
 =?us-ascii?Q?6pFE3mcn1N8hBM5PuOSoAP654cONZbRXdv0sAaFVDTtQOWR4syNlCm81hQfB?=
 =?us-ascii?Q?qyvhSpCIVOWXRp6O3AJL8WmaBGBlxXmrpLOwQFBf3YV8z9f65Jc4XXDRZ0Kk?=
 =?us-ascii?Q?QHmQD0BCsEbKn52UgPe6+qdtC7TWj08wL7L0nLKyVqMS5J/HwylnTqJn5qX4?=
 =?us-ascii?Q?jGZbXXxEp8504XzPXimdg8WYhbmF/F0LG7VggIH+RvPr4ugZFt+kYKak67FW?=
 =?us-ascii?Q?5L/9COzmXTNa03b/KplO5UZakSwREFdtZnHzA7rgZ9gK15Dht1Gc6b3F5K0T?=
 =?us-ascii?Q?14LuBOBm2B5+eXI9FmBTgZIYR0KeRDJnrsg/w3eYL/dNd47FZb7wgkdYe7sC?=
 =?us-ascii?Q?+ecWVjQflxSeX2KAgftcVEeQ432xLkNkjWiLI13FEimPhjorAGP1GFNyVcc2?=
 =?us-ascii?Q?2nEe9pDH2FuYh684YntiaWbu/iJu2jSElzdSmD6Y0ft19LZBDwtv4HbBEH7G?=
 =?us-ascii?Q?Z0KTZEGbYPoPLiEbXigkIRSsHhx1G806OvGH5UTlrA7QR74M7fRyWPFz1c7O?=
 =?us-ascii?Q?CLrGzCF2JlbUYT4ittDyY/SMyp7JWHO0cIkv2JQ7ePANPZ9oNnFAHXz3K3oZ?=
 =?us-ascii?Q?L1rDnbA/17YnQv5zQLUIpHBNssxhNgxnoXrDua25WKaw+3LUeTIBHJL/dJxF?=
 =?us-ascii?Q?j9W5MDSqNjevdVDrpLOQsS9frCENbtp1XfEGIw7ED0EPD8tv+mL2qOOB+hhX?=
 =?us-ascii?Q?YBX6bijffKh1ur3pUMHEnqGcUFC4gPmLx0txeI2SraAUhCBDqj6yZBlmFSSS?=
 =?us-ascii?Q?dHzGTeZo6HK7FaehPKYfzn5UyMwh+gy+rDHi938yrzeXueL3+tmUZdIUcy2D?=
 =?us-ascii?Q?bJkxfsew+kF7XSX4zfD70VcZcOevgFXTuoUrhLMx8WHfknNTQTZqP2sSdsxz?=
 =?us-ascii?Q?T6jGnqRuctc2RlCXkF+y3COV6WUfo0VZhYy+jDw7ZkgDVnMpnvdkelLOuNa8?=
 =?us-ascii?Q?pvH4TWOMq9ocGDQOrV5g+ETSFXOW2cc9yrYQzvlVBQuuIk2wBGk883I7c0k3?=
 =?us-ascii?Q?ylmARrzWg4EIaUBI6SlLNEhClC17G8IdkSDRpXTmJ3LV4RQPY/NE4LbBxQ+7?=
 =?us-ascii?Q?HEHQlX6AAE9Pu+8eYE0tGIdiQEqcJVI0b4mjDHFpph8lWkxdY9pOKs1jKZs5?=
 =?us-ascii?Q?fGqeCSqSo+XlGaNW43Sw7AvjrFflOLBFVeNpn4wqYrDgepkO3cnn85iAeQxs?=
 =?us-ascii?Q?zUxMW/QCLWUY2GVgAoYnJc4+Qxy5l6aQz/dzjEZJK99S5THqL639kcf0gO5c?=
 =?us-ascii?Q?cZw6NbqFqzetUU40E1fm1sUu2mY0GPRyzr5ASU1ff+B8pdsVegWuPNwRJ08g?=
 =?us-ascii?Q?wI6vt51u11Y2+jJ/+9jwdSVay7mdJtsXJVGHvJcIQd1a1dSJriE8hstvFmz0?=
 =?us-ascii?Q?goGWshzbaFyuv4RGZC05flpG/Qs+ocfYROfkvBU9BWi5Qbx2hY4u6kGQE3J9?=
 =?us-ascii?Q?3DaE4RJleMt81SI7zJIgd12zkVyDIHfAssemz+MQGbFtdoXTZ7WY/aVK+DeZ?=
 =?us-ascii?Q?WADnI5MWVFm9YXb6MI1X2X9IxOCzXoYqM+UMLIPYgzbF0RLj5G63+cVUubPx?=
 =?us-ascii?Q?lboKwtyXLey/sWzvqnNBXREvehNh8EO6aY4vz/UDU5kTBv0Y4aztca8k5cIq?=
 =?us-ascii?Q?M7lSNdW/M81R+KwoVzhRtn6Nt/jUPlyi2+DAiKVV2rieffBrN+u7DHxKgbBa?=
 =?us-ascii?Q?YylnPeN4Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8fe64f-c8ad-4cd9-09ef-08de88a27c42
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:07:38.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krCs3o3GNV9Nr05z50tH/RIwmOOeDRlmmp1JAzfdgjR8rBf+Ye9CW7fpqEnrjkYBtSX0pSlCRa9BXIpWtV9KhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9882

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
index e2d88496f5f3..4b331971dd8c 100644
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
@@ -784,6 +1312,17 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
@@ -825,6 +1364,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
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
index 6d7758631e61..a2b0c1a712f8 100644
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


