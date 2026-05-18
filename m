Return-Path: <linuxppc-dev+bounces-21085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C69CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:24:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrS35zCJz3bt2;
	Mon, 18 May 2026 18:24:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092643;
	cv=pass; b=BuPIZthZkhGTvcCSXZ4HDOmUwesXksPWmfAqlTn9RtpgZpdQVildMtxNdIK2O4hVWzSInADEVknO7b4VEQGCZONQOAjTIxSZctMMGu0prp3hYtE0HU7kTlfq+mq/VdoESiE68lQVyJc6WxcsNexMopD0p+JdWjfer8J5y8IbYkd2XZ1A8FaZYiXwr/pbPCPGRESty5b/iIqLgCeKZWU9Z+V+/aC0r9uiXrj4Yirn6oNhBeW9VX5GEKiXpPk3y4N5xhLleDm94rtUXJclW9GciIV74FQGXp7lM3VPelOIh5U2kuJVBuNcPcr0yy+jw3hB8FC8qE3LlZEOWwA3QrwNpw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092643; c=relaxed/relaxed;
	bh=Q6enbRcT/dEPo1XQuXSQ9rwIRkppP8bQaCEeL8mOHXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NcyvhD6W9ZV3p3i+hwJjZ4J0ACt+XmT6MUsNOWWS0nqvaq6W3iebEuK/ET1wnpLBiwITLZo4UjcNIikkVeZgUrzRZyIW9t1lMSgsjDzjsn0miuZQqYW/1HkvgtUTUYJs46zSM4m2gYXT1sBIkj+eSJDs1XTMsLpQ5Ve/Ty4qheBUdYBzRVcQABB1dlC15UEB8B2glseyKVvv/SX9GNKd5vXITh9UxErfpMmq8Wr02dxQb5ulix6Y865pCi+Wz8YTC8cxortMJq+X1Uj+4xcZ/IUrdzP5X0E9/MjGTVGBcomDlJReOXs3CNq2updRviGD9+TurlC43cRMXkScBSC2ig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=eIvBiMrU; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=eIvBiMrU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrS24jcxz3bsy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:24:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgYmtmBhcKep287pPj5V5SzM4zj3QMuBas0ek596CoRhj0dcr7ow35dPmZWyect9Cp9GJN+Q+h+LrStcOZZ7bymqE6ngZyXFoYORaG3dUxXUKbFvpQyuFekNKggrpEB4mkJvjzQmL+NcaB1bwHDOj1z0T9TNLeWqS6S76lvEdJJLd1AZEAsK2ZDjnqF/I9O++57MNcrLjqNiPjGmDCRFHf/StOVakKKfEKfWYKxKpE9/I769WnL0OPYdTFQWJRC91il/GujkkvYYYgp2cEqVvewpqrg09xC2r9XzUmhCW5XHHXXwPsHokZlJ8yvIrQgMWUAdpDptfvfd8GVaq8g9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6enbRcT/dEPo1XQuXSQ9rwIRkppP8bQaCEeL8mOHXs=;
 b=efIGJR6BJrHqZBeI4QLgs2W5N9EFwFZ3ikKvWOigfnA2uslbvVVJGARXQr7RSiDM5DJtf8JrYNvTSUcKKKxD4FQWPipKme3CvD91CEKo7gIAWIQkZcZpFtJE5Ruy4ukPjDuSJJwh22g1JUcUvIPSIc/yRsy8/r58Npz2uYtDcqZzSWWyBCaaQKp3At8kxljVH31W03+FOmfUGwhXBSXywwvEK88FumS+BbzrCO3P5mMsC3G/Cf0olXMoUoJzKG9xHPZ8kqS4rofOxcQ0BcX974k1tVDA4RCSmqzwPaChvE34itOkx3qPUcQN1T5nRyOzwdT6Hmpl5StvBEeacH7ZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6enbRcT/dEPo1XQuXSQ9rwIRkppP8bQaCEeL8mOHXs=;
 b=eIvBiMrUxQPYg7GzcVmMTsHDxgFoXQHLWc1d5H9BfdQKb+kJfjxByC4MfipBrrJgn21CEsc8yaiyYD1W6a4WCoFB3tpUNb05XOLVVoYEcfSAx8jS3FuCy/ac54+KYKqsRKvLBprgktyQENUUaDCe2nYEZTVCaosO6ieHNKp3HJmuQF/ymn8KsvIWc06o3MqGzmh3AkFGgz6CV3IoAKmck7YpVDU4kL1ESwu0PdSCB2ZhT1umSu0AscmYocy0sdsgs2Crx6SrKxMEL3C0/K+wUuyksbC1Nm+wdgCQHouY6cn85ZqT2xP5zXvjFB3lVBu4gXLc7YODujpfHQp4nsr86A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:23:38 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:23:37 +0000
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
Subject: [PATCH v8 net-next 06/15] net: enetc: add support for the "Update" operation to buffer pool table
Date: Mon, 18 May 2026 16:24:57 +0800
Message-Id: <20260518082506.1318236-7-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7edac7-a029-4536-e962-08deb4b6c2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	+JbI7ugRDAEjjSXb0aUEg3fgru6ZyPPWo7sglC4NcNwhgXXQBFyEh/i7RPpyjEX/QPyvgePJH0HTDpC4NVcNk5EzXRMx44/SJyNvz3bMLFYWvaiEmCdZD6MCdKYzQ6HMuY60xvgXJFms827Le6mQqIf2TS1dLA5ZPv6oGeLlaGBzURTjmE+W0cQmT9syctkvZEXcYikMxXTek5dmWRsZ06IZRNs4SDWVzON9GgbYtI+URsSz4KChtUkt8kDT8S2ZtT9PRKgBCkRoXDoMkrKGO6Mv+OZylAMT/qZILY4kbSjSs6ue/UX4y4n1UDeKcgAuANctsUbD8kQ/RDxLaviOqIHF8liuE7Wx2e6cBvHi7gqvoGSqBh0B13A3b7AYbwl015wX1HdrQN43n73ALbmLKt8aQud5T5BaOrN3s7EwrQpAbX4+weLMraf/6OcCzNQx/BZo3YxYZFKygoNGBW0RExOH7Y3YnmfUoQxL4xdvHeF5i5JvDy6J16G/AZphzawNZ0dTvaW1XPN1a4IKN3mdswtAicDCj7hF2tbGmpbkgAQ3I5h5TQVkyObQCU6YAg484tivZSUXmmOFwa6Ods1ZeK7jyZd0lOI/6B67xxRKjFu++YDGZ3gWD4FQWuLyhHusu8BS+ept7L5vfMdHN0SwEjY9zTbxcoDU25LxkBLoQfkuN9Po1L2kkmcNDbFqqYmcrkqGCxtKwCPwxB/YKLIIZTiSpi544lZUQEN89ML1GfOglWnTWXSqI8Tn58gMIBxzMTFkBr8qxFw8gmrAuhDcUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?acVmqyJqPD33qp+m2DGj5z1WDrT7qp/bPUgTVx+jCaAt0zYHJRkhUzJHC1X4?=
 =?us-ascii?Q?e7drOlMNnEfg5z58F11IifOM0ovE+e3oTznNn3eJP9yC1ZIQcmEhLjjx7pIF?=
 =?us-ascii?Q?8Ve621i5P4WSipd2peASHM9XHBkJxLioNTAosrVzoTuzaa1VO/F0CemeeTpO?=
 =?us-ascii?Q?LNOPc/lCrjlruWmGAdbzQebsv7a16d7uNzsFMUS5ikS4jnO3LfyCrauOg4+t?=
 =?us-ascii?Q?Akk3GyKRLM5KMNP3qKC8BPa2/dhOobAT+T3O47xe4XysYevV1682dwUwa8cl?=
 =?us-ascii?Q?e46m0phzoRUyVu7K5rKZZGPyF0DsG+uI08DE3oFmICC60OqFk2+bxoo1d+bl?=
 =?us-ascii?Q?oOPwJ5qxiIKomyye5ILFHnwqrhG+bSy4j9eNbmSoGJkkgns/3Q4jROFvdRdz?=
 =?us-ascii?Q?sC53Y/h90lC8D+eUi0N8I9JxaFu9vc8wT2wCj1YF/UwAvcUSlAZI6CK0bPAO?=
 =?us-ascii?Q?jalGdw8IWGdSttvfnXgmzwP5Z5hqBHZQF+qs45nNBKlkt4BooPlYvk2VDyXk?=
 =?us-ascii?Q?zzM0xlcHNuNSKvvTwRwKHAFHPN7SU+rAQUKEQAtxFpvvpIxg3HTiGg5JZW0/?=
 =?us-ascii?Q?N5MDLv8dW6taJD7nO5tw22VTLw+DsqdrE6cH59LWiAVV+/62Q062PqRHJe5Z?=
 =?us-ascii?Q?wcvpFgrachx2nMx2KISFDA1B4w4AcKjzVyU3cJVhTgPdu/vTvozCZ+bZdXXV?=
 =?us-ascii?Q?NIRhDmj7seMmTsX7Ytaws8w6+vgvlyJ5r/A15DfJDHvzZ83Rj4+Ct3R7n5co?=
 =?us-ascii?Q?Wapk14gMMDkaCkUb+lo9wRSVUtJKlorDHI//H3uSHpLh/1DvrTb3FRq3hjIw?=
 =?us-ascii?Q?AW4W8D7jWLlb+dbNa0pjqvbKb1V86IFS4BXeulioPyWFt96vgqZvagAmFSwm?=
 =?us-ascii?Q?idKXLfApVF9pBYqQ56n1gInXIB32nkB8K2Cw6I5E1TJ0OjmuJjNyXyZAQ1vJ?=
 =?us-ascii?Q?J8/++SBq3ASUctXI2L9n/6j1Oovd5GXf0FtUzb6D2uQJ1gec0bKEhVyv2sCt?=
 =?us-ascii?Q?oPCt49AdeKuEtf1nUhhluzdl0RLcFAEkI82cB6W9YFn0PPpWpJLs91o2iYkc?=
 =?us-ascii?Q?8lRTZgTOl+EzPEVPdgDLWryIzUqIw48A81GcHDWznZM+bVtzkhhwGkUlPGeI?=
 =?us-ascii?Q?EXLS/0zwTzPSdGMMrqmMv4F5oSBD82RhMYYy+ouECWaMaDl09wCmYyUTyW0U?=
 =?us-ascii?Q?cWvWuVBhI2CCiSOpHX1TTwxjydUMhT62MAE+pj1fOP+ekiwJSWjtY3dj3lmy?=
 =?us-ascii?Q?UNry6aPdwimuXYnr9HX+TzwWD0SG/EevJuuWpUlLeDOLpTRmPphnGSXS8nXL?=
 =?us-ascii?Q?c5glPPSGdHOmx/P/ERgVKXG0JwRVFdHTvOlAQJ+xEZNf36FYzDY2QWKV7lE+?=
 =?us-ascii?Q?L/nm2zHBG0E2GamK+B0ksV6B5IMknIdMQAYt3y7EPIEF/2GvDLmUVQlOc7gj?=
 =?us-ascii?Q?S6E4SaIvrpk0eQhHLKl5OgW6dU6fRsgauBUMgtNUSbo+el8orkFhmLDMjW66?=
 =?us-ascii?Q?PK/YY0+WMQr+H41PYwQn1aEYN6X/ZL9rvmBXMNbNp7EguZ6ON4RXQQ4zpUo+?=
 =?us-ascii?Q?kVXnKSa1gXCVBFFNsrQHbrLP0b+yX9oLbMUf+j/MJcIdTImEmzwB2bwMR/ua?=
 =?us-ascii?Q?gz/aGea/7URlKGiJR+GusxoE1gsvZn9Yq3AILWngKqM9580fdNJRJP9BHJLW?=
 =?us-ascii?Q?nGR5utWB/tAwJaZ64K/1O6PbCAkDnhkXsR8u4lQj/4ZFlaBNaukmEG2Y7YyN?=
 =?us-ascii?Q?7HFhp0W9sQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7edac7-a029-4536-e962-08deb4b6c2a9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:23:37.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Arpyw0YZdVv12ZCzIcevlyQUuj3gapZ+xXXl5Hny1MNw7EE/N0bS2ArpSqOWowzPDmwXDP8s7KEryZJV8sh5iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

The buffer pool table contains buffer pool configuration and operational
information. Each entry corresponds to a buffer pool. The Entry ID value
represents the buffer pool ID to access.

The buffer pool table is a static bounded index table, buffer pools are
always present and enabled. It only supports Update and Query operations,
This patch only adds ntmp_bpt_update_entry() helper to support updating
the specified entry of the buffer pool table. Query action to the table
will be added in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 43 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  6 +++
 include/linux/fsl/ntmp.h                      | 25 +++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index db74a9107975..ad89be85b185 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -23,11 +23,15 @@
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Specific Update Actions for some tables */
+#define BPT_UA_BPSEU			BIT(1)
+
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
  * ID are not returned.
  */
@@ -271,6 +275,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_BPT_ID:
+		return "Buffer Pool Table";
 	default:
 		return "Unknown Table";
 	}
@@ -749,5 +755,42 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
 
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge)
+{
+	struct bpt_req_update *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Note that BPT_UA_BPSEU is used to update the BPSE_DATA of the entry,
+	 * which is maintained by the hardware. The BPSE_DATA is not present in
+	 * the request data for 'Update' operation.
+	 */
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
+			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
+	req->cfge = *cfge;
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_bpt_update_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 575ee783be47..64df49e9a3ef 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -175,4 +175,10 @@ struct vft_req_ua {
 	struct vft_cfge_data cfge;
 };
 
+/* Buffer Pool Table Request Data Buffer Format of Update action */
+struct bpt_req_update {
+	struct ntmp_req_by_eid rbe;
+	struct bpt_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 3672e0dc7726..5fded868725f 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -33,6 +33,7 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 	u8 fdbt_ver;
 	u8 vft_ver;
+	u8 bpt_ver;
 };
 
 struct netc_swcbd {
@@ -123,6 +124,28 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct bpt_bpse_data {
+	__le32 amount_used;
+	__le32 amount_used_hwm;
+	u8 bpd_fc_state;
+#define BPT_FC_STATE		BIT(0)
+#define BPT_BPD			BIT(1)
+} __packed;
+
+struct bpt_cfge_data {
+	u8 fccfg_sbpen;
+#define BPT_FC_CFG		GENMASK(2, 1)
+#define  BPT_FC_CFG_EN_BPFC	1
+	u8 pfc_vector;
+	__le16 max_thresh;
+	__le16 fc_on_thresh;
+	__le16 fc_off_thresh;
+	__le16 sbp_thresh;
+	__le16 resv;
+	__le32 sbp_eid;
+	__le32 fc_ports;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -149,6 +172,8 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				struct fdbt_entry_data *entry);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1


