Return-Path: <linuxppc-dev+bounces-23171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED2DC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:50:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFfg4hQhz30FF;
	Tue, 30 Jun 2026 17:49:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805787;
	cv=pass; b=bWYf9zTACWclFfYG6vEF2HEFVgiPUVx2ge2kCtmUg6k8b6dMara5rBXjlgSNaI/6XJukIsyRDphlHZBB9cmryp+jh0lAQyoFcgQCyMX7QdhwXNAjGB7nwnUQXOGDciNRlp1gD08YPMlIQtgcP3IwfX4r4C/8BtFxj0kP8G1cb6utCJXLupDQWJa2gyt5F15aJI+OQ7aqp//KZ1v8g6U0ATjFihDgKeTVo36+kcYo5n7BXzffB4Hu/wlio/A8uUCnO/NkdaXxnHfy/p6eX/2R/3/6MLJKcufeTUMJD5zSmy1RHdYwe59sCcHgOFHvG/gx0hlXQx73ALzPWaE8663snw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805787; c=relaxed/relaxed;
	bh=fT3Vsq0v9+pq36q57f/18e05NKhG86wbn43vQlV1L9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ann+vv1NFqlYrR7OoLm0Lppd80Yrd1jPUmmYCBT713qyssUqiCE8sf6fpvusqn4ZQ8SsC9G96vsD0PFxZkkoSQQTi7rTtF0Jyhw2aVxplXjRuPSCFi/PrFLoCAmZbnuQqOwc6OESvVM+k9lsAihR520nOFwNXML4sgsXi05iCYbjKHywPMpjQOT5G+sh3oJ+rbODRX+cRJ+ZVic4OrWx5ghdnxDgtR8qS5Fl3InC0x5nDoMjU2qGx8LCk/FcOdZ9lrtmDtRGOIn0/qk67CNTWVXKEgKq6NnJPa4O/oWohY5ILplGE6Twe29ZTO4kNl6OI5BhmdUdsbm+j1q/TupY1g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KfcWF2ud; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KfcWF2ud;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFfg0PxYz30BC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXFlkY1CTwXZTARz+jeZsoAZY3y/Zpui25sL00HJ/O1SsjuzQLOOUdzgbtl5FTL+xcuwm5AHy48UAsQYQ7t56n//9tF51cdNoF+bYump4pVyPkour+uxdqA2EySFAv0YIAK1uiy60MDVGi9VO0A1herheSCOUyHHPA/Qa26fGIDoEKAFiCdePliloNL+wRs/KMrg6IcxZXjVogpIqq4cPYgymitFQdsUjHnjZTOMPKXpr/QlXKRKMwCki3jV/ZMvHCVshK6BninZzOLb+dlzjjnZHy2JOCVwVr3vNTz/h0hUAfYGzD8RNYMOKs9OpZvpQzi07jnC0aXQbwHgalMQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT3Vsq0v9+pq36q57f/18e05NKhG86wbn43vQlV1L9w=;
 b=i7Xm0b5vaFmIvtlWyFf31aZZuhg7nlTi6mi0lXhHb3cVlqtwGFIgJKD8cUsPBDEoD6uev7dozsH081eLKT21zMRPv0uxWLAEw+p/5JNN5gWi7FVJoDTLM5cZpmyaJRfIf+ZvEbbViQWwsHhgnZjDVqIxy/rvEpuP6dxclEChgJqNs5lWi0d6CrCoX/BGvKFYxvig6WWl3nDdouizuiOAu9ji9zVbtENZ/0GN0UDFxdny19StgmfYjtdRnJXoW5FgAg+9rtCXMtOkmK62DURbPrwwEN9L81PQN4nhMh3pjxPs5/ZIPkOcqAPqteQ8/kjCjh8liAN8QzpJnnFc9yxmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT3Vsq0v9+pq36q57f/18e05NKhG86wbn43vQlV1L9w=;
 b=KfcWF2udgr0INqBgd9lu8OHgHT4KS4VVSeWSqbp373sp+9zSN4Y3mMW/98gMOOEuubqlJ/QjcEr+O957vkt+ySrC2HFlwq9MI9OAbju8t+U+vI3qyCDeftULr9REpjLyO/jQ2SEt66PdixCn5O/WYQnfnqCCHkWpkU1QPJudUPhBxWdZM8Ai1UC/Vy2YatsVKWQuFDGY9mb/732V+UAwkkXYXhvjTY4f2RJkXXFynAwieBmdBskfvFDC2RzC2cOnLLeTsrbVmo18S2KVTHRmt9ewuXjdH0A1CgoSyWeETL0jqYbS4BZ30xP7nrgufp8KXCR7R3sUqgz0+hrA4B3OcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:29 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:29 +0000
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
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 09/14] net: enetc: remove enetc4_set_default_si_vlan_promisc()
Date: Tue, 30 Jun 2026 15:20:31 +0800
Message-Id: <20260630072036.382761-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a5a042-1930-400c-6fc3-08ded67c1d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
 BNeI/ppi5gBFg4p4Otz2HDuRW7r+9taw5pDj8np3Ert4RCPzQMa9Ctjuj3nVLfKluwz20DDPi+EvupMTU/awVI0cWYu5H+Ga8CEN6gVfTYuy+oIvca/drMNEyEVbxIl7SgNvDo9d7YjnCyduUWdSwFuZIYuUI1GeG675HfsfpoHZwDU6BXk+Psoni4smRtRqiS4vq/kqTgBo2Yl4nImV3fXXbhPSuHKMpS18FwVuSB8SOk7njeXKmc1S3rZaUfSNFcC8Km0D5SkDq2m7M+IWLwTqywacp3pe67ZCSF6NLfMD6dsndMolD7eWu722LqLOPbpYtPFCydWfWoBr4/Tdd5V33BJzrx4l5VD5vG8zMOzesFu5AAOUaSBBvbmF40TTmIm4hoB7geCLMQncdSQDHsJPJsaWOVfx3hrAgmWje3mVVd3KRfJ/wMYgJpHQp7AAlNQJa+uukW3Stdte0oSgenoCS2TPgGbScrdxfXIRjlYA7q4I8cfXMWvhzUP8tFytrgjYAOE868cgh+iH1OqP7lZKSORT8z8oBJPh4+dV0JZv3zAzfZsrOX4ul8qUj+nWUJ0ZCtRPR7w7FHqLjD7iI6bTewunMJ6HLe1N9dIhdL7JgH+tbT/u8cX7RmwNqmNqd3Ug0SQ3VbftRJ6nk+MgM0KuS/qk0CCe5LgBgPP+6UxGKKpAOJ+yp+Hx5KbymEi3IC5J3Sc7X0bScnBPnCHIRg==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Ib4+r9jNnkQIdSI/HA5odqRzkVKIybolTgf8V7C6Omt8mmv204voi2qfaSsP?=
 =?us-ascii?Q?OjUVFSTF6Bqjvb6rNWGQE+5OluhFF1+xcR06w9kOZpNxi8UEnCg0PMJOZ6+s?=
 =?us-ascii?Q?fEEcMVF38cImU7CSnvkOcCboGU1F60vOw3i0CzansZ63ij41QHmsmROX+z8N?=
 =?us-ascii?Q?qB6D+2x+KnyLnmv+VKD+XgjMIFgDMr/gOjq8TK5XrWWXiMakH91y+nj7z7RZ?=
 =?us-ascii?Q?CHi7hdhOtUBjaJAiYO43SyLQvSrpWzf3UP5D546E3TafRNJJIjjXowbk5Ilv?=
 =?us-ascii?Q?HF6FyrQMbaD3nBYx1JFp947KIsjKDho8SWjENNtVtdZziTRCGL/Il8dFcfPh?=
 =?us-ascii?Q?UUF4+HzUUnvAtB9Ik3Ot9Lf3gVtqUgIbHQKbI81I2bsetxMqRbkL3iY0rhiE?=
 =?us-ascii?Q?ZaPc1o2W4+8KxtUu2gWaZdRmM+U3buxD2umirietQepfgDlwTyGVBZ9Z3dzs?=
 =?us-ascii?Q?CpwU/mkCnw3RaD4TYxCZVeeIR1fo1+se4ZsFPa6v0tLKXFe/uHJYsZidFWtA?=
 =?us-ascii?Q?v5ACZe4PG+8UrzKi8ceCtzcKC7LvGe5OIu3Ztj+AlYBHXi5OCcF6Qss6EVzq?=
 =?us-ascii?Q?FCK76FlBBgKx3uOzk3dr/4E8tlgmGEW/Lph2tmKXU8wnTy5SebcoyLiQqvgQ?=
 =?us-ascii?Q?PoyYifneTS9Iu2j7EvLZeY6FUhBasfpgos60eym4sR+vtGkqXEeM1NCP1+xF?=
 =?us-ascii?Q?luaNtYhlKpThiboBHPq4/6buU6eiBpBn2w27WAk/JiPcU/bRqj86NhiB1qzT?=
 =?us-ascii?Q?7NM9ev3lmUNwfoE6cLCtw4gO++knpkBZSoz0+brei6dlzSJtnL/XZRqKOlrR?=
 =?us-ascii?Q?GvRCVdENCPa7qe2nuwV3SJMsS1SUvAJ7z3d0q5kui8xeKyFf7w2kYZzDayH+?=
 =?us-ascii?Q?/d7D12ScO++1FHBUCWQtafRl9qjYfdsWrYxTBB+2aXP7raIlheDz0TjEXr5A?=
 =?us-ascii?Q?K4SZnZaf0yfHgWg5zGU+1tngXhj6xq/NbM/NP1zNfdkoZ1hALWBwQrCpOdPE?=
 =?us-ascii?Q?e+q9ezMVhAW/zZBkCeh8hLjgogxoSTz9siQNJ/V7MekKe845apcB8pEgGjQI?=
 =?us-ascii?Q?pXmBvpNNv+YsL+xGTzMoldjYsbYl617D1VhOgLFwwhi3FgyM7a7jj5DPs/zU?=
 =?us-ascii?Q?lAua8zIgffn6SbGgnrczfDgTlc9AWz69vQI+XeFP49rFc/Md2nkGFdcqqozy?=
 =?us-ascii?Q?sx4Dr3XvGK1h/6V2nPb/4i9iNwpEuuNtHHzvtE/qsjm+Kzbo3BYXimlulJDu?=
 =?us-ascii?Q?3kHJe/YcrnhWjBwo4Bx0uIzInoOCkxlHSVCe4he1UILPSJMAwAtktCmseAw/?=
 =?us-ascii?Q?E8INZdaWltfiePsPXEXqcqmCEDUknDiEGc/gxehuluqHdl+u7PsznSTBdrmn?=
 =?us-ascii?Q?wlA4neXNn7SMZBeRX4eoerGeUceIBNVdYNNREfDnseWFCCDXLxiKJ1myPH8L?=
 =?us-ascii?Q?oYq9v1es68scZzqpJ386yrtoflVA0VTTWdK45Ckjdgk2+MonKPeDBcKzkV7N?=
 =?us-ascii?Q?RhB+BGFq4CPMcjTyKcTxB6AIwkMa+YRcbfFAZ5SaDmKUidyOruIAZ7YQGAw4?=
 =?us-ascii?Q?pWjKf2ox8nFmwz9QiQJgIIYqtjUqU22/C7h17w3+5x9ZHL20Df+whtqyPIOC?=
 =?us-ascii?Q?Eq7hRb/4d1Izm/iuDStMuE1UkbILRhG1eV1iMGOK+G/65HvsLsJXm0zhrpxg?=
 =?us-ascii?Q?pTRkk+SfFAvu98MablWW+lYtlLbSPcLxftPdsEjL34QDjMNgMAlh5IkNvI2n?=
 =?us-ascii?Q?mJ27YquSrnFo/PDeAkeAmbKamFnTqRBljTmt8c9rraHuyKXZNIRg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a5a042-1930-400c-6fc3-08ded67c1d72
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:29.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta4iysC+ELz9KeKZen04oH34ezpUkkUVIFziI+jXZA+wP2A5zjHG4zgbaofhxV8prl9vjzUqPJuqKd53Ym+tr/e/ODsvyc4e5T23a6xYY39GSkSLn5YmVn1/9elf8PLC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

PF performs PCI FLR during driver probe, which resets the PSIPVMR
register to its default state where VLAN promiscuous mode is enabled
for all SIs.

The explicit call to enetc4_set_default_si_vlan_promisc() in probe
is therefore redundant. Remove it.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 67aaf188d325..43883b55974a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -310,17 +310,6 @@ static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
 	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
 }
 
-static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
-	int i;
-
-	/* enforce VLAN promiscuous mode for all SIs */
-	for (i = 0; i < num_si; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -364,8 +353,6 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 	/* Outer VLAN tag will be used for VLAN filtering */
 	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
 
-	enetc4_set_default_si_vlan_promisc(pf);
-
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
 
-- 
2.34.1


