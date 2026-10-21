Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DF606A322
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TVTSRt29
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8tCX3KJFz2xjv;
	Thu, 22 Oct 2026 02:16:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792595768;
	cv=pass; b=Lfhh5imAKLGMWOog9qqo7VWXHJsJwpXl0LzwyX96tzt0tmLvAKemFS+bzmgkhAmiGoX/iIkYLob0UiHcRqq3Esj2107penLGXZvzmxExlpcDFcMYtmiuaRroMrewrL5TnAWXidYxSphIGcM/LejcE1du2Z/oWW5M507+BPz7sCsetwmINhoUfDldJ6rqAzweW7n1Bjr+tB3C1L4Mi5IoogAlhlQKibx7BoQEFOiXzbHqLb8rZcS5NnB8CUMBH7I0QS78F2xsX0yMLJOilo3WHpQ5n2eZ8UST9XsxJ81d+CJh9Dj6r067i9dNP036k111UydaN37C6gnJVn590YvVzg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792595768; c=relaxed/relaxed;
	bh=AjeERqTMtTFCemJF8aYOEDp+NdgQGo5LMi0YqasZ8DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gwTOAovTIR8EtBFEGLR2orvSO7VH8OJJTDKR/Qpkt55rtECWFzs3wRGz354F0epbMzuwpD6GV2gVy2x3twG5JoTuD96pTNheGhHoweq8jqAelvV5qdtGWZv4HY3sLYnMKiKwuoYsc6bogne0HdPnma8Nh5ORdWCsnUCYYoHEGl/dkqUvcURSbYMfEKh+So7UVEsTkttVsqiuD8PQA3LFlKnrw6KJ8I1vP7Kmv6cd/r78k9eg2f3fsvHKoFo2+q0RIE9X1+zq85H1UugAZYmDOr4sZMiC6wRMLeK5oGz86e7OOx0rCIhYbsPIFxfmEUQ6aOlDbZsIecFSCrsc/rZiTw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TVTSRt29; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TVTSRt29;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8tCV4VyNz2xfj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 02:16:06 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpl/KOPak2Lfb8qG1C0YPTxqctMCVpOTtJlze4MwQ+dDOXsA7eNAv/0QBMjtIz9vfEKLt+UM/TvIEGn86Z6hAvO9RsyzPBqqZ9A6/jp+Yu1EAlsiohI9+AZKIy3JM04HzqMzEoFVPp8ayfvw3CM97x3Oj/XB90ygbfc9+KoMuLYDCFykb7n7a1YnOqqd+bB4iY324m4XY0ijhJvJmGfSeIVNeGhCT4Hy/TyFdutPRjqkkky6a0amMP4N7dtd309qWlijpzm0OuYP4Xp8ZD1sBrqtsQV0fjecF8HQuAkUwupx+7j6jrqqRm+SsHT0nkWpVdixWl0MZ9cDeDknp1E31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjeERqTMtTFCemJF8aYOEDp+NdgQGo5LMi0YqasZ8DU=;
 b=ZM++6YtnsDEjdj3PFb217JZvSp0u/i1brz34pdYXGem8r/hyTjgB4iR0phpPZyWVbhMJs/vF0bgU+LkZHlM+8ju2BAL4mNTB5t/UnBbYqRAF/vn2DdjuSqQtuaBzf4l68nbTQZ8higf8eygXuVjMHFStFWVcIaHorN6EGvrkwa8hc9CBdo3GvADxegEkeBDej4r5eEtWkWU80ZjN+FKn+BilaFCpZTeJ1o5Od3wKnDL/KUYy3qUuVPtQUm9/o3hwpxthnMuNKbkLzkZYhNvppxhDjLY0L2/ulPC2z470qzCsTgoh9sVxKHe3FXhYT4TQ9nsqZrQm+FZZ5WyXM5yyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjeERqTMtTFCemJF8aYOEDp+NdgQGo5LMi0YqasZ8DU=;
 b=TVTSRt29lXiD0sHZTzy3QcpsDXnfmVd8eRg1XNz941N8k7s2fUg9COIIQ9nT0k4HvtuFt0DT/oDnAJzfMYoC5ky8stvWyAweXGFxyrHFmUUA+udB7glt7q+RkxsCiMFltZ0aYXhrIZLLJ57aV53wM3fH21ppFpJP4nlBs9hQ3eriVlHbVER28e5tB+/ChvjoUS1ym5mAXp3Xv47S03jvNx32HRDhUK3mo2ycmrG9PHx4IYeHnr5h6Ja3rv9jrguHwIb6C26kTd6Zyk0xE/0Bf2cPyno+TwV1VVo3uInfWKRk84oy5eHccsK+YSATWyXoe5Pr2sDPRIqw102ZDcD2MA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MA6PR04MB066831.eurprd04.prod.outlook.com (2603:10a6:250:56::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:15:40 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:15:38 +0000
Date: Wed, 21 Oct 2026 18:15:34 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Marek Vasut <marex@nabladev.com>, 
	"Frank Li (OSS)" <frank.li@oss.nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Frank Li <frank.li@nxp.com>, Jakub Kicinski <kuba@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Message-ID: <ucqfjqsvvnxp7csa53lsbtxxeti4n53wdrybzuemargqkt556y@amr6rfv5oq4f>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com>
 <atKDNdxl0w65s8yQ@SMW015318>
 <DB9PR04MB933217F7ADCB6223A44DACA7889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
 <661412ff-3942-4d1c-be6f-1ef6c54620fd@nabladev.com>
 <AS4PR04MB933821150913BDCF35C4827F88982@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <fe920b05-6d89-4dc1-83d3-0664fbc2e00c@nabladev.com>
 <AS4PR04MB93389CB9849950CFD78411DE88672@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR04MB93389CB9849950CFD78411DE88672@AS4PR04MB9338.eurprd04.prod.outlook.com>
X-ClientProxiedBy: AS4P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::7) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MA6PR04MB066831:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcd3e3c-7427-4f40-9a43-08df2f8629c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|19092799006|376014|1800799024|366016|6133799003|18002099003|22082099003|4143699003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kd64XkLt2PjbuJF+EItCjaaD38obEnIsDl71xCKC+D4aAdUZBv5+v3HEfCMk5z7S/ySmGgsdODOjvQTzPWHN2fhjwe6VSLUCn30BYwImF1KjhEm3cOYIruj/fdkEVfHYZhl56xBJWz0uGkNFCw9jOLmWV8xbWp5KOKEfCksg3ad4ACclXzKU51isMOxsORcHW7s68WJ5j+oL1TweDEmJoENi5MI6KXQKu6VfVg4VUKp3afk2m68Th4q9EpbFncDPqL8ME9XHtwvVnoGnWcYWi7xxjOMEA1cy9Fze0aWpd15tkOCJTreKsNgVpWvyczwobwTcRquG/pqwRusS/ZKKcfQLtTtPTlAmDmbbKo4dBJ+Nh2fXusui0yN8BUVSGa+m/pWXRkeUAOeh413Y2LiJhT8nxB7uPuC/0R1Gy+C71s6/ysszaqo4hkEjZpnnML8llmemAVDng/xfIqJVOJFU1+jZoipaxyN7JAYoDG9POs+bI3oAgUSGOGaSDqW5UgyX4BnYeoOxfLwnUamwOiDKeEVSiZi037Idxba+0K9/TRQBBmwfqSvYbu+F9l/fS3n3eZX0xfKIuHN9RO4XXTdtJx09NzM9QAw/raHAXinqI4heOW88jdAps6fUEqul6SdBX1AhEsobs75VviFmOExJUk9GJ+CYOgJYtafZJ/t/V8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(19092799006)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TfTo8mYBA4yFQ42LgJBL5heWBuMOO3t8zebKRbHSe2nw6LXMwsqir2xfiuHD?=
 =?us-ascii?Q?b/OzflaZFw5GR8U7zXcarSF8+ON3DKdMMOexj6MEBP7jaP/7BqIWROKJa6j1?=
 =?us-ascii?Q?P+xlxbLg6/UlD1Hb6FowdDTwEPQKUW7CoFHkXkCSRCPG06yrla4lAQOfUlVt?=
 =?us-ascii?Q?U9olkEqE8Aks5bcAP9puH80wk9ZB6TJRPdNFTNm1NDkF7z++dsgIx8QChrE4?=
 =?us-ascii?Q?NtoSKR85dLbapHQNxjEAgfIV7BZdk4YGJ8ifbbi+4EWT/ZvWdtscV2+7KI2N?=
 =?us-ascii?Q?60wMQp4XXwyRvpQVQc1QchtbYCwqjZXb2ef/obUd/5HvkE/DxYt5rlvoxXKX?=
 =?us-ascii?Q?ufO3uRl0MyQuW717/Z7dHCBtr2jk3vcwiOoW1tfwr761L8ErDcE22a3trdu3?=
 =?us-ascii?Q?TuApmHQbFsIM5QBE5Hs1clst+WNttLF9QFuD5UHCLhmLw95qXRWZs/Ia8oUP?=
 =?us-ascii?Q?dWNrpJrqbkVXrETIozSfA3u1DMQpy/zb1Pfi3eBuO3a2vxT92FdEQcsB1dZz?=
 =?us-ascii?Q?mdNZP7Hsu3rH/5zAXEdgxDsHu/AiG5odnc4N1lsWeEjSGNZzpPDNCpEK3RDp?=
 =?us-ascii?Q?12K82cNuBNiHwV5JovNHTxZjglF1WTBBYD1r/9YB/9U3SlvW94YbEUo0jTPK?=
 =?us-ascii?Q?kSFT8NBk1ijeTfjhB0ndWISmAAZneaEgYSMtQRWAW/Fr5eK9vzOuDmKDF+Id?=
 =?us-ascii?Q?Oa0PMLpeGXTANZ/cckHVYN6rGp2Vu4P6HWefM5NhnAJJHUe6JKyxhU7JvTrL?=
 =?us-ascii?Q?mSiWbYRlLo0nbmpson03D0QgzzMpiyK1NOlWKUjgnuXtXmmZ+Jmm1o3A/cdA?=
 =?us-ascii?Q?qs4OowUfXsqIel+0OD2Ia2ej18SCh6+NmEvCP87e/sj2bqb7C+Sy8ImnOIr4?=
 =?us-ascii?Q?9GSajwUplRU0JmbRC4mUUBMn7gzEI24sBwjCDBIQ9i2y8gz5DRZ052X5tGAj?=
 =?us-ascii?Q?4+Hh0Rp+9VOdY5LwiLr0xveHQmWhxP7SV6crCe/vKCGlD4RAWwk3wyXLPpSJ?=
 =?us-ascii?Q?oVskEmmMVZY/FrBHGARjN1CXnHAoec8ZM4wmMXIp9AcHO0ka8anzzJWS7mPI?=
 =?us-ascii?Q?ouSSkfyb1kZZknfqpx3IO0a7OrN4CzaQUEmZmNHKGt7ubjyw3ksNGVMbFyDu?=
 =?us-ascii?Q?EaLxZNjJ53RuAP/bH+xYMgZVFqNw2Zfkglycx2s83HDXYOrVbewhX9Y0ByVC?=
 =?us-ascii?Q?PKtngXnnoz8sGHJCDYYhOu6DWce/fFAQiKJhk9EqaR39/JUeTs/5UWxsYL6y?=
 =?us-ascii?Q?pUS3RlurWpZK0MsoZShj+OO0ZOKLEjLeA73Jjk/4BVQf9hXXIPHp9wT+F8nm?=
 =?us-ascii?Q?elLin/pRXsXRuNfan2SnuWMa/VIQ6ESlAUjS2TFoq0Rj5kyOFI5mqjxEpGYS?=
 =?us-ascii?Q?8HIc3H6fQNzlsrP4Hsn1T8pV/2YvuJ13EG0eNnp0bZRSL41SLALK0ac6eHgq?=
 =?us-ascii?Q?0dejtpUxAxjeTnYnwSguuMZ3Nsi8n7JRckWpNhrK6nEEA7hCwFMBjOenB6aw?=
 =?us-ascii?Q?26G2fHjPlUHphSUgjmBuSTvvMExFvHd9ch4mvEZaRhyl46IgU6PDnhTWj0Od?=
 =?us-ascii?Q?QXRuDtQDTx3mEZjWbxrj+6yakAwzuWNV12cE/QPeojcE4hNaa7n02j+z524q?=
 =?us-ascii?Q?YUJIGEgaAk2H49xmyufzpcfV/M0UvmON/dcblUpN2AZ/51HBrMteOM2fURdK?=
 =?us-ascii?Q?URcwq5MFpMfdw451TQ/JspCwmI0dxry+CUW3+MakXksVm0vNsH1uYEZKDGJy?=
 =?us-ascii?Q?O4+El6Kp6Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcd3e3c-7427-4f40-9a43-08df2f8629c3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:15:38.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Mtpaz+q1ErxyGWgaFTKVLaUSKfgDRSVWtR5+KDoHkXJMzNgiiAthZ/dbE957LCckkl6kP5FFmmQYrX3BiwF3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA6PR04MB066831
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Wei,

On Tue, Oct 20, 2026 at 10:43:12AM +0300, Wei Fang wrote:
> > >>> For ENETC device, we already have a 'ref' clock in the enetc node, so
> > >>> devm_clk_get(dev, NULL) may get the 'ref' clock rather than the system
> > >>> clock of NETC.
> > >> Shouldn't the clock be described in the MDIO DT node ?
> > >
> > > The enetc_mdio_read_* and enetc_mdio_write_* interfaces are not only
> > > used by EMDIO devices, the ENETCs and NETC switches also use them.
> > > NETC switches and ENETCs can access external PHYs or internal PCS/Serdes
> > > through their own port MDIO registers, instead of through EMDIO devices.
> > >
> > > Your first patch only modified the EMDIO binding-doc, not the ENETC and
> > > switch binding-doc.
> > So I need to patch also
> > Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml ? Any other
> > binding document ?
> > 
> 
> fsl,enetc.yaml and nxp,netc-switch.yaml.
> 
> However, once again, I don't highly recommend adding a clocks property to
> the DTS to obtain the MDC source clock frequency. My reasons are as follows:
> 
> 1. The MDC source clock is the NETC system clock, which is a fixed configuration
> with a fixed frequency for each SoC, hardcode the rate in driver is simpler.

In the RCW project (https://github.com/nxp-qoriq/rcw), we have for LS1028A:
- R_SQPP_0x85bb/rcw_800_sdboot.rcw and R_SQPP_0x85bb/rcw_800_emmcboot.rcw:
  set CGA_PLL2_RAT=8, giving 800 / 3 = 266.67 MHz.
- R_SQPP_0x85bb/rcw_1500_gpu700.rcw: sets CGA_PLL2_RAT=14, giving 1400 / 3 =
  466.67 MHz.

Apart from these, yes, the other RCWs do set CGA_PLL2_RAT=12, giving 400 MHz.
But the statement in general is false.

