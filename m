Return-Path: <linuxppc-dev+bounces-22526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3998DCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:41:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbtL01l3Kz3c2v;
	Fri, 12 Jun 2026 05:40:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206856;
	cv=pass; b=PEHaZYsJzWbulWuqOgdDncRhxIC7a6ubI+4w9SRrPgANsP7q2KGT683jrVWi8vS/09LTFeHhk7aNaq0fnhlam6PG6id7TU9nSBHRGSnnNZSrNfS3VfDiXVYB3uVKXLzM2+xsBl+HR3ynZbUonH9mDsQEsVwsTXBosRHSkPiNB/3d1WxvZAc0uFAVciWpi65NxxukWmQXKoSOilsnbAvqTLgZrQJrWelZ8Yg8EkvHOqfTm1q99Y8b0QNMZdthy/ZMxKCk08qp17rFcX5UD7QVGvVjx7mTFnD3+JXXeDGi2IxG8kRzc1oZ8GyMM8vtIVeGbi/SyEEF2XiRcQZNDXymGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206856; c=relaxed/relaxed;
	bh=sUXDjg2+TWJB2UGIhwjQso9/JK8tD5C7S945I91rXag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IaUn/tRX1ujMzsjYIa5pLaC4slfOtgwDSR7EL4JDKlAvocSY2dritdcNe0BOXEPwbb4AGa9iRxeH89rdlPoccPmzHWceIeqUvOpYCXuCPn2y30W5zBSPNg2/1CGHTcfzQFw0+9MifqJrrGnvhPR7uujgkOMYD0Rslbo+AgslvfR92Ku1fXb/FVvRWxwhg/JS8ZEiEyeWkquY6Cq4PAt9ROIfZ9MnGSmcWftqypY86Nr7zIHsoDnFiS2tRxJdTxySiHh23P8RAByfdM59Tm/oBK3WsW7LVhyWt0ZspE0myiNUco0jB5CmTuTOrXhB47nQ1ez8DQo+oIKoaoX6qn4lhA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gsRZBT1A; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gsRZBT1A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbtKy23nsz3byl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:40:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEY7WfYv2M4FY40/b4FqE0j51kOvG5SpH3BSTiU7lTcnimGscqIJfnpj8LMhxqtk51khMjmnNi7ydgQi8kWfxeW/dhr3yH6gO9aLoSq+geuGKU9z/bqFrB5Q5wtoIijEbSdwqGcdvhlof2bS5PKdOx6qwPu3GbiHeyPpEnZlxfRjuDrIXblpdlR2ET5qWwcaZjxDCrnaOkUI+hkZkEan7hzJ1XFPw+EUk0MzHrQZaJwknySEZ11u6kJkkKYxIZG6zAmXk+qbWxBqVy0WX9Qh7i6tfajKtLEnigCU1dQ3lOsvctwNQ8dlAa8fvQlhhrIRcHicQS0ZPkf+mqarr2ijGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUXDjg2+TWJB2UGIhwjQso9/JK8tD5C7S945I91rXag=;
 b=tcCT6FCmrpjjynhqEYP2gooqwn0oMty14Wv5H4P70d6wEniGjFCie2oAt9LbH7FglO4fHY1/tpVUaKso7dKqTO2E9KMfKBlWTG+CWVY97100Dwe1XUaCGB47193565/mSmsBs5dpsNDUmcr+TJM5i4XZGmi5CC6KEXZ1W6Cqz1rR9YP0NN9hIvBdZGd2JDR8cZ+WaWx04qnTeZ9F/z+GmpDh8enS6JfD/5TJh16w5x7hzvjLyqk2Q0GMSqWc2Ylm77BRqYIeKp2NskcI0TCr4awetqqkRy23KqOggznLlEx4s8HW1sqQkXpgSmtRwfH5H/N78qvcTa1j1jXDlLpx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUXDjg2+TWJB2UGIhwjQso9/JK8tD5C7S945I91rXag=;
 b=gsRZBT1AqUdsJOqWIEUyL9RrC2valrZfvgCjjmyMORIGqgbQRhQ3WhRsFMdwsz1y20Kdx5/jb7Se07zE04e4M4yHWl7WiNSVZteizzEQbMGot3zo8aoUysr8HXz4wM3pK484XfQAaO0x/4dXvhJvdBx8LJXUJnmNRBCU3EqCM6pWmM4ZO42d/UVSWdfb1fN+fEIsZhWCYOUOqch7Lq/12865+ovcoErp/5PPVDk+sZoUFsSWFmmOUiIQVpEThHh0ztwFSns7kiIP8AN9ZTtghLx6v7kqg6LZ0DKwV9U4XdZLDSiSSOhF4AWywQfgk27kG8ZXQNuFvv7Pl2TXgGJ3VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:40:31 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:40:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v1 phy-next 7/8] soc: fsl: guts: implement the RCW override procedure
Date: Thu, 11 Jun 2026 22:39:39 +0300
Message-Id: <20260611193940.44416-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611193940.44416-1-vladimir.oltean@nxp.com>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0131.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::28) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9ff5ef-5dbe-4a48-551e-08dec7f14c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|366016|7416014|23010399003|1800799024|18002099003|6133799003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	fEApXOaLZEEcEFnCjizv1IcEcLNcETtV/vdTmkvlgNyq7iji0zMawprjRapmiLikIRUhC4FpIcTvOgbu7phxCYYYHn+a0DrCo5oQNMLMI7RIo5D+xXJ4MPMruxpECUluwCMIO890ruNjnuyVYce14UFV7Ft7kWVZZPOTzub110xVQK6DA17eLXo5LmIWRdl/q5SGOWBdq+J4xbjdbEXbH7Q+VIXuuxZNgS/vtUwmjCNq+AWZUO7nmYRrFcl3cnQNEX+mjx8c6p0Qbo4XEQKnUfKzHYwBMZPfUIiuVv0twu+qnwiDQr0g44WvaGoX1nGrjZy77X/mw1Ayf94xUKG0aMSVrXzkc5DsiA6r9ZiMdR0no8FZwWccwPdspNMwXvAzMEQgAHQYTtyN0iP0z3i7RqaQN9qNsdlcIQfgL28rMSsTugNKnRyhWu6EgwemxGoVSYTLrlpYEIDDgzk9nkHwXLrkwrCZ9dSBNYXnCpWsw07OwtC2WeGUwEMXROar+7yBPAXuz2YtAEvH38cECWra/tpHRNzdSR0gl7MAMJVTAJHyeu8tpbeZHEzahgMzX5Ja5cz9Q55P0ctHGMgHxT2lNtIHcEGZmUIzhCVMhfV/aAS1dzlhca454F2p+mPb3KHwdDVF5rEqw78F2dmUHvVQ/4yIiHywCSYHdhHBw5gPns3hLolRdOgUA6Tz6bsOnEe1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jfgHKq9eYq6z4Bk4Ntw61kRU1HDPgEL+0sBnWnH5GpNAey2dRFhnvKkVBZGo?=
 =?us-ascii?Q?0DgEG7ynOl67bvHkdUvkJXDMjSgy6RiI6zWQ4I53r+VDlFDxfDiOgjLZuUfA?=
 =?us-ascii?Q?13z70Fc37ltg8xeUAOX0a8aWJewYh0a0Mo7tDyAkjOUY/QAgsVnOnFp/rejF?=
 =?us-ascii?Q?QLnr17LT+g03Aq7gatNPy8lfZ2ryX3KMRBwZI8Quh6mnaqxDQBsj6KNDu97u?=
 =?us-ascii?Q?3RjPL0j4/Ert6UmjqzSiYO6p+HFMzdJfbchv4YEMEDMuRjvL4HUxb9ki4CJs?=
 =?us-ascii?Q?EYSnnRqB4/AM4horWIFSUfD6fkPVpbkhncJRgNaYX0U9yi/05o7Ad6sqICML?=
 =?us-ascii?Q?2SgtWUyA2LZlhtsthDNohaPQtLrRl94ATWXTmELn02HtdPA9UKCGT1SqEU5t?=
 =?us-ascii?Q?yAraCwZ3r0L6iNpDMkYDtxibt1SaYU2r4zTBakEp4bYPQlWifPK0i8wQdnU9?=
 =?us-ascii?Q?ctfO8QUuaIu7xCrSmwxqvTssf/rD9/NsOp4mao+DmmgCVOs0ekhqY+qai0cp?=
 =?us-ascii?Q?L4bIYsU5iEJW2Idtgr1PRLE736Kyde6SPjdaPS5pxrVSiJNKbDb/6SdWpDV/?=
 =?us-ascii?Q?VPX7x6NpsAoYBbNzjXq9wKmExrAWsZ8UuvVk2CQK0TyPzLd/eWyquJJML3ZK?=
 =?us-ascii?Q?JF5ThK0pRXk13+HqaLpZPitnLdPXsl/q2eU9JcSU5P2onmwG99rN5nex6w9T?=
 =?us-ascii?Q?kKFat+w82mMDxzk0nBA+ZpvyYmkOpqxAxVCNO9DH7CXVUyJm3gKcSL63byYM?=
 =?us-ascii?Q?sSOYgiC68GrYdyCd5rJG3Rjd2enX2aUkkCjHHaT7jvujX9wxFmMGw7LIblmk?=
 =?us-ascii?Q?CTzUGUb1PbxV0FEqvfR28HT4bcBCyjfu61+XSDyT2aOP799Fb4osoc7dBjZP?=
 =?us-ascii?Q?aVUmXau/Q8Io2REjvnQGfaYDLRB/PG77wbxXxlMKMo3frHHwslVobnv7i89t?=
 =?us-ascii?Q?BF4XHQ3SBAIKaRAllwzfuQdIHw3hyRZNPzHVpnch+mdf2PGLHaa/oslB49Cv?=
 =?us-ascii?Q?J/xYMPWKHW/JXZVsKunOEBQEIPxkoa4Puv0y0Kbed1F2oUKKy6T9DB/33ypv?=
 =?us-ascii?Q?kvzQ1Ms1PgyftB/3i36tTVdCK3a6eW9PRPTP7UZ2vcNha/QwqvKerf2HpGMg?=
 =?us-ascii?Q?EVbxTSSEQRNZCOgVHHqWwyeuIrJx8DjoIMU4DlPoRLJAskg2rRdqqkhh2mdu?=
 =?us-ascii?Q?vSjOgDwD8ZrUospYyoZ2XdMSXsvT2jmdIvrRdU30zL4OU9sReHI0xSftRkb4?=
 =?us-ascii?Q?5AG3T/7Ql9yhBITw4TjravZZV6/hShzyVMAALqbAJ137yLVKRMdEKODL6mxQ?=
 =?us-ascii?Q?rXQPvAM4kqWyzLmHYyz5jCMrJG9FUnnhXkU+dlw2EUY2YXUIFFYqtxRmdHmO?=
 =?us-ascii?Q?vJXmK4/flKLBoBJJWgzpxqJZsodYZlCmchHGXg91WbB720PmZBzB6wfHR2DD?=
 =?us-ascii?Q?F1SSn1jTSAKbeloYdl6PtSBB/T9v4CnjD+Mzcrb+D+nEMtN3hb+3pgSIHgQC?=
 =?us-ascii?Q?5jDSm5s16YY0KNX4hJa1b36uRKdfs+/ebEXhLfM3UEwqZFpgRTt9FhvkYkeA?=
 =?us-ascii?Q?7DBp2RENQDzmrTt1kasZXCfyf+fzHUb1qum/r/mx9jl8jCKmGhVS9tyEmcYP?=
 =?us-ascii?Q?plnmddfL+0mXlGDE/fxDipdxGSXM9FVOEWlqmOq09mTxi7VCp4FjmphD1wBx?=
 =?us-ascii?Q?6T2Ix4eG8djhp2+29mrAY0NUSKnF3+w8w8ybuuVW+KwXaEsW1KMjE9sAZur7?=
 =?us-ascii?Q?RlqcGzOUc07+TfZ0ZlFVUGaDP2vT+q4GCW64jJgEamBAXBxCWF1O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9ff5ef-5dbe-4a48-551e-08dec7f14c53
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:40:31.5869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW6osUDa6eSac9/PN4gTbj3CbwCdeZg1vP6HzgVrtAisl88n+gy3NLGBakNSZ5oDjtMkOTq4riRjPPOOMJugMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add support for the RCW override procedure which enables runtime
reconfiguration of the protocol running on a SerDes lane. The procedure
is done through the DCFG DCSR space which now can be defined as the
second memory region of the guts DT node.
Support is added on the following SoCs: LS1046A, LS1088A, LS2088A.

The procedure is exported to the "client" driver - the Lynx10G SerDes
PHY driver - through the following functions:
- fsl_guts_lane_init() used to notify the initial / boot time lane mode
  running on a SerDes lane.
- fsl_guts_lane_validate() used to validate that changing the protocol
  on a specific lane is supported.
- fsl_guts_lane_set_mode() which can be used to request the RCW
  procedure be executed for a specific lane.

Since the RCW override procedure is different depending on the SoC, the
private fsl_soc_data structure is updated with two new per SoC callbacks
(.serdes_get_rcw_override() and .serdes_init_rcwcr()) which get used
from the generic fsl_guts_lane_set_mode() function. These two callbacks
hide all the SoC specific register offsets, masks and values so that the
_set_mode() procedure is straightforward.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 drivers/soc/fsl/guts.c   | 286 ++++++++++++++++++++++++++++++++++++++-
 include/linux/fsl/guts.h |  20 ++-
 2 files changed, 299 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 9f2aff07a274..23ec5750080c 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -15,6 +15,30 @@
 #include <linux/fsl/guts.h>
 
 #define DCFG_CCSR	0
+#define DCFG_DCSR	1
+
+#define MAX_NUM_LANES	8
+#define MAX_NUM_SERDES	2
+
+#define LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn(lane)	\
+	GENMASK(19 + 4 * (3 - lane), 16 + 4 * (3 - lane))
+#define LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn(lane)	\
+	GENMASK(3 + 4 * (3 - lane), 4 * (3 - lane))
+
+#define LS1046A_RCWSR5_SRDS_PRTCL_S1(lane)	\
+	GENMASK(19 + 4 * (lane), 16 + 4 * (lane))
+#define SRDS_PRTCL_NONE					0
+#define SRDS_PRTCL_XFI					1
+#define SRDS_PRTCL_2500BASEX				2
+#define SRDS_PRTCL_100BASEX_SGMII			3
+#define SRDS_PRTCL_QSGMII				4
+#define SRDS_PRTCL_PCIE					5
+
+#define LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1	BIT(14)
+#define LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(lane)	BIT(6 + (7 - (lane)))
+#define LS2088A_RCWSR30_SRDS_CLK_SEL_MSK		GENMASK(13, 6)
+#define SRDS_CLK_SEL_XGMII				1
+#define SRDS_CLK_SEL_GMII				0
 
 struct fsl_soc_die_attr {
 	char	*die;
@@ -22,9 +46,19 @@ struct fsl_soc_die_attr {
 	u32	mask;
 };
 
+struct fsl_soc_serdes_rcw_override {
+	int offset;
+	int mask;
+	int val;
+};
+
 struct fsl_soc_data {
 	const char *sfp_compat;
 	u32 uid_offset;
+	int (*serdes_get_rcw_override)(int index, int lane,
+				       enum lynx_lane_mode lane_mode,
+				       struct fsl_soc_serdes_rcw_override *override);
+	void (*serdes_init_rcwcr)(int index);
 };
 
 enum qoriq_die {
@@ -138,9 +172,13 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 
 static struct fsl_soc_guts {
 	struct ccsr_guts __iomem *dcfg_ccsr;
+	struct ccsr_guts __iomem *dcfg_dcsr;
 	const struct fsl_soc_data *data;
 	bool little_endian;
 	u32 svr;
+	enum lynx_lane_mode lane_mode[MAX_NUM_SERDES][MAX_NUM_LANES];
+	bool rcwcr_init_done;
+	spinlock_t rcwcr_lock; /* serializes concurrent writes to the RCWCR */
 } soc;
 
 static unsigned int fsl_guts_read(const void __iomem *reg)
@@ -151,6 +189,28 @@ static unsigned int fsl_guts_read(const void __iomem *reg)
 	return ioread32be(reg);
 }
 
+static void fsl_guts_write(void __iomem *reg, u32 val)
+{
+	if (soc.little_endian)
+		iowrite32(val, reg);
+	else
+		iowrite32be(val, reg);
+}
+
+/* Some fields of the Reset Configuration Word (RCW) can be overridden at
+ * runtime by writing to the RCWCRn registers contained within the DCSR space
+ * of the Device Configuration (DCFG) block. The layout of the RCWCRn registers
+ * is identical with the read-only RCWSRn from the CCSR space.
+ */
+static void fsl_guts_rmw(int offset, u32 val, u32 mask)
+{
+	u32 tmp = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[offset]);
+
+	tmp &= ~mask;
+	tmp |= val;
+	fsl_guts_write(&soc.dcfg_dcsr->rcwcr[offset], tmp);
+}
+
 static bool fsl_soc_die_match_one(u32 svr, const struct fsl_soc_die_attr *match)
 {
 	return match->svr == (svr & match->mask);
@@ -167,6 +227,97 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	return NULL;
 }
 
+static int
+fsl_guts_serdes_get_rcw_override(int serdes_idx, int lane,
+				 enum lynx_lane_mode lane_mode,
+				 struct fsl_soc_serdes_rcw_override *override)
+{
+	if ((!fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS1088A]) &&
+	     !fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS2088A]) &&
+	     !fsl_soc_die_match_one(soc.svr, &fsl_soc_die[DIE_LS1046A])) ||
+	    !soc.data || !soc.data->serdes_get_rcw_override) {
+		pr_debug("RCW override not implemented for SoC\n");
+		return -EINVAL;
+	}
+
+	if (!soc.dcfg_dcsr) {
+		pr_debug("Device tree does not define DCFG_DCSR region necessary for RCW override\n");
+		return -EINVAL;
+	}
+
+	return soc.data->serdes_get_rcw_override(serdes_idx, lane, lane_mode,
+						 override);
+}
+
+/**
+ * fsl_guts_lane_init() - Notify guts module of SerDes lane configuration
+ * @serdes_idx: zero-based SerDes block index
+ * @lane: zero-based lane index within SerDes
+ * @lane_mode: initial / boot time SerDes protocol for lane
+ *
+ * On the LS208xA SoC, the RCW override procedure needs to be aware of all link
+ * modes which are configured on a SerDes block.
+ */
+void fsl_guts_lane_init(int serdes_idx, int lane, enum lynx_lane_mode lane_mode)
+{
+	soc.lane_mode[serdes_idx - 1][lane] = lane_mode;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_init, "FSL_GUTS");
+
+/**
+ * fsl_guts_lane_validate() - Validate that SerDes protocol is implemented and
+ *	supported on current SoC
+ * @serdes_idx: zero-based SerDes block index
+ * @lane: zero-based lane index within SerDes
+ * @lane_mode: requested SerDes protocol
+ *
+ * Should be called before actually requesting the RCW override procedure to be
+ * applied using %fsl_guts_lane_set_mode()
+ *
+ * Return: 0 if RCW override to protocol is possible, negative error otherwise
+ */
+int fsl_guts_lane_validate(int serdes_idx, int lane, enum lynx_lane_mode lane_mode)
+{
+	struct fsl_soc_serdes_rcw_override override;
+
+	return fsl_guts_serdes_get_rcw_override(serdes_idx, lane, lane_mode,
+						&override);
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_validate, "FSL_GUTS");
+
+/**
+ * fsl_guts_lane_set_mode() - apply RCW override procedure for SerDes lane
+ * @serdes_idx: zero-based SerDes block index
+ * @lane: zero-based lane index within SerDes
+ * @lane_mode: requested SerDes protocol
+ *
+ * Return: 0 on success, negative error otherwise
+ */
+int fsl_guts_lane_set_mode(int serdes_idx, int lane, enum lynx_lane_mode lane_mode)
+{
+	struct fsl_soc_serdes_rcw_override override;
+	int err;
+
+	err = fsl_guts_serdes_get_rcw_override(serdes_idx, lane, lane_mode,
+					       &override);
+	if (err)
+		return err;
+
+	spin_lock(&soc.rcwcr_lock);
+
+	if (soc.data->serdes_init_rcwcr)
+		soc.data->serdes_init_rcwcr(serdes_idx);
+
+	fsl_guts_rmw(override.offset, override.val << __bf_shf(override.mask),
+		     override.mask);
+	soc.lane_mode[serdes_idx - 1][lane] = lane_mode;
+
+	spin_unlock(&soc.rcwcr_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
+
 static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
 {
 	struct device_node *np;
@@ -193,6 +344,128 @@ static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
 	return uid;
 }
 
+static int ls1088a_serdes_get_rcw_override(int index, int lane,
+					   enum lynx_lane_mode lane_mode,
+					   struct fsl_soc_serdes_rcw_override *override)
+{
+	/* The RCW override procedure has to write to different registers
+	 * depending on the SerDes block index.
+	 */
+	switch (index) {
+	case 1:
+		override->offset = 28;
+		override->mask = LS1088A_RCWSR29_SRDS_PRTCL_S1_LNn(lane);
+		break;
+	case 2:
+		override->offset = 29;
+		override->mask = LS1088A_RCWSR30_SRDS_PRTCL_S2_LNn(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
+		override->val = SRDS_PRTCL_XFI;
+	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
+		override->val = SRDS_PRTCL_100BASEX_SGMII;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ls1046a_serdes_get_rcw_override(int index, int lane,
+					   enum lynx_lane_mode lane_mode,
+					   struct fsl_soc_serdes_rcw_override *override)
+{
+	/* The RCW override procedure has to write to different registers
+	 * depending on the SerDes block index.
+	 */
+	switch (index) {
+	case 1:
+		override->offset = 4;
+		override->mask = LS1046A_RCWSR5_SRDS_PRTCL_S1(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
+		override->val = SRDS_PRTCL_XFI;
+	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
+		override->val = SRDS_PRTCL_100BASEX_SGMII;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ls2088a_serdes_get_rcw_override(int index, int lane,
+					   enum lynx_lane_mode lane_mode,
+					   struct fsl_soc_serdes_rcw_override *override)
+{
+	switch (index) {
+	case 1:
+		override->offset = 29;
+		override->mask = LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(lane);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (lynx_lane_mode_uses_xgmii_mac(lane_mode))
+		override->val = SRDS_CLK_SEL_XGMII;
+	else if (lynx_lane_mode_uses_gmii_mac(lane_mode))
+		override->val = SRDS_CLK_SEL_GMII;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static void ls2088a_serdes_init_rcwcr(int serdes_idx)
+{
+	u32 reg;
+	int i;
+
+	if (serdes_idx != 1)
+		return;
+	if (soc.rcwcr_init_done)
+		return;
+
+	/* SRDS_CLK_EN_SEL_XGMII_S1: SerDes Clock Enable Select XGMII Serdes 1:
+	 * Enables to select GMII/XGMII clock according to
+	 * SRDS_CLK_SEL_XGMII_Ln_S1
+	 */
+	reg = LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1;
+
+	/* We need to configure the initial state of all lanes for
+	 * the SerDes block #1
+	 */
+	for (i = 0; i < MAX_NUM_LANES; i++)
+		if (lynx_lane_mode_uses_xgmii_mac(soc.lane_mode[serdes_idx - 1][i]))
+			reg |= LS2088A_RCWSR30_SRDS_CLK_SEL_XGMII_Ln_S1(i);
+
+	fsl_guts_rmw(29, reg,
+		     LS2088A_RCWSR30_SRDS_CLK_EN_SEL_XGMII_S1 |
+		     LS2088A_RCWSR30_SRDS_CLK_SEL_MSK);
+
+	soc.rcwcr_init_done = true;
+}
+
+static const struct fsl_soc_data ls1088a_data = {
+	.serdes_get_rcw_override = ls1088a_serdes_get_rcw_override,
+};
+
+static const struct fsl_soc_data ls1046a_data = {
+	.serdes_get_rcw_override = ls1046a_serdes_get_rcw_override,
+};
+
+static const struct fsl_soc_data ls2088a_data = {
+	.serdes_get_rcw_override = ls2088a_serdes_get_rcw_override,
+	.serdes_init_rcwcr = ls2088a_serdes_init_rcwcr,
+};
+
 static const struct fsl_soc_data ls1028a_data = {
 	.sfp_compat = "fsl,ls1028a-sfp",
 	.uid_offset = 0x21c,
@@ -221,10 +494,10 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,mpc8572-guts", },
 	{ .compatible = "fsl,ls1021a-dcfg", },
 	{ .compatible = "fsl,ls1043a-dcfg", },
-	{ .compatible = "fsl,ls2080a-dcfg", },
-	{ .compatible = "fsl,ls1088a-dcfg", },
+	{ .compatible = "fsl,ls2080a-dcfg", .data = &ls2088a_data},
+	{ .compatible = "fsl,ls1088a-dcfg", .data = &ls1088a_data},
 	{ .compatible = "fsl,ls1012a-dcfg", },
-	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,ls1046a-dcfg", .data = &ls1046a_data},
 	{ .compatible = "fsl,lx2160a-dcfg", },
 	{ .compatible = "fsl,ls1028a-dcfg", .data = &ls1028a_data},
 	{}
@@ -250,6 +523,8 @@ static int __init fsl_guts_init(void)
 		of_node_put(np);
 		return -ENOMEM;
 	}
+	/* DCFG_DCSR is optional */
+	soc.dcfg_dcsr = of_iomap(np, DCFG_DCSR);
 
 	soc.little_endian = of_property_read_bool(np, "little-endian");
 	soc.svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
@@ -296,6 +571,8 @@ static int __init fsl_guts_init(void)
 		goto err;
 	}
 
+	spin_lock_init(&soc.rcwcr_lock);
+
 	pr_info("Machine: %s\n", soc_dev_attr->machine);
 	pr_info("SoC family: %s\n", soc_dev_attr->family);
 	pr_info("SoC ID: %s, Revision: %s\n",
@@ -305,7 +582,8 @@ static int __init fsl_guts_init(void)
 
 err_nomem:
 	ret = -ENOMEM;
-
+	if (soc.dcfg_dcsr)
+		iounmap(soc.dcfg_dcsr);
 	iounmap(soc.dcfg_ccsr);
 err:
 	kfree(soc_dev_attr->family);
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index fdb55ca47a4f..176842531241 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/io.h>
+#include <soc/fsl/phy-fsl-lynx.h>
 
 /*
  * Global Utility Registers.
@@ -91,9 +92,15 @@ struct ccsr_guts {
 	u32	iovselsr;	/* 0x.00c0 - I/O voltage select status register
 					     Called 'elbcvselcr' on 86xx SOCs */
 	u8	res0c4[0x100 - 0xc4];
-	u32	rcwsr[16];	/* 0x.0100 - Reset Control Word Status registers
-					     There are 16 registers */
-	u8	res140[0x224 - 0x140];
+	/* 0x.0100 - read-only Reset Configuration Word Status registers in
+	 * CCSR, or write-only Reset Configuration Word Control registers in
+	 * DCSR. In both cases there are 32 registers.
+	 */
+	union {
+		u32	rcwsr[32];
+		u32	rcwcr[32];
+	};
+	u8	res180[0x224 - 0x180];
 	u32	iodelay1;	/* 0x.0224 - IO delay control register 1 */
 	u32	iodelay2;	/* 0x.0228 - IO delay control register 2 */
 	u8	res22c[0x604 - 0x22c];
@@ -131,6 +138,13 @@ struct ccsr_guts {
 	u32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
+void fsl_guts_lane_init(int serdes_idx, int lane,
+			enum lynx_lane_mode lane_mode);
+int fsl_guts_lane_validate(int serdes_idx, int lane,
+			   enum lynx_lane_mode lane_mode);
+int fsl_guts_lane_set_mode(int serdes_idx, int lane,
+			   enum lynx_lane_mode lane_mode);
+
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
 
-- 
2.34.1


