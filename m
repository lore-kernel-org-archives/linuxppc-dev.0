Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3F606A893
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yDH5yJUn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSvM43gMxz2xdR;
	Tue, 17 Nov 2026 04:03:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794848592;
	cv=pass; b=EuptyMzswdVVBxKnkH54qJwiskYx3ZHA5oQlBCVtPdMgpmqRXXLS7Txiuxi0wtvlFy//2NGh5/6Xpo8HXKVZMbjsI+QJ4Y2hbKg/c0zu/6nMvUFK06n5dGNlOVn6gzv8Ym0oZTxRtGXFnH0w0gD9Pg/mTYCPQR1oPqzswr9zO1Y9eMEzRp/57H633WGsOX5B+IofJIe7tnemvJwDjY5Swaq8CObhSnB2VyU65x93eXSMoonKxx3tmnNBNwxMFNTCNk1oClvuoYFLkGLhv3hJzVcqp3234nfldQOeTpgw09+5LzjNjTSl42oOB7RDTa/1QKPBeEvi+HkOMDdxbp9Ycw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794848592; c=relaxed/relaxed;
	bh=txney55JXEUJ/0VwwgFQ+Hmh7HAFiOWq6vyYCl6naTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RAixsdDnHua3LcO2hJ/RuGFdCpHRCKVTEfZ8ndYuQmiYT/Xz6nLFlEkIXA5ZSW6/LuJgxeuP/uheTztQLVLBxk1sXAbjz0UICzZREGmNh+xuoSiF6zyLw72Cu7R+JrBCpfl2n6arB6LAOc+A3lTQ1Kiuoo1Z4kR4kJv0ZF7FzEV5nxuLZyqMv9O4RRjvFObZV98j4gFxJlGHWkfLDsoIOtu0+Ub8bacc2kdhBcp8bJZHxaopM2A+eBBJdPMmAA6Lb9awDg+x56D1BQxvbaMJWlPxfaL4E3Rwf/pwjDW2fiZ2R1bGRRVtu8bqifFhMjXENjEzuE7QiMXjHvmToBSsuA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yDH5yJUn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yDH5yJUn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSvM263yzz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 04:03:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5UCdV8s7Ysw/cbcf9J2/RI0G0Bls5z4xhvp/bnhHgOQCHM4Xl7kU3+3jjVf6Zi4Qou70aDvdX76GYQE1CvBWxH5ujlbOG7rSJS98r4o9NiCbFWjCwZNeSWwzLwXWFZ7LhhxS6JGvzNvKsZCloGnDKnztrtIjP8OXg3gNlHfXk2jYnFPDoeI3oAp2KWMnuRqEEZI0mCW/p/fUYlKArV99xcqhc5g1qwPq3o1JamDGtSldMvpOs4KSC1jv/SbsSZk1XxxPs18zLZnpyhoKDaV9VqU5oPEKQCutjSQg6aPKTIsWfkC2S+1BPt9yQuIYeBiaUp63H9S1dbjgEi+0mxlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txney55JXEUJ/0VwwgFQ+Hmh7HAFiOWq6vyYCl6naTs=;
 b=X3KsscVTOS7ydD+2eG6EsEfY1re3yP9E1QJV3wWWyiNdaMSYVHY3mQ6x5pGaNpfjHe3R0OvVJhuVAb57Ta8a0BarZsvx8PzJATPxZhNSOeC/aM5D+c8WHJjiDh6au66soZAgOhLM9tePU6MM6I4l2+VaYZcyt4BeLaHQ0JmO0uWcfgSg1JPe+4jCfkGjKr2zgNYzd1AEFZuSa8TE5heJXAFFudkK5isLpYw0XGMIWIutCR6RYQ/sIqdvMpe689RN3LYDZo81Q0FqRUg1qQBTGxcUjAEMDax9FkruLP0ND7QUxfJa1+yRgwUzaMrDR+yrlGHQwBetqCOXK7Vf1eWp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txney55JXEUJ/0VwwgFQ+Hmh7HAFiOWq6vyYCl6naTs=;
 b=yDH5yJUn/qGemF0CuCAxnIUgkNp6XVLLoLzy/ETL1Sh0Sy+DbMX3VFzmVdVuzJtGmlaRxkRPcl2v+qcmk2FPT6GhmLdSnR64D58sLI3Rshhe45tl/lub8MsAPWlaDgm8BslVVSo1ecBNRnm6pX/wlDLu+k2W7yr3vi6saTp1jDvMu0bOciFNb1nkVUijqu4LOfoQhE1klOi+ena9CkJZKcQXovZLZ+I0tZvVRodJI506EXN85JD20bGVSI4vSlaFTc6+zQvcmL1nr2lfQIRAVUng2pjoo8v36jK8Ggz0zAGeSMkn/U6uoWjP50D49todXKIWKTbVVqgIQdhybipCDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 17:02:51 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 17:02:50 +0000
Date: Mon, 16 Nov 2026 11:02:37 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
 mux
Message-ID: <avs3Ldd95mmdOSaG@SMW015318>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-1-fbdce4565a5c@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-1-fbdce4565a5c@free.fr>
X-ClientProxiedBy: PH8PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:510:23c::21) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f74b76-b715-4702-140f-08df4403727d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|3023799007|4143699003|11063799006|56012099006|10067099003|261028144727099003|261026121527099003|261021121427099003|261026140227099003|261009223027099003|261102123227099003|261022105027099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	WIcXfcxr26FXNUQ7UpkzfQqSfVOV2OV4uOsmkCVd7gw/LSpS0LXn5vjfzYRiTtnmejFuvg88vYPqjJA9Rq7TD1d+Png+egVjylM7fEnFobJeylEmy73mkSNUz4/fl98F6NJXH8Om9ODhjwTs0REtz0GGcZpW6I5xa/uy8eArNXZEDv8RawpUOuiBbUDegLMGHCt1vn56O9FPGvr/CkF+9j6Qg+jtaWkV+n+8GjDTA4nBOp6POjPmWCGs82dPJc45Jz6x7wA/lH+aVXMKUiqEXgXhuNREyjip6SySpmRSXron4VLiowyr6zrAMgWlwFZP5Ts3Lv/lG3ArXaR5z9JUeDq6VBGTi3zF0Zp7874cpxUB5FuEl2gFh5u+2M4504VsKPpbJZz/KF5xdKu9rRQ6YfHwg8RkzZ5Yctg0HUdl5c/A2Tqfm6dDZH9Iq9rO2bZ6/LXzOcRG4MxtdBjVdgY1E6W21xXRXZwV6d/rLmuykKX5cx4+sqLtaOU62gZvlagoqZ86oZ3UXdM/TeJ6gbvk+1nysa2VCePunXYmQbQ9sZqExqamke8SgzBshKnQcb9/82YXM8vqncfz215TnK0aSznXeGM/5gxy8X91f7R+JGibva87PkteJBZhxhRgqkx+56hgJ3T3EyED4mSnqJ4QPAcwXPzXHXV9IUs2Hu83hbF4BY6atAJJTqEbqvGk3VQVcLbqQyJPlYakd9rPlQw//g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022105027099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eyJEba9N38VDuCDLmM7cYTHzUZBKhximG90zSmqnhVPwVfUTlwZrm1Anw4iY?=
 =?us-ascii?Q?Z62UfrU2aSOXJvw1B6JZCGt/2M+2TpS+sW439viJD8QwUx225KR0kS/GmryB?=
 =?us-ascii?Q?xl8cA6v6ISxZARf/pa7O4j6JHLO9VY/FPbOU5uq9Yhhp8BVH+AEMWaVw9uCJ?=
 =?us-ascii?Q?WgdZQ+EOou9yvnR06e1JJqMgmpyKSuFr9shezUvxkAabkCZpDXKsELFPLswy?=
 =?us-ascii?Q?h2Fm3SwA1gPo4rO4oGeIM2SugFG7PrCTS09gfeC+ZbLt9EHU41usMELY8zMe?=
 =?us-ascii?Q?utoIhesB+pTAp9Ve72xnsXnNrg6TFPTEXAHIlzQBGUY/xFzVfK/s+WjD0bDX?=
 =?us-ascii?Q?U4hFoCvbD+qgcI2+/tkprm7RYCfpu4+pGPnnY1sn2Y7gNMUaKIlf50v5qkQl?=
 =?us-ascii?Q?uSmFQ2l8TpwgbsYphIrfc4Bt67PSw+2KcAtY2fl330YDswnoaKyxXzRY1ysE?=
 =?us-ascii?Q?TDiIvrP+oOfd/d7xXQ94ExHlp8vASArrKbOr9k4b0+9Ci6F++vXEGhnZFHm/?=
 =?us-ascii?Q?w+9bL1irLKHIpu3VdqcHorhlSSwPfQsJczDBYXD5r3P52TBeGzJn6MwODv2M?=
 =?us-ascii?Q?RndtVSKEEzQ+ZtQ/4ktaqKzml9z9sGHonw4z5U7OSlWmQKsCP/Z0MV5gS0wF?=
 =?us-ascii?Q?Jwl/4A4Pv5fQGJ91ZejZs/1znyKPs96mBiA9aXgEzu6si4oPe3rUM1HYwtoV?=
 =?us-ascii?Q?Ocksv04fAlEgAcVPZF8Z2eTNwdkA4vvUzyqCw20DoK0I6S4gzigWDWR25nRs?=
 =?us-ascii?Q?2uGNhYpJNs+h9zkHaEyR/gYD5jQwyQWvqpCxYptF4SU2KHzAe59KRm68/AEb?=
 =?us-ascii?Q?7npkUqnfuCWWiOmwkS+iln3hWc/46gOpSJ9Bd1IyO/tI7gFHdi+wTSNbY/ox?=
 =?us-ascii?Q?Wm0ELJp94J87R3DoT+ZZU8XCLIPqLNAvIytINuv8N3YD9z+Ap1+43ZsZLw9F?=
 =?us-ascii?Q?dhCEnjjvP5UQHK8N3CxFFve1j92VSobe9VrR9J71AUYaH1ydhM9qftuJRWJ0?=
 =?us-ascii?Q?mRgcHPDqPGzCfVVjW4OuXV0uRUuNKJZ0Ma2KzQ7NUQNkFhC02y+TKiuNGX/2?=
 =?us-ascii?Q?lwEe+1kPchcL8ud8A7BAc1CNCR/2vTCexVCUs8Wrle9Yena9nbaVSBSf9+vq?=
 =?us-ascii?Q?6IItWYIZMFGK+dy0N46/G+FuVjKsJbxlO5t4fNlktW89ixYphs15xPW9jbdP?=
 =?us-ascii?Q?o14YVwESXFzlI4gmA9vXxV1yhDQIo27a5M9+T3xjqe2w/BOjVWjKvrgicKZY?=
 =?us-ascii?Q?ji1verAptQVEzVLrnTI7pm942YQ8u1o7LdoQKnAtuhczyXkH8pYYC1PSBKSx?=
 =?us-ascii?Q?UNlwnk4LKfIW1XM6Yhoyu0EN9thTcYgvN5WC6pc0SaHvmfXZodur06HXmPE7?=
 =?us-ascii?Q?JFXppyrKZuQsdYHVKCZGCUtpaIjrL02l6wdjC9YKYIqcgERl3kDIZth+a/ia?=
 =?us-ascii?Q?EhzvG6WgNrWrEdAS4SKuxhz6mZ+gsm0GpShOEpg+bGr/p3YgWY+yhiIGXupt?=
 =?us-ascii?Q?T1W2ix+UqGBdURqFsOcBVQqtszVBb5xaFKQB61mHqq4cgyFOIDij4C028zhd?=
 =?us-ascii?Q?GEz9O6naglQCSWkkGWlev3p04rp+MOWWBqSSUJ9kWyCC343InLt0+e9NN8jN?=
 =?us-ascii?Q?tmgozuclWp6MXEa3E0NS7/JQLtNfXIudmEEjalagK3Lm4tSY3V7unAsz+DU+?=
 =?us-ascii?Q?8i0uM1hllyP+jFGFE5QF9UrMb1Oo0cniiroFFFR28yqCEcDpcQN1HlriMDIe?=
 =?us-ascii?Q?+glpWs4brigkt6r2FACIHWU/MP5GrJQQuTwPg+5urqZayNg8CA5l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f74b76-b715-4702-140f-08df4403727d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 17:02:50.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPROOIX2v8x31chkVkF9Yv/wl3bEnUkQgfQbfXx3U6zBGoSKcx05+17lTCLnaV41jQr4Wu/JCel2RB5UA4uPO8lf90GqKHakDgBChY66hXXeYYEWY0hKQ3dwZuSHU+3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 02:27:31PM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ, EVT, EC and USB pads
> from fields of the RCW: read-only in RCWSR12..14 and RCWSR27 of DCFG,
> changed at runtime through the override registers of its DCSR view.
>
> Describe the pad mux as a child of DCFG at its RCWSR12 to RCWSR14 and
> RCWSR27 windows: the override registers are at the same offsets of the
> DCSR view of the parent. One group per RCW field, one function per
> encoding.
>
> Each function lists the groups that take it, so a pair the driver
> would refuse, such as can on iic1, is refused by the schema.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 309 +++++++++++++++++++++
>  1 file changed, 309 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> new file mode 100644
> index 000000000000..f835ebe332a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
> @@ -0,0 +1,309 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LX2160A RCW pad muxes
> +
> +maintainers:
> +  - Vincent Jardin <vjardin@free.fr>
> +
> +description:
> +  The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ, EVT, EC and USB pads based
> +  on its RCW. The related fields are from the read-only RCWSR12 to RCWSR14 and
> +  RCWSR27 registers of DCFG, and can be changed at runtime by writing the RCW
> +  override registers in the DCSR view of DCFG. The node is a child of the DCFG
> +  node, which owns both views. Its reg are the RCWSR12 to RCWSR14 and the
> +  RCWSR27 windows of the CCSR view, and the override registers are at the same
> +  offsets of the DCSR view.
> +
> +properties:
> +  compatible:
> +    const: fsl,lx2160a-rcw-pinmux
> +
> +  reg:
> +    items:
> +      - description: RCWSR12 to RCWSR14
> +      - description: RCWSR27
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    $ref: pinmux-node.yaml#
> +    additionalProperties: false
> +
> +    properties:
> +      function:
> +        enum: [ asleep, can, evt, flexspi, flextimer, gpio, gtx-clk, i2c,
> +                irq, reset-req, rgmii, sdhc, sdhc-clk, sdhc-data, sdhc-data4,
> +                sdhc-spi, spi, tsec-1588, uart, uart3, uart4, usb ]
> +
> +      groups:
> +        items:
> +          enum: [ iic1, iic2, iic3, iic4, iic5, iic6, xspi1-data74,
> +                  xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
> +                  sdhc2-data74, sdhc2-base, uart1-soutsin, uart1-rtscts,
> +                  uart2-soutsin, uart2-rtscts, irq11-8, irq7-4, irq3-0,
> +                  evt4-3, evt2-0, clk-out, asleep, reset-req, ec1, ec2,
> +                  usb-ext, gtx-clk, sdhc1-ds ]
> +
> +    required:
> +      - function
> +      - groups
> +
> +    allOf:
> +      - if:
> +          properties:
> +            function:
> +              const: asleep
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ asleep ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: can
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic3, iic4 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: evt
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic3, iic4, evt4-3, evt2-0, asleep ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: flexspi
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ xspi1-data74, xspi1-data30, xspi1-base,
> +                        sdhc2-data74, sdhc2-base ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: flextimer
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic2, irq7-4, irq3-0, evt4-3, evt2-0, clk-out ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: gpio
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic2, iic3, iic4, iic5, iic6, xspi1-data74,
> +                        xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
> +                        sdhc2-data74, sdhc2-base, uart1-soutsin,
> +                        uart1-rtscts, uart2-soutsin, uart2-rtscts,
> +                        irq11-8, irq7-4, irq3-0, evt4-3, evt2-0, clk-out,
> +                        asleep, reset-req, iic1, ec1, ec2, usb-ext, gtx-clk,
> +                        sdhc1-ds ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: gtx-clk
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ gtx-clk ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: i2c
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic2, iic3, iic4, iic5, iic6, sdhc2-data74, iic1 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: irq
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ irq11-8, irq7-4, irq3-0 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: reset-req
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ reset-req ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: rgmii
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ ec1, ec2 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic2, sdhc1-base, sdhc1-dir, sdhc2-data74,
> +                        sdhc2-base, sdhc1-ds ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc-clk
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic5, iic6 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc-data
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ sdhc1-dir ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc-data4
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ sdhc1-base ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: sdhc-spi
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ sdhc1-base ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: spi
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ iic5, sdhc1-base, sdhc1-dir, sdhc2-base, sdhc1-ds ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: tsec-1588
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ ec2 ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: uart
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ uart1-soutsin, uart1-rtscts, uart2-soutsin,
> +                        uart2-rtscts ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: uart3
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ uart1-rtscts ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: uart4
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ uart2-rtscts ]
> +
> +      - if:
> +          properties:
> +            function:
> +              const: usb
> +        then:
> +          properties:
> +            groups:
> +              items:
> +                enum: [ usb-ext ]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pinctrl@12c {
> +        compatible = "fsl,lx2160a-rcw-pinmux";
> +        reg = <0x12c 0xc>, <0x168 0x4>;
> +
> +        iic3-i2c-pins {
> +            function = "i2c";
> +            groups = "iic3";
> +        };
> +
> +        iic3-gpio-pins {
> +            function = "gpio";
> +            groups = "iic3";
> +        };
> +    };
>
> --
> 2.43.0
>
>
>

