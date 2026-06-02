Return-Path: <linuxppc-dev+bounces-21848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D9AC5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:21:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2LF0TZjz3bwL;
	Tue, 02 Jun 2026 17:20:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384853;
	cv=pass; b=O12xpjBEZYZ5g9E+pGaF8Rt3ScunQXbJ556sb9+R/P8HGb+TudCf+wtg3YqNeOFwGH6DpYSoTG/o+H0NgmcI/iLnlLh+Jq793baLUMvT+SG6Fb8FK8D9B1scau1PG4AlXKgml03/YJ4QldI1q/cFmORKdEDGLteA8Fie2FQV9wXbgTa5vEefNo4M5ahBBZaht1Z54g9HGglOp3KhN2FpzG/dwmdDERQsmvHTDSKTlZdRicd3P3O+6vdnLqUITSq/q7g/QIIsCRKR+38BdVA5Tuzam8ERCNzxf4eXgtKe4gUTeYRnhveQz7QcIyW0LoKT9AURHM1F7+zB7hFlYpw/fg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384853; c=relaxed/relaxed;
	bh=r5airljjDLuMIH8cJtpHKGVjh0WtGoiFPg6lBbS8mJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxY+VAz8wDMWn9+wnTxGEUSzTk5bgfnVPgaPUy9snUG8tdsvpETPAjSV+pIBcc0zUItBn0NENmn/kC7KeNu3vrJyUhbqm91i/eiRq/PI+MbyTag3n3qtievAqUkS0bqxWunWHi94wcjMxeCIbFYoRv5pTwsFPwWlHqnD16v+1eCs8OnjfzW5bkLJbx/JpKhH4xl7XzHAzzreM9TeUdcw0t2d2GStPqb/33pTlGf4w55c4hhvZNIYuby9thIAkxIexvvfsXkosLC6pqKf25sap8bTEbE5+z7czTU8KakTHk9xjCjP/W6rLCqYHbHKQNScERpswboUbO97Uluq3T05UA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BHldxtU4; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BHldxtU4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2LD34MXz3btt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:20:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APah+9JbbTU3HOD4gsHFgPGm2992hxFqHNCxSK4ggfTJdatUVMaxdj5Jt6XbjStUrEcDZQ7b5gae09NVNOFaSZEJ71stAbZs28cS30nVYHQQCNLZ1WkD6DHF1uwnNeHhFhvc1I/aVRFzqrF7rGQQsmGPMFZs+Pk1fLBIvpI14Ss7L/8L08sgQ+05DxCBfYFxRfZWDDPaN+8nDJPkbEhxboO//7bB1S+tywc3GQdjf8RBIkJAcc0jElhF1NeaJdCpFJV1LBUTzUM3iLOh0Yh0H7URKQKgXNbt1fB2azNzudyStNmHQm1vclC8RTMmqXSoVC+TuewW7aTa3LlvBz1Ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5airljjDLuMIH8cJtpHKGVjh0WtGoiFPg6lBbS8mJk=;
 b=qZ4l8qDcfJzDhVzICACr+E7cXNnTHn58PifBGrnuGNre4tN0N1HMHJOPbFmaVS9hJgEF5Ce8JSn49yMhC0iLruEJqbkqhmYFCSXWkOKCc4NXQSWN4emZln/RwURwMelO1HPGsqCygBP7k1q/3l/PI0tMPXTPl1WQyVrpJyFMX2g747wbdFnzvOOjM7sJaaojENKAmrsLYO1ayL8DiI5TIqFAGDF+a7Cat4AOV9uTcnt3I/lYra0BY8DX5wPheIqD/Xbgrb9e47r5qm9t9REf/O1zB8Z+LN0+IsnFA/D46LWKowgNNGjOc1A//0oDvVCNAsjYIJRTLslLG9v/EVulJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5airljjDLuMIH8cJtpHKGVjh0WtGoiFPg6lBbS8mJk=;
 b=BHldxtU4CquL5ayeF3bbpqLGjcDyFt3V8SnsR2hyMWida7Vwv5FAfDhnP6gDG9ZeG6iDLtLf0e3T0YXjMe59CGqZq1VhekTJBYMci8lS/l9BlBHoMNlVrW8g9V0h5zsK0IS8g7CV+EsYy/xhitoGtMNnP8A4jni/oP2ipYBUlXAnkkuoVAVC7DP6vVPw2E5C6MXvJbAYsF/EJNev30KAUd4L7uhT1d+fhHKTmXj2YLvBCyKTGXso7aacpS+918TYjxZ6F8vT7nUU7i6IdAkDdJjKBzuEZ72VRIiTqCPzgkGqec2cM8I2Y1CN758AsUb2/s4MJCoBZHKBeUBLDW6hlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:20:50 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:20:50 +0000
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
Subject: [PATCH v2 net-next 6/9] net: enetc: add helpers to set/clear table bitmap
Date: Tue,  2 Jun 2026 15:23:10 +0800
Message-Id: <20260602072313.3162120-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: a59f4a49-468d-443f-6723-08dec0777938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iLLl1UuhLYMBYzTvWRce9n+6rFC7v5sAfUYhAKqLH3X4naZVf+5LaSMY55BrkQEy4mx11Jp3ZQSfBJLh3GbrIFCtB/hYVqXh+sg4rZPw8TxwRiDvtkrkZETMN0r8uUwOzFjyoYtUWL+IN0jXX3HIx2qFO8nfreeEQVa/0s9vP8buf1GHBdSIGLzzEcxpZU1Uqjl2rRqIIbDLpqMdoLAoeoPfeyMQAN/nBxAab1azsEl4OFQzvquWlaz1aLcYzASKCYt3ajaE92Ph4ycubakft77cGDgr0yzRQzgaBbcNc6GuxBUIYL3mp5JnMxPFYiNxpgUD2yX1zPBpwZy6iYt9D7AIsfIlu0bUMdaL2hglcaesI1XTTU82FZI7oCFTWwlNJpDvHfHjrQv2EF68tVUi8Enfo2t2bdVtT1HX5DyLI9tCETMAR054+u8/xUJa3T47Eakf1BCuRKDM7ojf6bjBU0lSstuQKqAMUWpOJf/ZPP3em6fQ7M72PkCrN5a7GgAeulLPqr1DjBNwiv1qfKlSIN+9j3ycE95De0vsFTnKDwITPBH2ufMJ9gx8t5/1pLkSTrHjSg2nKQ2jYNqQ7prQstKKN2ElLOxQhyrasgNVb9EgFyEEbJqFrKiTPUO7vzyU/TagunMokcfUt9BNX+YYdvYlbwzUwoxjGgt54UtTkCOuDd+4dBsoF5DJ9rrS3klkTQUDdh+SuwFvpGAmNEQ8cl1ZIjSjw0sO6z9t9G7Mk7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?camAtxxqfBGu9PymBcxeUrdJ4yYVgdy2T4SvYnt4dHE+i14jPA7EOiA+bQIp?=
 =?us-ascii?Q?f5V0GJlKpGnR8ZNa7TRVDRhS/zJssN9qlQ4oS+0Crqb9hRpDzERhkqPHnj0K?=
 =?us-ascii?Q?2VFKQgCa5j/RZbkeetnohH4RBbn8gZvrlrDEHTnvkOX+O1fCJWcTSWA7Y9bA?=
 =?us-ascii?Q?VYNOZ4IgjFrcfXX6ukJ0JvNCcphJlCp1X29c8uFHgsKcYjXPavMrnpIxtklp?=
 =?us-ascii?Q?BVzfqk31bWnkjQc2O2UNnHv4UWS1seTKjy+xHHQaBWVkfORNdWhEq+LX0KSm?=
 =?us-ascii?Q?2khdEJpD41tiajpZiGF0YAq5pogJvPHpfc3z9UtiAV3jPlS6URmZVeLRjapl?=
 =?us-ascii?Q?/thdgMfxJFZuPPRFISwMuWZexXHVxQ+BElkOiAcAiu2k89dhgeOaEBaXmse7?=
 =?us-ascii?Q?HZjpL5Q8MIHbcZBvEicErgUoHSM5qAK79ruIVVXc4cU98ifEshRYsnC0PlcQ?=
 =?us-ascii?Q?b1+sfqRNuO6pbTO3H4MzgCdOZ72/+fmiKYzG+e2WgqEW0dkQCK9LRKUVr9oj?=
 =?us-ascii?Q?e8uUrrbcxwJViPKT+4DYD9kvKzhZ+lQHOoRQPIuh9EhG2EvVsPvOWJH3bmKB?=
 =?us-ascii?Q?cevTUgv+osSHhlJEr0ev/PBGQNOaa3FRWX1ouqheal7CjM5WGMn2WAb220hs?=
 =?us-ascii?Q?mR2IXB8qv55E8Fa/LJOWnYecee0zdTqcyYTMc8T+ay57EkA/S2T2u4ohqm7k?=
 =?us-ascii?Q?/L/SX+lS5/imeDGs1lFbX4rls2fP2eZpzegNB4FVGVBWQnIeoWF6YNrEd6m+?=
 =?us-ascii?Q?Z7oaQfYy1uBR8ENfYLgxldPNeVyEJQ5YD9Ni9slHTPmcm4Ox4Wh6oqe7i6P3?=
 =?us-ascii?Q?9hLEq7E+pkH/Vqtfc6Zhyh0FVGBvLSyMO7YGCMspdI0uiUj8v2QbGxzX8rrq?=
 =?us-ascii?Q?ijyUF2hs92AYPsGrfIrw/HnlawK/1wMN5kWo/GSCKEeSd5gDJwDYmdeJlx1e?=
 =?us-ascii?Q?UA0GeM9LHaQp/4YSs+ZHi61LAlQp6w+TzA1/IY0abIGD0/bQ6e/YjRBSiK5x?=
 =?us-ascii?Q?7KjD8XKRMW8BXKtmK6I2QkOJ3T4RN36BrkZXwnDPB+hdxnlb2J2AnSqhGSr+?=
 =?us-ascii?Q?l9BgBrTS1VJCMIHI/kgcwhJ1vJ/lG+6f+zw96/ufAlsjax9KhVNAmylxvzHK?=
 =?us-ascii?Q?lIcH525qQPXDTckI9erwFm8/L5xCt/GT3iU683d2z5xUhp7VpTH+xUEti9LX?=
 =?us-ascii?Q?mp0jn1Ivtw/poArJ4kkTeMDQV1y/w50B2+CP6MhbbYPr6kw7UBea1jOZumHt?=
 =?us-ascii?Q?epZlJB+n8K47ld0YElWwRiBhNSsf43el/38CUx01a21SN51Pq9C/ih+DQ77z?=
 =?us-ascii?Q?V99+VvC8eVZofgPUk1iRJna94z6x4rMCZO4AGGEQDTS5cDxXfmFz5Nt/RMtU?=
 =?us-ascii?Q?V+nBx1/29JEeH/lNpMLnUc1p8lHRaKQJXgXng4pUvuygRVZBjzIkemip5Hcs?=
 =?us-ascii?Q?DctLCQCUV8lW66LUsb8XRzO2+oynXSOwmIkFvHI3FcmHKoPySIBwWuWAbpkz?=
 =?us-ascii?Q?gJJcBE02KblJQfmYNZ7PwVmOkJup9n0e575MkiANU3E1baMrUPYlIXuSlRNj?=
 =?us-ascii?Q?VF16bXThIDITn87JvXXtA5MatNHn6XmlUAoiqRtogYl3GGIfn2LyupNpQWlb?=
 =?us-ascii?Q?Rpe7qnF4EtC3fJxTC+1Oc+FrAlXGiTLsy/tF0IDdl7B0YST72xoArlyWHLrO?=
 =?us-ascii?Q?9euw+F+pOvr0yZ16q3puCfg668q2Qt/bbCbR0XlZ9Hj6b5mJ1Ukp2dUMnrUw?=
 =?us-ascii?Q?QfM+2QWLfB74yxx0QrY1xzj2k1htDy8eskDPU0GuD7GjYa1HtGyD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f4a49-468d-443f-6723-08dec0777938
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:20:50.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uepna9gCdbojL58g47F1N2sj/dAqtBX3pr3kRUfHIClXUC2CeQQ1FnyJaC6Upbn4rIBbUannRYfyxskHDtnlSV5xlZ4+XaeD5qy3xCzJsrFcuh72nbVYPMcl/Y6g9QIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

From: Wei Fang <wei.fang@nxp.com>

NTMP index tables require software to allocate and manage entry IDs.
Add two bitmap helper functions to facilitate this management:

ntmp_lookup_free_eid(): finds the first zero bit in the given bitmap,
sets it to mark the entry as in-use, and returns the corresponding entry
ID. Returns NTMP_NULL_ENTRY_ID if no free entry is available.

ntmp_clear_eid_bitmap(): clears the bit associated with the given entry
ID in the bitmap to mark the entry as free. It is a no-op if the entry
ID is NTMP_NULL_ENTRY_ID.

Both functions are exported for use by other modules, such as the NETC
switch driver which needs to manage group index bitmaps for the Egress
Treatment Table (ETT) and Egress Count Table (ECT).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 24 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 03a4ac6af56e..b2db91683e7b 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -47,6 +47,30 @@
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
 #define RSST_CFGE_DATA_SIZE(n)		(n)
 
+u32 ntmp_lookup_free_eid(unsigned long *bitmap, u32 size)
+{
+	u32 entry_id;
+
+	entry_id = find_first_zero_bit(bitmap, size);
+	if (entry_id == size)
+		return NTMP_NULL_ENTRY_ID;
+
+	/* Set the bit once we found it */
+	set_bit(entry_id, bitmap);
+
+	return entry_id;
+}
+EXPORT_SYMBOL_GPL(ntmp_lookup_free_eid);
+
+void ntmp_clear_eid_bitmap(unsigned long *bitmap, u32 entry_id)
+{
+	if (entry_id == NTMP_NULL_ENTRY_ID)
+		return;
+
+	clear_bit(entry_id, bitmap);
+}
+EXPORT_SYMBOL_GPL(ntmp_clear_eid_bitmap);
+
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 1e087316d4f4..531c3b9982ee 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -271,6 +271,8 @@ struct bpt_cfge_data {
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
 void ntmp_free_cbdr(struct netc_cbdr *cbdr);
+u32 ntmp_lookup_free_eid(unsigned long *bitmap, u32 size);
+void ntmp_clear_eid_bitmap(unsigned long *bitmap, u32 entry_id);
 
 /* NTMP APIs */
 int ntmp_maft_add_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1


