Return-Path: <linuxppc-dev+bounces-18583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E76AD58B00
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:08:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN595rgqz2yYy;
	Mon, 23 Mar 2026 17:08:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246093;
	cv=pass; b=ok8xcs4FXf+SpwGx23RZhCtp2054SHQpPggsGNzxZSWz/FHqm4DGoX+ZlUL/q4ebpRIa3g4ghUU1waNCDmad4YsAF/tJANM/6WIAIV0pSI0mqZ91JpQ5teix0pn4U78pEcIIN1ZQP1Kkt7MaYOKXt+iN88E8SNr6c3yLtUnFPlYpw79N6Ghut9o3KZQNQtxDnHt5wPPnzynUTmIGW35mL5P2ki27gvdfjJXVbEnM9vap5fHCOVhk7OyiDM0X9HzBulkjGQIJ9omXaPCX5du5p+R0SVmY7znIGX7Y4SJ5R9lU2oD69Y/IxHGedJ5FgjsX2JtwuJXFDF5bpg+7wOJgSg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246093; c=relaxed/relaxed;
	bh=mEji+40KZiCu9feXBBpQ4eynY19LMuGbEYgGc5jQN6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+S4BLw+PeM83a49d+zx/PqtO33NeGe6VIIKkyVf57zD9ZvDmd5ZJdvC+dm37Egl7lqw2r4TDiSSJF72PQv9NqJSv/xWQ0UGCxuqHLS6JiXhOdU5t8Jluh9keSBEZJG2YAMGXdEZnlHGCHmb59H3wn/BOV1wVVc9Df5LLqQCrdvzynzBJLj9taIUHQefOfIWzhy0LB+OH2YJwrh5+Ns1ZhAPNsP7XQJ1aH/sd3TYjUSZspE+NbUST0VLsNqQaRhnihqHLcE62Q4sP3YGnAoIFjPpEaUag1sI553YxS129sNTPCOPWDf0OsX9+yWMvQcf7lK5jz5SMIqzu9oBzKaj9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PBL1jgnd; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PBL1jgnd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN583Q0pz30FD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:08:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ok4We4+orCH15EzVJv+OgaRPzgZyvRgz1JisZxQJFEc8/O1ZyUE5cVmpuxH0wR3G3tS8aPLkpOyf88YEM/lyxpj1zHIpFolZ4fPpR/fODdS+6gaZpwE6kl58+mQ1hSHJ9IYSNEZbhFgx1l5GKprpjBwVYuewcccwrEMHDhZ1pKj4zRZofiUSBnyGQOkcwSAiBncAitNHPKBB/S1QDWTmmfLysFIY2DIfUzEc601JSkoZQsXGoUdwFnfXNaAAWc+9iJtSRpjI1Dml8xDuUdHGb72rUmhxXXEvEwuuet3bpXU7+19bO+XDY0Y1/UN/FmswZ+OSuIYwjtSWIaTpOSkNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEji+40KZiCu9feXBBpQ4eynY19LMuGbEYgGc5jQN6s=;
 b=qwVxKYeNKjombXTvHH4jxlO/DsbWioYXtMR/Py/h2RB/vfc4aHZs1ikJ3w+gxeWlAo04+jpq0/+/0kJUJxENq5aqB3QdcuFl1tIrmXcN+i86Yxyg23pf+uxY2MLG4Drk/3jk5Zrn3K1TVvqpJhzc5nTe+OZQunb0Xjwi+FGWnUQjOuuO3Zi+w4dE3hUGOt9UBLRxb0cXxro+ZH/lNvuzyHOefguQKFOPzQ8PEUNt4svZcm0XUVJ1ixqciZdeMud5oxr94COJxnE6h4bj7ykCqJgGHK/jXbCJLAMvUtH7JbBqixPRZTf6bScXsYRZ+ChbF0/CCiNdsqjDG0luvXdqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEji+40KZiCu9feXBBpQ4eynY19LMuGbEYgGc5jQN6s=;
 b=PBL1jgndShdxZZwcIAO/1LXySA4IWg02vZEaGbtGKCPNfh3O4q/heTd2k2OQoYp7ms5/1vZm2R6UGmIR/aynKrm5zC1uzJcgrqcxu2hqZaYgWfGNibv5dv84m2RJD/GaaIvNmb5ZmPCiM50A1qeYTyLZ+PJcX9ifUhcrVdlr6ZHn1BH//JpPdoKcWgLvzXTZ9KMWFRqQQuQveQfDza9BKkkkcEi3sm2UfNLRw7TIXg53Yi8U+2n/a+QPT+DZ3zITI7MxVKs3+8bxkZNgj/vH0Tu7/iniEPwvKXhsTvWkQVKAdw0O3Wls2DrjFRK6+K0flE4xU0eKHlOwzV0M5FV5bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by VI1PR04MB9882.eurprd04.prod.outlook.com (2603:10a6:800:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:07:52 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:07:53 +0000
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
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 14/14] net: dsa: netc: add support for the standardized counters
Date: Mon, 23 Mar 2026 14:07:52 +0800
Message-Id: <20260323060752.1157031-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|VI1PR04MB9882:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bb191a-5c3f-4c63-fe72-08de88a2849b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b57sik+96wnHIvi3o6l8+Ij7J6BpUEZ3SSCsrCaL8nGhP5ftIr0YNdl+7XmXSUjL4vYJO8UsEIXhnwlqBapXr1qqYPT7EZC5jZOfxllpDOmxzspAufvH8cbBvyQ1prhMQM19FH28+WtHpH+gZxO6BD7lvoZz3NVyFSZvFP2/E+PE/TDvnciFsmI4nhOGo3Xsc5EMwlor2osFDtOcYFNrG9d1LiEkSEv6nkW7A6QvMpdkfCHR16DV9n1Fbs9HM0cbwcnnpoG6XYl0Fq1RSPQMROWm8yK3OJiIP/MENdY2A34Al6F0/9B343qJXVJU/6HvtoQxQ+LpmpFUrX6frsjuI/TxjeYrSxsQ9cxFJdLKbNI01BtnGD/TrP5z5q5I8sg48hX7pWNMAm2Yy/wHsYKJw1CF2Yz8N/hbtGjQTalOyheT9u0oGks1VmMW1x26X2EwOrS6ZaCnrEVnjOZDeFRd5cYs7PBtTEYDZepZ8rpv2YyBUb285BDDjrRhkvT2YMfSHUVvaxPfUxYkm0yNgTqXphISeXSUyYzig1zADILifZ1LZPN0nDPueoHj/QFT/00oDlkIWYtvf6QGBStYv1DeR3yqm6TNWOkA8N3UfuaDv5KRbqU1I3uo9fe5HhQHA4PsKX/O/cYvxVB9QROXeHEhFhASav+E7N9H2Ic55L+A0tP9IccY+h4CFvSFBMMksnRPXkMyZV4vH/0yaaKgO1npFpue4F68ClRldkEHUDgSLR768v3B3L+NQPom3T3gWzXsx/uIZKinM1xYSN3vzcOSX6qfHbK6Nf+7MMMpW2JHuKAUlcwWeDPIDh+Jfz67qUyE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISDrLiGVA0TBV23n9w1o4jv4t/uWmgt0KisGpStfjpWVMjNi1sxXDupV56xj?=
 =?us-ascii?Q?YOhIzTrG5Zjt36pOfZ66bpQ6UyqXa2TGXur5OsvTPMkG++cWhXTl5umAcBvA?=
 =?us-ascii?Q?JK3m2xg6cHsGo2ajgXaoi0B6aL97idJVlUvVbVOcOdyhNiAsQlE3nvi6W9u6?=
 =?us-ascii?Q?Wj31XWlO4tV4xNVV1VjIbNhUDDxLP23WqpPI7JxnKm5E17Cw0AQp/QNeqiSa?=
 =?us-ascii?Q?CTD2Xy74Cui/qLRxTe+uL7JFb4rabyxw8SvHHghFkVMoF0UOxEa6G3KtOmVH?=
 =?us-ascii?Q?+qrre90/BhHa0NRo+hCW6fINHB/qvT3wDyYIdUlMmaVFLn5eay1yGDTI5Djo?=
 =?us-ascii?Q?rrKCSZ8Li1pGWG7mK6QT1+ET5+JPuAvwi6w2ufRR6oCZ7+QWequ9Rfw94uSW?=
 =?us-ascii?Q?+KE9sGPDtUIf3GOa4zXF7MGzeWo13M2ZjL9MQBqADAcfD9kdSkDkPYsfGxLl?=
 =?us-ascii?Q?n4ORBcBNszE4viGGNyqOQdEO2fCkasMMN3xtQNUjLgnYBPVBICCQJUUvcHeL?=
 =?us-ascii?Q?6lcQ8GTIWjfAfOEaYcf01jD8IGmFJPo4n6InedRO9s7zp55XIVjJPMnYckOw?=
 =?us-ascii?Q?uiVtQ1Sh0NOtTvlwu0iBROLf8Qjk2YNpiwqXS6ZeqH88UpB+R5CeqXPCi3mZ?=
 =?us-ascii?Q?Pg7/TWlDLjhY2cpS3fxj3TxE0CyJ12LM+tQJLtwsDG94DHYv0F6X2cSiqh4P?=
 =?us-ascii?Q?zxqepybwO4vM70puqIuOaNjsfHEmKU0zFwqDcXl5XhC2sel+TGyqSVycZP5D?=
 =?us-ascii?Q?KncnI+4Q7yVxRHbAjv8aOnWXo1xY4WpIA/Il724uqLZgKfvCfjWW3P2nMS7y?=
 =?us-ascii?Q?KwJ0osPDrPOo+BglUMkVtQS8WVwb+sA1I2kDo2LtzZ5DDsPQr0NxrV/OiuOW?=
 =?us-ascii?Q?RtNuJ8jCQoyI4087ZNv3iSpMndHf4s2mkOlXnmUuBQmQCI029Dp93JVANRN1?=
 =?us-ascii?Q?0O6uQvxcJQz5pZ3qDeFkPQB5NncHibvD1xxjVeK32xHL/r2oyLDVhPHukenV?=
 =?us-ascii?Q?m2m8Pob5e0Ea/b0qKdcQGja40Sg8ZTp5/UenIacGdpBDFhoni1jD9090zA1F?=
 =?us-ascii?Q?iVpJ9pscIEdzqP2VvuNbV9ZUwbm0cD/PMd7NMAq0JKL0J/E8EepuHrOkZ1Xl?=
 =?us-ascii?Q?YQX+DiwKf8HmKOp7j/n4nlbxYJnm41+cvrt2bpqP1YBVrHVQgFQ97Y7yxlEe?=
 =?us-ascii?Q?b1r3+HtpDaF1jAk7FgNs+xSkj4dKSZi9qEuE3qqdFxtx2cfP903+ytqfKP3H?=
 =?us-ascii?Q?U6lBojry0on789p3HKRDLbpH3kW71cTs8nEqCL6UNfvBB0U2Q/0U0g0akK+j?=
 =?us-ascii?Q?6sz+qFmOQnXR5/GWP1Pv4LQ/QW6pUSu2SUTMfv2FTZsGxXktrHlk8jvp53iZ?=
 =?us-ascii?Q?qowLA5bxmN0VYDxhSHOHlQJOxIho7RlOlhqXOJb+xVOUiGA/leAVeQs/w9Ew?=
 =?us-ascii?Q?M1ejOQ2Isn4rriZqWhYT8x4qilxIiVEntrqjzRNrVrhQKx8UO2u0a9P7FZ4B?=
 =?us-ascii?Q?3wJhWhi3oq2fcZ0wqsrD6kwObdMJu59bdYYzRb3VgRQQOLBKUWcqfFuQytsW?=
 =?us-ascii?Q?s/MROzC0R7tspUmRC262mKfZkKjZmZvFX8oLwCrAfUy+o2W6bVwJYC4SC/4F?=
 =?us-ascii?Q?kpcZ1sNpD+/9rhCuc7d9gCIXaU4jDnMfOhuxPsm0d9/IaPR+GkUAMxid4d3l?=
 =?us-ascii?Q?ub75WHVPwM/igX5jHF8sJJdQAvzYAuRvTlxG29rfXJHnI4ZPSZrBt9s+kO5+?=
 =?us-ascii?Q?pPCY/PyGRw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bb191a-5c3f-4c63-fe72-08de88a2849b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:07:53.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed/vUYPs3K+rIo1F4601eiHQUxseX0T+4x/xVeAUhUf+FC6K35spYMsd2H6aIaNg9QR9zO2Z3D0hcuMlYzhYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9882

Each user port of the NETC switch supports 802.3 basic and mandatory
managed objects statistic counters and IETF Management Information
Database (MIB) package (RFC2665) and Remote Network Monitoring (RMON)
counters. And all of these counters are 64-bit registers. In addition,
some user ports support preemption, so these ports have two MACs, MAC
0 is the express MAC (eMAC), MAC 1 is the preemptible MAC (pMAC). So
for ports that support preemption, the statistics are the sum of the
pMAC and eMAC statistics.

Note that the current switch driver does not support preemption, all
frames are sent and received via the eMAC by default. The statistics
read from the pMAC should be zero.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Makefile         |   2 +-
 drivers/net/dsa/netc/netc_ethtool.c   | 192 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_main.c      |   4 +
 drivers/net/dsa/netc/netc_switch.h    |  17 +++
 drivers/net/dsa/netc/netc_switch_hw.h | 153 ++++++++++++++++++++
 include/linux/fsl/netc_global.h       |   6 +
 6 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/netc/netc_ethtool.c

diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
index 4a5767562574..f40b13c702e0 100644
--- a/drivers/net/dsa/netc/Makefile
+++ b/drivers/net/dsa/netc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
-nxp-netc-switch-objs := netc_main.o netc_platform.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o
diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
new file mode 100644
index 000000000000..8e5861543d30
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ethtool.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/ethtool_netlink.h>
+
+#include "netc_switch.h"
+
+static void netc_port_pause_stats(struct netc_port *np,
+				  enum netc_port_mac mac,
+				  struct ethtool_pause_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->tx_pause_frames = netc_port_rd64(np, NETC_PM_TXPF(mac));
+	stats->rx_pause_frames = netc_port_rd64(np, NETC_PM_RXPF(mac));
+}
+
+void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_pause_stats *pause_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (pause_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_pause_stats(np, NETC_PORT_EMAC, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_pause_stats(np, NETC_PORT_PMAC, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_pause_stats(ndev, pause_stats);
+		break;
+	}
+}
+
+static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1522 },
+	{ 1523, NETC_MAX_FRAME_LEN },
+	{ }
+};
+
+static void netc_port_rmon_stats(struct netc_port *np,
+				 enum netc_port_mac mac,
+				 struct ethtool_rmon_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->undersize_pkts = netc_port_rd64(np, NETC_PM_RUND(mac));
+	stats->oversize_pkts = netc_port_rd64(np, NETC_PM_ROVR(mac));
+	stats->fragments = netc_port_rd64(np, NETC_PM_RFRG(mac));
+	stats->jabbers = netc_port_rd64(np, NETC_PM_RJBR(mac));
+
+	stats->hist[0] = netc_port_rd64(np, NETC_PM_R64(mac));
+	stats->hist[1] = netc_port_rd64(np, NETC_PM_R127(mac));
+	stats->hist[2] = netc_port_rd64(np, NETC_PM_R255(mac));
+	stats->hist[3] = netc_port_rd64(np, NETC_PM_R511(mac));
+	stats->hist[4] = netc_port_rd64(np, NETC_PM_R1023(mac));
+	stats->hist[5] = netc_port_rd64(np, NETC_PM_R1522(mac));
+	stats->hist[6] = netc_port_rd64(np, NETC_PM_R1523X(mac));
+
+	stats->hist_tx[0] = netc_port_rd64(np, NETC_PM_T64(mac));
+	stats->hist_tx[1] = netc_port_rd64(np, NETC_PM_T127(mac));
+	stats->hist_tx[2] = netc_port_rd64(np, NETC_PM_T255(mac));
+	stats->hist_tx[3] = netc_port_rd64(np, NETC_PM_T511(mac));
+	stats->hist_tx[4] = netc_port_rd64(np, NETC_PM_T1023(mac));
+	stats->hist_tx[5] = netc_port_rd64(np, NETC_PM_T1522(mac));
+	stats->hist_tx[6] = netc_port_rd64(np, NETC_PM_T1523X(mac));
+}
+
+void netc_port_get_rmon_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	*ranges = netc_rmon_ranges;
+
+	switch (rmon_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_rmon_stats(np, NETC_PORT_EMAC, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_rmon_stats(np, NETC_PORT_PMAC, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_rmon_stats(ndev, rmon_stats);
+		break;
+	}
+}
+
+static void netc_port_ctrl_stats(struct netc_port *np,
+				 enum netc_port_mac mac,
+				 struct ethtool_eth_ctrl_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->MACControlFramesTransmitted =
+		netc_port_rd64(np, NETC_PM_TCNP(mac));
+	stats->MACControlFramesReceived =
+		netc_port_rd64(np, NETC_PM_RCNP(mac));
+}
+
+void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (ctrl_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_ctrl_stats(np, NETC_PORT_EMAC, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_ctrl_stats(np, NETC_PORT_PMAC, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_ctrl_stats(ndev, ctrl_stats);
+		break;
+	}
+}
+
+static void netc_port_mac_stats(struct netc_port *np,
+				enum netc_port_mac mac,
+				struct ethtool_eth_mac_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->FramesTransmittedOK = netc_port_rd64(np, NETC_PM_TFRM(mac));
+	stats->SingleCollisionFrames = netc_port_rd64(np, NETC_PM_TSCOL(mac));
+	stats->MultipleCollisionFrames =
+		netc_port_rd64(np, NETC_PM_TMCOL(mac));
+	stats->FramesReceivedOK = netc_port_rd64(np, NETC_PM_RFRM(mac));
+	stats->FrameCheckSequenceErrors =
+		netc_port_rd64(np, NETC_PM_RFCS(mac));
+	stats->AlignmentErrors = netc_port_rd64(np, NETC_PM_RALN(mac));
+	stats->OctetsTransmittedOK = netc_port_rd64(np, NETC_PM_TEOCT(mac));
+	stats->FramesWithDeferredXmissions =
+		netc_port_rd64(np, NETC_PM_TDFR(mac));
+	stats->LateCollisions = netc_port_rd64(np, NETC_PM_TLCOL(mac));
+	stats->FramesAbortedDueToXSColls =
+		netc_port_rd64(np, NETC_PM_TECOL(mac));
+	stats->FramesLostDueToIntMACXmitError =
+		netc_port_rd64(np, NETC_PM_TERR(mac));
+	stats->OctetsReceivedOK = netc_port_rd64(np, NETC_PM_REOCT(mac));
+	stats->FramesLostDueToIntMACRcvError =
+		netc_port_rd64(np, NETC_PM_RDRNTP(mac));
+	stats->MulticastFramesXmittedOK =
+		netc_port_rd64(np, NETC_PM_TMCA(mac));
+	stats->BroadcastFramesXmittedOK =
+		netc_port_rd64(np, NETC_PM_TBCA(mac));
+	stats->MulticastFramesReceivedOK =
+		netc_port_rd64(np, NETC_PM_RMCA(mac));
+	stats->BroadcastFramesReceivedOK =
+		netc_port_rd64(np, NETC_PM_RBCA(mac));
+}
+
+void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				 struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (mac_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_mac_stats(np, NETC_PORT_EMAC, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_mac_stats(np, NETC_PORT_PMAC, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_mac_stats(ndev, mac_stats);
+		break;
+	}
+}
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 2a7ad39f8bed..1fb5eca0e41e 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1456,6 +1456,10 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.get_pause_stats		= netc_port_get_pause_stats,
+	.get_rmon_stats			= netc_port_get_rmon_stats,
+	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
+	.get_eth_mac_stats		= netc_port_get_eth_mac_stats,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 7ebffb136b2f..825601847c89 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -70,6 +70,11 @@ struct netc_port {
 	struct ipft_entry_data *host_flood;
 };
 
+enum netc_port_mac {
+	NETC_PORT_EMAC = 0,
+	NETC_PORT_PMAC,
+};
+
 struct netc_switch_regs {
 	void __iomem *base;
 	void __iomem *port;
@@ -110,6 +115,7 @@ struct netc_switch {
 
 /* Write/Read registers of Switch Port (including pseudo MAC port) */
 #define netc_port_rd(p, o)		netc_read((p)->iobase + (o))
+#define netc_port_rd64(p, o)		netc_read64((p)->iobase + (o))
 #define netc_port_wr(p, o, v)		netc_write((p)->iobase + (o), v)
 
 /* Write/Read Switch global registers */
@@ -135,4 +141,15 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 
 int netc_switch_platform_probe(struct netc_switch *priv);
 
+/* ethtool APIs */
+void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_pause_stats *pause_stats);
+void netc_port_get_rmon_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges);
+void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats);
+void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				 struct ethtool_eth_mac_stats *mac_stats);
+
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 7ef870fbba4d..9be859d20675 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -193,6 +193,159 @@ enum netc_stg_stage {
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/* Port MAC 0/1 Receive Ethernet Octets Counter */
+#define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Octets Counter */
+#define NETC_PM_ROCT(a)			(0x1108 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Alignment Error Counter Register */
+#define NETC_PM_RALN(a)			(0x1110 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Valid Pause Frame Counter */
+#define NETC_PM_RXPF(a)			(0x1118 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Counter */
+#define NETC_PM_RFRM(a)			(0x1120 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Check Sequence Error Counter */
+#define NETC_PM_RFCS(a)			(0x1128 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive VLAN Frame Counter */
+#define NETC_PM_RVLAN(a)		(0x1130 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Error Counter */
+#define NETC_PM_RERR(a)			(0x1138 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Unicast Frame Counter */
+#define NETC_PM_RUCA(a)			(0x1140 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Multicast Frame Counter */
+#define NETC_PM_RMCA(a)			(0x1148 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Broadcast Frame Counter */
+#define NETC_PM_RBCA(a)			(0x1150 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Packets Counter */
+#define NETC_PM_RDRP(a)			(0x1158 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Packets Counter */
+#define NETC_PM_RPKT(a)			(0x1160 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Undersized Packet Counter */
+#define NETC_PM_RUND(a)			(0x1168 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 64-Octet Packet Counter */
+#define NETC_PM_R64(a)			(0x1170 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 65 to 127-Octet Packet Counter */
+#define NETC_PM_R127(a)			(0x1178 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 128 to 255-Octet Packet Counter */
+#define NETC_PM_R255(a)			(0x1180 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 256 to 511-Octet Packet Counter */
+#define NETC_PM_R511(a)			(0x1188 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 512 to 1023-Octet Packet Counter */
+#define NETC_PM_R1023(a)		(0x1190 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 1024 to 1522-Octet Packet Counter */
+#define NETC_PM_R1522(a)		(0x1198 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 1523 to Max-Octet Packet Counter */
+#define NETC_PM_R1523X(a)		(0x11a0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Oversized Packet Counter */
+#define NETC_PM_ROVR(a)			(0x11a8 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Jabber Packet Counter */
+#define NETC_PM_RJBR(a)			(0x11b0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Fragment Packet Counter */
+#define NETC_PM_RFRG(a)			(0x11b8 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Control Packet Counter */
+#define NETC_PM_RCNP(a)			(0x11c0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Not Truncated Packets Counter */
+#define NETC_PM_RDRNTP(a)		(0x11c8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Ethernet Octets Counter */
+#define NETC_PM_TEOCT(a)		(0x1200 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Octets Counter */
+#define NETC_PM_TOCT(a)			(0x1208 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Valid Pause Frame Counter */
+#define NETC_PM_TXPF(a)			(0x1218 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Counter */
+#define NETC_PM_TFRM(a)			(0x1220 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Check Sequence Error Counter */
+#define NETC_PM_TFCS(a)			(0x1228 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit VLAN Frame Counter */
+#define NETC_PM_TVLAN(a)		(0x1230 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Error Counter */
+#define NETC_PM_TERR(a)			(0x1238 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Unicast Frame Counter */
+#define NETC_PM_TUCA(a)			(0x1240 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multicast Frame Counter */
+#define NETC_PM_TMCA(a)			(0x1248 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Broadcast Frame Counter */
+#define NETC_PM_TBCA(a)			(0x1250 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Packets Counter */
+#define NETC_PM_TPKT(a)			(0x1260 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Undersized Packet Counter */
+#define NETC_PM_TUND(a)			(0x1268 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 64-Octet Packet Counter */
+#define NETC_PM_T64(a)			(0x1270 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 65 to 127-Octet Packet Counter */
+#define NETC_PM_T127(a)			(0x1278 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 128 to 255-Octet Packet Counter */
+#define NETC_PM_T255(a)			(0x1280 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 256 to 511-Octet Packet Counter */
+#define NETC_PM_T511(a)			(0x1288 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 512 to 1023-Octet Packet Counter */
+#define NETC_PM_T1023(a)		(0x1290 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 1024 to 1522-Octet Packet Counter */
+#define NETC_PM_T1522(a)		(0x1298 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 1523 to TX_MTU-Octet Packet Counter */
+#define NETC_PM_T1523X(a)		(0x12a0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Control Packet Counter */
+#define NETC_PM_TCNP(a)			(0x12c0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Deferred Packet Counter */
+#define NETC_PM_TDFR(a)			(0x12d0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multiple Collisions Counter */
+#define NETC_PM_TMCOL(a)		(0x12d8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Single Collision */
+#define NETC_PM_TSCOL(a)		(0x12e0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Late Collision Counter */
+#define NETC_PM_TLCOL(a)		(0x12e8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Excessive Collisions Counter */
+#define NETC_PM_TECOL(a)		(0x12f0 + (a) * 0x400)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index fdecca8c90f0..5b8ff528d369 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -5,6 +5,7 @@
 #define __NETC_GLOBAL_H
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -16,4 +17,9 @@ static inline void netc_write(void __iomem *reg, u32 val)
 	iowrite32(val, reg);
 }
 
+static inline u64 netc_read64(void __iomem *reg)
+{
+	return ioread64(reg);
+}
+
 #endif
-- 
2.34.1


