Return-Path: <linuxppc-dev+bounces-19162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319F810F6FB5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 14:45:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm78N6Rj7z2yhY;
	Thu, 02 Apr 2026 01:45:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775054756;
	cv=pass; b=GLBpqoIgiOH50B82CiDKnCFVObCUqoCsJ26IYEM1TdnYr1/tiBjq+bMTWHH+cdkUFJm7gzaW2b7dncXwQuqFbLZMXT4x0Dm5LOx7beCDP2zIDh1edvNQAH3j7QqUyTS17soobkcXVjqrUt9kWyE9DgGO6iFOG3xUhKeoAU9lUoOerl/kOVxM0eJOIN+W9rD0i6l7UYv+VxOyurSZtg1gxYkZjN4NiRIHODDqDVjksRf0o+A/2HEOPL/9kqiHAjFeTL1T5o7iqYR3xutA3/llNyLUmIXhY7yuW0cwMh/KE3R1ylM7QMpMeQLnifwpcBseSksT3BaXkXhfFx23EvUwyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775054756; c=relaxed/relaxed;
	bh=im9xzHpjjRNfGtheIUvhAkm7qRIO0rNFgEciUDuP6EU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DsuZAu7ciJ5BdtfeL6fQaPP0Bfwlzd63DAmuW2+QLG6gqTU68AnUOhYJzgLXA054VHACdFExABe7KaacsV6XXvmMhcI9eSwryjk+LkJ/TQnW2EOfAli+IQGuw7kqAyRZ9UXsvs2vo9P18c3/PzKGHz2rvhW6ALJ68VU2BpzzOhmnpYLIKk7rsw6ljcQkEJjhc0OsJTPCkc8unCMmhA9PsyynXtgcioA/L+2zZu7eUYS26Jea6K/7lcqvnL9mNtmygQ7ABQYVNhzgqjOwPPqlxfUhg48HqxDpD340yHn4qRZ/X7CWUmwH+5evVZtc7+v4zyPNDC8QPcew6CAlncwdfw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WmaOhYFn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WmaOhYFn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm78L6MvKz2yVM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 01:45:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxRswfVQ9r6dc/v6y0bDiQzS2oVP0Um4R4WJUrx+wN0Km/29bG0tkYMj5lzJ5KsId648dXjVM2BSMl7Jf1Wj1FqlaHkfChrMBeXhlZWl6I8GK+MibLIEHb1gvuiGVvInZw1FJ6HxOUX1XVOnIYU2ZyiFFE7BkGii6twXFf4I9jVexmxe4x37db0oI3pRTurfTxhHMITRUvl/CiGGBy6I9VI79ITD1c8QErTa7UYtd3epjkSn/w+u6JknMZ3ZLIvgdlVXDEA6S6q0BdlWkUhPSQ40PJoWTT5wNSxFUYXLXOxpGpxmk6K1RtebSsEo0Gu0kK250vt6+A02uLHPOZzVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im9xzHpjjRNfGtheIUvhAkm7qRIO0rNFgEciUDuP6EU=;
 b=pLQhBEwqw1r+NDr1JASBowQHttauNqMItwkqhYeyOSHnJAQmKBQebeLVJ1so9+VlKnP8EKzzH+Xdn9AMsRrny7gPAYdnqMdcnofwYHOFUpYgyQZzAXUXXlatDjX4IAiZie2ENjIw/UicqgZHwASXSfJRnSYA4esgqYHOYu8cU2KfcLTIYy42MTxXBcLdC0c2eUHJk6UiZZ+F3Tff7KNGVmVRmbFfkXeVqDXkg52LijWpM9prtPnwX+b1YJ8+dNFSW4iXFUk8uEIiwzD2/NAQm041JakDeyr7PUlDH02Rtal+RkFU0GJKOQXElj6hiK5jU2M7+r2/YQriYeOXVOP5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im9xzHpjjRNfGtheIUvhAkm7qRIO0rNFgEciUDuP6EU=;
 b=WmaOhYFnB68g99K+r1zooM8CkLnoQSOpSMpzAg5T7wyWxJsO8oSm7YtjRIVqno1Is9W9wXsQdLtRrBk4SZCm2aBydueod8GfcnrDi79UpyA+B+3ZAxXJr+aOs+etFhyN6S+uRlaNJPgZuzvTsk2XexAGl6xNTSbrktBhh2rN7BYyTJcN2hAh16/Trt0TWwgXp9s+oDYLNE6fSV9toFSJZpZqo57od4tZWU/D0JrsR2QgOzfHRm/TPHQ3YKuemr+Iw1zpVj/RzaURV6694JG/To/XJIZxC9P8HXUrWfo0HeaK7TfDusGpPgT08JRQ8tr9hMu45ubqNeRsLXBdWea2Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13)
 by GV2PR04MB12558.eurprd04.prod.outlook.com (2603:10a6:150:368::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:45:28 +0000
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49]) by DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 14:45:28 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] bus: fsl-mc: wait for the MC firmware to complete its boot
Date: Wed,  1 Apr 2026 17:45:08 +0300
Message-Id: <20260401144508.3062019-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To DB9PR04MB8251.eurprd04.prod.outlook.com
 (2603:10a6:10:24f::13)
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
X-MS-TrafficTypeDiagnostic: DB9PR04MB8251:EE_|GV2PR04MB12558:EE_
X-MS-Office365-Filtering-Correlation-Id: cef88a62-1e8e-4a5c-7b5b-08de8ffd5127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iNHhAKD62w0/Fxs8NMHxjFCL32Hgn5d+MDyanPBxpLSA32N+K2uyFLxvgECFyIcR26JjCY/Atp39emS45+fAuzXolF1jfhgw0+p/rAg4Xgf4ebt//WMNubs+yXO7ZMFaRAHZVPlZKMhXnBAiWc76sG5pTUzsltYsInqcPh5KtzMtBDxBmDXMh7cGU+48mkzzFtka2zPktar0NfGThyzsRV3ETCBCa1qclhpUbFuTAtEkiatfwt0tmXw1xOQYtPSFO12XDHIZqXTWghjmGQWwkjyyKvX3NStUfRBVYfW6J8O36p6IrRXgrnX+yLDfbt3QFikc4MvBYUdm3GjFjLPqLItVXYb0x3RDL/1wmfT2sCyUju3iBcQe+spTQ4YzYHaJS+pJRjReiivHr6+v4G6qjRe9AH9Uli2Oc9SARhOCjvt3vBT0dfk8cNTSVsYgFqcivC2wf4JI/k5TJevLUSWy+9vfmNZwa+hSzPqtsl2zfwkuMwNp7sEi2nxiO4rdrWXMiOZjbqonl0T83xIbUNePkHRDfxbBn7pW0fP+f4KLgzXBl7kN6dAzBW4PDslG9BR+WfYAl+cq+itEPYcHbINz+xPN6cGZjk7ZDy6NTdq4b97LjK7YUiZE460bX3OqcnS4CGAB5Y6rf08TxR1BVBOcjleok18IcofKjAWxZP2l1BV8WQp9t/lcg/X0mfLY46yrb0G79+sORX7xEHi9yb40A1i/62LxVNIebLeEow5p5T4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XNNszR6f/e7bEfL9m6oCmHlwbhQqyHIz+d0s1+SyciABkxChoPwCc3NVgeOq?=
 =?us-ascii?Q?XARAuD8WacYX+WZF7vuQcitTDj/AQtuUkVetocLcFtRl4pmWnZfHGoLGAyCY?=
 =?us-ascii?Q?SPgJtwGgE7Y8jhz/LTEEtYOLWw3vrYB6EMCJJ4p6WdqVXaQ5PRwL6wGTCb5+?=
 =?us-ascii?Q?aZVE0ZhADsnhflquPoh3aYSHTnJoUEoD6mi2NDcAnlsZcUfEYP/ayutiANvN?=
 =?us-ascii?Q?wOIbtxeJ++foMj1/tJobchw4u9fMvxMvDP73Mc1HcOqg1gzZJKUk+FR2sFSS?=
 =?us-ascii?Q?F7HBdwDwS7XlAzFfUsCW8UJk8EUeEjFjWjFX1njErk/JJBdnxPXGU3XGe+M3?=
 =?us-ascii?Q?ETrQZTDVhpN/XHCCnnuRo2drawFjIzpFiBkCQEVttaxMc7D78fATX9Lk5aZv?=
 =?us-ascii?Q?Jt6LTKfPMSJah5RxD0dnp0Ihk4ovPcKbsiwCzmhXKsFUxEDfhg0ldpAvdKY0?=
 =?us-ascii?Q?IzRDssmcuTY3UIijnQ7vaE9yypyVoCmgyYFdKiWnKfIrkvhuVDVlhHF6R/NT?=
 =?us-ascii?Q?58nOL8ZqPOK1CeqqzRC4eDrEWcbfHej9BBo4jIAuL4PZEZLfnX7BYQtY7cXA?=
 =?us-ascii?Q?42P5O99OiBJbAwnZ7ds/KQB1X331XPI2A0V4u9SVhypZciopUE4ljwNtPbES?=
 =?us-ascii?Q?xgaGtISHcJTp0WOGNzSlgv8us1oudZhxfD1QkAwBAD1Jswthick1XNp/Pd55?=
 =?us-ascii?Q?rAU4wxf+sZC/zXvePDsyy5d3jJkOY5Jz98yrMCcS0tIkRCCzyNPsNasGloQE?=
 =?us-ascii?Q?LgKv3luxBKZ0OI/0GmTtLnT3e339pzPtNGovnOPY1vLspEIsiR4wYuOZBvSZ?=
 =?us-ascii?Q?2bsungyfU0ulwZrld3z58/77G6aDbG8XQIqYxZ3SmDr2P4c0OW06NpvhCqb0?=
 =?us-ascii?Q?Uo0uYp4zNwa8faIf4Q1YaUUPptXNTSJ2dpwCMs0k5AT1azBBTICPKpFSufj3?=
 =?us-ascii?Q?p9Q7MOx+hLuSKHXdlGdqLRmlTqo0kaifdoInx7z+PTPhf8PYcYaqk6hmW1HP?=
 =?us-ascii?Q?S5u4tk9QLmgExMKh/cd6eoL4Yyi+qxmk2kzCHa8NSg0yUAJLBUsAF53iKbEi?=
 =?us-ascii?Q?umj6bIzH0MNvYXimy21Zl9/Wmm5fXN5Go0h5fN0OyS6AYEbBsFxojAmXtKHs?=
 =?us-ascii?Q?L1Z3C9cTajCMAdxQ4X2sFRITRbab8FhkrzPBGA1awvI1aAWu02EwyFG6ydKH?=
 =?us-ascii?Q?lAcWNp3eMot2fRMjpcYf5wkXh+syqiQ8nxTS3VT17QSRxwobhAnVI2rIKjLQ?=
 =?us-ascii?Q?oZyCWnZbMjro18+AraHh9ckjMafYIiIMyd+uRZayPFMfjIKdEiLpBibXztt+?=
 =?us-ascii?Q?0yEwg5gqBNMsbPfSHGVwdgihpTy+OT2he5/sLtrSbm89Vnhnyg0t+cBaQ7QX?=
 =?us-ascii?Q?2rqJj4WvYWYHGXuTosm/A2VjalOjQxnh1s4sJKNRHU2G1ubzy+j6pLUr8X69?=
 =?us-ascii?Q?RUp0zgnPQHB+Mu3Yxihd5vHYFkr4XY9jsdhGztuYtl+JYOxxMmsp723s0wRC?=
 =?us-ascii?Q?EJ5vdHLvPd9KN6fdCNdeVY2PdYmTq6Me+lzzFwajHcC3E7yZ0J0a8S/tbnIs?=
 =?us-ascii?Q?FGC9WYK0dqcr/cA+Wp+Kg5qacLeojIVtVTh2xBkLpckaeaKZP620J52PxB8G?=
 =?us-ascii?Q?AZsO4w2Hk56jez8ykDMudYiW7GH4q5khwGawc1Nm8vwwsA+wzVO+enEeh9BF?=
 =?us-ascii?Q?BsgSB4osNvhEMfFlRy/SwW/nggHXlPr26rN59rshrdC34oiQS93AFvLG0lBb?=
 =?us-ascii?Q?UifLs8HKiw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef88a62-1e8e-4a5c-7b5b-08de8ffd5127
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:45:28.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWLwRtujJZ0Zlsj/NZgBQ0aoaXSECBw4ARv8pNznjxWAyXb/47jGV3M0zhiTIyknR/aA5VvQ0MpiK8TabaJMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12558

There are use cases in which the Management Complex firmware boot
process is started by the bootloader which does not wait for the boot to
complete. This is mainly done in order to reduce the overall boot time
of a DPAA2 based SoC.

In this kind of circumstance, the fsl-mc bus driver needs to make sure
that the MC firmware boot process is finished before proceeding to the
usual operations such as interrogating the firmware to gather all
existent DPAA2 objects, creating the fsl-mc devices on the bus etc.

Add this kind of check early in the boot process of the fsl-mc bus and
defer the probe in case the firmware is still in its boot process.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index d54dd80c6503..64d75eed0d34 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -66,6 +66,13 @@ struct fsl_mc_addr_translation_range {
 #define GCR1_P1_STOP	BIT(31)
 #define GCR1_P2_STOP	BIT(30)
 
+#define FSL_MC_GSR		0x8
+#define FSL_MC_GSR_BOOT_DONE	BIT(0)
+#define FSL_MC_GSR_MCS_MASK	GENMASK(7, 0)
+#define FSL_MC_GSR_MCS_ERR_MASK	GENMASK(7, 1)
+#define FSL_MC_GSR_BC_MASK	GENMASK(15, 8)
+#define FSL_MC_GSR_BC_SHIFT	8
+
 #define FSL_MC_FAPR	0x28
 #define MC_FAPR_PL	BIT(18)
 #define MC_FAPR_BMT	BIT(17)
@@ -990,6 +997,41 @@ static int get_mc_addr_translation_ranges(struct device *dev,
 	return 0;
 }
 
+static u32 fsl_mc_read_gsr(struct fsl_mc *mc)
+{
+	return readl(mc->fsl_mc_regs + FSL_MC_GSR);
+}
+
+static int fsl_mc_firmware_check(struct platform_device *pdev)
+{
+	struct fsl_mc *mc = platform_get_drvdata(pdev);
+	u32 gsr, boot_done, boot_code, mcs;
+
+	gsr = fsl_mc_read_gsr(mc);
+	boot_code = (gsr & FSL_MC_GSR_BC_MASK) >> FSL_MC_GSR_BC_SHIFT;
+	if (boot_code == 0xDD) {
+		dev_err(&pdev->dev,
+			"fsl-mc: DPL processing was not started, DPAA2 will not work!\n");
+		return -EOPNOTSUPP;
+	}
+
+	boot_done = gsr & FSL_MC_GSR_BOOT_DONE;
+	if (!boot_done) {
+		dev_dbg(&pdev->dev,
+			"fsl-mc: DPL processing in progress, defer probe\n");
+		return -EPROBE_DEFER;
+	}
+
+	mcs = gsr & FSL_MC_GSR_MCS_MASK;
+	if (mcs & FSL_MC_GSR_MCS_ERR_MASK) {
+		dev_err(&pdev->dev,
+			"fsl-mc: MC boot completed with error 0x%x\n", mcs);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * fsl_mc_bus_probe - callback invoked when the root MC bus is being
  * added
@@ -1054,6 +1096,10 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 		       mc->fsl_mc_regs + FSL_MC_GCR1);
 	}
 
+	error = fsl_mc_firmware_check(pdev);
+	if (error)
+		return error;
+
 	/*
 	 * Get physical address of MC portal for the root DPRC:
 	 */
-- 
2.25.1


