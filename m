Return-Path: <linuxppc-dev+bounces-21087-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6AECD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:24:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrS62j8nz3cG0;
	Mon, 18 May 2026 18:24:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092646;
	cv=pass; b=mgZknwMQxIgMQVQB8rYoBCzuwYgoYpcfORlB0XIRVFjbyCEfEvStCrC7zzisl4tgGcM42JzrFYdu4/9Bar+VND0m5WFWLr1rtGm0TptbGa+0TznTzDxvAMgbEqlCMHNQKtP6gk20tOoHjDcc6EuRGJ2C13lg9Vo+VwQ3XBf/UfFMxmP2R4CRy9Fbp/awiXMbxEbvHWLcsAC8uyoovw5v2MEXSrNldZdTyrTsoYocFbDrQn9HS4CRU9MV+orjhl0I4FKpH0s6K7u2H8Uw8DO7pMTWvbqUWqKt/1OY+tNtWAcrkbi5SLjz6B1UTtlMOg9TPcJ73tuKhPFYIfTx73ykZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092646; c=relaxed/relaxed;
	bh=irsH3/6S1dvhTXA2nLyw4lOUkP4Nt4gsfXtfZVu/MO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4YeIUkZhuV9puKgzUoMFiJNO+Vh1/JVJaJ3X/ITY2lCOV6PLBnxwEnuuuFyk27v/c+BRmbW8AHDi1M/I5CnxZWTLjfO03lHXdgQL9sBcnauOvmkNUZ9+RKqE4RiFpQOhK2lme7R+O9PADq1CkeydSliTJLto9yG/end4+tJNTxTm7LPUCRbaXErGVeUOTmSZKX3wyFIlFSOF3jfb1STPfwOYMto7ZVUA9AESyl+fK36vcDiLvSiOn85EpKOFPrRXoncsdv+jSIcWILJz+qxmaDoescstIvNLPx4LwRYfeBB4ZZCWb6KIlWCOobD7pnSKFNPwsFPu+hEvKiLJAaQbg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iCsZ76ho; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iCsZ76ho;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrS54FNsz3cBH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:24:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYfTK2uA2DmKPpYFzfl2i8/genjnbuazitQ2cPFIWH16EUSbS6jHLndyQcdqDi2qbludRllgYrcGdFdFwZ3/YILZQMpzMK3kTgszGkBe55RqtxlFe/cpFtE56qDj1yGGAJbnxy8XxZY+koKNnxd4H7Xr1M5INoX6EQwVneOeXxGYNgQs8pehpd0fVOeo+nxbBJs2dvO9dLRZbPbyfPQzvEIZzIn0CHWnLGATq4pot29UbLWO7RqW2/xgiMBxdoOOqaK0tHGqsSzG4qb3ZFrYmqTVRnGjT1N9VCnci/8OugwDGEsVxwnqYsfhTwGNzYWq9vRrc4zWFpJQ1K4n0aSAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irsH3/6S1dvhTXA2nLyw4lOUkP4Nt4gsfXtfZVu/MO8=;
 b=kcYt+J9UpDwV8iqbm2gCPSII+m52goIqHhn6ihLJOjqvEb8nOCNfgWVwEVjgIpw5ZYwvLuvwv4sliVoJ+xbdQfW+uXgDlx/uldnc/ciO4iHC2Pj5kKEjh+6YnpfyQXs/k2Imz2eEa90uFpjOmDb37MNe7x4HWNNPhHV8NQFTX9FBWwPUvPZQgG0+G5UnBpK7JFcM3ALWKOFjtqYQs+zh74JDjtdR3NEi67fZ6sEl5afPo80b3MKoKlZ4R8RfcYhD4nEtSqFGLW4LHuXSqoYfZgyG8ly5DaH7oi7Nvfb2151AZgyc0iH6+kilFXKilUaQKX1xdcowEoqh00Rr3P3AoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irsH3/6S1dvhTXA2nLyw4lOUkP4Nt4gsfXtfZVu/MO8=;
 b=iCsZ76hogoIjhWixjKdM9Lud2f4FEygEolUy5+FjwODEOdvH7ab3F7MD5zKc/T7eiKSPtWcfFeVkoUTN89PEfMQRfOdABTaFQPyvirhTisquORl6Qot2xSTSOeSjZkfOZ/XBvNJwPgyIzJtApBW2ld8ZGcQVngxvldg6e+FVnaUicQ911uvjUHc37ikVSmLOoKEY0a3vdXKINrro7L9nxq3Ejyse3elpKrhgRFkkmLbp9uSXOoJUWinO6Rrd47HzMCab+uWAd5s6Yjpcij8jOaHqL9EheSW/SS+A0+1GI8m44tNRWOwJEh6do26A6O1CTf/hxJHyNtEH1RWpOWWRqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:23:59 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:23:59 +0000
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
Subject: [PATCH v8 net-next 08/15] net: enetc: add multiple command BD rings support
Date: Mon, 18 May 2026 16:24:59 +0800
Message-Id: <20260518082506.1318236-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ca5d2c-24aa-435a-8dd2-08deb4b6cf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|20052099010|921020|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	tEKNBZzV0TkXkcsSDTPIHN+qUlvxpc8xPDiFwyRrW/Z9G/x6+0HRh8pYuUJVif+0mkhMbyNkoeG3nYjkWEr9VYkiPd7FSH0SCHy/uEj8hvYDTafwPJ+/FG3/NVKkpy97IYNab2jvRh+s095K2LqmyH4VlPnepeQJw4NdqtraNCjxGDk0gp6JRT4+R0yvOyRVPpnBHGSsZqc92aEaexkxxn9yFZavWwaPGLHNSu2ZqklHXGgPm4TFaR7stsJMFy0s+o5sgFlgCq37kyWvjbTi88c/PYcW8aKYHOKJzwDu/TAGrhUEL7n9z19rARkar0RIFQlTcQbqeTY6BiY4pqfRjgrJ+BAxUdPmbFgWklYH9s/7sTRJHWvmMrJKk0CFGAx4VU7+Zjyo65wdnqz5jKj9B72S9h+nPELd76v4iHjKLfdGcCZ2APos00DeMx3DBBoa2gIhkVZZQvQJoU0Utux1YL3SV+C1rhYh/C9i5H1pqsitcd6CXrkcbv83pCZqLpAYDbN7o4iSzw4ZrLL73oRfcbd08tfkS5Y02LOZN8FzV5yGohumDprwPHYDrm4zD4/dnfA9asLH5uDP4B2GAvFe3S31HRHxu88IWUkg78BKHIBzgZrA45bvb8/kCMSXMDPqZqWNgBvYM/xeikQbKMvGFTDUCQqiE9T+wgTZa8tpU3tV/kTj43zUff0QXn7PslweoeJnIuOFXSXgQ8Nrw/hcsAdiEBqHOkxBZ3BBWFxrWRJihnEF/FG9hx4YjWNc5HZgkXYy81oBypOHbbVvCIFDkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(20052099010)(921020)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0d65cPacrYh3kQYP3XUYb1l77Bsy53Z6+sSovIei04yhbcCfCxoLSRBRozi8?=
 =?us-ascii?Q?rrP+RUa75qEzRTDDTFcLzduNE9AZSCHH80CeVPrF3LhHP9OOjejH0MnBYk2n?=
 =?us-ascii?Q?OYsGlVJh2sobDuetv19R9FThQybyZEMtF3x6bd3aFH8dy2v3DcASR3vMnHOv?=
 =?us-ascii?Q?Cd815ZQBkyd5gYEYlT/No3LX3GUy9quxl0gq9YFN2XsWkB1oHUQvv/N9Z2jc?=
 =?us-ascii?Q?MpF0aruyt38vcF2OsC1H4LoJzM7KwOBdxj6VMedvast0w8hjgCX4Wf53J4nb?=
 =?us-ascii?Q?XhPojECIHP0YDnu6UbjsjFGMX6lrtPlnTGkkyo1kxWw1wQNgQKs4SBMtzofH?=
 =?us-ascii?Q?EWfQI7OtvZIGTrz5+aT6zDIYKzVqwlZ6FRavBffyYfMQjaKsqTtCUfOPIRoN?=
 =?us-ascii?Q?FZZ5pvzu3aApjlnGwhx2mI47GEGmXWb/JCSXEs/ZcG5sbzr5T+2yC3aZZ8dp?=
 =?us-ascii?Q?3016s6KCAkt1I6Pvb6Ibibfs3klg4/x8DEivd1Wzzh8ncImukJTyDobooD6s?=
 =?us-ascii?Q?nuasb1BWbfvbC6nWPUxq1lOk8LDU5RjmzMhNRj4MA+m/GhZGlsGhEx28nt2e?=
 =?us-ascii?Q?TQlRn9/d/rqvP1v70t/cLpLLKUgrgoo+pNlRNGPkrcVnss6Ch47hAoPaYs2v?=
 =?us-ascii?Q?KS+2nl6S3wynTirz8bX2Ix1iUcOwzczYz8kkhZGAz5jlk1458tgInmlORHbP?=
 =?us-ascii?Q?eu+gEoSctZsrtkyD+DdN0c3OTKUtYrlICTAMz8zPmC1EHirYXAuelbS8sV1s?=
 =?us-ascii?Q?v99xDv5IEuQP7hI+52P4wFAI7btBAIw5YZ/picMML2shKAXmbKrAQ1JCHQ/2?=
 =?us-ascii?Q?g3rNRY9f0Y92n+myEL/gnQey0ldCrrxIBgioqyxsBFr2FtDAv6xram81haYK?=
 =?us-ascii?Q?WYNf0DbOj9AZo2gCLHJsUHCHPmkAltY8WFRdJda9iYvOAZWkk2j3CFBobmBl?=
 =?us-ascii?Q?btgfpWSS79aO7U90uvI3Z04HzvOURFSonzmAmaSy6CMlmWorBXN7I6vKwwtD?=
 =?us-ascii?Q?mHygpkTnOSv6ijbmfexNNipK0zzqCLeaiNuVmEmGBHq4H+l6rQmEF1iXNv7X?=
 =?us-ascii?Q?PujwQJhfTxy3Tq8SsMXcEWWOC/5mMG4epZWIHOCOa6aSRQ5VqJialsTiTYmr?=
 =?us-ascii?Q?kwca20dYmCnz2U1gCjOmpo9m1ECBtqK/m+fFuOEoDXkaKidtH+wi5Y/JN0du?=
 =?us-ascii?Q?wmPmBIOl/Xi+S+ZpZH1BxSpnv9nxxFtC2M29P7L2ccNjGxeW0LTlAmpHIkjh?=
 =?us-ascii?Q?TsPfazJSOqgP/MN0VtOMpn9E5Jr+WEUcr7aco+XTpo3UVVh/no14iSlmaPML?=
 =?us-ascii?Q?eCwH1h0Nf8L70O73+4mDFEGsVM7ywZzJQzgV4FcEi48emiojby//QI5hAlyk?=
 =?us-ascii?Q?yNQ4hmF5dPuipQYvcT/ccCcFL/20WW8swMJbe6UtWLyubyHFvWD7WA9n/Y63?=
 =?us-ascii?Q?3ZC2qpHl8fKIPLs3feTrgd2aoXggVMbPbAUX+BnTs6ZyxUdqait8rSoGKPRv?=
 =?us-ascii?Q?Z6wDlpC6V1riVLjVneeftM4HEbQDLGbo8scRbDgJ4TEXPjiOw4ixAbBEu/OG?=
 =?us-ascii?Q?p31p6kbh9HkzWJnvJjM5rzEmEBtNzxY2EMMNCeFoxHckKmQ5uAA6ygWHSXYP?=
 =?us-ascii?Q?plf5tvz8Z8xgFx6fht88+F6Y1rs5KHDKefEDeJ8nvuGKSqRywNFnAYR4qVkN?=
 =?us-ascii?Q?XkV9mLulaCGvVe5xgY/WC/0aPYwXIIMIjvoYS2VPKBp2FttCaYhu+K/UIemt?=
 =?us-ascii?Q?Vah0cQCRwg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ca5d2c-24aa-435a-8dd2-08deb4b6cf65
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:23:59.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ww+oWsb4CyujfwLrD0LEPBUvXUfwydZkY9UewHtbXxxOLUr032diMMXxBK55B5rz7tGgqmViTNID/fZ/dg3yKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

All the tables of NETC switch are managed through the command BD ring,
but unlike ENETC, the switch has two command BD rings, if the current
ring is busy, the switch driver can switch to another ring to manage
the table. Currently, the NTMP driver does not support multiple rings.
Therefore, update ntmp_select_and_lock_cbdr() to select a appropriate
ring to execute the command for the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 635032d24dc7..f71cad943424 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -146,11 +146,16 @@ static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
 static void ntmp_select_and_lock_cbdr(struct ntmp_user *user,
 				      struct netc_cbdr **cbdr)
 {
-	/* Currently only ENETC is supported, and it has only one command
-	 * BD ring.
-	 */
-	*cbdr = &user->ring[0];
+	for (int i = 0; i < user->cbdr_num; i++) {
+		*cbdr = &user->ring[i];
+		if (mutex_trylock(&(*cbdr)->ring_lock))
+			return;
+	}
 
+	/* If all command BD rings are locked, we need to select one of
+	 * them and wait for it.
+	 */
+	*cbdr = &user->ring[raw_smp_processor_id() % user->cbdr_num];
 	mutex_lock(&(*cbdr)->ring_lock);
 }
 
-- 
2.34.1


