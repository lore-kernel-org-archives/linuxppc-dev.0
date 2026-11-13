Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B2606A8A7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P7FLcUmE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR9Hj3n0Kz2xMt;
	Sat, 14 Nov 2026 08:24:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794605057;
	cv=pass; b=gcI1iJNQTKnj7APuZRRtyAc1OJiyPSWhMRcviNMfvZHM2DwdeBgIVsCAtWPzRk/84MSUdAhCx53L3tTeFqCgIaApQVdypl9mv/kL3i48HQicSbISaEpTaqOHz8PGK7PDqcpysgNKWV4Qrp4+BHIY3aZlMKVIAmLleLPN1NM1UfyxLDHQw7KKoHhaBjQyWLlrxE0BgXURacxPBcwTSMwV01QxqH6m0S0n566BEAPE14dvqkdDqtZHTta+dzdORhaeiIXCgQxGgoBedpG8gJ956gdh1x3gYpmeMsQGOq939DxEYV1Y9T4+XbCUZTBZjZAuh2pHoEswaM7SdhgzcuSM0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794605057; c=relaxed/relaxed;
	bh=L3IoJb7HDLDoDil1P2ra2A1YD3NUlgh5fDCWdFjYYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nBY5a0yIxerl6X7reEGuBvp4JZyUXn/1o2eIYQjfphVJW8UVdCFYPRPwlg6oTgNuaOTerHrynkSura3+oEV2ae7tuXNEpLWBSW6kvG6Sdf1rb2JPUYsa01pDApkIXhi/412fZ0XJK3iJ6fcyxaPom4nwPnZw6Y0kZ1ASvSyiEGbCpDLS+FVhYfW4UykdEm4vqXRYsEbaBVvoGmcZEbWMtLMIF2vROxq6vlZW3z98AefZ4dlxBaIUTWg8hy/CleqwUlQyPkFKfhJ1fwmm0aX1R7J3MBs5K4ZIw7Wt0IJhMAUqDQyjAL6yfUO0+0wSopwe66C9Irc/a/czog9lPcH+XQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P7FLcUmE; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P7FLcUmE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR9Hh3XVvz2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 08:24:16 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQmoOKl0i3P13DLpMrJmxpY1KPqdqVZbK5CPhkd6GMC7UQtbpJblA2e9GpzG/cagAgghn0fEkyYUyS4XGV91AHL8nLKvzy0sFyuCT1KCcpUBjObS91iAzjcPbMHWIh3GL7+1DN4KQ3alUbgR2LzhFyWKdPg7tAYgrTp3p+d1hwhByMq1aLdM+cMegNod9GhYHcC3r2PvtEA3G8xIxktSQIKtRZKtBMS7YE138F6Gp39DtfeC2hTRqwnvb+sCzl0GnQFVZdgvjiBJr3xldcZkrYwJoche4YHLnKQHv7AwtxKwMOg1LxGqNrRGEMHPRSK58olKbm/c4cp0Tl8E+TakFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3IoJb7HDLDoDil1P2ra2A1YD3NUlgh5fDCWdFjYYpA=;
 b=jyZO27shQOo/w/MoK94C9DTADTmUzNO0PkH14obkmd1Zp6PW7OyawmKM3/g2avX9aUWSLYmgIg77aVI+AlNTy7mq/0raQbTiUA9Du1QNElIcpO9ZYNRjr3/OZxWr4b9mWJPq8BS3mVNpestng2IWSAOsx54OzMt87H6Q9uqKPu47zrHrmcOJCN5n49B7UkZ/OF83HS5IlIfMoVerQPL0BrFhHaDQSLP6Luga2mIKV/oNHbas5hqQNLk4VZcP/f8gcec6UbtS1pIB6suCSmGDwlJTVNpCeNpLZneyVus2Ndg0F84H9Vat8nLBxQ4p7OfMDgQ5xVV2AzagHjrImTTrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3IoJb7HDLDoDil1P2ra2A1YD3NUlgh5fDCWdFjYYpA=;
 b=P7FLcUmEPdHZynl9jAfd2npbXLh5jRqh7I1xMQOL100N/ULUBbF8DdoaVE2bIEtXWXVZMk0q7jPtwk0L9P6TYIksUMtq45oElABVsFZS3ndNrrbNqTbXhNwMANu0xxL2IT9vIrIJEK4xvrOlRMyhoHMBKHWYvfzhzXr0ThEhkyryOVJgtxI4HKAj9QB9xkAWB380FtVlOWyhyEFVTGNvWRuDv38oDzUfQtcP21xMFNjKxUni4M9K4LN8QY2zYGOL1v7J/yCoUhNY9fe+3hl+gS/kC+g5HPMHDhm4VxKrmPv3dLeTzav23EqKNTurRaYuQx8p/nHooo0YrTQisGhjfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AMBPR04MB335523.eurprd04.prod.outlook.com (2603:10a6:20b:7db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 21:23:52 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 21:23:52 +0000
Date: Fri, 13 Nov 2026 15:23:43 -0600
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
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 3/5] soc: fsl: guts: add the RCW override of any RCWSR
Message-ID: <avd_3y9V5UsOKiyu@SMW015318>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
 <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-3-5a0063f1da9e@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-3-5a0063f1da9e@free.fr>
X-ClientProxiedBy: DS7P220CA0112.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::9)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AMBPR04MB335523:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb45395-8aec-4cca-8787-08df41cc6a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|4143699003|10067099003|261102123227099003|261102130727099003|261026140227099003|261022105027099003|261026121527099003|261022075727099003|261021121427099003|261028144727099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	THfmviQJftnJuolLvwuQBU18cxNk16zKP1zYeSRpXsJJEdMHJc2v9ibktPrFEwGG2+tPdZyDA2kKHaEl2ckG38mlg8VuYDWNhPANJ/zzSTYBWWDjt18I3eKyQ+TYlMcD1E2w9zi/Onq1XTq2OJ+VfbFSPsDDfK44iP7G6Ryjgu6gMII53T8gk7DSto0JFuG98g6EpDwHZbjQ1riFEIqSFG3IZk5rySExXtPeY6VNmE4c601DlUy2q2nhm9iQ9Li2o3mQ03B+DH/9C4H/L/jJ1vEUZAJjmgJIcqmRVv14sO5Yy5npaF5MY3HtwJU/lSvn+f63l/nGzFerRGY08cqdLKh9l5DpypWHWgw68LggFBjYhiJb/m6DRTBQPjNPh+RtLY9cJm7X9YuEYpXCTC9sz2xUN19KqYRfPqVeCl5AU+agUo/aWx3pkHAmRC/ybl/+ZWlictZCu4gtjYooUiYYVSNG5dQZuIm7e3yJpbPWhyXYoqtTRiAr4I+cs0DurLUcjPfiiieMDMZOQ6YHDhczMG2o2BwZdLGJSMu8ItfEOeakyzUk160VSG+J/JMGQZ6lWT4VUXYhtICyWI299tnulk7npDJKMqm8pWvUWMHwbbYyD5LvFJxhUOwA0f0zEU+odaiETEj/6uDNQExDM+3oTNkClgLTOdUzZ3BDaxIYAvvr9TOBowJiPWw1r6NARaZcDJv7+Y68r3T9NLlW/TmDaOIk+M2SKm+pAB/jMgklFBGNuF9rE/PYBO/Hnp5Fw6yx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(4143699003)(10067099003)(261102123227099003)(261102130727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021121427099003)(261028144727099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GZWtPU/Xt4MdBgy2KZCsbeeXVrZb8B3CE7P7rqHzVL7JCVYXRaD5Vu3/yYBf?=
 =?us-ascii?Q?G7AB7OT6l9RzOOIbGhSwHyVolomKiqq7rTjbuopUc92ljK4n+q4ByYhnsr+L?=
 =?us-ascii?Q?g7RJSd0nLw7lQ/pSxowHOcuNe/7qpEj2faEWtPCp+rZdsjr65L4fmbvWV6Vt?=
 =?us-ascii?Q?+aLL5eYUyDlRgnVKaMErHAvJ9JQGAb89HiISA87nFXFDT1RVQu1j0XksvFqx?=
 =?us-ascii?Q?gTQPi9Unkctlru5Du3hBehrM9hop7sCSKrhdc+VAa9nGfVA+ZaUvI6ww7atd?=
 =?us-ascii?Q?ZYxsGcZW3cTVd1xa3lF0U0q2nY7Fa4qQGKwlqInr0rOqeYREx2QTJITkSuuq?=
 =?us-ascii?Q?snvxSW1J+3gohuXkS8QKyrjt+Nr3m5VTK2nwS+lu0hNYl3Y1QFGHA7383R8d?=
 =?us-ascii?Q?BlUrJ7LyNax4Q5mTJHiVcleUGPQtT9VJciz3lWnwpDvozmK0pHrJkBSVRGa3?=
 =?us-ascii?Q?ERZpW1a2pNuoEwPe11m8Zl4O6x+nfI/cmAAeUC37ZSc2JLl0ZH+WwC8xOqg7?=
 =?us-ascii?Q?vO7aNNU8YpQv5rxVgnZ5OhHffNgxm0eDSR3a1V8QOhXKqnw8bdivoB+g7tuB?=
 =?us-ascii?Q?2sn/n7tNYwGsQKROauWX7lk2bvHyGBWU3cpPe+T/WRFl2OrwZyRlbTZB5tpM?=
 =?us-ascii?Q?gLypldf2FVxk1g7Acge1BVy2UWilsE0WWYGraFbJwCMPvQwJNsyASHx6+ezI?=
 =?us-ascii?Q?ZHBiPHgfwSu+kejpspOMRgeuUEg7zv0B/md8y+Ee3KMDczPPnF6VwSSB2IXE?=
 =?us-ascii?Q?9nicodLvRlwZByDi3cUwG+SyZAvF/4a1E/97/hyEmBTao4Mq4BMfAR0Qk5Z8?=
 =?us-ascii?Q?m2YdZBYAeM13uyDc2c0AxAf0AJTCydj8cS5fkgu2vkLI92CyEEt6GSDufqSn?=
 =?us-ascii?Q?9buzGNLtSebMAMN9YyzGL3rD7MQh4PzAQH+2mnmjhd7zE0l/B7d2M9eLICTe?=
 =?us-ascii?Q?65IAA3YK/qeWBg6qpstiBqqyHMsl75rSO71VJMkxZKcKBj+DBcFf4gHIDnJY?=
 =?us-ascii?Q?la12aYimeypv1SA9/aebWuuf3AikFBUKCppGM41vXEIgTaOmpys8BuAsVkBX?=
 =?us-ascii?Q?CICiAjSeLu59y96T6hKG3mqM5gUKqS4FCao4nXe1rZDPHYzGij+IQsAu5CRR?=
 =?us-ascii?Q?DCqFvvwoWxzUgIX7vHz18Xh7zNMPLeAOIoX2BHzPBsDGKUAbPI6Sez9WQexG?=
 =?us-ascii?Q?/dvX10khW9EKwCRBGi2AZJXJvKR12FFGBcZyheBYxijTDd7wQSCEy2QOUBpY?=
 =?us-ascii?Q?qzgcSeFqI/rj24gtiBXptYBDfLYBUSu2kHORrzkC8PMfZ/naWGLxrxRQ4ZD/?=
 =?us-ascii?Q?pP3VztnLljJC+GAlMaCDvoZvMGDQn4t9dbnKZRqDR7SeAQH53ax2srL/+PZm?=
 =?us-ascii?Q?jcEsPyeqBtSGmC2PEXi0peXVEd2Fcx6r+bY6aXLc9rpmg852ztXX2kVFXNdG?=
 =?us-ascii?Q?z/CYQFkShNwGIECrr7Dff1Uz6APw5KZesTL5zP20s3bwGXqphJoCpA68NC5d?=
 =?us-ascii?Q?aAQGZXZYB1v3AsvG2PtcgnjG/llcaox+tY94RHPJ/BU5QV+TKt2BzZLNmhfz?=
 =?us-ascii?Q?3Gl5mbfMlNiE9JFYu3NoOO9GWIZXhaR5COimwLj7uais4UKz+AKiVBP1NNrN?=
 =?us-ascii?Q?R/mCvYbb0A7xlQhM7IeZr7FO1iLD6G0snzUR5KjSL/1kO/23T5Rw+ugi0R51?=
 =?us-ascii?Q?F6YugYHqiAqdqLAaRhM/6xuBk269elkNlfEvDl0b9R0ZQwPf0VxR6hmjwCXs?=
 =?us-ascii?Q?qQnvZ4YrXNm0KTdabTHrT4nU+qeB7I2bo15PuIwFoj0OPn0A0fh3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb45395-8aec-4cca-8787-08df41cc6a82
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:23:52.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezWjMk6NJUNKENAVMfqDvlsDUE3cswIpL0epwvsX7/BVuvthI8uiBjKcoc4M3aVSgoxvpdKoo8hirjC2fRCZ2dADHI6+irZdHesOh/1xlPhnkU3s1dpMxLADxoy4m7m3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB335523
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 11:06:51AM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>
> fsl_guts_rcw_rmw() only serves the SerDes lane modes. Export it for
> other fields of the RCW:
>  - fsl_guts_rcw_read() reads a status register
>  - fsl_guts_rcw_override() changes fields of one under rcwcr_lock and
>    waits for the status register to follow
>  - fsl_guts_rcw_override_supported() tells whether the DCSR view of DCFG,
>    which holds the override registers, is mapped
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/soc/fsl/guts.c   | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fsl/guts.h |  3 ++
>  2 files changed, 76 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 28361c63e26c..d2e3f66d0da4 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -369,6 +369,79 @@ int fsl_guts_lane_set_mode(int serdes_idx, int lane, enum lynx_lane_mode lane_mo
>  }
>  EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
>
> +/**
> + * fsl_guts_rcw_read() - read a RCW status register
> + * @index: one-based index, RCWSR1 to RCWSR32
> + * @val: the value read
> + *
> + * Return: 0 on success, -ENODEV before the DCFG block is mapped,
> + * -EINVAL when @index is not 1 to 32
> + */
> +int fsl_guts_rcw_read(unsigned int index, u32 *val)
> +{
> +	if (!soc.dcfg_ccsr)
> +		return -ENODEV;
> +	if (index < 1 || index > ARRAY_SIZE(soc.dcfg_ccsr->rcwsr))
> +		return -EINVAL;
> +
> +	*val = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[index - 1]);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_read, "FSL_GUTS");
> +
> +/**
> + * fsl_guts_rcw_override() - override fields of a RCW
> + * @index: one-based index of the RCWSR and RCWCR pair
> + * @val: the new value of the fields, in place
> + * @mask: the fields to change
> + *
> + * The fields outside @mask keep the value the status register shows. The
> + * override register is written and the status register polled until it
> + * shows the result, as fsl_guts_lane_set_mode() does for a SerDes lane.
> + *
> + * Context: takes rcwcr_lock, shared with fsl_guts_lane_set_mode(), and
> + * busy-polls the status register for up to RCW_TIMEOUT_US. Does not
> + * sleep; must not be called from interrupt context.
> + *
> + * Return: 0 on success, -EOPNOTSUPP without a DCSR mapping of DCFG,
> + * negative error otherwise
> + */
> +int fsl_guts_rcw_override(unsigned int index, u32 val, u32 mask)
> +{
> +	int err;
> +
> +	if (!soc.dcfg_ccsr)
> +		return -ENODEV;
> +	if (!soc.dcfg_dcsr)
> +		return -EOPNOTSUPP;
> +	if (index < 1 || index > ARRAY_SIZE(soc.dcfg_ccsr->rcwsr))
> +		return -EINVAL;
> +
> +	spin_lock(&soc.rcwcr_lock);
> +	err = fsl_guts_rcw_rmw(index - 1, val & mask, mask);
> +	spin_unlock(&soc.rcwcr_lock);
> +	if (err)
> +		pr_err("RCW override of RCWSR%u failed: %pe\n", index,
> +		       ERR_PTR(err));
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_override, "FSL_GUTS");
> +
> +/**
> + * fsl_guts_rcw_override_supported() - can a Reset Configuration Word be
> + *				       overridden?
> + *
> + * Return: true when the DCFG block is mapped with its DCSR view, the
> + * second reg of the dcfg node, which holds the override registers
> + */
> +bool fsl_guts_rcw_override_supported(void)
> +{
> +	return soc.dcfg_ccsr && soc.dcfg_dcsr;
> +}
> +EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_override_supported, "FSL_GUTS");
> +
>  static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
>  {
>  	struct device_node *np;
> diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
> index 8d5ffb985fee..7127de897c23 100644
> --- a/include/linux/fsl/guts.h
> +++ b/include/linux/fsl/guts.h
> @@ -142,6 +142,9 @@ int fsl_guts_lane_validate(int serdes_idx, int lane,
>  			   enum lynx_lane_mode lane_mode);
>  int fsl_guts_lane_set_mode(int serdes_idx, int lane,
>  			   enum lynx_lane_mode lane_mode);
> +int fsl_guts_rcw_read(unsigned int index, u32 *val);
> +int fsl_guts_rcw_override(unsigned int index, u32 val, u32 mask);
> +bool fsl_guts_rcw_override_supported(void);
>
>  /* Alternate function signal multiplex control */
>  #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
>
> --
> 2.43.0
>
>
>

