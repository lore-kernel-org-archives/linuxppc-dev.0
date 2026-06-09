Return-Path: <linuxppc-dev+bounces-22299-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2CFCD8C85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 03:27:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZDqb4zKBz3bsZ;
	Tue, 09 Jun 2026 13:27:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780975643;
	cv=pass; b=A3lRmhUdAAVd9ubUf1hv9IrPyFrZQIgASzQPkL12x30KieXJFvpnk5dYWQkPeOlZFBAxgSxOye06pCudMUy6pdystNEU3ODmf0liwWbnpr3avsOSpoHIHM2aFlSAwbzBbUA2nAEcIyK0O+0Hen6eOkc3PFCtziUOBjMrEPYZUjoupfFPu/TLnrtcdFCMrDMNhmDMjycC99gfJHepMYaxeeRAQxZwQT/UB3nS+nBol9jZcJwolVjbE14a8mBJ64TfdG5RLNADel2MrMlTH0ZBKHEWOefkqm9Gnqg/uoaD+EzeHeXwWFaHzv193Hl7xsJhm7/kHqNuJSa+y449Rp/DSA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780975643; c=relaxed/relaxed;
	bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3QtsJLYnSuOqoc9ZJdOsuqTQV2OU+b+VUSuqpLixYgksnN+F7Ve79hljJy83Z1kkidpcyjAabkwy+DUods6YV2sC4zoyJwX9d8MQ+DSPv8HazHf3pYnKGY+K/mudZooCYPTlxJegIyFE9uQm/o5jzAlfAF6xmPUM5jOUNWsf0ZfSCR3NOmmIN4dib4fqX/vNm8VoZyS6Z4BJgHQEm5aVJkTXzeFQcVzX3ScIJkibcRzvOXodoxcOdqIDiea+207hGZpH5qj7mr3W6agAOHp+XT6qJR8Nm88VtN4vGZxNjCVlAGn6uuE5T1U82/wIFowPa8EE57N33y4LdZK+oNAXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KdHx2NJX; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KdHx2NJX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZDqZ3XXSz3brt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 13:27:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDmmIRt7SfExLXDuCJSFj3QV/vYzNlAbNAWNNW1oKXfvwnVlSwXdSU2tXSZ57LZxzaYI2WEP4z2DsohI/cGvykR0eJM/JLKn7/xPFOt8QJFoODcJBf43bDY0yks4CTSY9Olu4/66DmffEFn66pKgP2sJUHuuKJq6QuXxR/GmiR4XFMATQ4+p1sxG7PBiYsNb9arjLaekL2t3xPH8qxBgvKNf0MeEJobxRbqiMMWV64F9R646uVOIg/7SJXjDQckln+SeIO75nf91W/zSTHrmHjrmGQSXFBLYYZzu65R/p4GBIlA23LAxz3hv+OwkL0L6ar+WW/XmCqmyWuvVZ6xRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
 b=k1oLYvb5NY4gWPVjH9PR8AyLAg+URQw3DjHfsajA6acPDJ/CZXh02j8rnA3o9yWsPvBENekd1LJWcGqXI0Y4bRodnG1ONyAkVnierhSx2nd7kOsoTGTFnWshIz4sHvSoF7l7WeIw7OdVZ+261ntDkDiPy1VAM9nRBl20rZKhYXgVG4DkV3DhOIAYeDey1uKj0kY9GITxzFHoNkvPIGPGvDjEnzA7q2/Mdxk+UuvVFnrjxMTYMXTHDoZLVmykYWfHBRea5taU4wE+nG1LpG6MTmvlI1+gko4uEp6xEI42GC/lQbTa1P6snV07ID7YfoZSfQm6n/j0Ss0HWhIqWp/zCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
 b=KdHx2NJX+S+3AufzE9iXceU27ARfEpOKb5OJE5P0SDR7m5rL1Zrwmd2GM5hp/Z41egZB14ghrum0G13KFNsOCMkIN4x3bhtmWLPDvEdLGt85Yam5mREv71Xmbw3Mo78FVEOqMT7+3fF54U2NQ1DPyb7A/ggtG5Q8f5aOsTvBYTsNZq7qT5SOrekZhBE77UIUhz1fwGgloimGoCO94K2PAQURDyqQCOJ1yqXEe1vpYOClQ5pH1ZEBDq2cKjgiHW2sSEOlaVjZ/R+i7RqPADwrhUECLf0fRRhgMFt2CC+ohrFklrKMWnt9SlfPF2ukyal6PUm8fR2OQkcA6qCh1dzZMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:27:16 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:27:16 +0000
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
Subject: [PATCH v4 net-next 3/9] net: enetc: add interfaces to manage egress treatment table
Date: Tue,  9 Jun 2026 11:29:49 +0800
Message-Id: <20260609032955.2066089-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0168.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7a6365-e300-489a-dd90-08dec5d700e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|921020|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	QqBlvsvyZ8pS1YnOwZLjW4b7lE78qtkw0ktYe3t8KB4ADgG9jQlpjgZTuDgfawrLc/KXbSVa8S5NdKbJHqNp1rYL+kaoTiQY0fCFdJFa4rhIy91MfJl9hacG+3TCyl+WqsMeKkSIEIy87E+8++O/6NkolNKS/C8n/eYj6kpMEaGe63hdq5RbmPQ3QxBJxuHMEWC0GSI3+v8wS+vxMil3me8ydGG4+lIGNKJOhFgfUoQKLk9YXmgjXOOy+Fpmkl86aNMtWSaWHr1VDKlTTQYKf3QynwhsBFqDdTOA/7EP77JZCzkOR/bc0ws31txsaxWHwnI1bqfmZdxGKrSYh4AiUTACnmLB8rQkod2niKNtYT3VZkKm8dlxiXmIyIkePwQfX/OwrvFdRKOOGsUTtOJ/EBrRDQPkl5fg/UdhLYFqhRmZFGsYBvlmkjDiybnKfBTPEMOGIruSG+7RWb/jlTHK6JcXdgJjDWGDW0JBWFpUyM3W8p5FCBfPhgIDyISyIF4pK92q41qRvKZwdEwUdjKu4fT55kk5ks0Oc39bNZKwZixphD8jlr8coE05lFLzjUISN9imVuZ+ty2ZrDts2PrbN2oq0GouC1atOl4zFHnQY2wynVhuCWNpZCQtDpFCwOaNJyzgxFOCuUBMrSmPhxOAPvWb4PIte6Gg7bBh4whArknwCMpuK3iX3/A7bCZCsiDQ62LZMSogG6vEazQZHSouPGKvZTA4pztSvGVmgGR2uhw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hu8u3d8MhwA+epE/TRB7nYGufe+P082PXLMCg17HOEt/AJKGjqhRpf6mZHjW?=
 =?us-ascii?Q?qVZdccrDTxmCbBvEhf7atbTNMmOeQTZeXH4gIsiEogBTke2hOpkyTWa0szWu?=
 =?us-ascii?Q?1IsOeRHVeoy0cf8g84FrnJRNRFCwNqGSydOJJCXUj0DgGtJ92qwL4NejZnCL?=
 =?us-ascii?Q?dK8Apgy0TT9+EOH9nIfy2/3E4/+yRAYPIgETHPXXI336yysN83Xl7hQgLJ3l?=
 =?us-ascii?Q?oRsWZW30CM9Oglp1rQ/o8DWhA+NCpQvUlZUJIzNqllpCX6gBDJninE//6eMf?=
 =?us-ascii?Q?QBw4Fu/MxP1zqwKAE4N7RWKPH2uBpIKmPVufhUFLbv25WuNaG3LHaJvvdb+f?=
 =?us-ascii?Q?c+chjmajdm+E4r1qN/z6lQJdQOj+eF7jBJuF0Mh72dMGydiPqx+7Z6xgBQC6?=
 =?us-ascii?Q?SJ+12NHI+aGpldSRipzlkuTp93hboGHdIWvM+kFKHGP0s9gq//mxE+gjeVfr?=
 =?us-ascii?Q?8q+2FSBQyrUs7KWq4B+3iwYEClcnE5p0un39Yv9uS2xRxR9QPLRz+cggU9y0?=
 =?us-ascii?Q?Fd6R37BX9gXW0Od5qWYqA5VNmjDLvj3GXW895ePqqRmd9EtsVX0WIidQCswD?=
 =?us-ascii?Q?MPFRFwtWkBbaRRwOzBP4myUDbm3dAObrFrcmHXdBM+xaooSLu3bGNWnHcv23?=
 =?us-ascii?Q?E4Vpsj3lajQN9hYwCZmbfBkhwwGLsp435W6qdX1VxONgL9GIUrR+vfUBdcOE?=
 =?us-ascii?Q?TdCiYEoeVLsm1PBaLCtu0sZX5ZYUhQrGoLYhY+gP7XjWOkkXa/LppyJ9r0/n?=
 =?us-ascii?Q?4Wr79378EPKeOhbkc2ez2ypgxtzqM4egu8HkiuPWBT7fL9/UaHlIVlOCPKpF?=
 =?us-ascii?Q?sv+VxeYxdepBh5ZonJ1xsMkgdxVZeaMNURWbMwCuFz1l8B/9bbBb1Ray53Tk?=
 =?us-ascii?Q?aJyFJoC2H55KTnr7S56J+SI7EI93wkZW/hz3wJeCNa5svIoJv3umWHo2gsgs?=
 =?us-ascii?Q?vgQT6jK8MoMBFe3go4WLnFjiikJhL1dG1mF6ygNm6OKgQUC73mGfkcT/y3AH?=
 =?us-ascii?Q?zhORknrLhWAJAAbeAYTzKDipzQfjj9vb0vwlnRupstAzmRb+h9+7pbCmORNO?=
 =?us-ascii?Q?CDy4pCONglwRQHHLaL/NK58AFmtGxU1LcfHcmisWo53fJcUM203p/dt4aBNd?=
 =?us-ascii?Q?79iG+AoNljGbN1U2lVWvNLbNnn986GbGDWx9lyUJ53+9R/F+McSdGibnhpYI?=
 =?us-ascii?Q?eY6yNLZAUUoS3s8a2EiSmaru2zq6vd6q5uWH9oTI2kiuEb3dANO3R3FIbjeG?=
 =?us-ascii?Q?OPMcrTnnV7cxVi+MsYXlzO2S2hpgYUwhhjgg6NGqDMXpMeTJeU2KcYx1wE0T?=
 =?us-ascii?Q?LOhnJrwv1+SDbPZOWFA4ErmNxBV1FxHKC/X3qTZPLfkJaK9PuvFVyetlfTvf?=
 =?us-ascii?Q?XhFkxrNU+JxmKt1hE0CaMwVEALwDoMhwDcgAwirRqqQBo/xfX0Cux21OmR9M?=
 =?us-ascii?Q?LDR5aJDoFbKAJ/awIVXPHtjoijzzHtrX52VC+gcS+hAXyO35xQjFDWMfYilJ?=
 =?us-ascii?Q?2L2bDhSO+t7t4YEQkXrgyV3eYx/eprHOuLutIHT5qYGYoA8lcGoEbzqTUVb7?=
 =?us-ascii?Q?Dhi0PQ04U818rOvCIWbQU3Oh8YNvzroU24mhsE6w4dhE/YYoaMTyPF0fS1P5?=
 =?us-ascii?Q?+55dns51+NvBE0TaNpMe4r/wM98ye6dD+Yra6eIF8017y4usaqwD/abgYVS5?=
 =?us-ascii?Q?T0i70nkl8tT74+aI2ileiK8rqtRwLy7Rq7r0EVTzRJRMCDgWPD2H3J4DegL+?=
 =?us-ascii?Q?ZAwCqtIrGwcwug0Fj0Ytcyym1nL6C6Yo5mmmENDXYqKVAnpCy4ka?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7a6365-e300-489a-dd90-08dec5d700e6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:27:15.9484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ1A7FeNXk7bKkzQWN7+3Eys4AvRBxNk3YfeFwBxfzImJMUN9cUl/eRFZti2S7vy6PB0OoA6BHAswIg6as54e6DkuiRYdrjB3ZVP9Lh/Vvx/DwShA7X4Z6qPoDg9Fgno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

From: Wei Fang <wei.fang@nxp.com>

Each entry in the egress treatment table contains the egress packet
processing actions to be applied to a grouping or scope of packets
exiting on a particular egress port of the switch. A scope of packets,
for example, could be the packets exiting a particular VLAN, matching
a particular 802.1Q bridge forwarding entry or belonging to a stream
identified at ingress. The egress treatment table is implemented as a
linear array of entries accessed using an index (0,1, 2, ..., n) that
uniquely identifies an entry within the array.

The egress treatment table only supports access vid entry ID, which is
assigned by the software. It supports Add, Update, Delete and Query
operations. Note that only Query operation is not supported yet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 106 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   8 ++
 include/linux/fsl/ntmp.h                      |  23 ++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 4e60bbc38cfa..9249f78219ed 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -24,6 +24,7 @@
 #define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_ETT_ID			33
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -284,6 +285,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_ETT_ID:
+		return "Egress Treatment Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1091,6 +1094,109 @@ int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid)
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
 
+/**
+ * ntmp_ett_set_entry - add a new entry to the egress treatment table or
+ * update the configuration element data of the specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cmd: command type, NTMP_CMD_ADD or NTMP_CMD_UPDATE
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+static int ntmp_ett_set_entry(struct ntmp_user *user, u32 entry_id,
+			      int cmd, const struct ett_cfge_data *cfge)
+{
+	struct netc_swcbd swcbd;
+	struct ett_req_ua *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	if (cmd != NTMP_CMD_ADD && cmd != NTMP_CMD_UPDATE)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.ett_ver, 0,
+			  NTMP_GEN_UA_CFGEU, entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ETT_ID, cmd, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+
+/**
+ * ntmp_ett_add_entry - add a new entry to the egress treatment table
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
+		       const struct ett_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_ett_set_entry(user, entry_id, NTMP_CMD_ADD, cfge);
+	if (err)
+		dev_err(user->dev, "Failed to add %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ETT_ID), entry_id, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_add_entry);
+
+/**
+ * ntmp_ett_update_entry - update the configuration element data of the
+ * specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct ett_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_ett_set_entry(user, entry_id, NTMP_CMD_UPDATE, cfge);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ETT_ID), entry_id, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_update_entry);
+
+/**
+ * ntmp_ett_delete_entry - delete the specified egress treatment table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return ntmp_delete_entry_by_id(user, NTMP_ETT_ID, user->tbl.ett_ver,
+				       entry_id, NTMP_EID_REQ_LEN, 0);
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 9d30f128849a..531ea7ddd145 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -217,6 +217,14 @@ struct vft_req_qd {
 	union vft_access_key ak;
 };
 
+/* Egress Treatment Table Request Data Buffer Format of Update and Add
+ * actions
+ */
+struct ett_req_ua {
+	struct ntmp_req_by_eid rbe;
+	struct ett_cfge_data cfge;
+};
+
 /* Buffer Pool Table Request Data Buffer Format of Update action */
 struct bpt_req_update {
 	struct ntmp_req_by_eid rbe;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 36a9089526ad..0c951e1c763d 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -36,6 +36,7 @@ struct netc_tbl_vers {
 	u8 vft_ver;
 	u8 bpt_ver;
 	u8 ipft_ver;
+	u8 ett_ver;
 };
 
 struct netc_swcbd {
@@ -214,6 +215,23 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct ett_cfge_data {
+	__le16 efm_cfg;
+#define ETT_EFM_MODE		GENMASK(1, 0)
+#define ETT_ESQA		GENMASK(5, 4)
+#define ETT_ECA			GENMASK(8, 6)
+#define ETT_ECA_INC		1
+#define ETT_EFM_LEN_CHANGE	GENMASK(15, 9)
+#define ETT_FRM_LEN_DEL_VLAN	0x7c
+#define ETT_FRM_LEN_DEL_RTAG	0x7a
+#define ETT_FRM_LEN_DEL_VLAN_RTAG	0x76
+	__le16 efm_data_len;
+#define ETT_EFM_DATA_LEN	GENMASK(10, 0)
+	__le32 efm_eid;
+	__le32 ec_eid;
+	__le32 esqa_tgt_eid;
+};
+
 struct bpt_bpse_data {
 	__le32 amount_used;
 	__le32 amount_used_hwm;
@@ -271,6 +289,11 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
 			  const struct vft_cfge_data *cfge);
 int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
+int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
+		       const struct ett_cfge_data *cfge);
+int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct ett_cfge_data *cfge);
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


