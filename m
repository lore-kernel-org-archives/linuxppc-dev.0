Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E6606D827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A3jd5oPA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJX4C1VNCz3c8w;
	Tue, 03 Nov 2026 13:06:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793671579;
	cv=pass; b=kdWtsxUFgyk5FAApVGAIG+qV+0HHxW8TF1f+9WTqDgEYSBQiOUrYL+y47rye/8+clAI7MtcoiZRIAwWith044FjRVVrOayG6uLnp/w5YzhvvVTuLRP1gVE0XRAi6EpURtnOm0IeToWvguRjswXKTWvFsqJOF9BfRoGpfa0cTWrJaa1Lt3IQX0SMD6pFIiAl+06nXxbhrF43lxhx/sNGEK4L1zsifA+KeO/GuNbA5DJEPnAMLHaiB97SJv5DDDLFj3SVN6huIztc2P7mGxBpbczXxMsVp3nLe59gF7eR/xp0bomM9u4oiD+DzHHIYAL3OMJn90NWpH+guHJSFpbUkPQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793671579; c=relaxed/relaxed;
	bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QeUF6BhFFqQs3W6BTD/jT1q1pNPzUmh1Px7ITTmZYQvbaSqdgDOsccmyTxOKH5WcTnsBXKo9iQSR3KyQ6/rLoELYexxMTrA611H4adanKrRBMAJqYbu7HV6+gLV2K31V00j3Zqu1EWSDv2KoNp4PgFSip+69jVZFBjQ46tgGtLtHSJhVHLduCI61dlu0/e330CTAzvezg+jjRYvEWq8QQuPGmlOc83n5PNDgOuoV+d5wyjy2259JFFVNHMb3zYhqZUZCNnbZB8hmDOXWsGFTdozMU3eXLmWcJBIsjwaQQfIpr8qdKlF7m9zvQt0PFQxB7DjXz/zadc86cS+T8r4z/w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A3jd5oPA; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A3jd5oPA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJX4B3LbVz3c85
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 13:06:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucERacy81Sasz0q9/J6OytSBCyV03tZRsNROcmuEuDAkd/bFZgN51vAmbzPNnuw0U5Gx3ZPTL7o47wfZI2zM2EquIQc472YEqrdSIjmGVpsf0RxosgVo1s+kT31EKm0naClWNXBKI3Gz9oEJafUviny5CSm44GHoJHr0/BFK22pi7io9KTtDB1/LSL9zwCKbqCOi2vzCKsa1y9HQMpFduGydQv/uv8Hhi6jdlkVO4AK8n2neruUR36lhPSPEwidx7KN5jGfPIHGVUoiwI2WG7kMUDSLHN4CqtAtKBB57pxC6Ekf3lrGQRGpM3lB3lBvE+VSbgYm3Ca7Jn9jjXyfNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
 b=bEbn+KiwOmAw7wTHExzBRo4kUPFJQjqfjX9KWYWcf9C+2h/HIXix8bkA7x61Yt6VlcpErIzIIHn8AMirgjA8sZe6y4dekuoi9Op+Je3sqt+wkRPRtNkHpKuHk57I9olAJklxSV79SbPbabDduJ0rTZwDK6b1R2/zUJCDb6zVJBecOpEsgccgY9xE7fE+s6Upm8YHHIoQ9vLNaIs5JBMaa1S4d3SuqUvhFj5wxaqBYKOHQLSfTtqz/zgOi+8WH3J+U6A8qrnnAjrCUHjGiSzuWKsv2Hdy3xOa8C+YeGhtgyq/E6IAJGBckfs9AyCkS/yAHONWVCXfe7YSowo6MSS4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
 b=A3jd5oPAnWcuyBRbzbomETdZy4PbDz7NI24jOGnfQuj5X6lEmBwtel5jO6VtOM6T6EnAXnWCfjmNynHE0HVCze85QqYPd3GSbyI3SU6EAn/uJM8WpoKXbt8/jQHKwTrPT1dDbRQG2P9QQGUgC9B3lU6v4cDhaC3KzA/spVpMjzB5BmmG6wo4m2+YcgthR5ReiDrXhDlkrQmzqqR9BLkxPvArir+LPlE0T2E3BAZweHcWfdCbjDp0lP9hO6i2n8z9U9Hf9mKNWHZFZEQb5JVPYUFoPacMx/SjAteXDRvzDRwbtqqWWzlUo07mH2oevL2EOrP9PHq0Ix1LAbd3Tz3XFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM7PR04MB7094.eurprd04.prod.outlook.com (2603:10a6:20b:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:06:01 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:06:01 +0000
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
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 net-next 2/9] ptp: netc: remove unnecessary pcie_flr() call in probe
Date: Tue,  3 Nov 2026 10:10:17 +0800
Message-Id: <20261103021024.3121936-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
References: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM7PR04MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbe6cf5-0e1e-4d5a-f6fc-08df394f0286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|261021123027099003|11063799006|56012099006|261028144727099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ve03WdkdK/aZinYPBXsbcNnGfJF4ESo/DI6ZdSOVPvA+VxJbfQlhrYvWYo+nFvYqKcs1dT3MBKafVpQfBRspTYB+bCJyw1uv++wRe5WEpEVvUyNfodf17NyyXmyk4f6yMzcXySZSoJ/kAhGOsbCmSIfXxp/mnwwKCD+0EVIyOBEYEkSbOMpuilpQ8e9YjN7d3G3rlDzAgYSfDkpnlr+ycoYuiFlAiWOunXfDbQlf++YKkE1Nk9OHNv6DIvoCbLgaeAAtyDnlIL0euJOlJMRgVFJdbMQVqcXc2k5IH0tH31YYeGp3criWlxA2poec3l+j6FZga9LcAXMdBo4wlM4VCNxePLUpafAm1ebMeDygf08LXnarBqXQb5u2yStpNtF6gLuCn5ia/aMk4Hwx6cyLtsmtxBpC+M0dxsTfkzev2gcXRqQbez8BQMl69PcpFX4fCWbrm/7YGqJwDWOVvxlnqqnKpaUByOBgfESTcPT8oa5NuF5MhhfEaMiLhg1Ag5ONnso+aAfvDPbsjs7fqMaRcomaxEH3GY4pWJ7PjRuowSwJL7Uv2Npyc1dePufzHNSk3RqnHZsfG3QCi3KT8Dt2OaB1SUt/bheedrmFErEEuHc3Fb9BGMYl+kdlYKoovg9JxrZa1z3rqwO+1Rh0nb2xGVYZEvZONSCYUrD3F5J6uLym/3QvwfSbovRDorBqcsv43J9hzr4u8BHj9baJI/cBZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(261021123027099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l7ZdpE81AKL+Sh0hUTW2ZfFnKoqxHy4PaP9AEgpF1WvXEiY1l0a1NfpUq9y9?=
 =?us-ascii?Q?E+0f8oyq8kkqDNFZBQIQGKtL9x3gEAyrD/bLT96asxcqZ7qZ268yFLPI//yU?=
 =?us-ascii?Q?Y/KwHsM9x97RLLkr7cxW5mAcpTnIuOhFNsl+Niyh1L28C9JLq7U271q243fZ?=
 =?us-ascii?Q?JEZtYdYQ8wn5jNGdMIpSS6l//u03Mi2pwA8gaay3ysyxORgDGJUDSayjjbqc?=
 =?us-ascii?Q?sQpQ4a0bOA8o+TDGFjhJMS/HBa1bHw21CGN+NzEB2OEy+RKe5gWDK6uJixM9?=
 =?us-ascii?Q?beszrNMuzXz1IwAmbntpvb/4SN0lRe+PK9LW6a3Oh7YDkM7srjN/+R7YJAsc?=
 =?us-ascii?Q?FBlhWyCz3toRgJW8+hlB7xCoDqWp4Hn4aExdPxDRDvDwSMIk00+T/9cIr/ct?=
 =?us-ascii?Q?GSO7A0MVpd2PMOcKm0RoxdUZ/UybwBhedbKciIdVdtY6P2AyqcqwOKM/sZKh?=
 =?us-ascii?Q?JNiiRRVi6jONuYPsHwMPwj2OZHfQhOz0GNJ7mL7x3g9w6QGuOtUj3hy1sW+s?=
 =?us-ascii?Q?1BDYyYPEzjNANmrW7ixx+9EdXsVpDDeNSJQ1UJII15VBjMEbogOfowf9U9vW?=
 =?us-ascii?Q?nadZg9MXSyO6kg2wptBhiwyPMx1TjBNBAj8OSXfEhXf01Ul2YbRAukyanXh+?=
 =?us-ascii?Q?VaiZC2/VjEmXfwJ7pxVKLBlt7UefCDmKCnLgQ4FFOHdqmyvdajFG5bZD337O?=
 =?us-ascii?Q?KGuUJMsCO9fStD1O6j1W5zmb+UYdoIv4LURQfTtwTY9qbxOqy7yxRaeDk6LU?=
 =?us-ascii?Q?0p0n/LsmMqPirK61TXoUFcPp6WMDwHwugvJq8r2wWCOrImqgURUI/8ms1Qhh?=
 =?us-ascii?Q?ESwU8C26CmtAwjb/Ncl+U7sWoP35OvPEE1D2vw/GqskALDXl7ttI3JpTTLPI?=
 =?us-ascii?Q?NYTq0Z+7PXkv+CSoinSu0+A7jEyop1lAValXw3Qf/2JOBx7IM+tm3mStUMrr?=
 =?us-ascii?Q?I/dmpjExf9F7vxeXV9edwKy1K54CEtfkxhWNt2E05nlq3gbQD/epdAuPgwBK?=
 =?us-ascii?Q?06uefYYWh1FuhDgoqIVRaYq8njm+XJ6fjRfmtxPCT5IRt32ZWIgK0NfclBzA?=
 =?us-ascii?Q?CQqaUlK0xzRn4znnRpYXbx9UnKB5NZfp0YPGW8ZlPQLZ5PrQw1ljKiECAN+x?=
 =?us-ascii?Q?sOaLKX9V9+DiWge7eqhzqcGgk42tKp6N6ZVKWktYrQq0LO4TxIEspEIKxXBH?=
 =?us-ascii?Q?pAyMCwC8yH+FcGMDibAGpErdYPdnuYqNmvXEJndeLkAZNTKiYAk+YJ3ASU79?=
 =?us-ascii?Q?paC+eAWt2/WF7fZUvP1xrHvqT8xstCtAuCJ7PCGmo+AV9ZCUJm7xb5Jvedun?=
 =?us-ascii?Q?+3cyZ92/pMhJl3Ew+voxkzDISZMwYVQ9Z5CMFrlKNvUR0AtyP49tIkU6GT7G?=
 =?us-ascii?Q?96G28m3ry7OqSQj/WsagId+YvxaLvgUkjj5UzNG/qThMuzSgAN5LWO9orqfS?=
 =?us-ascii?Q?PeMK5IH9DXE/FGfE5qPEjVhLx/yV7bY/RLNlTXtyOx39AOccNSzpLYztxNyF?=
 =?us-ascii?Q?MKyyB37FHa0chfjf6oGRE4+FToa0OeIVIP19AVSFXERvIfpATuw8zURqSx0b?=
 =?us-ascii?Q?pagJN+l38N4fjlSC+Lnzh8o2w4kyc+pZgl1X9syS68wb4YyB6WJBB4zzQrq5?=
 =?us-ascii?Q?Fthov6Z0Fwpn7hiAPlJqn9xpS+UrQXYG1pblIAT4LmATCzEbkAV1uCGQRCqe?=
 =?us-ascii?Q?MRoqC6H9i7D5ej+ml4rsSnY3YaUhwj0/93WuE8ydYifKtGSIdJhxGpHGHeiQ?=
 =?us-ascii?Q?lvr/ZaVcPLLKVM9fLFYMCEZjzVb2QPeYflwFnf2TRyV2vtzIQctO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbe6cf5-0e1e-4d5a-f6fc-08df394f0286
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:06:01.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9uPH/uHRmM92aU70e076tm6RV9n2wFJ1m2Crap4rJVWFnvqsry6ByTN739O3EEPTXnhBJcAg7Pbqo9tQrsq/BL4UIfU7V0U94wMyRe4UWa8A5fc8s9bByM6xb+EOSEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

According to the NETC reference manual, function level reset is not
applicable to the timer as a supporting function. Remove the pcie_flr()
call from netc_timer_pci_probe() as it has no effect.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 376b3b0d1a38..aa9be8e2a630 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -777,7 +777,6 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	pcie_flr(pdev);
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
-- 
2.34.1


