Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A101606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EO8ZFL2f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT0Gz0g1qz2yHD;
	Tue, 17 Nov 2026 07:44:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794861899;
	cv=pass; b=FaYEtb7N0xV5utUDvIzy4LX7dtiiSeTdLDFMSnXyS/diuKiAseopplu+2LjjMYAa9QjKsXIOdwVj6Ux9W2p7BptiO4smUICi+zjgAyR5H4YPFzmTDTYonlSjP4BT6qr+fUUb0B8OIrIlkcSl27Wqq5GqaiWayufFwYEmTAB1UkaobIGh0EevGqQ3FmoyFjPMOsPwxrbvEAKRdzuoAhjhH1pozUxXBE8xeaiOkk0q2DI0W3kz0z/Wx8qRk2oE+JYptWHArwJL/6sS+yue18nXUX5Z62e4tOPETAkcZne2nTJrDXdjf4hm1VKf9KLjn0+NfKkbLXb1SywmMBl+Djfbdw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794861899; c=relaxed/relaxed;
	bh=iLNRB7He7rjr+/wiaJxfR3wgdC/I+r/KXciImfr/fxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TQumIgIyOivB40B+rbB5mznwmz4A9xyyGy10RMvu8JhKPoSZVgAdNvDfm2p9aP2W56L4nl6mxVCYmkwuivtpHHmLqgsSImskLyo+hcN9cGOQPYCnVZpg73TN1g2vqn7CS1GgaUz9IzFy2Gc2vWfexYJvbc5vl2L29XpR2p0qdlOEXv/COHANV1i2r7n2OfClUUbn78HNjDwDd0VvMjCWXjRJWzSWN5DjkR8YQYF4ATOGPsuHIXDjkWHhy+u/0wt0gwxT0NOQuYpbJVmFh/qwqP7YvcspiqizJwHl89X3/8dt/Gqbdix4lyfXB6bV5/NuoJKCllKECgrJBOCTvs6FoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EO8ZFL2f; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EO8ZFL2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT0Gy1jC3z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 07:44:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrLz7EiZ9q+gpxyGVHxLSP+uqJiKdwtBTmiCJfrqzxekPZiuFQMnvBHHJDhMocEqHa+uPiJrVH/cKmUmTk9rzvcyUH8Y3Xey3GdQrNG867ZoENJon0ChIXLMQ5sZE5pph9LMuaMwY/cv1tO/PY6CiNtFX8cNFb+10jbyBby4SP0l+B7sclU8r8goTA1bfY4q+bKkf7gJZu1IkYDfnQtzYYMQ1xx1uydDir7PzjB248TF8ZiRJx7SRVwnFY5sxL0bW6heRdxNxgDpAyxEFF4SpQb3j8VO467JBef5vjTAaeeNIkA1MZGbjtIZySW1HnE3hXxdo5NoLE//VvjQNFlhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLNRB7He7rjr+/wiaJxfR3wgdC/I+r/KXciImfr/fxw=;
 b=RyXJTr1OIYtDZgTXTlbDlxC+wACEh5bpgX9gnY6fTjgB/fvo5L8sgMxao8AQDjLCmK0HaAPvtjz4JG2RcCWaN5dopr3crriT2DMpyN8fvcQgVfFXqvOT20nLwDf8rSGXUoGAz1jUkpriheLFIdM+6sMwZojgfqHJjgyIdgeAnPXn9xJkn0/hmiYFjSMZxc2h4Cm3EgOUezdcnZ6DAKanMMrlIfnEvbCjaIhhH0WbU+47w9LpiUEKWsiFkKBTT03CSfwfC2UwCNQ+TFW/EiG+WJCgKk7iZxKjK+R/g0nq7A4tyB9yIkcY6t4mv36s3Cf12f33aRpqbYQITH3RNB6KMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLNRB7He7rjr+/wiaJxfR3wgdC/I+r/KXciImfr/fxw=;
 b=EO8ZFL2fhe8tL7QxLGBD+9rmH9sxPRhJs6M1PfVxRwLNd53q0YX65ResAM8Qf9GQUx9yCYQkr/NUcT/7rpV5YffCBZdg1ZQgVQM0OYhNta6HUFu5PiS91WoW+ULJyXC/HQAc44ptmq7hLQYnJTI6ezQrJMD1qKN659uUwqLcicUe3OPhwCv/nbRz1P/BTD4cRwibMhvxyDanbdLdkR8zEhFjYyspMu8hBjTThvoJzB+iiQlKxdODKhlDzZ+40ip1l0z4taPbEWD+POjyQ/wCnkdOt07CC1YkRllGSGgzQJsJ+opT3Cugsv8V/T+HRrUa5l6hBfUnxAOoFCgyArLemw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:44:54 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:44:54 +0000
Date: Mon, 16 Nov 2026 14:44:40 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linusw@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	imx@lists.linux.dev, linux-actions@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dmaengine: convert to subsys_platform_driver_probe()
Message-ID: <avtrONsd_CZLSbdj@SMW015318>
References: <20261106-dmaengine-subsys-v1-0-780eeddbf3ef@redhat.com>
 <20261106-dmaengine-subsys-v1-2-780eeddbf3ef@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-dmaengine-subsys-v1-2-780eeddbf3ef@redhat.com>
X-ClientProxiedBy: PH7PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:510:23d::9) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI2PR04MB10859:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d88ece7-1ae3-4baa-0417-08df442277d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|7416014|18002099003|22082099003|11063799006|4143699003|10067099003|261021121427099003|56012099006|261009220027099003|261009221727099003|261009223327099003|261009223027099003|261102123227099003|261009221227099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	cnY43WBqfKOqqKx4SqwPO69BL2JxivT9S/nhZoO9pPbYpQ3VT6H33xnHt4hZp+IkJu7XcV/7fPcmZcB2Ey/P4vc0m70AtIBEVQqZstXxdc5m+TAuFszpq5UJR+PZ5VLqYcba8EULP7aET0y1KiCl1Sl6uSWuJNxf/uIStgaIk3HpzmltSOVFOeO8ApsYUPJ0gkqbtTdJcST4GtNcR+1VZjF7MjwKX6yZ78GtB4mbpkN8MW8iptwU65DM4JeDi32ctU/DiGxGjkxiFkeIXYZwqcdRFkdZyrtVkYt+5qpXEcoERbgvYoMMTifcBy/WdtJYRvnMhg7Ugdl63St6q5NExcEArYAfIcMAeH3ukBMfmkYwpht2f+YE/WcoRPyUHcoWCKibFtTJ6CtPKlD75OGi0IRwOkbOYheDyFjEMiMiVug6f0Ulylb2DUAbE34Tm/bZl4JnTudP6HHKV4FCid6VOKbQfCI4QoHHXa7+c2Kd2H8DBiuL0oFAPA2ofI2oBVd5Hc71+ftes8To/jAqpjKU3bLlJMm+QkwyJv6ayIBbW9gob6mky7q+8VAXLmIksf73BzAUrBNmPIfuR5VUj5RSRVifcl6nlpS4ciVu4r596uqSdDsyAiE0LEg2e8uOw7cnEdJlM1oH6JXsLnfj1LkPBOJowP5KbbMch76rYRob93M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(261021121427099003)(56012099006)(261009220027099003)(261009221727099003)(261009223327099003)(261009223027099003)(261102123227099003)(261009221227099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N2Mwn7HZFDeWI7Cp4MrmXlfpifI9t94uUfaU9YqFsqoKgkggO2ZxQP0FBH+p?=
 =?us-ascii?Q?fA8GHmk2t/AR010qtNh9XvHFRBoa4n0xSnN03Kg1a5gGOCfVKMIhAS6utmzJ?=
 =?us-ascii?Q?TW5yzLvAt6Ohk2JcU2eJ+6jRohoHZRPAJPU6PnTW86HL1uUp49RFt18KLTBY?=
 =?us-ascii?Q?EY8AsP8edhfGM07BiL0UlzA1653j0W9Kp0BHsBI8vQSCDwpryFcRNrGHUY9K?=
 =?us-ascii?Q?4P/HPR0HAZ3KWbSNFLKbRmGPO5EvKHtYLxi+jNA4IGX+mAktg0RhWOZ+4X0R?=
 =?us-ascii?Q?SHQaob55A1hFQ3YTd0gIlKNG7NFN7YYER/27oLle3AuOo7K3lYIPuJCEB7jl?=
 =?us-ascii?Q?HgHbrLaLuH+nwbPvXa0GV524N4Q4hbCSIldYF0rBjvcy2P5ySBa1W72Lyt2d?=
 =?us-ascii?Q?rQS1v/o4dGJlSfPoPkgqr6mvYJtDch8jTgilaNGoIJ2bFH7Tje1/8yaA2oKe?=
 =?us-ascii?Q?jKY6ZgbFLQRQlm726sQHGHeLZVEbdRrkr0dQoL7wZhDkDf1ZAHVNm0izgVjF?=
 =?us-ascii?Q?UXSspNUAVutQHU7nJ8OU9x1oUuuN034dI1t5fXLl476oe85/uM/8WJXZ4qzB?=
 =?us-ascii?Q?Rd3x0Jg1imz5Ued8C9Raqvk4UDpY2++KBeqhqscykcfBDh6co3F7H+uw6Cww?=
 =?us-ascii?Q?i98yD+U+tIxVjj7ZqpmHsDsdtmzab6Vmv12PMi0V20U/rnOenHKtNexN1x+/?=
 =?us-ascii?Q?TFbPs6NCayITXY/1aNBRWD45uI5z35VbmCUKTqLXHGC5eGHFD6LIazj0ZSzJ?=
 =?us-ascii?Q?UelYt5MvHPYecmbvLrSGqjn8jp3+SbR6FgO1D8dBpN2uYww+qkGl865ejHYX?=
 =?us-ascii?Q?RlXgDSZ/DpiQBYsJZSVY9JtT30fWonodExF2V9d+b4rzvBNnn1hcTWN1oTCJ?=
 =?us-ascii?Q?gnVxnzG7s8vQBMVvma3xK8r4G59PJ2AL2ganIcwAO2OjZxfwkKcKUbvqxvHd?=
 =?us-ascii?Q?td75bcMoYOgngjpUMH6bn6p9UkzRCJkc2Lnwv3pPkhavkDuOwrVySTWuiOvb?=
 =?us-ascii?Q?3vsxKbTtrbsvqvgApS9a4ElutiOHiWljP4HIIXWtOr847tNUrJTDoy0SVBWG?=
 =?us-ascii?Q?xj/QCV+l/I3T22ZoU+q4y+uXubZvAvnD2IR4VIBqVAAg6aZkY6TgjUBUpH+O?=
 =?us-ascii?Q?u/nTRTotDVe0VTh4Ibtie9C2bsn21QcuJ/n+W1R6mTF3Sol+3A4Ak6LCqtNo?=
 =?us-ascii?Q?+fzFUhr9Xi1VJ434dIFc34lOE0E8SkxR7AIeZDgJl57Lei4wZ7MqIw7HrTv+?=
 =?us-ascii?Q?qm+6vohNPd7myacnT/AorSjph4o18dbjIZANtPGImK0hnA3fHopwA8zv+/MK?=
 =?us-ascii?Q?TlFHYfrznieHR9a7OasJaBLMQNo738hd3UBfxYvSa4YjCLpxFoc8QM3gIbq0?=
 =?us-ascii?Q?yPiE9rg8Igizd8j1YGz9laYQa3hvPJ76D4Q9LXnoHKo+34AqDaKU+6ss/+5p?=
 =?us-ascii?Q?o/0ff//5EKAs6M0rp+GUKUTrB51UmOLql2HTR2xgQMvEXE/HXxak/Fvf6K+/?=
 =?us-ascii?Q?kovJ3vHNgsfmY/yHNtw0ZVCdV71lydVb6Twm8kqXrh5SbXqnJpCUcJbGckPA?=
 =?us-ascii?Q?0I5NpnCKZLwMCMTGVqfK1AobTRvENvFfgmtzRodGiXoW3rFJohURyLP4uHUq?=
 =?us-ascii?Q?Ah53uCP+mzIEtjnRoyluR9gYTIHYga2xLquahF8kvxhd3ZNCt4MHObnN/5DR?=
 =?us-ascii?Q?ZRZJonWu/t/uWu3/AZ+XHElBUwSQ7Rhjx3kNsRMPnM3BekvyHq6JmxavT3HU?=
 =?us-ascii?Q?7S4Y6+5fqDEge5tJNOgXx7RHrBsI3QRpbwTk5aA646IvH3QR69L2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d88ece7-1ae3-4baa-0417-08df442277d8
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:44:54.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwCdV1O8H/yj0mTMoQ1hPAwvu4smCXjoNDQZDf6o4qNcZO2rGeUqB0RMaUQTnbxOxBzOP/s6H+rUtJ1gnXkmoNzRfn95pA7mOJHNVI5POyAoWTnoCC6muNXuFtmAxyd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 07:06:09PM -0500, Brian Masney wrote:
> Reduce boilerplate code in these drivers and convert them over to use
> the macro subsys_platform_driver_probe().
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/imx-dma.c   | 6 +-----
>  drivers/dma/ste_dma40.c | 6 +-----
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index 81c6276436f8..8e0e82df8c5b 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -1238,11 +1238,7 @@ static struct platform_driver imxdma_driver = {
>  	.remove		= imxdma_remove,
>  };
>
> -static int __init imxdma_module_init(void)
> -{
> -	return platform_driver_probe(&imxdma_driver, imxdma_probe);
> -}
> -subsys_initcall(imxdma_module_init);
> +subsys_platform_driver_probe(imxdma_driver, imxdma_probe);
>
>  MODULE_AUTHOR("Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>");
>  MODULE_DESCRIPTION("i.MX dma driver");
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 2e83503f71d1..4fb54c8f2d23 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -3990,8 +3990,4 @@ static struct platform_driver d40_driver = {
>  	},
>  };
>
> -static int __init stedma40_init(void)
> -{
> -	return platform_driver_probe(&d40_driver, d40_probe);
> -}
> -subsys_initcall(stedma40_init);
> +subsys_platform_driver_probe(d40_driver, d40_probe);
>
> --
> 2.56.0
>

