Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA1606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gO+V1dAv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb18x0w2lz2y2h;
	Fri, 27 Nov 2026 02:45:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795707937;
	cv=pass; b=P/BFle4d3GHgaLXuop1clMe/SDaL3i/gvhQJnTXj3fQxbOEeQjc+b+Vn7yE3IGgvhaE3nLyUwKobkflE7a2wxsRzgKaHEc2UETdR2Ylt8k7deTDGHlA4N7LMf0QqV1u9llEWVqY0AL4mZw5wdN1EoNlaPAgyP041Ve7I8qnih0hBgtFs2hrBmObKc/6yRVS1GUjQhNP/kosNdBuFgD0zvEcUPuwH1EjYw06/KR0OY2qIuVHFvlSaRLhasrvX0VlFY7D+6ZNdFrZyyYaPVN5GtH4z7wzsYJJPlJ5YH2S0YBpGPoLvm9M3Ixe3XU0FjlCv/ydwRAfpSEE0nt0QtzwR4w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795707937; c=relaxed/relaxed;
	bh=xrOJ0cgSrriKm78kQBfcWGcNXtRkDMCA6dGRL/7O2LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bbojwzOYSWBD2sV9BXZhWSqi7do560/EG+JdfoKdpQlyx8WBmPd8t/vzonbsABx4cCoFa+QrXwTrYi743YjBQO+4snh2du9sXElAKHQtO4AISQVd1Thrp71mlcAaWsZceRL4mbGkjuk+I4KAojUaGZwjE5t97I6raCBV2zcjaI1nIbYa84fcBqiKFL7OTnLvp1Hy42dvp6iRXiuKxQrOnixAz50623zUeaeMI+Z5ZhpJG1eAqe9nSE5WYJcZOblam78uVdmd0DXKkJfHL77w37NzSHufZ4Re815LaXq0yPycP/wF5smNypyrtGDnpPCks6gspKCB5Qwfqw8Wtc+t4Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gO+V1dAv; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gO+V1dAv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb18v5bjmz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 02:45:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8SMQPrfLI1pxp2+TdWSq6vaHYddVDPfHapC0nefouaJKX+IhcTMIrgV9kJFwP8yXNJ2F2rQuTRsALwgRDgqt2yBQ1lkYy8+wBYzQsw4xnt119aWfulGuRy5iLoZ7+i3fx8u1QW0WbXfPezeEgTG2OnjWb8ZsrsKPJJBPcLoQn8UlqAgcLG/2T4LTF2nyPbViz9m8vr7IGFeE5+/Ob2bdfsS+9NxEhtWN962ONy/cqgvRjSrQ4+40WtHlqi5mu+NOf/x2+2sTdsKyHnxSQqn2k39fObirHEQTzUY2wdWrERk4YiUpICiYxajgfKcNszxljl+wXZyjppmYVQmrDhLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrOJ0cgSrriKm78kQBfcWGcNXtRkDMCA6dGRL/7O2LQ=;
 b=ILUwuAthot+g5n6Rw8t0JWyo0IvtAGqSpKLHta1L7H8wMj8u24JHNEyKz+IrkR000VgEnAt+/+pSGuwDNr8ZSeYI5P7575PtsZiV/5xkjud28OwEoDEnTydTl5Gs8Eoi/C941Ke6cqXIBERALLyN3bv/wKW/2M8hylsKsjySu2a0RQqbiI8tFWsj96GwdGOLN5FyDEntJujUvTNz3VNErzLI4E8Y6QE+hXxsK/fwCVfkTWvosWPJq/LCKKA4O+dEp3OZl4wZkGUJoyJqXvixd29qlxAgjXvW9Y7Hbaz1z59yoZeqaqDUS1BcxmL1smKSxkS7YJZQ9SigFem9K3+S5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrOJ0cgSrriKm78kQBfcWGcNXtRkDMCA6dGRL/7O2LQ=;
 b=gO+V1dAv3CnCQKSOUgpCl96vTjeLYUyUL/9p3GbqNCk5zcge7IJehthWY/bjms0OEwNHZtDiqsL53YDhpxFfKorzqExh4Jgmd/4r63gbQRhdpA6TpF1FRzLfIy7PZ5sE580PZynDU68hcgevFf8RnrJ/K9iqAoSXM34NBpKvW0xtKoWenEQg1/RL8q3YPPmSXS70t38vyt8Vt2BK3u69LPqehOuRtfixivpGNUPgawzRf5rjtEtiGWfWFQame8x/D2nvXIahYFJju+zalBiy3/4uefX3t8gPsk7DR1lj6wNcDOoar9x4mJy1ENUTE72NMvyqPqCMtN2nNM40+V2Xhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 15:45:15 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:45:15 +0000
Date: Thu, 26 Nov 2026 09:45:03 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: vjardin@free.fr, Dong Aisheng <aisheng.dong@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v8 0/6] lx2160a: change the pad muxes through the RCW
 override
Message-ID: <awhT_zmCYqbRvelu@SMW015318>
References: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
 <CAD++jLnRWZrLfyBGGOikx_eeYXirahuB7E7yuDhB6KoSAQoA5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnRWZrLfyBGGOikx_eeYXirahuB7E7yuDhB6KoSAQoA5w@mail.gmail.com>
X-ClientProxiedBy: CPBP307CA0011.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::6)
 To MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: ed589e0a-29f4-4fb5-8348-08df4bd443d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|23010399003|4143699003|22082099003|6133799003|18002099003|3023799007|11063799006|10067099003|261102123227099003|261026121527099003|261021121427099003|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info:
	VadmA7uBFmFNQjy97jcyEJj2VnXlCefBhwYzM6cYMKedZZ21G/+pkm8wkPjkDno+vZ6eTQbezji74GT3Okgq3aHXz8PNs8/ILxveefA4s9QIRRGBP1BjzPVjdPkvwQMpjDWpa6SzDZYg+18kPjL/1Wsxb3PehuErzmJLfxMrwkXWlHYvd0dHt2/DER8E1wWD2PeaFSuQrMuWqzUXjJ4YnbfSAD7aMisTAjlVwFggq6iHkQU6KCGmxFYgwH9lA2s8pxUOzJD1YOW50yvt94TMjCzWUoiKvgt2rnBseHbGlVr3dsLNnSnYsIhV/sZChweqmPhV1RnxUQ8l9PkgllyZSDQ50H9ZUb1CB90zGCFuIlnGoxEKO22sci7/61m73yamgMKgeapwilr+1+GkPEGjLemTIklcGPWcv5eTSCXXGO//TjsxAwneEAUiirigqJYJ7oPsp8wKPuE23mJZcWZw9IxnmHoCOvJyvo8QO8i+TXZwf3AbUmK9KDZKdZMQ9upNTB+AQx8lym+Q2CmBwuUc7yMxvCg4fsmA/DEuoaSxK85XkujImV3isB0X7o2bRAnfGOa7WJ9IVfFSYhpcM4djFW+dd8yjl+0QzPw/Xvrgjaz0ur0QLDI66NtqLW9IT5OTJUV7DI/i4ZqoKfj8bmEABPG5PgtbvM+SCrPpyB4FlXAVRSL6iIg2/Vl80zEKS1rkMvolqxexJtzf51SG9/fB7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(23010399003)(4143699003)(22082099003)(6133799003)(18002099003)(3023799007)(11063799006)(10067099003)(261102123227099003)(261026121527099003)(261021121427099003)(56012099006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjFoNVZzRkZtMTZuVnpmUFF6TkRMd3AyWmxCSUY2dTBOdm0wTlQwZENEeWFn?=
 =?utf-8?B?aHZjVFF3Y0dRZTljc3hSNTh2NlZJK09tMG1XREtJdGVHNG9ta0V5TUVQbDZ1?=
 =?utf-8?B?M0ZQaXltaDV5SFhWb0RpZTNpRjk0S2tRazNLN2RzV2lIL2R5c0UzSStLdDhr?=
 =?utf-8?B?NXh0dTVIUlorR21HekFndWhUdGN5RVRQR3cydW4zb2g5NmZudk0wdHkrZ1RP?=
 =?utf-8?B?WUdESkV5c0RtK1o1TmNkTjJId21oNFh5S2didVNJbUFha1g5aXlOKzlUenZJ?=
 =?utf-8?B?RWJidW5TRnZVMnhFc2pvblBYMmUwWjRjeGZJZDVLMGhXQ1BFMS8vUGN3YkJi?=
 =?utf-8?B?SC9xeERSc0twY25Pdy9rNzZGcnVDVTREUEsvOVZrRlB1aEgyS3RHUDhKUkdD?=
 =?utf-8?B?TmhxeUlIRzhaRUl1NTU4WE5xRTAxWVNERlpXUFU2YUp2ejVPOEdLTkpXQ3ln?=
 =?utf-8?B?SDY0dkVGUG5Lb1F0blFWNG1HSW9SMnh2d29sZkdDTUdGSEU0ZThlQjBmMDVW?=
 =?utf-8?B?bWtZWlNYOTVOWUZjQWc3TUtGWVZ3S2pBS0ozOUZvQ3FVaWtXS0U4Ump2Kzd5?=
 =?utf-8?B?QkZVM3p6c0FkWU5xbTRDN0s4K01BUHJveVRYOUIxYVpIWjAxZUZsQjdLNDVx?=
 =?utf-8?B?bEdTazNQVEluMkZEaTVGZDFjdTBjdWxJQXVjTVF6MC95bW1Jb000aCtVY3Yy?=
 =?utf-8?B?N3JobXdrSFQ3emhnUHVXOVYveTViOExiQk5kR0lsZ3ZtMktFQ3cvajhzbGww?=
 =?utf-8?B?MFh4RVV1WkRnZUZBeVJvZjlGMEF6c2dpRUh2WTZ2T0oxM0ptYW1PajloYU1T?=
 =?utf-8?B?QjdKZjJsM3J2ZnZqMDFUbmppMEwyM09DbE9FWlNJNHJIMHhVZmpESWJGNWR4?=
 =?utf-8?B?SEdCdldiNHg1QzZJRTA5c3YwY09PbWFiWWZ0MGxzRWlucytnR3VRZGVWR3Rr?=
 =?utf-8?B?c291K05PZkxReExhTytQVjNUTmR1T09xSnhsek1URElSaDU4K1RaT2thWVhw?=
 =?utf-8?B?emVYei96am16RzNXMFo3ZDg3UUFtbmd1bEdtZ2FpRm1xbTlkbkxseUg0Zld3?=
 =?utf-8?B?alB2VUM1NE0vSll5VnpUdHhnbDA5bElPNURjSS9XTmlkTm96Vk4vRXhpd0Zo?=
 =?utf-8?B?UldwSWlnWS9Scm1TMmNJY1Z1bEMrYURyaHAvUDdhSVZmZkdyUDRNR0RqZVdB?=
 =?utf-8?B?RTRWbUVyY0pyaU9abTZvSEdwZHJUYmR5YlRjWitlU2pwcyswRGdHZ1RFR3lW?=
 =?utf-8?B?am9DVW4rSU5ySlZheXJJMGg4Z2lwU3A2TnMzdDFhV0JKS1N2cDdSZ0NrTzB2?=
 =?utf-8?B?V2FFN2ZFVC9meW1jWVdiQUhITVhUMjNIMWNYK2N1TlFTUDl5QzkwdGFzSm1V?=
 =?utf-8?B?YzhXR1FwY0o5Wlk1RXJpZzdpQm8yemxpNmtUK29naDJmZ3A3eEFmeC9HbWxs?=
 =?utf-8?B?M1lldlZRSWRVVlZQcFN3UEo3N0tRSE9yNnV4dkhGWW1says1Q3JWTDNNVnk0?=
 =?utf-8?B?cmNNcnVNRXZJTzJNMmtiVWdXaExxalcxY3VpVStrSjBmcnRiZmJJUG1UOGV5?=
 =?utf-8?B?ZXl3VUQ2RE51VFpjdXNnSWpESEhaUmRDVjMxRnpONEJGSHYrR2JDd2lMMHkw?=
 =?utf-8?B?WlMxd3hvSDJySzRpcHlyd2NpZFB4Y1BDK3g4SlZMaWtyRkpFbnQ1YWhjdFFs?=
 =?utf-8?B?TUZJSzJ0U1dVT2V1QWhBd0liMmJJZ05VOG90YjNVQ01mSGtLdFFodTZscVpw?=
 =?utf-8?B?ekpiUlhxU2dYTkJaZWVUSC9EM0FLbzFGSlo0WHZhdjFRMmVyMklxRXF1cWRE?=
 =?utf-8?B?TXZVYXBwREx6SGZtb0RvakV4UWVOUXdZTVJZZmVKWVQ4WlVicTRCUkRsb3Vz?=
 =?utf-8?B?UlBOOFZvbmNZTnlMNmg0NkdHVSt4R2Vhang3dkRjV3lnYTZSZHl5N3krRlJB?=
 =?utf-8?B?Vmk5TkdLWHFtbjhQQ2RIT0RBMURMS2RHWGhkSnNjRzRMbm53TStIRHBtbWpK?=
 =?utf-8?B?WHRHVGpBQkt5aXJWVWVmcVRBUHVxWGlBcjRUVXV1OGpuNmpuY3ZRWWllMENn?=
 =?utf-8?B?QkhkaWE3QWJSMFIzR2dJenZXc1kvakJla21BYVJzTStZOUgvSDFUQyt1MTZi?=
 =?utf-8?B?SE9scy9GODl0QjMwSWlQcnpMT3N1OHJZSW9RZEdnMi84OEl5N1V2T3o0OWJU?=
 =?utf-8?B?NzQvYzJPRkIrUDR2ZHRWNk42ZjBTN285Y250OUFzN090ZXdjaVdqekRLSmNH?=
 =?utf-8?B?SERmZ0RmWkVmN3BqTTV4VUVmcHRNaFgycElCS1hneTNLOTlucGdQVUhQK0ZX?=
 =?utf-8?B?eFBMcHJWbExSbVNJWnlXL3h1c1RHUS9sSGZ1cUZ6Y1NVVVduQW9sYnNvb3VY?=
 =?utf-8?Q?R+bbKLr0a4bxeZ6v1fslvIeWuBVRDHRG2excb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed589e0a-29f4-4fb5-8348-08df4bd443d7
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:45:15.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGhqCgEiuwLM+H8L0Wdk2y4cZi6sStnMejDlMHXRiuSn17eStgclJstc9BbSqgqW6NIWH/QZuQnl4Ty5cHb/G2/NzGlVuU/HhxwInr5znIp3OdbOQKoy+do623DOpw02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 01:53:00PM +0100, Linus Walleij wrote:
> Hi Vincent,
>
> On Wed, Nov 18, 2026 at 12:00 PM Vincent Jardin via B4 Relay
> <devnull+vjardin.free.fr@kernel.org> wrote:
>
> > The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> > fields of the RCW. They are read-only in RCWSR12..14 of DCFG, and are
> > changed at runtime through the override registers in the DCSR view of
> > DCFG, which read 0 until written.
> >
> > Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
> > gpio to support bus recovery"), fsl-lx216x.dtsi drives the override
> > registers with pinctrl-single for the I2C bus recovery. Its first pin
> > state clears every other field of the word: a board whose RCW programs
> > a non-zero pad mux loses those pads at the first I2C probe.
> >
> > This series reads the fields in effect from RCWSR and writes RCWCR, as
> > fsl_guts_rcw_rmw() already does for the SerDes protocols:
>
> Once the review is complete, can I merge all patches except the DTSI
> patch through the pin control tree, i.e. does it have the right ACKs?

Now I manange fsl tree, My Ack should be enough for SoC part change.

Frank

>
> Yours,
> Linus Walleij
>

