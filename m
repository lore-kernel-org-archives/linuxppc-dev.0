Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A7606A326
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WgzBv2q2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJKVH4Fxmz2xjQ;
	Tue, 03 Nov 2026 05:09:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793642983;
	cv=pass; b=eirwrYZ9ufBnTpUvpqdDxPPyWVKmJgoFWsadQ4Hnaa+PQghKLWLPRpuV7GApzg6MR695SMKia4aELh3LB2wb0mWADn3q5OE3CIT0UanJn1MFVxTNKbDmL1vjE0eOW+XYDQlAGm5MojrDIzsmeWleb6KhIWRXK8yzNI/WTsaVCY7EqdzzCrXkqlLNlYq8yiCB99lGqL/JD5dNGu2/srwwu0GNqSIcwB6iXLwJi1Fv5D7BtIpSahpER8xW35I/lIFRKWIjG968zqb2FbLLucImliTmbeYiJccdWDkUc+Y/L6JDeYxN93q6ymsBG2pCvJlQmR0EN1FxiYOEeqqEEp6GNw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793642983; c=relaxed/relaxed;
	bh=hiQeECdH2uRxntetH/OLHd3qrLA+fdBl+S4x/mF+g4U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZtWRIXcrx5lcrCQLYwzUFBjuzy9H9dnnO3oJnzDFt/Uq0FyBejw7lIj7RztwhyocsKn+AIueUWu4WJM3EfTtJwbOGqXT0USidVt1vBpNJ+gS0JWbUO10yNcN2sOROPWQTHDR/b2urOjiB5NEA2iqvrZJyhYCsg/W+g0qAB3eNu6Eejg/6DdZFCxjlX5auBPkXYBeG332cKsSauHkXl+U9ZD/KyTih/UEwAde+wGFGy/L5Qi4hy5C7o85cRJG1qQcdhlLWBV0TpPgKOx1P/opdgXVBdMWjGacMsS6vP+XrqqvsmdwHhG52jOOPkGpOhRmQlcNXwNwcIWexZAPYh9SOg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WgzBv2q2; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WgzBv2q2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJKVF6MmZz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 05:09:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1gg5DNK/G4nWnvSl0ImatAfKux3vQSyzboG9DvPVwIiUo+jJoEk35FNgcCJ5aAxM9YacjqkWifvH0IIas3HZlQddOxO77zXun1GXrnv0Birxj+zhEvH5zrLXFpl/aqpn1pFXuikwGhobgc5T9PnHYAq8Ng7jkOHgoN/prDXI5e2hWQT+f1vCLgCuJ6E8PvecHMQPY4muSXPcZ4qXj7WUx0c4basQRg4/jXhruNRkYwkKGNBvhrKbhnKcjvRUrR6f7lYE8tLOCxnoKF8jXn9icUIZbWczmhaBYOGuG3N6D6MBJE8PXYvY48Z5j3/ATBZHShJ6OjCua2fK0FdjqRIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiQeECdH2uRxntetH/OLHd3qrLA+fdBl+S4x/mF+g4U=;
 b=QuMhi7oZCO4N2vMlUvLWhr8h3zHc5h+8dvBHgWpT7smtQIyVmDTFv9j9gm91OPephtucsprlgPgycWFGRD4ClCQZ5je3+fY3zwfD2kcGAYHuJySlHPspFQUOUn7a1m5XeMBai5Wy2NxXkfVJ34oo7j1q90TsS6GWGvWfaZUwH/lAr2Yq+d6Y5cv9JzMilw60CLRfRHnp2kqURhELiAs6jbFjrpyHJEms0cAqLHRqhCbEO7zslyeEygMEGuskHH0xu5cbV0nonTe9nrpzBMkrBiXqO5WVbBVJ6EfB9E0VpM3QauhYR3i0ZmDC7ORD4Pv/n70f8jc2HqDQB50VrKODkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiQeECdH2uRxntetH/OLHd3qrLA+fdBl+S4x/mF+g4U=;
 b=WgzBv2q26zh8XeamYM9RK0hXwOj0pMxj3mvYLQp1rZ5eNsnHtT1/mjUxntEuXkf0QysvfNyhA37yWcIwZFdl8ZksOnwjp8cGRpgOdeMSmGsPBYfgFSCDZxJ8NN6yhAkvZb+rUfvVAhx0h8IJ0Q0TH2FNHWX5hMohOSElO8XpZhLjvjCvJF6mh0wjUwtGH/9v88WIjqnDxkHIEfiECIHE8LSLusdk1EZvA6kaBUgx/kuDGU9fzeeiGzISmkZasYQ5oh8BRGv4RcaxPftf5B0OI6CHwdpZ+pLHk8KIZ0DtrewGs4LezTBn7l1i9pMY00s1SRCCsj+yJ0hAtfTjJStNFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:09:23 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:09:23 +0000
From: Frank.Li@oss.nxp.com
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Frank Li <Frank.Li@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tianchu Chen <flynnnchen@tencent.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR & FSI AUDIO (ASoC) DRIVERS),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] ASoC/sound: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 13:09:08 -0500
Message-ID: <20261102180915.3981805-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:510:f::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: eafc58e2-6960-4863-0282-08df390c6c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|23010399003|7416014|1800799024|10067099003|261102123227099003|18002099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|261026140227099003|261021123027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	0d0aLwHrkRsLiOInjPkVbjaygVYo8Ru17wEu/XkArWZTL+7wk+yKJbYXZ2Hq8QZX5rlePQ628RHeauLSwTICNwMx9fJRyGFhyKk4XylIosd8lNeDhd5CmLwEg1bK0B1UFHny/teVxCfEeKLWZ1BoTJMn7N+xqb0hY/ZMaKOZtWzd0Q1mTaGDzC1i9j6iSyh7emcetIIz/YPu60L6sWCc6GGlEw/t5wbxkNzu/i1fsZ5rZPFmLKInYx2F8blEGk5Ynpr0KuvjsUkR1ccM4R6fDZAGRmxWBelYOw8bMDBbgxxtIy2B3+YBW4lPfHrT9g7aSTygKE6P//+KS79q9n04/DuHfeAtJeSh5h4VfsFy+/r9nOciCrgr9fCrAZOupTEPva+JhlSlqdDmQbrc0dgL15gdeNGJNeIyVY7CyDz5CZSKpQTg+DZJBKQmATIPaKkd10XYfj8K3Yu+EhQY19v2ElOeuASHcQzkiiUXYLWO04RuOATPG5LDgcAV5P43H843MSf319gz+gZfqnNIyFF/wD4KgfBzf1J9A09jhbb4ghT67FKU/u+0axo3Haa6uQh8/w11CJeQUz50kavz9d9YoY+3YhT/ZnpxeFBRrciKWQiDbZ3EJ7ySX3c5R/JdfGX/87e0NZ5TRP24kpWj3pDzB+xkM3EynMr0K1uyZ73pWFr3TVkLPIoqLiENWqSFMFJg/RCqeqVotNZ/h8YEnBYN3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(23010399003)(7416014)(1800799024)(10067099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?75i0AYNNqMBZ9if+4lDiqlBv1epaXSv9qjbDIPt5n1ye2e7UuGwCNdRrWTq6?=
 =?us-ascii?Q?3EWkw3EBZU7Jcg3RGGJH2cLfyTq2RHWELwGLNvto5sQAv5AyZbAh6YnopMsu?=
 =?us-ascii?Q?5Aib0/mDYeUS5RGvN1E3X+6MbILib7cZ/66CosebJRhl2oHCswK7W8L1mQZi?=
 =?us-ascii?Q?dQUoyzhRl+dH8r/+9uso0v5ukHDh+O34NjmrJDj/DvnR0Wy8ZSvXQLn4DlLF?=
 =?us-ascii?Q?5y4Y5KJDt2TF33V1jKbtXa6Xw4COYVhZXCitz3l7S3YyWtW5u+UhZhy/L1Dj?=
 =?us-ascii?Q?tbDwZuwY5fgZ5DveKpoW5JdGjk4wrvRaBocqe7OaJjVchyMgRybOEsUJ7Bxe?=
 =?us-ascii?Q?zqZ9oYRSmkIu8duOu73iRJmF9OVA8yoKi7ZSsHYiSqah9VbiYoQ8VLlM2yal?=
 =?us-ascii?Q?CucxEnjivhLjIU5RpFBKzSACZxSso9wvbMyfWAzYA3kxcbGLqOvYMzzBZsT4?=
 =?us-ascii?Q?cnjpLjemA0Lk+JoAxui0eyLX63jxmuu1V3f9+dDwQ4ARzuZSt3DpX5YmCrVi?=
 =?us-ascii?Q?5dOTJC5s2hhiBJc70jxZGElzFXY9EPF+V2w+EOO7xyGSnQDwnIjoV0ikLe+H?=
 =?us-ascii?Q?qVv6P5GUamTX70QGOuRRuwC2VJXtcnUAkD1mnwW0QxOK7o0Q9OT0TSgu5Ho8?=
 =?us-ascii?Q?BpFMh3JN0+UrGhJ8alk0ojX6GLjSmVuW15cBIW9C8OE/9sN65Rci9L7BF7DX?=
 =?us-ascii?Q?7YkSjsOZ6F9FlfPbBO07YpaWaJjWUYRLSjdI7nIypmpJXvXxyi207adVUaMn?=
 =?us-ascii?Q?26pM09l+FvNgrpffoMcTL6Svz0/8B+V3TjCTcrx4BnM4Zi70VmP9nuknqgqA?=
 =?us-ascii?Q?SmSABZib9bbx85JiyohVP5Vy8lOxKJXTS3f5sZGH+IeCI7OBsKWxxPL/oBwn?=
 =?us-ascii?Q?xBWiWde9aKwWbXKmk7KKn3XscAQs2a65BTIFh8IpkGOxbb096/pyhfc4tMGa?=
 =?us-ascii?Q?p0TkG4Xry0UkxjAfDpnFsYVz5qzWiBBriJMMvDWB6SnmjnVhaRuao5zdxGgH?=
 =?us-ascii?Q?ioNMyVOju4CQAymVVCrsT0L2a5sQ1XZ1GvhOpnW7pP2lt/a0RqKTrt2TkZs9?=
 =?us-ascii?Q?+BrirRmnL2Gss/cemIUdP3wZj+/Za38t+4SLIZ6Or/vIoR1+dA9UbIyDTiH0?=
 =?us-ascii?Q?wHYrQHvP1ZdzcFnUnDy7jm8lywqVS12xZY28Zmcl5esRC9RLWTUIn9EnhzV4?=
 =?us-ascii?Q?ToZsRQ06bWQUTpV2gElSMew2mmHsFN3utoU7g3dNKb09f8J0evZY3+3Liw3T?=
 =?us-ascii?Q?+73E7kOzDAPAY/4wwhXwFjXwGeGj8XgfkJiaH1Ba2/U/gLzLEe5HBeVXYxhq?=
 =?us-ascii?Q?00cH+QJ7jB5H2qvR1YpkUVYDV1bWaYAT1Mv26bOygluXw3q8vEIiU1fnt8hQ?=
 =?us-ascii?Q?pqo6BtZ9czgUgjGwIuMUUTOT0mV0DRgLNT1d3rRR9jaIjyRKFm1dOvTPWQsM?=
 =?us-ascii?Q?Qa+Q/ani0i+jEzwg5VrwRbzVoZo+c/NNpgxOPx6NExzWhm0bWLKmePwNG8UY?=
 =?us-ascii?Q?7DaanO/TAqw4h687JKx1Bld33P0YBu3XBiQUDo+hcHhVb3zYNs1MbEjFZeq5?=
 =?us-ascii?Q?XeH1k9Ay0fHmEfKZzwVFPH9C6WnCY5RdzFoe6LhxjcJ6kg0iWBeuO8cKYxl8?=
 =?us-ascii?Q?Sfj1+JTsgWMrYpw6iQuqFspaTHVhbvSPqNmri2OyYUOChVSBbM7HiY4VGbHU?=
 =?us-ascii?Q?HTgMAuQaA3SbR9HqBniE4hwyjX5mD9YASIYh7+fJYNFK67BfKcDd4snMu4FK?=
 =?us-ascii?Q?/V/YZgJNoR7FCIJ+NhqmufAyfITUF6iHST0nlXQSPcuGv4FUJ2PP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafc58e2-6960-4863-0282-08df390c6c56
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:09:23.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1/xqQxvBiSJDQRcrmZM3JjqpeGqnfI1bFjxetSHS9fDeDQ0vc939CIMYMRwhEZwVJ10Ix3rbmiCmQHNL4kDNQwi8/WTyFYXd+9j4aLKw80PHMFLCtvqwLWV2YSuWLT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper across sound drivers.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 sound/core/pcm_dmaengine.c         | 3 +--
 sound/soc/fsl/fsl_asrc_dma.c       | 3 +--
 sound/soc/fsl/fsl_asrc_m2m.c       | 3 +--
 sound/soc/renesas/fsi.c            | 3 +--
 sound/soc/renesas/siu_pcm.c        | 6 ++----
 sound/soc/sprd/sprd-pcm-compress.c | 5 +++--
 sound/soc/sprd/sprd-pcm-dma.c      | 5 +++--
 sound/soc/stm/stm32_spdifrx.c      | 3 +--
 8 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 1306b04be171a..41feb5312ffec 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -169,8 +169,7 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 	if (!desc)
 		return -ENOMEM;
 
-	desc->callback = dmaengine_pcm_dma_complete;
-	desc->callback_param = substream;
+	dmaengine_desc_set_callback(desc, dmaengine_pcm_dma_complete, NULL, substream);
 	prtd->cookie = dmaengine_submit(desc);
 
 	return 0;
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index b417de6abebe4..cd3bf6340b650 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -76,8 +76,7 @@ static int fsl_asrc_dma_prepare_and_submit(struct snd_pcm_substream *substream,
 		return -ENOMEM;
 	}
 
-	pair->desc[!dir]->callback = fsl_asrc_dma_complete;
-	pair->desc[!dir]->callback_param = substream;
+	dmaengine_desc_set_callback(pair->desc[!dir], fsl_asrc_dma_complete, NULL, substream);
 
 	dmaengine_submit(pair->desc[!dir]);
 
diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
index 58101ce07c9f9..c6970a7e88f3f 100644
--- a/sound/soc/fsl/fsl_asrc_m2m.c
+++ b/sound/soc/fsl/fsl_asrc_m2m.c
@@ -176,8 +176,7 @@ static int asrc_dmaconfig(struct fsl_asrc_pair *pair,
 		return -EINVAL;
 	}
 
-	pair->desc[dir]->callback = ASRC_xPUT_DMA_CALLBACK(dir);
-	pair->desc[dir]->callback_param = pair;
+	dmaengine_desc_set_callback(pair->desc[dir], ASRC_xPUT_DMA_CALLBACK(dir), NULL, pair);
 
 	return 0;
 }
diff --git a/sound/soc/renesas/fsi.c b/sound/soc/renesas/fsi.c
index 74e2ea002fbb1..fa21cf47befff 100644
--- a/sound/soc/renesas/fsi.c
+++ b/sound/soc/renesas/fsi.c
@@ -1375,8 +1375,7 @@ static int fsi_dma_transfer(struct fsi_priv *fsi, struct fsi_stream *io)
 		goto fsi_dma_transfer_err;
 	}
 
-	desc->callback		= fsi_dma_complete;
-	desc->callback_param	= io;
+	dmaengine_desc_set_callback(desc, fsi_dma_complete, NULL, io);
 
 	if (dmaengine_submit(desc) < 0) {
 		dev_err(dai->dev, "tx_submit() fail\n");
diff --git a/sound/soc/renesas/siu_pcm.c b/sound/soc/renesas/siu_pcm.c
index fd5b20b469a4a..7208514e16a43 100644
--- a/sound/soc/renesas/siu_pcm.c
+++ b/sound/soc/renesas/siu_pcm.c
@@ -125,8 +125,7 @@ static int siu_pcm_wr_set(struct siu_port *port_info,
 		return -ENOMEM;
 	}
 
-	desc->callback = siu_dma_tx_complete;
-	desc->callback_param = siu_stream;
+	dmaengine_desc_set_callback(desc, siu_dma_tx_complete, NULL, siu_stream);
 	cookie = dmaengine_submit(desc);
 	if (cookie < 0) {
 		dev_err(dev, "Failed to submit a dma transfer\n");
@@ -175,8 +174,7 @@ static int siu_pcm_rd_set(struct siu_port *port_info,
 		return -ENOMEM;
 	}
 
-	desc->callback = siu_dma_tx_complete;
-	desc->callback_param = siu_stream;
+	dmaengine_desc_set_callback(desc, siu_dma_tx_complete, NULL, siu_stream);
 	cookie = dmaengine_submit(desc);
 	if (cookie < 0) {
 		dev_err(dev, "Failed to submit dma descriptor\n");
diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index f790b959cd4e4..a810c9c8a0b5b 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -247,8 +247,9 @@ static int sprd_platform_compr_dma_config(struct snd_soc_component *component,
 
 	/* Only channel 1 transfer can wake up the AP system. */
 	if (!params->no_wake_mode && channel == 1) {
-		dma->desc->callback = sprd_platform_compr_dma_complete;
-		dma->desc->callback_param = cstream;
+		dmaengine_desc_set_callback(dma->desc,
+					    sprd_platform_compr_dma_complete,
+					    NULL, cstream);
 	}
 
 	kfree(sg);
diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index bbd7516f81954..968901ae4c335 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -287,8 +287,9 @@ static int sprd_pcm_hw_params(struct snd_soc_component *component,
 		}
 
 		if (!runtime->no_period_wakeup) {
-			data->desc->callback = sprd_pcm_dma_complete;
-			data->desc->callback_param = dma_private;
+			dmaengine_desc_set_callback(data->desc,
+						    sprd_pcm_dma_complete,
+						    NULL, dma_private);
 		}
 	}
 
diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 88863dbd05d9b..44467a25fb69a 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -302,8 +302,7 @@ static int stm32_spdifrx_dma_ctrl_start(struct stm32_spdifrx_data *spdifrx)
 	if (!spdifrx->desc)
 		return -EINVAL;
 
-	spdifrx->desc->callback = stm32_spdifrx_dma_complete;
-	spdifrx->desc->callback_param = spdifrx;
+	dmaengine_desc_set_callback(spdifrx->desc, stm32_spdifrx_dma_complete, NULL, spdifrx);
 	cookie = dmaengine_submit(spdifrx->desc);
 	err = dma_submit_error(cookie);
 	if (err)
-- 
2.43.0


