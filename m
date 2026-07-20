Return-Path: <linuxppc-dev+bounces-24465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7F2C44525
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:00:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3bbk6L4Zz2yft;
	Mon, 20 Jul 2026 20:00:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784541602;
	cv=pass; b=j7kC+G4RSfFe+X+zb/cWaWf4EcauQrydFl84bQyA9MSSVH13uGdPauaIIxMU5ABvrVfHnSd1WrDD/xMlXWLLsj6LyYIp6nUZA9exRIgqbawfRhB3nOQpBDO7Pu11TNTxwujYWsQDkBwCbkkGhV0w71ySk2Jxu93BteM3PqmGoeCfXhh8DN79PEq3nuqtNGzVEolsVJaO0D41msPYbTI5c7E/7vDbbfbu/zHKmsRRz3xMDPefuYiK5HYDXPcvR55H5mE0RNdPXCsgQQNcp7YjEo5UJQ51q0+9dnsLSpOASkG94Tlb0gj21g4kP4BprW0c6Ke6G6kSEEjiJjy6V8jqJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784541602; c=relaxed/relaxed;
	bh=0um9E0TC7oGGnPm98jCGhF/BZdjS3k1Cgj8FdIUuxGc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HZoS+uJbkAAT0xPuxUE3JAl9Imz+HO5ZZckQRZgbWIsyGma3B6hgympHhARfgjnW2s4x4HqUA5lZHMPH8JcLK+qvURCkAZo1lVQylveEswnOMdpaVllxOXnJ9+hV0fJXCBTe38RS0DpwCsCj2V4agDZWKQ2wnUFhJWv/G99TeQoG0j8DS6okhgyaWvtBtUwVcfuqLQmsAnnmCe1D3gwT3vB/sMZcRuOKq+xn21Un0ILfR+HXkrrJ3NQbOLwEIBFVKnY4StMclEa6l6w0GOlgYIUYzxNT9CvgA11HdTF24cfgBq3YiO+PWLx8tba+VVfVz7ReJOuLvcahAf1JUhqNRQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=AZ9G3G6T; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=AZ9G3G6T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3bbg6ZBjz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:59:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvSxyWP/bInAkmcSonVPtEYVT8UVnJtMYJ26Vqu8WnGoRzVQ9oPSM3Ny7N9Bqxc3d1yYKUgtX0zt3YN/G2+h093tjA5pk+pFSwxK+yGcsUc1qcnn/VVQbesYquaalrfYcGfdeOnmgkqrDL4jDuzQYvHMD/mYa73Qbb5RA02RTysObllWeBXFNuohtSXwBIrKxPFU9pl6dBBx98YZgd5jPEfytfPzPw9S1r/c+bhganRuzsH6Ey7WQyDaboCAMTMckvegl7rCoehaTbwT+zpw1GvP7u8zgdDS2y1gZCpW462bZzOtuMtMMRuEm3x1icCc18ZbT5PBUkstEVrnC3Gkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0um9E0TC7oGGnPm98jCGhF/BZdjS3k1Cgj8FdIUuxGc=;
 b=ikmEABK5yUvTalzpHamvfQ6/5blg4B2+pzFtJ6pZ92ZhCo/Z3IVo87vkZc84AxFmvyzxwhbHyH24xzsR+AViESsUOpK1sWVa7kdZhGVonLKeSWEPcWoKfgfk9XnZ5ipX6j6StwHT3vSrDgOj72eHMLTBth+8tg7wgzqUDbJYQ3w8L4ZkcV0U2MxZXgIXx9lssO1PWyfDRj2m0sr79WNmyKgrMfTtV1ch81AYtAdSb7KEwROtFZzhhl2PCASq001c0B3OruFfY/VA8SAc4QjsDh+SAJP5SFFmDF88oLENIs8Wj515mR7kpC4RO4rO4VwwqmylyBfR4v7y59TI4WJ6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0um9E0TC7oGGnPm98jCGhF/BZdjS3k1Cgj8FdIUuxGc=;
 b=AZ9G3G6TSZ1IwRl4HNBmDlWJ07/Hv3e3iuUirj7otHv0I/beJPvewFlI9pt2hLc7SAkn3BeI39+mFkrEuIsgHk2UQ3cAd9IcqpohrpK2Q2NZCIwUqXOSBXgjzVtKXhrpkTZflWmxAv+6LXcYtCHnpKTGyi9WEQLQtB2NvUzbO8SGhTEpqzfbpqRRG4FN6vXAvTtIYOjVXOcFZ63L8oXL9NtAonMuHSuwcR+M9v+hGORPMIeDy2GxI68fjeVT0wxbZP3X4Z+Qay0ow5nzVhEhe4pSc8FQSv6HnPT43oLZwpQQTc4ZkHpdstzDyGbBfLQtO5oD/dq/ph0svXhupiqnlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5828.apcprd06.prod.outlook.com (2603:1096:301:e8::11)
 by KU4PR06MB8458.apcprd06.prod.outlook.com (2603:1096:d10:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 09:59:36 +0000
Received: from PUZPR06MB5828.apcprd06.prod.outlook.com
 ([fe80::1d47:987a:ed97:769a]) by PUZPR06MB5828.apcprd06.prod.outlook.com
 ([fe80::1d47:987a:ed97:769a%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:59:36 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Roy Pledge <Roy.Pledge@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@openwrt.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Gary Guo <gary@garyguo.net>,
	Sumit Gupta <sumitg@nvidia.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	linux-kernel@vger.kernel.org (open list:DPAA2 DATAPATH I/O (DPIO) DRIVER),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 0/7] soc: Remove redundant error messages on IRQ request failure
Date: Mon, 20 Jul 2026 17:59:06 +0800
Message-Id: <20260720095920.542801-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::11) To PUZPR06MB5828.apcprd06.prod.outlook.com
 (2603:1096:301:e8::11)
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
X-MS-TrafficTypeDiagnostic: PUZPR06MB5828:EE_|KU4PR06MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 33784450-c4c5-46c7-3162-08dee6459b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|7416014|376014|1800799024|56012099006|11063799006|10067099003|6133799003|38350700014|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	DHQTLLL4TvEqHY1dGmrBQiIeGI0JUeS1b04V90sRs6ifYtk6+nfESaiKMvEh5kqT2cjkPKFnaYFF75TheQlRkkzo9P4rMwMH3Ledh8A7g1GrJQU6yhbJkDFavZg4N5efEVmVSgJFgnAhYl32GhPRkLdjXmYeXajTwtnqMElL9UyjwbcgHLOmjwD1As9ZFzeixZTBu8SXYs8yHbhevb9ebagco7buJeF55i/uMsiKTWkoGdqWZ0FPIVcoSkjokxYz8yBovdC/6S+3VWtgReiMkYXgTU7Xs6Z5gbB/4g1WBddWA8UXkD4skHTcBwAN+7kQPnBlYG9cZ92ETj/IoHooORqXfrtYG1GavRCwpR6VxAEu0Kr2KljRM/AavnKsLuYlAlbAqrB1WYWF+ddPHYHCQWrQZ9BPlBDMjF/YwpG5UwRq8V7cKf+VtNeoRhVAAzq4+U38Ziop5f1El47DzTqA59jcva+s8UsVeLGCHIQKgUDrY+PP75NhBkUN3jMh3XvXzIMhpBFaHbeQPuZ3sNiw62/1BbldYNvAqDeHcLvuGW1f3vBtf49ocg4iyPdotPutLgBG4EXS6b3EudsHkQeQYcAIrXIgjL/lQxXITpyebF7HUiPXaGLfKJJOvVb3il7MRLbXDt8CJlok2BZS/ggv77+xZpZJpxCAzTt96WtzwUUty3KrtS9gKcCUc04X/Eg3MlwHzxBX8COGcOrwJ67RlwpKr49axkbEfJ4DxD9vOfHiNt5b29WUtN4cKAHf5BvW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5828.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(38350700014)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHqj9jonrg1Ax9Mdmn4DRxrhPkRlLCoylc/aVfA6Ll6qpR1NkdoNWFaW7CH1?=
 =?us-ascii?Q?Aw58Hhl9J91XJDMHEkAGFS5okAX+7FQXwMesp6T0x5rG2sAhgouEIZEzMKvr?=
 =?us-ascii?Q?cuauoRyp3HU3ffk9VRMNKyeuxHVCgfifDmRDlAzMFd2DiIe8adc68VnKCtMg?=
 =?us-ascii?Q?/gL2fc+xfNz4bFz4KgyLL8Ui4qhypxKmar4DU6wJweT6rtwp85ccjbQyAg3R?=
 =?us-ascii?Q?/y1JRdyew11qNM2iy/slGjKupqp7fayfHHvun9JOl6uKPicKRhv6IhPwb5Fl?=
 =?us-ascii?Q?Xlx1YhmrSw9BSBdaTrcP91rlqlEwCI+z0UYZQgJ4fMrBffGbaQVpd3x1HTVq?=
 =?us-ascii?Q?G7rvJsMtxczUNS5iL/XhxEdsCfy74BYg7RVEzDA5bjahs457lbhuESpBDBYN?=
 =?us-ascii?Q?8v+jxslrjvHlLhI7bxOjHE6P3L83wl2mE8+b1Axfg+2poKv0lgxPZnQssDVA?=
 =?us-ascii?Q?q0+zhUKhXL0F5Oi7pFBGrkNk1z6Q+jwfnyKy4uEaPX1++fCDtLugmKf/hOr9?=
 =?us-ascii?Q?bEMAtNvXel5XAmI6aSPm1fYCCjv+WLCduB7ylmjn44PHYQQv29R/JTLzBe6i?=
 =?us-ascii?Q?nGl0GWXM3muX2ZrUzNFEwtl+LY7tJIID07rObGny/qHvB9vhffmIifh+0/kK?=
 =?us-ascii?Q?vfcEVM6aZp+BrMDADN475qP4bjbPo+lubI9XlsiRiNpT6m3H+HUVeT55iLK7?=
 =?us-ascii?Q?4OQBTGonltg1rGuuzObD4122K+V+ghXpQ3MX8HcHkwO1D7BRRTvTXPnhYeTG?=
 =?us-ascii?Q?cOs28fPsRWWtQ35AusGgw2W3JvsAVPCqy2+Q3JgedwSWf5NHPMWHWHaZv1ac?=
 =?us-ascii?Q?IZy7fQhiOkLAIwD8ETe4AMQFW9pHyaXPDHaQrAaqFAew6BLTFuzpG0ZirtOV?=
 =?us-ascii?Q?0u6+oss/MzKPfAR4FJsis+MNgMjh0KstUtbqZb2inlygC9vzNbNppFzvnmAv?=
 =?us-ascii?Q?ycR9FdbfpTKavGohXT5tl7T2uyZBxqZySwh3yrWzKGqr2/ghIaFNwObAGj14?=
 =?us-ascii?Q?yru9xdeb2xcBHfRmAHN22Sfeh6VRc72vZ7NFsHbvdxHFxyqzygke0PLd2naQ?=
 =?us-ascii?Q?DvvfIuLorHyumLSIhNItvUxtwH5hJKgS887hFaOifB0Q9RKmUagWHT923vwb?=
 =?us-ascii?Q?vcZHHT3OGROAaqyu+mRe2x4tqg+UMQZkGsYRYElo+03XBkIKb5VSWVKkz/P9?=
 =?us-ascii?Q?Jogzsz1pFsl9oKcyIb1mf/jLCo+4eJgxVxgggnmw1RFNNscWHaam3OfHqXkq?=
 =?us-ascii?Q?DBcmkBZvM2yZhsiZbCNH401iZ4NXe1ArMUyEtSP4L0xeONvCyDpzVW9S5EGJ?=
 =?us-ascii?Q?fvsXwvUWOaelhJQRFbvsPX5+/zCR22UhNSOn4MTyoVtzv6ryjsuhRMJ7HdSf?=
 =?us-ascii?Q?QP9kcnp0X1YlDy+ez3S8qtPHEEkhhc3v0K2WhPdYh45v8NANox43c+BIvX6J?=
 =?us-ascii?Q?Z5KiZ306p18frhzQEGve89LCUZise5UBzOIbGzQ1xrup5Xn/V70GzpUKCQw/?=
 =?us-ascii?Q?vm4E/K8alJDDyxFU+FZuL2RyXR/ftYCfN8u5XChjc1k4oHnOIPwH8RflDMBE?=
 =?us-ascii?Q?nGB9PqFGdpDwI1boLF7RmbNtqw4S2V4+SInqt0hQ6V00kwAlhosj1Q44mb2X?=
 =?us-ascii?Q?3n1e7p6iG9nE0kAj+AkQfwfm3D6aCVe5PzW71F5JLpWYwizrHjaSoj0fQVAS?=
 =?us-ascii?Q?puxHXKt2uhpFB/ObBR/vy4KZqKj+WsEyZd3qqyt0546yT/Dsl6v623UbsyC7?=
 =?us-ascii?Q?SOc138b/CQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33784450-c4c5-46c7-3162-08dee6459b08
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5828.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 09:59:36.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cahEH0NhU2BEKmTDd1FGT+iCeoYkwsU9b+jdtWgV+NBwUJi/y2+aydk3jLzpcz2FmeuGhqx/kbNCYzNvkS9XKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8458

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in soc drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (7):
  soc: fsl: dpio: Remove redundant dev_err()
  soc: ixp4xx: Remove redundant dev_err()
  soc: mediatek: mtk-svs: Remove redundant dev_err_probe()
  soc: qcom: Remove redundant dev_err()
  soc/tegra: cbb: Remove redundant dev_err()
  soc: ti: wkup_m3_ipc: Remove redundant dev_err()
  soc: xilinx: Remove redundant dev_err()

 drivers/soc/fsl/dpio/dpio-driver.c   |  6 +-----
 drivers/soc/ixp4xx/ixp4xx-qmgr.c     | 10 ++--------
 drivers/soc/mediatek/mtk-svs.c       |  4 +---
 drivers/soc/qcom/qcom_aoss.c         |  4 +---
 drivers/soc/qcom/smp2p.c             |  4 +---
 drivers/soc/qcom/smsm.c              |  4 +---
 drivers/soc/tegra/cbb/tegra194-cbb.c |  9 ++-------
 drivers/soc/ti/wkup_m3_ipc.c         |  4 +---
 drivers/soc/xilinx/zynqmp_power.c    |  5 +----
 9 files changed, 11 insertions(+), 39 deletions(-)

-- 
2.34.1


