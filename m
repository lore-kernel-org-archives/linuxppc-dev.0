Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA80606A32E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lCCe/zC0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS4q16Q6Sz2xGr;
	Sun, 15 Nov 2026 20:06:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794733565;
	cv=pass; b=YdVaY3MV27ssFyvW1Vr3BJiFZlwlQ2eRJuGhQctSGZKCwTrcXof9ivbxLUxLOm9mhejmuTyHMtty0u4tzPdT8Nvx4Q0XOFSuxXreev+7pJZ2tveIrFx1AyQcbjxXzhY2Y8JocLpHhviDfqOEQ/9Rz3rsC/uWogpqhZM6nLtCg/ggVK2g0ycg3FQvwihrUb97PZZVYOXi+OYROiDqMpwSuR+7RkRok6pN1Yj7FnVI8EuL55QUe8vixUvb1RaZv2qNrUZiJT8yNzhMvjRB9Ft5HTrAsORnlXN+47ct9SoORWC/aaiqWfdgkAmDgj+yjrOyVt03skZth33IQ8g1YhK8yQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794733565; c=relaxed/relaxed;
	bh=07WOKYUWzc5l6SRYMycvBjujniheSXKsXpF0DlJErRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V2JCg+KSURke4zsqhYHgT3qqzz3cwFb7J12J/yzoPPdw39asOczUcFWNv4sz8e2qUb8WuXegQZBL3cUuTFItzESa6pjD+uru+4ngKPAmvGLsJEq+S8jSnAHq8QdtaTIaOzF96+vL+36b39yPLJljCeK6Eghq8QLt7VPgPpISD4jeLp5AF/x94MaSwWFzCagLcRUOV8UF97v2wLYeM7rn6COpd+yXqY5hwW8iJqOfLvkvWQtAuxy7vRuXNP8Qq8XnWmGuOqvCKDF+pndsDN/Y0MQf20K5J7yFl7I5jQYDfc0jJTvKHerCD0ONkLlbDIBhjpm1w8UXR8avd4fzLxbfAg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lCCe/zC0; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lCCe/zC0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS4q02TXxz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 20:06:03 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI2ML/2GV+lsbfV8Il5uJCijrPpZn1O1Xxg+i30MqcAQLIwltSuDjskSeMGEfBaDDZLkAlBgkNSXIDr3qRlTa7hFfc1qTbZTDAGw/EJFNwvgnhW/zGq1fv1+xOaJhlScxSxhAbgzAs14jPJfw2ZchJoHg9Wfom9TOgM0lERWF23Yb/Fx9tI1PR5EPIwKYtRTtgbJEul1j32j5OEAzU6elrPY4VRPMnMsypbe4n42JtgG9bZff9ZP/oKXZDjKjm73NUEwav3xqZRsTETxwe3rVsgBv7jYCMtPP74EiKtM7jFEfWLIHr8X9iI5r15NuSXMFzsidkF9TrpaGqZLYP07jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07WOKYUWzc5l6SRYMycvBjujniheSXKsXpF0DlJErRc=;
 b=tbKVMtGv/v7ch2cOBriH3FIjtEcwi3ghPqDTfY874ikt7TU8QCCaKux+Ceos9bcI7lvUEY25Kyea87UBHi1EmPmLtf8jhY6jZ+XKJxSeffsWfe5E0xa5/QFEqwm9vNcV6e8xF/cBblPI+M131JMsuC1XZ2fQFAJOllJt9ZWl5XeWav111rjz9ftAEqYj61HbiVfTxMXvOxWFS3yRrKEzwT9B9PwX0ib9w9uNu8IBWkvqyqg9OM1Ox6tY0QR2YAHVO+65pMK0HSelztqU/R4KndzB9C2pbi4ssEr/DXr5c5NPsk/UfOKVD4gDSklEhhSRfxoZvtDYgLRyNQSzPG3VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07WOKYUWzc5l6SRYMycvBjujniheSXKsXpF0DlJErRc=;
 b=lCCe/zC0q8M1BMfQ8wOoowEINuz+BkMGFVYGzzM0YuK5+fPGSQnSk0RV0CdYT2MQSDziVWvZP0SYBESuakn9dsJDCSQ54M447yM9wfQUdRMl/5aq3H1yquek1Y5ju82RMkwYAO8z+0jnQWE4qO2QagRbA6deJD1yyAMtiuwr16sfPglrEDhMxhgAsvGFhixKmWEZiRzAD69hQwdAYYAsTCiDeEawl/uFEw6lU2PgdxhhfTVMTkxvw2envlIdMsrMoR/CHGNe9rMzdcS6zZ/nm+f0KzJ8mig4AbOwFRPfrgVLw1ju3E0o7W3dxJH9JH17RKyIenvDZzplUA2u1r2ONQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB8446.eurprd04.prod.outlook.com (2603:10a6:10:2ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 09:05:40 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 09:05:39 +0000
Date: Sun, 15 Nov 2026 11:05:35 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 4/5] pinctrl: freescale: add the LX2160A RCW pad-mux
 driver
Message-ID: <avjaK3cOj3iQ6G6w@skbuf>
References: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-4-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-4-eefcea066a55@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-4-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-4-eefcea066a55@free.fr>
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: d9758e83-962e-4103-7fb1-08df42f79eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|19092799006|10067099003|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	XDIrN0D2pHLSQxl0uOMAvnEcSTebakSzkQw6nU5frKdmdB31sjmaoDN+EeTEAqwlVIa+/J3vkBvm+ER8IUTMZNoyi2Fi4wUTH6gbv/m2ttTr7FRFB6HcIkV3FpykYC14gzfKHu/X9MY+f824hQqoxauVxSRVp8TBDVw2RI+m1G2PkwUXNgLPox0JLe86+PmXJfJLKo6TkKEYYJ0ohkthwRAYYYYgf9y+0tjI7K14mmQzLcoz9o4j2Mg5M0kbXHMvzvorsBqngVq9qBKqMm6EHVMbIrUhYmwwlz3uiVOs+tDxrvUUhcWE214XyAq9fW+SNozhupGUNRnj3mPG9h32792SB1IOwRPv3mNu5EN1Mm9Uu8V+bwFZKqBkzpdAQWwJzGCXVyRgTaQKcUH3Bt6JmISHtPCMBS7Q6QniowJdkVyIMy945czP+P6ePzI9Qa3X/xiNFQTVZD1qkEy2m+wuJIaZvjETw+XMFFzU0uIAWCQ5fFIfGhgZ8rRi9/1YRO244IiVthCpGxy2bHpAdxtoMs+15HENROQRKWuvUtmPlz6owiEEmL2Gruv7JTDDdG37huS4uuJInjQjQh8Gz2uAsHMgzIbG1guDm+PsZph9x7RiTD5y15oQ57V7A5gpafJ9DIjXaDWYwD7keUiLR6SFEO2bo2sxmcswgUDkrzUyQiZ/fCmPEvEKAdiLR4AtPvoXalqqnjuZxqRGzJGGgDE0btlOCpN63b/+dygoj75HN3VIYuPH0IKfZSzsyYgF/Ihd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(19092799006)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?so3WQjPWcmwII292CZo/EAYB4KR6dIV+MfPdNQfY/WnvR/cVKRpQrRwhPLiM?=
 =?us-ascii?Q?SpTvmt6IBHCdsoY3IXZ3EUWsyrPcaGHZMzEars3hzMBVFt3JurM2uqqjBo0s?=
 =?us-ascii?Q?1CwPUsaWPTVjoBSnqvABoQVroT5DHwXwvlTtQMXNJXjcSY3ftI3RKFIV/8nC?=
 =?us-ascii?Q?BLOhJ7Sbq4Qm5eCdGWQ5Ui6GzJyIYl04sqmZrJLxzCYXYZWqXRTCNq+6evUX?=
 =?us-ascii?Q?SrkDZrv5WmLgX32Fnh4iHfCmgy4OcgYXqoDtoOJrvqZdZSCgnp4oswNFAjos?=
 =?us-ascii?Q?at0DAzz5ow2gyvAaXem0SeqvfBKRJC/FoBpXeKYfhbcDmKmsNfpTAKvbjmA8?=
 =?us-ascii?Q?oYfp922qLZeWBNOjFUUlL2p5jrTMkpDdEJfk90iYsL7bvwigudsUzPwFXNPG?=
 =?us-ascii?Q?9DQLlmcrb/OMmTY5BDUyrSudiBTq1dNhaCygXtBcizKNMTfkpzB/MrCowmle?=
 =?us-ascii?Q?HDGweRqr7/gWr/pzvHnzn2cwAOcToFoOq3L/hy7OvSskAnJhj2HEweIvXXey?=
 =?us-ascii?Q?vEcg8buzF3LSrxqWxdxnsSiSmjVbjkmF3rr5TrOaQXgB7SE934arl2ZklQXu?=
 =?us-ascii?Q?fyjhZcXWmTuZzCm7h9fXkjKY1SnnZWreBk6RVYQu0N+alx/fZnwYNsVrFqiQ?=
 =?us-ascii?Q?EXSP2mDMU8C0mjagT80BHNAPuPSp1FUGUyvLoht5EDMhrZ+c6YBLONQv8wbl?=
 =?us-ascii?Q?uosrXYHfKTsOKxNlV24ghQJBSaCOd0pox9/x4w2ZRO2u5rtINKGgPHLW8tOC?=
 =?us-ascii?Q?GzCx6DE5PfGRdpy77yJa4ilDPsfcLuwM4JY3yfdW8ooHKjownFUPN5x0WsJH?=
 =?us-ascii?Q?6auuoUnAQ959MJVsLJsqMXTLprF82ADTr1/ugETrMBz3JgPIt/gZCnCbLbA0?=
 =?us-ascii?Q?ZEIiYz/os4H7mgLyWDVE0CG+bZHp11M+CxJz6qe5LpgsklaQsHgxX4Hku05q?=
 =?us-ascii?Q?GYQzjtzT2GUWHF/QJgworp9TbxiXQXvxLP7OfTdHlcgcuaRjickrp254+P+h?=
 =?us-ascii?Q?/R8iK3UUD08Wr46gwAMp1d6+GZX9THJMG8vGqEKadEOR0sRNF91tqvxYa3wz?=
 =?us-ascii?Q?u7Yn1058HyCAwSYKHXREqHcNCBkuZUg2UPIurizgjKJ1BcpIJtRMExWOxxcI?=
 =?us-ascii?Q?AEB5caV1AY1QZvkxIa6I1upXmKhybcqyv7EXGpaLQhlsJK2kuHhkq9Rwcrr7?=
 =?us-ascii?Q?QA1tp7O1ZMPg1JvXFcDvynZCf2OYmSJmJFyOsH49h56b0VNjGaQ0SAyc6Fqn?=
 =?us-ascii?Q?mwNuDFYAGpO+DWVDQOOf0iTCynNOYt3wkvwM0e2d2x8pCBc60K7epEkPELYh?=
 =?us-ascii?Q?ogv6sjk6UzifN+yYPbtHjtKIhBYLFpzpjFiw5+AQwr7sLI0nWhkBGJFbtw71?=
 =?us-ascii?Q?hRJ54y1tS+38RVT2l6laA5/T59co/e0fOQQVDLoOo/XKK8enmTksGlsSlh8U?=
 =?us-ascii?Q?tj/K/y9N2UyGB/0AU3w45xQ6sTFjHgyCZoTDhygj/FyoWl5aHGvKi0hjfvM7?=
 =?us-ascii?Q?95LxlbAVREtZFK6QIePaZ2C4QpMJzgC0mGoxmnRUm6Gr3nrxyBiMEbNfQHFG?=
 =?us-ascii?Q?/wL/3mAoTS0XdM9kZB0gzV/M5XpBs+tvBWIeiRNPBShmrETaiotvPSlJeB72?=
 =?us-ascii?Q?bFDWClbuUvojJUsKhW5yJnUUBrf9WDEIUlcvy7oSlaFKyCxVeRbSo1ykwpEj?=
 =?us-ascii?Q?Bvllys0v69dsfdP5ermvYhfEx9Dyg8Cm+/YaM4fg4xvf0yJiZk7lV4grJL2j?=
 =?us-ascii?Q?bHZ0aad4vti1kJvOlR60zTJnyisgWjj62tAbFP+rIWwBrBr9HZZBlB+GxHHE?=
X-MS-Exchange-AntiSpam-MessageData-1: 4nNRGeLfM8jOEei3DzE8y14+Sl6VcY+C06E=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9758e83-962e-4103-7fb1-08df42f79eaa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 09:05:39.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGlyP9vtN1+NGbtW82T+SKSCNl6ea5y7iFcnlAP5DMPNZyfeQHkUNJ5crYFnNnmx2ALU19lqYuDq7MqLUIIRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8446
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 10:12:31AM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> fields of the RCW, read-only in RCWSR12..14 of DCFG and changed at
> runtime through the same fields of the override registers in its DCSR
> view, which read 0 until written.
> 
> Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
> gpio to support bus recovery") Linux drives them with pinctrl-single on
> the override registers, so its first pin state clears every other field
> of the word: a board whose RCW programs a non-zero pad mux loses those
> pads at the first I2C probe.
> 
> Add a driver for the pad mux as a child of the DCFG node: the fields
> of RCWSR12..14 and their encoding.
> Then pin states select them with the generic function and groups
> properties, and every change goes through the RCW override
> of fsl-guts, which reads the status register, writes the override and
> waits for the status register to follow.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  MAINTAINERS                                 |   8 +
>  drivers/pinctrl/freescale/Kconfig           |  15 ++
>  drivers/pinctrl/freescale/Makefile          |   1 +
>  drivers/pinctrl/freescale/pinctrl-lx2160a.c | 368 ++++++++++++++++++++++++++++
>  4 files changed, 392 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065..106a0cc7f25c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20207,6 +20207,14 @@ F:	Documentation/devicetree/bindings/clock/*imx*
>  F:	drivers/clk/imx/
>  F:	include/dt-bindings/clock/*imx*
>  
> +NXP LX2160A RCW PAD-MUX DRIVER
> +M:	Vincent Jardin <vjardin@free.fr>
> +L:	linux-gpio@vger.kernel.org
> +L:	imx@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> +F:	drivers/pinctrl/freescale/pinctrl-lx2160a.c
> +
>  NXP NETC ETHERNET SWITCH DRIVER
>  M:	Wei Fang <wei.fang@nxp.com>
>  R:	Clark Wang <xiaoning.wang@nxp.com>
> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
> index fd53cf5bb843..a3222714c970 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -283,3 +283,18 @@ config PINCTRL_IMXRT1170
>  	select PINCTRL_IMX
>  	help
>  	  Say Y here to enable the imxrt1170 pinctrl driver
> +
> +config PINCTRL_LX2160A
> +	bool "NXP LX2160A RCW pad-mux driver"
> +	depends on OF
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +	default ARCH_LAYERSCAPE
> +	select FSL_GUTS
> +	select GENERIC_PINCTRL_GROUPS
> +	select GENERIC_PINMUX_FUNCTIONS
> +	select GENERIC_PINCONF
> +	help
> +	  Say Y here to mux the IIC, XSPI, SDHC, UART, IRQ and EVT pads of the
> +	  LX2160A at runtime. The pads are muxed by fields of the RCW:
> +	  the driver changes it in the DCSR view of the DCFG that fsl-guts
> +	  drives, and is what the I2C bus recovery of the LX2160A needs.

I'm sorry if this was discussed before, but did you consider targeting a
wider range of Layerscape SoCs with this driver? It's pretty generic
apart from the pinmux functions and groups, which are all data, not code.

For example LS1028A, which is part of the same chassis 3.2 as LX2160A,
has a pretty similar pinmux group layout (subset of LX2160A except for
SoC-specific pinmuxing in RCWSR27). The functions are a superset of
LX2160A though (for example IIC3_PMUX and IIC4_PMUX can also take the
values of 3 and 4).

The older chassis have a dissimilar layout to LX2160A/LS1028A, but
similar among themselves (they have a two-level I2C_EXT + I2C_BASE
system), and their core mechanism remains through the same RCW override
API.

I'm not saying to add driver support for those other platforms, but to
have them in mind and to leave some space so that they could be added to
the same driver without having to rename it and most of the code.

