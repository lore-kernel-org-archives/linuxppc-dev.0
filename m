Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7F606A323
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aYs2gOYv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRnmB6dJPz3c55;
	Sun, 15 Nov 2026 08:47:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794692858;
	cv=pass; b=PrXhnBjRqxRFBUS6dCibiK5QlXmin48bCczbwtWeIVCKGkpbqAgh/rkq1Ck4QN+kVGu8FZIPizoxm/uoM291dg4bA8uMUae0z4cz8BOVeUkhtNxheJkHAnzUW65Uv72+nRDz3+wsCrZZ/n3DuMY91T9TtMcDbsJH311vzs9ne/QwckpcjCE77RTH+3RsUKMsCQFopwqKKHa7TwA/JPAZLs5+M3C29o3P3X9XovL8s28SP9OrU38AU5UJiJKtGK/V495hN8jjZoz+kMHnvef9J9lVGrje4seFxqcMn4mPuhHW8HtvD0N1C0o9w/hl3zX7L6NF2jjgDEmHF7o/5/uV4g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794692858; c=relaxed/relaxed;
	bh=O9JHKYz3e1iiwcxO5S9MaYk/lsi3O665sENSzeAWiTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZyB9isr6/GiW/ys4xdy/Jt2R9RifTkyX9AKjLrCk5axrPurBUdkvYHxq3GKq5zRE5k+APrV/6lKXscYmv3IT+j0e4yJb3ZgMyEdw0+PDYd8xR/xzYkeJv+dCKkn8ONpDa18nk8fHlAsXc+K/AUVThSg/r/FKJ74K81Bmo/M6+jSZaN4pOldF4IroaKFUPMhiziQseBJPk1j6pObvdxzlMfi+4knKfOn4/d+2aueBG+Vfne+ysXaUoWfIlin53ZVl3LcsnMcfMJrgYl+7BNfcIlyjWrRoArPDXj7LN5d/OGL1c69Q42b2SuoZ+LsG2Zme57wBOzxVmbqjbcg2ll42Wg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aYs2gOYv; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aYs2gOYv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRnm91sfbz3c53
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 08:47:36 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwD+2GRns2luPeI1LN+WBniEtLHq7d1/Xwk5mYfX5RLOdYoTcxZHX9gHPBJmhDoyEwWlia6hD1oDvL+9eh21J8XvY32davbMnqa+U8/JzzFexFJ9YhLijXD17/37dVkA0d+U5N2Ld2Dm2sGUbxUsXz5OVkzfRoPOUXTA1gUlNWFedtnPjSSRPvQIU92iWkix6JOF433qiGyaDjrodA6T3OfEPmRk2diXJQbJQPlxMql1aVV4+FR8Y7UA6QhlY10TxJa8bUiW0zLwH7Js5szR4D4KQzALgsLvd1X3pWnyKpXEu/QLLl80VFsW7204GWCSEFgBxLraRYC8vfWX9DAMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9JHKYz3e1iiwcxO5S9MaYk/lsi3O665sENSzeAWiTo=;
 b=JF5jHWLzxXGAKqSPXuNFuBT/CQ0cN1PDD/nchKr2Uy/TJnGwvW9+yE7zyihghvw1yttNGYIRf0Xg7nbsL26gUkk0ZVm4w3oFhJVPTV5eXmUqfKN0vCI4lvnbtnCMZxtvhNnhlqCV7kY4aTyPtbTOnSD1t3tIH2uJZ/Z4eiuEb7RGmU/SXGoRZwvW8L+OB3fEOLAYLlX9XhEehePBanP0dFfN/tsd5FFuKHf88gEEOTQj5UTIogOfeHVwLsP58HO6jjjW3ljdztriLYemBpJ22MfHg9yA1mtLhnRlZm0Xfyfh2WyPVywqW3OVziWnbw5LfS9uqDTfiPxGAqJLYxFErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9JHKYz3e1iiwcxO5S9MaYk/lsi3O665sENSzeAWiTo=;
 b=aYs2gOYvNxBuKpk5KACNiSCLdqGhCGNOWrZwQpAjaBkTFcXthGXLbjDclxIPd8MppMppWUMcpvl4lqQvLMrr7myS7N59jvRChfk+9ofJ3MIwEsxF01algRoxP+V5evXzCGGjtQfRwC3CB0o01y8pO/c5Equ+DhxQGLrf6ubqEyvUFz6iRaLSluEbMxOTdP3tBxrjJGajEnCjFdlZNNiBkBHiM0adJ4PnvueKj0mLlPeabTQ92jj8vWz9XgjPvRQpKT/dMjAtpn9HieXVfdsYpS0py4FtXOQCVZ6+BWF/Yg5tImN3HpK5TH3wKPL/q/WdD8rem8t6X9HUaoM2j4jmbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB11029.eurprd04.prod.outlook.com (2603:10a6:10:590::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sat, 14 Nov
 2026 21:47:18 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 21:47:18 +0000
Date: Sat, 14 Nov 2026 23:47:13 +0200
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
Subject: Re: [PATCH v4 3/5] soc: fsl: guts: add the RCW override of any RCWSR
Message-ID: <avi9N8P34X5uel7a@skbuf>
References: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-3-eefcea066a55@free.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-3-eefcea066a55@free.fr>
X-ClientProxiedBy: WA1PEPF00005B90.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::627) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB11029:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cf823a-a99e-45d0-24b2-08df4298daa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|19092799006|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102130727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	wortIPmyB9rNEp3Iap+z8boinPUAey4azTgaiOf2n4elsuME0yzdbtFJuSSXNMDXr7zhviqzuTdoTxVk552HyFrgEL1oprU+arlSRfSF63HFs/VC6G7H140/oWlqu3rg44hCVrerD7En8WaQEmmYMIBERqH5sGnTQgnqdFXxuxsEeRquGZM2rRCsrHZ3NC9frNAivF2oqashul4H0EfgfKl74oIvTu5dGO61vigA+yxoXkuEvdrSORSlqo15/7ij90mW2R+OiwUg1kKiObUMby2EQur3xNm+XvhM68z1j1wjRRzOS1b+wRHFiX/QD7e/vi/G2o/ZF+JtNsNyrveituhN/ezH3zju4J0Ics+4CT+JGzwNoxKPzWJeezxi3otAggpBME4L+2HAk/GBWLZbY5qa0lg1CfGzH7bLRYP25yQLtCzPNXauR6z/08DPxeI1VQHzW4647qC6PLAROhZjzVDvDjl9/XO9lpMFdtXku82qC4K7oBApZJ1Ty3isgtj4lCxukW64GmQs+a2b5MKTQvPNvf/OaOgHvfO95CaXC+RNKBXPk9xsbsdgKvY32rkBeT0Sg1EndQUnYvrb/0js0xiL7PiBKF6glnE7N+YFWi4B/ASkTeietYC9VijTy8vKN+byNef75jzM5DI2BD2xKApfstNx7fL5gMiIrSlYfyekYhmXfTmirl3tkJG1vfjjBb5b86myeMuW6OWVi9Nh2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(19092799006)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102130727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?xiMhDwuOBfD3GohdMhbdLNFwNfFE3B9tgTsXgyAOznOILYDB/RNRdGT3os?=
 =?iso-8859-1?Q?OqGOpRTPM/7YuRgLF/ldzTTRUmwBGr4BVw6GVnNBcfXKztL4IgsDjc6WbX?=
 =?iso-8859-1?Q?mjwVxfyAN4kkCZ69iq99DC9Asj3WLG4E0uSSETndLWwz1QsZbd84iPyipD?=
 =?iso-8859-1?Q?Zbls16YOQGdI9fjND7ly/eCffA/2mHJ98XtTNnRA/B4yQE+dBxHHnkAc7y?=
 =?iso-8859-1?Q?kRL9f34SzJHG1A6U5qgZI899yBxTehaDcQQ41dqI2BwfCPHJzUpkNGAL1m?=
 =?iso-8859-1?Q?oBwYEdROT/iWqeG36n9YhENvyJiDbZAh3FCgNJbq/y14UMpdlbLqEZUsmB?=
 =?iso-8859-1?Q?J8N4s73LNRDXF8m62T1LOwB61q6dHDKhVi0SteZXZsGtQmvGfFIO60JniC?=
 =?iso-8859-1?Q?V0sipCpIEc/UgqZ5L5Cg+qnCgmCZOiEpJ0h2Fhq8hp4gZM7Trb3mVN8+7e?=
 =?iso-8859-1?Q?v3g3xok8c6w0KDZ7HUCCYkP8vePvl8hXphb6ZhN0er9ZKlgWD4BrtC+YIZ?=
 =?iso-8859-1?Q?AwlO31JnGGMlZ+TVjJ19cUkMBbS1z2NGD2N9CK4D9o4/ESW+Uyeui6M/m9?=
 =?iso-8859-1?Q?8wFys7mNXkk0vzeYKbN/89Z+KZvcAs7xU+iquOeiOAgUTs4cHTmEUsYRPD?=
 =?iso-8859-1?Q?Rp4H+LQ90Snql7bb3MtTqirhmtJPYdMy0A0ckIj80KYqH5fOryCr5RCRIs?=
 =?iso-8859-1?Q?z6QXOp282IEc0Z1pBvN4Vni/6dsy8LcF78pfP29OBQmFo03MgreZlVoMzZ?=
 =?iso-8859-1?Q?UAL3/Eh6kp6kF5gv01nZdBDZh2uJhhtfj2sZNBolLgRgN6xsW4p76f6X5u?=
 =?iso-8859-1?Q?0OOPfQ5RZRPtSoCLDhRQbYB9QS/kto/qytXrJqe00x2ccgeHB6iWR2ayWt?=
 =?iso-8859-1?Q?qczCd0dQAppxiKhgd1t4Fa71QVD8cBH238LZWSVeF1ai/3NkyKFvc+5gAa?=
 =?iso-8859-1?Q?XV1e0AMYfShQ2Rn+Mw7zgNW4x5SOjxBR/sWQZlbxxO5of67D6tZZsxjWoC?=
 =?iso-8859-1?Q?wIlkyCjxeW1yofgwKArjRqkYcZO05xpkVIOhXAuDHJsKOt5Jz2n8RGwYww?=
 =?iso-8859-1?Q?2SerHvl0R5XpMArhxzBzXdOPYXViaDPB0tq6UXXRBroY/C6dgZENZhsTr8?=
 =?iso-8859-1?Q?fYxLwXY7UT9X8DI+H4PsmQagVoa01fZ/Y01K5qDWFP+fnZXHzaOdw/5dZT?=
 =?iso-8859-1?Q?Ifr71s+v6lt1H/2N0JbeoOgrHl++JrtMYAMI157DGguSkPcEt2jaofQPhu?=
 =?iso-8859-1?Q?YUalmuovf3bSAjJx6C7gsrqokUYUW92gC5HKtFYRJ4hYdAjjcEle9qZAzw?=
 =?iso-8859-1?Q?FELheRE9L8d+Y4jdS5RIWFn7TMbO2Fy1kOLBq8JMVoYJah0/M1bI5JozaS?=
 =?iso-8859-1?Q?40XzlGIzXpMcYS2/24DwiCtJTxqZaPZL8fEnZZBcPGNzrGehxgsIP+ntRK?=
 =?iso-8859-1?Q?eWpUu/ARdTC1oKpW4aDjVRHvBPGWUmC5zFI1OgaC/DnGsDkAduh6rfhgjz?=
 =?iso-8859-1?Q?4TZYSvZ4qmKki/sO1CaSte7dYXZ4IfSZW/4c5rPhoVNy59PFehej1VktxB?=
 =?iso-8859-1?Q?TWoW2G5tY/zEKMOgPaAglmB/6w4hqY7A4qT6zw1KsjzwRaebvDrPKYp7QA?=
 =?iso-8859-1?Q?dzLxY7d2P2Ascjeirpo5fSHYdUZI7RSsHjGGmgdUxOK/5GX8o7RHx5By//?=
 =?iso-8859-1?Q?Fn+AMPu/oIAnoI2rVb7t7rYOSHBv17CIy7/CAgW7Lot27oRGUmpm3T+Uxe?=
 =?iso-8859-1?Q?wXHcRbDO7qonYwjmipynpPpvl75AN6PJbcJOo5DzoE28F/mi5caTTZq4Nt?=
 =?iso-8859-1?Q?rXrBTLIjdi/U/Mx8koZzkDRPHR6OyjgdqCToy5TN/6NzcQeSkVzO1L1m2s?=
 =?iso-8859-1?Q?JE?=
X-MS-Exchange-AntiSpam-MessageData-1: BdzXFMhigOvNZHJpFzD+Nqqm2SgmXg40Wgo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cf823a-a99e-45d0-24b2-08df4298daa5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 21:47:18.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cylMh1hRMwyZeiFZxaIXP3UKJk2NW87UoNLzuKNp6xGtTyOjmaYrW9BhUe5pr+icRoPx71GVfrLRYSeoXmtP8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11029
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vincent,

On Fri, Nov 13, 2026 at 05:39:05PM +0100, Vincent Jardin wrote:
> Hi Christophe, or Vladimir,
> 
> Le 08/11/26 11:06, Vincent Jardin via B4 Relay a écrit :
> > From: Vincent Jardin <vjardin@free.fr>
> > 
> > fsl_guts_rcw_rmw() only serves the SerDes lane modes. Export it for
> > other fields of the RCW:
> >  - fsl_guts_rcw_read() reads a status register
> >  - fsl_guts_rcw_override() changes fields of one under rcwcr_lock and
> >    waits for the status register to follow
> >  - fsl_guts_rcw_override_supported() tells whether the DCSR view of DCFG,
> >    which holds the override registers, is mapped
> 
> May I ask for your advise on this topic ?
> 
> I am looking for the review of this serie, then I'll adapt it
> for u-boot along with the integration of Linux.
> 
> thank you,
>   Vincent

Sorry for the late review. Responding here to your question on v3:
https://lore.kernel.org/lkml/avc9KbxQ4dxlibGQ@L30177.local/

I cannot agree with your API proposal. It exports to the rest of the
kernel a blanket API for RCW override of any RCWSR1-RCWSR31 register,
*including* the SerDes fields for which the fsl_guts module already
exposes an API. So with your proposal, what can be done with
fsl_guts_lane_set_mode() can also be (un)done with fsl_guts_rcw_override().
The possibilities of abusing this API design are endless, and I don't
want to have to deal with them when I can avoid them.

At a minimum, I would recommend renaming the API as fsl_guts_pmux_override(),
and make guts enforce which register fields it permits overriding via
this API. Example:

static const struct fsl_soc_pmux_mask lx2160a_pmux[] = {
	{ 12, GENMASK(29, 0) }, /* IIC2..SDHC1_DIR */
	{ 13, GENMASK(29, 0) }, /* SDHC2_DAT74..EVT43 */
	{ 14, GENMASK(10, 0) }, /* EVT20..IIC1 */
	{ 27, GENMASK(7, 0) },  /* EC1, EC2, USB_EXT, GTX_CLK, SDHC1_DS <- your series is missing these */
	{}
};

