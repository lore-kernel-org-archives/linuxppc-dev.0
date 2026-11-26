Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00940606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FlLKc/k7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZgfk1qbtz2yDD;
	Thu, 26 Nov 2026 13:36:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795660606;
	cv=pass; b=exlAmFlZcDJzsn6Y6fJl69CtVr0XdmGGv3gJUys+yuwJ0dmWCpazqi9o/5EeH20OzNFqwJYdczjju4q2QU0f9CSCyH/v3kS0sUV7VmMzva/s5qfIUQsAF2HouY3UjEaD6eJALLLXbshAcQVJlER0T7BtczicO3h8XjOEZ4vYjZeRdo/hdFUPDholsxfLpnLZHFC//WN6Z8sCq9QvSbJB6H65RIpOiYOEpQv5p9pQSOy4zDeGet7+WkGRMWPk0ofHg16XaPX9pHTQ82FcG1uEUx0sqaIQ8kvUS8tB706h3izkf6a8K9c5k+wybPDmwJ0mNJfwM00bQOj/3AHVoIJcXw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795660606; c=relaxed/relaxed;
	bh=/vJmvmXNB6WSgHgaT4qCAX6m2DcEYhGZj8WtCwv6Hx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VwUeQ6vGnN8lVfqxCZuEjbKkKrXwtNqZyrlUTOYAM8mV68GazUWug4Yv2jOlCU+fvgqwdrNAGjq/l6XrjUME12gWUv3X3KJxXghen2pHH+kGqvNA+IDxwegzqSDqylo+pBEcmv1TbilQUvNEjK/TQUpFfjjcQecPUqWHVF5Qg+HTc9XxZhAbVZpBSqFmskeFQo1u2W1Wur71E91sWZetQZDeHQmZINvOGUzaWJ8HkF8HQ4CQZ5QU5ROR1ku9IT0T5swRjSRzTngk+vciMg+Fp9Nj91nBEe0Z5Q0/ify+LmcW8zfftA1i0SMcosLI05FNjfL/waic0wIzZbkgBpQEyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FlLKc/k7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FlLKc/k7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZgfh6Bmnz2y96
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 13:36:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1CCP53TmwPbUJ9LD3c8GGuQ/YVa8ZJ6zQ6HElntTahC3cX/4P9G2wZo5ALO92Iy94sCpkwCzyoRdJN92tyrO56yV3CKb4tOwVNpSJCTIn9I59AFxKzKzyILx8WsaxFFyLlOziPxFKH5WMRfUldscS64BvFW6zaL8bM/JffQD3kRZ0BpkPDVeNh8Re8UgjnRpb2O9KGMhiKxs+9QZclSr8Iu6VYSmDoLjJwPlW53SmSYxC3CPxHonGOkiBmNFMEsC/s8hZsKdA25zmXaEGWZdUTJvSCP68COridciBWbqvbQhw4fJfqHZ6XjaSkGL550hChmVmgApC1mjfqpatauSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vJmvmXNB6WSgHgaT4qCAX6m2DcEYhGZj8WtCwv6Hx0=;
 b=mIowMYDqMiskoIRxLg90v7FddES6SIQUdlvsYnGF7YP8YXVLoNEQ7GuqdL+pmbi1PfEW6blpHTD9osZh7+k4/n4cDO1E5MvSpGHA0+Mmj/BvPiOAmlHvsgOX8DgZDkE9GiOkGR4LOIWrIeFGRuhK69DsTVerrdQJrCJ0HWww6JTfncA9S+2wtjIoF/ZHjeIznQ5BbEQkUcNhD+WIZCbD8D4pQ1y+wabh8pVNeAQteLTBtfX7bZfyYTu9272Kit7aH1g0zRpOeK2ptWnVvZhCNT7UatOFWuZq3GK5Ec0vDLNXmTAyOBidmqK+S+HtV5PBpevjx4Sc8NgE7rnoUUUCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vJmvmXNB6WSgHgaT4qCAX6m2DcEYhGZj8WtCwv6Hx0=;
 b=FlLKc/k7+hxOlP98wjRy9+wQZ7WbjThxG2M8otTTKsonBj5uwsunZW4F9aNfQxepwQ/rp+2A8PbhaEPCrkgw/ESFYHIV0SQOcVBET2RjqtiVPYW8+EW30ajwwnutbHBeHaUz11ZLUW1ZzWgefBFC4vI1heiG1aKaphRDlha1oQovxqhz2BpBV+XemVGfIV7S2K50KffjcVf62rRF8kM2ep3/XConk9QqqZN0Bv4oywxnrhtcG6hUF4Uh/8FXpcbB2Tdr24sGvp9MhfnvwxRgMkvFFGZBJUeb8TAykLUvFpTeI7xFjcqIhmSRFOnG3YJEWSBM9T6BxFxJpOmwGlS8bQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 02:36:24 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 02:36:24 +0000
Date: Wed, 25 Nov 2026 20:36:12 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Vincent Jardin <vjardin@free.fr>, Dong Aisheng <aisheng.dong@nxp.com>,
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
Subject: Re: [PATCH v6 3/5] soc: fsl: guts: add the RCW override of the pad
 muxes
Message-ID: <awebHKtul2FHepc7@SMW015318>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-3-fbdce4565a5c@free.fr>
 <avs4l1otw6ACW5P4@SMW015318>
 <avs9fmJqYShOIPMK@l3017729.home>
 <CAD++jLnF07h3Ng5O=xcgKhTEkV9ij2ptzktAfi2Kt45smdEjpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnF07h3Ng5O=xcgKhTEkV9ij2ptzktAfi2Kt45smdEjpw@mail.gmail.com>
X-ClientProxiedBy: CPBP307CA0022.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: c21bddd7-e2ba-4ee9-647d-08df4b661014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|10067099003|56012099006|11063799006|261026121527099003|22082099003|18002099003|4143699003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	vhHzknaGxToY60fq//4kRtu8MgOU8aTHg5mwlNhdo7FrYpr8PDZq22gPizknkgX5WFgFPA8iu1i+Ct6YaEXg7wGM/q2bO7LhahQAdPk21m8+7+s3BsZ6JtUg/yfPZtbTSSBKg35Uj2/Qs+4+eIiSOPxF27U3t+eQ+lCVlbQGR0qdyh2OZnFcLJiuNxhEwAksKlu7zw3NrkNkz99XOBWQT2sU1x3REGNsaHVYIqGNNdHRtABBssKsG0o7Y/oT96T3+euVr7859SGl/9Onu5BvTdxRtVOB5wGz3+jHFGO2ChuJXA6HoPiIIQt9dPN7qy1IaUj/ZmGMCGfV2j8pP2CgvcjLUHtzh2EawV6ZMlLccN8J/oiq77CIPP0G/xCu6ascPhcsBM6O6Rq6VfADp/nb9hbrwzfGasOhZrmy3+Dqhg3g8TD1m0wt0X0S2v1a/CwHp8qivdBXTRuziSz7RTwunnSutXXBrRpkp64nQl7nCcnXn/WuWfJuML9cjVwraHvDWlb9+Kx61HM1/7w3N39hCQnOF7iR9UxzaJO0Ii2wShw4IqxRdgfhu11NZgO9nG9ab2ANPCGA9OxEG9aq8bw45cUz14KeewZ6vtSco9WznM/Oon874tjwwNYhBAi+HXdoB3LpleLD5v5iNLP+8SAbm5KWV/Th21pdEnd8ieEQa6aesGa7DwaXERsl/aEWbfBoTFCL7D+OjTGwXZTOge8w6+uoxKEBoov9J2NRybKMUH1jAbdJCyaGqX13TM+jQVk3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(10067099003)(56012099006)(11063799006)(261026121527099003)(22082099003)(18002099003)(4143699003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVVMcktUTDZJYkMzN1BtNWEvclBmNVVSVk1qZjdLV0JxKzh6NFVaVUZVZEhw?=
 =?utf-8?B?N0Y2Z2hZVnArSHJnWjVzRWFUUmRHWk1vYkxZbXBuZzJQNWdqOTM0c1ByaXk2?=
 =?utf-8?B?dU5reCtPNGhXdE1LM1UxZndOTnU1ang3bG8vbm12dmJCT25xbFRsaUdxQkt6?=
 =?utf-8?B?RHliQmZld0dFMHdXRldFNCszMGtKVXFnV0xaeUhBTkJGcEFlMWVvMG5zay9W?=
 =?utf-8?B?Ri9Ba3JmdGJHUEJZR25ycWFmTmZKa081cUN3dDRzeUlBUFdUdHNQODdwV2JK?=
 =?utf-8?B?clpjZmJaZ1Mvcm92NUJrUnEwSnNXK1g0N3BtRTQ0cXVBMjZDV2pDSWFKRlBv?=
 =?utf-8?B?UTA5Mm5XUWxrUkNPVno2bSt4Z0FJTnR6SWVIWU1TQU8rVVdtT0g2clI1VU56?=
 =?utf-8?B?TDJaYlFKcUxjbkd5TVAzU0UzSzk2SmtoYmRIM3BMSU1ZRFkyV3JFaXpsTWdo?=
 =?utf-8?B?R2ZDdHRicWtGWkhSNjdzYXk4TWtQY0c3bEpuRHRKa1VhSFNRYmpnNjNrRVpC?=
 =?utf-8?B?emFmOFRRYVFYNVJaVHl2VDcvVFNLb3lFMVB1NzJ5YU1ENDFMaGkvR0JVZGlm?=
 =?utf-8?B?Z1pHOVlCOU5YRFMvUnhqWEVpaWxjT0MvcW52SzU3S3lKVDBMeHptZ2JUbWk5?=
 =?utf-8?B?RmphRWo0ekxPRUt3Si8wR29takRUV0l5RUlXaUNlL09yVkN5bUlJd0YxbEFy?=
 =?utf-8?B?NXhRR3JQOGpJVzJRN0RvQVNiOVVaeUxlNGVaTXBrdlBxVU9GM2xpKzNybUJy?=
 =?utf-8?B?QW9OclJnbXptRCtZWDVobkhuUUFVTlNsUUluTWNDQlg4RmpGQ21hWEYwNFov?=
 =?utf-8?B?WTN1NXluTXh5SXF2U0lJT2hJR096eE5WcllMOW5aYThoZmZDUmM2UVpWNkU2?=
 =?utf-8?B?K2liRnlYSzJyMVdBNkFpRHdPSUUvdjRaeHNYeWN1Q0Y2NFZPeTlpblN3clhk?=
 =?utf-8?B?Tk9pMlJVdyttS2N5R29qSzV0b2Y5YjJINGRPQ1R0Yzc3Y1VrUWgxTjJnRUFs?=
 =?utf-8?B?aE1NSmtURlVvMENqTCt5MlFUVEtLOFpkVnQrWGlWSEh1Sjdkb1pBTWJLWmhZ?=
 =?utf-8?B?ZkhpUnRLcmJqNS9jNHY2bnRuTjhCRXNZdzJDL0ZBckZ1OUFqeWZwZmd5UlhU?=
 =?utf-8?B?QlltMXR3K29KcVcxeGRsNWtjYnZaaTRYRm5CSlBnR3JpQWZHZ1p1QldrYTQx?=
 =?utf-8?B?R01OSFdaRGQvbGdOQjIxUFllYlp3ZUNzUWR1TEtOUWM1NDIxSENoSWtYZ1Fo?=
 =?utf-8?B?Q241aFlUcitPLzVBUldHYjNtelpieC9RL0xUSTZiVFcwWkNHMlYxV25Uc25y?=
 =?utf-8?B?L3d4YkRHQVh3eGh3ZE9xZ2wyaFhYVFJTcHR4Nk9hRDI1VG00aHVFTTI4UmhO?=
 =?utf-8?B?bFVyWWprVmlBVkZ5bVBsdXRwbjZnOGhPcFRyeVh4dC80MTNtaE5aQXVKR09H?=
 =?utf-8?B?TGVQaTU4QldjOGx6Mng5a0dydmhMNmthLzlOK2xCbXpwT0RVWmdIVjJlRnBG?=
 =?utf-8?B?N05HZ2NrZDBhZnRRQ0M1MFU4TFc2MHd0MTZpakJqQng0U0d5ZUQyN0Q2NWF2?=
 =?utf-8?B?VDNuMWlKYUFnOHFXcVptdE1QYXVwOVpWblQ4WWJWd05ndTZYZTNNK3B1b3Vs?=
 =?utf-8?B?Y0xTWHRBNFcxUWhzUWJUSGhiZHcxRjhyYjJubG9lMnhtTkVTM0JwaEpweCtH?=
 =?utf-8?B?M0ZHaEtKY0tXN3NNWllYQ0NYZGovU1ZpMlRZeHI4OWpmOVFJNytyTUZvU3BT?=
 =?utf-8?B?cnIyeHFsM0hZWUNMY2k4SzQ3RXRRVFZKbHp6TnBEdnRzSmQ1dTFEQ25KaDVV?=
 =?utf-8?B?VmE3NzByZWNFSCt5Y29EZ0F0VFNMWGdvMUpkSS8rRlVhOGpnVGNyaTBBdGUx?=
 =?utf-8?B?TVBsQ3Y2NlZlV0JCWkhTWEt5WTJVRXIvYWwwN3V5WndIbXFQb3k2UzBEK2RG?=
 =?utf-8?B?bGlMYUc4QU9TZVBHU0xOYnpVei9wcy8veXZrcUIxOUlCbzJjL0RxclptL0Zt?=
 =?utf-8?B?SG1mV3phbURoZFlydzhhbnpKVWd6ZlBLZGUvaVY2VUZXYk9Dd0lDK0xlMTFr?=
 =?utf-8?B?RWJFaWdXVXVHK240cDVsdDlwa2RHUTNmR2xISEc1aFlDQmJyeTdTUGxNbzRn?=
 =?utf-8?B?NDJBYXEyVzJvbWFaU1BqSTJCT3V5ei9ndXFsUjFDZTBOY3lNWkFTOGtheGVY?=
 =?utf-8?B?UVg4Sks2SHM4aWRwMXJoWUp3d3UyTkVObEw0TUdOMytxMGRjM1puYnlCRkNh?=
 =?utf-8?B?WjIwcWJRcmNCdGxkd1J4QjlwVnNZVFE2RUdNRFNCcHluYWZaL3ZxUGtmZkc0?=
 =?utf-8?B?a0NJVzljU3VQYWcwY2JKaG5VNTFMNnFSZThRVm1ONURjZ1FVZDBidDZNUHI3?=
 =?utf-8?Q?jBAj62lLTjFXE6DYy1c737UkcUbVtizYlpe6j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21bddd7-e2ba-4ee9-647d-08df4b661014
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 02:36:24.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMBXW+OoCcnV67RKMtPYqKSbJmoMKo5z7mUSsO2ILeQ4II3oBLo7DotD+peJqn0Oxf7a7AnvWJucAcHadxPCc8TY6bNbMdiqGY+kF9Uxd1HTrVEdjQbMiDfGytSid2T3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 02:02:38AM +0100, Linus Walleij wrote:
> On Mon, Nov 16, 2026 at 6:30 PM Vincent Jardin <vjardin@free.fr> wrote:
>
> > Then, since it was unclear for me if the patch 1..4 are through
> > pinctrl and 5 thru imx (please, Linus Walleij) ?
>
> I could do that as long as I have the proper ACKs.

Patch 1..4 through pinctrl, after that, I can pickup 5.

Frank

>
> Yours,
> Linus Walleij
>

