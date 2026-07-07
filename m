Return-Path: <linuxppc-dev+bounces-23695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDE0C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:48:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZd914fLz2xKh;
	Tue, 07 Jul 2026 18:48:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414109;
	cv=pass; b=oqL5vLxwAo6vUdK3QQS7kDh5S9WzCZiHzFNBE29u9NCyoch7RPJBqgnRhUES9Po4m2geXn7IOfC+3MU+5kDsacbKrz58JzvmReSV+4w/tXHHRAsvXEypFvyhuN0aLhidfa1RRjo0SsEsJZr1QpmdrYvwrWHiBAlXgeyHYsBPGFinkeRhyIEuhHv+D5k4DI735vVEoQjG8Szv08ECl23UMXDOixsDR4UqgPmfeX6kVOH9rJoyuac36/qVti8O4ZS231QWsgxnNveCVk6/2r92kiJVUHFn8V4OeauJ+jlgOzrcGNn8Rm2WmrWfmMp6/5QIoKEQsiZH0M3lrl6AWQCjhg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414109; c=relaxed/relaxed;
	bh=bzDGl0iXRrzyQEm7jepHNmDavS0h9ogVTM3kF5sZHgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXTyENCTHeLLy/Yz+CD1tVssz/AJ4isRzvQ9jQPqFtheZbbSZLUGgUEwWrCc4qYs43/DrLbwYYasaiQ8J1gkoik83dYv4PbdgEXmJmzTR74iWZeS7jx15OLm+o3B6Hs5Jsf33b9ybrbEOJcqu1C4phzAckJDVJ2pxZPmCTxDRaH/EDa73/g+/5sCVg3scCa2YyNvGBWpd+t3CLvc1HdPM5ls2mmy1KnZ1aJP/BveaMcMygmesFpfRxWJFb2E9kBwDw7qbzn4pgzL/t6Z5zS+MHN4eJe8AiWdoAC0ZYw5H5Jq5x8WSFQUeydOClRqJJ5FQmOFah9BIv8O6+oh4EMawQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QN8lxaJY; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QN8lxaJY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZd76S1Rz3cMB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:48:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5mCHoLg6/9puHXknoqZ7G8ny0Wi/kcIbsU/RWvKWUhvgZ3w5ZOfB3n7fc8KIRPT2re8uyD928oAyziL7zarZ2bh4hRUC0tglOS8IKpHkVWMf/dNyka0GpWv63xS0WHw42WlSukPpUMgl2/9UfMgrASifGt9IlM7LmuH9ibv05QKC5w3/SooKvlBAI94otoMtVbdRmJ0S1WkaDSSYgLObPwAMPDnERhvpZASI1JA5X7mOTvjQEsEMAzshrAYG06598Jq9B0XHZaJqnkby1TzpIGqToy7SDawI3CXHgehcoCazC/dCMjCSnbMB1sK+C8nJYbN//murc5cXoxmpIB5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzDGl0iXRrzyQEm7jepHNmDavS0h9ogVTM3kF5sZHgg=;
 b=J+P72M8OQb0rFQ21VnWGpMuAVlB06QgMa4OaIGHTXFTvuOvlmdXGQJrRwn9Gw1D9o+9mTd6Ak9CR/B9YxNx1WDnp1mB0448s8WcV0pEUOj/1bpKncwAOM50v4GoxOKT56b7HsVpQRzzQrLZrGRHXaN905d5BdGLXr0QhBzuaQKsnMXX944fLnJhiQqFHwbo774ceNG+X5BNhjYd6qJ8hzfi0zP9NG+KCAX0RlFGjDjPtCaSG3nk3d2hcn4+PAIelxLYoi124xNye0CKG7Y44CIAiettTJAB1oVjoD9A4qHwotJnud+gx2s5y3gVFWnh0Gblxj0977O4Q0x0qrf/1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzDGl0iXRrzyQEm7jepHNmDavS0h9ogVTM3kF5sZHgg=;
 b=QN8lxaJYBoioWqAunhYzHCpUy97w8RfFYl3GQxA1Y2aJIRy6k+qbcbtQ7mwOC2Qn6EuW48Es0IO1/EEGo38spM3dV3UslMdOSTYgCh2dE5KKYTsy1fTtL5k7PhAg5eyLC9JqyctuWKu3lIlQadAAl862iY+Ig1Kdpsv32w1VcsIq59f11/iVIB3MEpA3Df1FlwY55iHs+sP2J7Vv05brfuGaRpwE13PnecNQKcKp/Ua29fbw1haIuoRlHhun6T37kp1ywXtcmwUeIrPSPTViNNyaiQXkWen8xbNY4ldMutmlR21xKlviEF2SfCa2WZn25QehJXi5x6SFJbRv0dVuIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:48:05 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:48:05 +0000
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
Subject: [PATCH v4 net-next 12/14] net: enetc: remove redundant num_vsi field from enetc_port_caps
Date: Tue,  7 Jul 2026 16:18:32 +0800
Message-Id: <20260707081834.710730-13-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: d356a82e-e495-4c6f-976b-08dedc0475e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|6133799003|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	8VcoeY8scKUwhoc1mc1OKpidDA4aKf8+f1+lsg2Yz7FN4UueR7mBGLCzJVerbrwK/6P2AyTk0x61p5+aJRjvNpu/aHWTYwaCleZdw/pM8V7a2gQu+IUqXOZP55/DeCPBOnACEZ9boG2w8d2ZVEpI78B0xBkFjEaC9Ckh6Jb++WtzhxHufI/f/xXTLcQgzTmyLDbe1Sz+uEInKzJstCFwgJtepD6JVf7zIELtEk05K5tIHnjdgVDx2u0uUcZh7OWM9YpldBDyX/ZdWrlHVTYYG0PDmLy+/XNpgDhN92Hl4looZXuRp9hFruSsWnJKsFy+N6WkU9Vln27yeX1l72x6vsb9jxBUPo/ZoazYXZvQIriuK5RZ8YG6K3de8wLijPbCcbSPmOGuRCzZ8OAugY3zwALiO5sG6tBtQCsm2adEiwyVRB688vshnBHnbInO1DK2IpNzpw1m6p6t6Eyb1OOSTXVG7tcGF0uUIIAmti1iRln5OJgrDAyqBv5WdFQyElE+m4AXsfuW7/xzcKi+mLHI2A9eVbzQMdwvRsC3Ier3VmqIlizrTqy8/3OyiAShffyFN2hg7Fj4KJmMqZ4qa0IqxA3PgAoFuOZ3Ui4XA37Q8dX/QaKTCTVr7C7sUI8bZtjkmbrfB8fU+a4Yjzq3mLVTDeunwSB4CpTqaeSK8JwQZXeAmBzc9OxZjaxLUO9eq5RXxsFwFrw86Fk2m+LSQrTtaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(6133799003)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqwyBsoLZG6diNmzwq/FZSyuVDpCCLRPagDatj7Pzq84+FyyNXo+epuGJKPG?=
 =?us-ascii?Q?tMA7H+jq7iESTUbUk33ef6a+0FHW4GIWow1+JnRErTTW1mVZ/3/i5UkvHEbr?=
 =?us-ascii?Q?Lt8E84B+8T6jh1ZPceZuDAYfgqNSx661qPZZDJ8vAoku4aRY+LLDEgHGOJ06?=
 =?us-ascii?Q?JYayLUTXk4ULikujxvCl7SbjRyqUee4UAgW/5raOYYfe5UEfRcgtPvL0A520?=
 =?us-ascii?Q?aVbFW03R6hNiA/LfFOHgWSdlFeeeZI5eu0vzVcQ7xSNFr0weFxud/DSYnvp7?=
 =?us-ascii?Q?lsXN4yCYQYTOunyMV6x4z/aLwVi0+b3bd94H39WaYM+CJsStsrYwsgUMZOio?=
 =?us-ascii?Q?/oxwrbV2hCzt7AL/d/9bytduTjQRB+94WahVFVM48g0XJkJ7OjNYg8c0YK1W?=
 =?us-ascii?Q?u08h/sh7QpEhaPV2caEi0ViyAHu4JjyPMs3dnO1z8kwPP9YSPd0MQJmUJdKh?=
 =?us-ascii?Q?6vKCSXOLIQTywnZkXhHoAulxhOGAiHsDGa2+DAiWeRBa07sAq2RWcMGmcak4?=
 =?us-ascii?Q?scX+B8ugxmVEmWjGAY0AoYYZ0Oqq2k91E6ofoaRvAfkOMXpIInftsibo+ySI?=
 =?us-ascii?Q?DpeX68k5U3MjJArZlkk6E1r687scVSqDaNwlBOA5XDlVwRcb5PIwy/g2/880?=
 =?us-ascii?Q?+nCqHScOT2Y4MBq32Xgp17DXExWVRdp9WHca3doywsiJpWH6/acyS2LtKnQn?=
 =?us-ascii?Q?sSM8PdoRDkZ17Iuv+NWcg5K9u6L8ZYJP/CQdPRfmb6+DHCZwBOlqylwr3N1L?=
 =?us-ascii?Q?iQIG6amnUGWZL58rxbLPTZMaEHl7ABTqcHHUUZ4e9E4emR6dKa9bEeRcqIZa?=
 =?us-ascii?Q?MWzsss68aWg0ziy1aQbgocXFUpsWJKfQh+fZgTguHmxZ/rBizo+CKqo9nece?=
 =?us-ascii?Q?pblnOnEzavAF/Kv/Aa746SFmaZC8ocWhdUVVb2dIz4Bzt9eKzMedGwyE71s6?=
 =?us-ascii?Q?WH6V+6/NUgyxHwfKdN2BRxGUyyAPvJxxCnkxtNB+rPHVzRMmP7IBlfLNKFtX?=
 =?us-ascii?Q?QyHJlWct9Npm6fH5a+ZAg8xb2pDVGi70Emntc6iH/uol1eIyLLyUOdAMEx8c?=
 =?us-ascii?Q?kt4wFBJ+HCdBXs7++REBXE5DqBB0wzX/ECbe85X2ElgmSi7ROCn/L2cCnoQ2?=
 =?us-ascii?Q?ReQtTH3vuDFdZyYzDObqxLzoq2RrcQ9mdByCdHlXdCLKT872lAQ5Ka7qXdwp?=
 =?us-ascii?Q?dHvcNDmtM5U1fpcB8eNnCk3hL5+xsKBcAUJW+SjsKCco7ECKL4AkxonsN5/y?=
 =?us-ascii?Q?VVXC2n2Maj1sl9zvn1M4HhUhKDYct59Gy6WdTXMHBiuN+ceYxL0yMRccsrdl?=
 =?us-ascii?Q?MHGTGqJQGax7cd6nk8UVFTUW9DKJJ2EKALBt0vLUSPXqEUW97cMV5dGKqg3F?=
 =?us-ascii?Q?5fesUVqNucvq1QYcLvtged6Ny8d2nKjl/nyVLLCFoot7rPniIGfek9QONcDd?=
 =?us-ascii?Q?BzZivog7DiGiN3g78t/zD1XwaKIKYyQHdMjxlv9UwbCrJ/pOrmBFIbROQWhM?=
 =?us-ascii?Q?uAFWVG4zOm98aSCiU476xDeSy8j0ES1b1MvXkYwE7t8oeKBkD3rKi3HFWvhR?=
 =?us-ascii?Q?ohBq9CQePFdzQ4YeLmo4Hde/u/Bes4xh8voJYTeH9CPe8QdDlJ6uhk+KCL+Q?=
 =?us-ascii?Q?z4mw3JtLD79Vl0ndQr8uXC5wAIZ4ZZu2tVeF+WJF4zcQQRbytUA6GwywuUtX?=
 =?us-ascii?Q?x+YHa47SJ0eH5CuIalbDay9pVT4MYB3O8cn6VgPxuaNbqwajNbmTtWsQt/Vl?=
 =?us-ascii?Q?BXSo89WV0V9cflRHQbWH5BA5opQBMZbO1B1fLtbJLPK/JHykkr/o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d356a82e-e495-4c6f-976b-08dedc0475e2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:48:05.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4nx6H37HDTDH3BmeFcAc0EPhzBpervuVi+LngQc7mDGZsnNMmTNvpvZv9MSEImiGGDH3C34TZNh6XFhJ05SMvHcIhm7NeIpKUB3WDmzSVTRBUvcbQ+iH5ZmetKdbGUT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

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
allocation, MSI-X configuration, SI enable, and debugfs code paths.

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


