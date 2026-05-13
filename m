Return-Path: <linuxppc-dev+bounces-20816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431CECD343F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:04:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdbs2jqhz2yFW;
	Wed, 13 May 2026 13:04:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641481;
	cv=pass; b=hjnkzmgAsvWyX3Vuzavha+EvNakW3shLFhQbk7ZhhKZtvesBLfSD3ACijfJ6A4Ioae9OpGmBEp/iJbVvynlYeUja8Z9sataJAxSKucuSh2crkAfZqKcBH1O3qwKdxRaxvn4MFs8MBqiORluQqPkkYCdcSBRoncv18E6fzephNPZbU/ah4NDF1bcsGnVNnKCwqzNv/JjQ6AvSWGpu8aCXy8IrfreXds2qFYD3hEMxr10bhDDA5T6dNA/oHVUGYh41g7I8e4PHDl9rp3YuBX8dXSoQJ9lrgP/2sR0aZKxYgMVqpS83fyyNDvZJ0SY+tUaYiU69sXoaiNjeOHtcAkDmVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641481; c=relaxed/relaxed;
	bh=0xR1d6e8XJ0K/LDsSg/j3/H4fm3GCviKF2FjslXsJe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTUWScvKDYJ/96PHfPoZr5rFvO7Oxxxq3OZkKXIUCsc5/jhX54g8d1oepLHZ0UwOdJ/mOYGTmEGvRtJe2NrAAis8yXYL3H51T/phwZM+ru3qUmt8oZMEVd3787Drdk6TLEieylMCSdJu27H2C9w4Zgp45+CZgTnK1ft+DRTnvq2qXaepDYYHv/Elb2ypuc9deMtk793hAfBPys1Una7UFrVLNt03ryPpD/TDMllq95UBX7i7UXmWXjd7kWlI2Z0Mqnwv5AS1c/Gl+ztfhCxfKvEr6un9f32xzHnGAzXC8O+PglNtPUtVsxrZcmwiVpHTzDKdLuy9tK3ILtjCElyS3w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ezqvr8EW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ezqvr8EW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdbr27LHz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:04:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqGbuae9Z7EPzpl/jZR86fLXEWCg3IvX2R0GBGFBQzZ7lK1aqNgIGRVgNzqpxD1n9vrsbghBTDnONk2JLomCkA7vaU3acAlHG9NO27q3pQ8xagyvn306G8QBBS0srnKpwHSvLHtQeM4RB4xM9G3Numr9CImi9gJrJyves/z1F/34RAThVc3ju0YrcMoIRvrtuCc3QVikPaa2wvGZW3eicEa0nTgBl3+r+OqoJYfwRRJCCPpupiwCVbg22MS7TuRw91zU81JVZQz828ISHWgOHUH/mCWrckFwiLgLhS39B1kMNQBR03K0nhkKP0KwlRSSZoelZnbLGX/9uy7IHVDkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xR1d6e8XJ0K/LDsSg/j3/H4fm3GCviKF2FjslXsJe8=;
 b=U+4D7qJFldKMtc+yhxTfcWrCfmAsHWbKYVj1r+idDcILLc1HSBWuuPrZPTn2gNScaZ2w8LTFnAett5Xlg79W8gLfLC44mjp0zpoTIRJ35z8b6WRyhInEtJqkBbSNwp1Bns7rXe8B2ru1sqr+JHPt175YbXNQo04ifKZecJtrgNISkVc1wbYxLQ8wbiOVOZ6IBNE3qJdoic3/0Cy5d3oSkoLjJ9ujystleyWYGroDsqiw/JM6FihZvsn9Q3IuUkQhIrfb7nranZdjBds8Xkhu1bLLKDscaOqbH8w/fArBZ02Wc8qJYboIkY1eO5w1+erkVqYHEWzx6GUyxqRLzEEw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xR1d6e8XJ0K/LDsSg/j3/H4fm3GCviKF2FjslXsJe8=;
 b=ezqvr8EWlwwx5aqVUa2IUnTye+55/oZ9PA4wkvg3VAON81UgU5JHzKz/WE6ABTiY45ZpPqjbpI0yoNDOsDetfsHq+/WmHNEnIWFAL0AwfULr1CzJiJwfEOq3LLOhR1ELpiXj+doNQFjO9Y12+ze0LnB8RndewmlMHYKKj30vyCACfcBe2C+QylsqZ+y6LMaCdLzujAsjNNO0vgTcBbgliMNa6ZSOvTdwPu6nXT8FbQClZu5BnXYynxsa9SMtnZXFKSkfdizXcfRgkzNHAWBPJoCajKvV9oWaGiKmyFyNoBovRGvnaK/OqqQ2Q504dQ7iCswzJb3E/zAcpeBxxc2Z7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:04:17 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:04:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 15/15] net: dsa: netc: add support for ethtool private statistics
Date: Wed, 13 May 2026 11:04:54 +0800
Message-Id: <20260513030454.1666570-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ad2477-add1-40aa-aa4b-08deb09c51ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	5+T5ZU7GutDU9QAMGZNJZJHJ/LPB8TkTkjgINwNpVu0ZsU8XsIcZEutTeC30rHOV7IwDBehrAAXbTP0OzXOYnAnTidbHs6+yuFMjSkjx0iltxrUhTKGkpr3zRH9G2V8tkdkaRbZAdF8LfpK//4CBDPTsti0KgAfF5Qc4l1CBfx5rFPWWH7xBnw1kKwsVFOrrE3uNLG3CtQIySKcHGMvs+PE0RpJbuAJsUUPZaMBYirwmBwXA7MRQH7J0XxIxEFiYaskxXK85uNcN4XFc8RZfmeM/qdcPoOIPZmRkh+VcpgQu3nCjA0Dv8uuofOWdAU0ZlpSZC4BWaqo9VTz4nrAmVIVwIZlwadhZyA/FlWCXqVzIk8C/YkaSBuKjYUgVF2B24OTnN+pCpPHdQIBtno3nC1pyUgXRZbAEBTc9rZ6m7IGGPkj3GUHv02WZPH8aZp1FA3ZKhzIam0ZFaXOypH3yI4t41KBUoce8/PI4VEtZbc4p5cK8HbhyovOPOxsQc5celO2JTtTB41EBYVGNtikLhjwBkDuvarRVogZqrUNVQzVK5vOvPAb5WnDrNovf3QbJo16E6yhrZIP7iHjW2L8aA6WWiNZVd07f7OvMr/HItQg8abgdzs4XrWJJJ3Aq4JVD6bsrnjlZlvMynb/JrvEKu2y4dtUG4YeMeon6IJNBDLRzgD3nV87OAF2sJQ3JYgIByXH1iEGd9RI6C3PxeWXE/QezYRVvljVThAua/7sjAsx8vTeIduMCsgOmduXOcuZzrwAabzMGjA+hg8EUHM6RIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S1e2wz+DQBYFO3tYShhjqOURBqEDPwP6s2uht8Kl+ocIJ51CCS2ewYhnrGi+?=
 =?us-ascii?Q?yNVBLyqqGHjwabywilAC6fpNFTvuL53OjOsJpjDTDQr7Rw+16K3MPdyycVI3?=
 =?us-ascii?Q?rdakA9UZSZU7Yx84c4xjz1buNmp9QC3sMTu3RMejc+DP0xFCT4wgmsjgc0OE?=
 =?us-ascii?Q?Bzd5lUSCNAwfz41/hFMhCV2viMoDoco6sw2DuaxQ8lMOSCImJNzyihDmDY+Q?=
 =?us-ascii?Q?8Ik6qDUvupIsByZ1p2Rr12MakekhI3ahIVy5bL3Iw5fyW/oMqE9cNqZL2aAj?=
 =?us-ascii?Q?RkgjTYPtkLS5YD3ZBeuHpqge67sg0a5g2K7LmFZaQNrjZBFhhISXq/hoJElW?=
 =?us-ascii?Q?vlL7Za26akU2k5cjiAUD1SfQw6lN6sGFdadXwH6ypaPa6EibqTY0Dqz9HuYB?=
 =?us-ascii?Q?mDJ3IUZXglhaH2wVGgQK/94PIiGwHrEWU4f4oxLejW4peWG6JDnTam5htV0c?=
 =?us-ascii?Q?rNJo0SQmqL/4ChjVdI4HsZez3PN7wX4GmL/BAF2keZyDJT/YZut/BRAaNs5s?=
 =?us-ascii?Q?ORQW9LgAdnPDXEACsZg+nG92TVY4PiBgOGeoKoQ0BENhZkfDl88ygtwrazj7?=
 =?us-ascii?Q?tkmiFgH9aNy5S3M8/8qzSPXQxaGDfawqht/thVeeYcGoFe9Nd9IClnbNpAfA?=
 =?us-ascii?Q?DPE+PaU+Sk+280N4kgGPnWEhOFOped/rw8DH6zmWE+5riVLPZTTK4A2Yk68H?=
 =?us-ascii?Q?KRvvEEz+Dtg/k70LPQ0QFPB7rxqmzr85QFW6vY5wczjcfr8iZzFqChtr0iat?=
 =?us-ascii?Q?z1rPXw8spJLjowzE17uLZlqqibaTMzCyPO4M/rE7fr5Z58sxLrfjTknp7ShI?=
 =?us-ascii?Q?l/Qdx4HLw3MQ4dvIINH8Jw5YtwbavTezMV7xJpsq3i5dEu+FGbXBfPpiCWSe?=
 =?us-ascii?Q?8uOcR765SVUe1ZskDay6ioZKXfVg9TEUQbFvhPyQ7ihZCHeqxLjxxx1ssSSZ?=
 =?us-ascii?Q?PAnhNzjieaXv5Gu7hIvm6HhjFmmAXrV229VJGUB84OBABvaAqw6nAExztcd8?=
 =?us-ascii?Q?nEvI1M5iy57OxmnaIaMu7iDWG54Q6ctbyNzEMkucDZ8tT76iZKM117kn1PTO?=
 =?us-ascii?Q?F0pq/T1UYrk0XluMVuW8fDtciPppzWAcXJPkkFQyHloQK/rBheSxXmHmgx5u?=
 =?us-ascii?Q?mixmV5jIyaitQrgZG1VKMuy2Bl29FkHmISiMSbaZZSg/To29g2eKWRs0xcTs?=
 =?us-ascii?Q?ksaXwVu/ydg3/ZFgPRik6wp6Fx7QKtFqhpOafjKeHkLTvGtST4cpBqkG8wv9?=
 =?us-ascii?Q?42eUBXI4DYiZp800Hf7KPORRsx4jivviwzfWFl6ak7PYBRv8K1rUYBfQZLjT?=
 =?us-ascii?Q?hXEuS0rA9vBBGeugjn1el20IkE/9ch+zAWDylhpzyAttkrpdrsPuAQ9Onpu0?=
 =?us-ascii?Q?AXPPH8W9jBQAlKa+c2u1yUP2dkhU0xCchWMsCOp3kB4zk6yULhbEt8h12PCf?=
 =?us-ascii?Q?7IV0y2spfb3+9zklH35wxBEb77HvFI631RdOlmOxWjQIcvetvgXj0Ig0H+zt?=
 =?us-ascii?Q?hPy+xMpULlk9NYX9qYMENuSAl0ZxnuOnmpVLpWCtG4gVhRZ+RfO3fXF7bqSt?=
 =?us-ascii?Q?Oo6kpNqdJ5etf+xghJdgi1OQJ12FYxJVKov0Ww94Z+C6lsayB6hXs1NLx2A3?=
 =?us-ascii?Q?siyc4lnn9bt77m4k94xtaBD3ZRMvg4WPy8YAJBeskqnG24FChuCz2mTBRXkD?=
 =?us-ascii?Q?1GPH239uJLO/D2HV8jASHXXeYwnvHlyAXf4v/aF/mTd7j5K3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ad2477-add1-40aa-aa4b-08deb09c51ed
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:04:17.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeO5J2VRldCERk7wpbagiqNh/GY6DG0qEvkZiazBtz7wZyz4kbmwrqNq6vEkNMIfzZgS4b7WXW7Hiwk//jY2lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

Implement the ethtool private statistics interface to expose additional
port-level and MAC-level counters that are not covered by the standard
IEEE 802.3 statistics. The pMAC counters are only reported when the port
supports Frame Preemption (802.1Qbu/802.3br).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_ethtool.c   | 107 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_main.c      |   3 +
 drivers/net/dsa/netc/netc_switch.h    |   9 +++
 drivers/net/dsa/netc/netc_switch_hw.h |  58 ++++++++++++++
 4 files changed, 177 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
index ac8940b5a85c..8d04db534347 100644
--- a/drivers/net/dsa/netc/netc_ethtool.c
+++ b/drivers/net/dsa/netc/netc_ethtool.c
@@ -19,6 +19,56 @@ static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
 	{ }
 };
 
+static const struct netc_port_stat netc_port_counters[] = {
+	{ NETC_PTGSLACR,	"port gate late arrival frames" },
+	{ NETC_PSDFTCR,	"port SDF transmit frames" },
+	{ NETC_PSDFDDCR,	"port SDF drop duplicate frames" },
+	{ NETC_PRXDCR,		"port rx discard frames" },
+	{ NETC_PRXDCRRR,	"port rx discard read-reset" },
+	{ NETC_PRXDCRR0,	"port rx discard reason 0" },
+	{ NETC_PRXDCRR1,	"port rx discard reason 1" },
+	{ NETC_PTXDCR,		"port tx discard frames" },
+	{ NETC_PTXDCRRR,	"port tx discard read-reset" },
+	{ NETC_PTXDCRR0,	"port tx discard reason 0" },
+	{ NETC_PTXDCRR1,	"port tx discard reason 1" },
+	{ NETC_BPDCR,		"bridge port discard frames" },
+	{ NETC_BPDCRRR,	"bridge port discard read-reset" },
+	{ NETC_BPDCRR0,	"bridge port discard reason 0" },
+	{ NETC_BPDCRR1,	"bridge port discard reason 1" },
+};
+
+static const struct netc_port_stat netc_emac_counters[] = {
+	{ NETC_PM_ROCT(0),	"eMAC rx octets" },
+	{ NETC_PM_RVLAN(0),	"eMAC rx VLAN frames" },
+	{ NETC_PM_RERR(0),	"eMAC rx frame errors" },
+	{ NETC_PM_RUCA(0),	"eMAC rx unicast frames" },
+	{ NETC_PM_RDRP(0),	"eMAC rx dropped packets" },
+	{ NETC_PM_RPKT(0),	"eMAC rx packets" },
+	{ NETC_PM_TOCT(0),	"eMAC tx octets" },
+	{ NETC_PM_TVLAN(0),	"eMAC tx VLAN frames" },
+	{ NETC_PM_TFCS(0),	"eMAC tx FCS errors" },
+	{ NETC_PM_TUCA(0),	"eMAC tx unicast frames" },
+	{ NETC_PM_TPKT(0),	"eMAC tx packets" },
+	{ NETC_PM_TUND(0),	"eMAC tx undersized packets" },
+	{ NETC_PM_TIOCT(0),	"eMAC tx invalid octets" },
+};
+
+static const struct netc_port_stat netc_pmac_counters[] = {
+	{ NETC_PM_ROCT(1),	"pMAC rx octets" },
+	{ NETC_PM_RVLAN(1),	"pMAC rx VLAN frames" },
+	{ NETC_PM_RERR(1),	"pMAC rx frame errors" },
+	{ NETC_PM_RUCA(1),	"pMAC rx unicast frames" },
+	{ NETC_PM_RDRP(1),	"pMAC rx dropped packets" },
+	{ NETC_PM_RPKT(1),	"pMAC rx packets" },
+	{ NETC_PM_TOCT(1),	"pMAC tx octets" },
+	{ NETC_PM_TVLAN(1),	"pMAC tx VLAN frames" },
+	{ NETC_PM_TFCS(1),	"pMAC tx FCS errors" },
+	{ NETC_PM_TUCA(1),	"pMAC tx unicast frames" },
+	{ NETC_PM_TPKT(1),	"pMAC tx packets" },
+	{ NETC_PM_TUND(1),	"pMAC tx undersized packets" },
+	{ NETC_PM_TIOCT(1),	"pMAC tx invalid octets" },
+};
+
 static void netc_port_pause_stats(struct netc_port *np, int mac,
 				  struct ethtool_pause_stats *stats)
 {
@@ -188,3 +238,60 @@ void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
 		break;
 	}
 }
+
+int netc_port_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int size;
+
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	size = ARRAY_SIZE(netc_port_counters) +
+	       ARRAY_SIZE(netc_emac_counters);
+
+	if (np->caps.pmac)
+		size += ARRAY_SIZE(netc_pmac_counters);
+
+	return size;
+}
+
+void netc_port_get_strings(struct dsa_switch *ds, int port,
+			   u32 sset, u8 *data)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int i;
+
+	if (sset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(netc_port_counters); i++)
+		ethtool_cpy(&data, netc_port_counters[i].name);
+
+	for (i = 0; i < ARRAY_SIZE(netc_emac_counters); i++)
+		ethtool_cpy(&data, netc_emac_counters[i].name);
+
+	if (!np->caps.pmac)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(netc_pmac_counters); i++)
+		ethtool_cpy(&data, netc_pmac_counters[i].name);
+}
+
+void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(netc_port_counters); i++)
+		*data++ = netc_port_rd(np, netc_port_counters[i].reg);
+
+	for (i = 0; i < ARRAY_SIZE(netc_emac_counters); i++)
+		*data++ = netc_port_rd64(np, netc_emac_counters[i].reg);
+
+	if (!np->caps.pmac)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(netc_pmac_counters); i++)
+		*data++ = netc_port_rd64(np, netc_pmac_counters[i].reg);
+}
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d79bd18b7e6e..fed2b1dcb856 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1491,6 +1491,9 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
 	.get_eth_mac_stats		= netc_port_get_eth_mac_stats,
+	.get_sset_count			= netc_port_get_sset_count,
+	.get_strings			= netc_port_get_strings,
+	.get_ethtool_stats		= netc_port_get_ethtool_stats,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 40e54af0c356..740e1f307c45 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -94,6 +94,11 @@ struct netc_fdb_entry {
 	struct hlist_node node;
 };
 
+struct netc_port_stat {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+};
+
 struct netc_switch {
 	struct pci_dev *pdev;
 	struct device *dev;
@@ -160,5 +165,9 @@ void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 				  struct ethtool_eth_ctrl_stats *ctrl_stats);
 void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
 				 struct ethtool_eth_mac_stats *mac_stats);
+int netc_port_get_sset_count(struct dsa_switch *ds, int port, int sset);
+void netc_port_get_strings(struct dsa_switch *ds, int port,
+			   u32 sset, u8 *data);
+void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index f8d436ad9623..1b016e7dd03e 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -87,6 +87,17 @@
 #define  PSR_TX_BUSY			BIT(0)
 #define  PSR_RX_BUSY			BIT(1)
 
+#define NETC_PTGSLACR			0x130
+
+#define NETC_PRXDCR			0x1c0
+#define NETC_PRXDCRRR			0x1c4
+#define NETC_PRXDCRR0			0x1c8
+#define NETC_PRXDCRR1			0x1cc
+#define NETC_PTXDCR			0x1e0
+#define NETC_PTXDCRRR			0x1e4
+#define NETC_PTXDCRR0			0x1e8
+#define NETC_PTXDCRR1			0x1ec
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -94,6 +105,9 @@
 #define   SDU_TYPE_MPDU			1
 #define   SDU_TYPE_MSDU			2
 
+#define NETC_PSDFTCR			0x4c4
+#define NETC_PSDFDDCR			0x4c8
+
 #define NETC_BPCR			0x500
 #define  BPCR_DYN_LIMIT			GENMASK(15, 0)
 #define  BPCR_MLO			GENMASK(22, 20)
@@ -142,6 +156,11 @@ enum netc_stg_stage {
 	NETC_STG_STATE_FORWARDING,
 };
 
+#define NETC_BPDCR			0x580
+#define NETC_BPDCRRR			0x584
+#define NETC_BPDCRR0			0x588
+#define NETC_BPDCRR1			0x58c
+
 /* Definition of Switch ethernet MAC port registers */
 #define NETC_PMAC_OFFSET		0x400
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
@@ -176,6 +195,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Receive Ethernet Octets Counter */
 #define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
 
+/* Port MAC 0/1 Receive Octets Counter */
+#define NETC_PM_ROCT(a)			(0x1108 + (a) * 0x400)
+
 /* Port MAC 0/1 Receive Alignment Error Counter Register */
 #define NETC_PM_RALN(a)			(0x1110 + (a) * 0x400)
 
@@ -188,12 +210,27 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Receive Frame Check Sequence Error Counter */
 #define NETC_PM_RFCS(a)			(0x1128 + (a) * 0x400)
 
+/* Port MAC 0/1 Receive VLAN Frame Counter */
+#define NETC_PM_RVLAN(a)		(0x1130 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Error Counter */
+#define NETC_PM_RERR(a)			(0x1138 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Unicast Frame Counter */
+#define NETC_PM_RUCA(a)			(0x1140 + (a) * 0x400)
+
 /* Port MAC 0/1 Receive Multicast Frame Counter */
 #define NETC_PM_RMCA(a)			(0x1148 + (a) * 0x400)
 
 /* Port MAC 0/1 Receive Broadcast Frame Counter */
 #define NETC_PM_RBCA(a)			(0x1150 + (a) * 0x400)
 
+/* Port MAC 0/1 Receive Dropped Packets Counter */
+#define NETC_PM_RDRP(a)			(0x1158 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Packets Counter */
+#define NETC_PM_RPKT(a)			(0x1160 + (a) * 0x400)
+
 /* Port MAC 0/1 Receive Undersized Packet Counter */
 #define NETC_PM_RUND(a)			(0x1168 + (a) * 0x400)
 
@@ -236,6 +273,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Transmit Ethernet Octets Counter */
 #define NETC_PM_TEOCT(a)		(0x1200 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Octets Counter */
+#define NETC_PM_TOCT(a)			(0x1208 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit Excessive Deferral Packet Counter */
 #define NETC_PM_TEDFR(a)		(0x1210 + (a) * 0x400)
 
@@ -245,15 +285,30 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Transmit Frame Counter */
 #define NETC_PM_TFRM(a)			(0x1220 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Frame Check Sequence Error Counter */
+#define NETC_PM_TFCS(a)			(0x1228 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit VLAN Frame Counter */
+#define NETC_PM_TVLAN(a)		(0x1230 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit Frame Error Counter */
 #define NETC_PM_TERR(a)			(0x1238 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Unicast Frame Counter */
+#define NETC_PM_TUCA(a)			(0x1240 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit Multicast Frame Counter */
 #define NETC_PM_TMCA(a)			(0x1248 + (a) * 0x400)
 
 /* Port MAC 0/1 Transmit Broadcast Frame Counter */
 #define NETC_PM_TBCA(a)			(0x1250 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Packets Counter */
+#define NETC_PM_TPKT(a)			(0x1260 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Undersized Packet Counter */
+#define NETC_PM_TUND(a)			(0x1268 + (a) * 0x400)
+
 /* Port MAC 0/1 Transmit 64-Octet Packet Counter */
 #define NETC_PM_T64(a)			(0x1270 + (a) * 0x400)
 
@@ -293,6 +348,9 @@ enum netc_stg_stage {
 /* Port MAC 0/1 Transmit Excessive Collisions Counter */
 #define NETC_PM_TECOL(a)		(0x12f0 + (a) * 0x400)
 
+/* Port MAC 0/1 Transmit Invalid Octets Counter */
+#define NETC_PM_TIOCT(a)		(0x12f8 + (a) * 0x400)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1


