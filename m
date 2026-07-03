Return-Path: <linuxppc-dev+bounces-23484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE327C44500
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:42:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9LM4ybmz2ynT;
	Fri, 03 Jul 2026 20:42:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075339;
	cv=pass; b=BN3Vbu6fuunDo88rQ/ux60axe3+jT0JSJkDithLOtOgAA2bGGcxJYPVgvrwDuRl3etbQeMTQmqZBxC/BxJq6vyN9pseAEuhneupSw7q2HeL+hSmcvC8g9xeB7eqSK8jyr/CuuQbE5dgpUEHMdhGUMO9OXZsDus2XkU6LSSk//E/ZGseBxdB+mHdfDhKobfvF1B0oRMZZVtwkkMVD24HH2Ujk2RTyNijUDk4csAm90lAKxbnVacGUz7npwrpjFFZJ4KzUYQ/A5jjrNR/hkB4GQsMFXhXWUGZKJGXahQcQ4IL0k4P26IHLVly1wXwpjhSWuSxTClsGch2d5NF433GqCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075339; c=relaxed/relaxed;
	bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=is66gmD5cZQ6gkm76gu2kpjn1kgdDWstGW6tUGzkyEl4Rq4n65AVyAfrgc4EZMT/9zFSI35taKATWzwp/dJMbIKKrORmsDIekEgSeJA946O5HNtrfh4spc+gNPstrCRmY2HUw5HrumdqiWS2qNCMXbLLXxgHgdmvU6cZ5qGSpAdH4OnahinJqKsW6CqXivSAO3kg7uoD5ydBHoVrzfaGmkU55EmCFLNyojC5fxIkOBOy+c12iyymLB1/lhqYwieubOf922S54Jn1E2v05/NsK9HvFYSycw6BwTKjFXv2Kxza5tMrgxzf0gfBpkj/y1mu40/DOvqWap4qN31J2D34TA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ajmP2Cfv; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ajmP2Cfv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9LL1Jw8z2yk6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:42:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6qaJBP7ap2yt6tgeJqtXalN/IMCPF3OlM/1dniRCNOGlr11GB+kGv3/HZUwk24iXTlOypOwZ4pebfK65anDDNhG0hn4UHLLn+iQTFzrgmPuKfjcpTpruI3z3lL4rdEHi7iJiLZPyY+6tpZLri/4+EhkaTCvqi75pFqx71DC3c42HdlH+GoL3PjhsEdso5VK38+p/kR4jV3RYGZGEMGCAjw8VoUYB2vhiWIQjhPysDiA6BRrK0GHrzv0fPuBTfUIAEN7h7Qj4PmZ5TVb9ruyTbyX1P0QP/b4JSi5r2WtcdkB3fA1pS91eSsPHGQxysanwhykoIYPOrYZXoGE23qmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
 b=P7Q1R9vXkqvcqO+BRsgPBdNDh8MJ51Tfr6OpKv6OU5n+ZYZ/384IpkOH1ikYXJJLs2pBQ+nzSY9rm6WiPr3nbdXRTkni3t7PJxtR9Goa9wR2kZ3A5Mv0tj42FCr7ScAHcJZ+ckEmhrVEu4jbC4VnKRe3fKvdtOK4eS9cV1yKh7NlLZaBNeuKTzr+U2GRlkzxxRuNF63ZQDH0tc11UrcUY+GCxuHplsCdEj/3IjxBfRscWEar5M/B39YHy/Umpp2yW7lWp7BvfJ3tBXsYP9srb8NY9/zqZYeEF3U8Pl/YY0eVg8qHAtBVzCfsO6m8lfdFnAM6G0yo0WFvNBi+3YkSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laEqqxQLZLzYQtBU0n5VfXeJP8j3yGHfiXlzBZT6bmQ=;
 b=ajmP2CfvDEHpUVn9SZM69kLQAu3JudRfIvpdxrPDBSftAY6pUW5YDMBG+UcugVS+rCi7arZVtV6JvummmE6723v0GLigIET+VjiGlviH5sZYZzrPOAwdQn0Gsf7l/3ooXZVoQU5gY/t4T9cDDuYkSRigdSQPok6qdJscU/Y3qliTB2+bVgcNTsYIOSi26oUyT43tdtZNb6LPD9PsMks/hCLY9eMjRQGySZoDhB8jRgGA7FmJhQv07upZCCG0Oz6RKqlmdut/xa4CSOipwz+DEo8xIPhd3KMaSBj+cMIz3WoqpxjnMHpjQL6I9wr0Ca5lH9nTI/JckMnGiyR5jqp3oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:42:16 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:42:16 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 04/14] net: enetc: improve MAFT entry management with bitmap tracking
Date: Fri,  3 Jul 2026 18:13:18 +0800
Message-Id: <20260703101328.550714-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e031f6-6cf2-4f9b-26c8-08ded8efbfb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|22082099003|18002099003|56012099006|11063799006|6133799003|20052099010;
X-Microsoft-Antispam-Message-Info:
	8eL1oLWmaQJOtUydCtpof+txNs9UxNn3Cgl1h8VfZnF/4V4OP+E0VjLUx9azDxsgxdcZwjx6Cp0VvYgqPqgDMLbAF4bklewohU+S/uGWwDNrlwjh96aUEm6Ko9i00DJUphYAJTybKVKxvkEwvqlI0Li3FQSVLGTnlQQD2sjttah84z2iK/bsA63mxKMIwj9uHUowyTxTDw7jb59aceTnbFfzYtjWlPGXeV/mvh4XJoEuzM1ETceWuyIYzDzFzDOLV92/329de0x4w1a4mr/lMrBrCNJIoLJ6QJX6H115U+LkKCjvYk7KrdMva4nBCzPpvdkvFEpWoCjtZ+92dn2RgiXjZjPpAHWcSry4uOMs5aPHmYRcqfT5WacTon5vjwglMTOMCLZqNYr/PPJPn5y8/PyswAY8KjQn/NbyedRbZy3koi6hjagXIJziDIcqDtDzvt7cEfvDuIwpkXtf1zTnyJ9oPkkhA8tP/hdhHdRjvhYPo2oWugECqttb9gGwtOGJ+8k09VZftIChbroJlCZL4GkyzcAHewaPMS2iNXAIcBX20wSTeaTyBtZOXKw1lA74tykr43cN/yGMOs+nQ+CEWV7eXqw0oUt7qjrVUe26vrwDuilhhUxMG4I9lgkq3eWRtJDs5fuN5CM8GN54YvNkD/zr5O3khEh5wIwevUgh3cwG6xf5Tlol5y++VURLbsawPyKsjNQkUDZmIvK7uXrALg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(20052099010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GtTKx5v8ABGH2QFci+ptbITOKdH2J28SEcE3OAVCDL18Uz88XSv2/su2wWLX?=
 =?us-ascii?Q?vpsrhucA/E5tHZHaNn12p0wTStTsLulY7zNApbD5mSOOJ4zjjuKZVj1V7X9H?=
 =?us-ascii?Q?Vb347BmnV/bOFPhH1x9h4e2TljMg4kRRBSjh02M3K0nCVBmqzusgIu69PS7q?=
 =?us-ascii?Q?bln5yrSWP+PI6q2fxvTl1LD0s8s20tUpFkSkPaq35sf6tBKIz4kjJwkJO5eB?=
 =?us-ascii?Q?nM/mXdschG++uDvDOQOzGFJAFA7VlkZdQAIZzYNYPRrPq12VZ6t/D+su5qHj?=
 =?us-ascii?Q?Aou8yu4IgWdvtERMe4b/C0o8chJ5MoTd24JVpzEU9E2EAOAeo9OezPWE7+tF?=
 =?us-ascii?Q?qf1ZV3quM3itA+Y5IFhevko9lTlFGEzKBSOis2Ajw6GC/bUtsBw94W9xOBcI?=
 =?us-ascii?Q?v7eHIBj3trScGGgobTWielY8jb0kZa9IB1EFpuVTdoVF6rj1V2pTZLezZDZ3?=
 =?us-ascii?Q?S+cTN4TVaUxL9WKYvVFSa/D2nMlw5JTe7SLl3ihmSHRjyS0MY4Tid0dD5Kue?=
 =?us-ascii?Q?1uLS4nXDJdyi2+E2/fEdgw/BoK1MmrkYlJUWtYzuhA/IYHJNEG+v3gUx+Zah?=
 =?us-ascii?Q?0zI23l4ASt6EufVjf00TSVSJPwDPm3/+5KNPchv+BBX2KOZKFGN2mPoEIW9I?=
 =?us-ascii?Q?SKzuU/OciDchzzJZ1sP7kBtA5bSsAO/VINarQ+9RcVRhCStfXrjFucI+4YEC?=
 =?us-ascii?Q?bnlChaGl4zFRPEVZjZxd8opkUsEOjLXlj1ypWzxVOSTxJwP1iV1V+W8/zWhf?=
 =?us-ascii?Q?MyxRpzimogiwFphLUviZaVT66Br3AUrXjQDz+mS6Mm1/Optw0LUE37wsvJf9?=
 =?us-ascii?Q?sFy8APkpZFM+or+Hq8OrHLn/X065hnEq3XjIWKB91d8K2bo82po6rgj+7LOI?=
 =?us-ascii?Q?GkBf17y+Cg7BLyXjZn3lAc7etJshbVbU0X8NKZlLKECl259bHdYJKttIf4VJ?=
 =?us-ascii?Q?xRQDLmxKEE2AlFPW74GI2JSv5vKs3EMUyRv3oJgtwp5m4j1cPHULPPo47F74?=
 =?us-ascii?Q?PbfzDjyDWVHGU25eIJnwH0ZvARYT6pRzpMm3Dw6oukaUDVgHyulN/SHcjKN2?=
 =?us-ascii?Q?5/0UGaCTKLBBO9e43BiThtbEXoYnWxHZQ+BEuSGGXIEtyI1bcZg06qxRecES?=
 =?us-ascii?Q?DqqA+K4fnl0XmtYfg4FLr++x94N3hBoJ0ZsLP4ZPHo6xy/v0LgibzGKlbode?=
 =?us-ascii?Q?haTMAW+A1UUktHwAs2RSLvYoEUWDdjFu/NIzc1ozwdaiz5HutJ1f8UvmL7hB?=
 =?us-ascii?Q?UsSrq9p8mQeLHcjEMt62R6AsBBn9etnfmLprdRURW85Iy8CKWFap1TiFSdcw?=
 =?us-ascii?Q?UU3qD1KzWV3bAzxlED0K7h/KwC9Pt3NhfE00BazZxbvUlJx08arbljJXDBMV?=
 =?us-ascii?Q?EKX5B6QbrCtq8vGVxyTosX3pdedIeFglt770ThbJW4RJW8st8uqJHjkqog2Y?=
 =?us-ascii?Q?PA/lHmOS34fPr85yD4qfrVnVa+h2M8Smo5dLsFhpcy2Z0sMT8RORf+gKCBF0?=
 =?us-ascii?Q?QHcA5aLNaCvpbFSh1xAuvG7X3v6rTXhZFRSrYAIio4FhPmaTs0fouorcHifx?=
 =?us-ascii?Q?CE+ySt0JLCDYd+tc2FejYCzL3vpOhlsJJmW7qC331mAmcCBdIg0tbzb+vwly?=
 =?us-ascii?Q?pcKpEUv+fmf20fKGXpdBnbs5CSxCkgyCntA3nbWFFfDLH4/LERIzqNmI24zO?=
 =?us-ascii?Q?a+dgOEJm+zvf6AdELPKF8vwCbN8RGEzDZ4YBwBDltQUoRqYjGiBEcBHxYgKf?=
 =?us-ascii?Q?2dFnjXY8Ctj1ousGwr3XvDs9bSRpsiP2uBHVgGOG+PsWniV/p46Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e031f6-6cf2-4f9b-26c8-08ded8efbfb3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:42:15.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcgMfxmZ+73rKGxIdp/fLC3Jz3G2NJC5P2pKmo4JQpS+Vd4mN/TkEuJ08flmN+O3fitNq0JXDlJYd/NqE/Tvs7rV4+MZhH4YqNbcgaEwuHiVkmZmkNUSs4+FbwWIZG4y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741

From: Wei Fang <wei.fang@nxp.com>

Replace the counter-based MAFT entry tracking (num_mfe/mac_filter_num)
with a bitmap (maft_eid_bitmap) stored in struct ntmp_user, which is a
more appropriate place for NTMP resource management.

The bitmap approach brings two improvements. First, the entry deletion
in enetc4_pf_clear_maft_entries() now checks the return value of
ntmp_maft_delete_entry() and only clears the corresponding bit on
success, keeping hardware and software state in sync. Previously, the
counter was reset unconditionally regardless of whether the hardware
deletion actually succeeded.

Second, entry allocation in enetc4_pf_add_maft_entries() uses
ntmp_lookup_free_eid() to find available IDs dynamically, with an
upfront capacity check via bitmap_weight() to avoid partial failures.

The MAFT entry count is moved into ntmp_user.maft_num_entries and
initialized once during enetc4_init_ntmp_user(). Helper functions
enetc4_ntmp_bitmap_init() and enetc4_ntmp_bitmap_free() manage the
bitmap lifetime. The debugfs show function is updated accordingly to
iterate over set bits under rtnl_lock().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 30 ++++--
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 97 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 -
 include/linux/fsl/ntmp.h                      |  2 +
 4 files changed, 96 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 1b1591dce73d..4a769d9e5679 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -31,9 +31,11 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	struct enetc_si *si = s->private;
 	struct enetc_hw *hw = &si->hw;
 	struct maft_entry_data maft;
+	struct ntmp_user *user;
 	struct enetc_pf *pf;
-	int i, err, num_si;
-	u32 val;
+	u32 val, entry_id;
+	int i, num_si;
+	int err = 0;
 
 	pf = enetc_si_priv(si);
 	num_si = pf->caps.num_vsi + 1;
@@ -50,22 +52,30 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
-	if (!pf->num_mfe)
-		return 0;
+	user = &si->ntmp_user;
+	rtnl_lock();
+
+	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
+		goto unlock_rtnl;
 
 	/* MAC address filter table */
 	seq_puts(s, "MAC address filter table\n");
-	for (i = 0; i < pf->num_mfe; i++) {
+	for_each_set_bit(entry_id, user->maft_eid_bitmap,
+			 user->maft_num_entries) {
 		memset(&maft, 0, sizeof(maft));
-		err = ntmp_maft_query_entry(&si->ntmp_user, i, &maft);
+		err = ntmp_maft_query_entry(user, entry_id, &maft);
 		if (err)
-			return err;
+			goto unlock_rtnl;
 
-		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n", i,
-			   maft.keye.mac_addr, le16_to_cpu(maft.cfge.si_bitmap));
+		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n",
+			   entry_id, maft.keye.mac_addr,
+			   le16_to_cpu(maft.cfge.si_bitmap));
 	}
 
-	return 0;
+unlock_rtnl:
+	rtnl_unlock();
+
+	return err;
 }
 DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index a02b01753ff2..b966637572a7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -32,9 +32,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 
 	val = enetc_port_rd(hw, ENETC4_PMCAPR);
 	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
-
-	val = enetc_port_rd(hw, ENETC4_PSIMAFCAPR);
-	pf->caps.mac_filter_num = val & PSIMAFCAPR_NUM_MAC_AFTE;
 }
 
 static void enetc4_get_psi_hw_features(struct enetc_si *si)
@@ -92,31 +89,45 @@ static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 
 static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 {
-	int i;
+	struct ntmp_user *user = &pf->si->ntmp_user;
+	u32 entry_id;
 
-	for (i = 0; i < pf->num_mfe; i++)
-		ntmp_maft_delete_entry(&pf->si->ntmp_user, i);
-
-	pf->num_mfe = 0;
+	for_each_set_bit(entry_id, user->maft_eid_bitmap,
+			 user->maft_num_entries) {
+		if (!ntmp_maft_delete_entry(user, entry_id))
+			ntmp_clear_eid_bitmap(user->maft_eid_bitmap, entry_id);
+	}
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 				      struct netdev_hw_addr_list *uc)
 {
+	struct ntmp_user *user = &pf->si->ntmp_user;
+	int mac_cnt = netdev_hw_addr_list_count(uc);
 	struct maft_entry_data maft = {};
 	struct netdev_hw_addr *ha;
+	u32 available_entries;
 	u16 si_bit = BIT(0);
+	u32 entry_id;
 	int err;
 
+	available_entries = user->maft_num_entries -
+			    bitmap_weight(user->maft_eid_bitmap,
+					  user->maft_num_entries);
+
+	if (mac_cnt > available_entries)
+		return -ENOSPC;
+
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
 	netdev_hw_addr_list_for_each(ha, uc) {
+		entry_id = ntmp_lookup_free_eid(user->maft_eid_bitmap,
+						user->maft_num_entries);
 		ether_addr_copy(maft.keye.mac_addr, ha->addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
-					  &maft);
-		if (unlikely(err))
+		err = ntmp_maft_add_entry(user, entry_id, &maft);
+		if (unlikely(err)) {
+			ntmp_clear_eid_bitmap(user->maft_eid_bitmap, entry_id);
 			goto clear_maft_entries;
-
-		pf->num_mfe++;
+		}
 	}
 
 	return 0;
@@ -146,10 +157,10 @@ static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
 static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 					 struct netdev_hw_addr_list *uc)
 {
-	int mac_cnt = netdev_hw_addr_list_count(uc);
 	struct enetc_si *si = pf->si;
+	int err;
 
-	if (!mac_cnt) {
+	if (netdev_hw_addr_list_empty(uc)) {
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -157,21 +168,19 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 		return 0;
 	}
 
-	if (mac_cnt > pf->caps.mac_filter_num)
-		return -ENOSPC;
-
-	/* Set temporary unicast hash filters in case of Rx loss when
+	/* Set temporary unicast hash filter in case of Rx loss when
 	 * updating MAC address filter table
 	 */
 	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+	err = enetc4_pf_add_maft_entries(pf, uc);
+	if (!err) {
 		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 	}
 
-	return 0;
+	return err;
 }
 
 static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
@@ -393,18 +402,60 @@ static void enetc4_configure_port(struct enetc_pf *pf)
 	enetc_set_default_rss_key(pf);
 }
 
+static void enetc4_get_ntmp_caps(struct enetc_si *si)
+{
+	struct ntmp_user *user = &si->ntmp_user;
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_PSIMAFCAPR);
+	user->maft_num_entries = FIELD_GET(PSIMAFCAPR_NUM_MAC_AFTE, val);
+}
+
+static int enetc4_ntmp_bitmap_init(struct ntmp_user *user)
+{
+	user->maft_eid_bitmap = bitmap_zalloc(user->maft_num_entries,
+					      GFP_KERNEL);
+	if (!user->maft_eid_bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void enetc4_ntmp_bitmap_free(struct ntmp_user *user)
+{
+	bitmap_free(user->maft_eid_bitmap);
+	user->maft_eid_bitmap = NULL;
+}
+
 static int enetc4_init_ntmp_user(struct enetc_si *si)
 {
 	struct ntmp_user *user = &si->ntmp_user;
+	int err;
 
 	/* For ENETC 4.1, all table versions are 0 */
 	memset(&user->tbl, 0, sizeof(user->tbl));
 
-	return enetc4_setup_cbdr(si);
+	err = enetc4_setup_cbdr(si);
+	if (err)
+		return err;
+
+	enetc4_get_ntmp_caps(si);
+	err = enetc4_ntmp_bitmap_init(user);
+	if (err)
+		goto teardown_cbdr;
+
+	return 0;
+
+teardown_cbdr:
+	enetc4_teardown_cbdr(si);
+
+	return err;
 }
 
 static void enetc4_free_ntmp_user(struct enetc_si *si)
 {
+	enetc4_ntmp_bitmap_free(&si->ntmp_user);
 	enetc4_teardown_cbdr(si);
 }
 
@@ -422,7 +473,7 @@ static int enetc4_pf_init(struct enetc_pf *pf)
 
 	err = enetc4_init_ntmp_user(pf->si);
 	if (err) {
-		dev_err(dev, "Failed to init CBDR\n");
+		dev_err(dev, "Failed to init NTMP user\n");
 		return err;
 	}
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 285b7e5c48fd..6f15f9ea1664 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -22,7 +22,6 @@ struct enetc_port_caps {
 	int num_msix;
 	int num_rx_bdr;
 	int num_tx_bdr;
-	int mac_filter_num;
 };
 
 struct enetc_pf;
@@ -60,8 +59,6 @@ struct enetc_pf {
 
 	struct enetc_port_caps caps;
 	const struct enetc_pf_ops *ops;
-
-	int num_mfe;	/* number of mac address filter table entries */
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index d3b6c476b91a..764ef2892608 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -75,8 +75,10 @@ struct ntmp_user {
 	/* NTMP table bitmaps for resource management */
 	u32 ett_bitmap_size;
 	u32 ect_bitmap_size;
+	u16 maft_num_entries;
 	unsigned long *ett_gid_bitmap; /* only valid for switch */
 	unsigned long *ect_gid_bitmap; /* only valid for switch */
+	unsigned long *maft_eid_bitmap; /* only valid for ENETC */
 };
 
 struct maft_entry_data {
-- 
2.34.1


