Return-Path: <linuxppc-dev+bounces-21086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFA5CD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:24:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrS51sClz3bsy;
	Mon, 18 May 2026 18:24:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092645;
	cv=pass; b=czH9P2C18uF+TgQ28afL4y4yVlRPqRqaeSq+LxAXigGwgloJbxpgQE+WWMcF9LoSLednwX2Cu+8tVa0+8QEMiVO7laIRPoxdX59WekqIEDP1st5m3FkUGxxaWhhMduxFdN8fggb2IXJ8kYIlYzZwNFsyzgNatVPzd8DwR8ZpavpTQIviBypFrARVeIGKBkoqeZLE/0FNxnuxz1EM9MI+DMAiuCCFdBVpDNauBztztgGSgP2MSbprEENOStlc97xjkdl4pzGDKFeZ+z+6TMzFQGzVSX/K5ev9M2fXg9U7+I511mVEfv54IDELJzQCFFRe/QW8PhfiyONqfRLyDl8Hmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092645; c=relaxed/relaxed;
	bh=yL/rZyN7Po+Of5X2h1TC+jbjqAclIbX2sJ3uJsm/2zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VHwTWPN/LZDtwOdte2VvQzrfRxUjyMDD/45rfbBxVlwjQ9zdfRVHB8HktjS9GBsC0IBtxB4ydSJ6onjNraHG2eVUzy+oxOa2f28nlqP7eAZ3ZF0XoElX368iXqb5+A9Qjn6em9YNOculFUBYd/rjXyKXDWazJRC/T0ND0BlfT/dZdkKF6EZxn0fx56jGVw4x3Tm8jTg2/1sJU/gJpikodjQcd+bfLA2WVHmbbN/xix4R2JE8pkqyvimBrSWxwHR/xWDEqBe7QDF2P3jAUOsDm7pjoeRHBwhIlj22FATaKLNGKiiJ2rCqQP94UajZ1QpByiPlys+ZVvq6tIoYEkag5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JIww6t5I; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JIww6t5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrS414VQz3btc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:24:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWYDdbIabk04INIav9JFcMZQB0W7MBgav4SN99WBvgR+tPSFBeh4JOPOHc25Ki0sLcs8k9opeBC3R99SqqHrYnr4pfTuVcC1a1px7s/KusidUIOjxOcXx39rKp4+RBNXhT9beoT4WP7RcYIwj5lSQhDDXrEP2IYS7ZOn2I85e9gq37qXNCuH7vLGzfupmUl4sS0DvXwjT7nlQEvMwRFOlyk45He8PSljrV6hcHBKQCn1zEEGiXrAf3v42jhowf5AEMNIXIz5P9vDSY+Us6nGXX5D1201Iwy4u1xCUaJpJo59V9FtGnD8k4HLqJiRtPuKWd2n/rcgw2bgzPcrDOHCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL/rZyN7Po+Of5X2h1TC+jbjqAclIbX2sJ3uJsm/2zw=;
 b=wpm9+nlQH/1WJnMdYmBy/3+/fPneEHQOOwHqVnvLjbKW1QSsSbz/A9M0JhCUMuS/8k2bBQ//baa7YmsT9wlmqtyaW9aiTyvmMYg2IM72te4ZkNjhZyNvEvNM1imRAh4XOpPzszmdZzc4L3vdbtTvusjZRRhwh6DFVA8vmdU8hx9d9Obd8KOEUlMvXeOBlCjkCcrey+g7VmLcL6+4/Tyz+vivDeqjPqfkoR927hpYt6WHCOXc+pZZe+FnQZknzka1K5KDKh65amUA7jIN8bP/waGQB0XjQRlQtNtBmsuUgcSN73n6u2SonrT1WGQNNQewuoSZbZD7ZeuVJhHlgSmqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL/rZyN7Po+Of5X2h1TC+jbjqAclIbX2sJ3uJsm/2zw=;
 b=JIww6t5IkSg3JaVdSs0Fiu9mEVJOzUy1BNymXcuhj07+mdZHrvY/18zumdmNWJOo+pHwKOfJ5PKdx07kack4d66+aPuLwZEZIzjdFVP8k0f4zC9ZtA1TanESOGNpxbhH+W0zjaHv24oYbLjVF4lAV9ecjKv0SCpAWxn0xdCAmHXV4AZ3c7Ek3+keduzV/JBcy3Afz3pkdX0V57554UmQdTOucy2E+85BB+U9AMJXfu3dl29Wjg5N4sp9BmetJ+9+mzFnu4ELCER38KJzO91TorvrnG3uaZ9pUPl+sBL1roIoXA9lp0czWTvIzgjTmu/+v/J+n8gAlkSM7xglfwU+iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:23:48 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:23:48 +0000
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
Subject: [PATCH v8 net-next 07/15] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Mon, 18 May 2026 16:24:58 +0800
Message-Id: <20260518082506.1318236-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5d16908-e825-434d-4281-08deb4b6c8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	XuN4i3hf31b019edV/NMnp1/WNepuOBd+VyWsZTa2ED+9pg9TXCRVKUbh4rWZYqdExlMxynMrh8V2ACs/2dtu6Ubs1z6uMIrG02guyIlsap9TPGEVBq5Q3vOBsC6U6lvEvnnmwVJKWqS+gWkzr0SVv6DDdrn3q7d9j25GYO7xImxCbbxZwNEfFH3XaewJbnP5ZpMJHegksfEuGnMUGuqMZkkS+Hiv7mdbTcSXyaLkwMS8Gtf711jVTIDqWvLgL4XnNejseO0FxW6zQ1KRtR5Gc7sB417lRvhS3H0r2Yuxs7nr6a2/haY9S5tNCMcw7vEnM0LZBcTrgjK55Fs6hCeeW6y1qCjP3MBfGlmIS5qYRxXuFiK77+z9EwhNPL+2ZyJnXWalsmT9S25G2EnJX+Z+iZnFY3o6tX0+NQJXLz8+uNxiox1Fmfd99El95NDd1+scf3AMGSs+0hxX88K8dJVH/G62+1VtONj8Ihy2bPvLWBnifZfWxz/JwEGZXhdT2uaZ2YmhVjEDJIB1LTL/Jys4Mv7wc6rDWHCgrcAcgywUnlHFpqYRDq84e9HRMzFcdcP64NEQ1OQ/VvVLVMPmMRfySvBmssGs4sh8VjLxur2VkCMhYTUnz60A2qwaVfEK6N4aPRSKFeER9xZv5R4AkpZKeiqdd4gsexEh1xouS73gNUp5brEZkqRjdcSX0wXo9AoS8NiXDYd7h32kay0V/RjPMXfrFob/T7jdms0HEUBwnpkzIUZ1xn1MO6rxC1sWm2TrlsZM004zLlnAsCfSH/zug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4o6Y5zAxAIIXeBDmwg1VH/vq7fDZ2t8bFoLXFaclIxuVSF86iOk+epzUz47g?=
 =?us-ascii?Q?tMmtti3eJ9cVqJeOP3LsOhf5KKtbqMi5EAX98IUYXxkwUjSNX8A0Tcbf07Xk?=
 =?us-ascii?Q?KPnIxL4epsKWntuXjiLLWlJAaXkqZtgzk1l4VAEaGv8u9apF1tLArzSvLf5D?=
 =?us-ascii?Q?+CQXF9a89Q59m80TT29BkUp8O8yDRD305Co9kzZmFiIWU+J+23Q4PkHUvYJE?=
 =?us-ascii?Q?Po8HLeSlhsjf45+htcf7BbjJyApYx5WGtmkNFyE7Xd8G6+PLC2D6K+CtfPg1?=
 =?us-ascii?Q?HyZpvaFuD6Fx68ZNwK42xiLjoSWNRA1XDw2ucdHqldJFtQJMPoRkhqJC+szH?=
 =?us-ascii?Q?Hi+RrYxseZgTX9+rzRsdHLMHefCKTWcAnoYXSi5M0z+LJ2qeXszlnRuz5UFN?=
 =?us-ascii?Q?WzX13FvzbWtRDtaB380Yi8u36ukC1+OQPU3Rasp1YOlmkRgGhxc4axGDS0Ck?=
 =?us-ascii?Q?PM5vn9oYTn1BJCnvFtMEJG7NUV2YssgAt0XGnTSZY0JQvwt5bMo+gOgt+VcX?=
 =?us-ascii?Q?I8lx65waixHeEAkL1ko3qJ2nkFgGepqxA9+2ngCKPQBtvLi6VNZptGT4dOvH?=
 =?us-ascii?Q?pilREje22cr74IJIPSH87Z/XgOOJAvov2oaF3UQipm4gVFKSaHBsM1EPOXoR?=
 =?us-ascii?Q?Blg7yToF4S5AMHXEPez20zra3DfUAP1bLj3Bl3q38MdNTOkv6CyA39GGk3JK?=
 =?us-ascii?Q?BIoNZDAFzxcDFQmyR0UnzlYUvehUo5bKYLAs89jCgiXVddpsaYL22vQPgH73?=
 =?us-ascii?Q?/iLA2k/VApTjhe0nmg39gaKwG6ItrCRxzhdPOJyafukB8PcWD6M0oZV9yPiw?=
 =?us-ascii?Q?dtV/Xnoj0LFX35TQmlgMqhuIBYIlA3q+x7DTJHVkaFrlGiLqNMY/8iPvSQpx?=
 =?us-ascii?Q?nrikW3tPQOBZnmJhUCdvaKXLFRXqQwup6byZfthnEl6IeTEXNDCgxMz6I1KF?=
 =?us-ascii?Q?bYBY4HALYaJJR3I0FilZH0kr8Nlld2W55CnSISC1L726OjZAVbRUH22h/CCh?=
 =?us-ascii?Q?xI6Qwsq2SIc+bupRh32dkZFyapF84gXGlNfvs+b8d4z9nNKzrHFj0TLv0n82?=
 =?us-ascii?Q?QC32OjnidnYG1r9off6rluVOKWACQbP80jQYFHjE5IJpQN8shmWcrHp2hvk3?=
 =?us-ascii?Q?MWvIvMS+kfnh+OQKUtW9+R4dsQrukahHDOZ9n+EYHIyFvYELFzG21nbenwoM?=
 =?us-ascii?Q?M13O00PfGarloFr9RClmUcY+XWSh1JW6KzzndPmuSTKK0FuKa7wlUQvTXW86?=
 =?us-ascii?Q?79sczgzy4UXYTpWRoVvR4ChBqGzXtAyezhBPb5z9/n1+B0r16EMPXGh6PJeY?=
 =?us-ascii?Q?o2qcv3SsVZV0ZzJhpXjBdu6XJLlgpGX/pwWojWm06AxEkU8LbhNs9r5xn3Ai?=
 =?us-ascii?Q?uj6yMn03rlMK/JcKS6Gtecy9mVR8wTFMmkGDWv5jOqO5hv/GJ6bDngOA6cBD?=
 =?us-ascii?Q?X8VZiow8ZlbL3ZIFUuZXgZSoB0LgvpCTrmZXJ5Nfe32AniaLXoYwx1TFYkz2?=
 =?us-ascii?Q?yoCTt9o1PYyDPzZ7okHm8fYIhsJ1xZOnNZ0AKYtf/uhS9/Uzzjwk+letidgT?=
 =?us-ascii?Q?j54Z9BO3TEhC3bgQkPPrz8JxRYDHDrSe2EDFBNP7PqQd6enZ3ZEiYu0Azu+s?=
 =?us-ascii?Q?OPO0mG/6Mo8zj1hi5/nWQ5lKKhs8h0bxQri8Q8Kq0clRtxSrGYTqr6goZSqg?=
 =?us-ascii?Q?+r9D18LDLgGtRlHshRjy3MRCQKpbg2YbTPj0VyJnXqb0YQxsD2EhRnAb7s+n?=
 =?us-ascii?Q?2CnBXWrBNw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d16908-e825-434d-4281-08deb4b6c8ee
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:23:48.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nphDOUujfALpaDXbKqVB055U+kE+R9JoU1JJHc+mqC2qwXVUSCourw4ZyEmsSqhI1GAWZj3MC7eHpGrBRC+qqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

The ingress port filter table (IPFT )contains a set of filters each
capable of classifying incoming traffic using a mix of L2, L3, and L4
parsed and arbitrary field data. As a result of a filter match, several
actions can be specified such as on whether to deny or allow a frame,
overriding internal QoS attributes associated with the frame and setting
parameters for the subsequent frame processing functions, such as stream
identification, policing, ingress mirroring. Each entry corresponds to a
filter. The ingress port filter entries are added using a precedence
value. If a frame matches multiple entries, the entry with the higher
precedence is used. Currently, this patch only adds "Add" and "Delete"
operations to the ingress port filter table. These two interfaces will
be used by both ENETC driver and NETC switch driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 80 ++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 36 +++++++
 include/linux/fsl/ntmp.h                      | 93 +++++++++++++++++++
 3 files changed, 209 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index ad89be85b185..635032d24dc7 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -21,6 +21,7 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_BPT_ID			41
@@ -271,6 +272,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_IPFT_ID:
+		return "Ingress Port Filter Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
 	case NTMP_VFT_ID:
@@ -513,6 +516,83 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_ipft_add_entry - add an entry into the ingress port filter table
+ * @user: target ntmp_user struct
+ * @entry: the entry data, entry->cfge (configuration element data) and
+ * entry->keye (key element data) are used as input. Since the entry ID
+ * is assigned by the hardware, so entry->entry_id is a returned value
+ * for the driver to use, the driver can update/delete/query the entry
+ * based on the entry_id.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry)
+{
+	struct ipft_resp_query *resp;
+	struct ipft_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*resp);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Note that NTMP_GEN_UA_STSEU is used to reset the statistics of
+	 * the entry. The STSE_DATA is not present in the request data for
+	 * 'Add' operation.
+	 */
+	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
+	req->ak.keye = entry->keye;
+	req->cfge = entry->cfge;
+
+	len = NTMP_LEN(sizeof(*req), swcbd.size);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_IPFT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_TERNARY_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_IPFT_ID), ERR_PTR(err));
+
+		goto unlock_cbdr;
+	}
+
+	resp = (struct ipft_resp_query *)req;
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ipft_add_entry);
+
+/**
+ * ntmp_ipft_delete_entry - delete a specified ingress port filter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the ingress port filter table entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct ipft_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_IPFT_ID,
+				       user->tbl.ipft_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_ipft_delete_entry);
+
 /**
  * ntmp_fdbt_add_entry - add an entry into the FDB table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 64df49e9a3ef..0a9b87286105 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -99,6 +99,42 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Ingress Port Filter Table Response Data Buffer Format of Query action */
+struct ipft_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct ipft_keye_data keye;
+	__le64 match_count; /* STSE_DATA */
+	struct ipft_cfge_data cfge;
+} __packed;
+
+struct ipft_ak_eid {
+	__le32 entry_id;
+	__le32 resv[52];
+};
+
+union ipft_access_key {
+	struct ipft_ak_eid eid;
+	struct ipft_keye_data keye;
+};
+
+/* Ingress Port Filter Table Request Data Buffer Format of Update and
+ * Add actions
+ */
+struct ipft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union ipft_access_key ak;
+	struct ipft_cfge_data cfge;
+};
+
+/* Ingress Port Filter Table Request Data Buffer Format of Query and
+ * Delete actions
+ */
+struct ipft_req_qd {
+	struct ntmp_req_by_eid rbe;
+	__le32 resv[52];
+};
+
 /* Access Key Format of FDB Table */
 struct fdbt_ak_eid {
 	__le32 entry_id;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 5fded868725f..88166f9ad3a2 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -7,6 +7,7 @@
 #include <linux/if_ether.h>
 
 #define NTMP_NULL_ENTRY_ID		0xffffffffU
+#define IPFT_MAX_PLD_LEN		24
 
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
@@ -34,6 +35,7 @@ struct netc_tbl_vers {
 	u8 fdbt_ver;
 	u8 vft_ver;
 	u8 bpt_ver;
+	u8 ipft_ver;
 };
 
 struct netc_swcbd {
@@ -73,6 +75,94 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct ipft_pld_byte {
+	u8 data;
+	u8 mask;
+};
+
+struct ipft_keye_data {
+	__le16 precedence;
+	__le16 resv0[3];
+	__le16 frm_attr_flags;
+#define IPFT_FAF_OVLAN		BIT(2)
+#define IPFT_FAF_IVLAN		BIT(3)
+#define IPFT_FAF_IP_HDR		BIT(7)
+#define IPFT_FAF_IP_VER6	BIT(8)
+#define IPFT_FAF_L4_CODE	GENMASK(11, 10)
+#define  IPFT_FAF_TCP_HDR	1
+#define  IPFT_FAF_UDP_HDR	2
+#define  IPFT_FAF_SCTP_HDR	3
+#define IPFT_FAF_WOL_MAGIC	BIT(12)
+	__le16 frm_attr_flags_mask;
+	__le16 dscp;
+#define IPFT_DSCP		GENMASK(5, 0)
+#define IPFT_DSCP_MASK		GENMASK(11, 6)
+#define IPFT_DSCP_MASK_ALL	0x3f
+	__le16 src_port; /* This field is reserved for ENETC */
+#define IPFT_SRC_PORT		GENMASK(4, 0)
+#define IPFT_SRC_PORT_MASK	GENMASK(9, 5)
+#define IPFT_SRC_PORT_MASK_ALL	0x1f
+	__be16 outer_vlan_tci;
+	__be16 outer_vlan_tci_mask;
+	u8 dmac[ETH_ALEN];
+	u8 dmac_mask[ETH_ALEN];
+	u8 smac[ETH_ALEN];
+	u8 smac_mask[ETH_ALEN];
+	__be16 inner_vlan_tci;
+	__be16 inner_vlan_tci_mask;
+	__be16 ethertype;
+	__be16 ethertype_mask;
+	u8 ip_protocol;
+	u8 ip_protocol_mask;
+	__le16 resv1[7];
+	__be32 ip_src[4];
+	__le32 resv2[2];
+	__be32 ip_src_mask[4];
+	__be16 l4_src_port;
+	__be16 l4_src_port_mask;
+	__le32 resv3;
+	__be32 ip_dst[4];
+	__le32 resv4[2];
+	__be32 ip_dst_mask[4];
+	__be16 l4_dst_port;
+	__be16 l4_dst_port_mask;
+	__le32 resv5;
+	struct ipft_pld_byte byte[IPFT_MAX_PLD_LEN];
+};
+
+struct ipft_cfge_data {
+	__le32 cfg;
+#define IPFT_IPV		GENMASK(3, 0)
+#define IPFT_OIPV		BIT(4)
+#define IPFT_DR			GENMASK(6, 5)
+#define IPFT_ODR		BIT(7)
+#define IPFT_FLTFA		GENMASK(10, 8)
+#define  IPFT_FLTFA_DISCARD	0
+#define  IPFT_FLTFA_PERMIT	1
+/* Redirect is only for switch */
+#define  IPFT_FLTFA_REDIRECT	2
+#define IPFT_IMIRE		BIT(11)
+#define IPFT_WOLTE		BIT(12)
+#define IPFT_FLTA		GENMASK(14, 13)
+#define  IPFT_FLTA_RP		1
+#define  IPFT_FLTA_IS		2
+#define  IPFT_FLTA_SI_BITMAP	3
+#define IPFT_RPR		GENMASK(16, 15)
+#define IPFT_CTD		BIT(17)
+#define IPFT_HR			GENMASK(21, 18)
+#define IPFT_TIMECAPE		BIT(22)
+#define IPFT_RRT		BIT(23)
+#define IPFT_BL2F		BIT(24)
+#define IPFT_EVMEID		GENMASK(31, 28)
+	__le32 flta_tgt;
+};
+
+struct ipft_entry_data {
+	u32 entry_id; /* hardware assigns entry ID */
+	struct ipft_keye_data keye;
+	struct ipft_cfge_data cfge;
+};
+
 struct fdbt_keye_data {
 	u8 mac_addr[ETH_ALEN]; /* big-endian */
 	__le16 resv0;
@@ -161,6 +251,9 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry);
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 			const struct fdbt_keye_data *keye,
 			const struct fdbt_cfge_data *cfge);
-- 
2.34.1


