Return-Path: <linuxppc-dev+bounces-29243-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA6CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:55:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CWY24mCz2xwZ;
	Mon, 12 Oct 2026 20:55:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798921;
	cv=pass; b=SG1E9NhG4vN12rbT1+8SjyxpLoaTh/Cm+MNkLe4J/31boRaYPdGYp//4G3oftWhguQb3rhqsGUGZ8tOMJ7Mgv4U/CA/nXj8ho68LYo2QM//arfbytjXfObSunm8NyD7RAa9o7M6dK1RlZU0eh5e258mWAILQNNG4Z+PvLcRuEc6Qoih7cLav6EVX1SM5bMkZrVMxW1GOAiokcn56InTRAp4c3dWqWTXCyXTJtMA2NZsr0AQZAVw69qDJAr4Jr28DxYYO+o9mbhXGRYfQ/jMrdZ+LaKW8tUpi32yTVT6zVbsCG0di8MsvhYPMvz+G8gCiINWYEfHczrdaOKTKDzrzmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798921; c=relaxed/relaxed;
	bh=WwlXh3LktFHI7zSBsD/SZac3qhtr52wShddo+pQGDSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZpq2SucdrRR2bhIC2ehqZqMmJ3LxS+DDPHuqloN9rsFiqelST37Xh6fqvowt7S8VPD4EFpFCMFgYS99oNN3LtrlN3k86+Z1SnGi3iKp4pfNZUaA2gWpxxlTWYnAfLKsNr9WRBi1oaE025xZ1GbMCAxe9m83C4AXE65SofNcFk2j7eNvxc8+AVHcpztuFR80AD3m1ixXmKHXniL7fBHvJ5YLiqDW2wLBYbwkbPGpgj0dXK4lStnsRmcDFIR+P3aFGKh5g83XRqFw5IRDWEnTI1bbjYD7X2R4UH7t+ZXzFh0YRQjZSTgckDg+ztR2aLmRNJcn+8DOUaCID0yDKmkHAg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=J+0GdSF0; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=J+0GdSF0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CWW6ngcz3bV5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:55:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOhQizyfyNA92c+VfzrCGtok6OsGglfZeeenYBPOmtrbHGkG8l7PGhYHE5cu52W5YbUfz5NFgGU9TV6WMXHNvBHqHGZglTZgbb8t329PsAhHpudLr1YBoBbMKpvnU+JWnXfSTJ/NzYaZd/Ux69AP2wiuVHumAccKtXi1OHPXSdhT2oDAFTHsO2WXZJqEWJDloAHSQhkuT0ajhqgjQAPJBZuXAaECF1mJBETOPlp+CqMVhYbVFUNOoeOxIleGtCg04Vj3BPLEYmWSN+a45bx3SzRkWub29OGTVZs4qHn80hL9A3+3gys39C1TAGZ4I6OeZsebHWRYfxRyraIMfUeXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwlXh3LktFHI7zSBsD/SZac3qhtr52wShddo+pQGDSs=;
 b=wh5vTHOj9sCmZEvZ/+9khlYXtinZvYg1qhfMSaGFL5TeOo+3yjV6yR0IhYt9ojbUBsRBFNSq3ZzYux5GG0K2SF4e3+noM0s692ecScog1WJjc5N+5YouJVt3ol8kWQWVTxayvBU9ZzSlXqLFJkl7gTagUmkdpvSH7v9Y9fPV2hMvvF9LOfoY1dinCOztT9L2tuRIHRcx+tNhw6THAJJ6dr7l0x+ZF7BZHc+31cAfpihIiy6Hf9cv66Hy2VF6+R+6uTPR1r/DMKDAmVDjovNY/1V/eCDde8/Z9o7OlKv5kNgdhaoMK7ejXT6/zUufDLQSzaCFZlF8GxK+y9SGT96bkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwlXh3LktFHI7zSBsD/SZac3qhtr52wShddo+pQGDSs=;
 b=J+0GdSF0vGrCHKVcjAtmXc7FuSzTEKgTtJ9i2nQ2vKRllabJPoAbAMlraYYUB3bCrxC3gvsv/d4xbyjBqXuHifh4hl4NH8cSRnoEx4tnN1y/ziIR4SIWW1CUb2XovfngGGFyr3nxP5NG45XN5ELbUcN9OSXG0liqUMkxZyN0/XKjRH3a/ALOanLt0aH2kWqsFl8sDXkYSMdBGIwpZhZKZcvHOyf6qH24TF4d6QNwoa2ht2sa2OmKrKPRWUhWIDv+ql5GxuwQx2zBUpMRtuac2OOvjr/mDHF36a1lzjudjCljQlRLEusPAzRPx3MPwI9eWhRzy2SK88iEJtpX669hJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 12 Oct
 2026 09:54:59 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 09:54:59 +0000
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
Subject: [PATCH v5 net-next 1/9] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Date: Mon, 12 Oct 2026 17:59:16 +0800
Message-Id: <20261012095924.1129312-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBAPR04MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cee79cf-a9ca-4c62-c759-08df2846e05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|11063799006|921020|56012099006|22082099003|18002099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	jGNrz9yDep7RV1JTJOVoCNI0GH35vxXKyGOsl81jO1PG8qT+nLrZbteOBK19wRm0VaE8gynYGerbThOfdx9J4pnyJOp6/0hRlAUxNNTxSER6VS+ifzYNp2zS+fRIZX8/ayMnht3VMBIE+wHk6O4ucYFreSYe056wKppJE5zqU98UY21FUne1+fbES2wyjEOF/3siGlm88KOFYIpYcvJJIcn4ly4nrzbxqUxXT3acWQxVaSaVtZfGJAZwHUzTmMnOWjaauRtZwb3KehkIpOoSMn1+nRrYEUqQ20s0ozdYBq1MXcRvcchcgSHD7Zk1vgnEUMsjhhyuDRLyxMP4XePaf3s1KLUaCYcaPPKoCRpAGj8ibW94sdpqbkgoTYq8KKvU3M7czlVx4AFDpUc/65eJV4xcAZ9oZpQ2DfPx/U7j2ekFuG4D/GC9r9//tJMy0KbuvS7li1b8YfCtS5EhZ5NhQC4Ey11VKxPuayHEjAeq4rwk/J7uN3zdAGPrzABJHb218+gDUuB7ubeP6f4wRkFawoTxG4BMcwWlVFFZ4YjHZw/oiqh9eyB2XyoQU9Gc2IC6dD1zwPNZDZvPJiLeJBmQyGSULmumCR6k3p8AH5Hn0SRCNA26vu1TJbzn2GYQuELbFNYCLnJULnXi1tvncL1NbEDUpCVfX1Us6ETP1aKxOu5EZJW09jY6b6BsQb25Xdhg2pFhFPaf48lAepVduOMG2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(11063799006)(921020)(56012099006)(22082099003)(18002099003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9EAgsxjodkrjWuiUeWp864uyOv3doA/wxe/lQSzUDBilZQ4Vsw6nHWHUXKz?=
 =?us-ascii?Q?oATDMv/g8pRwXCAJFlk0AcQ8UcteHLGXhoFZfJRasRqJh/lhEOWnMA9oPDnP?=
 =?us-ascii?Q?/+ZzomXYZw+55mX2FLCdERPolc/9hijEoLmYGn561ZKzXtLtCLUwLrh6FEXF?=
 =?us-ascii?Q?7ElqzKRuxej9g9iwpBoPM5mnRxIslGkltfN+qAl9hJ+9GYKVW2g6uMw5DW34?=
 =?us-ascii?Q?Jh3HEOwSzx5v4GA0jJDpHX6Cdncu/TroiXOAiebqTQnoapp9gequbRSk6cVb?=
 =?us-ascii?Q?Pjs8tploq/baMog4tDpwC8NA5PM716CESBvnexJ6OF9NoBt1PHL24Oi1/r7h?=
 =?us-ascii?Q?YIJeb/QO23cAied8vp97MWZBiGBEgrA+MJzRAwre2G6/laMGBsgtiIZndjKz?=
 =?us-ascii?Q?0qPX9QNNvxrtZPeIivMuMWz/nBUo8RWyFFrAtHP74KWtxNnf51t6S/64YMEC?=
 =?us-ascii?Q?rA05wMhcW37kAFtcvdTCUr3zzWTTvMv0rE23u05yuQDfn79bVhJOsqnlc4qo?=
 =?us-ascii?Q?W82dqckgpZSXRO+0qVYZ8SaQRpbNApYSR2RLifoZaLScRsOAPnORk9lQIhyA?=
 =?us-ascii?Q?/PtyxEOB6bN1IMAfvH9tIrTDZv2vTDpMLqO8v9O+hhaANqOz83zXC+2IzLzL?=
 =?us-ascii?Q?pB2u4LaDsoFhhAh72dGuVU2Ms1rt1VPWiNJdCpUuqa5VX9NsBpYsoTzy0AHD?=
 =?us-ascii?Q?Kj+uHqVuFGIpdMvrRWh01WUrkQdWclsPabVjdIQHiajel3cK5TrxITZETebh?=
 =?us-ascii?Q?UdchRz2pSpFjCJwreUhqquOf4yTPvemOugGx+Gyhv+eX9zcXh9sZW5kRgaLy?=
 =?us-ascii?Q?CGcq6WDT9InBOFYRYAk1UkAqhU0tsXfN+QGEYQsV1dIhM1P2ww6sK+DEIRhn?=
 =?us-ascii?Q?Szpqmf+s+4HXTpwSZkOJmVWly4uxj2d6ph7xi8LkAUxvy8nsUo0CG0JMHbYk?=
 =?us-ascii?Q?Y5XIO/Dz5fQ9iGag7abK1YGnDIxAnX5RiZx7FQZT1FU0Hp9DFA1+yEohKndq?=
 =?us-ascii?Q?xzIMAb78Wr6j0+Az/T13zIG9k6ayOYXGBAuCl6O5fV1WFVDTS4PsaHxpZc8C?=
 =?us-ascii?Q?lDKIf9EGQZoFIpvgKrFyEdEhEMgBAUNY6BnZYcBJHW1VpeZRr/e//8lUTWS1?=
 =?us-ascii?Q?uvAHRG1rHoURvds9ilHJGBAP+Vi6CkDADSnscynJ29KlMZ83Cz/xctYZ46Et?=
 =?us-ascii?Q?k7/YveYSQAPMAm6SyulKbBtDHX5PWDQjy712JvNmULz8XHEK+pzvuzYwts1k?=
 =?us-ascii?Q?BfnhGWGNXsi+5UpctvWZeWsniuneCfNEWZbYo8OvmAKyFIOCOJ4XEpf2R4NO?=
 =?us-ascii?Q?NCWje2S97JexUzdPjMWo1oMpzStdcS7pDN6nj/CNmo7EUbxN1f//k9eW47uB?=
 =?us-ascii?Q?R+/Zu705ixJ96Fi8jtv4UpP2cgeZDwzeI9QYNFBmXzaC6EdaoJB9xbANZGZV?=
 =?us-ascii?Q?FLTzasPok3jDlDqajXBO/G9RW+TsXKLQgKqBB+GOm4zFcpJLbSWPyZyDTvHZ?=
 =?us-ascii?Q?e3pjAQHX+UbRmztPiGOVbHrvPoibR4ap/pC/PlClhqlq0gWzDUH+kJJVxyU5?=
 =?us-ascii?Q?dzIu0DRA1TyLoeAaSg17ejSLra4GOmWhx6viYZxEMDGaEGk8VNyxUG54Z1Wv?=
 =?us-ascii?Q?SuaR8+mb3ZRca5wSZDi+Qzbb0rNDjSltSxxt0M9TCK4Klnq46mzoimNWoF07?=
 =?us-ascii?Q?UrRt3xJDz1DEG0U2IUJBF6yu++w835mW9pA8eMWCvKF3fRn8fcmt81UtoP15?=
 =?us-ascii?Q?z82eihxdqU5qvloX+Nzgl8/1hKEAbCSaTrEdXEaWuf4WlrZh8pyE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cee79cf-a9ca-4c62-c759-08df2846e05e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:54:59.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlPz0u8tqprT4gbmMHUrVGJeMaRUx2+Xl6ihhnssnBLU6/C11eO75tv9CnYkFvJTLhn2bU3EX7syjlGzBqd1gJtyrLXFvCb5Vtofx2xK4isSuMAil9l2fIQixC7e71ZI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded 64-bit register read/write sequences with
ioread64_lo_hi() and iowrite64_lo_hi() helpers. Introduce two new macros
netc_timer_rd64() and netc_timer_wr64() that wrap these helpers and use
them throughout the driver. This reduces boilerplate and makes the intent
of each operation clearer.

The high-half register defines (NETC_TMR_*_H) are kept to document the
register map; they are not used directly since netc_timer_rd/wr64()
address the 64-bit register pair via the low-half offset, relying on the
hardware layout where H is always at L + 4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/ptp/ptp_netc.c | 72 ++++++++++++------------------------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 19ca99d80e95..376b3b0d1a38 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -127,6 +127,17 @@ struct netc_timer {
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+
+/* The 64-bit timer registers consist of a low (L) and high (H) register pair.
+ * Hardware requires a strict access order: for writes, TMR_xxx_L must be
+ * written first, which latches the value into a shadow register; the write
+ * to TMR_xxx_H then atomically transfers both shadow registers into the live
+ * counter. For reads, TMR_xxx_L must be read first to capture a coherent
+ * snapshot. iowrite64_lo_hi() and ioread64_lo_hi() enforce this L-before-H
+ * ordering.
+ */
+#define netc_timer_rd64(p, o)		ioread64_lo_hi((p)->base + (o))
+#define netc_timer_wr64(p, o, v)	iowrite64_lo_hi(v, (p)->base + (o))
 #define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
 
 static const char *const timer_clk_src[] = {
@@ -136,66 +147,28 @@ static const char *const timer_clk_src[] = {
 
 static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
 {
-	u32 tmr_cnt_h = upper_32_bits(ns);
-	u32 tmr_cnt_l = lower_32_bits(ns);
-
-	/* Writes to the TMR_CNT_L register copies the written value
-	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
-	 * register copies the values written into the shadow TMR_CNT_H
-	 * register. Contents of the shadow registers are copied into
-	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
-	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
-	 * register first. Other H/L registers should have the same
-	 * behavior.
-	 */
-	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
-	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+	netc_timer_wr64(priv, NETC_TMR_CNT_L, ns);
 }
 
 static u64 netc_timer_offset_read(struct netc_timer *priv)
 {
-	u32 tmr_off_l, tmr_off_h;
-	u64 offset;
-
-	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
-	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
-	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
-
-	return offset;
+	return netc_timer_rd64(priv, NETC_TMR_OFF_L);
 }
 
 static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
 {
-	u32 tmr_off_h = upper_32_bits(offset);
-	u32 tmr_off_l = lower_32_bits(offset);
-
-	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
-	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+	netc_timer_wr64(priv, NETC_TMR_OFF_L, offset);
 }
 
 static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 {
-	u32 time_h, time_l;
-	u64 ns;
-
-	/* The user should read NETC_TMR_CUR_TIME_L first to
-	 * get correct current time.
-	 */
-	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
-	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
-	ns = (u64)time_h << 32 | time_l;
-
-	return ns;
+	return netc_timer_rd64(priv, NETC_TMR_CUR_TIME_L);
 }
 
 static void netc_timer_alarm_write(struct netc_timer *priv,
 				   u64 alarm, int index)
 {
-	u32 alarm_h = upper_32_bits(alarm);
-	u32 alarm_l = lower_32_bits(alarm);
-
-	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
-	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+	netc_timer_wr64(priv, NETC_TMR_ALARM_L(index), alarm);
 }
 
 static u32 netc_timer_get_integral_period(struct netc_timer *priv)
@@ -500,22 +473,19 @@ static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
 					 bool update_event)
 {
 	struct ptp_clock_event event;
-	u32 etts_l = 0, etts_h = 0;
+	u64 etts = 0;
 
-	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
-		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
-		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
-	}
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index))
+		etts = netc_timer_rd64(priv, NETC_TMR_ETTS_L(index));
 
 	/* Invalid time stamp */
-	if (!etts_l && !etts_h)
+	if (!etts)
 		return;
 
 	if (update_event) {
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = index;
-		event.timestamp = (u64)etts_h << 32;
-		event.timestamp |= etts_l;
+		event.timestamp = etts;
 		ptp_clock_event(priv->clock, &event);
 	}
 }
-- 
2.34.1


