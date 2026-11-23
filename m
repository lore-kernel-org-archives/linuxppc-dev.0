Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF487606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=k7DoTlQY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXww70r3Qz2xqv;
	Mon, 23 Nov 2026 17:27:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795415239;
	cv=pass; b=GPrCCBzXM+SU/MQgxCMX4hzZT9/5GyoXsicdo/wNWmwHV6MycMOmgV9rpHCaTRdyiBFc/ecbQsFWKks+/5Qq9ZIAymsdxks+FYp5jaFFeDJ+9Otnla0hkEi7qvef5oYcU7a40G8+FPioPuZebfl/RaOTo+13tIpzdTZTciyT8gFfFl8nRdUPBgGCMbiOOkMJa/bbIBBlHIsMQje9/tZMDgTLEIi6qMiGw8Pqfi/r3WtwG3HUuuGu8oVkWrlsUP4s6WqbixLf/4k/cyIr7AI3D7cs3SRzfe+UPIVuycszFYRanu721uaFjq3b1rN/PjAwWpZuKrF/IRXRogtR/ZYU4g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795415239; c=relaxed/relaxed;
	bh=YRdDH9kINoiz1JaQ2w81t5CpHPQmhGNSBVjX9i/KTqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCJVUVcpbSUKo688PNR6baMjCidCeOQOLoNbt91UwCn79l2g5ntqJmAkKBPhGYcHwZmQfQs4XU/r6CNqu0EEowuVNxpaV6jgd1qFHcnc4RIvvUDtMavnL5/Yn7bnBzGIgzd5nkUbb2SNnxaEmOPn7aUPaGKG+3BeOPLTg7wIj9VsRY8MDxZjsgStKosCueGYFV4QRkHSuNWwQRVpTg1ntwMnM4+Jro7rEcJ+uz9iXjg0gXIztwoXMc0/ac3+hqZXLN9+5nbFUQPpa7NfzEDtBNwUlZjm+JeFy2YMU0ejoTIcnZgxRJ6ubIeeffEQW/eun6AwjWPl4M2YwQTEj8vX6w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=k7DoTlQY; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=k7DoTlQY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXww56cbfz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 17:27:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmS9hATEpacVtJ04ZmDf3Rsy4Ze3U2GwzdX53dEv4TYDW2cl8/43OaQH5aI2Zoxzkfks/55iiHFlgk33lpRjUUcS8SaQW2+bDzQdt0JoqKGRxAO3YRyru38aGDvo3N8NhgsqqPBQ0jFVF4RLQ2BEhWuVyRnQ8ZffibqVlSCnGrH7UIRXpGXkZCmuS7gJ6c08n3R0MLKK6C/QmflNtrt7RLmB/E9b4oAgK7FETf1QHw6ralcsq1Hg1HzYGOCyJE1fPt2Ru/tMKjfodxLc6OyXUj17Yt0e+tDjC27qoLgYA07vCk3SpfiCJ0Zwoephc4B/IdAu/PqDGqdNDIuReZWwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRdDH9kINoiz1JaQ2w81t5CpHPQmhGNSBVjX9i/KTqE=;
 b=IoU7MDvyerZUzHvF4CCnK0DefVtdn84tSg23hWpL/h3HG1q0UWGvekEYh6O8HAchj3dg7goBDfr8rSQaS9e7YRokROdW/rDDlGS8/S+yTs0narPKxfqkosjuvzxYiAFX8r2SS97Fx0JZBRmYxWBU2Jag7SHrAjxC7oDQSCp7YpGqK59w+e/tVIyys7PnekBd9sKlkdVvKMhWRnQPx1EYanDZBmJuYqMIw/E6V0TemEdErppsuYXScZdB1c8mJBcGHH0SkgPJSlSdd1DAGQv//zZ00PxOHC0mlTdCInsVQSrYYVSzgH+NlaQfCQPGDD48zOfOKVXV1OErvZ3FGSP8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRdDH9kINoiz1JaQ2w81t5CpHPQmhGNSBVjX9i/KTqE=;
 b=k7DoTlQY37nb9Lfr7qiIo7tishrh5pKSC/rDv5t2PptvdnJx9JxzV9ho+pEd2nDoJHmHnM4VWYnQ2pMPv7uQTT/8i+x2kQwKgTzidFJMBXrRW7jhcmIVoEVX4eSnUsyK0sYXmpiRhSCJcX/rLTXylIa/zr6/Apo+jOVRD2Y2pu70Koqt6KYrHa8XDiRBhXb5DJeBWXzoNnxz5Gff3mOuIIKKrCyIMtX1n317QDR8YLVLW8gC5piZaaCpADoCXo2rvEN5EG2qTZuVCVIiHUx/JPMS+wW9tBCCF4Bph81y7HMYtn1hjG9fFLxoml+s3o7+L7EuVKfZIOR9BZI7JRWMfQ==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 06:27:00 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 06:27:00 +0000
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
Subject: RE: [PATCH v8 net-next 6/9] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
Thread-Topic: [PATCH v8 net-next 6/9] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
Thread-Index: AQHdd9I9xYE739+Y9kiAvP2UpdxZMbc7IOmAgAAP/PA=
Date: Mon, 23 Nov 2026 06:27:00 +0000
Message-ID:
 <AS4PR04MB93381DEAD9CDB1718F9DE28688452@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261119030534.1892935-7-wei.fang@oss.nxp.com>
 <179541033709.3135.10401749390258091680@kernel.org>
In-Reply-To: <179541033709.3135.10401749390258091680@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AM7PR04MB7189:EE_
x-ms-office365-filtering-correlation-id: c4f66c5c-5d05-4606-2d75-08df492ac81a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|3023799007|4143699003|10067099003|11063799006|5023799004|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261022113327099003|38070700021;
x-microsoft-antispam-message-info:
 R8L3xtmasCyXpvn7DKt3Svxl26c65IppuHNrmrdDx+LuzPC/Y+ANJxL2KiV3xI+mjkXOa4pVb9HyLrl+jKCGjGN2U4aKHZt7XWjiqTuJwXw90Gcap3B5XhFQGamZz7QK3DVe6WHf/Ctv0PvHi74jz+cZGBVttpJWWw/I+Jabsm5Yw0F7l3vQ8BM8oOepzWNM8OlUXRKlTf+5gclo/84tMHzOkzlYI73LAQnn/jlpOlcKCHcYHWGEzPvczVCRiwNAlkNzZvQaQL3JXstm1z0bMcfLkELMBA1gDab8Vxc0Yr1xZihQITso9XQQlQSjNvEHb9yXppEASr4XAZwSRo6UE3WySSwtCV4//RjGUbVE7/gETDcxqXdvLTUK25QaLVc3yQhXd0syGgNvfFbaqh9Peibkq0l1qN/Lz9TBzXxPbkHzQju+phjh3szQr/xT3gBjLN8jKn5ixoBggWi3KxM1/EhwF8NLj9vabUcJ2ZQ20kuXZYlXUnplAQR6wiKGHk4xc8skNrw7vbg8Sw9Qfcf82w0ZbR95vLlgpk0aoKwqXnDlgGPfMiX0whr/MFM92Y/tuRlXGIQnnGgvb/a8XCLXyKshw7jf5ewlkpB06vV4oRfWRsxs3bcYuyO/CrJ6TR4jMzuPSBAFExSqAQrYhdj8PCNXtAs89CQGlDP3+bMbr5eEP2mfBWzpsC/wqv1d6DzGHpclu5nRIxyWzNdVjbQOOo+CHlAxLCqf4MvnlN4xbKs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261022113327099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ti0IClpUY8eeti32WcTzjaRrh10FbflIdwkaHXu7HbSsHPdS69WivSs8baeN?=
 =?us-ascii?Q?k7XZMw9PXsvNYktRxNJ76qJMimL7E1aQ22E12faAdWX4iU0gUH1civ1JVF+t?=
 =?us-ascii?Q?fkC7HLdf5oWrKhdCrD8knO92CUii3lca7H/8WUSpY7dhiH/qy8q3yZvg9VI/?=
 =?us-ascii?Q?U6I4jUbCzFlCuyNqV46/XADJwiXcSqEO22PlsjdBz96e/NSG44URAss737ZQ?=
 =?us-ascii?Q?omTB0GpUEGlYuL1BeIVovX51NgApqw66GbYrbCU+HQGh5HkADy6aw0QeOjA8?=
 =?us-ascii?Q?6aMIai0NCOrX0Yyh+ENVONeQVv29Z0imf2KxIZK1E+vOfkYBw8buhRXrQep2?=
 =?us-ascii?Q?QA0fNpJf2HY4OOYiol2Eg6/5h4+XOm+WLVJyrfiYI8MHLi8uBtpiHMScqiiJ?=
 =?us-ascii?Q?f+yVlhsxWKrlwwEKzsayqgFxcJifDYEyGYzcu74LYLiZw1cFdH90l6Ng1fj/?=
 =?us-ascii?Q?bJZdy/ecU6R92jeHYDLxBKj7MrgIaxXLCpAc5gsyj5d/Z4cWzKv/B2tc39nO?=
 =?us-ascii?Q?mjqKFcwHe2V0gYDZPy02GE8hFSKgdQ3Yqc4amhLyJFlyc+RRmKm1VboV68ef?=
 =?us-ascii?Q?ywlGO9E9KWvB29G0JVEpyIVhbq+fxkXzadgezrGoeVabKaaWBK4bROo+9qWv?=
 =?us-ascii?Q?TweEGY39O5sMS3HySBbSoPH5qQfgmUbEznpBId+sIs2UOnARL1NoXlUHhGi5?=
 =?us-ascii?Q?dHpBe+bw6KvP24+QZauerGGoLaUCE95fM7HxISb0EDJ2lyTiYhEsHdg/aznq?=
 =?us-ascii?Q?hk1ozroH/t6mkqT16Nq3QjtYnzWWqMQsv9pOX8sjTzDk+BahoGi6YszCSsJw?=
 =?us-ascii?Q?2KdkyPidRlD4xxqQu0tEr5o0U7kyTUmHbVSv7YW+4mmL2yMPvqM0Ngq1Q2+S?=
 =?us-ascii?Q?DprKn3JqnwnFQpHsRrUiPKDECzBRQCtNtQvkc4QlpQATObsYFfuNdX8IpyI0?=
 =?us-ascii?Q?hwguIraIiVz+9KgHDFQD2TZj10U2gEZZ1rT12SgNJNEuiuwVJkW1drljPsa+?=
 =?us-ascii?Q?Pg3aIuZN4XlZrkRxxkA2hDjrpuyysXEY6hryIpu+lJHMyOzOqEwa/sdBPuPU?=
 =?us-ascii?Q?GaUfJ7apaApNvx49QMB3VFDXM8v909pS8q0QKnd/9x6PGg72cRsAFuB9u2bJ?=
 =?us-ascii?Q?BBK/AkWweYpf2QYboNxowLOvv4BOrp+O1KEN4X4HtbsD72aukX/CCesbsPjI?=
 =?us-ascii?Q?FbLTmRv1PTPOciukf04ZhY2Z6uxaDivOWeIbIGC0kXl5JlNg4A3pDkFSO+X4?=
 =?us-ascii?Q?15AV/98zWoGQVbjptWdXYbbEvxgPaPW1HZqjZy7doGvz6vYZbMEB2NX3QAuw?=
 =?us-ascii?Q?p3zpTF2BO4gB/lZb/cuOdCqB8WMbOk/Md/1MxDBLaYieA51QYigNHutS/OlI?=
 =?us-ascii?Q?0wDztSxr3Ev/E606jA1Y2sLtBDyGqO7N0vp+A0ji168KOZqlFA18C8Gdoxa5?=
 =?us-ascii?Q?vGRUj4QwqyqGrWeDF3vPQMqMUMnWIrkw65BFy/xWKRCiz1HAYEfKQWYuQxU7?=
 =?us-ascii?Q?7WRgm0NcVVK/5x1r9YmalvxXcbmjHFW0aHmoURhCFvfirGLYh+9UMjaHAQ+t?=
 =?us-ascii?Q?O57hEnwDcpkEJEvLpFOQ92A6/ttw3ATW9GAc2RlQ6wEKlYa+CGn5jithihYa?=
 =?us-ascii?Q?RbLJDR66aZE8uGk7jTmCFbEs57QWJI9kqAp2tYCmMuwJo3IaQ2cYel+3q2vs?=
 =?us-ascii?Q?s3AJJtWOwqqYJSr2r9yJmSlZ6FK2uUOLyh6b9fkE7hsWMTd7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f66c5c-5d05-4606-2d75-08df492ac81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 06:27:00.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFW7j1tCWV9HnEa+5uQQE+99S8Pyohl/euDKc6fqKfMzW/s6JVq42JoiSKjMdxsQzYkyuNq7ieB4zg6GsDdvLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > @@ -1880,32 +1874,36 @@ static int netc_port_add_host_flood_rule(struct
> netc_port *np,
> >  	return err;
> >  }
> >
> > -static void netc_port_remove_host_flood(struct netc_port *np, u32
> entry_id)
> > +static int netc_port_remove_host_flood(struct netc_port *np)
> >  {
> >  	struct netc_switch *priv =3D np->switch_priv;
> > -	bool disable_host_flood =3D false;
> > +	u32 entry_id =3D np->ipft_hf_eid;
> > +	int err;
> >
> >  	if (entry_id =3D=3D NTMP_NULL_ENTRY_ID)
> > -		return;
> > +		return 0;
> >
> > -	if (np->ipft_hf_eid =3D=3D entry_id)
> > -		disable_host_flood =3D true;
> > +	/* The command BD ring is always enabled here, with the ring
> > +	 * enabled, the hardware completes a command well within 1 ms,
> > +	 * so -ETIMEDOUT cannot happen here. Any error therefore means
> > +	 * that the entry has not been deleted, so keep tracking it.
> > +	 */
> > +	err =3D ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> > +	if (err)
> > +		return err;
>=20
> [Severity: Medium]
> Is it safe to read every error from ntmp_ipft_delete_entry() as "the
> entry was not deleted"?
>=20
> In netc_xmit_ntmp_cmd() in drivers/net/ethernet/freescale/enetc/ntmp.c,
> the command BD is posted and the producer index is written before the
> poll:
>=20
> 	cbdr->next_to_use =3D i;
> 	netc_write(cbdr->regs.pir, i);
>=20
> 	err =3D read_poll_timeout(netc_read, val,
> 				(val & NETC_CBDRCIR_INDEX) =3D=3D i,
> 				NETC_CBDR_DELAY_US,
> NETC_CBDR_TIMEOUT,
> 				true, cbdr->regs.cir);
> 	if (unlikely(err))
> 		return err;
>=20
> 	if (unlikely(val & NETC_CBDRCIR_SBE)) {
> 		dev_err(cbdr->dev, "Command BD system bus error\n");
> 		return -EIO;
> 	}
>=20
> When this returns -ETIMEDOUT, or -EIO for SBE, the hardware may already
> have done the delete, or may still do it later. The comment above rules
> out the timeout, but nothing in the code enforces that. There are also
> two command rings (NETC_CBDR_NUM is 2), and the poll is a fixed 1 ms.
>=20
> If the delete did take effect, np->ipft_hf_eid would keep an entry ID
> that no longer exists. Every later delete of that ID would then fail on
> the response error status check in netc_xmit_ntmp_cmd():
>=20
> 	if (unlikely(status)) {
> 		dev_err(cbdr->dev, "Command BD error: 0x%04x\n", status);
> 		return -EIO;
>=20
> Wouldn't that make the failure permanent?

A timeout error will only occur when the command BD ring is disabled.
Normally, from a hardware perspective, the execution time of a single
command BD is far less than 1 ms. Therefore, there should be no timeout
error. Otherwise, this is a hardware issue. The current interfaces are not
called when the command BD ring is disabled, so there will be no timeout
error.

The SBE error stands for System Bus Error, which indicates that the current
command bus (BD) failed to execute. In fact, if this error occurs, it indic=
ates
a problem with the system configuration; all command BD operations will
generate this error.

In fact, netc_xmit_ntmp_cmd() should not have any errors; otherwise, it
indicates a configuration error or a hardware issue. Checking for various
errors here is to prevent misconfigurations during development from
causing unsuccessful feature setup, and to verify the hardware functionalit=
y
of new SoCs.

Therefore, for verified features, netc_xmit_ntmp_cmd() will not return
errors. Otherwise, it indicates a problem that needs fixing, rather than
an expectation that the hardware or software is still working correctly.

>=20
> >
> > -	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> > +	np->ipft_hf_eid =3D NTMP_NULL_ENTRY_ID;
> > +	np->uc =3D false;
> > +	np->mc =3D false;
> > +	netc_port_wr(np, NETC_PIPFCR, 0);
>=20
> [ ... ]
>=20
> > @@ -2099,6 +2109,8 @@ static int netc_port_bridge_join(struct dsa_switc=
h
> *ds, int port,
> >  	struct netc_port *np =3D NETC_PORT(ds, port);
> >  	struct netc_switch *priv =3D ds->priv;
> >  	u16 vlan_unaware_pvid;
> > +	bool uc =3D np->uc;
> > +	bool mc =3D np->mc;
> >  	int err;
> >
> >  	if (!bridge.num) {
> > @@ -2110,6 +2122,12 @@ static int netc_port_bridge_join(struct
> dsa_switch *ds, int port,
> >  	if (err)
> >  		return err;
> >
> > +	err =3D netc_port_remove_host_flood(np);
> > +	if (err) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood
> rule");
> > +		return err;
> > +	}
> > +
> >  	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
> >
>=20
> [ ... ]
>=20
> > @@ -2123,8 +2141,6 @@ static int netc_port_bridge_join(struct dsa_switc=
h
> *ds, int port,
> >  	netc_port_set_pvid(np, vlan_unaware_pvid);
> >
> >  out:
> > -	netc_port_remove_host_flood(np, np->ipft_hf_eid);
> > -
> >  	if (atomic_inc_return(&priv->br_cnt) =3D=3D 1)
>=20
> [ ... ]
>=20
> > @@ -2134,6 +2150,11 @@ static int netc_port_bridge_join(struct
> dsa_switch *ds, int port,
> >  disable_mlo:
> >  	netc_port_set_mlo(np, MLO_DISABLE);
> >
> > +	if (netc_port_add_host_flood_rule(np, uc, mc))
> > +		dev_err(ds->dev,
> > +			"Failed to restore host flood rule on port %d\n",
> > +			port);
> > +
> >  	return err;
> >  }
>=20
> [Severity: Low]
> Should the commit message also describe this change to
> netc_port_bridge_join()?
>=20
> Before this patch, the host flood rule was removed only at the out:
> label, after the join had succeeded. If the join failed, for example
> because netc_port_set_vlan_entry() failed, the standalone host flood
> rule and PIPFCR were left alone.
>=20
> Now the rule is deleted at the start of the join. The disable_mlo path
> then tries to add it back using the uc and mc values saved on entry. If
> that add fails (-ENOMEM, -EBUSY or -EIO), the port stays standalone with
> no host flood rule, np->uc and np->mc are false, and only a dev_err() is
> printed.
>=20
> DSA does not call .port_set_host_flood() again after a failed join. So
> the port would stay without host flooding until its RX flags change.
>=20
> The commit message covers the delete-then-add trade-off only for
> port_set_host_flood(). It does not mention the bridge join reordering,
> the new restore path, or this failure mode on the join error path.
>=20

I think the current commit message already contains the main content,
which is good enough. There is no need to describe every detail.


