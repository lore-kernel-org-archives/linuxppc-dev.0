Return-Path: <linuxppc-dev+bounces-20638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC27CD343F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:28:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMdx6k0Lz2yVP;
	Sat, 09 May 2026 20:28:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322517;
	cv=pass; b=ItJ4V3dlcsBnnxLiHC6mAMMYQTYEpUxA6WmVrwoMiCs4sM2/x+Ua5JYvqN5Vkv9Q6KizmlOdI1ELX1ktn4ry101iMOCRgSAP7oNF8tH9QfrflEhTorkRjM3yXsn4s+wl7Emev2CKhIz05c+LbL5qbTLt4NjIzISqX9LqTJFAEHbc+SZYpGGuInAWOfB0kj5dB8NcbQW8ZeaDuMsk/BRVRg+/xt2nAS2gHokuHxTEo8FVmJPysQYoZfztWm7wxdfpJgGPqENjGpRNCqyBtRcleirIo7ccCfp9kJzO7ZYCT8etTQznetLeD7QPJgcbNBayFMT6f6kGf7DsjBdfmDrwvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322517; c=relaxed/relaxed;
	bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ci9yxhoX9Rm1OSkB7hLOhUK79k8ukhGmmbyOGxtlaMGqT2rWaNdqPynWPNIBMJsmESn7R7LO12A+IABG0RJzEYCgtfPJlv5Pi4JxcQ3+4SDWxyZ6+i2hRz+6LKXf6fhvv3dbXmJgEQBem42h/LCQYZzN1/w0b/6F/Z/cGQOjuxedWn0QwesvH0WDAgA6M1fwe+uKfv1/frd9SGr1bjV+ESnwnUcWYk4s9jpXsO1sinFPN1r3gk2QXKghUcIZcxDQ8o4tvYaeY2dIsZ5EX0SJulwGFj9ZW5vJ22MKdkvfuOhhVnzecOY7EBbRJ2CT74sLd3u/l3wNCTcomRCVIiLypA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Ln9rXGoT; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Ln9rXGoT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMdw6zdtz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:28:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDWfRrhOa1FREzFNEratYYwmBcgUW9fnbHtkTfxg886xeDYVEB42X1XsY8faUjK0ifiVOvKlgNT0IhmH7DLKz5otTSjWkdhFPzpskLuFSyM3Zi/y1cGOipR0X7lKa0+bNf9wun/Pel107XuvYfA0mQr0geosYrP4kar5EDXszPo5Tr5l7Jtw/3b+lANMHgGDfWQm/cmWd5yhlPyrQXieqKykPaflOGbZhTyyNmyh7wcsyDhcKJFL6aw2th0HbFORLtynRGliV3aFquCznEH4ccTqW4bgZV1EcmLLz7y9dFnlar/nfvm8qqwk7v4J82zZDZkQ/K9f93mQitfuYHMHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
 b=uta5h/D46i7iIo9TBM8KBqWDCTdWWY+LzxrozKpxJf+qgR5aJsMP4sb+j/A/aYza22tAKqPvRlW0y7OSIHN25c28PMpxaY2ApVorraNTTu826OmooKyqiszMAuh1dzSqCz63q/G1LY15OPiLyU8T4UwGxP3Mhkkj0oVyUKVGymi+0Mjo9fGaQVcXcHS26HwAmh5nlXCnNbA+jLIovB6jteFQwWFHO3t4c0fosoTUT/2Rr1AmKFwJTFVZ8NUp6SqX4/pnsyDGAhXBzTJPKqf9wB8x8OVg81KaIfAJREtqoshtJKN2YNMfYWKt8UY7XXEpe9Ky8L61yebNi6apuADW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B62fPejed7Ldum3h06+M+/Eww4lOevQpJ4rElrPhHQ=;
 b=Ln9rXGoTEuI4/hwHqiqzOO0jGRw/QJbmDBf/ww3USW0IK+u8PmOU6/q4NoUE0Ow/DnHxXg0PJYtN/WKyVED+h5OMajcjcccbcbFyI4l5QPB1icSltB+AUFlM2gAhgQHjhtyfE0jwfcjlUxp9IeKICddTO1WSej0H8OHh3w7BEvgztvozUod76HfuVPRGzDnT/XDeC1/JLfuCwh/OphuSEY/Q8CWqbSlJA0lZpyfmtxUEc/kZLq72WezrGcnjgcd7j7u4abCJFS+115YrK55w8TChHO8kQqja1A8riekhaHsfbVFGfDuJnfTr6LQu8yU0dw1knBlpFg6E2uCAoPVd7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 10:28:16 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:28:16 +0000
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
Subject: [PATCH v6 net-next 05/15] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Sat,  9 May 2026 18:29:44 +0800
Message-Id: <20260509102954.4116624-6-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed4bdb7d-06d5-45af-2004-08deadb5ae4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NMJooJvEAsfO44Ucy3I/jPTQ/G9W/uyVW1mpELYXuv0iv+NEtFjUL3AXiAac2sNZnTsFZsuH3/hQodj5lRWFvcSyF06k1m9nAVLHEPpQW0skSX604iitA80Oi451DrcE70Sxr2kNSdZPEaQQp3VlixnH3j+OlfQdGl9As/8Cyv9N96BJYEzrQWHg/Rll0NK+i/7hw0/FJ0jDzJzkhrnRlXMmKsio/+LO+8fbTUcVCBIjpvnqex6+4u2djBOEOgT/lIOroWZ2VP9K14sLg00Ma2cBo7StGwZ03PJYPHpwjdH4NHBF6KuUUsk7uDP1wG1JFv9z23KbwT9JIGDJATDJIJajyLrRF+tQEwBys/25HwuGCpX43K2YpLADmLXHrSBwpOlMGKFnHLC1T36y+Wbv8PYtNEmVzuYg4uARg//GW2G/TlRpb1iwzmEkljVHf7p1HkMBuofFCN2R+WRIgkV9NJn768AnzH07Pmb/PQ2lo+0B1BimN3a2vsdiR9sJ9If0Qmx2A1mUOzNd2lGECTu7xmr6rIZ4fsKK7bTxAF+2Dzk//h7ga6PVHL0rSlMRHl8O21C1b1wRizN8qoZynDi7Uyb3GPtrlufGrkqiQQh42N1VLrJhHBEH9eIvSSFL8GzugPe6OVw46taMK+qM1merFYQCjTXnGt2Z/YNOARZDrjjrtO8SNBT8xQKuoA1ijEvBUSv7DjXwIk2sQfImzd8emdPgLaw9LsR8kjDQN02uUkx/Om+vqbkrLLgLEVK4kNLWdIy3JRI/TfpytvFgQr7xMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vkz4bS0W8gdY9zaL7XLdOsaJ9ysaKtmODFV7NT+3L4R6jtjtUUJDv5TgBMcl?=
 =?us-ascii?Q?8fOI6Ornbdg5DnlSjN/54spNANp9qD04ONtPMA5CaN43W3r9w8BD4jhlwy4a?=
 =?us-ascii?Q?lJW/HEYw3vnbu9GOPLMZoiUvNQO0R5Vz7+GaUJMx0QwAbMETQ0PWnR0X7QcA?=
 =?us-ascii?Q?nh93+Aca8RhkC/Qzd2NIpX56DutV6EgctT4AkyoY0R8fOyH9AtHyG0ZgeT68?=
 =?us-ascii?Q?3j2yJbuxv+zTPVTxD50LXX1Dv0Og7xST8/bPHiuFSyHef7IsqVOFbFXcYFql?=
 =?us-ascii?Q?EiUh28+0lv/hf5LZzYBOiGDQc0h1oQiFHPPGAkJ6hOlunzD+IY+1GUXrj+fV?=
 =?us-ascii?Q?Z98bI/YIoiw5rkCTFn4S3WH+4UXiFgZpgcNfxO6FNG/oGmNJtAT9jnbrQJr2?=
 =?us-ascii?Q?IBI8YrFWxsOuF0gRTiYH+/7xtx32ls0s+ifR1Qpl12D+6p/2H2aJAUoxVf5z?=
 =?us-ascii?Q?KCYlbrQmwHWrxCzg+e47x9MgUeYLugN0jkjRSG5F0H9AyA8p6PaVuy/WeAca?=
 =?us-ascii?Q?NSKxD6S4+gjjRvEpxusnuzHYhDtnVLH0GwkO5d7tNWdyc3h33Xxa4DhAN6sg?=
 =?us-ascii?Q?6AR7KFAZ4UU9nEMdS2MjvGuJdycrcV+TzTvHefOHczwafwFCQ9lQILR3GGHE?=
 =?us-ascii?Q?LltqdWbjiwgq5ghY7PgXOTri5o3yCGeAZAJckpl7xFfU3qJozfJ8jxmP8vLB?=
 =?us-ascii?Q?2XX97LXQQruX7HqS71RcRqxgErx2cz9BZjx1xouyjvatV0uaBUH/y/eq4zl/?=
 =?us-ascii?Q?VrLlQQ+OlKteFpYZ9qebQdd+EEDFeXEgGi+ycdW1j6BJS2hVNP2kBVYEUwWH?=
 =?us-ascii?Q?7dXBFBkxfD2hcmGuqK40QpfYBmWYbW4YBnoJ8AvRMJbA6tPftbS98K9l+919?=
 =?us-ascii?Q?BpLRYdKgXSDcQ2bkR8eeV8Ot4/37fS/sddl/xUqqbNs+r2PJ5TlAIQgSMKtu?=
 =?us-ascii?Q?AScZm4NVCQStRRS3IVF3ViIOf3kbz4xxYX/HduOhmRzvBHl+b7afw/mflciU?=
 =?us-ascii?Q?tY8TgnG477xAgkqJ9zOvPVzOrtVdCyRSwnTl9JaLV7u1fozG/D5Mzrc6eqGl?=
 =?us-ascii?Q?hTXa+fiEjnIjO7h2+ev7Lfib10rgZIUNWHa10P1sT8AkrdpPMGV3/7SME9Xe?=
 =?us-ascii?Q?aRvPoGpiAP3th9QK1myyd7kcsf/1dW9XmiRFtJkVXFU4EtokTEN+EV31NxHo?=
 =?us-ascii?Q?ZSiQZ02ug4EB3F2DhM74+3liS+/rffYsPSW8h5af5U3EPQ2PqYwoYnj9JL3Q?=
 =?us-ascii?Q?nqnRY8gZKjMi7wpa7BVoGWO1TW3QX6AHb0QHhKgnSukZ33Ob5G0dwQxz32LH?=
 =?us-ascii?Q?Man3YP4BJ4m4kB5hI7zfpJis6axGezVqWqu2V/iNRzt9jDGEQxLKelckV0Tk?=
 =?us-ascii?Q?oBP/IZ8FjWRgYbVD8NnYOaqZx1Qc45iGJhkK20yQZIFPNwhpL6OUqhsCL6g3?=
 =?us-ascii?Q?5o2Op6Xo7dJqQrVHs4kF9mv5HXi3Y+GNiAk0SLi9PkTIgSptqBxPKN7I71nK?=
 =?us-ascii?Q?f/1hWqKmXTOVLUmMGrv5P1P7dhTQJpVrPkodpUo2T8NrvRdC4B5FO4QgmYWO?=
 =?us-ascii?Q?VgZveEaxn5UBZSfnMkUs+VkP2wUiRrSfFuSuyhEYmDuCmfJCcO6V9+dnRKW+?=
 =?us-ascii?Q?M69xfVSSCOUIZN8m9j4VVOVdSY1bxxsU4cx7uf2KVgglAVXKv1M31hfhP8Ev?=
 =?us-ascii?Q?NjUeWSUZvWZN1RGqk60roMZFQ8/abYMj1OkzO+3r1u6lbQC2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4bdb7d-06d5-45af-2004-08deadb5ae4f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:28:16.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DE8R+RNC4xCRVqyaBcoYiFu6AVgKiVyJDPxeZWGrqwv3qY0wMkdzUSAmL4NRVV13/cvlwVXDyHwyQGL2IMCtVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909

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
 include/linux/fsl/ntmp.h                      | 24 +++++++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 6074eeafd5a2..db74a9107975 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -22,6 +22,7 @@
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
+#define NTMP_VFT_ID			18
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
@@ -268,6 +269,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
+	case NTMP_VFT_ID:
+		return "VLAN Filter Table";
 	default:
 		return "Unknown Table";
 	}
@@ -699,5 +702,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
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
+	struct netc_swcbd swcbd;
+	struct vft_req_ua *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
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
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to add %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index b0b5805ac4f6..575ee783be47 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -156,4 +156,23 @@ struct fdbt_resp_query {
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
index 4cfff835954e..3672e0dc7726 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -32,6 +32,7 @@ struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
 	u8 fdbt_ver;
+	u8 vft_ver;
 };
 
 struct netc_swcbd {
@@ -101,6 +102,27 @@ struct fdbt_entry_data {
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
@@ -125,6 +147,8 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1


