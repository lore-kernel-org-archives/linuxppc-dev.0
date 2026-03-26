Return-Path: <linuxppc-dev+bounces-18800-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0DF109E54B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:28:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDNx1hs8z2xlM;
	Thu, 26 Mar 2026 17:28:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506497;
	cv=pass; b=YPKfpr/4C+Dtg8OHTJ/e9OWvPFut1nLB3M7AiEaJeAXwzl8WdVwjsVahl+lf6uqnceKBuzY2sdh0LEEgjGdp63MLZdnR4uHkhEdMryLvLpjjfdNi8PWQg2y8bJRyTpjVyERT0cCzFd+VtcRIy/rByn4xg5Z8zsR28PiwIhdIOMH/gINIHCYsAp4t6qeNcMesUZAFcLtppzJMtdRvQbduq1FWgUZrQP7TxkHj9533By6G4Llk/WpQKZF7g7qP5He/BI2rTYypUTvZxrCKfXAfilATxLWqAOJ5rB0BzOGZNVCc9fFlWF+HkHPyQ0Ys/mePgHPbJ4t1Hlyw47NEyjm0fg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506497; c=relaxed/relaxed;
	bh=3ZeZ3dPwS0u+xryUhVkkEBmIqoBeIJKKHZEGRC4U5Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C5Vpjpj8RJ2n9bdMgw/xS8ZrJV3j1n0PhHLq0LgDmzrv/rz5l0oTuSfbZ9l6wQmhOks7NwJAPtm1cBGTl8vCS5v+UqUj988R0JFK2nHNRLz4VHaWZy8BPSt2Lmd6izSeIQKi+H+SOTM6JZbfCoXpV2hOwmyOgzpqlLlIFoXySe9nOMQ+o4sYcwQvZ35tgwGiEm7Dfvx+iXn17VxKop87x0jJzO38ebx+m1pQw0a1sPZfttKQAmti9kFaJiSkMnRvwmcpLsijo48HbOkRgzgDN/tmOtYOZtfswrMuwHfAH7Ov8w4743lS2nCHaAN52vfYvdHW6VCGCL6hPbiaovw6AA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=f7buAz7v; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=f7buAz7v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDNw2YN9z2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:28:16 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irbI8CIW16sz3a7BcCBRjoa1ID7Ke63RjHLQC9n0wyMR95XcyKPkIu/tLbHshYX1LmNC7XPRz4b3KXE+8FgGitUmpj2F529C4w46xQf3cUCwniAKpMe+jxZNYAYCqdxKRWMMKZkdqV9Gp1WOXJeqlMlnLxqgX8CMj3ocTP6U5UzGqt0MPHptdlir4UOyQPysgI2z+TxnmyHg5TEkD5IYCJMqG0x35jr7N8YROZZGxfGzj+Zay8uyXXaPbMSoHv79fEpZgIthchakaObcdua200ltDbBGkiLfldKUBECHy6PJNiGPCFD/rvwVX8xh+LsIP9Lk/L7unVVPQyr1sslb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZeZ3dPwS0u+xryUhVkkEBmIqoBeIJKKHZEGRC4U5Ck=;
 b=WEHsfaO6IYgtHOcS6bHjsmbksXP5Uo3zYlg9eajSU3Kq3RiN71F3L7vGbVlpJltbybtCwsg95Hfhez9D41dPLoi0thSHn5n+px1JBDiugUujS7Kyz9DI4kT01DlvWTlh/7vWDtK8u1tsqLqfJhZH2anRjOV/tmM/G37fgcF7pxvkKDBQZNJm138lSvhDM/2A734+mBHaF6Uk05bQ5OxAszuIpXyrx/mEESqrFdyp0Rgu1fWE1SMwOJEgO+QsjNvNwUuVCQw+OjTksjECTwDUiFJAyjwoTABezyg2qN/JxW4rmzDtfBzrsSHfknCWOVR75T4KrXbAFCGa5+TwzmcAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZeZ3dPwS0u+xryUhVkkEBmIqoBeIJKKHZEGRC4U5Ck=;
 b=f7buAz7v6or8e7ixMuDdcAIuOTa/P/wSFXH7PbU5WF8afMyMVmL4seYZ0vWZ5ZM7Q2wtTHYinyVhvl6xaGnFcr8FYIWevOpQb1bloAOB5nTesdU0wq0wWpLbQv0z2v0B463Ld9FL5Uh8BY3e3PSbxJtWMW30qo0EZV1l6pKHwU0oRF8CLzve4dznjrSCFS1YUeEFG08ZianiY8aKxyluchoKALqGMqDFjU1TJYBbVzwOnIVdm+UF2nUgSZ0Ka4bmOQLrhtole+5O2iz7A0PoQV7mKyAjvUDbBavoniuh6W4mO4B0X0htMVfm6vh4jqrYXOJA3P5YyUNTBR2fAbkx+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:27:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:27:58 +0000
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
Subject: [PATCH v3 net-next 05/14] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Thu, 26 Mar 2026 14:29:08 +0800
Message-Id: <20260326062917.3552334-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6d3774-b240-4a9d-24d8-08de8b00d19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|52116014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	75AFey6urIS1yWd6enXwY6KFF1Ysf/PNYbFYgIZdcXxNrCyjHb7DAA2G+S7cd0HCLAWdrYq7GMjkl1y/9/FTW0Jxps4bNiGEVGn1wppCusj3C2GZaDONI+LZu6DiQWseiLMVoxI+CZOa6JWF032C+Wa6lzqC55fEhWkZGP7CI4F4JrIokf/vbg7AKHyr1PHknX3mppjER4iRf9zz2DTreon80lDqWUOF7Bw2Ey3+4vVdDL4LK+7a5Rz1NC9nEtQ5dc/YE9wXiXU9rYtLQFnWbYrhV5oVvoDshOi2QAAwI3Fu3X/p1gFbRHujDKxx7V3q0hVG7zVYOrDQuOTlPYBUwwPYZqIfqiloQiwHEGwUVuRN0Oty06MltveokUxOdrczEsd/jb0cwaI40Li3+9aHcSKfkHUYVDUQhPhNBT678yZ0S2+UGTkpywrvXiwxMWYtZBWP/JmkmzNISsTKr3Q9BaDU6nBlgbJpKSfY8cNme3yXMP2NmlOjfRxi1+frfoC4rgxP4YxQmTwnQ1rqk6DumIOsYlqwPdLDMzpRLhkvgIo3G6WuBHVKQBX9yOJ01WjfUOhIR9/j2II7KqpEp/D92BP5ZbAMXhxVuDxh+zrlEjWRgkGZl12SZNbYMSCFw4goy5Mxs+Qz2WffDIgNxBPhPm4otjet4MC4LDwKDkdX6twSJpeT4ehxSgH1g73VR/slTFBqSmtYCZAKJphdfIyaw2zDFi+295WLJ1o3/san7kZOaejpOC3uq8n3wGLPRRp0n/FNBqHtsJW09bL/aD848I8phhR8Les/rD0algOnFczAwP6U3+I5G4Zn3DzFMXQ7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(52116014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rsKP3Xg34pKWSZQw9C1bmE2CbH+tOk53D/ZJq99ac7JJVo3J9I3wWS72lVfH?=
 =?us-ascii?Q?aIuYgU4yqoIfASDunlGNn4O2af076WWmkIOqfTYzB750YldesdzbN2GAKfX3?=
 =?us-ascii?Q?ev3aofLM45jfYSWm3+Dreg5T06s6lsCELks1sjKtEq0LcM/SvvoIBQWjso9n?=
 =?us-ascii?Q?zOnwnGIdAg37V9sEOvSWcWtytSixT9fkJv8fjf08iEgyoendw1FG7ge63bpS?=
 =?us-ascii?Q?49x5bdi5eChdj+AmcRYLlMgboeeFmyFapklmxkaJFHEE1MLYSQyRGFvJBvwJ?=
 =?us-ascii?Q?LF6bXmKhuD9NloKg6LrwrYWXtyXjF8fKqAnOka2jSLpd+nU1vNJDp7vQUKIA?=
 =?us-ascii?Q?ChvjjlCjHod6fq6jm3ma2/FD/sTGepfrnuaqewoZBiae6JspfwYbofzZjzSh?=
 =?us-ascii?Q?4jAtNHXSMsObioovLxwZ2U8LXnqVl7cO3Vk4d77Kb6MCm5Q8BAFRnRLn1Jr9?=
 =?us-ascii?Q?Q+TcSrELFjjjgOGXehLV84jEv5RPVQEkqptvPPiWjnHHA8HG6xSN8+BCyz4V?=
 =?us-ascii?Q?sPl+Gdek0CHZYhUyU37sftLqw/umbDsAgf1YEXoBV2NM0qlwTNL8Lm1CyLRg?=
 =?us-ascii?Q?9n2ezgXQYChF2Tucvfm+GozAkLQEOMiJ1AJSPr5BUJ597dAw5rGXwFSlgxMQ?=
 =?us-ascii?Q?+itOJFZzFx6pNAvFQYflVOeSjO9mHAgsqlN5gRI/K2CxLf5e7wsdjdoHQnmK?=
 =?us-ascii?Q?H8Iy5svGSrv7MK04YOgGd3OSWIGjj9/VzbEq87xnhC1NE9gQQ7hX4dgFK26t?=
 =?us-ascii?Q?6hIz0yL6zujv8A7zOF9DsG7VW9lbhCpuSEVOCTaDdgtZaPUmdDejznHYVUiB?=
 =?us-ascii?Q?1CuJrjM/HLswreQmusyAB21R3j7NPmTAabNP7dkeB0ePdbwrQiJlUWeLOOGm?=
 =?us-ascii?Q?dPNiBA2/qE4pcNJV89/zqCQIoem2slYp1amrLeLvv2TXzYOnoNSEoSmk0/uN?=
 =?us-ascii?Q?h+d43HefHwZs5BJ3xe7MrLZra2U73u2jjkg5uEFdATjuQWzUCji+dglRApcP?=
 =?us-ascii?Q?KytclKku683lOGWHYb67IZ3A5q7SFDHn64XyGQrYsvLRMYGmLzwH3zGcmPS9?=
 =?us-ascii?Q?pa0aQcmbWMlUybi8hDHlYn0ek/BVJS/J4D8zhWLgYE/QhPrMylHYe08vwIPC?=
 =?us-ascii?Q?NzY9FytTLme6Rib+Mnbn/mCsUL5Un8q3F8F8/d2FH1UgBfhEzoNItidjzF6X?=
 =?us-ascii?Q?T63+GpYlow9zx+StWucBIPwdjD2oIdYLNjuhilIkRebQ9ADw4wnD5YuvK09x?=
 =?us-ascii?Q?78vc1z9ytUwu2GQlu0xskvmHMSwi18fYB1B6oI6ER3c003wuF8ac60FwGaA/?=
 =?us-ascii?Q?+W+R+S402a4hmm1Zvi7TCeVjIMvbTX/wa0715iNgd8Li/lcmv+inNqoama+S?=
 =?us-ascii?Q?lcmGthPEedwqWEFCnMXzmfetXcHERhzRoy/e2pKHwANA2p4C7acSTsddv4em?=
 =?us-ascii?Q?5l72q1paV3W5zt3weMLedzzsvh7avW6/+IK54Wcj98YyYIzb8+ko2J379qc2?=
 =?us-ascii?Q?RCpyFwdWT870Wj/otQ8CBBpuSac0ZTCTvQSqistvXmgqzcN069Bk7iM4sJRY?=
 =?us-ascii?Q?m33XPAS+a9+Emvsp8he2ZBkUaGfUGBlvw7rQwZ+6g6UbJRw/5HEDRylDPFys?=
 =?us-ascii?Q?cTLkcx6hqCoU5bIXo+S7WVkk0bWdhtZBOyMxJN5+DRnW8eS7SxDIzDUvMmpC?=
 =?us-ascii?Q?2oz2bu/VCBC4X03PnMRCb+fmFdobK8O1rt6I0JpWhLnuoK4p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6d3774-b240-4a9d-24d8-08de8b00d19e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:27:58.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6b7IEi+wxzdY5qkK5lQcw2xxAM6Hkj/7yKuuoluli7BGd3bGSMP3v9ccGBQEdNatIzHrgha9bxCiLDhtEKrxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309

The VLAN filter table contains configuration and control information for
each VLAN configured on the switch. Each VLAN entry includes the VLAN
port membership, which FID to use in the FDB lookup, which spanning tree
group to use, the egress frame modification actions to apply to a frame
exiting form this VLAN, and various configuration and control parameters
for this VLAN.

The VLAN filter table can only be managed by the command BD ring using
table management protocol version 2.0. The table supports Add, Delete,
Update and Query operations. And the table supports 3 access methods:
Entry ID, Exact Match Key Element and Search. But currently we only add
the ntmp_vft_add_entry() helper to support the upcoming switch driver to
add an entry to the VLAN filter table. Other interfaces will be added in
the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 50 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 19 +++++++
 include/linux/fsl/ntmp.h                      | 30 +++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index a4a99954baf2..d7d8a37078d1 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -21,6 +21,7 @@
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
+#define NTMP_VFT_ID			18
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
@@ -231,6 +232,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
+	case NTMP_VFT_ID:
+		return "VLAN Filter Table";
 	default:
 		return "Unknown Table";
 	}
@@ -652,5 +655,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct vft_req_ua),
+	};
+	struct vft_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.vid = cpu_to_le16(vid);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to add %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 8999eafe1920..d2a6399b0a36 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -160,4 +160,23 @@ struct fdbt_resp_query {
 	u8 resv[3];
 };
 
+/* Access Key Format of VLAN Filter Table */
+struct vft_ak_exact {
+	__le16 vid; /* bit0~11: VLAN ID, other bits are reserved */
+	__le16 resv;
+};
+
+union vft_access_key {
+	__le32 entry_id; /* entry_id match */
+	struct vft_ak_exact exact;
+	__le32 resume_entry_id; /* search */
+};
+
+/* VLAN Filter Table Request Data Buffer Format of Update and Add actions */
+struct vft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+	struct vft_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index a9f3e6cbf422..2aedea17307f 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -32,6 +32,7 @@ struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
 	u8 fdbt_ver;
+	u8 vft_ver;
 };
 
 struct netc_cbdr {
@@ -94,6 +95,27 @@ struct fdbt_entry_data {
 #define FDBT_ACT_FLAG		BIT(7)
 };
 
+struct vft_cfge_data {
+	__le32 bitmap_stg;
+#define VFT_PORT_MEMBERSHIP	GENMASK(23, 0)
+#define VFT_STG_ID_MASK		GENMASK(27, 24)
+#define VFT_STG_ID(g)		FIELD_PREP(VFT_STG_ID_MASK, (g))
+	__le16 fid;
+#define VFT_FID			GENMASK(11, 0)
+	__le16 cfg;
+#define VFT_MLO			GENMASK(2, 0)
+#define VFT_MFO			GENMASK(4, 3)
+#define VFT_IPMFE		BIT(6)
+#define VFT_IPMFLE		BIT(7)
+#define VFT_PGA			BIT(8)
+#define VFT_SFDA		BIT(10)
+#define VFT_OSFDA		BIT(11)
+#define VFT_FDBAFSS		BIT(12)
+	__le32 eta_port_bitmap;
+#define VFT_ETA_PORT_BITMAP	GENMASK(23, 0)
+	__le32 et_eid;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -118,6 +140,8 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -183,6 +207,12 @@ static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 	return 0;
 }
 
+static inline int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+				     const struct vft_cfge_data *cfge)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1


