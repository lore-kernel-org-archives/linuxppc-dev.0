Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87880606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZhbPniO/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTd765Wh2z2xPb;
	Wed, 18 Nov 2026 08:25:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794950722;
	cv=pass; b=CAqEHLX8+0TrlRCPGHQbDG176r67mJzPyCxPJS9vBGYW0xVeIh+MR0EukuUpvD5ZZKJ8ZDSWox8EPNl1KkvawGmklbVWG1Gb1a0wxzfzhXCyco7comuS4mBwQAHjjnS5XaGs/xRC2PlYlIF9KLC++HFzGUfS6zxqdLBxieBpQKn6oeuHAJDvBtU0Uoqc4SDeoDvHx8DLO7eH4L/cvmdPCGsgNFpxaumHNhdnb6VhmhzwCzijbOQ7tUaoK2sJalejuTcVd30Cp6UBXrvISX1ZJlmuPEYDWrmUa175EHiq6csGKgSRiQgbk9qtHEHPWNSSTnY+byO9Pa1yY92cosSpjQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794950722; c=relaxed/relaxed;
	bh=axodwTasm91O3cYfk4Gz+3vwYcx5CNhleO2ZYTQnJ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GDdobExcZiI0UkclnrzbOUZeFCGdNjgo7LkVTMf/oRcVBzoXfmq30U09TldtGfj+Gp+sXpJCQcoYtX/5AqqtNwSQFyl6RwgcVl1FZgV1LAaUtf5gJyKmTs5RBF3lGf0v9jiv6Pwq7fh0nPCamxgbpDD3a0fyWf0P9/59DUpysB4GGh2Em4lCHmMupnVXy+/hbVX8xLltMg4iPaM0YINNqzuxiuHDqkGV1+6FYE7qPYRKLRZIygn/EHRzYwqZuZHiwo2vfuiMAUYsjqIIl0cuAYAyNVfp2XIMqOce7V8dL0qe8YFxvnpEqgBs5YQCmqtmx/cMzoLiZL7fFAA1mBMYCw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZhbPniO/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZhbPniO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTd755dNNz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 08:25:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhYPZjjS7S9jQ99CmSsSf7iA0boHYZtu97QMHpatDb8KiUpnSDul/ZxbnhJwnrX861fpUPCwIUYMPLF1oIfTygXnk2BK4oI3Fy2NHRq/TQx458ECvNqXCexlLhqAdzc68tKS9UYpknHhNf6gRCq7N0PtY4c9SwRVKmaf/TvMYozY6af+5a4gERhkpDnu7dzX6TAs095LdCDzZW6K9kH2S1fW18aT4IXwSOr0nQkib/sjJSM+vZquy5Hb1Ax4wrHtYgrKhFOoeiOcDSGMkrHG81RB+Sg442M2hFS4HV4lRtg/YAiH02A/SJdJS/ObMUcPySiIqLSfqzXKGlcBmS+qOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axodwTasm91O3cYfk4Gz+3vwYcx5CNhleO2ZYTQnJ98=;
 b=FX9Q40xzXdNoeCdxtHzvsEZN/yoEdPgkgtnQGKoEWQ9huu9WZ+ZAEM7B5S8+A/4Vus6cqPbvZK15H3LbrMOzmS5DdteZWCJNVbttQ0II/M2WoULHXvpbkwR/vr2OARKCARQrHDc0FPhzlUZmPBYKGEEYiHHnJEWtTTCEBBWOoPxPWsiBwSxpiqMVCeDuuETNLABIzsotKvUfWZbrYgD+mUDe8xYzDDQFdaRJk1HW7Oe+tc53+7mLaJ7+Jn0OMrz8BDAzGNNacNtJHrI/pWgKmGzWXSYOh+OkBkCnUkVP2A0JObgOB5NahVZJTyqn8x1Njep8Fsfyeuc9jCIF40fofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axodwTasm91O3cYfk4Gz+3vwYcx5CNhleO2ZYTQnJ98=;
 b=ZhbPniO/8EVkojiNjNNskWXJVfFvGz5OKMS4fFce7hufDh4CkgpSW2gTryE5kMVaT/j4V5biPs6d2n+HkugpsrlMUKyOeXVETv7YwMwtXcMTKYlYejTlXOkIDL0PvqMz4m5La5Ii4DNwzWChAmUG3PP6/Svlg38HxbQqt+Cky6NQeNWH7Qge4SM50PHVjjxhsm26INCZxYTBFb8rXPsAhnT+4Uu98HYLkGI8lFXO4YirnZMpO3yNum345FHFz6vupshZj4ljfCCbvTHoufL5qKPMxx8LXAUDRhtF+bniRQW2Vw5J+zoJ/hN/Kkv1yugw+xqK+ESu+4S6rBlRY4Fm4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by MA8PR04MB391102.eurprd04.prod.outlook.com (2603:10a6:250:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:25:05 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 21:25:04 +0000
Date: Tue, 17 Nov 2026 23:25:01 +0200
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
Subject: Re: [PATCH v7 4/6] pinctrl: freescale: add the Layerscape RCW
 pad-mux driver
Message-ID: <avzDTVESwMT2X67Y@lxl00025.wbi.nxp.com>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-4-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-4-5d7201970629@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-4-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-4-5d7201970629@free.fr>
X-ClientProxiedBy: AM0PR10CA0037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::17) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|MA8PR04MB391102:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd870c1-279c-4d26-c28f-08df44f13f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|19092799006|366016|376014|1800799024|7416014|18002099003|6133799003|22082099003|3023799007|11063799006|4143699003|56012099006|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|10067099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	Okt3/IfGeLAruVBfsh8OlRa9hNf2iW9J19PTdMgSeSP8ZtuXXClpLzuHvbC70slszINZJhtUDaEgRjVH2hycdSIkGPiudGj0fxJd/vplBrOOEV4Pvt72YgX0Mpdu5ShtRzaZ2Kf0bm6ciX8U6kU0nRcdNtFkHykOjeduBBRoDdL59ky6GiVSjVgs3Lrxqbflv8A6WXaN17/lC9oLwEb2CIR1Yiin+GaJpXTMlVBjUQ+vs9opbtcNzb2zHGVE07gOAtG/6iB+zEXJyaXT1A9GN6zejE7vSHwbH9tvpxx4nhmixbim9W6lSGbIOVm4B/f5WfhSszfsGojMi/EIPVoka1bTXLL6qTf0JtAsmO9FEHmqZfVx4jg7f68Uyp11T8q0JD2RYDlof0KPXsUcxcy7yh0Ey1Dl1Ks52/d7Ll0LHCPA/73risw91xEErOTIt4Vnq7JSEKb4Jeuh9n+1rhj3dcfiNx3Pjgzt1S1QG9YnzYZlezM56lkoihdM8OOmTBBGBG2yHbhKELs1i3M5oyzHSXl6bx21XkeXkIPveIxf7RPM7/BG3ITH4a4sUigxUf51CpbcZh1OygKrF1KTmkaM5N7DzbBrhDzZDBHW+xVY2cw1F+3eiW4KCjEkT9ODBcN086Fi2koN4vJ/C4v/0j9BjG9An/4+u9EdCVz02ZKvNsKwFvdgPBrQzNko8oKcD+2bw3qIyMwMpqv4ddzq+Yge/wW8wD93wF3wzXcgty6kBlJIaOt+xh6W/GFo4RW3Fb2G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(19092799006)(366016)(376014)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(10067099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RENWGYwvVduD2DLYmXihKH9V42sPPvKhQO7BU3JJgSPVYmZdPv4Y1ssU0q/?=
 =?us-ascii?Q?wMsL8wIV0hNsiZUnYfMo+ChYbV7gBvk3plSfxsoGLxAgJJOdNlh0QVTjjpKu?=
 =?us-ascii?Q?mGy64KGwWDltWL2qYGeG0j43xLKSClypottI3wMEmxJNzu0L8URkOGRZ80Zn?=
 =?us-ascii?Q?lHwT5F18I1Cm4aVN6tcbBDWuup2dUNCQJHXPyedc/Wtqon6S0W12fUEZjhYV?=
 =?us-ascii?Q?IcXML4Pf9sNoo7qio6K6Yp1shv8BYVlG5iSndQKXS7ZmzdYY+eh9frqS8mwl?=
 =?us-ascii?Q?G839hy4z7RbdbghsFnPfdVK97YdwDKrJ2Yd8IeBdAC1sRypRy0TaXaY3jbDx?=
 =?us-ascii?Q?JPZa67azQkfMLPkVsRY+bZ9zBLzQuDzi7o7NHjcWIux5cSUATL6biJxPKo45?=
 =?us-ascii?Q?mIdnpL94e8xN+iIuOh682JD9yuqb3AQyFTNBIvZbdgFkuRQ31APH4TfnHgB4?=
 =?us-ascii?Q?JJXejBWOAOyIRCfIHWx6KTMOI1DEK64qZ9EzpXZodeFBJJf/U8nJgqYKDfQC?=
 =?us-ascii?Q?57HSFq8+sgwLuaIEmBEwYDUEW1sp76sYUHPKRFdmz+lyU9d8SVG42taBV1QW?=
 =?us-ascii?Q?DG4C5XLnMowR4fW5y/denls5DtMin3MK5lOYW9mN8ndCa2Mj6D3Tp8ioPp6M?=
 =?us-ascii?Q?P1Kr5lkAm2zHDKXO1BJRIZZg7iCokj1ws5GdMAV82nhIqjr5PQL2U+zj2zBT?=
 =?us-ascii?Q?o9AM40DeAax0CeV44rAupq4cfBOPQswKMCVGp97hROeeWFV5QtCcOFx5T/W7?=
 =?us-ascii?Q?HIRbZlBQDzNsjHAuFiDqv+8xAsBKGCdNVUzV2EnNo00+gzTrJaeG76r93AR6?=
 =?us-ascii?Q?7oaQ7uT8tQY80QBH9cX+UMAQbbZt+omkCStlaEqbDiPqqie1uA5hQ1UDvL8S?=
 =?us-ascii?Q?RIvO9fkgmzKflOA5Lq+HIZJ53fBpg63SH90XbUW2XbLAybpNCfrTBIpb0+23?=
 =?us-ascii?Q?VzXvQ03ipLlUW/RIY6cQ8rh1ujZ/wLDeeOOu4IxI/NXNmTdxe/Rn6ph3NVwh?=
 =?us-ascii?Q?pldKw5WKUf28IF7jsCxd9tYRUD0Lab0g/41QsTcKBucHPZLVlrJy4SfW1tXA?=
 =?us-ascii?Q?eTP6McJdWCfyyhyB4jhmd3NTKDAHKwazg+kS97PWLuzKng3LaKVGb9Ya5kfS?=
 =?us-ascii?Q?v3az00iMkQ/0TZfwOTS8xVgknqrz2Q6z5kFftl1kNiP1fFtSgF1SgcjEYs4v?=
 =?us-ascii?Q?lycoCXMbltseeiJyQz4AOB+9Y3wBt3dut3nnFdRnqzLgl7Y0CcY6dCmpDf1E?=
 =?us-ascii?Q?PjxRinSHUcW3dLocj5moVunN1Ze8oZQOJXIn4J05H28ufltpABekbwtWcljq?=
 =?us-ascii?Q?9ohEEGZQaNhW/K0GNKffYBdy2z8z/vnAGwziMdWWtj3esBpjGhX7jmUYTLHh?=
 =?us-ascii?Q?3ciWVnlBtHsfyufObg63Ya3/GRPKtFPSZwciXzRGi076Y8CJZTMpZ3U1i9Iy?=
 =?us-ascii?Q?cDKuFvFsGsUij1E6x1Ciz+1AoeXzs5dqWsmadfQt7RGn+ZZprVXmrWe5C+rx?=
 =?us-ascii?Q?hrovOLcJkvh/Cy6y3ATR7F8tK/mU+oOrsLnWINR3D9fTSXb6fs9+RpmENdpW?=
 =?us-ascii?Q?iid2IGyO4wgSSrwqAK0n2B26DYW9hDDyM8yCzL+jXXMRislqHXGP/rCKPzuk?=
 =?us-ascii?Q?u3JTxVp7K/R6BT5jJM8JXOLnNrwNsbxSDygQAemh9IRny8ysTFMlVfX+ecnn?=
 =?us-ascii?Q?av0w6oIZJB6vlus0ww45QP8LnX5n6VuvL5U2dgU+zL+B7LVsCjGPyx+1Cr7u?=
 =?us-ascii?Q?tHkb6Tje/mhcm9os8ceMj8jGrevhyhNA+W/1/4O+ezSQKmrXm99xfji2KSrl?=
X-MS-Exchange-AntiSpam-MessageData-1: CWgesxFMeNJjDA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd870c1-279c-4d26-c28f-08df44f13f33
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:25:04.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IK3WgSt+eIG+ySAHbAVosKaVdP43mYhCdcwbOUc/pgBHnUgDUtZP1f+dD1s+mLcJXX4mdx6nxF8OFlnxvW3LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA8PR04MB391102
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 03:53:14PM +0100, Vincent Jardin via B4 Relay wrote:
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

Yeah, pinctrl-single is pretty unfit for purpose here.

> Add a generic Layerscape driver for the pad mux as a child of the DCFG
> node. The fields and their encoding are per-SoC tables selected by
> the compatible, so that other Layerscape SoCs can be added to it.
> 
> Only the LX2160A is done: the fields of RCWSR12..14 and the EC1, EC2,
> USB_EXT, GTX_CLK and SDHC1_DS ones of RCWSR27.
> 
> Then pin states select them with the generic function and groups
> properties, and every change goes through the RCW override
> of fsl-guts, which reads the status register, writes the override and
> waits for the status register to follow.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com> # HW perspective

