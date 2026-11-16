Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028C606A339
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f5MaqDxy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSvVC17t8z2y71;
	Tue, 17 Nov 2026 04:09:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794848963;
	cv=pass; b=awb2oFP8XsW0HzBFofWB8gjR4sEdnr54sX4bApWLpUmszQEDLpXxD1tHXn7wHnb7ZK2z1SxWJJ96ZCYfaC/VKKSp6zsmX3EtuI2pYl3WsfNg6MPDxvdCblMikA6Ho4YppjSp2pwFi6+tr48ibsvriZrp68lRrubKzU2Tf4a1fYTYy2XN7A6Uuzvg9RMMD7c/lOA1rdBHcBP/DqIgGUY0cTHkC1wj7RUdRKJDdplxwJf2okFJMl0qOpUlOKpHWuhJ7/dDtYQw9SGIxrUfY7U/uBBXyJSfqSRq1bW07mC8l3p7yfBwRBOuqwQxje6tC29yItP5LoKgCGBCetul+RmO5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794848963; c=relaxed/relaxed;
	bh=JqUBdWEUZtg7cdGQ7X46yjwUJFtABI81NDN5ExhM/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbbAISDz6o+SZl+TG17Yz7CON0RFUJGo6Q86Y2mjqaxTO2mHxKxKosrTYgCTEo5ugpuL/kOyXpZh03uoRMeYylrOE5y3PX5e0Ai7u2PHTnIBkrB4LN8Ng7i2ZMk/X7hRR4W9ojHz65K1zSOL5iOj39bnIPYJrgAS8oEc7wl9ZFpVlG3j0XgV08uepbrspfu9Wf+qc5eCvsDPO8HsZor1tbBENwbqEX3f41/0azAkNrJacm2n0/oJPpsjHy83UghzlZBClJhsEOs1UYSK/osMmCarellGa0CW16Epr3xWfdWvkzrJ4HMtnVjBhq3fZDN6rwi/1VABOHItUncyMP4Z7w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f5MaqDxy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f5MaqDxy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSvVB0NkSz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 04:09:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9ne57/8wY0Hz8TLZfqTJ2wqQPWI4hTorunlyTPe1HBexBY594Yxb3mep1SLtuDWYdA1qBvcRiWuZgna35jbKEmyDKLSPgfazH5DH68iGw6xogx22eel4Y4hN0bjcdrsEO6s5cK8qgu29fCPqCAc7szpfP0fTWN9ztk8Wb9ApxZKfT8a9hYwy4Ek6k/GnfsjccG32+JuNqc5dK5jCyxn8g/puU9j3TUzloFSia4SV8GNp+1R2hOXG9RkJ3HOundcbv0KtGc0xiKPfGCzAGE1itK4cLT8ja0CIcKe026ZJTn6LbbxJrmHIgQew89RsPsdGnrWmHjNwP8FH0g9GmOaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqUBdWEUZtg7cdGQ7X46yjwUJFtABI81NDN5ExhM/Eo=;
 b=Lm6Q4S0QzVL77p8zf0K8jzKsGRSQ4YjAp5J59avGk3x9ZYTMSMICdXYpiC615ogT1OHp6yMYkRg6cy8esFJDfOzm6cHVmZOrIMSoljfaXOAvnN3hKKK0lj24ul3Pl4MuhbpavkzTZjOr/+5GFNfU28uVvaBJ36gZNT6sdzi2Ss9bS+H5Bb3HDIfj+W4rKzKHrutET191ktA+fywR9D2VeNjXSqjEiOjw01GYK4tgccZF0kF4GQd+Lw+ZIJSXRn3fmGG1rhJY2zVrxLZsV5yW6MvFVADPIYx2+JIi9rymlDAdNXakgVwKV3ogdapQaDiBT1efloSS8qKvyPcxApBZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqUBdWEUZtg7cdGQ7X46yjwUJFtABI81NDN5ExhM/Eo=;
 b=f5MaqDxy9xAENL7MOJyE3739tTbsn+Y5rGkWmWAjdh9pLWjk6Ipzc8IX1P/VP9jw6QifCoo10p8aJwDVFnouapL2SIwqQ1IFU64cM7KU1torDo4WlYUImboNt78lYA6ju3+xjdwwbgad1gx16FEoQAineetWSAr6w4k5dDgPzlLhiS1NpuHa9ScczavgcIU6wFegqyG1/Mn0jZWNqC7Z5L7MFcpQWxjtUYX4aJLDqzI29OppupyLNM60JBkBpQS9Kbk911XmUgJarbkaSlgr5AqezWRqelLkn1oZMoNY+mFcYevtKfQAKnLcIImF/HeZROW47fDi5sVpk/+tqRB9MA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB11585.eurprd04.prod.outlook.com (2603:10a6:150:2c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 17:08:53 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 17:08:53 +0000
Date: Mon, 16 Nov 2026 11:08:39 -0600
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
Subject: Re: [PATCH v6 3/5] soc: fsl: guts: add the RCW override of the pad
 muxes
Message-ID: <avs4l1otw6ACW5P4@SMW015318>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-3-fbdce4565a5c@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-3-fbdce4565a5c@free.fr>
X-ClientProxiedBy: PH8P220CA0060.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB11585:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e92c89-fbbd-4ba4-5c59-08df44044a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|366016|7416014|1800799024|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|10067099003|4143699003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102130727099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	o3zUSXeisgo3SYMzGcXJn/5ip7sTNXqa3gu+/gDsOl5rJb0rSUChDFkqaVnGXm+OalN/WFAFPTMI/l3ZeuDJSwxFLuBkfX0zaQcik4l7Yl+wh9b4FToPPuWAb/iW7018ddIwQJlLR4ub50qQUYdCYpe5sLttOhG2zQKIBkSrbxdlcqnyZlmaXlcnWiZZUv+6LVgSkmy5HHAf183S912u2pDBq41yAafW++KVxKI0Hl+MZh/72cZdB2+1jq0K7Xx/9VKO5HbuF69UW5KuqfYsw3xzfLImKH0IizX4fYLOfG/d6pPnVUy2UAG/VhaIuGRc2YCvp9MZ2p1ShlQvSahCgH3syeEzdGzkV4j0uq33FGRLOB8eKVfPzEgTM2bgqqCZlu+zrEbe+wIf6AfqIcZFdgexGBTRbG76BMHimeZ51Vbn4HtbxB/ln14CvpdKPVeWvoGlMEVm+uRdk8zD38sAy6urmnhcrw11WD57fn+EGhXIsHCP+L07AuG4WOZXjGz3mwLzUMAEmgu5otPgIA6bWiBQ7NkSE7QX4kJjdTf2EDUO+ibYoMdrIXU3de7jLWdjrtdvfIrgd7n58g18dpGp9j1BYzcXs0USrbB4MY989RQs1rMltHUuNNaIhFIyUGimbNXBbkn/0WNpXCL5e7PN3mB7Iva3nVienPv2a+TFVrya9IIeNbjgIwoSpi592/ZvWmFcwDHk5ttBmUjFf2Y79AcBo5xyzXQCGelZVhb+udbKZtc+8aY3CYUfkrb6M76f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102130727099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?euSB0UaB4LVoo+aPCs65gfmYpU9o+w1j7ZIYQyQLOtz7GPAQHt/Wam0Prkm9?=
 =?us-ascii?Q?bggp4nIBkIb1xP+W0VHcY/0/Qq+btwCOSH6fSW9Hp39ynOMoBfgujOgXRUDI?=
 =?us-ascii?Q?ybgFj6DHb36KCGfcnThdKc+I731VpllOGkcfPkO+4tJPenEsvd0m9LemmrXS?=
 =?us-ascii?Q?ipVyUYY/hlSg9vpk83TuxAsMnaEia+7R4EzwRp554dFLb0E/MFJE5jX6aPXh?=
 =?us-ascii?Q?jzn5rPtgQwZSx0ttS38in3q7AYu+QaYCNdbU39rG2k9IQwiJOZJuuCghZKIf?=
 =?us-ascii?Q?5zR+xpCu00RkBL1cKO9lf/GbmluJTVs5i9TP2UYnwdXo0x8f0MJVe+w/4ysb?=
 =?us-ascii?Q?gykUKACzHeV9mop/VRinWRcc3AODOQ6QCr/ZfJClLpyYtOZhk9IRGp9JE1Po?=
 =?us-ascii?Q?IqV0gei58RN1DaGa76Jibl4mUSsaGSWdPBni3jA+jUkWZS4T3w7NgcAacx6o?=
 =?us-ascii?Q?hlHd4Z6+mdHP0rWRYU/vKvvuDPGlyh5pgpZSklkboPe67+Kz31fzbdOrLe2i?=
 =?us-ascii?Q?ddgDXvM6ZWYiR5svoyAMEtsqb8xXN77fXDefis2bkO1lvt+0CAUdxEYABucP?=
 =?us-ascii?Q?lD0oPfHfthEyFezXK06/dYjSlEZDGGKap7I/8tQX5BYFrBfl9LOx3JXvJm/t?=
 =?us-ascii?Q?l+BB7FKvw7C+kr2F0UtZ3xQPpISktRQ/6hM3N5G+Bq1b22SVrICB5pZQO8KO?=
 =?us-ascii?Q?UisLTyDEnrJCh1SvAluxk2csQN57+9jACUHH8efoflY1XzYJZkaJHkOLk3Ca?=
 =?us-ascii?Q?oAuqjCMxzisjDftgYAflrw0FSi7VVOD+ecSHC+pWuG/waJEwah13/U+0l88z?=
 =?us-ascii?Q?nvrWmlYH0ULF5B0LbgLiTjO+Cm0zltyF/DTWG3nVb41vR7wG3XWhwbqcz2Z2?=
 =?us-ascii?Q?/STqOIWxZhmI4VJ7MUoX3pWbIMfxGr2fjCeadHkOtpkB2Flnupc35ricub7C?=
 =?us-ascii?Q?f81sWyB/UPay5fY1HqTmLcBymj2ZTV7/7o4/0nZSnfu6yvbwzOGLYWhVrjka?=
 =?us-ascii?Q?nBLt4hACdNDu7fJ9A1He8Lf1YhMjQetuO5BPy5xTQ6bKNHmN7XLhyhxg9ciB?=
 =?us-ascii?Q?BQGG4adONizRVZB4PeU3rgAlk+ch5niYs4cxsN/nmbPzBKysB5BiTWdU3Ym3?=
 =?us-ascii?Q?00Bys/15t8cd6X8QS2Xx7MeruO2EPRqz0sigQdM+7+RwkLSmaNtEe7vq1KmR?=
 =?us-ascii?Q?cp+xhigxB4zISA8GN+eXZ4AD0MFZvWAcV71gjopu2CEGxm+ZPh5AZL6QPn9H?=
 =?us-ascii?Q?iVntluP7RbyeMG9Bfvz4q98lM4kJqlh7M9Oqt9I0Wy7d1jE7uXyrKThj7nL2?=
 =?us-ascii?Q?9w2l2Po1HmFMCTcxjmyt/Dr03ubX7u1KMOKpV4YgU0XARtAgWtSFeors9fxn?=
 =?us-ascii?Q?IYaO1CexSuTpPQrlC2Vv/4HKi5hY4hkExLIhLJED5RK7aDaZZrJ1+miOmz5i?=
 =?us-ascii?Q?J8NE7j22xeuW4+y4bX5L+qwBsHHunD85FORCvZWTmHORIqWlA7CipBKuunhI?=
 =?us-ascii?Q?EJfUiz8lAhQU57PjwRUeeab9wW2GWzreqf+7w38sZiaBtloWU20GL81wYPtX?=
 =?us-ascii?Q?SrHbWJHQ7s3ghwu3x2HtPdETmI8p/ubL1brX49xX7/779cwFejyNVSWuirKr?=
 =?us-ascii?Q?/jR1Es7MvIcthQ3YcjNU+YjZsOrBO4fsyBttu/81O2sKEPZewfhiOWlMAMzV?=
 =?us-ascii?Q?Wl+vdQTjBr/fzfqyG1ZH9SVHWlCp48jFeX2ZjwDI67i9nMoDbYLBGbod4PHc?=
 =?us-ascii?Q?zZaKquV73BPpsR7RnAnkxrn1f6g9R3QhCMwx/kqdfCM7Injwfddq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e92c89-fbbd-4ba4-5c59-08df44044a8c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 17:08:53.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqoarN/hm837BD11RnM74vw6TIDDiJ6FGYd+F4Yt7y0Ut1BIe0dODpJPRMNaTRK1W3eQAJEE1PErQKGwoUdTHhXOCnWC5Ohel7az7oJhBBaQ+u0JqVQMbspNx0tYCPa9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11585
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 02:27:33PM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>
> fsl_guts_rcw_rmw() only serves the SerDes lane modes. Export it for
> the pad-mux fields of the RCW, and for them only:
>  - fsl_guts_pmux_read() reads the pad-mux fields of a status register
>  - fsl_guts_pmux_override() changes pad-mux fields of one under
>    rcwcr_lock and waits for the status register to follow
>  - fsl_guts_pmux_override_supported() tells whether the SoC has pad-mux
>    fields and whether the DCSR view of DCFG, which holds the override
>    registers, is mapped
>
> Each SoC lists in its fsl_soc_data the fields that can be overridden,
> per RCWSR: a register or a field outside of this list is refused, so
> the SerDes protocols stay with fsl_guts_lane_set_mode(). The LX2160A
> lists the pad muxes of RCWSR12 to RCWSR14 and of RCWSR27.
>
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

You missed my tag?

Acked-by: Frank Li <Frank.li@nxp.com>

>  drivers/soc/fsl/guts.c   | 125 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/fsl/guts.h |   3 ++
>  2 files changed, 127 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 28361c63e26c..a4b767f1e297 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -53,6 +53,12 @@ struct fsl_soc_serdes_rcw_override {
>  	int val;
>  };
>
> +/* Pad-mux fields of the one-based RCWSRn, the ones that may be overridden */
> +struct fsl_soc_pmux_mask {
> +	unsigned int rcwsr;
> +	u32 mask;
> +};
> +
>  struct fsl_soc_data {
>  	const char *sfp_compat;
>  	u32 uid_offset;
> @@ -62,6 +68,7 @@ struct fsl_soc_data {
>  	int (*serdes_get_rcw_override)(int index, int lane,
>  				       enum lynx_lane_mode lane_mode,
>  				       struct fsl_soc_serdes_rcw_override *override);
> +	const struct fsl_soc_pmux_mask *pmux;
>  };
>
>  enum qoriq_die {
> @@ -369,6 +376,110 @@ int fsl_guts_lane_set_mode(int serdes_idx, int lane, enum lynx_lane_mode lane_mo
>  }
>  EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
>
> +static const struct fsl_soc_pmux_mask *
> +fsl_guts_get_pmux_mask(unsigned int rcwsr)
> +{
> +	const struct fsl_soc_pmux_mask *pmux;
> +
> +	if (!soc.data || !soc.data->pmux)
> +		return NULL;
> +
> +	for (pmux = soc.data->pmux; pmux->rcwsr; pmux++) {
> +		if (pmux->rcwsr == rcwsr)
> +			return pmux;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * fsl_guts_pmux_read() - read the pad-mux fields of a RCW status register
> + * @rcwsr: one-based index of the status register, as in RCWSR12
> + * @val: the pad-mux fields read, the other fields of the register are 0
> + *
> + * Return: 0 on success, -ENODEV before the DCFG block is mapped, -EINVAL
> + * when the register holds no pad-mux field on this SoC
> + */
> +int fsl_guts_pmux_read(unsigned int rcwsr, u32 *val)
> +{
> +	const struct fsl_soc_pmux_mask *pmux;
> +
> +	if (!soc.dcfg_ccsr)
> +		return -ENODEV;
> +
> +	pmux = fsl_guts_get_pmux_mask(rcwsr);
> +	if (!pmux)
> +		return -EINVAL;
> +
> +	*val = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[rcwsr - 1]) & pmux->mask;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_pmux_read, "FSL_GUTS");
> +
> +/**
> + * fsl_guts_pmux_override() - override pad-mux fields of the RCW
> + * @rcwsr: one-based index of the RCWSR and RCWCR pair, as in RCWSR12
> + * @val: the new value of the fields, in place
> + * @mask: the fields to change
> + *
> + * Only the pad-mux fields that the SoC lists can be changed: a SerDes
> + * protocol is changed with fsl_guts_lane_set_mode(), and the other fields
> + * of the RCW are refused.
> + *
> + * The fields outside @mask keep the value the status register shows. The
> + * override register is written and the status register polled until it
> + * shows the result, as fsl_guts_lane_set_mode() does for a SerDes lane.
> + *
> + * Context: takes rcwcr_lock, shared with fsl_guts_lane_set_mode(), and
> + * busy-polls the status register a bounded number of times. Does not
> + * sleep, shall not be called from interrupt context.
> + *
> + * Return:
> + * * 0 on success
> + * * -ENODEV before the DCFG block is mapped
> + * * -EOPNOTSUPP without a DCSR mapping of DCFG
> + * * -EINVAL when @mask is not made of pad-mux fields of the register
> + * * negative error otherwise
> + */
> +int fsl_guts_pmux_override(unsigned int rcwsr, u32 val, u32 mask)
> +{
> +	const struct fsl_soc_pmux_mask *pmux;
> +	int err;
> +
> +	if (!soc.dcfg_ccsr)
> +		return -ENODEV;
> +	if (!soc.dcfg_dcsr)
> +		return -EOPNOTSUPP;
> +
> +	pmux = fsl_guts_get_pmux_mask(rcwsr);
> +	if (!pmux || !mask || (mask & ~pmux->mask))
> +		return -EINVAL;
> +
> +	spin_lock(&soc.rcwcr_lock);
> +	err = fsl_guts_rcw_rmw(rcwsr - 1, val & mask, mask);
> +	spin_unlock(&soc.rcwcr_lock);
> +	if (err)
> +		pr_err("RCW override of RCWSR%u failed: %pe\n", rcwsr,
> +		       ERR_PTR(err));
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_pmux_override, "FSL_GUTS");
> +
> +/**
> + * fsl_guts_pmux_override_supported() - can the pad muxes be overridden?
> + *
> + * Return: true when the SoC lists pad-mux fields and the DCFG block is
> + * mapped with its DCSR view, the second reg of the dcfg node, which holds
> + * the override registers
> + */
> +bool fsl_guts_pmux_override_supported(void)
> +{
> +	return soc.dcfg_ccsr && soc.dcfg_dcsr && soc.data && soc.data->pmux;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_pmux_override_supported, "FSL_GUTS");
> +
>  static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
>  {
>  	struct device_node *np;
> @@ -579,6 +690,18 @@ static const struct fsl_soc_data ls1028a_data = {
>  	.num_serdes_lanes = 4,
>  };
>
> +static const struct fsl_soc_pmux_mask lx2160a_pmux[] = {
> +	{ 12, GENMASK(29, 0) },	/* IIC2..SDHC1_DIR */
> +	{ 13, GENMASK(29, 0) },	/* SDHC2_DAT74..EVT43 */
> +	{ 14, GENMASK(10, 0) },	/* EVT20..IIC1 */
> +	{ 27, GENMASK(7, 0) },	/* EC1, EC2, USB_EXT, GTX_CLK, SDHC1_DS */
> +	{}
> +};
> +
> +static const struct fsl_soc_data lx2160a_data = {
> +	.pmux = lx2160a_pmux,
> +};
> +
>  /*
>   * Table for matching compatible strings, for device tree
>   * guts node, for Freescale QorIQ SOCs.
> @@ -606,7 +729,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>  	{ .compatible = "fsl,ls1088a-dcfg", .data = &ls1088a_data},
>  	{ .compatible = "fsl,ls1012a-dcfg", },
>  	{ .compatible = "fsl,ls1046a-dcfg", .data = &ls1046a_data},
> -	{ .compatible = "fsl,lx2160a-dcfg", },
> +	{ .compatible = "fsl,lx2160a-dcfg", .data = &lx2160a_data},
>  	{ .compatible = "fsl,ls1028a-dcfg", .data = &ls1028a_data},
>  	{}
>  };
> diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
> index 8d5ffb985fee..ae245afeb7b9 100644
> --- a/include/linux/fsl/guts.h
> +++ b/include/linux/fsl/guts.h
> @@ -142,6 +142,9 @@ int fsl_guts_lane_validate(int serdes_idx, int lane,
>  			   enum lynx_lane_mode lane_mode);
>  int fsl_guts_lane_set_mode(int serdes_idx, int lane,
>  			   enum lynx_lane_mode lane_mode);
> +int fsl_guts_pmux_read(unsigned int rcwsr, u32 *val);
> +int fsl_guts_pmux_override(unsigned int rcwsr, u32 val, u32 mask);
> +bool fsl_guts_pmux_override_supported(void);
>
>  /* Alternate function signal multiplex control */
>  #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
>
> --
> 2.43.0
>
>
>

