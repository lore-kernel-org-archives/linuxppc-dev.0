Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MMKBlt/p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSvP45YMRz2y71;
	Tue, 17 Nov 2026 04:04:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794848696;
	cv=pass; b=RjOvrQN5O9kmIVqj4FuAsrscs/28i27NDsTtSWuUDySE39goNpjvuExxvq9UcGIjEf7Plr269RmJn0qGLPVS8eJeH2uzIHqFN2JD9WFd137Tu6CJaImjtWwaJKG2xVlc7VBIQkSfkQjsL//mS/mOtoNvkQFnPe6VOMFFwdRjIvkm1/TXPc2/7wch60sSoL/KCWarGN3pjL1hLC85GKRLfbXTdEKbCewMd7jKzLyBYjA6t2oiunNgKyKKYcKSHv/RUfiHReAFplVlVQaZnkAIqtg2X5Tjp5pvd7nsEq5sdHnPoB8IAXySZNNBge3VxY6X0L9LszOcVrMS2eAVO06pyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794848696; c=relaxed/relaxed;
	bh=gZU1z6cbczq0qQqesul/axvZyJbIvIkHEJFN+PnuMDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C3LIpe+SOxA18927UP4ngLSzYP1LO3wmV5tu7E9U5BftRhp2UAa5IflkFatIEzHTJkbTgEP6mNV+sMeqhOe43IYz1T4Y7YzrdUiL5aKlKrp0Jgl86QqIWi8mL0kscgFw6/HeIiXJUipO0sD+0MKz+ltCRQzoPk83JWd3ASLlsvjePig3r7PKmy1S4AKU0axA2jcJV5ZOg//foc/Tif0MF4J2ySnlQR3yxB2n+z5ZaptI7pNzulpY0REzoObNoKqVwUKXQzGrWz4e3cWdH+sDw7XzNlmgzSyXRrAbANiB4X2VGemCQdYOI2z8Lfoo5xOyyRbyeUH9oPV4E5xZYY0uKw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MMKBlt/p; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MMKBlt/p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSvP40pgLz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 04:04:56 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC+DUZiTW0F4Xnz0b5ZygquveiCyJTgK2LdYcsQLgKpKMW3ng9V0fgZ7ZZ8QUDY9zyuQVXML7A4Ave7dsPbOfFVmV3yOHSs/o/jcB61mAj/GvhwpZjMxzSf7bS8Dqwwu8aOAh5f+xbNnydEipkamoUV5KTD9cnkO5rlnZN1MlRkDYo4izI5q8dcyxYmVNdLHFzerMgvX3LjHcks42tPqPqZf/YTijcWONjNOJwPIFdu/rLFwk7OxhLXaqK4UOK75HEPfJDV5oAyHD9hJs2+0dxyhQ+48+Jsf7kDi85kmye+/r6Xd2VEBk1H80Dc9Nx2AifCJL+1iJ0udpddEQ90eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZU1z6cbczq0qQqesul/axvZyJbIvIkHEJFN+PnuMDs=;
 b=eHBo+RT1mjwO1LOwhIPi2dGZzAZ6BIQXxTGzHPfa/Jm79TsrVcnyhZDHtqN6WSQVh03bGtJ28C7JFTT711AcUEEsB0u7PnDcAadD2z6VkgvPk7qtAI/i2P8gM+MdtX/44afHRROUQ3J/O4KGIcy4eIVKxkCkikKVBadCTXDXbzqCS4J1Kkjtp7eXjpCp0dfRJlg9yZPtUPCMQdlvV2haqLxTfHYv8NIb4ubmcjEUm6k1wmWoD6gxcRCKpfXir/NYItKLy+8K36estmg0JjtRm+4qNZ5NIrweh+oFERcG2TC1yhWuSbe97NAJbPiOGTXUSyQRNkzgjhZPJwL3dc7ntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZU1z6cbczq0qQqesul/axvZyJbIvIkHEJFN+PnuMDs=;
 b=MMKBlt/p+1/Qyzg0wfIAIIc0cR3dSyziJZ+sbG8ZWIbZIHdPSdDRT6Tqy3qwi8TgmnmANMw/kWDw8y5PhXR/MtJB74ytj+8gJvcPRyZ5uaAqWitJdeFO18AX+Xa16XmkOPbOqplIEiBUAGkF74a5oWsqclS7v/qjHUQ2dZHeNGK4/iKCl5U+gBDoczGW1k+iAlD32d1bzQxO7KjdRfjbsPvVC6HteYd0MzwZqbMsrz5pXYaiw2yebrac5aIB7OtYckk6EkPm/AM9PFxR3Fj3vSsM3/DBSOmo6vKVU6wVzDL1c8HV0WDawdRlCMztsnjfXTzcclaGYtmgvbxUIkl7wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8557.eurprd04.prod.outlook.com (2603:10a6:102:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 17:04:31 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 17:04:31 +0000
Date: Mon, 16 Nov 2026 11:04:18 -0600
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
Subject: Re: [PATCH v6 2/5] dt-bindings: soc: fsl: layerscape-dcfg: add the
 LX2160A pad-mux child
Message-ID: <avs3kqRPvto9fbT1@SMW015318>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-2-fbdce4565a5c@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-2-fbdce4565a5c@free.fr>
X-ClientProxiedBy: PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::39) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: de651aae-8f77-4c88-5667-08df4403ae62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|3023799007|4143699003|11063799006|56012099006|10067099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261009223027099003|261102123227099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	5+2eOv6fX31HaEDVpDNY7ifwEst7Um81u2rr39zkZLe6gN9KP1VPRT2yPF+JrXPuSUdgpJfLJ88l4m+u4RXdAnFVnhOPRXu6VqYeh14dRf29hAbhGCTHhAJv1Xs/Bh1QmSGTwNyMmsuiY65csM8kyY7SFRqt+HUx0BBysMveYKiu0Dp0gxZaJTujJafhSlGP9i1EZKnGfYykOzKpRs2/+5q1a/Oyti2MvUx6gjSTtckUor8I+iypMoIXViwzUXyFk/pgVYCA/dMjR4fh29jEWaMsLlKkbExnftQ08WDqDUSjHqdf/wZOewtefh0B4CA+rKwOpyNma720rrrW9+TnW+yM/X6OxKA6+9fnSxdGfXak3DumPfA7J22V/gdcnkd331oPs0+wBb1RG1LwPlLY+vfDBifgm/h3f4636eseaPfwnncVM6lO9BflOYnJWa6jEynqKPX1slf4qdlfbKs76O4/18jbslITvVGwXQYRsAk/90pDIGOqPJ8Rt2txe9NJvl24O99JY9bpAAtyhDl3hkc0/cwNP47NzrcYMhQp7GMN4cdALo4XrkXKT1QdDWokoOJ4r1fSk1bK8J5fk8tXzHTy+7gTgJhclOUOrb8n60eHjKAOLPgMcy69ZwfSp50l9ZGqQ0F26as7og1buLSnls3jGWH9PFZ4z05qRDtWsqVfzPM42krKsT1g2rZ/isCi4eAqJ33mLVL/OufQAZgTiXvxLDYvLak8xyJmke5TdoA+mi9M2mQ9xnquZzXErbNk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261009223027099003)(261102123227099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MWFLshgoEXjaN98sllkRHTzYrR96yZN7dc0LUlVtPU/HQ9MKA7h6sQHLPTTe?=
 =?us-ascii?Q?cWixjnjwCZEZuaxhP2MSPvZqXpk2mokKgQPEDMTtBD6saASMfg2aDnvKtb0+?=
 =?us-ascii?Q?zu2q7574D64IuiQl1R26npNnxtoIs/126eTJJ1y5kepyj3pD2WBADmnKEkCF?=
 =?us-ascii?Q?zOO0jMj3DVGTCa3s7adieOIM0cc/fX66RpwQi22x6e3o7lmTMnVaYbaFis6t?=
 =?us-ascii?Q?KIMYvj23mpoztlPsxQOMVvuonm/E3yjVBrsnzksEkKeKI1GmYeITX4TToaYj?=
 =?us-ascii?Q?NZ+IOHiredgoQwr4Hb7pbq/fwbE0RBcTiXFRVYbA1CG7iaur6KZl7hNwfeGq?=
 =?us-ascii?Q?h6TbdjE5TsMXo/AImals0Y/Q2x+Hj9gwmQuqDZVfzoq6dXVWFBc0GS+00oHh?=
 =?us-ascii?Q?ocQaDI7IkHf3cpT0M6ugF7Lwci0N7RfS7VabmPxO5b97ihCTJwz/KjOyUPXv?=
 =?us-ascii?Q?DnYyDwLJFOtK7iPIC9ltRLAkYeOuNvkrFq1rJ/vT2uvyVmwXFyzNn6UJEj+s?=
 =?us-ascii?Q?VdMgDvfpCFZCqRrBh+l8cf+LbKvDrgp76qhA/R0EtG3D1HGdPNLiTPpf/qPP?=
 =?us-ascii?Q?O/o/wODUmZ/PwaiVFuYNUfzSKr1VGrursAJqp8RsCMqNXev7zidfXHxly93h?=
 =?us-ascii?Q?z0zlkiU1zpcnT+CJWKS/AkU71rHocZ7N65iqDsvVLX25nFlUlnfJc5A0ljGs?=
 =?us-ascii?Q?dMydhTcuw/5EEvnExtIQ2sp3s3kKiY/y3ff9UB7GLBM1YL3UtFrnABE+ieLO?=
 =?us-ascii?Q?WOqc5Jkjh8inInBbZNIjSqxlHrjYeHsavIuUVv+8GXzwuXXR/NryHh7qleE9?=
 =?us-ascii?Q?gu1sCPDxk4X9kN86DSo2OTZwvIZaYUt/rLuAiX6jTU+/x6NifhcvvIUmmszs?=
 =?us-ascii?Q?7NRqKe1aYXo3uA4azXaoMuWDBtAILSBdWL9k19QpSMe6fSMxLvNuUmze7Fsx?=
 =?us-ascii?Q?d2JsyqRPUU1nX2yOWK7kOn1jQSk1iUnplzU1qZf/v3pbX8H4OdD9K6MA4DH0?=
 =?us-ascii?Q?Jh2WFfXRL7+/0Tkspbdxug4Mcjdwx5/5xyqGe+geWyD20aAtC4itXT/Z4k97?=
 =?us-ascii?Q?uJK0gBTtvSRAluQKw1ItU/9YGezj1dZQZR0PhzE87zSR/vsoFkw9+/kwZpxk?=
 =?us-ascii?Q?WkEiVCbqERcj5hd/t5Eb9fpAb4HsQ2xLJUbxOUOPv0ZYJVUF5dVVFfj4N6NA?=
 =?us-ascii?Q?hbEOT4xvHnLgUGAFkj1gVaXD7TcD/paObvp0kRQMKQcwKgpSsNoQCrknykuw?=
 =?us-ascii?Q?3YWYo1pgz9X5+QYRy7gjDIElaqBlXIx9u5JQd+WPNFYVbdE3CC+hiL5FsTp0?=
 =?us-ascii?Q?sq58vZixP3FTdX2kEDauUJ3M/aTxAlcR6VvyI0v7i4rj8ZnF4evgEPgooYcp?=
 =?us-ascii?Q?wpk1wpHqbKane6LpunU5/SKomMbPAVv7cvb6EXMjgq5jQ4gwQlRnFhmgbeyu?=
 =?us-ascii?Q?POQs5aNZeHA4dQ52sJaBcCkBR3fp/PoplTNhLmKM30RvOxczlLxyeANLkwE6?=
 =?us-ascii?Q?X6VPbzENAk6O+68Uk0Vek8kEQpieP5WInRFp4MS1+vE8Jq2cZkkel7M9MnjJ?=
 =?us-ascii?Q?QDJTVnmcjovwyO/a6GRtKZgAyXJpuvUURnZcqG+DbkYZ406p+1YS8lfN2+bo?=
 =?us-ascii?Q?qORjCGKeP2kaW+qIckZKGT//nT9HLvujJsXC+wB7Z1N3Lf2WxC6Eqg4yPccF?=
 =?us-ascii?Q?U68tgqAvYX2n3m2CAaTvPTCY8+HIM5vnqdltNNKZ7Nr0m2EH4fIzq2hBE4Dj?=
 =?us-ascii?Q?fGOVXI9eyoqpQEKxMTqu72jIFXQHepEiYsAB9ZAxpwPLsioxCK4q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de651aae-8f77-4c88-5667-08df4403ae62
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 17:04:31.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5fwzZIqS6yjpamD/ijKDdTKf9tCexnTxpFn1esYKKUcZTiwQmFmKxsIFJaa/RcdrRhuGVI1yriyHj5j1mFlCibwW/YiV88w0Mp3PN+dC22tr4DyKKL1I30qLbueXoRo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8557
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 02:27:32PM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>
> On the LX2160A the DCFG node holds the pad mux, overridden through its
> DCSR view. Allow fsl,lx2160a-dcfg with simple-mfd, so that the child is
> populated, and the pinctrl child, on the LX2160A only.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> index fc14fd0bf84b..bb9dbcfec188 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> @@ -32,6 +32,7 @@ properties:
>        - items:
>            - enum:
>                - fsl,ls1028a-dcfg
> +              - fsl,lx2160a-dcfg
>            - const: syscon
>            - const: simple-mfd
>
> @@ -66,10 +67,27 @@ patternProperties:
>    "^clock-controller@[0-9a-f]+$":
>      $ref: /schemas/clock/fsl,flexspi-clock.yaml#
>
> +  "^pinctrl@[0-9a-f]+$":
> +    $ref: /schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#
> +    description:
> +      The pad muxes of the RCW on the LX2160A, at their RCWSR12 to RCWSR14
> +      and RCWSR27 windows, overridden through the DCSR view of this block.
> +
>  required:
>    - compatible
>    - reg
>
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: fsl,lx2160a-dcfg
> +    then:
> +      patternProperties:
> +        "^pinctrl@[0-9a-f]+$": false
> +
>  additionalProperties: false
>
>  examples:
>
> --
> 2.43.0
>
>
>

