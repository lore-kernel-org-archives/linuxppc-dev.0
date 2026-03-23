Return-Path: <linuxppc-dev+bounces-18570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F4ED58CDD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:06:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN3L26h2z2ygT;
	Mon, 23 Mar 2026 17:06:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774245998;
	cv=pass; b=Q1BWfD5743em+Gi68XThgnk0TpkCeCHZe9ip+tNqAkHfXJwlAEMD+G/6NhSJLA4BUyRUbtO8HD/r8CIKkDVUXA/mKuB86kxgJ5Hb2CL+ITpLB3iVPwBslXvAuG5OurrzuRbA66IwgeOOFVd8kcNT0aLS17L0bfCIISmYnrwTlzOhAX/0GwvfvdAH+aAWynq23CSGVWZEkptwB7C3B8IxFbr/BdeYKPTLP16QWvDLDBPkolw9b2fOoPt/8tSQYmYkTE5RLDOVh46OADvFfAi/JzdmHf3TXCt2rPDyrHzp6m8QbyA3/7JqPX7n8eQecEDAJ2k+qhuiXCq424IEiIretg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774245998; c=relaxed/relaxed;
	bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ARCdBpO28wkCk6GlPDoVCGWAE9hGwrCbbShLdhPhN1n+Kg4hvssZZDAhPu+iTyH4N58AL0MU6YfEyaCBea7qw2jqt5/CB0TVgzkkruH7EtjuUhauTwRk6qOhUaIYnfzusY5UI4lZj6t8gSRZWW3mv82BxNXJ1juNJ8ZobEHVOpzTRMZLCxbOXL9aP3zJsvGzBn0PbCIyI0snIPhwatx+klrJILYlZZJUxGXbSKOvG4HXOgQZCKyljd9K3BWf6mxN46zzSdiAwnkNQ2pDS6IrnpfTILDTZ9q488utSXKVgU0UGlM59Zt4pFP/Ya/dfGP3TcVwEjbqv9dTef5Ehoc2fQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SQJWgJEW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SQJWgJEW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN3K3GNrz2yYy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:06:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh0/Dlk2BbmMJaMrJfeD7qD18n1ol42fGVPLJoCoIcjLUa/Mo2zZ6ur4vQC3lx6XqZ76ecNltDzGtI7TxiInukuNv8higiz1mPav60MU0u0dXHY4gef/qw3GSIsLegMioXGSMZIJGwkXEtGCZyQGg5xvk0i+eM2+mhcn6jTaXj0v7WwG//VgasSD+cIeLLnTezfkdYBOzhPQAa+Au2N+bXwhNFe/B9UZbi2mr7xNRbkKlRWF0ilDQbrsfLMOBWAMk+czuWsgzrtoRYDcv6VXeG4iSWIEwrpq07q1VYMxqBaZRuAGatoRh+NVrnOQZih9GLrTmdSa0zFV599eDCRx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
 b=y2q3PZlQXilHQ4bRqm5spUtnYVk4ZDdsvYnAALcnA0yfAu8/VzW5TebFyPrL+FLQrYzUeUZOacSQ1CiY+JaNveuEMyzEDNDAWGVi4f7/ZGAA1OP4+wGfZTSHIUc5C/Ny0LHwGiW8M+lFVdE1rpTAdm5zhAuEIOafoN+25fAFYHEIRw0dfkpoRMRkj2oKJjckubQKKXvXUOXC7jzSrNr7YT3VMkX+XdCMYb3VpQBTkg6yLcpaSpH5QokNqNNbUy7+Q0CKdmoYApLIut3vb3jKAzdv9ts76uTNX6uZgRQryEURhueE66VjG2NvV8hGsW70X+BMaDgQ3/kqvBNjsIJWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
 b=SQJWgJEWIFeNtlqZv1e6lJVicYBPo3191O0m14OrwqM+dRHsQGAnG8geoZd1z19Pza2oIBcH81LiNQO04q5R2PfN4IIf9/jD4jG3LzWFH0iZQgjJcAjYjryIwqyL2WhSLk6UGyFPgkS9CHI+io6+PUQ75qQ98mneht5GXWoot24GY+X52gbBG0xW8CmkSswLx0Zm3uAD+A95dkTeivkK+uJhOkORxPJXZahx1CIodOGorTmKklZtJJ9jh0u6Ae+91CTd3XyXmMWCd+OaXRs5koKra1oMOqqPfHXjL7ubkC47/PD5NRi0NbmFA4z7xgrOHjXAc1DUXtA4O8d05YrleA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:05:43 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:06:07 +0000
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
Subject: [PATCH v2 net-next 01/14] dt-bindings: net: dsa: update the description of 'dsa,member' property
Date: Mon, 23 Mar 2026 14:07:39 +0800
Message-Id: <20260323060752.1157031-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5eb4be-9971-4907-a97f-08de88a245ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	55lKk53sTyOnh8ttq4uaxwD4KzQknE6oYdUtCSlAwlBEzoCeqh+Gn+26qKzvT6thI/unZin/glFx7ZkO4ASRpWOG1td3XNsfXUc4ghMPWXjCSL9UWbN9cIenZGRXtJY59ttKGUHkAtxvOhRculdNLWygga9EAzFEk1bBb/xFY3EubRoOc/OhTnR/qpjeKJUgO5lCJsNM6qX0TUfbXt7X9WeDXVWpzasoXW7QjEFRTzu876TrHx8cZFlPHNIDsnx3iDlldcU69aaV3OGXJUFSjoYapgiTcPp63futTKt0XqPFnGsyFw8QIOUi2Y9yXOuKQsJ9XZyGt/ni5dW9JPBsryeppJaWTopb+QP+oUwDh3jwp4rSNZbRjz/PH8sUnHyepxe4wYKNsKBzoOkus6TsRjPW+KkYF10lqB93Xr0bzVCmJlaEjcf9wEZqXqkGuNn1NWTrVHNEqn9cY9chLQjPakFdL00Kwj8VAlw29EZIZ7R4C4THJ+vZU7/CY7M11P4+EGT+ddbLxWORZcactx3VUHOHsYUaQZcB78EGMhkceJofH3ymQojAFS5+6ZGnB6YEUkxLo/LSozHeYPAFT9F5yYZEqx0Mqhs2WAU6TzvuEf0vjO6vOD8YF34+pIj3iVo5usMc+YODrlbIsgmHYdSCk2PdwL8ABETXku068rb2bUntoshoysTMJR6+4e58/UoDElTKeFHUwaQ5mMeNpRRLmEh17mfw5Eus1bN7vtetIvbxmvQP32dr32Vg4Ev2sGuizCAg9R1r7g7QV9Ry3R6ESfnFlAI8DZsyXVBkDwmJmYgaNLIG7OcyOU6imfrhv9f2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r4FI6X5ZPF4SYTL/9PKjwHYLhN0h/wKyllch/v08bkNGduYG3fpuuQEZmvMc?=
 =?us-ascii?Q?x5vKOEnLCcmvbEVolyMt0PyZKJFiFAZfeX+QiXtLGDQS6gHn6+ewTcLawLM9?=
 =?us-ascii?Q?vdzqR4wHsjCsXNFP+QjexaVxJ/phhcFqwacPYXEkKSRUmvhb0Jr3DRVuzoPr?=
 =?us-ascii?Q?avREESM8Ft7MHQZ9+k3EFDm+cFdi0MPlPoXlkf45F/5Ni0Wq0uIRZZtnVtGK?=
 =?us-ascii?Q?5KzfD/dzUGJBb+yTiLRYF8KLOglb8P2YVqn/f6mlg0KyOGB6iwVVrwg/awqc?=
 =?us-ascii?Q?Aj6/UKhoSukQDeiN+ZUBRm4IXH4uFrxgkno0FVzkkSJpodtFfx8a6YU11s2G?=
 =?us-ascii?Q?w/aZG0BN2AG2J9vUAc0bhcLPKVrY9PUfoQBfogtxMJK9+JuitQLH8g5ugaeY?=
 =?us-ascii?Q?louYLPT/V21wifvouWG8ZcwHpKY81zo0BnSUWT9nd/vFVQdj9z+nV5NTYyai?=
 =?us-ascii?Q?KHTZN5yg/+aIwxLd8r2OvE/ssmtN1+MKzMffUgGfFF2V2MI5cq7TxdAloHoQ?=
 =?us-ascii?Q?F9nEuJM5w2xlrNrzIbOrrc2bKrPmg/HD899o3XNVYr/sLPFT2jkZbdR+uE3R?=
 =?us-ascii?Q?j16kNxmgD2LHgZwyg0TjgSYIukkXNhrLSlFAfA1nycmi8bKWo6q+KYD0fm6v?=
 =?us-ascii?Q?yoWKp9PUwuS0nb0fY5RSOdRkKm1LdeBalkS1tYOdWJOWku9bR43K+N7Z4RM7?=
 =?us-ascii?Q?cWPzmoM8/06+bAQ3qagWSsGZZHOvJCrj5d7Q62XUgp50CMDSog2lUfXGJlx5?=
 =?us-ascii?Q?U4BUAGOBaivSk0BwkNOkkDnPPSE2+0vZMkksOu5bxlK5BFHI2AycPTC0hy3e?=
 =?us-ascii?Q?iz/Y/KBuxtWIm3Qwg8vR4HLR3EoK0V0v4wUYxqmTDoelu1u0laWkfJasdzt2?=
 =?us-ascii?Q?RXWT1HmkOc166iUcybwm/i5QSvfN7omvqbFutImLPOvpuluuumpR7P7h+TRg?=
 =?us-ascii?Q?GHZJR4Zp+hbLRV0wtuWizcY4P7azKlkDmzqg4FvoYSsEmlir2UxHgWMeElXq?=
 =?us-ascii?Q?uyqyX30bIrWGKMvKcojT7+KuMOY65A8TXvExPXEoGQq5nXeyr2SqNL33QouO?=
 =?us-ascii?Q?wDcH78JJvuI4YcfIk2uCT8Kpm/rXaeuy/zVG8M27mBPiu20RT/nTfEWpGSOC?=
 =?us-ascii?Q?09wc9kWM5/zGz+Q9aTzKt/p33RDpKATryJqBc5nNCInVIrdp3VvxQMi7JA3q?=
 =?us-ascii?Q?Ipy3gU539ki6iLnz0WFjxPdCxDOqB9gr/yB0BPym4Qysx3IEevobvoWwXzZX?=
 =?us-ascii?Q?+CNrl4S5XPBUa5/iXEIdCrb3YjPkXAZ0DvS18FOPxDo2wmzTLTNossSh7c8d?=
 =?us-ascii?Q?KofaglLx+HdTHtIXte1nm9UcINHTfxbqekip4F1uY8deT5aiZ0Xu0VC5buWV?=
 =?us-ascii?Q?emnN2t2oF1LPW6+UFG4CQXCCFHTFWXGHl7U4xvXOlu0Qv26mK9B0yYvx5d8O?=
 =?us-ascii?Q?7mcHe57d1su74L+r7V+MhNEejYnfGj82mXXhBMdZ1xD2xc5uzzu8ez2JVdQv?=
 =?us-ascii?Q?KbftG4EjjsVpE1UbqVnhSxy1gBztuQCcb1z3RZe/tcJvDEtwlpsuDVSO5Vac?=
 =?us-ascii?Q?o1HziawrN+Vq/PYXIfa+00+5iLiwP4K++CD9DMXR+Vs9RXKvqRTLnSPnmf+y?=
 =?us-ascii?Q?uWN4eIowmUun300oFM+eJKizEFambVmQmeVS3URCa0wy9aw0FTt//EP8BjVh?=
 =?us-ascii?Q?TFdZGSFOi4Y6chxAEpSGFt9jaeAMHs6hKX35F5vh0LhLziVJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5eb4be-9971-4907-a97f-08de88a245ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:06:07.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpyDyHKEqiHTraQ/I0TQoOuD1CyhKShYCrmgbs+nwiqvTs2vUtk5h2Tg1nK7T5HrXI1ig5s+AR1IxPRj+wQeCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

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


