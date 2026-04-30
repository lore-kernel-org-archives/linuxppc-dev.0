Return-Path: <linuxppc-dev+bounces-20304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C334FF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:47:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5drQ0l9Kz2xmX;
	Thu, 30 Apr 2026 12:47:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517270;
	cv=pass; b=HTAb7gspRKMIINyauxMGZ2TsjMVup/6pfCGvItONZhVhPGE37PItvVQYRMz3OMGy9Yr68ROZLqXYkgVuEC6XFdEAz1aK1LoePcnitoKW+lhBBcCPhzQBmeXe9/oCULbaE9j0VX6zBNCxn+uDIPZsr19vzD6yFAKvdo/A49kpoONSnrPk8YyihiF1opvGFKb+50xM8ydaQt1wexFOQLAMp7KSxi9+OQEBNDIBKdC7Rk/7tshzld2jirGwXYy9k0CsCEqqygIDKFIErI/yxnmLtTItfZlVyLrFzt/1s1cRNeni+GOANHSapk1QVZdcr6PQACh/5DblmXcTQ8gDVfh+gA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517270; c=relaxed/relaxed;
	bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FbL5inHfRSr++jQKIowZ89WHCClizO4W4mzlKkbB5UB+eFNaoSA+/RWmJjTeU4RG7b9pPc8wlwYNHqQ+OH2W7jYPqMMTIvC7TQnz4TqGEgZOVpAF0WNIxv3ujzJFoKLO93j/mc5wJLwnVIhSJSPI/j+A52HKgZY82n4p1GRaMXLwfn+Pl2bN7Y1sE4N34YY1K8YNdTNfRI616y1olPRM+qju4PUG3RqXgILXHDfHCAeeoy2E5gCnVBgPodbEpFVyplghmIznrSc/641KOP7BVon0263hYKMSnsxqg+GLCzNRWWpt3pC/WjLber1Bj2pxex9OpBiH0PEVug6Pageeng==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bIQFshSI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bIQFshSI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5drP1cdkz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:47:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC8MxSm43BPwIORMh640YcA4x5uQ2EbFLVeP7nitL7CiEd7L3+nbp+5uiCf9t5Bzeh8jsgndHrVO1uhMngfwOpHqL5M7zpOpMwhlO8W5cMNMnbwhW73TeixYKy7Lt4lItWe5GWxNw0JaXTWnEhjvTGJ51+nwLs0thusFZTUhIC9Eryp8IFXo30sDzZlrMXc/ze//xJX+YzMDD/h/7pfGZyOwpdarRSjPmEPse5B8wuRvDUCIIHR2C77xSCxJAow78aR7PqbhWDsd4EDWETWidu8c9LDcdWGW7axtkzXcatO5MZM5ra2l9aW/XCT0T60JL9L+lVd2+LCGLaOWHszJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
 b=M4QMWhKXOrf7TzMeJscSaKWN93Mqc0a3rsc+X89W+H1dKOTAoTKRYyiQBQDy2UYhJkUB+4ja240P8tFBYF/0Xx2i+/pXnjnckBNaJrtVFZwfFrTpXI71qSrxaMhp3bSqGCz5s1ZoCHcbQzLgFwsQraNmenT4wpANswEIzl6aaWnAcll7wgSjaj8VELmzHgjItmIMJcYPsa8TvSwn7YJrrhBh5l6ryaiQSuPPAbY/lvAeZ9BS6HwvnESBWQVtfzxZutZxeLvr14NDh/Qjn2VwqEAcVBIzAbL+p85+k/A/fBEdQR7hE7V4XgHx2AJvpCTi30nEDkRutC2lg6mQEUnNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
 b=bIQFshSIfF1WKL6lcJkELCDtelxzDHFYg09pVCoHTWn4paqBOe80AFPhcX6rLNczIOBrqm6XGhTxr32Uy3LpuW6WUVF/Msxgys77loDlKvPui6JMJMI+8GGJDD87M/TOzMaHrEZKFAduO/xu5upHkBOrLgzOIL5odxr8VKW0Vaf2cc5gb+WkoYFME9FTneIEhwRCNMwbU8ht0aRHqhHYlgOYRM8N7IZZ9BYWphcbjTnGJ5M+wSBf5iKrWmdVZcc0Qhs6eH/E0wdKji5PFAbdH+rIHu8V1E9k1nOStmZ0A428jUzHUOnqdjZVPyvS1o1s+675OceACK5NghH/Gd3WZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:47:29 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:47:29 +0000
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 01/15] dt-bindings: net: dsa: update the description of 'dsa,member' property
Date: Thu, 30 Apr 2026 10:49:31 +0800
Message-Id: <20260430024945.3413973-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f180e9-b509-4c03-3b14-08dea662d20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g1XhzNaUP6lH5FBKMmrDokFFWNvBvcTWZyn+/qGLmdAI1AIqK1yHoSHu1fK/niPIFcAtW4y/evKAWPaDxEOwgtjvHjnTafKqCE4DuUuRQpUknQ1WMZpI4qm+Ea4C0pzDgI3rxyhXYmpvH6yluhT5PI+/3vOTetu5c2IkhDN7EbJw/7nM+XF3Qa94enUhnjeWbnXkZ1GeYtp3luD1meNg8dNGNM35jd8BlmXYfi5A94ti351M3/PWM5U0MNcvlPXjVoWvY/Glz04nFaMZ48YqWyYsqQdsA5yFzSGUDvhgizsv3BzTuRfUn2rSbeRUdl8qiiNPz6VRTyN3H/AR3vZEGmNS/jvoNtGJvsUHBLjqDotYEXwGh1c+Q8Rjkw3a1LLB/YTPoFgqTKyGrA3sUz9qxU2q98CjnMq3yWA3cgfRP8MiT9sLKpjzWGzPqz6gW539LRusnF52Uw1EfYRGXATysO9gyCs4vnYGTOExMr62IJ/JJsxODUe5puNxIFYdia6Snc+M2qsQRZBLylctsUlXE0gw+lFKXY2P+YkWznDL5oEih2SSUtmc5SlqOgSzz/2BX5FtZIuEuTPnFs3A/Sk7sKxiQ8bU0eBG5U2LZiwlhIoBXhaKvlKkB9aoF5AEG9O+nHexbeqSHklaI69EqEOu61tFJFukaQWWvvvvwb2kc8b5CzYbSqRaOE9Bu1av++CwgLXC0DSTGmmbIyq+ogTggr9/76dwkCeM6AkZBNnbqyQ1mfW9QX0e+wKb+uPQ+sgOm5a0hJY39AtR4JdO8uuRFyI2dmG21sMEChSuWPDEdNsSV6LEmP3ABQzFFLlnztXg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?trhzImNGPHuy+OzbLtXGctgGWlz5eGtFIkWZHVKxuw2wf4Uwr1vSOG9Pjc5J?=
 =?us-ascii?Q?hiomogGt5FXeSEyI78eeMrSjxGP7jgHJMdAQPtSeYU4THs4YepioeW4CevcZ?=
 =?us-ascii?Q?Cjj9xwRKzBi+yJo2SS886ruZdn/4C8ShTxDmuPTaYLVbTu91orCZUv4LyPz7?=
 =?us-ascii?Q?qTZqjbd9o5T/ERhKposoICiGqPm57TL46vKnWYLLlriCbIMF5exTcPaFTbZk?=
 =?us-ascii?Q?hTCHBHE3uOqT7JOqsXeqSC7CH/30UNFSN8cKfzu41qNrKjnrjKb0LswNITiv?=
 =?us-ascii?Q?H85J5XkuN+iKapp0bBXDiisqCvgLUz8idB0u5OlkpS8IpDji8K5WfqfvaizK?=
 =?us-ascii?Q?8OZMW//IvYGOXAaEEBngODJ+voZ3NAHR9G2rmBTlNxo91TwxJb+K6N9hZPzZ?=
 =?us-ascii?Q?f4AVzYcQ9nQVE+LEz8M7aYha0AgK+XFxRzKVFsmZXKuFy42xe8SkG5NhisOZ?=
 =?us-ascii?Q?mg7nvwb2UhM/CSGBTjp3lkWoAHjW6VFJspUbw6ZtDNH6x+Nd+4ZxG7+f9Vqq?=
 =?us-ascii?Q?sBB1Xa7B48IpvbGndb79PlJLbeChK4YFCrjlGiXbTel97b58xiw1+h7aGRef?=
 =?us-ascii?Q?pLOk7N4SVy9ve885Lt8AHwv+4ZIA37P+q2srPLGLx2+gqLVZ1mQ0TR1i6Ve9?=
 =?us-ascii?Q?GXnHYJSL/+Jaj3Efs6+CmId17N50Kqtn3xXC21fcordJ74qvMhfvWYS/YNjV?=
 =?us-ascii?Q?YHHlwwO8KNa9V1iPbUbIHnN90KBcsocw/jQwtgbugY5XoSbGsq5LPRijH1hd?=
 =?us-ascii?Q?52gY7mTozhbtfj1ATmKjn5adVs6xS79g02OQuZDtNnCCZeH4ToMkEN0/6hiU?=
 =?us-ascii?Q?1TqOceXZh9DcB7Zfgz0JgJ4O3x2QMuTeATtvr62lpK4s01KW521hT5vUkC+t?=
 =?us-ascii?Q?40ID7aJ+oEj5Ukxo4DTvvA9WasdQskAmg3+gf61GIAdBt7b5xWN6hLxVPpbs?=
 =?us-ascii?Q?plXGwqL2y9AwI/aIgPK65PtbkBbCJhoQizdasL+8HJ6UPnLly5colE+mZU80?=
 =?us-ascii?Q?h9ipWnaPrN77s6wem9VNwQ1suTE0aKLwoDZ7x+BbXUxoM2aZGlIWqCMz1LnR?=
 =?us-ascii?Q?x7FG8KoSipXPtAvGCB8V9lNDQ5/ChWY1P67YDHILLbwaxFFKWF02w0Dn2kaD?=
 =?us-ascii?Q?o99vRpx86UoMjyx1xuzesWZOtEAlp1c/LDhhXwBh5YsFOE9z9SHIduekLYGF?=
 =?us-ascii?Q?2nBdLd0NxgbvDJhyQtQCPlCCFydPUiuTO3ZkONvVvg9sRAMc78+vi67jRSpZ?=
 =?us-ascii?Q?ny0ki3OLCQGl4ezgeaG3JWXfun8A4wTxBAM8YQS5OycmIvb5ON4w6FLGQbSJ?=
 =?us-ascii?Q?JaTWVExmQQS5whiLqW9w4VJ7XtS7XRiwNXcqrPmPpZTz8Ieftqmtz4oDRTin?=
 =?us-ascii?Q?1tc/OxnFYw7VfN3AdxwlJa5YVlT/feGSOngyKJn610T4LA/TUuDvwLRkB8FE?=
 =?us-ascii?Q?0EsvE/wiyC/sKMhMSHM/btkk5sA0cm2EUM5IFFeUeEgzLH6ruvFtc5isVNXD?=
 =?us-ascii?Q?VOwtRJGOl/UBQ1VSrSJZg6VUcz+qVXzhky02471ThYL9btn1BNFH49iXC9NM?=
 =?us-ascii?Q?LCdS1pSB7dSPH0W9GSQw92YcsfwyibDfV11DT+ZubSKeIbz4HrgocLD+WCOG?=
 =?us-ascii?Q?aVsBZlV3gVqG5yd10NcJaidJVtb09SviAQKuzEB+HGzgE3KZc0BpFBUmikUx?=
 =?us-ascii?Q?SJDm1wGiogW2OrQTsiubJnVTiK41YzQ1HyygnhWJD1n9H91iZ1xnGnjAnqHg?=
 =?us-ascii?Q?jCLh2YGFTQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f180e9-b509-4c03-3b14-08dea662d20d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:47:29.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Vv1BEu6LxHBE1xroSWfBsiq9ClSKy1xgjSRPb4HYx2SGzIsiuv/ZiE0phZfjtrQl5Z3yVGBv1cikq1JlKvFLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

The current description indicates that the 'dsa,member' property cannot
be set for a switch that is not part of any cluster. Vladimir thinks
that this is a case where the actual technical limitation was poorly
transposed into words when this restriction was first documented, in
commit 8c5ad1d6179d ("net: dsa: Document new binding").

The true technical limitation is that many DSA tagging protocols are
topology-unaware, and always call dsa_conduit_find_user() with a
switch_id of 0. Specifying a custom "dsa,member" property with a
non-zero switch_id would break them.

Therefore, for topology-aware switches, it is fine to specify this
property for them, even if they are not part of any cluster. Our NETC
switch is a good example which is topology-aware, the switch_id is
carried in the switch tag, but the switch_id 0 is reserved for VEPA
switch and cannot be used, so we need to use this property to assign
a non-zero switch_id for it.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 2abd036578d1..801e1411e5c2 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -28,7 +28,11 @@ properties:
       A two element list indicates which DSA cluster, and position within the
       cluster a switch takes. <0 0> is cluster 0, switch 0. <0 1> is cluster 0,
       switch 1. <1 0> is cluster 1, switch 0. A switch not part of any cluster
-      (single device hanging off a CPU port) must not specify this property
+      (single device hanging off a CPU port) does not usually need to specify
+      this property, and then it becomes cluster 0, switch 0. For a topology
+      aware switch, its switch index can be specified through this property,
+      even if it is not part of any cluster. Also, topology-unaware switches
+      must always be defined as index 0 of their cluster.
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
 additionalProperties: true
-- 
2.34.1


