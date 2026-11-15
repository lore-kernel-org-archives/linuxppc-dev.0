Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208D606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NDG1JN3m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS83X51H2z2xGr;
	Sun, 15 Nov 2026 22:32:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794742328;
	cv=pass; b=mKevdr2H7b9Rg5tY8uL2cBsyiaasY0WtBFOgR+y0JuJSECO5vUGUvkaIgvSiKaqkM4J+6Yf0IWSq7ZaEt7qIfFIElZtPbS+4aVJNRj7JYCu5XCbKFdhOrq/Ddg9UEWfN+pVApWl9kZEqGinosQ3XOu7TAW6YBU7znH43XfvJLqkOA7V9Erp7hv8LpKVIldcLT/Hw2kKnpfbnWSV5uNIAKzAxGNL2QHfb3XSH66oc2HyR28E41/TlrKLB176jI10jmREjWR5FEviCaTGmur9PORAlwNNhNmk86LCvdflMo3o21+Qj3/4sWFLN+4J+e5hn1Mb8Q2C8QxG14cqNbcVZMw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794742328; c=relaxed/relaxed;
	bh=Ac+tMfvvnyaFMLOKx8vwAC0XPeEEZCC1gbJDEn0qKOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MZsyovxF1IgvQhDsKYZNgQDX4irPZtjkJQ928pqcZxmUxLwMMFPccFWfMOKluD8Fuy4WNxeTvtk5z8gPmNwgAsNI6n6/DZfUMETNZ/hCDUmzhAgYPmYEBtK6ltYpjJezhxPmVHZI0jyk7Z8GX/8nfWPwygJBEy937DFbecWo6U8oxHxVVbjUn2Fs3rBQFhdvOSGm+ACsd00kHgiIDDesZg8Hkd6oe2clZCIYC8Gh045gMA3WWRaPCpSttaydiwuz1hvlpp87uuAzHUkDd7gsTDN2nSnFSf43K4pqrrHnHwv88URO1+PecuDXb7090DEaLr8OjI0Rycwb3oXm73upGw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NDG1JN3m; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NDG1JN3m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS83W1f17z2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 22:32:06 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4OHfq/2ui0G6T0/ILyCrLU+tLmialDbDT0VbtjJ6arzgAt2fkJEbwSBch8/ujsPGKX6z2TdSdU6urTID8YDtleeZ24vmhl5fWPxjmnSgP0SX1Qv77TM2QZvbqvg6ehSMnqNe+zW2u4+w0QwfTCecJCMoTiVMEQ42hed1nZ5ZEuoKjzACNktaWmOS4k+tpLfLRVfMR5QYUScspwY70C6iOca8d665sdTXtCf35E0WbyRFXEJ7p3YZGlCg9h12r74VmVX1t6LvKmWTMW8n/zVabt+ZmkWpvEA4/IvBdbLsjqMwW4l8U0irIPmihRRkxtkUGs2ypCaEi5V8vDTRWo/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac+tMfvvnyaFMLOKx8vwAC0XPeEEZCC1gbJDEn0qKOQ=;
 b=XibX1AvfxJs2cd4d2eZF1+caPP+pRuj62NCTyUjuerVpP00h8VxNWk2NgN66vymqah2+/p632IPlBPvqbhXIJDPwkguIfiMbTcRs1zFRE1TBhZzWco9L76DrlntdBIRmK2EiNwAfQOhoJxCMhLUffnwNY6CYxb1fOVZWL1ckkgOicMXjmP03se+HnrnqIJ7mbs7jTSUgse40giCV3b7I0anffXbTEN+ICBbNZE/bizKb55pere3J2GoBh9Gq51EvI8c1SToo0jqWSoYxfVWYNk5LIAtSGNkMBvMicWwANo+QY8rV2xvRF+v0cVMiKPMaVGbOOKBN9QFlrSca38pzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac+tMfvvnyaFMLOKx8vwAC0XPeEEZCC1gbJDEn0qKOQ=;
 b=NDG1JN3m8qR+lJG+9TRrYHvCuAVRwU1oTgJ+M/5n+wiVu1JOzmn+7jmmF0P4081JwE+GQIBLZuGMcuORgxKrFCMro0Te0tLTRtihFi/D9kuvtyP63MC4KQvKwi3W1QWPa9i/Nk1/1+36w4Ig8GFGhrXpuUqBiixxvwTIWvxaLSnMYlifbRZWsM/iKopCbWVPYsXZkyRXJVxyCYU1CPdBCqoysLsm8GtY4kiiP8YyVPXjI8SNo28qWCIPK/iZFivpdOB0M1XQRCiyy4l8qaciQP3viAUduQI0iMFUWMohqpNgIaC1cDY30r46MLTjFnezg3v+u5E0k4Rp+yc5cfUHhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS5PR04MB11419.eurprd04.prod.outlook.com (2603:10a6:20b:6c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 11:31:50 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 11:31:50 +0000
Date: Sun, 15 Nov 2026 13:31:46 +0200
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
Subject: Re: [PATCH v5 4/5] pinctrl: freescale: add the LX2160A RCW pad-mux
 driver
Message-ID: <avmX2HwOji6MBuhj@skbuf>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v5-0-d246166ea469@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v5-4-d246166ea469@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v5-4-d246166ea469@free.fr>
X-ClientProxiedBy: WA2P291CA0025.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::6) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS5PR04MB11419:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9b08dc-597e-4b83-e5b0-08df430c0a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|19092799006|23010399003|366016|10067099003|4143699003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	OLOtCWVsncpmGJwizzVWNyY+MmowS5dzE1Q5PIb4NRbxYbJBTh1Y/RC7v8+6xxrsGdudL5n8a2cvirSguRkDIkL9QvgTyAj9Vm1Y99jibWII2KkAIXkrwCIVANC/vO3jzaHs/WdSz0dGrBvhrMN4tAnNVxcg1dMuY4MmjUTi/a3X3hdckFHRbjSik8Tto/tSSVGxQ7YEEe7LJmCAcBo+sN34z7NRJ/UDrJZ7ytLBL+O8zC8hBw96xPdie/t8bX5kLyeB0oYGnyOIvbuiuxZ5Ey4oOqqfufz/W9/kNngZR6mconA8+bF8rrXuGKv+Nm3muXcb99bQDJXAERqpQ1eFgw0ucU/KzjeiaYMNgdsiUABcyclOAAGoNKExa2saktZmvGzC2aLIBbIAo9mdPFfy5eWhKGD7zJkwlh6w6g1O1jTyAJw2STJ3oY0RMACwjZ5OJN2hNj9cw3GVfw218h2pNSurVHZHVDKl7QuE7flYtppo9uegGTxJHMbFqsDW6V/BkNm36NGG8xjtPO6M1SWcnjqzzEnN+9HjPWlepOnnGuejiXpmDQP9kgPvbcW6wXp7Y2gaBTOgESUmDN/VdJjqlBwhyUSqGnRBCMkKaAR19QXyQC+Y52gYIfzCazZG+B4WWK1oPTtTzdVAGUMM5+wMoFK9OBv2cGAvi6V1NaXZoDvjxqskrUBOfu9BO9PPexwOd9WMUsug1+EFykqoQsaLWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(19092799006)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WjN5M4QvYUP0JYwcuYtlCxuhV52UlYIJRwY4gErDxtNMIKVtMmzBLSAO/hlY?=
 =?us-ascii?Q?mnnAJkFMoQ6McpAoG4jWS7YcmcAsxAtWMO+sGN6qMNcu1tfXoi8mlzZV5sMG?=
 =?us-ascii?Q?9QJNq3q4ptMolMPA7p+f15QHxlqy4kMkJcDQ4a3x8XX3PHgFdD/MkzmHjWIs?=
 =?us-ascii?Q?ycwQhY0kNCU2a8D8SvL5gIocGS0sN/y5pvZG78Vrz91K8Lb4niuvc4gxIcP5?=
 =?us-ascii?Q?Yk5otgk9VC8q1SvwqZw0mXApFpgmNOTMhc/o/EJvjiB4tcBmEzce/qDEIAcO?=
 =?us-ascii?Q?VukPtr+uTgZDv/lGYdYyVFFv6uabwoE1VtJ0e+yMUBkvLSTdsetsBoVbmMxc?=
 =?us-ascii?Q?euIzfWrv0+WGi2XhvwzbVJaPDxbRfCtHW3OtqERxXJFnydgpHj44yG0YPllQ?=
 =?us-ascii?Q?1T/EEPqzm2oBD2I66VZ5DHanT4KpMDgHqJWOZ6+7+91EgLs9yxEftR8Px+Jy?=
 =?us-ascii?Q?OMHZtBFYmQgTOK+VAbYrlj4hoS+gNiWiYQIhNYqrgL8YV3LaOfdqQdgJVwzS?=
 =?us-ascii?Q?SkOQ0Tua8GXG9uAAES4yxj55v3Oe+aRiIv5frxJLbb4OpHkrYA4HguTBZRz1?=
 =?us-ascii?Q?JhEAUcfSEZ0LA+B2kD+240aKJ3ewErdwInwPGHFR9o+hJB49h43Y0b8nxO9K?=
 =?us-ascii?Q?A85/+MVCKvv/tOGDV+76pwtPBOsLb3YgJyK+orOfUK9rQMSf2tptkZ8dZsWx?=
 =?us-ascii?Q?O1c25Szv1vZ1w5RE2yvQK+2e2+dtQMjNmP/0lZmJmfIDGJLhHqcTea8qufer?=
 =?us-ascii?Q?bUFCyVPisfOKslOGqgPW4a4FQQLOjyUpJJwGvmIKLP7ixtqQW8TfQhAw855U?=
 =?us-ascii?Q?ZTMJEhYDpiBfmk2RhRTaHelYvWVG5PuroAIzvNSFTW71o3Z5yp5IaygPawwl?=
 =?us-ascii?Q?H8K7XJd82ohFCcGz6iQ0gMP5MZ0vok5mZ6drcMpNTHgbUbsZaeNecwxu5kBF?=
 =?us-ascii?Q?mV80jLwtlXSrSPTdYcVYhh00BQWVGmCh2T6cdpBmHxfaywp96t1ixl45P7tU?=
 =?us-ascii?Q?iEJ2YxusBy7lG6H2rXpDzj7UXAEYjjxA/U19QbuuqvlFmOqmi+RgKRTvMWhe?=
 =?us-ascii?Q?ktpLAX1bIsH6OTLZfxzjRWxBcPQ6BTlIzLjr21CPZ4PouzoSqb6W8X0ZmX5o?=
 =?us-ascii?Q?Vcy6bqMcqINuI6oIKb2N5oFEofsgd6aCv6a1QjWZQf/s9AekJavSEJknA08B?=
 =?us-ascii?Q?6LuBkkxowfNRN9qGnGHgyIwSMQEkmXdoPO678lxsCDe4mNv6w1ASgPj7dwa0?=
 =?us-ascii?Q?AWOSeRf7FzZDvzKSRMS/WkCGwAb1+jcGUqVkFyes/ArPnhENB1bmr2kmDDYf?=
 =?us-ascii?Q?uFn6YmJ9SJXXuUqi6hxchIbhjM/SQcEb29lmpzCaRbeJpTEFULZLgOrDc8pH?=
 =?us-ascii?Q?f4JwuYUD51fe/gpNf0zJ3euX+Y0aezzgpY1ig3XmZy5X3IKOdF6hP8B/zDm4?=
 =?us-ascii?Q?+TWY+7hhyIj/DuVRchKvnpZ7kYxofe0c11FX65NEo7dPOHa+EAXrCKLU9Vgo?=
 =?us-ascii?Q?OAUfF2Lez8z5m5A8WWxU2oY27hh1wdyiIMTghS/jczJ2kkr9bXFuRb0I2wNp?=
 =?us-ascii?Q?JM5jPS1akF6kDDlHAP6CMlyf+wjAKTjCfCiq0zob8COiDsj9F6DxYdTMKfnD?=
 =?us-ascii?Q?EWoyI5TDCbmY3AphyuI8pcZ1RZIbijBZkkTtylBqAdpIUl13HN6/p9Eg22vI?=
 =?us-ascii?Q?sYIPl1ZJw6TG4wi+kFvA2299bGFd5Qtr3wONqtaFfmN0vDbefDP0hR9AHO4q?=
 =?us-ascii?Q?UxerZyflgianeGopovtaq2qhTBeOXjTRW5evoo/fU2zf7ydqB9KgLw3T2K+q?=
X-MS-Exchange-AntiSpam-MessageData-1: W3AmNzCDn1RXew==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9b08dc-597e-4b83-e5b0-08df430c0a54
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 11:31:50.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSoDWwini64ja3Y0afxySBwkJu2lWSydwrh1fSzErJSXIG4PsVt0Kf3mnP4ySq6wu0uJLRi4KlYA1VhtkLyUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11419
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vincent,

On Sun, Nov 15, 2026 at 12:05:40PM +0100, Vincent Jardin via B4 Relay wrote:
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
> of RCWSR12..14, the EC1, EC2, USB_EXT, GTX_CLK and SDHC1_DS ones of
> RCWSR27, and their encoding.
> Then pin states select them with the generic function and groups
> properties, and every change goes through the RCW override
> of fsl-guts, which reads the status register, writes the override and
> waits for the status register to follow.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Did you see my feedback on this patch for v4? Comments?
https://lore.kernel.org/lkml/avjaK3cOj3iQ6G6w@skbuf/

