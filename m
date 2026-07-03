Return-Path: <linuxppc-dev+bounces-23494-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B19C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:43:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9N36mPvz30QJ;
	Fri, 03 Jul 2026 20:43:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075427;
	cv=pass; b=OUE74lgmu9ylSHNRH3OVU4BZ6Q687x7GuoMPHCcsQ9pillS8cQKWnlxn81cb8JMgvpMys7Bifj11s23OXeBKIT6XtVy5maP+DnN8av1QIx4uylr+8t/OAz6pCBbtMtE3tQM1b/Xm+7H1tESK4thk1D9O0+KBKx85jBWGHt/rvJOf04dS0V065N+E7/ypoo9Pn4z4DYHhGs/kg6/nOfxzSzkDYFy7VDF3G5SdlhXbnrS98tfklJ9xpYZZkwS1zOPro/61ObbkPKpo0TKIbl52Sw7O9M+CMoooc0WF57+TGLoG0h+iwT6cgib4ifpxGzDuBQaALDOcn1LjrOY/nS24mw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075427; c=relaxed/relaxed;
	bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OC/Km+ipMT28SLfrqd6PF6xrk+tH90+u0ijic7t21YEcjoeYDScL41EdEx3R7eemOwf2m5V9815/rBTn+g8SWG2W4+hVfWDiWvNnUHe+IaJwDBTJRKyRjB+H7cUCbrgdKg+I3wdnupgvrNmotQ6amE56sFlKDc29POcv7WW6xeDOQBZpgNkeRRIH/5XAlMH5Fw8PuXX0d6wOMXJF4wtgy3rQ1F6GnDTOGjBSbuN4QzDMo6n80p2z/4K172BZGqvn9/yEpFlWYhtjqIP+wKGZ/DAt1X2KSd+/o+oe6PjQe4oDziJEO88OtDKz8FqfDkMZRsqvxbntFldKa0mxRSQW+g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m/5VkBrQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m/5VkBrQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9N32MLbz30GV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:43:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3Y42OHWsc8TecQaN7SEOlP2qqrZgK+40W394XAl8THBwosHDBrCuwGwjAOUrdJf57S+AFerLag+CyqtOUu8ShPaUgYZr88RPJaneanHbH7lIuEXY/hrZge/Na9HF0NHkEQuM5tDVbNdYmRNYjdrOy8mJzeDWIQiF300foJPP+5lT8+u/YXEwTgUEZMKncsbnaC4iOmRH879HMmNVW00iHYUVPYrEKs5Urg5wIiU+B7YPK6njpiCqQEtxAceXb2Gh2gcZfFSklxxoftnLE1Ikj/k+SNkPMcwByjcVMUe6dHLItBznB6Z0KIK3QtlBdKViSv9TNrw4hds0annj2bD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=huZNjO4KoJTwNdR8OrjbySGUDGdYGlybjvCKiPrOqvmwbeXHCXaDNd3p+TyobSPVT+DO8HTwOVm+iZwaFnEyuwgdDZG8mVIaxlr+twU4uP5I3FKMm2fhmXZvIHUzVeR5ol7yQDz0EmaIF2sjQbqLSN1apKlEKp2m+g8yvn+QRP1QnDJqpTkjyl8QjLT2ayn+6mJjEPClmhwlft7i2kSD/j0RieQiMmYqMBTM+aYhAyLmC0hwaHRHNglWZxzz3l942hRIbJ3n3UJ0MvLqVNETa4BJ4CYeOb9dbve+RtWBYBfvwKOyOGt0TVSPEt14hhw7+V6x6hL2Pcrxm81jCtgpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=m/5VkBrQz3Q/WMltlDKVKirakV+SqVULsvBwBlLSKMNq32OnFH/UmvD2aW83J8MZf9izPXCL41B+lNgNqhNl0TdONHsPpvqKIpyjAu45R+w+EZ+friC1j+Y39onQo4R7u8NNIphdcgxcKyQdkjez3QiXa7qQoyvT4kFVmY6gFh5JUx9zgD87SedH9RvDWAhvd4LugZF4rEJUrE3pPfBKdLxQQ4X6POp4Ut6MFOIvjohuTyUzQuecxGzK/Ws+o05a5JTcp9ySBsXU/UDtqTmxs7o2XSzVIy8olzk//fqAALN5zZzf3j/L1v4NX3tQJ9pwchfKWybtayzPWrnAh3+9Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA1PR04MB10867.eurprd04.prod.outlook.com (2603:10a6:102:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:43:35 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:43:35 +0000
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
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 14/14] net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
Date: Fri,  3 Jul 2026 18:13:28 +0800
Message-Id: <20260703101328.550714-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA1PR04MB10867:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8f8369-812d-4221-cc48-08ded8efeecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EzbrwlY9csZdmW1L1dEX1rop6loTKTVgOI/mysZckvW9h2AI92c0XsY7z344bgZQq6XKp5Lk/xx2c0QdEBxFZnQ8mNuse6HULiphItmbVxnArLlb8oisHQSFpk1/WBULrshH4eX5YmVhnhEtVfgZYyam7V/Jofd1t7ESCgy3dydCFNONjf5tNnr+f7VyVMnUgrFJj1ar0XAXwYutYzVFaQCR7S28kMbzcKr/oxmtJyia1Logs28DSCxqPYjJLOgP2MXMcIhjlGP4yIqrgDSa80IpoYIK5noTDNx2+DhPp0B2I9n6Z+XBchtiWPTmDEkiSv/M1feHm4M5Jjur3iq59crtSLKGyPlnH06NzejWR5eiLL2OTEv/tzW99UDor0/l2RPHxcERztC+shlKg8cii6FlJ1Q7AXde0lQxt1P8GqCYoawjBOuswI8nXJMbIFRMtlD9LF6FbZdkcUOGyiFR29zbiFyC90xUdpFTzbCelPM5pp58mJpTgcoUpg2If7oKQ2OSnU3UXHn+hEN4lEwYc6KyKXqrW9HbEFXtn1F9YStA/5JDZGAwlsjjtfNj0qjUEOPH85HNPaFSeBhJb6kcg34sieGCa+ituJUc+bn0D2b4gUEheQ5deJ7xdC/5uNeOYVDsWUx00e67qLJINWklU2VMF8aUC4TEHHk/FF+zJpQ4FwquFhX8XYFTcJ9p40pP5IzWUPyRCNT51v2157jNRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQuEFqUhfoK5gW0+53razjDcGvTh8JVBySTZ/BLEx2zkrsAUbWgZspPKuufO?=
 =?us-ascii?Q?RQdKoev30YfQ8rB2rzGtASEgjA9jMUXf2bVFTM5ME+I3hDplIVa3MOT8L+nv?=
 =?us-ascii?Q?LV/eMfMa18gw5t7mp55LVpsSha0do10O5FMb+CmcyWFdhzr4qkfpmBf/Y9sb?=
 =?us-ascii?Q?3wdv7H+uCE7bj4kBUrgEVaEYGdDrD9fcqynRyhDre0DAiKNIXgNJ8/MJSU3/?=
 =?us-ascii?Q?/JMuO5OT7dPvuW0H6BuM+NsS8rSY6vBwmfu3vKwZyJOhU+d2mt2qVgLE/EHs?=
 =?us-ascii?Q?B0vRH0udfRbnGg3z++ly3NKApV3fr4nEQftPK7qE++QKo8QRqS7gZvJDNCcj?=
 =?us-ascii?Q?3i0x0IOKHd2BAGn8jWAiPt0eSr8FUfIF1RX9qDsqcdxrLODQ1GHvp9brGJdj?=
 =?us-ascii?Q?6uc2+fokc9F7qcK9kuu1pJE9k1SOCIRVZg74omNp0n2NkJ5Wgl+zcG0Zyh97?=
 =?us-ascii?Q?cOsq1m0aK9GYVKqrgvPgOjPnYr+uhPV7x0AQtPDJl94ecmi234FfBDLhrYlQ?=
 =?us-ascii?Q?sHGAF1Vr4GCPoZ44B34LFj3EnBHxbcaEsvEp06CbW3GuT+bfl8OjA9Np8rXC?=
 =?us-ascii?Q?Zot+HkTaopgfLGGr+40GMMCS4QPE5yhg9xkA5O0o/rNU/VLkt4tyhKQiID9V?=
 =?us-ascii?Q?DVp2XIOs8FYClZC3OOrwVMMgLCS4OSmBZYO35ca59ZR23SsX+kYS0pYzQJ7r?=
 =?us-ascii?Q?tKMzmZa5VHuCKtz/uNCQavtS7nmptB+pcGSfSajDKSljDzSlERw0rT3HM4kR?=
 =?us-ascii?Q?fSI4KV0wXHU7PX2tS+KFMIpNr7LPs6LYLw55/aHhPOoiNNqxh8s8EcVka5oe?=
 =?us-ascii?Q?+Jyy6OhxshG43fqye+ahYO0OJum8h1u8kNo6sv2lkuuPfJLjcMpNrbxsOCp9?=
 =?us-ascii?Q?EHeXPi8W4cdgUpLQBO3Kj6py+BmsLnX8IzAMM65VMhUv2DEtjlN95+41CEsQ?=
 =?us-ascii?Q?b1YewQM7poq/nn4XnpSPtXFfLDDGz7gQPlCNq8hqVLmT8w9wYGQuqxoeuveQ?=
 =?us-ascii?Q?4opOYHUR9WS/i5Seoa4zjTTrJuPCQVnSk7bxuGRKOKojeNfgeG+r8PmwpBpW?=
 =?us-ascii?Q?EMWMAwBqag4WcLXJ3O6dNnrZIrc2i2U98Jqzc69zfJefPFwYg/NQzFxiqosY?=
 =?us-ascii?Q?yJd98r65Wguj9JebrpYaY+EjLmsytr9zHcy3thmc/DG4BCVwUMewEZmeYE6g?=
 =?us-ascii?Q?CgOROcYOJrfbjJG/zT0JfcgYe2ip61R1xorEAnmSO0BkCJfbeIFxyBRVbiSu?=
 =?us-ascii?Q?oi8zZAybl8un4o46UTVlFDBx6YU7vaioa/k7n4egDMu7rOY+fNvstUBtb21q?=
 =?us-ascii?Q?d0am9vkkWOD1L8yQ9QXX7if9CKluv4Cx+dzcnHrkizhv6bg/ql5V28uahdWY?=
 =?us-ascii?Q?NrtVgg1QygeFvsosSBCOgis6uxDtz/dQPVOIwp+4Qtct4Js8jryMnuupLnND?=
 =?us-ascii?Q?fnynF9RAq10aj9BhH/Wmfpgru8QgtP8MbgQM1y7dkSaJgjjP30Lwj46i2lRU?=
 =?us-ascii?Q?gz6MYGe/pVekWtXkwNrVNaqI2oOFX4G3mxgyGF7edzWc56Qb4bO8HoVOKd75?=
 =?us-ascii?Q?Wrqs2nGcZN8jgxZo+SEt0dbI5c4UPg5y1w5jaFHUDA6IRvnMLPYkwwkZYyqb?=
 =?us-ascii?Q?c25/2YWVqSc+spk5QXMOGJA4dWd1v94K2jyfC1vQ40F/luMjA1SBw4QzccTx?=
 =?us-ascii?Q?CMYQ+L+zNVundBBNVKDe3AaULsnAai1gdjOPQbtsnued1dJfV6cLq1vSTG5G?=
 =?us-ascii?Q?p9YOe/9XOO430x4HnCd01c1DhXX+M12JBAJqvBgmXIwA3OhtOoCl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8f8369-812d-4221-cc48-08ded8efeecd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:43:34.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4ZbzMIoZ5TPYTW4IGqdY8s2aEtW+XeMQRGqBvdPutJrw7hkdlXqSdlmkT7BY2Wyo0x2lO8U1vO0XPuJzaHwb9JMfY3oGHka0HAxyOK87iaJ9+PQu6ctv6MJDAVriI+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10867

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded struct_size() + kzalloc() pattern with the
kzalloc_flex() helper when allocating struct enetc_psfp_gate. This
removes the intermediate entries_size local variable and makes the
allocation site more concise.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 7b17bca24f26..2aa0fcaafcd2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1135,7 +1135,6 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 	struct flow_action_entry *entry;
 	struct action_gate_entry *e;
 	u8 sfi_overwrite = 0;
-	int entries_size;
 	int i, err;
 
 	if (f->common.chain_index >= priv->psfp_cap.max_streamid) {
@@ -1242,8 +1241,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		goto free_filter;
 	}
 
-	entries_size = struct_size(sgi, entries, entryg->gate.num_entries);
-	sgi = kzalloc(entries_size, GFP_KERNEL);
+	sgi = kzalloc_flex(*sgi, entries, entryg->gate.num_entries);
 	if (!sgi) {
 		err = -ENOMEM;
 		goto free_filter;
-- 
2.34.1


