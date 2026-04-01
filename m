Return-Path: <linuxppc-dev+bounces-19128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC085D35164
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:41:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0P52Vq1z2ygY;
	Wed, 01 Apr 2026 20:41:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036489;
	cv=pass; b=ip6lBufB5GKoWciZvndhHG4jtx14tp0oaNVTvSUfgPNBdw6tP7CY6farkCYRYdw4FCw+xDDj+MeyYXO4EYbB8AIaxN/1KbhLlkyF4VeQQh+1ov04NKGmXHQIdvSNpkzIXPk9Kz/yT8URwAzgD+bkLHAsW1vOi//k7Dl1gEXYMM1Cgi8HOFS8pBTRb8Jgev4hrYzDy59wX3Z39hLGypytJgcKWcRmKLYftZXRBDqmbhh+JR8WqSd/aQdPfvaYgEgwg37Sjdr6dhfzuLaTpVARxoX3yMtkilud6GHP4Q9+7oEOZrUujmdQ7+zK5zDlTGI+WK2hgtu1aKt/4v9IyGHEvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036489; c=relaxed/relaxed;
	bh=IaS5JlQPkj38YMmRmhpy13HP6CwjxmxX79j24Vy+EzQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SSLI3+NrB0PmeSQ9hl9wwt1OvreGQPE/Vo3CA/Sq9hvMc0pnf22IVkJCca0a5bPCJAxrUQOzdbdQr0esrYwrsJXGY7cNcqZ+/aHtXH8u3u+jhcbx6xdOVU5m0D3gl8BUK3WdgpH9IjVdDHI+v3LQdR5+BIO1pUsCv8XM61YBGgET5DWCk2hCAF7eInS0MtIJd2rkukLt+BSb697cgsr6eiUZWqko2NYUIDvcIpO+8gd9vsadGBQsL0ZClKXWO1Mo480XwtvZrg6uedHNAD4baT7q9ZgcROBVQXjqmEC7ftlbfMRHmyfdh+V7ODWhC/7s5NHiqV93bRULKpV58ZPqnQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bwkHWNCO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bwkHWNCO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0P35zvlz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0/PY0EHdInBVXDgi/cgIeT52oWUr2tJ1zlW4nshT0zDDCr6VhW7g8TXPVsvP7BPIhwXGdva3B3XNY4aqm5wkuqXEI4wWEnARNGEUnYEEN0vlWQhKAV9+vT8mckkeOT058tX18Sh04IruxY3Uvw0iZU//QslAJtwPF/zgHdWER5wl+Kwr0jPpy0JxKu+3l0zYOV7AN5OJkBriYi1hS3vJfr8cVazbaBwYPVyF3dfuKC+cWAlJu50sFrmSmlFkXI+boxGlEeoHiBQlnVpiaFsaMaB3vi7oHilZQN3e5pItTUo+Y2pM4wYkGkapu6rDCeAQr4YB09chy1pzo0bMjRqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaS5JlQPkj38YMmRmhpy13HP6CwjxmxX79j24Vy+EzQ=;
 b=ruIz0XH17O8puL82TPfc8MmpEWZ96TiQF0ZH6k1jnu0GeJNCt1SyXful4llW9yfnFve6l0Pmgp8g7cdQ/DFM0GP/ei7BhgmppX4kiUNki04Tkejn8LoiCX7H73ZbeenfGng+Xz00ZumqiGv9c5jq321lEZavQr6uJrlWJv+iPzHLEsi6ipK5RQ0watQ87ERqS5AZhwDti3jOjW+l5HbG8LzxOAQsI11I983Vja2gFnXe3EWI8LMK0YIAn0gQEpvhaa3Oi9t+LHwGVSdkjAgeyOIx3csGfruJFvH7eOfV2AG6sv/yIIaReciAx5RSSf6Di0Piml8mxDpxleaBJt3oZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaS5JlQPkj38YMmRmhpy13HP6CwjxmxX79j24Vy+EzQ=;
 b=bwkHWNCOvfur9ajlYaXLPBRMKC7QbYBVa9mmeGC0FJJiicazsExRvtAiigEQ2SQnlh1o/neHHOA1F4wGaBO3rE0cOjZSBJDEHS/RRxK6Y2vDoDZ1eiKroWvQdztJrSVcaU6/4KBvUNt+/VawvLviyy+8dBVdwqG0Q1CpA2TJGHfEC8RjvAFe+os/ejo8RhuS5fwfzY120sbLXgZlAMcbggaR+yniKuxBVKYZs39hVI/QQpVDsi4anHNYWK4ZnE1ZL2MNW3iy2Vo6btwC8iBO/yS1YxCCkznrwGhQS4CrMa495iwvDf2a+Oj6k0zTGLyDt3OGQ11Vi4duB3ZQ3x34GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 09:41:00 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:00 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] ASoC: fsl: fix mixer-test failures
Date: Wed,  1 Apr 2026 17:42:15 +0800
Message-Id: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM9PR04MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e108204-2692-4268-98f7-08de8fd2c865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	8FJf9OIQgobTaePL5Rp6eO8KPpZ+A6QFk/lR/NtiMtILb6pTF6pAZxV50B4j3g/cSG35z7hrhqvwrS+GdUs9ae6YHJ5RcZVIfnW6uY+3DKHD+FZVdjAo1w5rQuGmJyiY9jsTj7aEZlmlImAnMT2O2WECxjHwmSLi8NI9O8Y1lfVQ9WmzBCouFJF6XqdOtv74sJFf+KKIkMwTC+IzZ6rv0uCAVHuqd27jLb64hfqXPCAS2nXin5w1O3PvgvbLq0IRCrWETrpb3XM9/0VVYPWTEHVaHd3Csur1Wy0bQv3wL5JmRQXAXXOafgz8mBsYqFiJ8f2pycJrTQ2dBoEtksOAoxZ7stRixFUL0S1Fxo5RPaVgjD9lauqxCuTIWEOG+Oe97MBq8j4xPtYpXDnU8dvfro6ChGxEQda/u+p63VKjSTaEEh3297uGBW8yonRK+J1GOCYyifT9fGrhSOhD1Kgr8Z8TmoJ29fPHBMSq3YRVYV4c+9CZoqjcx7xx60DonvQ1+9tQOoNksc6PwNHqEzIUWIWaZBu5N6Lm6C2vKR7fVYOBhOJlaUd0rd+lWYgFvmKiNYRcYoQ0oQeWyhI/vsTxmirjNBuTcZGKQ/K+eR7FCH3WtZVkAPWgbVO7AnK3bhqhiCZooXgV5/u18QXkL496ofpR+qgW+1c4NDKunlt3u8RvLc8E7oG9d54GrB3X/oImV6PBDb/riLEvvoJLbqn5jcTfD5feMRL5Q/SEkM8TaDZlEpmWhQA8qNQeIVctKSZljIkIiJ7/YQnUneySxgAY+xGNcTeb136e+tL/WVLi44WLoXXGiL96UTFyDY5AG/ML
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tNku7yvJ9YrBy7uRVQfhCToOFINsN1Mm2posl55tpzKbMrBE8d7xJ/I5tC6o?=
 =?us-ascii?Q?quuNPiTkWBYNSh1Q/p6e9qk8OSRxbhvs3eMyoTolTSB8zht0y9Z4iyK5ihZ1?=
 =?us-ascii?Q?97sOCxh+Olu7vnrzCHc0JGIGGWIs1CMn/I3bAqf2FS4qaCTXbUT7gGbklzz2?=
 =?us-ascii?Q?w6Je7TUSD2PnBs1OV6CgNWpF9p3GziMNOWwbQB8+OC7vodAmnmzL/33hJQu4?=
 =?us-ascii?Q?7vWTZRWt+IzxlFT9KlTVauwFiKLGXLX5hCLCNgdVxPKp+Pr0E8fu6oMBbPs8?=
 =?us-ascii?Q?3Twdh10BWH/Ox6tkvMtIdWI0FHRRwNfk3fhdQNre6x9Ad2oZB3EnT2bCci+o?=
 =?us-ascii?Q?n0d0htz9WAiolqxxjWFlCXeeJ1iqiN7RgHayT/JDsXV0fgBycCuYFGcuQ/7f?=
 =?us-ascii?Q?ZQpDgx3SMfLlL+BhurMuM7/S5lMTVZtzkvORoBZbTn5Nu6DBjJTA1v8bN6T8?=
 =?us-ascii?Q?uOc8GpBkfpc3quWW5hKWwD6qC8E81hliluFHbDOkefgHp/0LP6WG3FTqIz4p?=
 =?us-ascii?Q?skVuoULS0JhcYkQe9IRdgsI/xVXkDCvL79AAIKpJR/Vzi4HdHUVV3oGz6U04?=
 =?us-ascii?Q?3B0U/6kMV0RRZokr9YL8eE6I+/Fm6cMvqxPJeZ9sBrOW+QieDXzy2v+N8fh7?=
 =?us-ascii?Q?sQ5CKkExKURRe4C/ztGv/FjZm5+N1TWmhLUET8fvX4BP6SGqe9BnfJkkUxd2?=
 =?us-ascii?Q?mRGmFjbwOrK/ueCf1Pmw/a1ggfAfizshrun75s+n64jcnEdh1Xrnmf0Wl73l?=
 =?us-ascii?Q?wEBeFNFBYBBoypKUyXeJclNIipqArR8LjNoqj+Pp/Cb5S5nl+pYOKzwBdYcR?=
 =?us-ascii?Q?bPu3VsPYL81LKnheDtPSm1PlG6NGfJydidmE5YV1n+Oody2VBOzGNgJRtx9o?=
 =?us-ascii?Q?P4Qr+wNJiN1g8ZAk3YpLEiOvofWg21qxdxWrDj2V9y6uEypJVfTQgXodkNa0?=
 =?us-ascii?Q?1ChCZQIn/omUWX64SqprE6mehgdh24ZCP0Dvmrdvtn3ReiNFtLI4g0p3bttL?=
 =?us-ascii?Q?2CwQL1Ija1o7WbizoN4VXBe4jGzjxVbaAWBdOIUhs2cK8Cw3sR9LhlVWhkqE?=
 =?us-ascii?Q?qe9M5TIUF/gln42xRnrqdLkn6D8SVndx3rVzv6atdi7MAp+O2SWNpYnD8hjV?=
 =?us-ascii?Q?OXVddzLjwi5HGEPrCvP6XtVQAZq/0oJHCA8xeIXIqv4RD2FvjM5Rmb7acdoM?=
 =?us-ascii?Q?EaZopdqnQ4+HcFUvScQC6ionHYyAj/nMBl/S/jgQBZEZOQzWO7YU3++8zqkj?=
 =?us-ascii?Q?q33ZlaahLbNCcx5n2Z4T6PfXwIngCA1UF0z5LLj/iZlZU9hFR8fl6ZmwANrD?=
 =?us-ascii?Q?mPRNO1iJZ/Od/Gl6txrv5JM67vR70sxTB+wAYUZNKiD2l6T6zF+wlfczp11e?=
 =?us-ascii?Q?8ulNS2GPD9akCwCaGvChROebbMrGOeRsqFpZWuwsguzX92eZfHbjfiGRUXA6?=
 =?us-ascii?Q?9MxUEeGBPJe7Wjy8v4p+ThG4so7vRmbqxmUtWLsKytGvQ+xvzp0/e02wxxai?=
 =?us-ascii?Q?3YwJa0bJ4hOwbPuEhZL66r4jpJADLKEcMIlO8RqbKDIngiAN8/R+cQ1ijf5r?=
 =?us-ascii?Q?SKGmgiAHletbdHHuY1swMpRwuKuJ1EOEcV3oKd5Asz71P5IzwWnyzAkf4VGV?=
 =?us-ascii?Q?ZHpR5bnbiSLjhET3A6wCyuSw5659JRMIKTrdJD7DXGUEUKAAVrYQ+H9E4yW2?=
 =?us-ascii?Q?MFRBCAHLemOFPvaPzkZlGJY9YzQJrAZko0d2k3xnA00pSlE36ZlyEdV0C4pt?=
 =?us-ascii?Q?49WiJQiOvA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e108204-2692-4268-98f7-08de8fd2c865
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:00.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WT5Egaesh9dSJ1RdTq++FcqHePunWZ+zswEx2s9bTmCf7/QQRlq87qnuyQsCwqoFGS4w69YGWbqA6X4wMFH2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

Fix mixer-test failures. Mostly the issues are that event is not
generated in put operation.

changes in v2:
- add back event notification in patch 11/11

Shengjiu Wang (11):
  ASoC: fsl_micfil: Add access property for "VAD Detected"
  ASoC: fsl_micfil: Fix event generation in hwvad_put_enable()
  ASoC: fsl_micfil: Fix event generation in hwvad_put_init_mode()
  ASoC: fsl_micfil: Fix event generation in micfil_range_set()
  ASoC: fsl_micfil: Fix event generation in
    micfil_put_dc_remover_state()
  ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
  ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
  ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_mode_put()
  ASoC: fsl_easrc: Check the variable range in
    fsl_easrc_iec958_put_bits()
  ASoC: fsl_easrc: Fix value type in fsl_easrc_iec958_get_bits()
  ASoC: fsl_easrc: Change the type for iec958 channel status controls

 sound/soc/fsl/fsl_easrc.c  | 123 ++++++++++++++++++++++++++-----------
 sound/soc/fsl/fsl_micfil.c |  72 +++++++++++++++++++---
 sound/soc/fsl/fsl_xcvr.c   |  22 +++++--
 3 files changed, 168 insertions(+), 49 deletions(-)

-- 
2.34.1


