Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1498606A31F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=G+Ztmh9m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXwL0300rz2xqv;
	Mon, 23 Nov 2026 17:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795413672;
	cv=pass; b=L5ymr/xC4ZKLJqrkR2lgg9nR+H+ijtWMN2TePXrsBbF/wCoUb6uP4c/e1CY1sBF81BLJnH4TXkdkP0TBOxOgwa96Y2x0l456ABdfiXF1gmKxAn8wKV7pEoJrJMzUe572Gr2D9MTZkBM8onzcaBPO8pmEbW93sj3NqCjk6E5RDGQwNZM9UnilHFEN07534aoUIujutr8A3kvz/jLC8FYVfEfm/ROw8lvXh43uQ+FMwzvUATqnWQHV8sghc7v9bBQV9BP5uiGowm2Fb5AIkYAevAdpN86+w2jGWLMqbtBIt23fTRUBPEawNJWucY8bszPLBi9Ol41UbmKLa44C6kSDbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795413672; c=relaxed/relaxed;
	bh=IIOxOGhxPXm6AABf4rQHvRKhbwdjGRZQL+njG4a9r0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WMa13cpPJ5of+i4WZBBu/EKUZHSnTmpko61VgByqIm6pR54I2PxDarfJ+mce2bzVAdnXgaO/ZRkcz8F2bO5FPgXW2dCfUzEhbWOsXQHzqBBh468krq51W3IsBC9wgc+Ssh7hhb79aMWXcSX1QIjfUx0QCEAShtExRG/vzVqVVvU7oReNpLJc3G2gOqa35ZVlHClA3uN9yaq+Xpf5cxGUh9EPhiarz4Q6BmAFPJSyZkg4Enk4eWhMQcpogMcRsY2iu5npvrBaUXyt3VdBrEi+y/Z2OaBqTxkqjQqz/a+0b7gce8WeRARWYThncO8/ZkwRMJhnbdGiEnWIhpf4D8QeUQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=G+Ztmh9m; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=G+Ztmh9m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXwKy5ns8z2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 17:01:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqymfGrs0gsJT/KwgHZIkA8CULThQzUc4paYA9bYWEABzv4qVX5YaumVW+yX50UXzFM1aarTvJoxsxcLW+l2FWrQJYL9cdphLjNlPiTRpfIx1gt41yfb4bPOfQcIzvG3lTjsgl/xlkmZejfwgeN4Gef/SttDVhSuQKym9gv1qs2doq2g8qmr0/SzVhhxBF/U7E3WoRgdAKxJzSpihoN+eO/MCsPNHV9ECg63bHVgNAtb9edjcDq4WdAYNkmfi2ud/SldMU2tHK/66PZ/NdDqXPWEj12AVFzJENdcJeNCnR2LboIwZS2oYvJ4Yj8PhA/WBYWxGDn8ER+AfbJCq76ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIOxOGhxPXm6AABf4rQHvRKhbwdjGRZQL+njG4a9r0A=;
 b=SjrUxriLhsd3NIDHs/Fp336sGPpIPeKRttE9IfoSVaFhZCbye0c4+O/yz9nG5rowuxzIhHYNNihd0qQsSwOzcedvPaKzPdzhta1lAAcpK+pHq2UfARb4mKEC47AAJC8Su1Q5pT4zx9w+ao/9TlyDsxvFu90Q+wei0X1/7Mw9COSQqnYCa+UZiUbH/acfLcCnEO5RsHoLIJfPWByRUGCWp1s3KLAVZCnm+z7PvZaLla+KMQ2EKfkiSVMGOtLbJJ6Oa/7+zUylbwKk2B3Sh40aul+CK/XHIPIQog4mO7sghxi3TPjTNZlthA+0N89D1Dj3RfcqqbII9utSN1HwYSxteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIOxOGhxPXm6AABf4rQHvRKhbwdjGRZQL+njG4a9r0A=;
 b=G+Ztmh9mLRuD1295+XUtkhDDDzLKTgQAiC1DgGsoR/Xu98DakiNZVMXKDMHksCvrVoydZAvNvye6Pui+oVf29cmaVgWgTvhU4JnlqPNKweGCsOT6rx31yHTwofgOAmoE6/9hbYRFQ7tG3owdyfn9IRc3SHDxPtola2nvjqeSZtPZqH3e+7JejbGQuibxUMvqF2/ZMRKugqAKcg5Cf7yYSRED3rjqBo/zE2kev3IioR75IUq8S7bNlep7pPVdPLgdMKkR0iW0uhCdmGRXyeBdLW0Z+mPwUQTcdBP2fSrdz541B1iFVLzMuQRB6orf2XuVPcdiIsajJX3EypzsSLhWFw==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by PAXPR04MB8542.eurprd04.prod.outlook.com (2603:10a6:102:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 06:00:52 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 06:00:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>, "Wei Fang
 (OSS)" <wei.fang@oss.nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
Thread-Topic: [PATCH v8 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
Thread-Index: AQHdd9I3sVEp6uudR0COvgaFzGt1z7c7IOaAgAAN3sA=
Date: Mon, 23 Nov 2026 06:00:52 +0000
Message-ID:
 <AS4PR04MB93380FC80BDE1B410825EF2D88452@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261119030534.1892935-5-wei.fang@oss.nxp.com>
 <179541033517.3135.5228725617878780083@kernel.org>
In-Reply-To: <179541033517.3135.5228725617878780083@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-23T05:55:12.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|PAXPR04MB8542:EE_
x-ms-office365-filtering-correlation-id: 457eb5ca-df2e-4843-e810-08df4927219c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|261028144727099003|261102123227099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261021121427099003|261009223027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 gQ5axupeszcPWjNuaRhrAQu/ZIePrUeCm7a4ugez2100QyLjpD2vR4CbIOGniTpGzTOcN1E/DGqiJIpr1XnBKBGq/icnm2SDFwL3KHJf1D6fAaIhY7ANFq0eouze9P/UB2Pz+5x4Dz5iR9jRoosHmJYdwIc0ZBCXUuXbGXy2APAQ/OolQC2IA7NZZYLlu4P5j1LkLhIAF/YDpjS84z5oxFYMdJP88ZPNCkgNMVpCRzHsHADpm6yIvMfGIoeslVs5g9sJIYZI5aJF8h0R7qSeZHeAxRiDn7W7dW51o8vqSVmGwkJjzKIkdWwO4dGkkpW14IzDgRNDSYRwJc/jgBPX00soG0KbjXL4MTBRac6WCo/3gC6vYV/LzWWQKrQooVQJWOtKnjl962FxRLsQbrF+pkwPcHk/LZel+zsdUL8dKg8rD4/GEsvrHYVtPZgmoz2ba72UNRUv9/QqBDAZPQgA48kWvRO8nF6dDZY5qL3lcbc+xxrwR2TaYRmPc4nK9/rcOlZpNmoWjd/AUObm3e3VlQFRRq1dhDRsaOATIdBc5r8OqpgY7qORst2JRCb4cLCknqR7zTploK+dm2/fv/ih24uQ8XDFv7XwvkbIYF8NeUai0qX6H7scAMFO7JxP/RvkXphvGsEKy8BVhCn9CGbR0BxBGQ0HHtoZH7PuNZuMcTTkjmzZhS3P4jfKLbjo7A6VMRnfnR8iMPx3aMPVv9CBiBO/JlmnQ9QehFWUX45nEcE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261009223027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jzAKGTp2ia/LQe2BzD6iyJvPna1R4H9rEsJ3AxVn5qWfnZuBCSExrmV8Zrsx?=
 =?us-ascii?Q?KPwkh/dXwYjhAs1nZbf4q4dakQKXmx0dSGXZCpgvHLmLBczKqYtO9fXwwvWX?=
 =?us-ascii?Q?xvfW2Rb2LhYTihVo3zHK/OrqWuZUE3JSqGSxWgFkIfeNM4fB642lRhn6qHAj?=
 =?us-ascii?Q?IAk+4h6aFuO8hiFVNGvaZcAMFKCCHKm6fpdHAmHIWT1GAZffHnFsoftSlido?=
 =?us-ascii?Q?Lf9bRxQtc02DkDOqbZM4QSxilXvB4dtcJIV3JmMIBw/bPSYudt11J3f17dV7?=
 =?us-ascii?Q?aub1oIVPVFKa6fCfEpSMxet4sd4Q2QIJrPyPUET/Rl/wQ3Ko/okAwrs1RAuu?=
 =?us-ascii?Q?MieG/XE4TN4vqKLEe2U4MC+XkiTpvYRVNyJ59z3C3YJWs/e6C21fxg4adQ8f?=
 =?us-ascii?Q?iPGjD1nuIl9kvvUrG3ImWhmB4CwlwBNNlRD9zq/ZySujtAFbkwgYW9rihgH/?=
 =?us-ascii?Q?6wjZikELn4V1ShCpxLIWFhP6eVnCa4WKbuHBKDe9eKHz8fUtstJkbFjc/Pho?=
 =?us-ascii?Q?xQcuuP6jRcfA6k1BbdX+jTHqvD9TmSykfhFppw8RIclp0C9vTe7P7mGIOBdx?=
 =?us-ascii?Q?2vIQGqzCY1YMlAM/LYF/4frsT9EDVfwy+EE1ECIjCqm6KEWNGJKVbkRsBfnI?=
 =?us-ascii?Q?SyJ7L0wj8RwOD7WyjbtllfV320+N2vbIGFNCGVxHNAbg5nOpzWVvP/1AW9NZ?=
 =?us-ascii?Q?SgvDFMuA8YSuRKpWhiUcC0FRRkaTnPuPe5I2ZJlz6LrlrYJAsEIIu2dAgTiB?=
 =?us-ascii?Q?j1VdJa7Jcb8GRbf164rRMFuCZWIUB+lCQc9WTzQjhkTm4MCITY36/oKLzdDv?=
 =?us-ascii?Q?f2unf7SiptP0RjMENrbu4cs/3av2+sLORXA6EdNgxxEuIiPSz3/xL4qGv0wr?=
 =?us-ascii?Q?/bG8bJsEPSZaQeDZkPF2BFVHZ+kIDDWsBnJQoGTNNZFfX1vvFbt4u9eUXLAX?=
 =?us-ascii?Q?gG2JKi3E2yODhTAEP4+4C25DpJ7eSf3+UKLwDyc4Rhc2aVozVt2I9TjIAIjN?=
 =?us-ascii?Q?esCsQMvAmn38USkiTPDSgW7MxJ7V87le7uj1rraOYoG6LN9jvrmU6DC1wXv9?=
 =?us-ascii?Q?LJPu0J6Sm6gwJ8dXqhbiiBTry+RaVstnGVgXueBdP6tW9hwyz3PJ6z1UIZlD?=
 =?us-ascii?Q?YdIPR2w5zO+pKt5lbOHqMKwpYkmRvC8BSf8ulL5fVn9pqefife0C/OZJSudS?=
 =?us-ascii?Q?RYxro1sEbyRKlF/FrMx6kp/ov36+jrPvtEPTwYBA7bbyWr5YdfIiDi1/b4i1?=
 =?us-ascii?Q?9j8XAzt7xpMITp1Ne+xPS3/p+nhdvntd9kBCY2OsP5gKGSg+ZlOlBr5yKEwi?=
 =?us-ascii?Q?0lkLMeO2ivl6ayDDmsc8iY5CS3w2pWE5b7QmOHPo/lyrukx0YNVLe+TCrKiA?=
 =?us-ascii?Q?sYwhGxHHbAQgdGcGPS93j9XOJgRQIs0apyH5uMe1nVxYpanPpXjwZ4bFbhaE?=
 =?us-ascii?Q?GlPp9HzUYxhna2NuHZu2HwOjL/+fZkUj/s1fnX22Cba+LJgsnDpZG8Ss+jMu?=
 =?us-ascii?Q?4UE3iLWweYe7KPEbEIqSvKHg43RCjn+ZK4xvzaiT9mPeA7cyyQlrb7zm/QgB?=
 =?us-ascii?Q?p9GLv28bQAjv6Cwzac0hKg2yjc2mXLswBzd+Oo9dDQpE00k8a4vhqOTsGXoG?=
 =?us-ascii?Q?zpXKfRAZbtBHBbwm5VrPrmcFZdLOyGxE0t6fMpz4NvsrD2UIP4P9v9ZqH0yM?=
 =?us-ascii?Q?xTrrTi2uk0t3JFQexN9EwXkXpMFxzKMVK6xgMo4wvGkn+YfA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457eb5ca-df2e-4843-e810-08df4927219c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 06:00:52.5845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLFGnTnC9yAvE5MUM+6rZ0ZHoagL2AfOUujttk8UgfSE7uEyAh4/QjrObfoCa5KIOuiVkWCjn8+8gWStShh1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8542
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> net: dsa: netc: tie setup resources and reset to DSA setup/teardown
>
> This commit adds netc_switch_reset() so that every netc_setup() after the
> first one does a PCIe FLR and starts from a clean hardware state. It also
> converts the setup-path devm_ allocations to explicit alloc and free.
> These are released in netc_teardown() and on the error paths.
>
> > diff --git a/drivers/net/dsa/netc/netc_main.c
> b/drivers/net/dsa/netc/netc_main.c
> > index 1225ff8153d44..f724f95add36b 100644
> > --- a/drivers/net/dsa/netc/netc_main.c
> > +++ b/drivers/net/dsa/netc/netc_main.c
>
> [ ... ]
>
> > @@ -1042,7 +1161,10 @@ static int netc_switch_pci_init(struct pci_dev
> *pdev)
> >     void __iomem *base;
> >     int err;
> >
> > -   pcie_flr(pdev);
> > +   err =3D pcie_flr(pdev);
> > +   if (err)
> > +           return dev_err_probe(dev, err, "FLR failed\n");
> > +
>
> [Severity: Low]
> This hunk changes probe behaviour, and the commit message doesn't say so.
> Before, the return value of pcie_flr() was ignored and probe always went
> on. Now any FLR failure in netc_switch_pci_init() makes probe fail.
>
> The commit message only says:
>
>   The probe path already performs a FLR in netc_switch_pci_init(), so the
>   first setup will skip the reset because the priv->configured flag is
>   not set.
>
> and later:
>
>   The NETC switch does not support multi-switch yet, so there is no
>   functional problem today. This only reworks the driver so that
>   multi-switch can be added later without hitting these issues.
>
> Both passages read as if the probe path is unchanged.
>
> pcie_flr() can fail in three ways:
>
>   - -ENOTTY when pci_dev_config_accessible() fails
>   - an error from pci_dev_reset_iommu_prepare()
>   - an error from pci_dev_wait() after PCIE_RESET_READY_POLL_MS times out
>
> In any of these cases, a NETC switch that bound before this patch would
> now fail to probe.
>
> Failing probe is probably the right behaviour, since the driver relies on
> a clean post-FLR state. Could the commit message mention this change, or
> could it go into its own patch? The hunk is still the same at the end of
> the series.

The NETC switch supports FLR, and from the hardware perspective, the FLR
time is within 32.768 us. Therefore, pcie_flr() will not return an error.
Otherwise, this would be a hardware issue. This modification is only to
prevent Sashiko from generating false reports due to not checking the
return value of pcie_flr(). I don't think it's necessary to mention this
minor change in the commit message.




NXP Confidential

