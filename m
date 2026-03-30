Return-Path: <linuxppc-dev+bounces-19011-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DCE10D14A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:25:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkpnR2d4Zz2yl2;
	Mon, 30 Mar 2026 22:24:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869899;
	cv=pass; b=W0yE2OnyzNcoWgCmBIbfIP92+6Kmn00J8+GmYL1XJnqXVe8LGzWS/secAJOIpTbDOGNaMS5sPH65g8HQ0Jxe9u5OqhB/TVnPEfe6y0+mEfe1EGzllwXJa5+GbT3IVpmfZXMmkHCREi27/dkL6OAdhSYvCtX5/7+6XhQy7NgplH6pe5u2E948RMrGfZ9kWuxky5AXTZcpnBEJDwlBlXgO5SuXLBZud+jqdkmpYYOqaEM40/YvxrTG1xEgrRnGQ8BcdRkai5D6yOdy4XHBPk4aBDV7ufZcFZxOk4zj3d4iufun30Ko1LataoJTSMIA5CsMUZxYaGttInBMY3fzCRgPVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869899; c=relaxed/relaxed;
	bh=y04GCk7Dn5EiZCT7lizHtIqx7R1Rt2FBz+pto40UiW0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrX5SY9Mqokq5S2TvlKnzSsp+xntEFdU3OdbEEK3ynudr4v0ONBm1Q0iwEYq77YjS3IBVfleAWXeTnsjYmJ3kPBXA/kBSt4FjkoUcQcIV5cNK4ZqkjXB+AYgDf5Wp0vkNGtejCn8pbJmhYF7IAknZ973BtTQcvV2JYuvYQJuc1I1Z7OUm4CZqzs1rgWKKoMCOxzTgP2S6GWfPW/jYv20w0+DnQ7mutY0L84IYJ76a4pICBUJfucqhqEyaugGZ1ufWmoY73ksPaIFcZ3rPwD4lWFPsLFGUF06FgVtydrJCs8scYOVp5e1e4PQu1OKw6Q4h5iSLLzVmSos9HNvcJRrZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gqty9s1C; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gqty9s1C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpnQ45f1z2yjm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:24:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyWRCakk/gEFEPTnh0sQ6Wr0NbAmdTYfiGelq2oXp5wQ3B0rRQJT4ZSYlSQ8y/tTfFAOXdXmR+HlMDKrgOnTvabt6PFDx9rt9ZNh495myQahbI04NTGkODCX1etZlx1s+17sOm/64zWIZ6EbxaiQyWgBDsDYH6wL12wlycbyVRInjWIX7MMDr/dAX64so6+SQSoA6oA3MsEvs1f6KmxatOFqXZNQ6juas8nfpHc0s33YP06T2iG/9SiFIi8ugphgTkU1thQwDL0f0ALzeI79BK584dO7sPkf7NiCLr5Xs70m27ynVir+g7xUjjbhHnVZ2mg8LibUoL/DYgEOThnY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y04GCk7Dn5EiZCT7lizHtIqx7R1Rt2FBz+pto40UiW0=;
 b=uQArv7xD6XKwZBDQaIpjcKT2Sz+quk+iX+dsZis5tcAl91VyYtstr5U4NzFk6Kp6k9qV06kOMp7AvxBC9gaO/SGJlyX4kwqt4NMd3LpdmiyxIlV0n4bvZbLUrFbHBKt3Sn6Fusj7VnjPMM/ZIVD2prJgw0+2IkPkmQGUkDoEVNXfpg3OIvAkeUbsnalY06cg26I/Cc7Vg4wzyz/NdF8GK9sF3WBeroIiR2yj5DootWPwLHMdhYNbRS2s65gBySJvEZI1GXuD4iwpq7c6E5eJfSJdkaJbzH187vxavOq3clqyJg50i1rCnWm9goSnGPoWXvNqoW6ZHJQlQkgrZh0PyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y04GCk7Dn5EiZCT7lizHtIqx7R1Rt2FBz+pto40UiW0=;
 b=gqty9s1Cg4+jnlkaUO2eqBcnGimNudayRzwrIEwq7bS5shujhRPDaPGpRnS/CRfqArINmXv6j+bW4uXgIXKLqqW3exrrwF3hYcEgn6w8oi8cVnJFZm970GCGLPPByXKHHsBvMgcJTBnTDW7l6iXBgmHWvEns9pyI9jahV0TS3gqY7A5ZrMZNr4qhCnTYtkQB4OCglf/55CukPiu8z8j1cFHaEBs3i1KjPyC9fhLnoZQFDqO6GO0Rtbxdh7yXdWvr2CuIqL7iFGejjjgBuJi4kM83vgL9F4SPIrT+vSJBPNcFn4U/oVanw6ZFb3I2kk7wwMqgc4n6eIIvHFs9Hr6lMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA1PR04MB11036.eurprd04.prod.outlook.com (2603:10a6:102:48b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:24:41 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:24:41 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] ASoC: fsl_micfil: Fix event generation in hwvad_put_init_mode()
Date: Mon, 30 Mar 2026 19:25:47 +0800
Message-Id: <20260330112555.3637002-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
References: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA1PR04MB11036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce97089-9b93-4849-87ae-08de8e4eef47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|52116014|376014|366016|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	32bB7kOFUTXKEjj7o1NQiQuYJl/ZMOGSMgknpk00DJSj+2gMVG25gkSpy8dD/chZY99pRAc3aG9PbYxKBU20cPD9uLON00/46W+YLdWWaWAC8QFiAfEb8ApuM2WuHwVoheKfwy6pk1tqUZwvBOaB+Jn/JkXMHAvwV7862aN5Kj3cQB6h6ntnU8mcgTRzkgdvThso1RJiv8EUAYz1Lkj5kY6GkkY4fcw8HPGn8ZsEnAuPegtH3Fq4D5D8LOUVNeuw3pLJHMQHYfM45veOJvuSMZrDqzUNVOKlt5aTkFJrqjZlsrS8g8GWOvv+2u1iBQaYZc3BxrX4XobkI77B+kyZIO3mVW365b87IGJ5XeKI2Z7FDKRftKSSrIpDK4vpSpFHaoDnArNdmzDZ/DqW5A3f7PvS6sLZVwlQwv0pXY2BXmSRozyRbBzfe7OWmBKsv6mlLxHpTbmB2iofR/PYmZlU24PjO7OFfdBA/NNSuPD/VNhDNLR0exAxqhJqzx7936A36onJa8PZbd52Hbbx6EmkYXleMljA1S+lFqZ3KM/OWvOwj7J2bDkruIQ3OtGke+l4YLUprKigMPUXOwkRuG16UBP/wo1t6EK1G2eHDb12YebbWbnTP5o+CzK48/oZeahpSux+1KLtQpKyAgp3RcgRIc4KOVmDqiTRDQ1XJQX/kfr1AbIAo5GVhhqDUDOXSdAZ5nAdcbRBHy6vu0cRCLixUyMwrELcxFW7WAHSTRjaWlT32eJRTfveXuu/lNVnSjbq0Pf6iX11yBigsnGKArByU+BSXLKKojRFXEmWwkENRjcRmINhKsj0T3oSf/Girkiu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(52116014)(376014)(366016)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1aaF/59ix8xWPSjGnMWicXCruSqMwfIIoHm73VE/J6mEEF5SrgNMz0QbD+9d?=
 =?us-ascii?Q?pCRpwYHQ5+/66rZq3cumnOtfJsa03YDfebMAXYr+qBNKESxM9bVKAUtwldtN?=
 =?us-ascii?Q?ggrsWL37Xclpuwafh/EkQzG06WjKmCrdb0MbJnmSQZvyA/gQaH+2JkDk2P9T?=
 =?us-ascii?Q?E9wOCYh9M0ql9JTwNMfRDGOwFIBEma+QEfCOy5+mFci/GoxhghJvqxJY1jfD?=
 =?us-ascii?Q?jxJ5phJ7pDNulotuXY1uMWhgBwVBJ4Qi/92mQl6kJKn4CWoO8+ASz/2iaNWO?=
 =?us-ascii?Q?HXFemLhE0vWejuhECfxif1UBtnqDzRqonpgYJsI0nlCcLrhcC1f9e2luhqMQ?=
 =?us-ascii?Q?qOTyMIeKOdliLCnQH72frN+ijYmHQBJIRVfUrZL7xHERG+7aua9MEJpFFOMM?=
 =?us-ascii?Q?6ELeNS4ZLPEH3hYIdIAJjWQvsp2mkyQrfPF2TGwIfoKCzajCtuT+FJE3Xk+F?=
 =?us-ascii?Q?ucG8KkIL3bFjUsDEDMkKxro4ja764FrgvkrENgHVRtwKBmNJnRSSb79A2ROU?=
 =?us-ascii?Q?DYqKrqNIK0FtTDWs4Yv8txYapbERXcoJTMrtBU8K/ntYaUdYGb+XcCD9gjzy?=
 =?us-ascii?Q?cZVW1mxtK9MykHqfcEt+wiT+uHBXTN/BDg5ZzHoyXu+WgbiA0LSOQ13MYqAi?=
 =?us-ascii?Q?wdRNR/48T40FpKSzeGdn+lNHkeZr3tlsJrPMQjYw9nFrCeV4zOuem4x4tIXQ?=
 =?us-ascii?Q?atQwky2PQF9I1bTZE4Wv4wxTrZn5ueUnieOsfUqi4AkENqvZDp0Epipj2NpE?=
 =?us-ascii?Q?07tAiidCeojIXFAc6pZ7UX/wzcQn7Nt5A5/ZImtR+tCYnlilvJfImm2SezJs?=
 =?us-ascii?Q?w7wUGmlhek8B0VVjYWrGwVFjGuu3qS+Ss7+Zwzji4riTwC+clgwoWsVlSZla?=
 =?us-ascii?Q?2WtcGngn9LTngBLJoM4rH8WNQ1dZOkTKjHdv4vLqBSFBzyOdgt7UiSOWKS9T?=
 =?us-ascii?Q?Hnqg3GDXveLfBcVWSYJoJDJWudBxWowz0dpbENC8Mkyf2/dq2mA3gRHEHruG?=
 =?us-ascii?Q?au/lmIgc8zqm8rbZRAyEdDmnNbLF83CtRDxAWRFpY5APhUDRFBdBCpDJ2CUk?=
 =?us-ascii?Q?whhuT7NsKfy37+TnnKhp0PTUl65/QhT8jaBiB3kr7/OEqDx5vYV2q30LSMhs?=
 =?us-ascii?Q?fpZSs1Gmnd0YzfhVPyY2veupLXHsHM92xlFQfmUmIPspgiHXZk4V95MVK8vF?=
 =?us-ascii?Q?Y6FAOniqGqth0QGxGhmmMxc1myryy0+pyIteKp45Y2a1OB/q43fa3miZTz/w?=
 =?us-ascii?Q?5REdEmca5U3iqBQP363GUm0Bd7JCwgZmfbJaeK08hkZmNPQXiRH7WWe2tre2?=
 =?us-ascii?Q?KaxlPuoMRzgrKm6yQZM0TbdI9KIqMdYNwD/wo7FOl6FviBGp9B8V0S7wNpdH?=
 =?us-ascii?Q?0TbP6iN4ZhiD/q9AecnMllaQccMMrjk68JOVF0GEwl8K9HlitY/U6P618Fuc?=
 =?us-ascii?Q?WVt/eWMGHi9EQdLfzMYnnQ8EILab13yEMXH4eepipiUj3JjT2vNNiSm3l2l+?=
 =?us-ascii?Q?WPf/qp1mWu3xu2dr32S97jEorDRKB9Qv2KR8Hie7MKQlXRoRYgXBsyfqCOga?=
 =?us-ascii?Q?SXO3kDHY6CZyrCuEpD4u77X7MZCm3C6+RAlXxdPrWkZ8Vbu+bPPRnYAeESjQ?=
 =?us-ascii?Q?8P9ri5KPs97PH19JxwGo8isdeeyk+SSRHP2MavgRXME7KtAeZVkT8ieWvWsy?=
 =?us-ascii?Q?gtPMhJurnc4V1QiM98TTZ1dAOwjaTUy0nwroYCH16aB+xtHqvu6AJYjPatZb?=
 =?us-ascii?Q?WAI092t9ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce97089-9b93-4849-87ae-08de8e4eef47
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:24:41.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrSRTZDYHdbFK2p5lgKeSu1zJJCNQZ90Fc7Ixs1cJULthS8qKTyGtnw1wMwXgnqG/a3y/s2s7Gf82NUq1ndcvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11036

ALSA controls should return 1 if the value in the control changed but the
control put operation hwvad_put_init_mode() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Add a suitable check in the function before updating the vad_init_mode
variable.

Fixes: 29dbfeecab85 ("ASoC: fsl_micfil: Add Hardware Voice Activity Detector support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 97f24c9bdd68..1c826e0cb1d5 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -407,13 +407,18 @@ static int hwvad_put_init_mode(struct snd_kcontrol *kcontrol,
 	unsigned int *item = ucontrol->value.enumerated.item;
 	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
 	int val = snd_soc_enum_item_to_val(e, item[0]);
+	bool change = false;
+
+	if (val < MICFIL_HWVAD_ENVELOPE_MODE || val > MICFIL_HWVAD_ENERGY_MODE)
+		return -EINVAL;
 
 	/* 0 - Envelope-based Mode
 	 * 1 - Energy-based Mode
 	 */
+	change = (micfil->vad_init_mode != val);
 	micfil->vad_init_mode = val;
 
-	return 0;
+	return change;
 }
 
 static int hwvad_get_init_mode(struct snd_kcontrol *kcontrol,
-- 
2.34.1


