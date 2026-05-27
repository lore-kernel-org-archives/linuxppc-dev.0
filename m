Return-Path: <linuxppc-dev+bounces-21568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A049BCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:12:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQT5B1SwRz2ySf;
	Wed, 27 May 2026 22:12:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779875992;
	cv=pass; b=PyVxo7MGp91I2QU+EPJbVQ+7uvG6RDDufZ+JcL9dZ+SMahwxHt+xm/7jTcqDCFs170FCu4dsWZunlTXPRXmlFXDvTkjF3XN1gve+R6tyHp+WaGpwdANAW/q6bhs5LK74dVbsgJmFzOoYeN7Tk0Fo2yO1r/NhZcDMJw51kYyzkdq69d2NuEggytsuGz0zDRakRCiH2Ie1WrQQMb2wZG42mKsmHiaTsJqIsZgX6D8BG3x58tZOd36pMfRxL6wW8hxjgcji6Z5SdR3ZbX9pHMIYAgFOf+LReYmI0Ql0HCdfOhHWN0oW6pIiZL/T0TrQvuSvM9/Gt+TPkHzBoJRqQzDbXg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779875992; c=relaxed/relaxed;
	bh=4iTqP21DsQRVkqEqEgrZs2AQ1IavhPuKKdYfdZF8OiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gceNc1rxyEPZIn12Dj/busH6JKw/YHxsk+nFFv2+hNGADUxI/NB0/iHWossdKNeT1hQ1Z8VSgSuv5ujFCWuqCHEB83quWaOM3cUNk7fDRLx8DeOy7BQQOtXWbolMo6tWwSYb7WvgujHxY8S6WydB3CsekZ/15hySt0qKbVaJ/BkAE5PmzVTA9OD1kLMQkXcXKpoODIkmP7WV095IMKvCP2NIdEa8hO9SphUMXq8Es7uDxPBOuuvuCLfve+SeqUreXOTX+SNVCuiaEaQa4Ttia5FaljkYpHZGA1/nVGcj+Y42wVWaM7jCf3QKM+5HwgygyuzFd3vj/fX58d/5x/iVTg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=innmysiI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=innmysiI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQQ8R45Rkz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 19:59:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rp17AvesXhkngJ5BUbLCyCxjUQU0dbmaJpKLSehppy6r5PWVN1fqfSzeNlteb2zxR+qaRSCTcouzfESDtD5H96dXn8pA6cDlm/NoGWCU02CBbLqXgrLjbUnR8jAKq1Rr+fs819w4PPHfhbjaGaZxU6rvUETdqrQRmKEeKaATSv1GJ9SjlCFA2CZXUGcJW8hAv85vrzGORxeQHIrkX/UtOV8ND+Cqs5+5xbP8wWPdK/kvohBK7Aig/9zMWAaW0QCSrbmRL615QK9J7EhZz7FWd5S4Ldc7Cg17/olGdDUHHkhRrBxTdRaKM7eQwz4v9Ue39kedJuPLMN1kRSXfbv/ANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iTqP21DsQRVkqEqEgrZs2AQ1IavhPuKKdYfdZF8OiM=;
 b=HIX7ibAfDNesovd6LO8yulycLrGvWS0LUy0HcjZldZ2a1oPdDnZdisB09ZrxD+uA3elSMSL1Zv278nydc5gdrEAtBsCY+NEEeMw2qqJC0toNHfXTfriRofdmC16GUrtUjOs5prFSkbdyXT8ne0yYufBj6SSUEAsreekBXSSYyaluw3zr60n3sv1QXaDP6TwBWUg4hgWDerqR7AUQ0zQ2yx+mP/SEi6Kaffe3e3ApXEDjj6ddFGCc0R9SQw0OCxzjIUlvSDxFZ3pZ9hVRKSg2Jg/DdTiPJOnKH6qOOiy8/wGQUbOM1Bmm+JEL1eUXtsl471QwbtyZ1MZl1yYfu4knXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iTqP21DsQRVkqEqEgrZs2AQ1IavhPuKKdYfdZF8OiM=;
 b=innmysiI7oGtnqzMmPiS9irX7WUouyAcvnWmf9W1AA6e7XrAYCapTp4rPq2Aq35Q79/U7Tqlq2lmOHj0jCZWjbEPgxlrLFikrp722gvNAK49l1XTp1b8HL1B/TxuHSMmEoWTZ/5j6RJwrbWZIXVcG0nP46w6c6DmK6rGMoxcaE5jF55XutXGFUQ6jVjBecphD8/pZCjOSqrYp+VGkbEmarxcvorkLo2gp2N+jXDa67NoMo8y3am8OTWb1xVmz2s5fqHvKQW5va9z9lwLNoXxNcIYcC/bgEUYaey/ZOBg5qjr7aw1CQmbr2KXY6bG85Q8Aks1ZHHEwk3W1LgUI2kwiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 09:59:23 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 09:59:23 +0000
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
Subject: [PATCH net-next 1/9] net: enetc: add interfaces to manage FDB entries
Date: Wed, 27 May 2026 18:02:09 +0800
Message-Id: <20260527100217.794987-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 013eceb5-ac66-4e0c-87a1-08debbd6a0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	0FeOuJUH2qwRTZL53Us9gcI+4nhg3CNtD2RBXf3deiDMP/bdC4f63PMA1idC4W4fAclReQNS9/LZ477iN/hblL1i4/AGRqzNf7Dp4310SDb4fYGS7kj5OXv+WdvQVsdxk8ztYwcVCVkSi0uox7rFzEAJeqPWSpkruo+lFeW5g5hsOWL0Uu9xRXzOxICujC30dF2hRIqC+CJynPj2TGgYXDIbNHgdvvg2F8OZKd8svhvsXhbEGT1REjLS4+oRYp/b+JE9n4gndwwxBHZw40mOzm6Ymn2rfapsRmhY5HxVuYsoeItN5j3ULWnf9iGN3cUcIutZlynxbrKGD02GRdfFTfnzknOLqUQKabmOvgAX9/UHYaovvopt45RhdO/b1MxdP8Shtk4k6v8XU1tnJbDOrvRYnnKSDl7tzXrU31CwbTgmQWC9bsDs7dLx9DAk7l90Orw8vXJVAudcxJp4T8nqNe+zjlX3NE1V3JRoFVzkbGBFBqI9pW8wcWuDip84tbA2sGTiIwrnUqORRr3ex0FozsUuWTkFn1lrbi3mylL6u853axbwTiLMNNgUyxsfnff7/I6TQUOBZJt1NUbtseRI+cMn9Zh8A7EUpP0bMHSZSEpnNnkf4wlYJ7z2tgsSBbclomf6lsC9ugNly6vgER1nYZAUkH8FrceuzXldH+e6JzSQURDuW/Kxp/gk93l2pB6k91z91ujz9kmFAzOt8scbM5xprMx+3tBxj7imNJ7XfCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n4s9QsJHtpAb6wlzmfRk8Yrw9BCvg4P6XuozkETgomtETTdAZ9wHUT/yreAK?=
 =?us-ascii?Q?JGq3j30RBlFj8eZVTV/4LmpPZt1OJjHr1tCScAD5lYxLHsGvTJE7APfl5DMN?=
 =?us-ascii?Q?Y0nImOY8oChU+H/m8xwz3W960kBlIz9w1J+RFYaIXGciZSfnwGGtby5W6jXM?=
 =?us-ascii?Q?3/T3wL3p+jchJb5ldk+AHSNbD1RbOXG35bGc0QhKjvp5cC+VnWyoni7XKOFZ?=
 =?us-ascii?Q?/mkYl9Vc2GMr1ZUwAyTN2S3AfJ6xP2FvPnkBWG5BiFnRD91yVZiN4xJTot+U?=
 =?us-ascii?Q?jHuo4Ps3i5v653LhGtwxg79XI1jVU81bm+3OuHSQf62Hh2JD9alawm2XqUcS?=
 =?us-ascii?Q?LZJhi583xkLEIlFvukaJdJthhnP2cxd+RJc8JshOj5YM4pSqJ63T6hLxjnHv?=
 =?us-ascii?Q?HddAYSCR+YdDNsp4Z4wQNlAMboQNweqGLYRawTCUuku/2avItBlxBalYREkJ?=
 =?us-ascii?Q?Hvemh/7UyRmvtwkSVBdH9B9RSJkbtZKgWtRxG0IfWXzv4JNMPEhMtSOMn5AC?=
 =?us-ascii?Q?IXhJi+ZRzVSEiOpac1OHavB/ycBb7dMrlL7O1P7damCMBeOSPhTnxAX9zeM2?=
 =?us-ascii?Q?vzGDgVen8D94N7T6Zf881K6Qo2kVDjv3uhY+ZHPthClxblnlMx7ySr+n9+jR?=
 =?us-ascii?Q?lkjdHTv6QP1pjnDuXAcIF/aKee3W2+ei/SK+OSBsi3EV3f0XU30IwR5G4R/j?=
 =?us-ascii?Q?71TO25y34ZsJ9HCnp+ghDRhbVQeDWx01zBf/aoK2LlZx3u0PUVbfN8EdNp4F?=
 =?us-ascii?Q?Lm8JEQI2dK+pGQxw0v4XXQVMTC2IO2H8D7OcKBz192ELDp0/LOrvPzkCJdFT?=
 =?us-ascii?Q?5FuhDqhi1e6+NqkMi1/P5uV9+AZ73efxr/6gI1WVWSALWK3Z4gyhVypBtCSw?=
 =?us-ascii?Q?rmWvqizRMJ9VftL3Zy/F5NudA2Qnt7+IsYwLcAbEd7/1LH7mxlFWaBOI3Y0q?=
 =?us-ascii?Q?z9iX4qECGkuirUa1vhfWl58YXjan5dEWrc0oA22oPAf25dMReKkgJCasMVOX?=
 =?us-ascii?Q?0P6jysIT03uZzTmquK6XtA1uqFfSLf1QBXvaEfen4JvIs5WJFLVgdVqbhHov?=
 =?us-ascii?Q?WDVFT7Qfh3HVQu8L/Ai9pkGIrGRyoaGIMDzilsOVcloaIV777aASYjThKqK4?=
 =?us-ascii?Q?DtPicNhx+0rJkg9l/EqLRx8QJCGY1KVlJ8g6dthh1hwKwcSpjcl0sGvab758?=
 =?us-ascii?Q?X+9Xo/ygxa7DaG+hiXPBr+WTKB+17dbQcjqk2EWXmkb5LQjwz3UolO0Inm1r?=
 =?us-ascii?Q?qoYYJ/lYNSYrjyQvwCog/HfvL3KB/3XjlqSQW9Srd0FmF7t5twy8/Kw7Wvgy?=
 =?us-ascii?Q?KUGj6mOVvW4u+JqXfwlpn5SAL3MJI4Bo3YP1i7LD7LmIAEM+0c3aMkysh23J?=
 =?us-ascii?Q?mSxS+E1oCd8O/r+6HvRXnPV2WCmjL0X2XLgqCadP4hery1XaXTgaEGdV5OJp?=
 =?us-ascii?Q?z0l3BlIS7uL3UBfWJJsiF8sKqeJqjwtvRjji+KgUuhdBZRZ8SAXAL/pW+OGP?=
 =?us-ascii?Q?03LQs2LDytiytzRFvUIrSqVvUm6/suNqLyU2xdxLjtbEcpDyWvFb1KmdHobb?=
 =?us-ascii?Q?Ni2DgsD+19MnTOxLORbSCyWf+ccxYWRv/164cUNDL2eSh3TiGs+6SUjZD7lQ?=
 =?us-ascii?Q?MS7/3xho5kqkbYDVpGQeWy3acOPkMc3RljtYWYCh9I4n9z3eueu0E3zazgVg?=
 =?us-ascii?Q?2f+OGbYFe68VsXwyfPHHEpLmSGKcd3UHG8tqVZljZ/vqtYFQsLHCc9CfUx/9?=
 =?us-ascii?Q?4PhLICe0qHKESt6h3zbs2mC303tLw5/LQQPs8wDMs6jcYQdwL6mD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013eceb5-ac66-4e0c-87a1-08debbd6a0fb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:59:23.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhF5yZ/PUS7flES7qcHdeghXAT6C3Qepn4P8/0VNSG90xDIl4fFq80IN0kwkzAxLGWfMFzvGeRFm3FkpVIVYVXdTf5TDiubBSOfdJnntn9qoXPhb/h6nDs5m6G+mrxO1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205

From: Wei Fang <wei.fang@nxp.com>

Add four interfaces to manage entries in the FDB table:

ntmp_fdbt_delete_entry_by_keye(): Delete the specified FDB entry using
key element data. It can be used to delete dynamic FDB entries as well
as static FDB entries.

ntmp_fdbt_update_activity_element(): Update the activity element of all
dynamic FDB entries. For each entry, if its activity flag is not set,
which means no packet has matched this entry since the last update, the
activity counter is incremented. Otherwise, both the activity flag and
activity counter are reset. The activity counter is used to track how
long an FDB entry has been inactive, which is useful for implementing
an aging mechanism.

ntmp_fdbt_delete_aging_entries(): Delete all dynamic FDB entries whose
activity flag is not set and whose activity counter is greater than or
equal to the specified threshold. This is used to remove stale entries
that have been inactive for too long.

ntmp_fdbt_delete_port_dynamic_entries(): Delete all dynamic FDB entries
associated with the specified switch port. This is typically called when
a port goes down or is removed from a bridge.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 206 ++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |   5 +
 2 files changed, 211 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index f71cad943424..2e79515e1772 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -31,6 +31,7 @@
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
 /* Specific Update Actions for some tables */
+#define FDBT_UA_ACTEU			BIT(1)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -722,6 +723,49 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry);
 
+/**
+ * ntmp_fdbt_delete_entry_by_keye - delete the specified FDB entry using
+ * key element data
+ * @user: target ntmp_user struct
+ * @keye: key element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_entry_by_keye(struct ntmp_user *user,
+				   const struct fdbt_keye_data *keye)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
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
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.exact.keye = *keye;
+
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev, "Failed to delete %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry_by_keye);
+
 /**
  * ntmp_fdbt_search_port_entry - Search the FDB entry on the specified
  * port based on RESUME_ENTRY_ID
@@ -793,6 +837,168 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_fdbt_update_activity_element - update the aging time of all the
+ * dynamic entries in the FDB table.
+ * @user: target ntmp_user struct
+ *
+ * A single activity update management could be used to process all the
+ * dynamic entries in the FDB table. When hardware process an activity
+ * update management command for an entry in the FDB table and the entry
+ * does not have its activity flag set, the activity counter is incremented.
+ * However, if the activity flag is set, then both the activity flag and
+ * activity counter are reset. Software can issue the activity update
+ * management commands at predefined times and the value of the activity
+ * counter can then be used to estimate the period of how long an FDB
+ * entry has been inactive.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user)
+{
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
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
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, FDBT_UA_ACTEU);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	/* For activity update, the access method must be search */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update activity of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_activity_element);
+
+/**
+ * ntmp_fdbt_delete_aging_entries - delete all the aging dynamic entries
+ * in the FDB table
+ * @user: target ntmp_user struct
+ * @act_cnt: the target value of the activity counter
+ *
+ * The matching rule is that the activity flag is not set and the activity
+ * counter is greater than or equal to act_cnt
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_aging_entries(struct ntmp_user *user, u8 act_cnt)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	u32 cfg = FDBT_DYNAMIC;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	if (act_cnt > FDBT_ACT_CNT)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(cfg);
+	req->ak.search.acte = act_cnt;
+	/* Exact match with ACTE_DATA[ACT_FLAG] AND
+	 * match >= ACTE_DATA[ACT_CNT]
+	 */
+	req->ak.search.acte_mc = FDBT_ACTE_MC;
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	/* For activity update, the access method must be search */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete aging entries of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_aging_entries);
+
+/**
+ * ntmp_fdbt_delete_port_dynamic_entries - delete all the aging dynamic
+ * entries of the specified switch port
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	u32 cfg = FDBT_DYNAMIC;
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
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	req->ak.search.cfge.cfg = cpu_to_le32(cfg);
+	/* Match CFGE_DATA[DYNAMIC & PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete dynamic %s entries on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
+
 /**
  * ntmp_vft_add_entry - add an entry into the VLAN filter table
  * @user: target ntmp_user struct
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 88166f9ad3a2..f18556b072c8 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -260,9 +260,14 @@ int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
 			   const struct fdbt_cfge_data *cfge);
 int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_fdbt_delete_entry_by_keye(struct ntmp_user *user,
+				   const struct fdbt_keye_data *keye);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user);
+int ntmp_fdbt_delete_aging_entries(struct ntmp_user *user, u8 act_cnt);
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1


