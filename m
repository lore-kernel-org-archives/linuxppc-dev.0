Return-Path: <linuxppc-dev+bounces-22070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80322CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 01:45:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWklr61lCz2yRM;
	Fri, 05 Jun 2026 11:45:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780623928;
	cv=pass; b=iDGB+3P2PdAqhs9A/rDCLf1cCrVEFP37gXThVMcHrKjHE0IiRUmzZI+SHAeeF30/qk/9HWcomJCOcSak5upK650JS0R427uPy1nQ7x+ywYbo3clBz5TjW7IkEe2YBH8TWZi6mWTdSd9M5mc9vsCY0ziu0FJVGzwNibxVuBD8cerjfG/uswNUk0vLZrBF/ZPyRgdjBmR734KekFUG2tmZPXHCPHdNJXv2EtXU1d7x9Bw/aKNxEE9k4gWrfNcvdOVy0SE+gbSmMtmICof/FvkNnhybuW3D6eWHCqURcGNZKFh0945AuUJbant10WrkhDUDP9diuW1F4qrChWrGEME3BQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780623928; c=relaxed/relaxed;
	bh=vjh3FJIXv11HrKppu2k5mOLZc7mdKjqkSEgR7F98W5E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Pkf3ZATZGuf8CYaoCXa25mxqlDkBU0b7sDAYriL8pwh+TKVN67HdyjtD2canzAf4K1PuSjkUclX0yCS5iIKhGHNDE4+dwh3iqbGfFsxEtRwRpLmmHQviXvZlcdi1IuTBJ7UxLANO4nEPX9Q/ljLp06HoDdfb1AsduhP3u2sQvsfOkjS7n3KgGSt8WEXnPx9kIsJmTKwh82ARj+JdcHvaL6EWQb3V199rYJkdBfpp/SwRUPEh3GW6VFCpiIBl/V0U+SVNCobbHCbPOTL3xGOITiFaE4jlJZhGT3obRM4P4ioJmXNC73IqfzN+2TH/4bX5Lc0WPaA6nb2SUgfGo1LOQw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wqTLDkZA; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wqTLDkZA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWklq2m7Bz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 11:45:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bY5IjOr0BEarNaevhRG+KlslNoZTAStlu9B+qFihKMZ8QR1BAR0q3hGjCZd+Mz3/yVbSPgaDwtIyopePzx7cyAWBlWCltKpEzfDsy9+t0mOqQpFII/UbxsrnBIl5uss/zHumZf+XiUrhZoj6XqsUl7VHG6Dp8s6NO2bLSdFP+tUhXXV+u8UgTQJnumITk2+PzDdCowN7BKme3gOnkDC3ciu5IDD/Dg+Ra9yxA0J3yJrXaxNS0DSINJTrebWqDkBij9BJl3oli0/4aZibbUCsKixL93QYyYIuvKBTJnV/aGVOrxue/3IppqM4settnodApG91Akm3nnO+mKzP08dRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjh3FJIXv11HrKppu2k5mOLZc7mdKjqkSEgR7F98W5E=;
 b=Ee5QwUCq0rDr3QYHzwLB9SCbrwKNk0za2xQ1dvlVC2naYetgG+KegzcIPizNQkzGlmEXIdtQGJizdJLtgrGxu+isBjj/fdYCwaAumMqM688cngokywgAwSiLvVsaIoGzcZjQgQ0TWps9MsRuOnIrsVUj3MbU/A3IFe0Gj+k+JcxNljNeFIpHAQxALksB6X+9DXPX4O6upkVgIf5m/nu+7hWa2k3wcl5NtLoU0eRJ+rI+t2sRhSZw9TBWBiyA24R0jI6W1YPUyotgAE1COQTKvN3uFcKDdRX+aLkkERdbiPcRw3d/6QM3PpqLlCK83jNSe7B7sUKfQWMVKljkhSrGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjh3FJIXv11HrKppu2k5mOLZc7mdKjqkSEgR7F98W5E=;
 b=wqTLDkZA6dThXN/9mLHbnD0zXm5WgB7E2LO1EkznW/EJUcWShq0zAArjXm26uA5HIaaEeNnk5bNeQDRaUqt7q4kj2z65OkgXrE5GgFq0IdKsbnMW+t0Hq/0Pj/1KVx/Y/dFlPOp4hzj6Lggj+AQ1THZOYdLoLTu86xalaPSo1k56a5/pN48cQMTLAv8ODeijNL/vQ1E6GnVSiqAuE27/uZ7qGe7arEldJnK6ZyB3rXcBCs1kzwXaPgevxNYmmF/Z4HcJVKIne+7zXziXNreLOYjqFUXxXOGdiIu/UdzvGcDK6grmLphlhmDel/i68J8NlUHlOI1xGbsRmAd3YzzEyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:02 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:02 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 0/9] net: dsa: netc: add bridge mode support
Date: Fri,  5 Jun 2026 09:47:59 +0800
Message-Id: <20260605014808.686024-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e948293-491b-45ef-b4f5-08dec2a40f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	whZWchuY7Q2NzGbOJdTxPnZt/nQR7KlAP4OggVw7mXuuOHfQd5hVBWn9gqcPbViR0dselO4ZsghhxVU6qaNPVlvj2zF016sC8OcWSSS34VVHGVOWP7mW5NvB72mXEqfON3I1TpegmR8vliiOfToGJjGcHkpEoMTUUu2GRKPNf1Wi3kpUhRqb0aupAvcReqoKhsqCs5wWVjWH05tBzHqigRBVQYl/I/qGZW3xHJEzpAfwFS9dohJZN5yLb/9j5oxWzsDWoEADCUZB25Y4AJmezP9/Jfd2o3WjHJ3OyTxYm40H02iFC8wLqd52rbOpdejaOI3UlxrLieAIvRTC1p1pnQBfRSlBECIPqRZRqm2gzhpDAm22TJf6dqwxcOoKIUsUYRN0sDh+twHJraIX/kQ4cuOeekdF3XEpI7fZ9KCS6c/92TXfqLTuM2aQTib8AYYn0JY/PK/P6mX1n+tn2bUUzizaU8uDRD+Wp4UJ8RwO69LxH6L8BwtBlW5gLeuCgsAsK/bPfnDBmAJG/q7RFU/Do+i2+AiH9J25FIzWBJFxAwLoppuceBSIAszz2y8vkL84FlVFa+HE99zM2tVIwXAE4oQzR/hq0SwGNXd3X5KviO6bd6VAeUmr4BYPUe5TLiGSwaCKJapW2Yu5n57BYeBOS/787e8RWQp1IMLAKaXR9oSvwW80kSgKIzuwHOEmHKJLLQMU8Ia0S3jOmywJJSugw8TI1KyYEjYXB/05lDtPew+GyWV2c2Df+fDLCMFM4Y5U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mg9pzVUeWsMMmZNtzCrDEPAClpePai60XrmWnqVjJgqmA3W5yi53Pg3IZX1Z?=
 =?us-ascii?Q?urVszIQDuDS3U7oKaRlBVFYGe/kSz/JI4oTXsWa3rxkZV2/Tw9C39I4oyAHO?=
 =?us-ascii?Q?EfEFeCXRAF3Oj1eSgpmKX5YCAeXLvUO0KQm/V0BLMufy1eDQDHPCai58KSVv?=
 =?us-ascii?Q?63zyqTzx5SDfyFiUdtIiM+ygPV9wvwWkc4znxs4FDf0apYtkFzAdRRdrDO0/?=
 =?us-ascii?Q?vXBGjqYX8uYYSF5PZLyGZzerGClDYLgJ4UJx5Jux/cEVfCBrEmOvXUZI9kGi?=
 =?us-ascii?Q?XVgWzZFr3V+MwVdSv/zp2vHnRxM3CQukaexuwZ9damBNyEPU8Ev7iSh9+Ri3?=
 =?us-ascii?Q?f4mxkZmy8Ip5lQt5xuhpGOBylWT//KzFvADThMWLmM4DbiUI7NrWJc9YZZCW?=
 =?us-ascii?Q?nZzs4OQp/h0f22Y3FdFd7d8KsG4NxySh/GHSo8Bhvkw3KEfLfeJVIIVEDxdU?=
 =?us-ascii?Q?deQ2MNMX/PDLqxRR94mqHZZf14fBbS2FqewUPgwLPHRLfqs5RNYcuzCZ0ag7?=
 =?us-ascii?Q?PU6HZy1buYPGOcDsL7SY8ewGKDIrDxvHcYQzj5UmZKv1bQU/f9rbWs97NkDa?=
 =?us-ascii?Q?zgFW7q/j6tCIiyrBUw0kNuyI0zuyd4bFDGVr8K6DPLiROFgaPLBr60be/3pc?=
 =?us-ascii?Q?ntaNoNLTxFD1P58Grp3++oQqHdkJBnOT/LdXoO0B3x/kFFjFkCMVxEJEmmgX?=
 =?us-ascii?Q?kFkxUaSDjgdWEhg6oqdmIE7G39MeHc6Ey4l/cY72t6krkSk0NY6YOhD7VOkf?=
 =?us-ascii?Q?Ww2UZAC/ZFqpjnHt4okRm9P7VJuU6p2tjJe6ZcSl1YOZq9PcQjrXMFuj1igh?=
 =?us-ascii?Q?7nLvKyqOu4P6K9emiN/rZ6hy34qIghln+p/6Cz+7SovW9cv4P5BV0x50l1qh?=
 =?us-ascii?Q?zWuTB/UGKrzSbCDEFpyfTDaaTcJ60ME6jMeIyIpYWxq/3pv7ClodiuNMgJP6?=
 =?us-ascii?Q?z3t0iLsVh2sSrqyhMSxjflgQ2akOqsWCfv03B7ktL4L/AUyN0YJbw3Tlawjs?=
 =?us-ascii?Q?HO+O9CQAI1EERtVJDFUeuicv5A9fWHiOSx9nEvuTTFY5FFOT6TMlzkPuDQnK?=
 =?us-ascii?Q?ztaLupDTWgFD++0JwJm+O0FEBLdep+vD3s56dQQD6KNtORXjDKu2R9RUYdqW?=
 =?us-ascii?Q?0MRZrRS6o3lRIuw5KitsRg0EZeS/4evIHUI5d7pFPg11MhZtHUCtMDc119Aq?=
 =?us-ascii?Q?ANrkPrk5IxwcJzVGz7lhSPIlIzrzODCidpg/lkS9JHt3CGa3YDABNmshdfUN?=
 =?us-ascii?Q?cwzpULCO8WhorVanYRrzGU+yzMpEAZ2Cma00y6NxS4Nx3dfDOIJqlPsjOLt+?=
 =?us-ascii?Q?kuDlR2wthFKpAUbJodPvvxenkUsQ69haNHnkqX5yHxkslKH6LZbyz9xl8iV3?=
 =?us-ascii?Q?37Wc7RIqT3HRgOUBTsZ/GoN8CPcellUz+3667xsxFGzBwufdMnt8hPBOhvuc?=
 =?us-ascii?Q?UeIw/YKxX2sZXXj7zhuoZ2ZFLhgl8R0qc38AOlxgCeTZRRrb2RIdZmS7JttN?=
 =?us-ascii?Q?+H33Mc87LtOSqgmbToWJs/eF8TvOWLeRPanBedugUGkiw+KdMEBqSUg3jLcG?=
 =?us-ascii?Q?hVsG8rPe6gTA3XxE4poiXWzk8B8GNNo+UEfV9b05f3tMruvy0MdATrsvIpzC?=
 =?us-ascii?Q?DzSKEyXl4r0fhy+dqnAdz++e7a1DyNetQS24VbR/BNvbmy5feckhyBAjB8dg?=
 =?us-ascii?Q?d2voAKbCroJ5N3OrxvYE6peFZCz+RP3zqcVYGaKeRiKZuvVv688qN2u0h8qA?=
 =?us-ascii?Q?VmPkL8T8pvofyOV219MIoRBMjh2/ix+uykC7Q89mr2zGpGeAR1KC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e948293-491b-45ef-b4f5-08dec2a40f45
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:02.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UMQcxJSqn6GQ1mboo2msRptnyW8VQhryLoLSjLBp1dEtF4dW1fGWNOwBHhmiV4F+cBhI2ptr/QTSUS1Eev1z+WjYQd6N7wGvRi8m1sNL7Tl6zI4wYNnaWA/0nnvDg9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375

From: Wei Fang <wei.fang@nxp.com>

This series adds bridge mode support to the NETC DSA switch driver,
covering both VLAN-aware and VLAN-unaware operation.

The NETC switch manages forwarding through a set of hardware tables
accessed via NTMP: the FDB table (FDBT), VLAN filter table (VFT), egress
treatment table (ETT), and egress count table (ECT).  The series extends
the NTMP layer with the operations required for bridging, then builds the
DSA bridge callbacks on top.

Since all switch ports share the VFT, so only one VLAN-aware bridge is
supported.

FDB aging is managed in software.  A periodic delayed work sweeps the
table using the hardware activity element mechanism, with a default aging
time of 300 seconds matching the IEEE 802.1Q standard.  Per-port entries
are also flushed immediately on bridge leave and link-down events.

---
v3:
1. Update the kernel doc of ntmp_fdbt_update_activity_element()
2. Remove struct ect_stse_data from ntmp.h
3. Refactor netc_vlan_unaware_pvid()
4. Refine netc_port_remove_host_flood()
5. Add bridge.num check in netc_port_bridge_join() and add an error path
6. Remove the parameter ett_eid from netc_init_ett_cfge()
7. Move the implementation of .port_fast_age() from patch 9 to patch 8
8. Refine netc_port_update_vlan_egress_rule(), reset ECT entries after
   updating ETT entries
9. Update commit messages of patch 8 and 9, and improve some comments
v2 link: https://lore.kernel.org/imx/20260602072313.3162120-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260527100217.794987-1-wei.fang@oss.nxp.com/
---

Wei Fang (9):
  net: enetc: add interfaces to manage dynamic FDB entries
  net: enetc: add "Update" and "Delete" operations to VLAN filter table
  net: enetc: add interfaces to manage egress treatment table
  net: enetc: add "Update" operation to the egress count table
  net: dsa: netc: initialize the group bitmap of ETT and ECT
  net: enetc: add helpers to set/clear table bitmap
  net: dsa: netc: add VLAN filter table and egress treatment management
  net: dsa: netc: add bridge mode support
  net: dsa: netc: implement dynamic FDB entry ageing

 drivers/net/dsa/netc/netc_main.c              | 940 +++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h            |  33 +
 drivers/net/dsa/netc/netc_switch_hw.h         |   6 +
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 440 +++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  18 +-
 include/linux/fsl/ntmp.h                      |  55 +
 6 files changed, 1470 insertions(+), 22 deletions(-)

-- 
2.34.1


