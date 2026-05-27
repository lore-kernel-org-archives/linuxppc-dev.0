Return-Path: <linuxppc-dev+bounces-21577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5674CCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:14:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQT675gxpz2yys;
	Wed, 27 May 2026 22:13:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779876026;
	cv=pass; b=YzhhAd1ma+8ba0Ghd1uB+CA48o4vWcWOxu/+UvoAIvUqyrcdha7fHKYYgMI+DivCv64DoO/ecaN1/jUa/2lO0ea1y3I+sgubv6v8Ggf2yxWDB2spGZ8l3zAEc9XlfTm7FIwHVfWLsGzAQMeag0TorOXSANUvpUOMe2yGOvV9tDTSmeIcsF4SSVYl8IavWI1ZqTw5zJOZYuFqJ5Xf9va55wIT4077BLiueMkBF7LzvyOAd/XVyH7/DwJUUpKDaAPah6q3bbfnLywItqRlPpz0YBFH3Sndf1U3iXFSGJHAP9Ej1qsLc8jJJk0plOxo1WG+ejO1fGBW6f3HsoCoiRMZkA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779876026; c=relaxed/relaxed;
	bh=8gxbSzSZ1VCPEUMc3S9LTO+U4AB+mhKGP2U/6S0bdRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W59GlhuGQolY0aRn5O+Kguy90bETz0PEtYLaE/LDl+kSgr9qyL1xKaj0gp1aq+wWD2IOPW0LiOCDn6mUqaI5p0mChEKVl5IWlmWTn1ABsaGZJc7UO03oANVQkY5iOmvnQsiuf5f3WA8YMUZn3dAQg23iFIRDUfp+f4UKxKoCaOU6txEyf90AeLb4zWHNz7S4pX3K4JNGwH6usqLI4MOhP1QV9qpMuZ7iKvhXD2xoBFaMLpVGdeh+u7gMejGLNq/+HlE3MHt92T9A2t8TZ7t76WKD6uUhv3nLVep4uta5L+wEWIHbZjkqnkNamqV2a6cnAuwgUcZosAz6gp1HCk/hOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=k8sjImKM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=k8sjImKM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQQ962CpVz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 20:00:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM/EtEkN/LmB/FXMfeKi3sE25X4At4OKCeIapvQ7f8k4vay1DEU3njQt/sc0zx6IHMxeGB+wvesxUfeQO4N9bonoke4pjWHG6d4qp8zJSdCdkVNIzOn4Aq1/J8xIc5deH+Sx+eACBmag/0/8DMPX+c/mm0Uipq0qRYimA+2uXzbfNZkHgqEleqNyf/IdphijHrSbT7CcVkuRBJhXv/1ZZWmQ2D+6VINMeFlaGQkJbpOSV9eBbqtsI1xNrgSM0EKq8n6xF2rhEi9Ts/ObjNf14ZHhyb8wyBNnTD2d7HlIqza6SeA381+eVvlQ8GtgSejujix5+vWfp4eEfvmaNO/xYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gxbSzSZ1VCPEUMc3S9LTO+U4AB+mhKGP2U/6S0bdRk=;
 b=tZZ48ttLPWN3i99/fzULex4rJGyPpcsMFxZxUeR5yAhV1PhCu+NLeZCYLnDTZvemJ18dvT+LuHWm24X+3aKsKVEea3Urt5Sguzezjt7ED4JFGQXNiLrOA/1WHTk3cw6CQ4Vq17tfYk+oKHIlno1aGOVrK8qyTcxELDbDE41fpRnpcVZcMQ8FsmJfLuHu9Dy3sBWoJPHs6GeEUuT4HGEpGyhxdgEodO7NeKvU7+56nURlfOJelsVoHqwAQurAtlS/K7SdYPRZHMR/eHcgOJmEYR6zXqy+N53qoccr3hRDmj/7PJtFPfb1ux9ijijzQwErOUmWAzCdb3zLmC7cb94pHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gxbSzSZ1VCPEUMc3S9LTO+U4AB+mhKGP2U/6S0bdRk=;
 b=k8sjImKMakunKdg5FlEI67boMcDaG5uzAgSrLkFdlnDF8Cq+r7T4f71lnBnFpdqPWh3iWsPzJjiup4+GkZqmgjbnrfraqdGQ0tXd9nWDsZPkFVSD42cruA5Q66TYa844TDwTEVgXS4lB9jDXdssrmU1QCgfem51OvLfibQapnsok06x9sRx4OYYJQqQ0Fh8YskXAFWCZJBa6b0OU4S8Y8fPneB87sB+/JoQWbALMIzpLLv57tibN+t2LyQxv4i8Zzy2zFd9zrZpx/Vhhw4EvBNMak5JyId6COPgdCNN5mBCRf2ArWxW+43jcssAVksuFg7jqI2PZtgjTJM0fG+Qqzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:00:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 10:00:12 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 9/9] net: dsa: netc: implement dynamic FDB entry aging
Date: Wed, 27 May 2026 18:02:17 +0800
Message-Id: <20260527100217.794987-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0357.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB12205:EE_
X-MS-Office365-Filtering-Correlation-Id: ccaf9b86-826a-4e51-3138-08debbd6be47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	UMgkeymhDKMiCASZUmxEhom9XQ1PthLCNrExEk83JLPIwM9OzJciuNzPBMyzvS8RAZs6LO2yNBj2pxgKtktcb7Mkcoy2YYzSNOfiPR8SNrjsYvDWYlwSeOHoXkNxcvBWcOpIHWAL8+ksM9noEARpfKaNNocxpMdIAsnO7zAHmV45SbornKPcWLHJGjIaJMGeg7uyLlZr1qHSUt/9NksZDt5GoUJDJqzo5IB///2x6T0Ra2fbTMRHtXw+GSkpasgyDwTGPjRFb2P75AiXo0+JVjeCRYLrqEpwUHbGNSqH1IU7uM31tf+7CEJaMvbxSd5Hh4nmyEE1oTiXlwU5mItLiIxVlwqXj+rMWBNs29IsVhQYBpUzaIy+BJMB2P5UzxiqTDFa2/n8KtkTm6cxnJ646iF3sJch8jGudlkJuDzRFOtv+eulh+Zv/xk+kb2P0myDyC+Zfd42N7OxnpPgUY2sSr+an+FqkTQdUyGVdc6Hlt0940GOXhZLW+6w5fAFuGPlqzOVrFzJ1jQuGcGQ3n+vMpVW2r6UUH/oapcV13XShFoZyNbKvq5xs8JTLGT47Z3Cf7p0OYXR9YBtcsRStL5Y0yz1QZlb0oY68aQy8RHG+tlRmbjLIwhJAhc3Rkq8Mv5skt30TXRCh0XnxS9zlEe9vDIgSLJjZo3lWRq7lCaevTsCIlRoFcQ1jFmuXk4P/0361SFu/MHlHnpUnhr2JSU1PnRvcHh8dMEFp2a4QMw+oPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOp5Wx5CLipjwgmnGsz9ZCyTFe5ouSsVmXm+rVAB2S8IbE7Rc0FjJojNGr4Y?=
 =?us-ascii?Q?92vX3QIev2AIjFb2qIz1Dq+yNZbsd7wnGT8pvCEvab2KiIQQh9rjOmbGJlbU?=
 =?us-ascii?Q?A2tOFtDMzfvkVY/nioalEMsJrZ9eTqvqiuT5spq9OD2WW839mOuJOsbBCqLL?=
 =?us-ascii?Q?94Lw3DOAnSNMDE69sX6ruxZXw7X3Aj7kAD3O0iiwALl//5QmgAqL8+8Ag2P1?=
 =?us-ascii?Q?9wVCzrBQuhhJkTV0I6K/KLv8WfML7oi5WmMQWNqSuSz2DOJubTl7EaKyCwTj?=
 =?us-ascii?Q?09MXl6+a/ffTQR5R3V+iAdgiap9psb0lWmxOhHmjsopHZfDi0mSi1FSE6FJL?=
 =?us-ascii?Q?vS1HrIJvl2YS2qUvLqMErIwfNnnVoUtZN7ldD/YmtMXB/+BSoW+3UMyiyvoL?=
 =?us-ascii?Q?JneJZHojA04XEu//ZSNcwtZWmaWIEkQTFDw5xQIQn5+ChE+n5ccjnx6RYbk4?=
 =?us-ascii?Q?Aw4AjZnfEwI6DWPyVQAtFWs7pXuPAa6drxQPC1jFZ048pXlBlN8rH4/d1Qb4?=
 =?us-ascii?Q?q7jsHp1Y6QnOezFIUZfjF0iVpPz33/wIqPpXV/Ov8jP3ngBWq5GaXur/sraq?=
 =?us-ascii?Q?BWCF1n+DyNBbMJLuj52Es7IJ4hEwcUsKUMazKRPpI/mEIAADSE0p6cqMF1/g?=
 =?us-ascii?Q?cN2AZ0VeZbpyvF4aWvRITlGP27jpt/8ZClXqLBWi/peOcEWkTrhXt0OROJAM?=
 =?us-ascii?Q?MJJNW4h4+l1iKGVRyWWkzJ/aaQlCuh+/DTq/T7m9QXXYGokOf44Br9WO6wm3?=
 =?us-ascii?Q?QUU9kZSib2FdPZmOkNAa0O8AVlEVC6Kto07gDliQEdvGqhuUSzuYBRuEG08u?=
 =?us-ascii?Q?NmbGHmHp7AVd5SyAhn1VGtq4vg0gMiGq1CbVK9+C35CiPHI2H1WDl3N2S5s2?=
 =?us-ascii?Q?yMBPo/ItPWdCkzrIlBbLyB8LmlJCVstWDIIvhZQj6dhAcmdJnEiEWPMgBNpC?=
 =?us-ascii?Q?JWHuJiwkQbID7v+OxeCvLAnuPkGL046b78R5ClnFmHI0rgfkGY509DlX7eDP?=
 =?us-ascii?Q?7MRBdpNaFe9l1+JtUs7CxmDOb27WxajhuB9q9rjMe5crpSRucdcP6er9nWcr?=
 =?us-ascii?Q?Ue0wPRaBFTsuzAroGofZurF6CUdm4ql2AY68eKSyquLb61G1I0UZLNn7uhDW?=
 =?us-ascii?Q?nMnTu6mCy3FYm8PWwtH5wM/nFzBQXH125a+VhcCievuXSZnJ32MS2ap8R+my?=
 =?us-ascii?Q?cVdUvucMoOHz4Hykmx3qT0Hu5KjYzOmgAdrCEXV+C4iQLzbY18AnrUKofIhM?=
 =?us-ascii?Q?ht8bp0htrZcY1e0fatrJbdcz8f041WtAsAQ4H2Yq0uVBvSk5myKqRR8K0Pb7?=
 =?us-ascii?Q?BI2SSDWtqZBkrcL1/9vSHX8mEhKxh6dGCAWYUND27TC2PtLdacTBvLUeSG2A?=
 =?us-ascii?Q?EDPSdbmAbtGAllSgxtwmQJnswmq3WYSi24aHU+2R5EQ3xR0Z5yl/oOREsaLY?=
 =?us-ascii?Q?k+dO5SNE/lX0tL92qJxRHyRLjoJswqt1ULhzBULhrDW8DBGo7DBMiPSmKCCn?=
 =?us-ascii?Q?ONbwT2Ylwz3mrEPMl7hX21c4fLnNoDq6JEE6yZ1Fs0UWvZ+0HfpnDIs81/s0?=
 =?us-ascii?Q?OTN13t6IWSI6o4PC3HN68eGBKTJMKAD5fl5MnYrQ/TRUUkSAAxzGTqFy3WLz?=
 =?us-ascii?Q?IN8q5i9+7uj6kGnZe0URjxIirTerTFAlcJ/cgUsZZJZx9Ub/72uBrHlq9pjS?=
 =?us-ascii?Q?KNawdTxNGbCXCPuIxVd+ANv77MJXyk9ZURfEL+RAtNKFn9KX3nBUxtFpZvkz?=
 =?us-ascii?Q?W2K6dvjSWb6mcBfrZa5kqK2a3vm53JWoFxvPC5VroQWVHzwHmTNV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccaf9b86-826a-4e51-3138-08debbd6be47
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:00:12.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzGx8SyTL33sP2e/ruEwIPjzJIUpvvLkvwZd4ewZxx/K+WkR14fhr9dFHNq3gca3PGoMMFeNwI0TtR1GBmZrLl6zznS0f4o7JuDx+5RZ4rLdSliObklw7E4D6MJzBDaS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205

From: Wei Fang <wei.fang@nxp.com>

The NETC switch does not age out dynamic FDB entries automatically.
Without software management, stale entries persist after topology
changes and cause incorrect forwarding.

Add a delayed work that periodically removes entries that have not been
refreshed within the specified cycles. The effective aging time is:

  aging_time = fdbt_acteu_interval * fdbt_ageing_act_cnt

Default values are 3s interval and 100 cycles (300s total), matching
the IEEE 802.1Q default aging time.  The work starts when the first
port joins a bridge (tracked via br_cnt) and is cancelled when the
last port leaves.  All FDB operations are serialized under fdbt_lock.

Dynamic entries for a departing port are also flushed immediately in
port_bridge_leave() and netc_mac_link_down(), without waiting for the
next aging cycle.

Implement set_ageing_time and port_fast_age DSA operations to allow
the bridge layer to reconfigure aging parameters and trigger per-port
flushes on demand.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 80 ++++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  8 +++
 2 files changed, 88 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 1fe3b43e0459..cffa479e19b3 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -447,6 +447,26 @@ static void netc_free_ntmp_user(struct netc_switch *priv)
 	netc_free_ntmp_bitmaps(priv);
 }
 
+static void netc_clean_fdbt_ageing_entries(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct netc_switch *priv;
+
+	priv = container_of(dwork, struct netc_switch, fdbt_clean);
+
+	/* Update the activity element in FDB table */
+	mutex_lock(&priv->fdbt_lock);
+	ntmp_fdbt_update_activity_element(&priv->ntmp);
+	/* Delete the aging entries after the activity element is updated */
+	ntmp_fdbt_delete_aging_entries(&priv->ntmp,
+				       READ_ONCE(priv->fdbt_ageing_act_cnt));
+	mutex_unlock(&priv->fdbt_lock);
+
+	if (atomic_read(&priv->br_cnt))
+		schedule_delayed_work(&priv->fdbt_clean,
+				      READ_ONCE(priv->fdbt_acteu_interval));
+}
+
 static void netc_switch_dos_default_config(struct netc_switch *priv)
 {
 	struct netc_switch_regs *regs = &priv->regs;
@@ -860,6 +880,11 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	priv->fdbt_acteu_interval = NETC_FDBT_CLEAN_INTERVAL;
+	priv->fdbt_ageing_act_cnt = NETC_FDBT_AGEING_ACT_CNT;
+	atomic_set(&priv->br_cnt, 0);
+	INIT_DELAYED_WORK(&priv->fdbt_clean,
+			  netc_clean_fdbt_ageing_entries);
 	INIT_HLIST_HEAD(&priv->vlan_list);
 	mutex_init(&priv->vft_lock);
 
@@ -924,6 +949,7 @@ static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
+	disable_delayed_work_sync(&priv->fdbt_clean);
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
@@ -1918,6 +1944,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 				 struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	int err;
 
@@ -1944,20 +1971,42 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	np->host_flood = NULL;
 	netc_port_wr(np, NETC_PIPFCR, 0);
 
+	if (atomic_inc_return(&priv->br_cnt) == 1)
+		schedule_delayed_work(&priv->fdbt_clean,
+				      READ_ONCE(priv->fdbt_acteu_interval));
+
 	return 0;
 }
 
+static void netc_port_remove_dynamic_entries(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+
+	/* Return if the port is not available */
+	if (!np->dp)
+		return;
+
+	mutex_lock(&priv->fdbt_lock);
+	ntmp_fdbt_delete_port_dynamic_entries(&priv->ntmp, np->dp->index);
+	mutex_unlock(&priv->fdbt_lock);
+}
+
 static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 				   struct dsa_bridge bridge)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct net_device *ndev = np->dp->user;
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	bool mc, uc;
 
 	netc_port_set_mlo(np, MLO_DISABLE);
 	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
 
+	if (atomic_dec_and_test(&priv->br_cnt))
+		cancel_delayed_work_sync(&priv->fdbt_clean);
+
+	netc_port_remove_dynamic_entries(np);
 	uc = ndev->flags & IFF_PROMISC;
 	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
 
@@ -1977,6 +2026,34 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
 }
 
+static int netc_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct netc_switch *priv = ds->priv;
+	u32 secs = msecs / 1000;
+	u32 act_cnt, interval;
+
+	if (!secs)
+		secs = 1;
+
+	for (interval = 1; interval <= secs; interval++) {
+		act_cnt = secs / interval;
+		if (act_cnt <= FDBT_ACT_CNT)
+			break;
+	}
+
+	WRITE_ONCE(priv->fdbt_acteu_interval, (unsigned long)interval * HZ);
+	WRITE_ONCE(priv->fdbt_ageing_act_cnt, act_cnt);
+
+	return 0;
+}
+
+static void netc_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	netc_port_remove_dynamic_entries(np);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -2231,6 +2308,7 @@ static void netc_mac_link_down(struct phylink_config *config,
 	np = NETC_PORT(dp->ds, dp->index);
 	netc_port_mac_rx_graceful_stop(np);
 	netc_port_mac_tx_graceful_stop(np);
+	netc_port_remove_dynamic_entries(np);
 }
 
 static const struct phylink_mac_ops netc_phylink_mac_ops = {
@@ -2260,6 +2338,8 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_vlan_del			= netc_port_vlan_del,
 	.port_bridge_join		= netc_port_bridge_join,
 	.port_bridge_leave		= netc_port_bridge_leave,
+	.set_ageing_time		= netc_set_ageing_time,
+	.port_fast_age			= netc_port_fast_age,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 982c8d3a3fbf..8ad828f7d28c 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -50,6 +50,9 @@
 /* PAUSE refresh threshold: send refresh when timer reaches this value */
 #define NETC_PAUSE_THRESH		0x7FFF
 
+#define NETC_FDBT_CLEAN_INTERVAL	(3 * HZ)
+#define NETC_FDBT_AGEING_ACT_CNT	100
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -124,6 +127,11 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct delayed_work fdbt_clean;
+	/* (interval * act_cnt) is ageing time */
+	unsigned long fdbt_acteu_interval;
+	u8 fdbt_ageing_act_cnt; /* maximum is 127 */
+	atomic_t br_cnt;
 	struct hlist_head vlan_list;
 	struct mutex vft_lock; /* VLAN filter table lock */
 
-- 
2.34.1


