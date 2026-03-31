Return-Path: <linuxppc-dev+bounces-19079-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D03C1061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:30:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQsD45WDz30PH;
	Tue, 31 Mar 2026 22:30:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956624;
	cv=pass; b=d/gB0xonXfKm4E9hZfCkvh0NhcrmtAg3zhBsFW90hBK+eCmo2AV9kyOz57zVI76R9JoW2mtVryyYZsZ99KZpV+42Qhk/jJx1GNV+p70k14k/NJoUY58N+HHfBSCHjAVWgmqMUuxNnK489k3II9/upEoLkEQe5EQ5KOrKibMkSilzAKtL/iardfqIWIkvC1r2W56jYJbOMPg4buMo7ZxdPfb/GW0Y5cMHEdvdlNbXv+pUddBk3w/drVm8SoBb7K3zYkxGpPcZA2ZoLMew+mCx/mXd5PVuIRtq+8FK/jd/H4KgIs62ULcbuEjPskOWEzkTlgKhcq+U1OixwRK9g1cbRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956624; c=relaxed/relaxed;
	bh=e2TwZNQT5dVu0QviOYnzDB6X8KdgYArcaSu/jVi4XbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ON8anRHrrnUX+lxJwmEk1Is7mVVpWDxp/+0+gxwqNBpqL7xhIzaRBGSn9BVwqmz3X9dYCTtnmhdlvm2GymFwNn/moZv/HBnOxcHhJDxNh1D/OQ6gdKZIvZ2WxBPOXsNO2cmGctczVtHD/ax6bO/+rinOKRS5r7cOvu3/2dcVnuQVZKulM7mH6Dq94qBGtVG3dDZFn11zH2FM+qcTAei2STh+yU1XrzC13u306qPztDpzd7Z6D2jsqtWu4Ay0QJ/b8/3R54fHLotlMtZubmBBtXH1KqqEB5rizEDkXtROq06VFzkif9vC4rVdaX/wUhs5IPHBD2TMYHylRWFPJr7meQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SMfBrQpF; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SMfBrQpF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQsC2BVkz30HQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:30:23 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUpdVBXIJt4fvOoT9+5dqueAtrX98PEquqPntOttE4Mh/sddw4j1JU/8VkZVf3Ba8fJbIitiYUGmdrg7YOeO5znHWAwAWM6+6oL4c+qkePdCgYWmwnwIiemfGk3/oUn/630whzbjg76pz3ycRpnaKvfIwkB2Ejxp29T4p0QcesgJuYwkqE9A7QgMvxSvvmSYhtCN3a1lETregykKXuMe3vB/jeFxge77CsfdZbOUHQdbdP6QD+/9NY81n39qSIlKxqMe+oTpVfiuPIPc0LdT4nUTDrr+H6XBev8sMZgKj55Pe/Ym2TCqyhp5M48G4ag9zqrUW+/eNhDbnzVfDzn1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2TwZNQT5dVu0QviOYnzDB6X8KdgYArcaSu/jVi4XbI=;
 b=lJydY3wbtR4V+Of7/2a18XMJ8jw8p45MwToqqHW94XItY7mf5GwAMlUAYWpnEym7V8onmROMy7MNLzpMvlqDuXqjKdDBHLLqjs8YlnaLUS5seP5hR9SJNsfjOzvRUU/3QnQc8nocTxTx3SRfTzPzmjzRImYSnm8WTS5f1ghk7Ac95VtW0zqKqB9MAMNUrbjDgk1JNzVarAfeFL8dwlcoMBxUBBlhqsU1tl11lK68sbBhiV5yH/KEbbJclkTOzq2RvN5bqBgfOKHrnirZiEDoROSoLc4nHq8ZjKLTOiG7P8rL4kzHW50r3r9d8omum1j1Lj054q262dHMQg2PqKvOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2TwZNQT5dVu0QviOYnzDB6X8KdgYArcaSu/jVi4XbI=;
 b=SMfBrQpFPpFx1ISaL5BnRYdH07cQCy4qDBqQt9p6J8+ZL2fHX0H+Uspw4BiU62hrHvYiKCgph8LtuuY+6wQ5/QNX2yA90VQGR8J8hhjn4Oz3J7RbOpFwYARp3UBaFQFM/Zrva76lOv3HNAyLKLR9eIGyWXdFR3XlqPb4OpenQNn2UHj/iprVnqo/bI7kQIEySFGYbhoK58jlKqx7x+d7qAELnmMF9r2E5Q5yBaoHvtOA4Cb0tV+eNL4rycZ3v3v1v+sf/XWw4m5G7Gk43IZqG26/YxscyE+hARUnWhOV4HgeIsi+JmV/GtH/LuDl0p5WwW+LHq21ZogclKFWA/A3wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DU4PR04MB12064.eurprd04.prod.outlook.com (2603:10a6:10:63f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:30:11 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:30:11 +0000
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
Subject: [PATCH v4 net-next 14/14] net: dsa: netc: add support for the standardized counters
Date: Tue, 31 Mar 2026 19:30:25 +0800
Message-Id: <20260331113025.1566878-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DU4PR04MB12064:EE_
X-MS-Office365-Filtering-Correlation-Id: ff31cdce-a949-4ac6-c13a-08de8f18decf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S0mbtYY1YfTFTVbLUB/6eRdJzxO738mXegy5n2lnSQJ4sqE1XyTCKKfl7rQ3QwhRfd6GfwJy8hJF3F9KtdA79MBEYACEzig8/JmIEHHWdAc20/l/THW6gpe1lFLlmqVsKVbfYDoVOI23VcBmos3ZEVEuiwQY40Khr1P7qZ2l4oOvj2cGVOjXaiQdi2Hmk79VZ7P4bok+vjomPvWQD0A7RnSHTcACjCrUizu7/Pl9XMlqcYh1fDDOk4CYujdMQWjrZ/74Kg3QhhMpAUQrz4iUVVMKFQoD90doyB1i1+qnin7xVOLerFXS1uJQVqQinqGyMvRF5qOqBoDLuo5NgkxHtpltrZZTEuusvn6SaNUrU3o8SZnS4EldIh6RJqWKhWkRBXEWRqvgg5wEIy6s/DYDHyDpowpVwkzAKO8jfx8MCuZzGbrsxcoVf7vilfgpCzspiPCI3Qp7UEaqDiIK2O4SgdHO9y9KcJ9OonfbX+v7gZJ0mS/k3nSyKxOadP6icoPk1X+t2EwZ01477J+FTTh2BEE+qpVCwk3+Bf6IS7sFZvPgy+mkT8/1n+R6PW+ot94o246R7ZANSulseN8EtU9oVTKlQ5M8+Jo0NuODAi3Pk7EptwKNSVqA9dg9v337O8q9ARTjZ4JthS6c4Z1m2xkim92KiV1p5Q7ZTlOyENpJ2rqg21QFHByYGIYRxJ99ORyRnVlI6JsLEaaLRvmvqkGlOjI4pXjpbuRNE7sCaYQqQEq6/opE32REmcMoxF88ybFGhycQPNPItFflZOh92pGoAi3HfZGezHbLWvdsVjLJtui3zdea6nDFRXJl3a2cJgFB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bAVWA6tQY5LvpOfLrm/d3Jk6jLXK8T9WyUCKAO3iuzLNcNhqy8lWmFbPeWJn?=
 =?us-ascii?Q?a0jFVjSkJztxUT0fQNDHXkoiobw6ZfBFxy9MUtBfPCmfB4P/CgcD5DUV50e3?=
 =?us-ascii?Q?Jw2CPL7zqddZ7DKfx1gExo7qSIiSYb/YD/hssRiF5P/2Cg8qj+S4zr9q44HW?=
 =?us-ascii?Q?OeqxqJknspLWj+YejV5sKjloucsmgCE5A90E6UETq1bPRhP9/CKgyk0yyvCh?=
 =?us-ascii?Q?nVzheFxWAurQwxkZdwRa5lwc44x6dKnb42y9OX8dS3a5aUqTYE3q1r5XwU9L?=
 =?us-ascii?Q?VMJ9v/31s/dG/f3wsuA+H+j9B64ljiq0Y0XXE3fXUq9yHTDe3T+81zmZD2Gi?=
 =?us-ascii?Q?5j6kdDae/JENzjJtb4iDF8RXhGkSTOdXmBoO8X5NHlOA0UQMWJEquxhWq5u1?=
 =?us-ascii?Q?dTiqnW4W3dE3nZlYBZpJp7N7KkFJmQRxJSepHU/a0DKmPxauLGV7vOKRhBE2?=
 =?us-ascii?Q?d9iMeusTih/GcfFvca7IZwZFipDjZ1dOxVhDJ7OlTJq/V7zLg64KQ4ODRh4p?=
 =?us-ascii?Q?7/2+XCjE3vR/DDlS9i0eGspXpkRJePI6HNKNqMN69W77z3xUokWs9MueWdM0?=
 =?us-ascii?Q?3IlLNyvJuMTUCk5xdEiBxQf/JX1qYr3DEWepSGDVC9eBGnjT7I0/EEYGhPHH?=
 =?us-ascii?Q?GutjiDyA0bIC5gXmdG1noYoaw9lyX1XVmIRt27fQF6d3Az6i5lZnc9juQ4bR?=
 =?us-ascii?Q?K3hZY7gX5j8jmOoG/y4YJijxWCNlFmfXtI/1hiAsZd9rshUqoJZAbmmbckeo?=
 =?us-ascii?Q?TXt9z5IQ8JDJ5HYj3zaM1JQamXOV7P8Klvlw42zpZ+hL1YAHLBacjEym90/+?=
 =?us-ascii?Q?MDPEHQUThcXzUY/eyea3cEu1AfdBfEfjcPpBpfjngtWVcnF6LPNlXO/uCF9C?=
 =?us-ascii?Q?PvDmImX5DeUS6s95GDwjjuK4SUlRapzayTQYReUYxrJ7S+3qcOQ5jJBvSrUN?=
 =?us-ascii?Q?Gd8M4HBhHIoAv37cxVcMrTnsV2eW+WLRZQe+uKwG+G+P1L3VU52UA/Er1O/S?=
 =?us-ascii?Q?3erYWWhHYznbqA/+oukem98b75958YHlNnSLpba0E9rQrdclERZcSDdWNhag?=
 =?us-ascii?Q?F0CQVY9H3Ymy/DrUYxauTL1XqdmyduspFSWHmz9308j83+LvUM3WCXCB24Gr?=
 =?us-ascii?Q?2hteddQiLFtD2BqDxIkpyAvagQSgm8QsT0oiIy2WxND1FtJcJu1VmRIpTc6/?=
 =?us-ascii?Q?gfaH294Qjc0NC2mjCL1MgIgmjDf873LPQeJqk3imKdsKSeTkulQEgqJd3Rns?=
 =?us-ascii?Q?nqhJ9Cmxe2KdFCf2h1d821KHhXSgSnrcJn315mzSS0MHyXZH2v2rQ+9Oo/CM?=
 =?us-ascii?Q?6RlN21rnnsz9Ms5ykl+zUy7KW+7DE/1G74zXJ8UjKl5q5hJgL7z8nUj7awXQ?=
 =?us-ascii?Q?Nuj4N8Oqq4yi73BgLaSJvI5sIakQVG+AIuEpIL8RgO7uC/7znywwNqE01p8/?=
 =?us-ascii?Q?ipcVvumTwnYSQKkMVMrkdmiogstVVz22h5p2S/wlSIwKT7jC+ejgMcU2AD7x?=
 =?us-ascii?Q?ksJeN9amerGIzl6V99lMgptW9k+rgy43/cQTQ28uH7jSOnQs/6ZwzZkaBP/D?=
 =?us-ascii?Q?ri9dlz0rILGUd5bTQc98uMY5gdlbDBXSIhdEiMMHjFxVC7W3x/ca2YAXwuXl?=
 =?us-ascii?Q?JXlmnVAk9fAX4ZvjBm6McRFmET5GDBtSTCqd0xQmWOvMXOPYLzKt/y0p5Kak?=
 =?us-ascii?Q?IVcMBxW0f3wi7/ZpOxas2Z+cb0yAZSWGzNbvzOvb0gXRRzmwjoOoplT5tB0R?=
 =?us-ascii?Q?2o9YA5W05A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff31cdce-a949-4ac6-c13a-08de8f18decf
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:30:11.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Txq6RG3YyRGNWVrFxAfikt5ikdgpD3DokEuG6vqb8KOIUJV7odUWGOBO06/NyKOajKb5LERu778ddUG/gE01PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12064

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
index 688dceb486c2..8e58884139e8 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1423,6 +1423,10 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
index 1e1c0d279a21..05a1c3e239fa 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -172,6 +172,159 @@ enum netc_stg_stage {
 #define   SSP_10M			1
 #define   SSP_1G			2
 
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


