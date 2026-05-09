Return-Path: <linuxppc-dev+bounces-20640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6A1CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:29:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMf03Xt2z2yY1;
	Sat, 09 May 2026 20:28:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322520;
	cv=pass; b=MxHKNeTykQKjwWofDgcIPloretGAymoOyPYNJ7fy1ldu1Mz51CvcbTR0O+IJjDYvLUgjyRgqMuYmthjQbLphF7F+fzJ5YGwxJvJU8TphZmOXJQirdcCIhOR1AR/2N7zudHFAYpNwGiprQqbEfIKmeZGpt4QZT5QZ4cZ9uOShnpEHBoAOxISCOKUJRyVkFPeCafZ8v4jXOTIOrgZRleCVmUF2Ay2ygmkBRER0b6CIBJSWi8Z8gw7bcvZzSn5Nam+mRxxSNH11kflZ3no6A7KanxZHEPnKarj7A4fFNF+QCCec/QPdXFHx32EBnvK0+GbyS+hkZmL7TukdgLehbls8RA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322520; c=relaxed/relaxed;
	bh=L8Ydddx9hpv3J6X9wC9v6Cn5MfAvXjmwpRFuP2kfqxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTq8HcZDhrIZklsiT20UixvuoDLqOG3X/Eez2NZbbb/r95uZ0I41Z/89O/IYGwa/NdwF7zIxjxXJ/aFxx+O2hfCdKInAiM+yprrrVubjtVRwmVYD4A+VEI/T+4d51wX7MkG5NoOwwZrWsUSndQRwFkhBsosZE9G0HxyrBz81cejtx4xeqMWd3JM3pFKKuPG6iJoPehD/MN2IOrjC4I9e5g0NfV+W3MZQqWq5pK6iV5bNWXNJ8VMYBGLbAce10UOyNFpbYGvDndLswI6tCaccJfy3D+d267wFdjLbSI8iTrkU+EuH0/Ylu/PsTV1WGxKVfgBn3drZo+uAr3mDP6EVzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OrUluA/6; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OrUluA/6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMdz43lvz2ydQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:28:39 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqNEEGAFYfeFnLu1eEmW1UC7HPEa7HIOaO76uYXYrqzKV7j3ppMebQVvEwbeOKOUmKzCgD2tT85Ti2az6ghc01RRujuqOohuVI7dXfLHh5WnsWLK28TQe34rw0+Wj5CmIwefU76qDDH5Kb4JSGT0ybBhAzLrQrcakPvyBkGmzluW/t5yEsGYlsReEYv1UmRGwFLV6QC4D/wn14NZSf+5Zvdt53JW7C17gP9FR5cEfSxnMA6TGjizm2TyCsOTQTRn007Ap+9xv00cqLxmeGg5adx9W7eUNAulPB1/ZCsTV1WM5clB3jckPboDbvW0ax9lKUVou2dshHKBiFWwml7ZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8Ydddx9hpv3J6X9wC9v6Cn5MfAvXjmwpRFuP2kfqxE=;
 b=Eh35HYtHGu/jVO+aTI7upjIBJdj12iDPQKt5NgwW479w2zqLihHfzkWXbA5id674SSfnLy0dEAkyiOzc1f1MgRfA9ONaFPCpvzWPG4cZltF9afUVEWhsUGs6zJ7ST99KswGlaUoGyno/+EGdzWkcpiZgFekSTTV/96fgnM61uqQKf3nkcPsOsgGpOGSsQgWo8AEpxCKIqnsCf9GD/A+m3wg8ZO5t5mW54gQ03pKyysOIi0ci9RNlsrR4FyRyNs42gxnxm4RP+cBiih1Du83Y21C9nZFHKR874aFvOcjcQ1Ur9rmWJLd/MuAbjS9udKEMoWX0Mm6szmnzwhnUR22gOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Ydddx9hpv3J6X9wC9v6Cn5MfAvXjmwpRFuP2kfqxE=;
 b=OrUluA/6xsw6+rZEA2iqM7rMzO86LY69SJtvUK+6PGmJiV5TiDFtAlaVAzu1pNy9PmjBn8aO6QqrfqmqFcL77CabJtVI408xQsEnmzvNVcMAenYq0LS6GvDhdOY2rw8cur7p14kbRdSnNHRMw09OOdLb5MVzgVj1BgGijBf+Idn5d603UThU3i3eB9J+cHfRRHFIvC0OuQGd8Wf9di29wdyCEA+YDoVSSd3icqn/7eGQXqX9fHZ8p4DDUSHUxke5kVjcVqO9X6nSjBdG5SwFzv4874ENQkI0zemDnL8/PTFoRzTtT/2OeVtI69+mKVQeXzCDUC5L9eq+QBuSynM73g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 10:28:30 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:28:30 +0000
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
Subject: [PATCH v6 net-next 07/15] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Sat,  9 May 2026 18:29:46 +0800
Message-Id: <20260509102954.4116624-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102954.4116624-1-wei.fang@nxp.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4cf84f-a17d-4d68-c030-08deadb5b69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tvevgxDrWZH/OW4wnbPbbQ+wVhwbCdvRIZAO2nt9JUw55/gliaUgj7E1jpTj+Wo7or8oJIpwZZlnGLJsb8iHKBBAUMpwV7+V8YLXh++Sxn9dzoWw+U+m8WHomq7MsPc43Z8ZEYxScXO38c1aDjL2X6vv9Yqk0zNaKn+1jsodu3QBQPo66f30bYSfYbJETpyg4Q+X4h3NeUAu8PDA/f8a8/fCuPTO4cTze5AwI46bDQLhWhi2YukmoEhxCMsRMQuDpKUtZaDb8BV0llBDUmTmryFDmoAy6EnXTmG0CPCvNiQvCPnXHtAwCkZZeszEy9N12p3xK05Gqvs/ySY6Ie/gKX2lX0Z8h90FzjTOipejT050+NkzdmNewqbLhV9YAIJHaNuVL6SvOUM5sKAlGwIrSXoxR4EhtEPqbQEPmiWkZyt6NZ6UmE8TAB5zFZLHOlVlDMf+K1TMpyuJWmXrdyipQENB1QEO+3KQ44xoySHyjb/BTwguJeFciHEmNmXWYXexX+XxPFmERjo4O3KTofQJPHzsVi2tMt4WvcckkXpPCv4uK6skb0XgGOaKc7xdLdTLYVjBJmnx7Ow/R6wLItSFRdH6gvInP828vxHjSMJFO3KbCl6lTIXGOATpgdRfrS6NdCcDreMFSoKjDYRW5EZBq24Mi1Jr+eWUc+MrDn5jaSFOeyGszHIArY2sEAHL60Oz8esoB29NxV2iK8UvvlJwPrP3ZtI4H+QZPhRBtt9Qbr9qjxUJgJnAZ3aIMuYYT+JFNbcnAB6ztgPeGzeDUGAE1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JsOfEA0xquIPAEgrSWYKcs0zKJWGqUfSEWMHxQy3IA1JwVdlrbCf1E69VSnp?=
 =?us-ascii?Q?iD88vr/FAqJCG6R1Drk/bHSv0ke8OYwl8fXk8KylXhmJRahZpLuXG5QlC5/s?=
 =?us-ascii?Q?kcJqsXh8bNotNf8v0ajEyY0Lu/KI04blwdiJA/9dckFwuGkeLAk4Cq164mXc?=
 =?us-ascii?Q?2WfpYrf83ib10gXRBCZoFZrhm6D8Dg4FcVldi9uDIYGtuxgQzAHIJ1W2cz4U?=
 =?us-ascii?Q?CaqtKfS1EdgVaBZ1KcKc7oT6YnRyjJynZ8IudmikOdhfy7UkjJR1C1T4K5u0?=
 =?us-ascii?Q?auaG+6LmkrnrbGeaqRt0Uk/WlQD/x0GfLFoTHxD7RecJg4WKvYFqgkMFacV0?=
 =?us-ascii?Q?Z4/NY+cqfur4Y3w2vt02l5EsqKL/kR6c2+jBO3VsAc/YTbmiHwjH4RaJUBw9?=
 =?us-ascii?Q?y1w/5KzreUEeUQLGFFaNspN+2my4QYBwE1ypP5vvyxGVpI1tm+3ngoIkYeLd?=
 =?us-ascii?Q?/ORJzstYwwLm7bltbuFFvcbDKkamrluX67HoYydnWI45xuXbeS+2abtnclN0?=
 =?us-ascii?Q?JppniA73EL53KYK6497I7J7kqfiN5c99gTGizSTJNdcjeRY9Sks8HWHxRQoc?=
 =?us-ascii?Q?b9N3JhJxIOvdqHerFF9k6nE7Kr8sUK6/RGYswf9l1h4ZBlWbbsOIlEyeAvVZ?=
 =?us-ascii?Q?JXVnvq+Zfz714bmkCdg3AlNjO3LPYE/c70smHiSOiHAFfQFnAOTSAJ2C23iV?=
 =?us-ascii?Q?gYpLcVr9Irg6yY8NJ6fwx+kuuCUNhywy7N4fwUnnybZXimpKQgmM6J9Qw1K7?=
 =?us-ascii?Q?3QRWNZxC8Y9jmxT9AlUKEi7QBbES/eblbQGrmwDtGxnEooRLa+MZ00bV8wGU?=
 =?us-ascii?Q?7B3Dfm5L3NM75JnFa/28wM7WsoYPOtxkQubwxETfvzbk+N/g1NtZen33PaA4?=
 =?us-ascii?Q?ZOnPvRSiJ/eWYSnYX86Ax370K5NXZiZLeyGZXHQbY75FPXtWG1SbOx0HGSAZ?=
 =?us-ascii?Q?IRYU1vkMrs/Jviz4qcU9MCv5X411Lo4X0nMtzupNWji7IoIWqSTTjp/+OI4R?=
 =?us-ascii?Q?2oUu4zVU1i4bUf7xzibsgdSPEQgHI2yT6aaLS1IhuKURzQz1QbboDp4FSRZz?=
 =?us-ascii?Q?kju8FlD4H5haK7Iaay54Ne0iWdNBEPyPe8faPBbjDIfpj6+Su6hvmLsMcq8g?=
 =?us-ascii?Q?51KBiDGiLYekkxBAW56qqnP509Eok6T272pJI7i7x/iQLQpnkUvowWE3egAO?=
 =?us-ascii?Q?3OEKQmRs41nhfT9+Nye3r7RmMb1sLHT3mG9gcb4bB/8S8/hJ3FCwRNm7UJvj?=
 =?us-ascii?Q?fTcFOXIMVejWrBX5W51sjPD73vhyNLOuEcNxZxkhH6qwXsDcIr9sHSn96zZJ?=
 =?us-ascii?Q?7iMP/y+dQbXgp6KAgGNHXpUMhcaOQoJw70rGy1d9xUYTE04l8UUUChxHxPnu?=
 =?us-ascii?Q?gWF5s8KaiH4mu4QkkNI9ULq8t51DswNyAa7DjSg25DziPFMCxgUJgb8xZMOL?=
 =?us-ascii?Q?kufmgRpCC1snHXLN3xdx/5zOMhRAZ06Pu8FpVSlBDjVnpH6l6BnekmGZ1Nym?=
 =?us-ascii?Q?zs1MDn+sBJRAdxr+5m5+dKsZrDIfDRNMQ7n5pkVdgAQCECGyBeo1DfqG51ii?=
 =?us-ascii?Q?rWMdS3GOsOLJWY2E7rFTyMBdGso3MsOf64NiYQ1qLlAFSSLU5Ns6SOVxlE1m?=
 =?us-ascii?Q?Z7evsxnC0AvxPY0p7Rv9/7p/dKPZecl60T/xWG91LVrqLsL8vLaLW9ZPCVgr?=
 =?us-ascii?Q?b8HDHpQgiYGC5AfpyufhZOcaCJIFOQCbJ2dNNlSgAcpO3+41?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4cf84f-a17d-4d68-c030-08deadb5b69c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:28:30.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CD/eNuGuzax4RxzKYZwrb7JiIcbHibYhZ3U0AQ9GqcIklqivbT21ol5WZVCbx6bK5SPajSDKhZ9dNM8anr/1xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909

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
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 76 +++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 36 +++++++
 include/linux/fsl/ntmp.h                      | 93 +++++++++++++++++++
 3 files changed, 205 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index ba80f5e08d80..c62c6a9d7bfa 100644
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
@@ -513,6 +516,79 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
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
index d74714a402f6..f68551045b60 100644
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
@@ -162,6 +252,9 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
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


