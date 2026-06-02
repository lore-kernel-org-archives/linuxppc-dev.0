Return-Path: <linuxppc-dev+bounces-21843-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66014C5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:20:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2L44MnVz2ytV;
	Tue, 02 Jun 2026 17:20:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384844;
	cv=pass; b=aFdhFN5oCUkkeNrkShBwKGo6Ht8eacMfhzVjVoNRHnWMqMcRH/ewPflCXAiOrKGJvuI4pWB4W6kyXc9sr7iry7f6uayyanqkYtCeCrfueIFy6d2zCb3ZUmq8kWAeucTqgg/hQYgEQj6VLBIxvfHJfIm3u3o7w3hcp0NWRjGBvgHKmc6GGZwmEZimqxi0XGE9oxzw3Iae2wZ+e4pGLKoBW9E8s4KVSwk7GcSc9izOFCH07b2l2TOGLCVN83XWN8F3kdmtt/m+Z6Gxaayz9XpbN7rBqP4ovTbBIdI0n7BRDQiobX8KC283eyxIq98YzZIRLH3fvjcRrcsAi3tz1GlEKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384844; c=relaxed/relaxed;
	bh=Z6CZvzuSn23176zoMx1d8OG0n/D6/p9rSta+zPDVq4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkKy6qCtP6JOaBkRsL/ZZgpFbNTqhut8Mmtur2AvyaANvR6KYaHgSHZBYkkeQQVn4iK04gW3PkTZuAqw31Xut7IjZFJ/eIlVhWVlKSY3j/QH8KAoslU976anDaNXzf23RO8Rc4YXock04A6LUajdUXJy8mOupIBnKF3frDxYtmbAs/Lyk8PWynuw4I5QvV1KCTGNQlLGqQsIqHx46lOq1Bpz/3MuJhSqcSUoRaaxWcKJniBiwgvcRr5EF7jJV6+H8fqSEqufplbWY0pfuTxF6ncD2vSWHamR0DLOYdxlm+KBapd9ypCTlL4DWCHKGOHVxkMV2v1SIulDP75pmopRhg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KAUlku6k; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KAUlku6k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2L300Bsz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:20:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0pYA3WUAfT/ZYNVlAhRSoa+I03KfsHD7cc3SXI1Q3YYfiw8kxfz3djErqfGmwSJlYreMAnAE7R5iGDicgzkfWRhkJquoZhH8Zp3JIuYthkCopyFFM7HbPlmejJdB+h+MjiOdpatQnxZNmiGO6zIB5wAE7AIAnqxHmDeHv53RbGh4tMurDU/Wno5L5hpDLgn2xY7fx5ftsdNEgJZoKCi74bpaIT+8as3irjfN1NQ8XHQ2xKTm0BW5vWaVtwAGbOjP73kzHfCwD+0PVjshCkCXa+QsZJ/ozMdz1/0F633VH97wTQ6mgo1gb8dFkx34ODCz9Qn6rQo/N6iuFVftmuAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6CZvzuSn23176zoMx1d8OG0n/D6/p9rSta+zPDVq4I=;
 b=bdSZHQrPGafnB90ZvPUqUGPpb6NEjP5q7pVFmzDzfhq9Jof+Nd7TKEWFnI6zKFpRUYmPK5tHMJnqSjsQEUVPmkU4lj0BGt2RwfT22SdCv3RwPQDXKJcxKahy72P++ssdSAx/2MNynMwWePrr+hAdhWsQ/Q6EeH5ittlK4cnJXQBPvfZVgdqUXfIHDGHYdTEPrx+KdQfOZSEpWsmTDacZcHoQ7ye15tPwAMDWYC/MwxgEhjmTjxkEruE06zcbO91hfPUAigBgNufltfvkxNOY+lF5g62PzYoSGnB9mowkEGj4UTvYbAjcWCv4QQLA7/a01KFzQlMQB+P4XvdaAk8ykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6CZvzuSn23176zoMx1d8OG0n/D6/p9rSta+zPDVq4I=;
 b=KAUlku6kxWkFDwvDnXHQD2lyesO054zG87l1uBovbbpawGiI33uQ03cAMSukaHHPfrwmwvCJH/EiB1AeoYbB9QfYGIoyr7unQfDci1fYGgeW5MbDA9cR3O+YK39Zcme2s5zGBRUNsO5DWy8fN4sO7zXa5BVfS2kic2wn+xGXKir0PozV7+L0hWQnglogAh927AD/83JNiWNKaLeVPNMTz6t3dW6JtYX4bxfPOfTIpbxiXiRWq5gSIA88OPXiqvr5MKb9GHyxhxfrv0ZXfP6OzjbiNgWsW36gk4bMB+avojsmd0HezVa45TSLdGzbuUMJDON6Dgs9YZTXbQDTRECHnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:20:19 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:20:19 +0000
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
Subject: [PATCH v2 net-next 1/9] net: enetc: add interfaces to manage dynamic FDB entries
Date: Tue,  2 Jun 2026 15:23:05 +0800
Message-Id: <20260602072313.3162120-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9f07906b-9d79-4087-26fa-08dec07766ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h5vdgdRJvphWG2EL0XsBVyUEDZHKYlIRhuL9yaQ9MjLAg+6BmnkK61pBMshV333VRzQfO/pAn6dZoiz7kWBmsN6/2hRqRIOpoSPkQIA7f/+LifxMpYFJlrvZR3Tjfy8FTeEeCHJO34sTJMImN+gP9Nv2srt/xd05UGUYHhbT0QFvO31FarJf7UOK/v5+ChrbFS9h+829g26yXoopMI/+awyQGT4shph8sF4i2LZdSJYxvPTaGF1NmG6rRfleNrCpqTQ9VzrJe201wWq4vYO8ZMaz5HzzNUiJbJR3X9HcqcTz3vAsJ3mlwWZLNgtgvel4Miz6J00jBvLSGhqnav3IiXe01OwkMBwT7gAuDtpW/yFlGrYWK2bb+mPSDxr5F1GrcJYTTSRpjx8vWlOJP2s/jj5tL46TcClh8SQsroxAajB9GOFsxGzx8hLF+K8wvG7+1JIjed0Xj9rMVwdYUeUBE9o80vhOd2O4t9ZvTDvTzIgMrUqdqszKCFR5DyDUpUwpohrT6agfR9gVqW7NC+y0fVo4rvt7BS0Q592jNKaQis3zoiUFPy/CSH10XfPb44HfOgJGM6ys7+Hsb3TFqKYtqTaaUFHfxuYtWnkLnJ9dt6Iw2HtLPG7ol2JLYO3x/C35w6gKAM3SX1vfPpkKgG/531iPHtLrR4a2Pv5Sxh9djfhFxp0IDnlR1QJ4Hm+pVU1es2ePccfd1FlHY9x2ip4YncilJG7rD3jyGqQdEH33tLw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIR4AD6ZMQGTkPNgVAl8eTYdvYlG3u9nNaqnCjPlX9ZJp5tCsbGli4Qlg4iO?=
 =?us-ascii?Q?lNzVuCM3zDRlJpuup//tCAi3G5kvWq/Ok2YGZXmBhrmUpFEMZw8uV/Vd8nWJ?=
 =?us-ascii?Q?ERLG2TsToz2ZK30ED/JwoAXb8qbGnoKzO2LRGmxMJR93ntw+jXk91ikf1u27?=
 =?us-ascii?Q?4dO3Dp8U7ySK6CFETK0BcsOwQvfzmXKqiFSI2s7nGAQkz9v7dGP2KJwIW87I?=
 =?us-ascii?Q?TuIZ5B1Q36Zp8X2zqxDa/FFN83WtBRNLfGuNrPu5sf6LvMm1/q5Bxd4kTIii?=
 =?us-ascii?Q?fzdJCPFpraVJDoKWHJUcE671DQX16VLQB3DlOcSIe5qNB144oVKUb+28dZpA?=
 =?us-ascii?Q?PlhqpuxMiDeyKMHD8sDGAybn+Rc7+YnjyIoJILF+QIN52yoO2KlJxCkQvE7M?=
 =?us-ascii?Q?DoyATBGGxslkh7zfcbrkyPAqtgc9CzTMdxSJVyM6XK5JLbmd0VrZX2O5rKL4?=
 =?us-ascii?Q?8j4sjGhbOGcIpDddiH04QDNaCzi8ol1UapSBxOwQUlnpBbMrNH6i6ntrRRCY?=
 =?us-ascii?Q?DNnkoAs4xNdjXNIxPh32ROQSoQMCvWljdyL06EZwcdy1HJ4MqsUcBYbQA/Ca?=
 =?us-ascii?Q?wyNdkO/HCZLCG3nlxbxkYOxYdi+BJR+QdjtQK57ikLd42poj1gdZgIeBoJpv?=
 =?us-ascii?Q?CcBF1dMnQ4ti+UlMAisKP1d8OEhdnwxKnSd0ElfM1j4TU5Nfgpnq0hIS/zos?=
 =?us-ascii?Q?guM+bX0ggy7b+3UUw7R173+2aM9UGuFdCvsxF09UnXhB5XhiUEz8sIoE8C5C?=
 =?us-ascii?Q?OfCh+25ibnOH2PmMD+LQ9tEv1qfqmlAtnS8cGc4zVQJ2etExpWUAY2mODY1H?=
 =?us-ascii?Q?tOKo+dETVA6eTbsJSDFi4sJdioEoIN50XSBfWFhTXKyCEZve63t8MYeeDTSU?=
 =?us-ascii?Q?kyhQamE+75sJoau8uU/GfVc3s8itASYlpRNkeU5OEm7hMhkN4Q7VPs0vahRI?=
 =?us-ascii?Q?l5ZkIPtldlcr5Az5dyVwWRYQRBpbLXTS9s+w+aE3NTF1aGr0HWpO+l8Ct5LQ?=
 =?us-ascii?Q?JPK58B4m2oF3SeTvqPy1SPF4H9byHbbHg4D+4AFJB5zKBy5o3d3fGBvy75dJ?=
 =?us-ascii?Q?YNvGfGApO9THwP547pixv4Og6wOZTg5D1ei6/uI+UkhREeP5M6QxPMR0hBh7?=
 =?us-ascii?Q?M+vrq+gur5rZQbvcx3NuEEMrXp4ECFWMPfCCebu3/4hkcvUFj+5zUMR3oxuV?=
 =?us-ascii?Q?tmwoYrzGE7rtHS7cq9yjZV/a3AW+XXG1qf/PzicWyXmmFeyqg4vpy0bd9TcH?=
 =?us-ascii?Q?ondkpmB4w/tAM1+yl9/7YgT9huvZPHRVHA4XnwUXXJsAinG/ST+FVQr6fQHr?=
 =?us-ascii?Q?wW9FIxgLjHOnwEUnVUBQxzl1iA3U1xCy339AJG2Gpxzmg35ris80OWMIUhwg?=
 =?us-ascii?Q?XFY8awFmkPC9gz+r8uZDOvp0sXjSgARObgx89wgnNDI6dY/ybXtdUo9O6mXI?=
 =?us-ascii?Q?wKI4lLZpjPy/MQ/VUkHVCJDWYTzvCWQ3EhLnvPjfAkCVnBb/CfjOD1iAolia?=
 =?us-ascii?Q?qKP9neOjxqgzlGxNzWn+X1C27mjnGwkfxvhSup1WjBNG4mYVgdekUN729rae?=
 =?us-ascii?Q?Sd+e8WheQlxJDWrYCWQ0v54rA/D5zzBqk0G0XugRCcogqSkXKnP8OKLAY2uh?=
 =?us-ascii?Q?54Ok+QSnkmw/vOmvv0BM0jD8StfL6RvR/KPg+J5rT4HWE3lgULid9zQ15WsA?=
 =?us-ascii?Q?0G3so/v03D4BLV34J6B6ni48JzRFbQjNLZp5DWALHKGqgknOBl3UE0/p6dvR?=
 =?us-ascii?Q?pKnOeG4GoG86tOcQR/jTLIS6dLqYAWnbAFmmSUoRjAbUZwuhfFa4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f07906b-9d79-4087-26fa-08dec07766ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:20:19.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jIyx3WHeEtITTJy6MLvAk7WA1HGIgfjfq9ROPXZK+NCOPX73bOUWEbz48WCtakuV2tQ1YU7s2fyTYlq1ksyO2FLO/biAK2XCSBgLgSdQHxP5Dii2wIeqP3mJ8IYe/ng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

From: Wei Fang <wei.fang@nxp.com>

Add three interfaces to manage dynamic entries in the FDB table:

ntmp_fdbt_update_activity_element(): Update the activity element of all
dynamic FDB entries. For each entry, if its activity flag is not set,
which means no packet has matched this entry since the last update, the
activity counter is incremented. Otherwise, both the activity flag and
activity counter are reset. The activity counter is used to track how
long an FDB entry has been inactive, which is useful for implementing
an ageing mechanism.

ntmp_fdbt_delete_ageing_entries(): Delete all dynamic FDB entries whose
activity flag is not set and whose activity counter is greater than or
equal to the specified threshold. This is used to remove stale entries
that have been inactive for too long.

ntmp_fdbt_delete_port_dynamic_entries(): Delete all dynamic FDB entries
associated with the specified switch port. This is typically called when
a port goes down or is removed from a bridge.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 162 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   4 +-
 include/linux/fsl/ntmp.h                      |   3 +
 3 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index f71cad943424..cb494ad02e3e 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -31,6 +31,7 @@
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
 /* Specific Update Actions for some tables */
+#define FDBT_UA_ACTEU			BIT(1)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -793,6 +794,167 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_fdbt_update_activity_element - update the ageing time of all the
+ * dynamic entries in the FDB table.
+ * @user: target ntmp_user struct
+ *
+ * A single activity update management could be used to process all the
+ * dynamic entries in the FDB table. When hardware process an activity
+ * update management command for an entry in the FDB table and the entry
+ * does not have its activity flag set, the activity counter is incremented.
+ * However, if the activity flag is set, then both the activity flag and
+ * activity counter are reset. Software can issue the activity update
+ * management commands at predefined times and the value of the activity
+ * counter can then be used to estimate the period of how long an FDB
+ * entry has been inactive.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user)
+{
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, FDBT_UA_ACTEU);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	/* For activity update, the access method must be search */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update activity of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_activity_element);
+
+/**
+ * ntmp_fdbt_delete_ageing_entries - delete all the ageing dynamic entries
+ * in the FDB table
+ * @user: target ntmp_user struct
+ * @act_cnt: the target value of the activity counter
+ *
+ * The matching rule is that the activity flag is not set and the activity
+ * counter is greater than or equal to act_cnt
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	if (act_cnt > FDBT_ACT_CNT)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.acte = act_cnt;
+	/* Exact match with ACTE_DATA[ACT_FLAG] AND
+	 * match >= ACTE_DATA[ACT_CNT]
+	 */
+	req->ak.search.acte_mc = FDBT_ACTE_MC;
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete ageing entries of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_ageing_entries);
+
+/**
+ * ntmp_fdbt_delete_port_dynamic_entries - delete all dynamic FDB entries
+ * associated with the specified switch port
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	/* Match CFGE_DATA[DYNAMIC & PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete dynamic %s entries on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
+
 /**
  * ntmp_vft_add_entry - add an entry into the VLAN filter table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 0a9b87286105..ad532b059ba8 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -155,8 +155,8 @@ struct fdbt_ak_search {
 #define FDBT_KEYE_MAC		GENMASK(1, 0)
 	u8 cfge_mc;
 #define FDBT_CFGE_MC		GENMASK(2, 0)
-#define FDBT_CFGE_MC_ANY		0
-#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_ANY	0
+#define FDBT_CFGE_MC_DYNAMIC	1
 #define FDBT_CFGE_MC_PORT_BITMAP	2
 #define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
 	u8 acte_mc;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 88166f9ad3a2..5db078e1caa0 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -263,6 +263,9 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user);
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt);
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1


