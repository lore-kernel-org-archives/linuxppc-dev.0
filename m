Return-Path: <linuxppc-dev+bounces-24931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FD0C531F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X9d6v84z2yv8;
	Tue, 28 Jul 2026 20:43:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235381;
	cv=pass; b=lC+u+hknTw8z8s+Vo/0KIXa6ZhnpK6ri4JNQt6/1klcStE6VV4i7rRDldyyuMRGF3dVPF1x2IuzEMXBU/9G1bJcNpXMBhDMh2RTXz8QqJgZ5BqHzRhTX/26E5bEGcncNByvXWMHpWyauHgZCAt35wyG3D7dQE+knEP3dxzRlgx7Hk3bUBcFk4fbcWI4l7FIiAi5n3gncKH+sLEFxPg8pwmJnMkeITE10N5jzryc/QcRq6PI2T6Se3mSTiqt1S2Pd3neRvqFzq6gpECXuBUQlbUPczTZcW/UnETretFzJMQXH+R6azAlqZPwvxwogR4WzwhPuS8721bDZ2m/sLE/0nA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235381; c=relaxed/relaxed;
	bh=MXUUIl4pS7adZMz3Xv2q4/G9v9CFQCk46ZxAY6M4Jfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3tiUsskKQ2caNQ/CjsEDTpOqCxEYi+df4eT7BOuMEWJPDDJe+tGWhJGhdSYDYvFwKAbpO2iz/U7b4co+3B8S6TEMq/KOMrrLDArSK1lcYQsSMPBu72NbJhFJ+gmmA1AJXQZ5PngsABCw8L2pIXX2Pfhdlai4SXdRf2HsVd5KCwi0IEaxOazSYsVLX9EqD82WPkeibn8gj61vMPknlRaQ7YMXi2bUKnRzv7BnyryOq7YuvXykgKsDlGaGYWp0c+MHJKOXz6xMGWo1osiiwb50XR5BKm54ZWo1Wht+aP9Wn5prhViJ4JITFI4KpIWWpWQmJaxwy6MSzngNafpWU90bA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WROo5FG6; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WROo5FG6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X9d1LX1z2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:43:01 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT+H3nzP+WpPIn/6YZciOy3TW8ZLgu3OZzkZkB0EO0WUyRS83QxJuI/IyrtdhCjOmj31xwMxC0gFjmxJ+8oPzQ8TNb64fhPZlYqIgNCVjJJ0ZD3ULbNwK7dobsRycWJ+IIeHK5kZlNNOX95W8nWuZH5LUWiai//HpmrLd97o/CmOUnzgQbCwNVI92IfIAKDE1QVhmboocmAF+bMpYWf14m8sLmANQujpdd1NCW9tMYBPWrYW0hfMii+vJbkB5pWAjy848nK9PBiOtpUdqGN57roOzoRmGj3g2FwIeEZnI9RgLFV9e+pWrkhydlySDEzzizadBO3P3QTGIAXyZybhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXUUIl4pS7adZMz3Xv2q4/G9v9CFQCk46ZxAY6M4Jfk=;
 b=kGxV16wgx67kaKurUM3PdGeEM6//soZ4zmqxKr9+EwCxqt2/phuZFogT150PGLLlsiJa0xBcnoSkdsx8H+pNzPwerOg5lKPy1Wur3huXjJa1+VU4PzGYN5hc+WvzDIUFB+wto4OaYwT2s7bbBpyAF9J9fUCJItsY3+91qug27VEUJyd92XbPkA0AyWwo/3lfUrmP0T753HMOCdHrY7pPx9Q6uDbGt5cBxox4lRKzz/39cQb3osd7WOnf3WOX88pu7uafFAvtUo20/Vy52rpyN7opZMZYfLQsZXzHVv5oZpNkCVNCTg9eZIVwq38oC/c8Ngyl8jpcdh7aupsgQQR2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXUUIl4pS7adZMz3Xv2q4/G9v9CFQCk46ZxAY6M4Jfk=;
 b=WROo5FG6OsMpYlnrCCfrl275XYNP8mFUskNQ9N0rSKMMjdEC6OuS9JXKDrblGsIVdtDbsm6wxFpOZ+9q7dnCgEkqDmkUM/DKd+c56SGy0bi5SeU0xlJnAfpVKuY7kK/ME2XuGOOYya7tX2VnkRXZkue1p1hQb+Mazs8uAFPqLB9NHMY6olnaJleOrzy27Icz0UksPA4IjxXJN6ccPTLsZApEXeDZbz2XLgFT8UxrfqBJXZMvzCIuTOOKnLa7xq7eDqxzf2WWnjUegtEATctgnsC5dA8O4O+6jZq3t4OT6mcjGieo6BJnwFmJA5OZYKlKzM5ImjLxtw31Y53vkTs8Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:42:21 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:42:21 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 3/7] ptp: netc: export netc_timer_get_current_time() for cross-driver use
Date: Tue, 28 Jul 2026 18:45:44 +0800
Message-Id: <20260728104548.3301214-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0ab3fc-72de-44e2-dac1-08deec94e741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	6YiFhK+Qd9ZY2UoTQziiruBHGwWdse7ckAb/1sc7dV8P/5kH2wpmaC5bPld/MNcPbjeSexRgfTjGYsDp+txs4/8yhBUEsvHYOBlmlqtH0hORMNS7VJ2xR2THtn7e2WC2Szgcn1Fj6qEV8A5MugVTO8VXtJtdgX9VxtsGf86/j5GKPcodmoedlIIgNAwQws4uvzawO2EOlZOOitKl8SSDxeT3lS20CeiaIl0BGC+CXKatcg2rp88i6sZ3usnjp+/j1mjnjxpZStDTvgGQWiKrXrCuoSVLDJrNo89Ni2DO9ipucRXc6+Zer1sfAqGYnkT0UEjg2WqpocTK0HKGXNvvS9WIIsOKsnCAwKmdisr2f/IB7hUAFyy3x1i0G5Jjme10x210Kar78kn49JY/i441F7En9wphsu5cW3LHOq5I/AVGdtEj8StPeO+u5v5P7QTjxXm0riaFofuXXIeI/ZAUYI/Lj4fQguTFz3xwB4q9mhX8Lg94gDYbxqHzh6TFTNZRmICmWt6OxaiWPo1R0FokZZenKqfdWBQuTLVKcDiQmY446fefIEkqT9ebs6CFmEJLLOIkMyfNE34WKTE4scvZyzDgEY3COFSJtuYc0EXXOhDmy6m4wMPFFXEvJGzwgJj+Mj7dNX9E1uRKHamFtW+zLZ7ZTwiFvsddhkAs5nMQXfYingEIhBv2MNYK/dmsopARAMnPAUkQCD1zxrdneaBmvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6aQf1rENBxESl/Jjym9vr60nesiQei6gfBTN/qSR/i8oO6Noa0oO/MFfEBO?=
 =?us-ascii?Q?mYeNhzug71b0hS2DLv8a73sAsQYpyHvWy8V30XMd5NRcNp1yi9ONAZujGiRV?=
 =?us-ascii?Q?AJ9TJDFAGyb0o6pGjC6VK9szhysdcrKaTqVS0docqWmWwiVuT7Gbvqnav1S5?=
 =?us-ascii?Q?y5zQ2hYbxUIfEI4EiLmIDN7zHFn6Q5JX7VjoedAP+A4YBM/C3aOgQTrWmenX?=
 =?us-ascii?Q?HM0MVs6r/ukVTDDmvK8MgIbHVVF93QXjSGatJBb53RQE6jIB/2/JhOnfMuVh?=
 =?us-ascii?Q?TagV6UzU0vzuAd9zDyS7PYd6FVWW/tDXev/0dQ5NkINziv4c8Pv0pcHWSzry?=
 =?us-ascii?Q?M4k7/0vjyICdI77Cd3wtnnm5sn6XSw3aRk0WnLAo+ZcKQKkTu544U7zAJGxy?=
 =?us-ascii?Q?203hCjMBveQLwY5z9z21qBFgfChDJwaMox+lCuMN5/RptdbWPWzYQhadbXNB?=
 =?us-ascii?Q?s8MrUT++JQpzdTQAVazSq7UXLC/DT44gUNBhm6X0qvr4lhe9mncGFJkvddOw?=
 =?us-ascii?Q?z0DILOU+6olTpJ7PE5lxRS/BKDdyilOQO/vvYUZalv3gk5Rl0bn/WMM3Xe9x?=
 =?us-ascii?Q?vsxAs/ai/thwUN33Egm1iJTwYcynG2sRVjeisdNG6SRLEQ3eIQCzN3ygwMEe?=
 =?us-ascii?Q?gfhZr92uRBqzivPAeXo3mhqBeFmo9lwHS9Iy8NLlFzxRA/z48nBrj5w2gkpk?=
 =?us-ascii?Q?Hw9GbNiKJamDxf3BimpfAX63vQy6uBzJ/LMs5UIs/EVZIPm6+swSDhD93JDi?=
 =?us-ascii?Q?XRKCPk+xJeboedEO1AHTFRewCNa3hr5PnFIFscrGxAZJQ3piQWCe4zFPBynQ?=
 =?us-ascii?Q?QZU4HEjTAx0skn2X8YZOL+xfK1nIQP0rVQXnKeNyru/YAS2x8CwXuHxqLeBZ?=
 =?us-ascii?Q?/oT06a9qIW9zydU8WqMGr8zfO1FEyOldrPfkR5/9oqORxC/tV5Z7bnR2wkPX?=
 =?us-ascii?Q?w27gE2iwMPF0D8oPrs6vktARj6JVL7CJt7gYrnT4RJnXhNX1Sucd1UTxYSTc?=
 =?us-ascii?Q?DBxH1cY/TMhzldRVJJ4xB2t6FyR6opzmsJDg55Gw//Pn0R/3iQrXgpmsa6Ht?=
 =?us-ascii?Q?1IJK4GzFu+IGhC1vgHlwoqRpN/5qVj/wCREDO/JC4B5Z0nzB99PKDCCjFTuc?=
 =?us-ascii?Q?EDxxKO4MdMdleASw9slqhHkCVaJQiDV20yJlzreX7vNKkCDA+0TRR0hzoA/J?=
 =?us-ascii?Q?x4zjQVwOBMgxdGYS+KWnnt7B5IhT1T85sZ8rtQXJrqxpK+sEj3dGhkSv+qNO?=
 =?us-ascii?Q?ztt0uOQK0EaxIPgA7noFcbvn1N4DswhB//sX9DBCXGWQHnZ7UjFR0a7C/XMG?=
 =?us-ascii?Q?HtFkAa4xzOovuwdsE0AB+Pv/9lnSico/XinG7DsZtG7ncjkMP2QamPwXgopK?=
 =?us-ascii?Q?h+Eg8wUgTbJjQQd5RCRab+WYa/hOTExkzzlLUQG/RkQow32uUPNJd5Yz5fT2?=
 =?us-ascii?Q?DzTZKzgzpIc+8h4M1LzpvTKaGVe8/iZzX1qWlEBM6NZvEfCFUDYMYnsyQAop?=
 =?us-ascii?Q?P3/FZu2R+uAedRqvxU3l6OIXkw71L6Zg9CDevIXhXuvT601eh+/0SebuPG+9?=
 =?us-ascii?Q?9QEbjwjYPOruHSp4uoVW/MpYI50G0pzx1ofeNpyGW3jHRqyt5lkf1UnG/YPR?=
 =?us-ascii?Q?nTx+JU42y9P4TToox51CTMFGdUumRVmGMvTZTzNLhuHSZnAFbctgccnvVSpD?=
 =?us-ascii?Q?vmjlaeEOoaUSnXtkZeTCGJ94MEdaLgjO8hLeEm1UgbiRd6+s2mrLuQ0K/tbM?=
 =?us-ascii?Q?kLVy1p6OOJ3Ktp7q9Um22Nxg6ZkserT79sS4+rNCNvr0rkDuzq0Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0ab3fc-72de-44e2-dac1-08deec94e741
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:42:21.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RYIiIQK8PBDtJChMbBVS6F1ZY8iyNtdNPnmOw50QbkH/OywUZnNTaKjdRBEwNcdzLRu+x+cGqqM0mW/bbC7NUYHiVUd6IMwx4jlOCyUucuNMxEsRfG/tc+V+328fR1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

From: Wei Fang <wei.fang@nxp.com>

The NETC Switch does not have its own time registers and must obtain
the current PTP time from the NETC Timer bound to it. Since the two
are separate PCIe functions with independent drivers, add
netc_timer_get_current_time() to the Timer driver and export it via
EXPORT_SYMBOL_GPL().

The function takes the Timer's pci_dev pointer, acquires the per-device
spinlock to protect against concurrent register access, and reads
TMR_CUR_TIME via netc_timer_cur_time_read(). It returns 0 if the Timer
driver has not yet probed or has already been removed, allowing the
caller to handle the unavailable case gracefully.

Declare the function in include/linux/fsl/netc_global.h guarded by
CONFIG_PTP_NETC_V4_TIMER, with a stub returning 0 for the disabled
case, so the Switch driver can call it unconditionally without
introducing a hard dependency on the Timer driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c          | 17 +++++++++++++++++
 include/linux/fsl/netc_global.h |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 6fd62e708fdd..f2b77bd5af01 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -165,6 +165,23 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 	return netc_timer_rd64(priv, NETC_TMR_CUR_TIME_L);
 }
 
+u64 netc_timer_get_current_time(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+	unsigned long flags;
+	u64 cur_time;
+
+	if (!priv)
+		return 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	cur_time = netc_timer_cur_time_read(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return cur_time;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_current_time);
+
 static void netc_timer_alarm_write(struct netc_timer *priv,
 				   u64 alarm, int index)
 {
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index 5b8ff528d369..91441cb35bc2 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -22,4 +22,13 @@ static inline u64 netc_read64(void __iomem *reg)
 	return ioread64(reg);
 }
 
+#if IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER)
+u64 netc_timer_get_current_time(struct pci_dev *timer_dev);
+#else
+static inline u64 netc_timer_get_current_time(struct pci_dev *timer_dev)
+{
+	return 0;
+}
+#endif
+
 #endif
-- 
2.34.1


