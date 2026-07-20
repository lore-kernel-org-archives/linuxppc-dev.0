Return-Path: <linuxppc-dev+bounces-24437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3BFC44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:13:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PFJ1r77z3c3v;
	Mon, 20 Jul 2026 12:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513604;
	cv=pass; b=G6isEtOkPWgqHFDkIZsRWfpPGPH2VbgEvA2CQiTLTXMlFlUhLBzUy8Xi4JAIIuU/3F5ZnsrI+HkgeLuVc7b0MlCpVi4zPDNqoUOyxW6I8KsLamXIjlV9U7Pqev0xgQHbxQw2vDYjWJ8cQsOZtTd7LsrZIOLB6cwqvsO4gManW3ULS+QAsECqt73Q7Vyc8vqfy5nI6agorzqoGyui3gx+7oLsLoYuSRCBfSPbHfYTMuB1AezTV20If9t40uveB/mrzcpD+k2rxEJ2qStPk99oH1/XLetdqEajVyFe6DlDM+uSb0lusdnffpOEbXjzW9QabMfE6wfNDE2Q305/wqNLBw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513604; c=relaxed/relaxed;
	bh=pF5hMKljNmkY8y+rhn1I5MWuSmrhyLoIDYIkvJGo7LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfzRBGCXcEJxptGSk7NO6Hdyiu50080pLyVks+c3BmJY0rjx+gJXd2wL5F0srRcJBnqnA6EYBJv1DDfXiH5NkkIqWnsMj/sKZfYjXgPbl/L/ODP6hlcyAwAJmGyAkYNkV67xP2oXogPGU5q9n/xacs6kSiHYJnWA9XDLyqE1YfzcgZouR/KvXVc+Cq8KzzZC7s1JVazWa9zI+Qt6gwpY+yt2NhoAWHAp/YllwbjrHP0qZNfDHnTI9HNZxKNapVtvyUph3a5rGACsWM+n+FMz9CONi78hUys6ubNOrOwnWPa5V21dpLqzJ5o79+pLq8aEEsookDuNnvcjTDy+a2xAUw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Gj4V4tGZ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Gj4V4tGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PFG74ssz3c4t
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:13:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujrdtZ868ELkfzHWqxQTTSw1C2jUNlgaydOFTTBDrZ+LA6sUY7VCCrwTDNrhgUuy1bUnsLL5z5sLsIcuT6hotKy71ZAYONz4lwveMcOuttQUfwsv+MEaOWDd/GncORxv2nFfqgO4ssxGaNQGreZcmj8igPESac1K/bLFWgyMvEtW0SLy0P9H0nW/Nw05Bg8qXMrspbCZHLwOQ7bWZlyhudWH1bydYp3a+BCVNxekBu4lVlq98g36A9g3Rp//rzbKqLHjbvGJFB7wsXCScYm2SalHo2h120UxJ/lmQICgwRkE/lAVM+12R5Lv5G1oBhKR7W/cy6XZP0xwjQfnzyjw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF5hMKljNmkY8y+rhn1I5MWuSmrhyLoIDYIkvJGo7LE=;
 b=KmzshSZNg2pt13/uq32vkSuBDn1Fu9IUtDZp0PyGOY3kOQU6fOfxYtq+nfseHnhGtgUrrI5cqW0Y8d9Oc4nWoFguAVfU2Qze4r0O7tCu0/SZuW0p+b+f9r79WA8Cqh15Z76aCJtJYlu0JOnWePhLCNmqw+b/qkZSMCshTehVuFuXMJMX1L9DaS1kF7MokBc8CumRFeD41LwBXl9T9fMi2aNwF69MfttPtaPHSMPo4ZNNiYXecw3UBIUYipb4j3TLuYUvHgYn54DRP4ursrTsdf5Qi62KuCVDTx0kTznt2Na/Zc36xAE3V8JWRpqLA3Rbyki09L9Fb4bgTnEc64841w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF5hMKljNmkY8y+rhn1I5MWuSmrhyLoIDYIkvJGo7LE=;
 b=Gj4V4tGZPwzI67bt+QcXWqeIkv7Et+0r8+OV0s+aBzuqhZIQLQooe8Afzk5at6akwvmsZ44NaLWq9BN6rdXl00W6IRQ39pHHegSdPKU1ubRfHJK6RBhzAefg8FGh71LOwn8J2aJvUftzMzhzxCWYzjo4iSuA5dwYf0G2LdpgOda0vPMeOM/a7tgv8MZo0wuth61gAHG1y0Q1fC5rdt14zIoFD0jjvasFYUMQqfBTnn1GCp2R7TIuFjSfznW6JLXGQTg6HpSFlj1lAnTV3x9lA5uKLx5enqGMhv5Iyg5yMNRNxnEljfY6LpPsmr5PTlg2Ersd3swT+n397f+sp63D/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:13:10 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:13:10 +0000
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
Subject: [PATCH RESEND v4 net-next 12/14] net: enetc: remove redundant num_vsi field from enetc_port_caps
Date: Mon, 20 Jul 2026 09:43:14 +0800
Message-Id: <20260720014317.1059359-13-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e506bf-e394-4422-4142-08dee6047258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	jgVLF4Q1wPVo4QewIMgyZn4F7WiXCKY5By76I2zysBJYc/Ku0q7VgRuqSasTK6cHj40Uklr8w3rQfvZP7/I0GKP8iYKH5XMI2WzKdYmF+4I6Lx9n3QbEWHNbvxiNynX7TIPi9kvq4M3mWtnzNqNdPD5fqG6BAcKewA8Nfxx+fvV3Q2997OR9OBg0sUBUaprSWc+wf7Y1cIq6VEnuwIWp8qDuaSeUq8G0QIAVNwKaIVwZ+uKft6Z7AFYj5pSvq6aZM8KPKR9nQLYUOAEMLjW5RPmL9sE0ZqJ9eOAzWmHKqwCMLImmfx8Q6ii/a1rkdBfCwYMOdfFMd/OeF7Sz7beIOIBrF5P52wDEQemx9vpXLB5r9YtT2JPpJUplOM9v8ljIjPRQl0m/Depuc0TWkz3D9HT44LzZC2uHy84EaJHmsCPHfY6S9pkxUKQGwwBTcJw9ORIcGzmQQnehL6Es8OlstSCXynwsAdEektLwvqhpFi9JtqB5wb3W2hisPaDhfNoLXH4biuaL19bTMaCWUQQyG2IyBaKdT7aGi+mt/idVLXOBWo53uMntkMtIo5lT6c/wa94WgRtGM3iRL18HeZNoAfglRHGoJv+frjQcb7/EX6WPKOWRPZRejld/orBDSTwiDdVymgvl50XG1Mcr6+4ZLw2GGZNwXo9gVdrQPGpdr4OR8dPyPpFUcRJkyX5clGSlllN7nFGZxPpyYLY73vhpCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R8J7iDx1NbjFx8d/svlZulhTQCLeV1TMNa4vN6lOdF8OaoW1BMfMDgoQ1xe/?=
 =?us-ascii?Q?5LEV/aLiIqf/R+0jOchtl+aJmbJogJwUaFa1UhaGI0Cm8e/8syZZYjbjDT69?=
 =?us-ascii?Q?FqHzL2krvTxHGdDEn13bQsDPBtPO3SuvQYMIHadBx2Wt2whQK3h/jM6OuC4V?=
 =?us-ascii?Q?NxkZd9e7cEuK64a8VAkp0rdmypr9yX5QnsUwevyn8TDMcn7zuF3Rv8MzKInT?=
 =?us-ascii?Q?WJ30h3uKn7NjCQtqdlRdJtQoqL7py/b6EFD8hP8NKB9peAvIptKq2zpIT8nu?=
 =?us-ascii?Q?v99tIrkSaq2rtMYbgGHy23LzwFKVZCqfcZrt0twzZlZVznG+D6t1cp2F3IRp?=
 =?us-ascii?Q?xE+IaGYKqRwL+AaCHF1dn5mvGEH8YT4rRROH3YmXk0QXQxOa5AyfQT4wj+Gu?=
 =?us-ascii?Q?G2zAB8nCi5rE25BURTDw2DkENnm49YPokLCH8vGBm7z/CIJWGbuiE2yFj44Y?=
 =?us-ascii?Q?tSvpCuXwcxCCh4BEgZGNNNkSNRTCUmtvVQTrYW+RbXHmQCNnf52DcuttMJNS?=
 =?us-ascii?Q?AtsEYChwHE61Ggvs+1HzvlQ++4erYu+3+PUcHQwn0hOkyd5flT58Qw7msm/u?=
 =?us-ascii?Q?MWLyPlk04OgrdM1ruusZC+8w19hZRpXRI3yVAIuzyZUnBM6y3ruFzsjgwwHO?=
 =?us-ascii?Q?k/Ku/N7qBMlzwYPVGF+ThO6g/PK/cTiH0MWdhZUXQy82syVCVxakEGsGRbOC?=
 =?us-ascii?Q?AMfP4qVBjQlP+LqWEYbaJJDyRmtTUOLKUvqVWSOs9018l+twD7l826BV62+F?=
 =?us-ascii?Q?du67//uGULvos06nS4CX5xUWrHmjZmm+b/XA+3tnb67hB6ik6FzFzkbCse27?=
 =?us-ascii?Q?0AIS0u9URRC2RCv3Sju10laCPrrbfB5EmVz3B6oFFcsStVKEZYFb+y1zkZqp?=
 =?us-ascii?Q?5KrgZLMy9G4PJBlVnIjgbgHv0JSAtSY2isgpKJqq80pMb3m4CKfCoCuUnUqP?=
 =?us-ascii?Q?i23R1o8I1H9yJRUlCM8JrodB+pEtPcuSyiVV2iwJbU1h0XiuKw8tw+s9qQHc?=
 =?us-ascii?Q?80eM32qWdhuIjs4BV5KYTdiBaFc9MzODuR4BkiW4w5hRtAWawtW9tmvfoBTJ?=
 =?us-ascii?Q?Jcn5KM2HdVUEcsZfc27NdfyloG4FnkSWp08dm7tJM3slqdo0AsXbkhpyeLEn?=
 =?us-ascii?Q?Ozn+7zUtCvI1sCflxpQhz25v7UdjMchKeTCiFmg9TX5kR0LIbQtdU5Nbbosd?=
 =?us-ascii?Q?bGwHyDMInMrl7cXQQHbJW/ekcfoeDocGGn02OS3yrRyf2+1yWzF01pEiJDXo?=
 =?us-ascii?Q?EdUp8adS1UOlonMlnYU23TGSybdYcF0r5UboSjNjg3jmDrNrelUsh5lNp8iY?=
 =?us-ascii?Q?5AVv7q4/uP9DCZfM1FS59JO1rN22IIzIsq8zOyD/R8nhEjntgLGuJxqJ4Zp9?=
 =?us-ascii?Q?O+gJazWm4nfnYoto6nMDKa0S9lIJBeD/M6OcmB8mzAq6Pe4h6p1WH1zjf0uI?=
 =?us-ascii?Q?WNhohN1WzlACAmiv3p4tzDPeGsHUgHov8AWGm4d7XibDD7+h3TPjnHlyMYSR?=
 =?us-ascii?Q?tKSwfY/tx0xpHZnMIoHgnjdJyxcZFf2KNMzmHl1DXX2yGj0RvX0ZRYqAxIy3?=
 =?us-ascii?Q?nJjM9bNhI9SKRwhDINCrVRJFs+YG1kb2uq9NEslIoO+pf42NzZu8zdRhFufC?=
 =?us-ascii?Q?T56IOKl3y/B/lKOZ8v6Krwr6D8eBuR5x2mqYKwfdwptWVJ4mXFs4yhdTooDI?=
 =?us-ascii?Q?sP7n6fiyHbuLsz0jc982sB31kdl6OgE4TWMnztjzlKb4c4BqWXNlLz32A14j?=
 =?us-ascii?Q?ApstQ1mzfYIFkyTFFj10SPx8fH1dmOl1cjDMdqHabQQia8L321Xq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e506bf-e394-4422-4142-08dee6047258
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:13:10.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0abZu9pd1ddw9a/PxPFwFKDsgG6fp8YNkayYy8gieCDv4G6kJkH9jkaU8J2nk+93uZsjoQa6oM5Qto1yLNsablhhKyQf78NsmjfPywiiy6rG2QIIdJlJHaFCngk3kZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

The num_vsi field in struct enetc_port_caps is populated by reading the
NUM_VSI field of the ECAPR1 register, which reports the number of VSIs
supported by the ENETC4 port. When CONFIG_PCI_IOV is enabled, this value
always matches pf->total_vfs, which is obtained from the read-only
PCI_SRIOV_TOTAL_VF register via pci_sriov_get_totalvfs() during probe.
Both ECAPR1[NUM_VSI] and PCI_SRIOV_TOTAL_VF are derived from the same
IERB register EaVFRIDAR[NUM_VF] (a 4-bit field), so they are guaranteed
to be equal. When CONFIG_PCI_IOV is disabled, pci_sriov_get_totalvfs()
returns 0, but this is benign since pci_enable_sriov() is also stubbed
to return -ENODEV, so no VF can be created, and enetc4_enable_all_si()
only enables the PF SI (PSI).

Since pf->total_vfs already reflects the number of VFs that can actually
be used, and is the established convention in the sibling FSL_ENETC PF
driver, there is no need to read and cache num_vsi separately in the port
capabilities structure. Remove the num_vsi field from enetc_port_caps,
and replace all uses of pf->caps.num_vsi with pf->total_vfs in the ring
allocation, SI enable, and debugfs code paths. Note that in the MSI-X
configuration, it is still necessary to obtain the actual number of VSIs
from ECAPR1.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 13 ++-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 86 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 68 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index be378bf8f74d..5029038bf99f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -28,17 +28,14 @@ static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
 
 static int enetc_mac_filter_show(struct seq_file *s, void *data)
 {
-	struct enetc_si *si = s->private;
-	struct enetc_hw *hw = &si->hw;
+	struct enetc_pf *pf = enetc_si_priv(s->private);
+	struct enetc_hw *hw = &pf->si->hw;
+	int num_si = pf->total_vfs + 1;
 	struct maft_entry_data maft;
 	struct ntmp_user *user;
-	struct enetc_pf *pf;
 	u32 val, entry_id;
-	int i, num_si;
 	int err = 0;
-
-	pf = enetc_si_priv(si);
-	num_si = pf->caps.num_vsi + 1;
+	int i;
 
 	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
 	for (i = 0; i < num_si; i++) {
@@ -52,7 +49,7 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
-	user = &si->ntmp_user;
+	user = &pf->si->ntmp_user;
 	rtnl_lock();
 
 	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index cab79f81d6fe..fcfbabb29d22 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -23,7 +23,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	u32 val;
 
 	val = enetc_port_rd(hw, ENETC4_ECAPR1);
-	pf->caps.num_vsi = (val & ECAPR1_NUM_VSI) >> 24;
 	pf->caps.num_msix = ((val & ECAPR1_NUM_MSIX) >> 12) + 1;
 
 	val = enetc_port_rd(hw, ENETC4_ECAPR2);
@@ -255,34 +254,35 @@ static void enetc4_default_rings_allocation(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
 	u32 num_rx_bdr, num_tx_bdr, val;
+	int num_vfs = pf->total_vfs;
 	u32 vf_tx_bdr, vf_rx_bdr;
 	int i, rx_rem, tx_rem;
 
-	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
-		num_rx_bdr = pf->caps.num_rx_bdr - pf->caps.num_vsi;
+	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + num_vfs)
+		num_rx_bdr = pf->caps.num_rx_bdr - num_vfs;
 	else
 		num_rx_bdr = ENETC_SI_MAX_RING_NUM;
 
-	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
-		num_tx_bdr = pf->caps.num_tx_bdr - pf->caps.num_vsi;
+	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + num_vfs)
+		num_tx_bdr = pf->caps.num_tx_bdr - num_vfs;
 	else
 		num_tx_bdr = ENETC_SI_MAX_RING_NUM;
 
 	val = enetc4_psicfgr0_val_construct(false, num_tx_bdr, num_rx_bdr);
 	enetc_port_wr(hw, ENETC4_PSICFGR0(0), val);
 
-	if (!pf->caps.num_vsi)
+	if (!num_vfs)
 		return;
 
 	num_rx_bdr = pf->caps.num_rx_bdr - num_rx_bdr;
-	rx_rem = num_rx_bdr % pf->caps.num_vsi;
-	num_rx_bdr = num_rx_bdr / pf->caps.num_vsi;
+	rx_rem = num_rx_bdr % num_vfs;
+	num_rx_bdr = num_rx_bdr / num_vfs;
 
 	num_tx_bdr = pf->caps.num_tx_bdr - num_tx_bdr;
-	tx_rem = num_tx_bdr % pf->caps.num_vsi;
-	num_tx_bdr = num_tx_bdr / pf->caps.num_vsi;
+	tx_rem = num_tx_bdr % num_vfs;
+	num_tx_bdr = num_tx_bdr / num_vfs;
 
-	for (i = 0; i < pf->caps.num_vsi; i++) {
+	for (i = 0; i < num_vfs; i++) {
 		vf_tx_bdr = (i < tx_rem) ? num_tx_bdr + 1 : num_tx_bdr;
 		vf_rx_bdr = (i < rx_rem) ? num_rx_bdr + 1 : num_rx_bdr;
 		val = enetc4_psicfgr0_val_construct(true, vf_tx_bdr, vf_rx_bdr);
@@ -298,27 +298,67 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
+	int valid_num_si = pf->total_vfs + 1;
 	struct enetc_hw *hw = &pf->si->hw;
-	int i, num_msix, total_si;
+	int i, num_msix, num_vsi;
 	u32 val;
 
-	total_si = pf->caps.num_vsi + 1;
+	val = enetc_port_rd(hw, ENETC4_ECAPR1);
+	num_vsi = FIELD_GET(ECAPR1_NUM_VSI, val);
+
+	/* The PSIaCFGR2[NUM_MSIX] indicates the number of MSI-X allocated to
+	 * the SI is NUM_MSIX + 1, so the minimum number of MSI-X allocated to
+	 * each SI is 1. The total number of MSI-X allocated to PSI and VSIs
+	 * cannot exceed the total number of MSI-X owned by this ENETC, which
+	 * is ECAPR1[NUM_MSIX]. Otherwise, when multiple ENETC instances exist,
+	 * it will affect other ENETCs whose MSI-X interrupts cannot be
+	 * generated. This is similar to out-of-bounds array access: the array
+	 * itself is not affected, but adjacent arrays will be corrupted.
+	 *
+	 * pf->total_vfs is 0 if CONFIG_PCI_IOV is disabled. If the hardware
+	 * itself supports SR-IOV, then when allocating the number of MSIXs to
+	 * the SI, it must be taken into account that the VSI has at least 1
+	 * MSIX, and the total number of MSIXs of all SIs cannot exceed
+	 * ECAPR1[NUM_MSIX].
+	 */
+	if (!pf->total_vfs && num_vsi) {
+		/* Because each SI has at least one MSIX, and from the hardware
+		 * perspective, pf->caps.num_msix will always be greater than
+		 * num_vsi. So num_msix is always greater than or equal to 0.
+		 */
+		num_msix = pf->caps.num_msix - num_vsi - 1;
+		if (num_msix > PSICFGR2_NUM_MSIX)
+			num_msix = PSICFGR2_NUM_MSIX;
+		enetc_port_wr(hw, ENETC4_PSICFGR2(0), num_msix);
 
-	num_msix = pf->caps.num_msix / total_si +
-		   pf->caps.num_msix % total_si - 1;
-	val = num_msix & PSICFGR2_NUM_MSIX;
-	enetc_port_wr(hw, ENETC4_PSICFGR2(0), val);
+		for (i = 0; i < num_vsi; i++)
+			enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), 0);
 
-	num_msix = pf->caps.num_msix / total_si - 1;
-	val = num_msix & PSICFGR2_NUM_MSIX;
-	for (i = 0; i < pf->caps.num_vsi; i++)
-		enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), val);
+		return;
+	}
+
+	/* Likewise, from the hardware perspective pf->caps.num_msix is always
+	 * greater than valid_num_si. So num_msix is always greater than or
+	 * equal to 0.
+	 */
+	num_msix = pf->caps.num_msix / valid_num_si +
+		   pf->caps.num_msix % valid_num_si - 1;
+	if (num_msix > PSICFGR2_NUM_MSIX)
+		num_msix = PSICFGR2_NUM_MSIX;
+	enetc_port_wr(hw, ENETC4_PSICFGR2(0), num_msix);
+
+	num_msix = pf->caps.num_msix / valid_num_si - 1;
+	if (num_msix > PSICFGR2_NUM_MSIX)
+		num_msix = PSICFGR2_NUM_MSIX;
+
+	for (i = 0; i < pf->total_vfs; i++)
+		enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), num_msix);
 }
 
 static void enetc4_enable_all_si(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
+	int num_si = pf->total_vfs + 1;
 	u32 si_bitmap = 0;
 	int i;
 
@@ -339,7 +379,7 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
 
 	/* Enforce VLAN promiscuous mode for all SIs */
-	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
+	for (int i = 0; i < pf->total_vfs + 1; i++)
 		enetc_set_si_vlan_promisc(pf->si, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 1bd3063a3be3..56d23a8a11a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -17,7 +17,6 @@ struct enetc_vf_state {
 };
 
 struct enetc_port_caps {
-	int num_vsi;
 	int num_msix;
 	int num_rx_bdr;
 	int num_tx_bdr;
-- 
2.34.1


