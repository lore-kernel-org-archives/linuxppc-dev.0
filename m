Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BFE606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dkO2u4rR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTclZ6MZCz2xRm;
	Wed, 18 Nov 2026 08:08:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794949706;
	cv=pass; b=h9osiYqlHsrDLTqHhSxRs6FXBkq55u7XqAY6tEJAnfZ3Tkh8nqdsP9go4A8Dqtyth9JN96g66bmJEg0Tb0FvKsvMcN8beuxWqBhY/fklel6D2DO0zayl+PJaf3s/+rgzOKyhFFO66+O4Z7kbCXc2zsDp+vq0tOjFb0wh6qeGc0bwqcVpybpNTWqx5l/88g8yurAV+napc7dOQRWB63cX6MWEHUKWPbaFfCZb7D8mNGQuIJjR5jiK+A/y59sbVdyGjYrJJ6y3YDwCFglORLJRddR6NzIVzeJfGf/KAuxpIcHKe8MkBpoDWJ641KNXfDdGGNkHLaGXE8TBSHJrMRe5DA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794949706; c=relaxed/relaxed;
	bh=aNy7lhrPGyHHVnnd8bm5bwniy/ZuH6vPw1U/gPaYHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DDDtiC24VdEyc1EiLxyiPqviGZ3Bz/KH6Ht1dTt8vKimCY9HkVJZ6Gc/bmqkf5BwGkGGedpJzZ46pA3GM/oWf94fJQ4XU+atXHIWi0fp12Go2mptehiDJxbH1yVMx4Qp3921MmzXHynascEoa5yVWaeycbjIefVzw44pcpsUVTdI59lyiocbWVpGymOYUMbMA+c3tBRjRlhcW5EBzEI45UmiE+W4bWmlhrKE5WN38nwmsgWW+p0fpnWH/yHqLK3lZoDRtyXcxzgCZFD5oUKqDq9/0J35ryV/4ndQo6gmBKLYc4QYUDDgssAmCs3+VgnYtuom9iha5v3O+4zfP1oESw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dkO2u4rR; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dkO2u4rR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTclZ1XCcz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 08:08:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgcNmF2fAAk1eL7cBWWaFNt0smzjOkCGSXvhkAfKxcqg8fc47T1EkAdJwj7TIxtuhg/MBnlfKOxBG9tr7eaywkC8Qa5QHAOb7+NzSEbViErSgS+ysa0dmMgUQLS6/2kcbgEvqHHtbq2tjaKbEaYDBxOplsZzrsSP/bXBRls+4esOJ18tJZNQMDPTiGboRdrhRndJJFli8Kq1Bw2Oqpn5gIOOJsc+BHM4VtYD0Vu2ItcmaxwgbJqeZXPZkDPl1EWgQSwpOHgoxqeQqkxgXz2zuIFja/enUJdOXyfuX8WsjpiB4cBUl9T/6oACSVqdB9byX7lmtVGwBfGDiHULX8nc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNy7lhrPGyHHVnnd8bm5bwniy/ZuH6vPw1U/gPaYHfg=;
 b=c1UyOIj5IGVOuEL6754FRxASGPEMyFoNeOH1LqfVEfAyLEWRtdZ+dV8txMveXWJ0Mxnq6FuNNATUdZ7q6ydbjYAdCe+fTq24iLQzXHEkBNNM6QBT2PkQtgMD5dHg/71tEcnk7fwFrnMGKZ0ZhpvTvZ8teQ4uUXg1HZDv41l1amZIr7PgrpwDpafWKW+yrrVxiJjwSZIwqP4ytyqhKPxiFdU8A1F48HcJ5xDr4H8oe+dH2sDoSYoDCvMvy+Lxmw0vqkDJforPGr5hSpsbxxxVhOGioOLMmxJFwvOhG667wLRQIV5JHuG0D41YTASvtmCIqb8ZL/jEBVdJweuqG7S6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNy7lhrPGyHHVnnd8bm5bwniy/ZuH6vPw1U/gPaYHfg=;
 b=dkO2u4rR1FEej64wXFaHBkGcgH79gea5VC3O5GU5XkrJbJLgwwSwkyOtrAWAaRc9F6LvBegZpJFvMmrA8hzn0qUw48D8XqHBj8+8zE7pbhu4WtA1PitzfoBE7thhlGssIZs6lUFHT0aPYNSEw1eKT8BayHWpqvXVp+ib5JGn0RSst+clv5QLmRN/OdXiiG+BFEHEgocOkCyuO4sDv1hSMQ1GuHRawpSmGTZL8gACdhBHgBwgMgID/awlt0Cfqq+7ROJEWz5HrJWpJRGlxtJ6hhfO8K4rhAnZ8oY1GPZkhkfLHC1TPgKS4j5Keo5/3BpoCOiuMzBKqCsnMuRqrHDqLQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS8PR04MB8915.eurprd04.prod.outlook.com (2603:10a6:20b:42e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 17 Nov
 2026 21:08:02 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 21:08:02 +0000
Date: Tue, 17 Nov 2026 23:07:57 +0200
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
Subject: Re: [PATCH v7 2/6] dt-bindings: soc: fsl: layerscape-dcfg: add the
 LX2160A pad-mux child
Message-ID: <avzCIFW06PTLauXC@lxl00025.wbi.nxp.com>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-2-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-2-5d7201970629@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-2-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-2-5d7201970629@free.fr>
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS8PR04MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a39ffe-40ef-419e-8f2e-08df44eedd9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|1800799024|376014|23010399003|10070799003|22082099003|6133799003|18002099003|3023799007|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|4143699003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	SBcfgXx40uHQfUldEMLmpb7ws+dJkR9stsRteD/cfprsDWxbObPqj2SdFO0KJ1a8DN4GAHO6f1vL9RsVxFG3QuVTnJrgjqUKRnaL5w95ubI+YbgJHL2/RxZ6NLOFpwocJwTDRZeaWrFvnwKlm385D3hpnBWOmVdRudSNyotlSR6KeeIhCr0I8sPYYLrapMXGWBCAGsxjA6ihMxWWJzqwEPwmZDmmA2uGELFXfYuHrV1ofTD02AfYN6YXt9agpEgEA0tGnPkZ/ywbiFp6NvPjcCO/nXLKUCIRMlTO7xEdJpUG3ZO5paTiOHChd1rCGIyAT0SYBY0DBi/gAIE37pxbbZSRMVT72X0AKgH8L30mYAmZ1j4CjcygrTl1D2Th4x962ya4NGLydw41RWNYXBDrQ/rrkKo8Ys1P+xD4+olTvvCeJ17m2AmL9RTmU8pZHF9c69oOWVP6ttVV5zo2uxJZyisoKYqbzqnZGkFg4C1LdPlnRk4wL+O4JFtDAJr2cWsZgAgDmuzz4e6q/YD/qQ9UQD2h02L9LViAb89X018ABxpxQjPMtKQVj6O2FS4ds2bssVzdSPSiO0lDQBf4/GNjyrvwENZ/lGoS1y069P002Ys7RAr7A7tFQjlaqrHIif0kij+O4Anj7LFuTz03ilQXRm4+vCQdl39fl9qEDww0m7rk3XEdoj8CkvYbbjwC8p0ZNoWc0cUth6XRpbn1E55ASI4xlU6SuMhftcgLkBtBMFxWO3ZQIHGIf8ZV3c3iCfvq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(1800799024)(376014)(23010399003)(10070799003)(22082099003)(6133799003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(4143699003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NIWnZuFfXj5T30kdbr+ymZfPbNtQ/LPOtmWXno/5Rlzy3DWKlW0aKN2+/tdM?=
 =?us-ascii?Q?5g+GERYM5TvQeREUAioBaXNZONn48SH/AKg1OPD3WqDA+djm+Sy5UDQ9X3tG?=
 =?us-ascii?Q?OXqWW8TQf5heeHwmcXyDT/ph3noLcCTZWuRdyUY9rBc5dmWlMRMsKfv9kJdb?=
 =?us-ascii?Q?vff8/kyVSgKjV84x6kogZxB6xFT8cOaOIJBLfM15c+IcNyTsTuwzJccXbQCa?=
 =?us-ascii?Q?6vVBSJEOxbPlPjOwo+FLBux1r9H6sjCiv4D4TxVmo37Vv1F9/lcZ4G/8Jdn4?=
 =?us-ascii?Q?4iACTB8eXc5rnZrw1tMluzuj9nhMllv7tdF0UsG2d4Z1kgFGL8TsjcUIo6VG?=
 =?us-ascii?Q?S0oDZbmdN4AB1hWUJtidJybC9isizePYbpBosmgbkw6aA8JRUL59ie3BR815?=
 =?us-ascii?Q?kfPGFKqNDvnj97vStCWtQh8RXnK1R/zqqA9CYBR5vl2OvggyEcJo6a1lnXdk?=
 =?us-ascii?Q?qDRoeptbcyFcxHd0OXPDQSpAe+w7K8dQFDh1mbcyxLk9XxOrFIoj48pS+wpt?=
 =?us-ascii?Q?5gla4+Or2wfT2vih7EPj/bmVKpLl919kXq8xoXOOm72sQDkHB4jpHTxdDuKk?=
 =?us-ascii?Q?0d8mtHROYWmAA0CkjrmTQOjpB2Bir8AfXc84vPrEmGD7kHdIZ78g688+1WT+?=
 =?us-ascii?Q?MBit9FyMaXztmA0vlzC8EJaHhfvwkma8yQ+GokVsAkEihoPbFZRaj8VR71KD?=
 =?us-ascii?Q?aUhHUR7AKDckstI738HipDf+tD9bdJGVCPWOsOPy6cGjYGjcHdkZVsA+GiNm?=
 =?us-ascii?Q?P8kLH4bCsrk/lW0lpBgLPQXWcmPScczzXnHN+/yik5yhGdSYoBKvQqE3oSbL?=
 =?us-ascii?Q?Mwo/hheP1V1IH1qbLJmYdIsBXxREN36S/92Wd4u4DORZZ/l4aLakp5h4Gj9h?=
 =?us-ascii?Q?VLa0vgm1OsapsNSG139lBShJygJjnZ4Yof2O2R/re/1oFUNAPhZ58Xabl/du?=
 =?us-ascii?Q?Ni1v9TrVuzYE4YCHpBfTbQCqBowlKApmAI4Ax3Xx0CWPqIgEADCbjDrfrEJc?=
 =?us-ascii?Q?ys0phCZ3Slte5PjDzf/ObSa2M8hF7AWHDot1LPdLfPbVASjGHtdNQW0zQsrg?=
 =?us-ascii?Q?kUV6fb06KPEr0q9I2Iz9l1pizbSKykmOCRhg+541gN7vZjfVzOoWaJah2PEf?=
 =?us-ascii?Q?thDCgmH0xX9q/JCH6Ppu6Tll9mnLX6a207G3/1Z/Bp4L8kD75OMmjh0hVxzd?=
 =?us-ascii?Q?N/IzyciH0k7cUdBlzG39sCuhUnTp7sWmIrKTD4EzE0xgg6h5N+1BcuL/Gaph?=
 =?us-ascii?Q?xkaaBssIuNr4ryqK62Hkc5NNCNqEczDp2xVLscNX3KmyMgK6C6V6+BpewgKt?=
 =?us-ascii?Q?DWj7TZjhCTnygH9M74voY0qqUp33QSx8LjJXZv/9BnVCgHw7ZKga/xqetj/0?=
 =?us-ascii?Q?dv1kW6jSwF/CQq7jRkDrURi9XNmljU4WjwpFx99jD8cKDnctQDrGhhppuOMf?=
 =?us-ascii?Q?s92yAvh6kHyUD1kCVUpg6BhcS7JDAPhJSfQvAyQoxODWO/EX5zt1853pOD1O?=
 =?us-ascii?Q?6Tv+3V8aFSiCh1PAETvY7QYLM2GYi9GkVWPFl11fibz2OGN9wMaZwTvFoxtl?=
 =?us-ascii?Q?FVQh/QyCC4rV+o/oFcIgYxPpHn0ltVQSKhO/fkw3vaKQMzenU6k972pBA4vu?=
 =?us-ascii?Q?F8XZbtwCmaOhvTmnbAEHtvjutlJq3U5psJz7Z1bfpR4YzanHpIse1raZO2RS?=
 =?us-ascii?Q?G0+31PUiC4A3WiM7BuhWTnCEXhJ4sc6zEg0T85pTMFiVKxJkThKZ29B9uWGU?=
 =?us-ascii?Q?oDH6KuZtPlt8x7nmj0xnACp2VNFVUMM07W6scZLXzEXBsywcEqdZ56jaAN2K?=
X-MS-Exchange-AntiSpam-MessageData-1: CiyyyOSxjPVdtQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a39ffe-40ef-419e-8f2e-08df44eedd9e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:08:02.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y4ztrA9zEzPMWBeHnLQtc6yJKN1Vz/txhny/lgFGFTNRy7D/ZeVhpwDvVoBulShpDPbww7WmuGpT2dVbhEX/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8915
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 03:53:12PM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> On the LX2160A the DCFG node holds the pad mux, overridden through its
> DCSR view. Allow fsl,lx2160a-dcfg with simple-mfd, so that the child is
> populated, and the pinctrl child, on the LX2160A only.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

