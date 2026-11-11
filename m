Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2CC606A330
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OsDCEfDS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPYPh2jqgz2yQJ;
	Wed, 11 Nov 2026 17:23:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794378232;
	cv=pass; b=ZTBgPeK072JCeaFDssB3F2XE8m53JiRbsHcBN//5KQLwB3wp56DgAOTO8l9sbAw8LZHR2UBzd3wVk01zh4e8/xEwiY3NLi9u4ffyz+59xK1ce0gbuO+PCu32KMGDwu31OC5BuWQOmenYuEwoUmwRfftPa77EXQYLbHvgxju9xNQVu0j4wYR5AZYxsJrkBXvbY9P5Va06WyQYAGeMwuzqpMmPb6HU93ZBCaVwLhZAjW+OSaNayuU5OU3hIfSQhJTHnK2a8r/8u/CeE3AfzJPdp7gfgAJW8/yWdS2isWq5kmuIYlu2lYR4myJTsDgVxeIsNhXdZY65oOPTdIaZN/Suog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794378232; c=relaxed/relaxed;
	bh=wJ/rZYGY8aeU5dI+3g2hetTV6DOVXG2uOsXl2veizXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+R6m5gHKW+6F0dVQdbSv2hfEw62xXGOQBXoAdCU+7ospabqOp/s7CyQaOoZYC6rugzE0DpwXSIvZreMhIwWn+0PexQIXyw8PvNXSxEPysA0CHvrfCjylvrGGnQL0+XG00bDUm9qINMOn1jyaMw0vP1kq8Md1MWYS9M3COqHY2pP0RHUo+vyB3jy6E/K/a7F/Ln5M0Uc4hEJnmmWAzeSX+hJnmTkCVq8nMNcSKqS4LV8L3Uww7rALF3dMXAh5SjQpXBNZUIz0adZ+AHGzdT09tRrYNHkYJl7K85WJ+uUR94Qd+41MRGpsLQc5H67vRi+F1lxS80H1tIfoFd1d/GpLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OsDCEfDS; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OsDCEfDS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPYPg3bCsz3bYf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:23:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee7nidVwGzm0AegkegTiprqiCDCo/Pb+Cslsl6S92RuWBpoTGYGjYU5T9kesq8xp2I3MWquBw9or09VKeJSiX0GNtuW4g3rP0DqQGK2oRqK3ZMdl90hUWLByo2Wd+3yquS2l1Vomf5uq0vu/+ra50oK+vujothcpeI5/3t9BLyoAYnAncRUCAvWYihx29V5KzfmvfcLADt4m9y2WXm4SoOA2jEOSc3j8Y/rMxyoaOD+ZGSA684IDYp+cWvt9tDpzcbJBtdUyZbkB+tATnk776y5ukkYDWXjnjIIX7WxDwKU21czu3ff6cwlFFsVsaeOwmNICE7XTY9Dp2nckVwA3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ/rZYGY8aeU5dI+3g2hetTV6DOVXG2uOsXl2veizXw=;
 b=jGEvtQ47D4FaMLw2jecRHLqwh9s/ODhfZykIIrdtCOcrABywgDz5wvqZ5Se9CeB/DDaV7ejzK4Zu4pjk/HyLipM+GHBhnZZ69a6yCvGuf8sv6Mg7mdVJ7rLFYSptHG7H2v03nzd8D2MmWCoEdcQOjU9KwKN6gmsi0TgVI0AuVYYIjp7a6I18FQwDGlb6DchGCOfQvG12cCsk/f3LbqE8OFnJlXhS5kou/5GhYCGOohSssHJlpF3ECJXOYpQu9zu/eM4MGUxtiz2meXGuY8wg6JZxWN90LBtwSs6QsCE+eBRrY0SnGWn2vDpL1YEPq3nNA8Hk2jDlcYoVkDwfKHkCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ/rZYGY8aeU5dI+3g2hetTV6DOVXG2uOsXl2veizXw=;
 b=OsDCEfDSRVGKDBrKHY9VtsB7iA0ODleAFje12UdPISBqWYhu60bsZiD08X0TS3sTLZTi7GXMeclFMdOeV2wreiIXZXtXUyXsLKEi85lYQC/BTAZUWYmSUmmwcrVpjqf5CTJLjaK/q6SJEWLBij9kvWz+rn7iS5LNxUyxVTMA6dIjULs2Qjqph0hQ6SEV73vNzMcTsY1/n8dFhcOf2/TyQubeyB//iw1jvK9J0gJkcGbtzEI9wYf1/OXQqc1KLWaFGp6ShuoLf9Un0Xe4SSGaZrs5RBq0cEDOCMaKVm3UaIyDmqWE2eapZL5wjrF4+on299yQaLHjYnETIQswGfEQRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:37 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:37 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 net-next 6/9] net: dsa: netc: check return value of ntmp_ipft_delete_entry()
Date: Wed, 11 Nov 2026 14:27:50 +0800
Message-Id: <20261111062753.1397582-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d436a29-d2e5-40c0-d90b-08df3fbc51e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261026121527099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|56012099006|10067099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	9ocyP2upJpmr6eWQ7KpQgH2c8VVImuXrNU+/cXdPFWE8boJQvHHDGjOzuWOy3pN8wMcXgMCxHLxvHd14xf9rBUz6qkjsWa7lYeepELCuX4k0pQgZhsU59Lzxpv449t8eYPC0OegFb0oHvkXainDD897NUoG1ZJDs2zYSiTP4ovO1yF2F0zY5MztYHrtrVb0Ls+plJPieVG8T6IuepaT44fivZ7cwYjWbAmugHyoaW3FmYlhrO18IxIX9ODxEp8L1PWT7G+L3U+jfQJcZ0re7NLW9IyHUDz8u6qXqnPgfO1rcfbFqqyo7lcJFYfDXo5J2Swm1hTOfM9DgB1HU15TqnQRdLnyIv53QfH6TNy/N+HHBKzZOwPLOKbx18uuoqrjN+dfmnXUPSQxxj9tpeH+0QB9wa1DRlAi5u4jq32fq5AEN17kUZZe+hIN6Vx5tVFZgF1IAtm/yYSux5rOQPR7VCAQqyDol543LSdmEAoX13iruvd4sGOqkCBsidZPztzM6as8OzrwpcsJRHLIfnC6d6I/gvIDs62zdzJkimlB0of4sThn96byiFFAnMj9yxQPcpNxhYo+QSAptXw6IczJWXYhCQdBcajL23PzGL80jvmvjYryiLRH2IoRd//5INdZRFHIEv6vXkPRmH95XzUwcMKJrDmBIcxcuuKZGfroGqpMmlMCZ5Uz8xNbc6pK/e1cFfg3VQkbhEHdBJ9bcUztXGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261026121527099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GHt9W/bHLjuDr5sKSg+G73wFiDMXYfkYaNpmy0SKBhbT/Xt9E1oiIzuyx0M2?=
 =?us-ascii?Q?JcsxXxLoj94fD65ZiK1cQENNvUY2C0MS4vyox5fPLQGAuAJqGvcn/SKBV7O2?=
 =?us-ascii?Q?xuutlrC3mroO0Uxgbsx2hk3CJhd1sPMy/yNpd3zKivWsyaQ3ddi5FM3rOUrd?=
 =?us-ascii?Q?igd++UVukVEKBVH9QyF52fi9WaUBaYVpQ5tucu19vd9GhRYZ9KbUB4fjPFay?=
 =?us-ascii?Q?K8KBr+U8jKgFCqdegFw/j2gDC8uQnU/yf5us7fDzGLPcLunZ3XlWBMbFMvWG?=
 =?us-ascii?Q?hM+B+PYzgW9psH3huyXIE5PTFElXHN9TXxB5h4Xm1KkjXi6W24O/E42zgi6x?=
 =?us-ascii?Q?CcvU0PbwzuftnbUKW2p2mVADXShZvoZBAqaYMgbcgQilCLS7go7pAVg0PPJT?=
 =?us-ascii?Q?hOMCnkMIO9MgdkiV3/3o38RnfeUq08gvIKuHNsm8rwpI6lJDGdf+HmfR4570?=
 =?us-ascii?Q?XIPPWLw+73HDIb4AQwRVaB6yQ0Sw0HnS+2X1yOR+A1a4kXi3vZeW464H6Ar5?=
 =?us-ascii?Q?K2jvwfCanQwGx1Jj4oRTKtwibNCIg+AW7Zh8ZQ8c4GuzTM2pkffb0O2o02wO?=
 =?us-ascii?Q?fnGUmsMEkGugL/BH9EMbwR0ZlddKIfC7Vyq0b4zcoRzFh0YkekeCvzSLXCE0?=
 =?us-ascii?Q?32YCCiRWj7ynGekFjmMJDGA02I3hdpmMxOMJSnvc6PUzv782/vlkzLgjRTSp?=
 =?us-ascii?Q?afMZM82vpQi64TWU8+/IET1v78kuo/95x/zi5WA1jCgm6jCHxvj5E/TjtPTi?=
 =?us-ascii?Q?CGZ+b5Oqc8a1pGZJHpgX01bOTwznM0ZQNr1kELjKmKri2GlnDYhmiyRI00Y5?=
 =?us-ascii?Q?3I6YGaF/o1auRZtZzR09WcUMgIrtCvy4PQs7YFkUbPYqARcUni9T2cmZwanJ?=
 =?us-ascii?Q?7W1fYcInpGJzKxPtdaPef8m2pNP6vAAOyTZlU+NPBx2r3+HbxGo4gvRrZLlN?=
 =?us-ascii?Q?7f6ixn+Wqp9AwGrukkppU73FirT5FOh7WTcs51H5gX72UpUn1RMdgHgvcVQU?=
 =?us-ascii?Q?2xJVfKY1f9DPTz2pq2IUJCvVstRmiMg4QTYj8HHtdbp0Em+bpcqxdBBcHoVQ?=
 =?us-ascii?Q?GU7KJYBpfbH1fDF2J+wDNff+K58ASQ10qojmc9W9Xfyftwq1TJsVTdp4r0ob?=
 =?us-ascii?Q?WP4UojD/6jw25yFPLgEtZQWvqvKD5U/zl37HuAPPjI5/dLijMUQih5tEfwjR?=
 =?us-ascii?Q?ybw1PVUt6vGU8SbLd/S3Oo31umOLMIDRGiAwHYN+4p5r2doxh59s+15LZgRM?=
 =?us-ascii?Q?L+Xi2KxgCFLRGgZgh2m4C2ZDba72NbivmaZyRL7EgF52hKALaeg+z59h1+nf?=
 =?us-ascii?Q?kGdz7Ee5Souu0jW43U1HYVXoeLLZBOrQgI4E3Vpv7RpKvjIa9QipAEaDu2VZ?=
 =?us-ascii?Q?OVgZwvsFqBu3Fuk3vmjTy3qdRo0tzNnYCiCPtnnnSvD4vBgYSmwlAXzBkzi2?=
 =?us-ascii?Q?NMCxWiBEnY1F/mgjbMswl8q+/2pIZXeHbecF00KgZCSmzIbXOFYg9HYBW1yW?=
 =?us-ascii?Q?DqVejSUMfku/YeL4npvrBy3WSmu1WivzlApKj2dtyC3BGFIqwQ5jYglM9I/U?=
 =?us-ascii?Q?G+KHuHIX63KhB6B5LhvKREXWjrEGhXFi0vgyJ+p1gpgNwvV2rob/YUvaewVI?=
 =?us-ascii?Q?TN+z/1DDncd/B3K7Kr15S/kMgo0Ayi1odOOAqZLsZtN5eiaUfChmD5Nc755U?=
 =?us-ascii?Q?Ezp1kjW5DWldC80vh8kkimpqIh4UDh5QpvvVQpXj8qKqpVhIDu2BfmjJGbx1?=
 =?us-ascii?Q?HSV8yq4ymlEFAEuIdByvZn38Fq2KLKuqfH+L9/UmHxmTGI62iHYT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d436a29-d2e5-40c0-d90b-08df3fbc51e4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:37.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4sZS4ClrPcSHVNozany0Y156oQm3s/lGx94ttdRMvWUDcefY2gFyI+W5C4XLwvlo33fg4ON4hwxCj9nd42W4Hj6g6gexk77rlLV9AijTHihwS4diyZlhUnImpw66fJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The driver ignored the return value of ntmp_ipft_delete_entry(), so a
failed deletion left the IPFT entry untracked and impossible to clean
up later. IPFT is going to serve more features, such as trapping PTP
packets and flow policing, so make the deletion path robust to prepare
for these future uses.

To this end, propagate the error to the callers and update the driver
state only after the entry has really been deleted, so that the
software state always stays consistent with the hardware.

Once the deletion can fail, the order in which a rule is replaced also
needs to change. Since IPFT does not support in-place updates to the
KEYE element, replacing an existing rule requires deleting the old
entry and then adding the new one. Keeping the previous add-then-delete
order means that if the delete fails, a port would have to track two or
more stale host flood rules, which needlessly complicates the driver.
So switch to a delete-then-add order instead. This order is not
perfect: between the delete and the add there is a brief window in
which packets that would have matched the rule find no match and are
dropped. The window is very short and its impact is acceptable, so this
is a deliberate trade-off in favour of simpler software.

Another issue is that if adding a new rule fails, host flooding will be
disabled indefinitely. However, there is no good way to fully resolve
this, because port_set_host_flood() returns void and the upper layer is
not aware of the error. So if this corner case does occur, log an error
to help users find out why host flooding is not working.

Note that, a delete failure has never been observed in practice and
is highly unlikely to happen, so this patch is an improvement over the
previous approach rather than a fix for an issue seen in the field.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 91 +++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d23cfa076e84..6756bf9edfdb 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1822,14 +1822,8 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	u32 cfg;
 	int err;
 
-	if (!uc && !mc) {
-		/* Disable ingress port filter table lookup */
-		netc_port_wr(np, NETC_PIPFCR, 0);
-		np->uc = false;
-		np->mc = false;
-
+	if (!uc && !mc)
 		return 0;
-	}
 
 	host_flood = kzalloc_obj(*host_flood);
 	if (!host_flood)
@@ -1877,32 +1871,37 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
+static int netc_port_remove_host_flood(struct netc_port *np)
 {
 	struct netc_switch *priv = np->switch_priv;
-	bool disable_host_flood = false;
+	u32 entry_id = np->ipft_hf_eid;
+	int err;
 
 	if (entry_id == NTMP_NULL_ENTRY_ID)
-		return;
+		return 0;
 
-	if (np->ipft_hf_eid == entry_id)
-		disable_host_flood = true;
+	/* The command BD ring is always enabled here, with the ring
+	 * enabled, the hardware completes a command well within 1 ms,
+	 * so -ETIMEDOUT cannot happen here. Any error therefore means
+	 * that the entry has not been deleted, so keep tracking it.
+	 */
+	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	if (err)
+		return err;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+	np->uc = false;
+	np->mc = false;
+	netc_port_wr(np, NETC_PIPFCR, 0);
 
-	if (disable_host_flood) {
-		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
-		np->uc = false;
-		np->mc = false;
-		netc_port_wr(np, NETC_PIPFCR, 0);
-	}
+	return 0;
 }
 
 static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	u32 old_entry_id;
+	int retry_num = 0;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1910,7 +1909,12 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->ipft_hf_eid);
+		if (!netc_port_remove_host_flood(np))
+			return;
+
+		dev_err(ds->dev,
+			"Failed to delete host flood rule on bridge port %d\n",
+			port);
 
 		return;
 	}
@@ -1919,19 +1923,33 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 		return;
 
 	/* IPFT does not support in-place updates to the KEYE element,
-	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry ID first.
+	 * we need to delete the old one and then add the new rule. If
+	 * the deletion fails, return immediately.
 	 */
-	old_entry_id = np->ipft_hf_eid;
-
-	if (netc_port_add_host_flood_rule(np, uc, mc)) {
-		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+	if (netc_port_remove_host_flood(np)) {
+		dev_err(ds->dev,
+			"Failed to delete old host flood rule on port %d\n",
 			port);
+
 		return;
 	}
 
-	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_entry_id);
+	/* Restoring the previous configuration is pointless because
+	 * .port_set_host_flood() returns void, so the upper layer cannot
+	 * detect the error and the RX flags have changed. Furthermore, we
+	 * cannot guarantee that we can successfully restore the previous
+	 * state.
+	 */
+retry:
+	if (netc_port_add_host_flood_rule(np, uc, mc)) {
+		if (retry_num++ < 2) {
+			usleep_range(100, 110);
+			goto retry;
+		}
+
+		dev_err(ds->dev,
+			"Failed to add host flood rule on port %d\n", port);
+	}
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -2096,6 +2114,8 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
+	bool uc = np->uc;
+	bool mc = np->mc;
 	int err;
 
 	if (!bridge.num) {
@@ -2107,6 +2127,12 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	if (err)
 		return err;
 
+	err = netc_port_remove_host_flood(np);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood rule");
+		return err;
+	}
+
 	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
 
 	if (br_vlan_enabled(bridge.dev))
@@ -2120,8 +2146,6 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->ipft_hf_eid);
-
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
 				      READ_ONCE(priv->fdbt_ageing_delay));
@@ -2131,6 +2155,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 disable_mlo:
 	netc_port_set_mlo(np, MLO_DISABLE);
 
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev,
+			"Failed to restore host flood rule on port %d\n",
+			port);
+
 	return err;
 }
 
-- 
2.34.1


