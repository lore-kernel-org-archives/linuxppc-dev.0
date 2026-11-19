Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC560A5BD4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NKema55H
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVNX513NMz2yqF;
	Thu, 19 Nov 2026 14:01:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795057269;
	cv=pass; b=Ml8XcMG9n6AS6PNzlVNZ3nf84NmE29WVDs+GSG/277bPmLGhO7MKqiBAqy6zOeqtDUpi3iSw7par0ecw4fvx8LIx9L6zoV1Lo1zhFaRl2OLU0NQCv4MQzeictrWZVq1VaBYEtS1zwmN5FqA0gCvYh8j4V8wK9XuCHMqHwaUfhAFC0q5jEXJwk0MnH5S15Kdl4629ixCMx86yXiX4cW+lLZIwyYxtPpM6e2yAfdMUII1FVWfCX4pUiVshDcg0zZ0V/sQzGIKW/NKTLUZoB1/C16O1X2qiXWH/MkeSNjetPnn7OYNUMGmuvW3nPvCxMZ2CkADlwogftjPeKvfvQ4xPcA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795057269; c=relaxed/relaxed;
	bh=cu2RuDkjD7UZpmn99mlj/rk594VGn3IEwrVdfKEdKis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvBbaU5cMnRzlixuwh4I3Z/BYK4HDfs04L7DCjdCTFWiBs4cKFRb2bYNBZYC6pq2fAHi7Ay+A1kZxtzYXuPToPUjJ2B7h58iQfIMwdRolAR0H8e8qvJlPtc0FFTn0AYddiWj6l8FQ5CbkzCiqJSRsNztT1B6MC/sANGZXZuWT9tP3fw1MaRWYMSW1g89MWfhMyHuGI4DPR5LC+gteFFdCBljXg5h9hfHFwMNzv9cNJlO6xP0g6AZm39AkV0zGAkb23YAHrRRok/75h07EUJn8qaC1XBG6jKZ6QHy7bnTcDTRJbpzbK8oijwRRd3z4KSvGaU9bjE0wDcSavRoyZSfUw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NKema55H; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NKema55H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVNX36fhYz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:01:07 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5u9nqVmy64N+T9NXf6MS0y3JKCtv7UqoGmmxKmY0KgMP1iA8djJDv/hJFeKfNpmM9bR3c+jAlHVRvr+CNLF0eJ8Klkza8AQzyjLD0WgFvJMQGk1VsV4R0VFLOMHkjYnnBTPOkXPjjYy2IL3GHK0nL+giDVZrBdu4zXLuNgdfIT/VoQutwzl9lSlf297G7qEVNRoaCXvOHNLzlcUURbZyTfPVGzP6rdUUrNQ1xxH6O8ww2MS8GArGxVIkseQXA3CyaGsQu6NSIaAmfuTzpDU6eEjqq/DZXyVyx9xHMaYEONGyLySY4inE4Kw4i76qL46DFVbRZAJrsJZJ09za74iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu2RuDkjD7UZpmn99mlj/rk594VGn3IEwrVdfKEdKis=;
 b=RZ9+i+E7qjSjriqWW6rd2fGnvlNRq8glfMw9evttcPknzfyo2NjciFTqMYNNNUHkGoo995WPI3uCQh5Cl9Bw5XP6Y9L/KXsTWeop4JAnlZ7uYlyxXRjedTB8cikwct9ABkAmkA3pXy9mxKAcGqVCRjr6btNHOsah5tMCDidfm4PK+oUeKtmBqqHN9WwV+uJ+wpbh7J93PjbHfZa0wtVAErA7KA61GquyR8pzgu7SMIkEX70z33GeLnrHupGZILnIJpjhJlOIozcnotTSqyPj92QJy5S1Tps9wSknAGI9inyBCl2Wz+EvHUaYGJ4hKamrQAATeGdFa0RYbh8wo01qBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu2RuDkjD7UZpmn99mlj/rk594VGn3IEwrVdfKEdKis=;
 b=NKema55HIC0TXXv+UJmEZl3hRyZ2IOZ6mkWEmWG4lUAbmdOPNFTr/n1YCzEHh/5A1+O1swH0XGEH1uSFMBuaTHv21NjWrfpguxox1jYTYour+EREg5+rm4BdYIirNeNqLlU9t28ecxcHbUk/AGRkHh+irrhpuw2Wc0O/il8f9r06VRNK4pat3hU/jYx7LPsHbmoRFe1LgBpbGq/28VUbPHEGA8sZ73qkrCewUKgo0TVrD5PzoR2363Gz4XkBIf43mpUwb2T4RTW1pvEVQ56e8hh7EYjWX/N9gXZxzBTi5tpmK1VLgwPNA7iHuOlEJXVMsP1jVnril6oPJgKTeny7yQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 03:01:03 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 03:01:03 +0000
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
Subject: [PATCH v8 net-next 4/9] net: dsa: netc: tie setup resources and reset to DSA setup/teardown
Date: Thu, 19 Nov 2026 11:05:29 +0800
Message-Id: <20261119030534.1892935-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:990:77::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e66d7f5-cff5-4193-7a59-08df45e95912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|22082099003|18002099003|6133799003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022113327099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+/r302Ij7Yng2hnLfinQXxPyUpdxF5pr99hfKeUKnvk8LqxPD1xwpK66jaXJ3HrPDK2TXxK3wBjGnIGX9pdBd9XYkdEh3pBpr5bNN8fwKjMb7l1KcEzACjckp9CKG3/F6I+J9h4n08lvemQZ8+apofLC3Mr50anJy6mfz1Z3tG+0zk7ECqgC4srgnDyfZpSk9zP6cKymINHjJ7Ej4MACAW+UBts5h47fHj9z3S7YI63ekmWjUEgeTNJqwqOBibG1qpOugavvFvJF1MTesW5lFBFiaXnkqf5Q/a+9u/Z9O4AiYXXWEj6FAHQHzruaNFaws6H+qZxbKMsKeHfLUyarAVzH6J5BbR0B8+4c/+NY4oeowPgni+hKGKIdfDtNapXiuI8ij3nI8F42SbTX1993Kua9p+nway6d+DIEFdga3sm7CMtt4XAxak4QBfCVEw26SRoxerlBnoiGuwUCTV/Titw2f4swnczlL/vi3+YNtlFK6k3xSP1lwZWo2kMj/Aw8j1vVX+UHVdCNm/Fip8t9pujNlYFmI3mNYNklof+3Kjg12g6WtN22Mu++XYBaiU63PkptyZZY8oE7ZSu10Ji9ckl9PaPzpOgFY0zGQPBrEZbvgcagZox5iz6Wyj9QHK2CVhEwNyJzEPLpxlQ0ttaiXRXlXQri3qzohbDDnHq6kNzUtNGHA3CsH/1e2y00taeaO0vvrmG4/mAsB2fM2/Ez1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUpSZV7Fbvwz8Ae3dE3IWDugoZ9poBa5LQUcw/ZpGjQQ39i0IEe5xxJX63JR?=
 =?us-ascii?Q?6+T/kSGcQikFz9C0lBWh8OY7ahBB+EDFHHdq5qR4o7Fam1jtFt2iRMDJjSJx?=
 =?us-ascii?Q?OmnODq5FUnVH6oJpSOLyUDOS2jvfXTVy11XQsg2PekfwErSgqCuZvT2b76sE?=
 =?us-ascii?Q?M8Gm2cpr/J2ib8xNLOH9cjwgcNAN2UnMj7ayNjL4P0VzjA2/JXgWGr6yfAOy?=
 =?us-ascii?Q?WVy08WXuM2maFsvoCKCrTnGvLnPcBqZq8JEkR6xv/zay0wLup6mvMPtVckiW?=
 =?us-ascii?Q?ftLkZHgPTcYAVxsRr5MQBmaDvny1oNBSR2AERnLoRLfRYVxWTJBRlfrxZQq6?=
 =?us-ascii?Q?pljzemTKjdxZmq98Pdb9YkZ7ANt7x7Iv5R3aVGk7awMNIaRzCE3htzvbmGo+?=
 =?us-ascii?Q?ciYjHakHiwlvYmJFGavjjOijekQiCsq/FxUh8jD8ozBBwWtAl+WJaSX0taaO?=
 =?us-ascii?Q?zBqdAgxmXAU/2Mori7p/s7lB3bXVhflBRjZkWPdCZFd9zSQKQpTMufJspsHP?=
 =?us-ascii?Q?qI1fz18XXjor/JTiKJ3q5YTKCkOGThAWdkxZr2KHqGf7d6GNlDd03XwSrYHX?=
 =?us-ascii?Q?ayGmIB5iduXh1XDhbVme4Ed73p2yLcsXNTnbHV4gSD3xhF/Khu2PuyZbacC0?=
 =?us-ascii?Q?ZGDNXvERDKzHWdUIhx1cXDV7eFGY9H2Rc0Re05JXEfzkM7SaOL6djfcxNQ7a?=
 =?us-ascii?Q?yXw0DEgO+00dTZQG06jgPgbiqvuKXELL6a/cOncMNqr1WXIkhIEI9Ywu0aqZ?=
 =?us-ascii?Q?XFowC4T1skK6ZROcU0OvLQOVxi9P+mR+IwtB+/vJmd4vbculHGkuEyvO/cpZ?=
 =?us-ascii?Q?4/PbsGheU0Jm8Y93qdUQEVN7HGLwQVdOOhM3/QQdWX3FFWkOPxKNk2PrER2z?=
 =?us-ascii?Q?M2a8Tb3xcthqDJ+kYoxmoc4vk+RqKd2FY0KFMUfoFJlkBfYefctKfvwho9y8?=
 =?us-ascii?Q?RgL/2OKlu1xLkEtugu+JRLK9Jq5CrZR4zrgH0i+xas3HZkHpu9OvmupJUeGQ?=
 =?us-ascii?Q?WjY1wyHZLfJo+SFjbhFr0lkDjALhmBVyLrwMHpWTMLxol8QaRaDQCWS2jKj+?=
 =?us-ascii?Q?++EWGNoIhS8AZmG93W2IS/ZJoXSc+e1yh4s70ftS4Rev9cS6zNKp3AyXk462?=
 =?us-ascii?Q?12nMuIxMSy7QeW2qRnm6407HKXnUpl2ZwRzml6Q75j40VN9CGgchlXolI5MK?=
 =?us-ascii?Q?7CljRjl0wbE5TGdW1xv4F5RQrVe6SuDUnPcsyn12wgC9f0kOrEpNxbzulhSS?=
 =?us-ascii?Q?BpP6DtPMmAQyqTu0f2Rv4GETM0yoGgAyo4DcBU5KjYubV//tISxEfdaZMiwW?=
 =?us-ascii?Q?R8WX/+g7RKZ/Gju55IPp8GaOGfq+khUSlm7497nRVy5dRfw1AoSF2vnNrHFu?=
 =?us-ascii?Q?+LTwutU434IRif5Hh8WiwOSVnlSLDMgIJN0MKlmnDOCBosjh60XdDieh0dN/?=
 =?us-ascii?Q?VuMXC5SrL5M38CAItrRk16IwPKd9aos+2FZP2te9t2MfWVMuW6TDAU9HZtIf?=
 =?us-ascii?Q?ZNvtl97MEbJN4WZ2PBnAGLAxHpE76Sjzx9QUZGxPjFcR7gLXc8qyjEXduEVe?=
 =?us-ascii?Q?NIHBMFA2X5qYocc8KIW1Pd2/9LRFVrlamcmiX4HRo8IqEjFgEH2cla9kMqrR?=
 =?us-ascii?Q?FXhZ+4doIiY78NcXuEHUixgQfut4H7yNf8AYR7RN6q47haJu90VMfKvsrctG?=
 =?us-ascii?Q?8eQx3AC9spGglIl8lDUMbWeoM5dqtLIuSTAnLDENLL9llLV0GS2rcOj11+hx?=
 =?us-ascii?Q?iAGLHaNMAkDFb9xZVLHmvJn0iZ/C0tdDr+s3ussUK5H+yg+WKBUE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e66d7f5-cff5-4193-7a59-08df45e95912
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:01:03.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBco8huMpzgJL0BQpO0zjGXcB35qAIc0pmY4wtOt7pjOVL1FYIryPqJt6yMsCHKic7Db5wuQXdU3JIcSmaeCps7iThT7/wP++Iouefp+ZfzLqs+Xqy+tYj/3T7TIX8/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The NETC switch reached a known hardware state via a one-time PCIe
FLR in probe(), and used devm_ allocations in netc_setup() for its
ports, EMDIO buses, reference clocks, command BD rings and buffer
pool table. Both are tied to the PCI device lifetime, not to the
DSA netc_setup()/netc_teardown() lifetime.

In a multi-switch DSA tree, unbinding any switch tears down the whole
tree, so netc_teardown() runs on every NETC switch in it. When a switch
is bound again and completes the tree, dsa_register_switch() sets up
the whole tree, so netc_setup() also runs on the switches that stayed
bound. Thus netc_teardown() and netc_setup() can run again without a
PCI re-probe of the NETC switch. Two problems then appear:

- No fresh FLR occurs, so the hardware tables keep their stale
  entries while netc_setup() builds empty software state. Hardware
  and software drift out of sync.

- The devm_ resources are not released by netc_teardown(), so each
  re-setup leaks memory and re-registers the same EMDIO bus, which
  fails.

Add netc_switch_reset() and call it at the start of netc_setup() so
every setup begins from a clean hardware state. The probe path already
performs a FLR in netc_switch_pci_init(), so the first setup will skip
the reset because the priv->configured flag is not set. Any later setup
is driven by a sibling switch completing the tree, under dsa2_mutex, and
resets the switch with pcie_flr(). Save and restore the config space
around the FLR, and hold pci_cfg_access_lock() so that user space config
access and other PCI resets cannot run concurrently. Do not take the
device lock, because an unbinding NETC switch holds it while waiting for
dsa2_mutex in dsa_unregister_switch().

Convert the setup-path devm_ allocations to explicit alloc and free,
and release them in netc_teardown() and on the error paths, so their
lifetime matches the DSA setup and teardown.

The NETC switch does not support multi-switch yet, so there is no
functional problem today. This only reworks the driver so that
multi-switch can be added later without hitting these issues.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 186 ++++++++++++++++++++++++-----
 drivers/net/dsa/netc/netc_switch.h |   1 +
 2 files changed, 155 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 1225ff8153d44..f724f95add36b 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -135,7 +135,7 @@ static int netc_port_get_info_from_dt(struct netc_port *np,
 				      struct device *dev)
 {
 	if (of_find_property(node, "clock-names", NULL)) {
-		np->ref_clk = devm_get_clk_from_child(dev, node, "ref");
+		np->ref_clk = of_clk_get_by_name(node, "ref");
 		if (IS_ERR(np->ref_clk)) {
 			dev_err(dev, "Port %d cannot get reference clock\n",
 				np->dp->index);
@@ -146,6 +146,24 @@ static int netc_port_get_info_from_dt(struct netc_port *np,
 	return 0;
 }
 
+static void netc_port_free_emdio_bus(struct netc_port *np)
+{
+	struct device *dev = np->switch_priv->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct enetc_hw *hw;
+
+	if (!np->emdio)
+		return;
+
+	mdio_priv = np->emdio->priv;
+	hw = mdio_priv->hw;
+
+	mdiobus_unregister(np->emdio);
+	mdiobus_free(np->emdio);
+	devm_kfree(dev, hw);
+	np->emdio = NULL;
+}
+
 static int netc_port_create_emdio_bus(struct netc_port *np,
 				      struct device_node *node)
 {
@@ -161,9 +179,11 @@ static int netc_port_create_emdio_bus(struct netc_port *np,
 		return dev_err_probe(dev, PTR_ERR(hw),
 				     "Failed to allocate enetc_hw\n");
 
-	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
+	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
+	if (!bus) {
+		err = -ENOMEM;
+		goto free_enetc_hw;
+	}
 
 	bus->name = "NXP NETC switch external MDIO Bus";
 	bus->read = enetc_mdio_read_c22;
@@ -177,14 +197,22 @@ static int netc_port_create_emdio_bus(struct netc_port *np,
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-p%d-emdio",
 		 dev_name(dev), np->dp->index);
 
-	err = devm_of_mdiobus_register(dev, bus, node);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "Cannot register EMDIO bus\n");
+	err = of_mdiobus_register(bus, node);
+	if (err) {
+		dev_err_probe(dev, err, "Cannot register EMDIO bus\n");
+		goto free_mdiobus;
+	}
 
 	np->emdio = bus;
 
 	return 0;
+
+free_mdiobus:
+	mdiobus_free(bus);
+free_enetc_hw:
+	devm_kfree(dev, hw);
+
+	return err;
 }
 
 static int netc_port_create_mdio_bus(struct netc_port *np,
@@ -238,6 +266,33 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
+static void netc_free_all_ports(struct netc_switch *priv)
+{
+	if (!priv->ports)
+		return;
+
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		struct netc_port *np = priv->ports[i];
+
+		if (!np)
+			continue;
+
+		netc_port_free_emdio_bus(np);
+
+		if (!IS_ERR_OR_NULL(np->ref_clk)) {
+			clk_put(np->ref_clk);
+			np->ref_clk = NULL;
+		}
+
+		kfree(np);
+		priv->ports[i] = NULL;
+	}
+
+	kfree(priv->ports);
+	priv->ports = NULL;
+	priv->port_bitmap = 0;
+}
+
 static int netc_init_all_ports(struct netc_switch *priv)
 {
 	struct device *dev = priv->dev;
@@ -246,8 +301,7 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	int ett_offset = 0;
 	int err;
 
-	priv->ports = devm_kzalloc_objs(dev, struct netc_port *,
-					priv->info->num_ports);
+	priv->ports = kzalloc_objs(*priv->ports, priv->info->num_ports);
 	if (!priv->ports)
 		return -ENOMEM;
 
@@ -259,9 +313,11 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	 * difficult for us to cover.
 	 */
 	for (int i = 0; i < priv->info->num_ports; i++) {
-		np = devm_kzalloc_obj(dev, *np);
-		if (!np)
-			return -ENOMEM;
+		np = kzalloc_obj(*np);
+		if (!np) {
+			err = -ENOMEM;
+			goto free_all_ports;
+		}
 
 		np->switch_priv = priv;
 		np->iobase = priv->regs.port + PORT_IOBASE(i);
@@ -277,18 +333,23 @@ static int netc_init_all_ports(struct netc_switch *priv)
 
 		err = netc_port_get_info_from_dt(np, dp->dn, dev);
 		if (err)
-			return err;
+			goto free_all_ports;
 
 		if (dsa_port_is_user(dp)) {
 			err = netc_port_create_mdio_bus(np, dp->dn);
 			if (err) {
 				dev_err(dev, "Failed to create MDIO bus\n");
-				return err;
+				goto free_all_ports;
 			}
 		}
 	}
 
 	return 0;
+
+free_all_ports:
+	netc_free_all_ports(priv);
+
+	return err;
 }
 
 static void netc_init_ntmp_tbl_versions(struct netc_switch *priv)
@@ -307,8 +368,7 @@ static int netc_init_all_cbdrs(struct netc_switch *priv)
 
 	ntmp->cbdr_num = NETC_CBDR_NUM;
 	ntmp->dev = priv->dev;
-	ntmp->ring = devm_kzalloc_objs(ntmp->dev, struct netc_cbdr,
-				       ntmp->cbdr_num);
+	ntmp->ring = kzalloc_objs(*ntmp->ring, ntmp->cbdr_num);
 	if (!ntmp->ring)
 		return -ENOMEM;
 
@@ -334,6 +394,9 @@ static int netc_init_all_cbdrs(struct netc_switch *priv)
 	for (i--; i >= 0; i--)
 		ntmp_free_cbdr(&ntmp->ring[i]);
 
+	kfree(ntmp->ring);
+	ntmp->ring = NULL;
+
 	return err;
 }
 
@@ -343,6 +406,9 @@ static void netc_remove_all_cbdrs(struct netc_switch *priv)
 
 	for (int i = 0; i < NETC_CBDR_NUM; i++)
 		ntmp_free_cbdr(&ntmp->ring[i]);
+
+	kfree(ntmp->ring);
+	ntmp->ring = NULL;
 }
 
 static u32 netc_num_available_ports(struct netc_switch *priv)
@@ -840,30 +906,74 @@ static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
 	}
 }
 
+static void netc_switch_free_bpt_list(struct netc_switch *priv)
+{
+	kfree(priv->bpt_list);
+	priv->bpt_list = NULL;
+}
+
 static int netc_switch_bpt_default_config(struct netc_switch *priv)
 {
+	int err;
+
 	if (priv->num_bp < priv->info->num_ports)
 		return -EINVAL;
 
-	priv->bpt_list = devm_kzalloc_objs(priv->dev, struct bpt_cfge_data,
-					   priv->num_bp);
+	priv->bpt_list = kzalloc_objs(*priv->bpt_list, priv->num_bp);
 	if (!priv->bpt_list)
 		return -ENOMEM;
 
 	/* Initialize the maximum threshold of each buffer pool entry */
 	for (int i = 0; i < priv->num_bp; i++) {
 		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
-		int err;
 
 		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
 		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
 		if (err)
-			return err;
+			goto free_bpt_list;
 	}
 
 	netc_ipv_to_buffer_pool_mapping(priv);
 
 	return 0;
+
+free_bpt_list:
+	netc_switch_free_bpt_list(priv);
+
+	return err;
+}
+
+static int netc_switch_reset(struct netc_switch *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	int err;
+
+	if (!priv->configured) {
+		/* The hardware will be configured after netc_switch_reset()
+		 * is called, so set priv->configured to true.
+		 */
+		priv->configured = true;
+		return 0;
+	}
+
+	/* Block user space config access and other PCI resets, which take
+	 * pci_cfg_access_lock() via pci_dev_lock(), during the FLR.
+	 */
+	pci_cfg_access_lock(pdev);
+	err = pci_save_state(pdev);
+	if (err)
+		goto unlock_cfg_access;
+
+	err = pcie_flr(pdev);
+	if (err)
+		dev_err(priv->dev, "FLR failed: %pe\n", ERR_PTR(err));
+
+	pci_restore_state(pdev);
+
+unlock_cfg_access:
+	pci_cfg_access_unlock(pdev);
+
+	return err;
 }
 
 static int netc_setup(struct dsa_switch *ds)
@@ -872,6 +982,10 @@ static int netc_setup(struct dsa_switch *ds)
 	struct dsa_port *dp;
 	int err;
 
+	err = netc_switch_reset(priv);
+	if (err)
+		return err;
+
 	err = netc_init_switch_id(priv);
 	if (err)
 		return err;
@@ -884,7 +998,7 @@ static int netc_setup(struct dsa_switch *ds)
 
 	err = netc_init_ntmp_user(priv);
 	if (err)
-		return err;
+		goto free_all_ports;
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
@@ -907,22 +1021,25 @@ static int netc_setup(struct dsa_switch *ds)
 
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
-		goto free_lock_and_ntmp_user;
+		goto free_bpt_list;
 
 	err = netc_add_standalone_fdb_bcast_entry(priv);
 	if (err)
-		goto free_lock_and_ntmp_user;
+		goto free_bpt_list;
 
 	return 0;
 
+free_bpt_list:
+	netc_switch_free_bpt_list(priv);
 free_lock_and_ntmp_user:
-	/* No need to clear the hardware state, netc_setup() is only called
-	 * when the driver is bound, and FLR will be performed to reset the
-	 * hardware state.
+	/* No need to clear the hardware state. netc_setup() resets the
+	 * hardware via FLR, so the next setup starts from a clean state.
 	 */
 	mutex_destroy(&priv->fdbt_lock);
 	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
+free_all_ports:
+	netc_free_all_ports(priv);
 
 	return err;
 }
@@ -942,10 +1059,10 @@ static void netc_free_host_flood_rules(struct netc_switch *priv)
 	dsa_switch_for_each_user_port(dp, priv->ds) {
 		struct netc_port *np = priv->ports[dp->index];
 
-		/* No need to clear the hardware IPFT entry. Because PCIe
-		 * FLR will be performed when the switch is re-registered,
-		 * it will reset hardware state. So only need to free the
-		 * memory to avoid memory leak.
+		/* No need to clear the hardware IPFT entry. netc_setup()
+		 * resets the hardware via FLR, so the next setup starts
+		 * from a clean state. Only free the memory here to avoid
+		 * a leak.
 		 */
 		kfree(np->host_flood);
 		np->host_flood = NULL;
@@ -960,6 +1077,8 @@ static void netc_teardown(struct dsa_switch *ds)
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
+	netc_switch_free_bpt_list(priv);
+	netc_free_all_ports(priv);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -1042,7 +1161,10 @@ static int netc_switch_pci_init(struct pci_dev *pdev)
 	void __iomem *base;
 	int err;
 
-	pcie_flr(pdev);
+	err = pcie_flr(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "FLR failed\n");
+
 	err = pcim_enable_device(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 305f2a92e2f9a..de2af536c5945 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -118,6 +118,7 @@ struct netc_switch {
 	struct device *dev;
 	struct dsa_switch *ds;
 	u16 revision;
+	bool configured;
 
 	const struct netc_switch_info *info;
 	struct netc_switch_regs regs;
-- 
2.34.1


