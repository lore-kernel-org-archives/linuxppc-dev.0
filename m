Return-Path: <linuxppc-dev+bounces-21845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC9CCD6E61
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:21:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2L72pRKz3bs0;
	Tue, 02 Jun 2026 17:20:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384847;
	cv=pass; b=VEVvdXBRtQ8DY4vDwrS6D+1Jf+jStXqJC+dPc98k3NNeFzpnJK7weOG2y1LSzSFsNIUUXA3qzFwOl0QWF101K6OTXY3vTtCu9ZASE4e9SEsPMfT9cpZ+zCfRuu7XMJ7sDbXNDpsMq/a5hyET5nZaTHBfuIP31EzzDMmuO/uQl7MxtSztUoJ/LNy/7HdeN9gYJlSGvEca2ftWREIJExLHMFvZXDgwophMqDCjcSTKn/si2oKhPZ9pYAHa30Pa+kwqXirGLQDc4zglNzORl/t7BKQ7zQUbHU38xG9N8KQFUyrXQeiA5tq2fBps9vqGXlkPauhvoKOyDOW2iefUhfYVqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384847; c=relaxed/relaxed;
	bh=wtmmJGFX5CI8SdVwMEI7MWEuLA5nrLpSkWxkqfWzBvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtY7J1zxEpqEAe/xnYEyW8mwIAXQRCFO49M1LE1FH4G6euK0lqyvWIHUIJHO+x+cC876ONDOCpTCX5QDa1mJm2TEz51avFISn+8IAwgfo4rOvo74zfrd4ZJhmKBEF2AFX0OyJq22g+SHKT6BH+IK/VjYJbTNYgwbR3FEqgYnazqfFqf+JtykR7cXZC9OZphnB4doFWNeQqaOWmgL94Q0N7iiTa8D7k51V36+JlKjkokxLnxUanZ84diEJm8yDz/7W+pmt+355fwsMtM64GOZKYvk+iO3H0RK6AnvApxPDZcNmeQ+GQ02gT5BfCqC78gS55qoMs5WDDDOMkkUUaubGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mqUhrJSa; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mqUhrJSa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2L61t6Hz3brN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:20:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoLYakO2wDQk2MWOKGRQKfvrhQb90U6wMiyEf3IQkcNVyouodhaQEdQhdCJS21FnBmAb5+1W/MBk6EaD/ZyBjCZHZuwDL6/RDMlWvRZPMNB7W+BtWLgoNQpS5KepSOz3FyVHOzA9nQm66swfCQcNAU5ek7rTyRgAVvdFIN5B/kkg1keEAonIsGGIGt7UF6HwCVLBOV7XpA1GIQpT1pkXCBGf02CHupk/M9bxJ81k4LUNCOnjGweCXHPH14d2QitWiEYkWUhVVH61RYrRtkP+6cL8eaxwNNh+myvlcanOwxE7z/gbqENKpeZuKcXZLBJtDxoa5WInW/oNfs70x8BvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtmmJGFX5CI8SdVwMEI7MWEuLA5nrLpSkWxkqfWzBvo=;
 b=hCbnFAyV61k4vM5t4o1qb5Y39Uw5HkCotmtrB1w7kVhmiXcmDryqmAWMHewssD+8+mQEUuCuOa/b85szTVlquZiOOI17p0YKu8jxYILDTJIW+LbtLZ4VSPgDIxK4riR+jnTA1fyDRgEsuyWmYkuZxcnKRZvNDgYFpqg1KRodnZyWg1MBGXFgHf9giqcULiV8Y6/0ZZwF2r/ZnDw9Xul579NsZi6sEvwDZhdomUxyGTwXz8IVkS7S1W8fDI0XMoPyFd1QaUQsAfOKULsMJmnhhPpwV0VelqXjXosiYkhj2LjJ8svaSRcPCUjszmf+Fv8rTKG3POTDG3CqC1U+8AQYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtmmJGFX5CI8SdVwMEI7MWEuLA5nrLpSkWxkqfWzBvo=;
 b=mqUhrJSaYg7EhUNxuQCY8cCLNT1+IvuN9KkUj2Co0vjoX7+TVbBa7K+Mr/gBDE6Y7Rl92nbyBn6CRVoBYq0O1bmEKmdi+NkDz8FcL/s5OCdEFMyJvIyLwaEutOHEaux30MZHoN9mD1yZnqULl9tYD30HOHtyaXGmqR4KnTbyG37aOWXLSd0kaq/VsTtevJV9GU9uJbZ0hgVOFli82/7DAhT/gcGxfQ0T35iLMyynilNfm1MYGkB2eflT8WK2QKVl2jFvNv+HWRyTmFxMlAS+HlE+BUEVKyK/kuP5PUeTUPuky9+WNqCCPO0M4gBEfxSp/HQSkzaBpFiGeXnHg1MD/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:20:31 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:20:31 +0000
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
Subject: [PATCH v2 net-next 3/9] net: enetc: add interfaces to manage egress treatment table
Date: Tue,  2 Jun 2026 15:23:07 +0800
Message-Id: <20260602072313.3162120-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 0bb3150d-eca1-4650-5e65-08dec0776e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d4P5uy5sQuaMPM5O+YP9/zLDnSJ3pVXOsnfmD0Iwlop2HQ+w/6nMa1mZ7l8vFRLjK1q2rIFysYYTWUPtLRAXSXRaLbmMW4d5expAk/6eciXc10aoUSShJ7IRvUKfX0JCr4yNKLcfqv8gIqv13rDUc5DG7KxRZEAvTV/qpVMS9BUVJhxpJCzW5Cv7TX6thce9k/sltzCyUxURn8v7Iu5FI9CK8lf2MQUgN94/q+AS38NkDLM75VSY6NO6CF8rnB7ZviCJOKbZszuDrFDXguYArxORaMFoQfxzVpFf5x9JveJ6LkM27Xsn7HlD00cN6iroyuatRhClxoMCO6/FpXiGqCh/bFB2TVIou8gJB8Omq6OGF65ce3/Q19g7D9f3UDCi0CIxtGmnTReP700+FRgXU5WBddAMAFgobGpgg0x2EXMv4CgqmXZ7ugpeczab2YECp29SD4jNb8pr3BdHcYo3ned70pDFqJud/z4MN8GrbA5cDMv01G8puijz0ZpXZk8LW6b+fKGJu8NlRk6pk4dYcPB/BH+iuEjhGuFU4d948bouF4wBqhwpnFYKOuplpTYrPgHY7XlRMJAYGfize6MlnaomjE2haXWmPXZ8kyJa3976Vaxr3qkfXEyrptmZkhZLDIvZA5yWcLiSzLCb1oea3JuTrWmZjh9tAH5Am5dUT0qImjLHpcivWoLL1qZlzoy9z73nWzdmCr1xpkNfPk6/ZRalQFLw4Qckz1uR+meOfDU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjpYcS7XGcP8vjbnH0EA2H0UAUXa7wD45C1FKSjKYOALpM/9eQoXDFj89YtU?=
 =?us-ascii?Q?r0nZvaf0Yh794mAkv5ebyDn+Kzis/rMpk8j/mna+y/l5AXS3QmVpTnzhUrOd?=
 =?us-ascii?Q?5QYK/FrNbjHaYtSHmE/hyWDJ04RtNSEvNzSU10WSrWAYSArsIOr5d6ndysR0?=
 =?us-ascii?Q?rGcvuuDsmxasle3UEpdVlMfp0NOPVYblIkbFGgbgGKz6XpOxjAr7DzVWbLa7?=
 =?us-ascii?Q?aB3MkZ9scd/VDMQxhbEDgeStmo0kwE1zBBCxfiygNR+hPG2KOdenHm+UDgy6?=
 =?us-ascii?Q?nVS8uuPWZLCo6n5San71ZgrKHuZyUHRwenTND3Amj7WcYyi/tAt7/YlvkI5t?=
 =?us-ascii?Q?WvXKL5h31HkirviQl8rlmCo37OOqvq7Ug0th1rxEm++mmQTDlo79DXWkMBY7?=
 =?us-ascii?Q?BwjEXmtKqMnNezlDnNFnhC1Lb7ww0J3lM6+GPfoubbC3+tMGwyFeS9C/40T9?=
 =?us-ascii?Q?XsZ71I3wHJMguNDwcLD2ifb8kRRKfck6wERW2Ovj25w4w2npjoOIJeNevYF5?=
 =?us-ascii?Q?Y9BYu5G8uhoOXy/XSb5UtU2iVGgeR+lrjsKurkznDstQjowTU+GD0/qYcFzH?=
 =?us-ascii?Q?lRNlX7KgGUPV6eAwIzZgfwIqPxf+G7Ktci/NsnkGmx39HCRw5M2y/3xznlx+?=
 =?us-ascii?Q?3HyhZen1DsnAmbPgSItp6150YlQiILr065Cwfs4r/ddlSocA/CXB57NmR98F?=
 =?us-ascii?Q?bIIcP+e5AiEPjDVoK1l+bPjcgQpw1MckRC8HrLM+PBvqLBL7ccx11fqlslD/?=
 =?us-ascii?Q?lviTu75ODXFoM8bN9Zoz9FnIqH68W8hy+nOYhH6eRiwXmVUchzn+okiT87NV?=
 =?us-ascii?Q?mg1fpamA/NAcBqxNdkAPjM+0k11m6+ylzwb3rzPIeVJHDjKWhSTywXByfz8R?=
 =?us-ascii?Q?YMNPRyv0WAFEEqKBIjsw8Hemv7N80SiEuoZ+hUgHdkZzk2wIRmYNLeCrnPuA?=
 =?us-ascii?Q?IXlFde1gAYrvqfwp9JHUKu1p215qDeFORmaXZGjv74/g4BWl1UOzFkPK5AXf?=
 =?us-ascii?Q?fA//J8pRXsJ9ssyEVkv8cSoX+v+Q8KkFfIAFklV2TSPFDK2wseJHZdyrTt6s?=
 =?us-ascii?Q?F2o8W9fPUTnW74up0nBkgdEPJBLNLutOyppKLTztDNSeSdNEjmOe6/EDTeni?=
 =?us-ascii?Q?+0SIv+XsDNQcmBTuFygggWEU/VzsPUwWqwicmGGYGAudfgxNy5CJADZ5VxGc?=
 =?us-ascii?Q?29NXvCM++PIASkl0ru5kHkXRjPaPQDfyOTPwiIm0TKjniSq/Y5qCtfP4DtfG?=
 =?us-ascii?Q?zL4/H5vTTn9lvokKNjZvWOlxManGdQGEa72nLSrzsuEXNTcRtPBMiLZgKr6x?=
 =?us-ascii?Q?S+VdLqO5R0TBROOCsfAUcyz6GKyovo5KnD8ZBIS4erQqZvLPmX98txxuVOWy?=
 =?us-ascii?Q?p4jCZrBsQ0lBZVPqnV2Q8z+dS8pVsqGEPQ9SJBVnDM/YynXwxRPDYyjsQRxO?=
 =?us-ascii?Q?3mwNYG2F7SeZrecvsT0B+W1mUVUGX9T5501RSHhEVfms5oNGXUkAf3Sn90FT?=
 =?us-ascii?Q?BduM6I4zDLthNzwCB82PCh2rWPtx65EyzvOw+KCWedX4JbHeapRnHCeQT7q7?=
 =?us-ascii?Q?h+XKTuhPMVmZSWG9DLAlfHK5wRk4MPGuKdfClaFSpPG/640DXJAaCLafvZ/c?=
 =?us-ascii?Q?LOGZgcMwxqhfWJa34lonh2T4ZX/6Ogtcu6UKzYaa0BVr7DODPFM9Zd2OJJLA?=
 =?us-ascii?Q?xJvdXUxTqol+HFJQwpZtd7xutvwkmsGFg6a2MkH7PHt4wpRK+NbWDER4U636?=
 =?us-ascii?Q?J/5EkEtHTRwDj32LeITQEYKyooophX//x7EQvUjB4qHIDim60VxG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb3150d-eca1-4650-5e65-08dec0776e27
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:20:31.6608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAgSZURkkIxRxtkq/ttkiqeAQn/4fb7LFrh1aUyyL9RcUcOtvE+8EnvvD4lp4/AXQ67kAtf+ZQdRwLVAsDmUYa1xDG9WMG05d7oHjSFL31PGVN3doo0a5zgdI2yCcF5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

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
index bcbbb012aec6..e2f439cb1942 100644
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


