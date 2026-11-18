Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0334C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 04:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Mt3PzOCp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTpHy4RTtz2xlY;
	Wed, 18 Nov 2026 15:18:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794975518;
	cv=pass; b=kU59ILvtdId121/d1OreIVF6/n8GxLQzHeZwXXSj7y88M01WRYvuoJ7werxOwR9PPrcO5RE2OTL+2FeGxsuvM5OzZ6ZoKWgDSI/zlHv0Vhd2s1e9HJUDUxdAyLEmUJZiIrsRqI2cHSk2lODZnJ1zfqaIoBfUojTOZhBVayChVe2GR6l4iUw2lmtdGYlFpLAZcHMquEz5R/s8c7aug8taVmmG8ACDIixhEgGHypHRbDuraBqrhAiaQafN7gCoGJ4Q4CX7fG+0ABgEATOK/D8WTNFhJUChOUmg69PuevSGQTdo/xWl173Jl1RPpjEBFkQCo++iKhdMSXybGZIMV4FQLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794975518; c=relaxed/relaxed;
	bh=vnQPJjjH6hN5V7veicXc949/FeYS+wOHdGFONuB19cA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c2/2tCHNpUSLNrICc21kEc/ZsCyebVHB6LLDHHB6UZ8BLSrWgs56yTNkjSHB9qsyqbDqy5frAWphL06ngIiuqZ2gWd3DdilY58sMU1MuDwktYM19Tdf04pc3E65ypaFoOJoqAzSeCdCOi8mXVBy2tXNOhb2R7kvVos5YBcyfCSJipHGhQg+vyshz3JHJDFyKl4s9J/V+6aqN0aku8UkBdLFhfIHrnypwY9sRK+RFZ5fI+0O3Jr2XBy7XUnh90XKzhMkE2duyCDy88A98h+d6sQL47J7d0skHsEYHGYJW01b3IwK6Kd2kmRPEFc1ZKMV4Mv+A7PH8zkkkOMMZemAorw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Mt3PzOCp; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Mt3PzOCp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTpHx3gZFz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 15:18:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uydlNblYZYNUoRs63a7z0mHvVGgjT8ilEPucWMl9tCdca9i4Nt5gYZ4YNJJNZwntBWbvqoO4fbAWFL9PhzozQDboY7UvyTyo+P58ZvdnNVCYmWi5EJ+ownuk39HvkKe8GeqeowgU2KIuWScD2bhQn4cGZDprtFyP7SVL8PIgCxjGDCd1ZHg7QfFe8IeUYVTly9zvrJkJzfw9piUbMfWFLqWqVQCXkhcs29ZmtTsv/RWJ7sstzxjnMrYqgQLTZyu2fQOFjXZ2lIhH53J2pYJLEEvkwSO51TLWCwm2z5eGIisu8QuZ9dhbbI4sic/5BVRCC4E7vK4ozvsSashIuju74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnQPJjjH6hN5V7veicXc949/FeYS+wOHdGFONuB19cA=;
 b=KqQbVvBaO0zoX2B2cnMWwkIMQsBp23C1ZlaV7PjsXY82iBLLbQfG2aI3lulHPvWC8sjSFNhjzUhx5l8pehNwihIyDCv7nb185eDQstVyGQ2SywimdTJzWpX866fjbPuBGURv2IAGahHlHMfjjV5kmwcXojIA3QEvNLRgezKULXfUcX97YbM6UlajWnRBIWTW4uGnq80fX0OYdlq14+i+81oD/Mahb6zh/8GBuca1bQBCjZIhasfmhjX6sZ1wS3U822Tiv+mMGqLL4jfEFoBqi5842+/flwQkl0WisKVV5bfi3jPTHava1vOEEPWqjhweKpn9wcq7jxAMGYNgI7J3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnQPJjjH6hN5V7veicXc949/FeYS+wOHdGFONuB19cA=;
 b=Mt3PzOCp/dJmMIcL7u+wlWS+ycG+o2DpKhWPTuC/fUj2VZXGwLtDp8x5IIPo2of2LP5qe5UhjAjC1nJ1vvGOiyUH0SVEMsmV4W+1L8D2G0E2vTYD3Hg5ret2WkkgZ0wnTLVFT0BKUh/UdIvXo5HP2I7452JNEo3y5xgwYSxl3fClgBN5u74j4cX3AlFRvEkbejAhQLnXH820yJvafQ1/itDvgxhZdh0xXfUk8E8PejMp1gJZ2xwD3DUp5aPga34GoHDy3E1xj6hShhNReZr4wepyCUmhVUYtaTlKGRrUv3UBuAM+TjiZtf+gJz59qn/9bwnQMzfJ5UXvlZUwF5lD+w==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by VI0PR04MB11940.eurprd04.prod.outlook.com (2603:10a6:800:307::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 04:18:10 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 04:18:10 +0000
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
Subject: RE: [PATCH v7 net-next 9/9] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Topic: [PATCH v7 net-next 9/9] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Index: AQHdcaU8FIWnfsUcvkazg7XTHvzRILcuwWcAgAR9yZA=
Date: Wed, 18 Nov 2026 04:18:10 +0000
Message-ID:
 <AS4PR04MB933806268CA9276C44A5696D887A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261111062753.1397582-10-wei.fang@oss.nxp.com>
 <179472746829.2199510.2714083926199671078@kernel.org>
In-Reply-To: <179472746829.2199510.2714083926199671078@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-18T03:59:41.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|VI0PR04MB11940:EE_
x-ms-office365-filtering-correlation-id: dc2fc065-acab-4e5d-0bdc-08df452af4c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|38070700021|10067099003|5023799004|4143699003|56012099006|261026140227099003|11063799006|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 /nmp85ks+s7wa3zg0jPfeIJ7TzOdxARjWrkkif6Iq/CKuDVRI01WZFh6sV4SyDTajUE8+WOLXRMETdy2qqTiAa4+wt0vZtI6gHoZvP8lGVt2wmow3G8eXsgEMDcZAOLSgaz+8oQjUywcDafZd32mq7fH1kmhGQxBahMdaftzpz4cY9Ku5wPr+p4c+urLSAJlFkZno2E7qojRYec3B+nq5uZAMITvErWC2xDsQEIEFMV5OuFaAOROEZvEH0v2geEKyXtwvw8gUkNMOXudT/LwFK041Nput2E5Oryd5l7tU1G3I2psULu8y6GvR3YzzYJ8fQT3SDlz+bNj47xjorL24fKH3s9rxroSfxwV4tJfg2ZmAbUbDMcU6pUxflUzQX8OFCMyzgVLfZGMw+ahOTcy++K4xtivhQLMmkNFqcIc5wjE+viylG1pDOvkvERVbWb6vQ/3T+hfJVTKv1vZbJCOKtGWxis9ze0It4BwuEFbdabd1CUhA2R9w0bqoBfQrwuxkUFjAS+92NglsWW5AJRswiqHn1Rsu+MyousA9irFAmLMZjfQcMrP4LHh5WlPASpErArRKw8kXAv05QKzDCypabyi7Tow8pcVK60p3JQ/ZEZrnXJTNxr0QV5ZklO3SZknPk9QE+Es6hb0GnbaaNATh72ItPgQkldtzx6vaM9qv28Ed2oWQZUstQ5tT3VqBY8DbhM3ZZM/RfgxjkLTfVUpXsBVSz4FokBDHDCzNWF5QIA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(38070700021)(10067099003)(5023799004)(4143699003)(56012099006)(261026140227099003)(11063799006)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8kFfOKaWW0q9QZn6zTqS6s0/h4ry/YTuOTfv4VOCZY8xFnlCXmhzNOPFLmwX?=
 =?us-ascii?Q?9Fh1jreuNDAiyH7yU+WluMxk1lyvIUYBV7kTlTFVE5iwfJ2S5N+nOSUSYKqy?=
 =?us-ascii?Q?HBCAGoav/qWYw44LZKByHnJRNdRhiXLnSJLaBqZvG+4LmMa8iZavIrREipoj?=
 =?us-ascii?Q?tkxUc8GVYV2KYrWijsy2nTCaFcvvmqap7QtjRylm8WItZXokf8H6sQ1jNh6j?=
 =?us-ascii?Q?VH4tZbZbdjBUveABYLYkwvklGvlWbp41hnVp7ygsTKhKu7NGuO1Fzte+xHJd?=
 =?us-ascii?Q?wUUhv+gCjTuiR9l6f+WaEXZYAgRGOCegXUNAEnNuyyM+wH6dNo3kV+0hiWFE?=
 =?us-ascii?Q?ioPNL2msV4n7R/bUXk64DqGu+ZNBwmCQU5tBRetVPXT/wrm7jBIeEJ8ZQJjR?=
 =?us-ascii?Q?eRsUTyzHz+w2u24FYY1RhrkDqg1poAQ/hXbdbQ+pdRoR0yqPU6Nazbr3fXd/?=
 =?us-ascii?Q?RVyoSU0dybjJlaZBXEbbYgVdOt12yE6Jd0iSdB5TlwfQOroyZf/R8b4dU9te?=
 =?us-ascii?Q?u2+RUNXMJXL16Vktff7dOe+vm+cF+wBel1aNbKlqhYG9fqeun2KunbBU7JXC?=
 =?us-ascii?Q?e7ptJy1pfHdxtL0LB2QeTcmlqU//vrjbcXdeCpA12Gf5kmgSWo+W39YrGn3T?=
 =?us-ascii?Q?JoJkhnbGKGtd3qlpcq6ai0igeIth9acunHCNpeJzde8lmRi1o4q8IxWnqmRk?=
 =?us-ascii?Q?3gbzUCyHe83gCvQ4Sib7YwJfhYFUHBu9LdkWgte+UTI283AA9/K5uJAoHrXS?=
 =?us-ascii?Q?YJVsmS2W+fLt4+YXhGwczk7ZxUBSng/XH9aFmsY8UtwaGIvJielSQsW3mzih?=
 =?us-ascii?Q?JeVpevZXvqFEcvYFIWqynHCS4wQge6FekB6ycQgvvPv5bRQzzxuMo+QBooeZ?=
 =?us-ascii?Q?Ise5H7OkeB/eaOr7FPxAcKR2uZUoWfG6km5XbA8NyQg6/GNFxxtRdQYkGiaA?=
 =?us-ascii?Q?fsV3uVEatjMjrK4rS59VvJ+Ddit/JomvWtD4wqra+A0ixaJ+fZKAYRu5tHgM?=
 =?us-ascii?Q?RgXdLDaurGUxx5/bW8ZXDeO5/gABTWMu8vaAJxv2i0vp0uY+mv+321zjTEj3?=
 =?us-ascii?Q?mZl9sPcX0okq/aCJw2ll3g2XYx+kO7raVhzNeP5NW/Qa+fN4Proy0LZqTQM8?=
 =?us-ascii?Q?LzMmSKHQNiWvQ/lLh93IzdVVdlT9JDy/1+9j9UykQPlfN9GVu0pOvQTX1bfu?=
 =?us-ascii?Q?6o/XLLb5JOeMNNWO0MKmVM0bqKSrOqO0x4qgHp/GqSa6Lxy2w3g5ifUud9we?=
 =?us-ascii?Q?mDlsjGK5eZxpN+gk14abBwCqiUTKoc+/HOveaVUNkpDZKGGDG1fx1AeKzRNY?=
 =?us-ascii?Q?UA2QF1ZDqa6MtZJ+0OPRLG1I3lEf1Qvc91TvWODtiJydwnDH1FVBEbe3bq8M?=
 =?us-ascii?Q?f3//QbMakwscpyatlFTrMQv3BjmVHB4HSwyaNj6e9KSTKJ9aTODGxD5EHYI9?=
 =?us-ascii?Q?Fwphpybm9jwCG738HWqigaHFn11RftmKjD1AqQUPczrEEYtHKJ5rp0t0B6rj?=
 =?us-ascii?Q?aWIBTMYztShTe80oAQyEnAugUnqXumb2hZ2WPUBY2XnfKdVMDuEDCe7sE+1b?=
 =?us-ascii?Q?eBQPBhYJuC+E5CpPDHBOpyS4vURxw/GND0oZfkGIMp18xmcc9zWA/1GtFYUq?=
 =?us-ascii?Q?4BuGKSUs2kRO8CVeBohTHNjGF9TIbBYouKItdtfZcaccAB54NgdZcX+DUXad?=
 =?us-ascii?Q?4VYjbOLAy4AuHIjYNusc8Ztk5ADx9GmFeC5J6aNQiuZHEbPb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2fc065-acab-4e5d-0bdc-08df452af4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 04:18:10.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dY9VP5y6eUds2dxVWpFgqr6cDJPFQL6fkvg6KRUDWZ7mNmP1fE4S/rdn0fxK6ktH2UTjmZYITTwts/b6PVsgqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11940
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > +   if (np->onestep_state =3D=3D NETC_ONESTEP_IN_FLIGHT &&
> > +       time_is_before_jiffies64(expire_time))
> > +           return true;
>
> [Severity: Low]
> Is it safe to treat PM_SINGLE_STEP as free based only on elapsed time?
>
> After netc_port_onestep_work() programs the register and calls
> onestep_sync_xmit(), the tagged frame may not have left yet. It can still
> be in the conduit qdisc, the ENETC TX ring, or a switch egress queue (for
> example under pause/PFC or a closed Qbv gate).
>
> Three paths seem to reprogram the register without knowing whether the
> previous subtype 3 frame has gone out:
>
>   netc_port_onestep_sync_enqueue(), once netc_onestep_timeout() is true
>
>   netc_port_tstamp_timeout_work(), which sets resume_onestep after 5 s
>
>   netc_mac_link_down()->netc_port_disable_onestep() followed by
>   netc_mac_link_up()->netc_port_enable_onestep(), which sets
>   NETC_ONESTEP_IDLE without tracking frames already handed to the conduit
>
> Suppose the old frame goes out after the register has been rewritten for
> a new Sync with a different layout (L2 vs UDPv4 vs UDPv6, or VLAN vs
> untagged). Would the MAC then apply the new correction offset and CH bit
> to the old frame?
>
> The NETC_ONESTEP_VALID_WINDOW comment says such a frame "is already
> invalid, whether it has been dropped or not". In this case, though, the
> hardware could add the residence time at the wrong byte offset, for
> example inside the IPv4 header or the originTimestamp. It could also
> update or skip the UDP checksum wrongly. The frame on the wire would then
> be malformed, not just carrying a stale correction field.
>

Old frames will be discarded by the receiver due to format errors or checks=
um
errors, so there is nothing to worry about.

> This depends on when the hardware latches PM_SINGLE_STEP. That point is
> inferred from the commit message, not checked against a datasheet.
>
> [ ... ]
>
> > +void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
> > +                               struct sk_buff *skb)
> > +{
> > +   struct netc_port *np =3D NETC_PORT(ds, port);
> > +
> > +   spin_lock_bh(&np->onestep_lock);
> > +   if (unlikely(np->onestep_state =3D=3D NETC_ONESTEP_PORT_INACTIVE))
> > +           goto free_skb;
> > +
> > +   if (unlikely(skb_queue_len(&np->onestep_queue) >=3D
> NETC_ONESTEP_QTH))
> > +           goto free_skb;
>
> [Severity: Low]
> Can an unprivileged local sender crowd the real Sync frames out of
> onestep_queue?
>
> SOF_TIMESTAMPING_TX_HARDWARE needs no capability. ptp_classify_raw()
> treats any UDP datagram to port 319 as a PTP event, and the sender

I think this is an overreaction; ptp_classify_raw() is designed to filter P=
TP
frames.

> controls the payload (msgtype Sync, twoStepFlag clear). With
> HWTSTAMP_TX_ONESTEP_SYNC set, such frames take this path:
>
>   dsa_user_xmit()
>     dsa_skb_tx_timestamp()
>       netc_port_txtstamp()
>         netc_port_prepare_onestep_sync()   /* NETC_PTP_FLAG_ONESTEP */
>   netc_xmit()
>     netc_port_onestep_sync_enqueue()       /* shared FIFO, drop at 512 */
>   netc_port_onestep_work()                 /* one frame per response */
>
> These frames share the single per-port onestep_queue with the ptp4l
> Syncs. A flood would delay the real Syncs, or get them dropped once
> NETC_ONESTEP_QTH is reached.
>
> The same sender can also send non-Sync event frames. Those take the
> two-step path and can use up the 16-entry ts_req_id pool. Then
> netc_port_onestep_work() drops the real Syncs when netc_get_ts_req_id()
> fails. If tagged frames are also lost in the conduit, the queue stays
> stuck until the window check fires on a later enqueue or the 5 s timeout
> runs.
>
> The ts_req_id pool exhaustion already exists before this patch. What is
> new is the serialized one-step FIFO.
>
> [ ... ]
>
> > @@ -409,6 +718,67 @@ int netc_port_hwtstamp_get(struct dsa_switch *ds,
> int port,
> >     return 0;
> >  }
> >
> > +static void netc_port_prepare_onestep_sync(struct netc_port *np,
> > +                                      struct sk_buff *skb,
> > +                                      u32 ptp_class, bool *twostep)
> > +{
>
> [ ... ]
>
> > +   /* Ensure the buffer is linear and writable so the packet can be
> > +    * parsed and updated in place. Otherwise, fall back to two-step.
> > +    */
> > +   if (unlikely(skb_linearize_cow(skb))) {
> > +           *twostep =3D true;
> > +           return;
> > +   }
>
> [Severity: Medium]
> What happens here if the frame really is a one-step Sync (msgtype Sync,
> twoStepFlag clear)?
>
> skb_linearize_cow() makes a GFP_ATOMIC copy whenever the skb is cloned
> or
> nonlinear. A clone is common, for example from dev_queue_xmit_nit() when
> tcpdump is attached to the user port. So this can fail under memory
> pressure before the message type is checked.
>
> netc_port_txtstamp() then sends the frame down the two-step path:
>
>       if (tx_type =3D=3D HWTSTAMP_TX_ON || twostep)
>               netc_port_prepare_twostep(np, skb);
>
> netc_xmit() then gives the frame a subtype 2 tag. On this path
> originTimestamp is never written, PM_SINGLE_STEP is not programmed, and
> the correction field is not updated. The frame still says it is one-step,
> so no Follow_Up will be sent.
>
> Would the slave then compute its offset from whatever originTimestamp
> user space left in the frame? The socket would also get an unexpected
> hardware TX timestamp through skb_complete_tx_timestamp().
>
> The commit message says:
>
>   "Frames that are not one-step Sync still fall back to two-step
>   timestamping."
>
> and:
>
>   "If the originTimestamp field of the sync frame is not in the linear
>   buffer of the skb or the correction offset exceeds the hardware
>   capability, the frame will be dropped."
>
> Should this path drop the frame and count it in tx_dropped, like the
> offset check further down? The ptp_parse_header() failure falls back the
> same way. There the header is incomplete, though, so that frame cannot be
> a well-formed Sync.

From a software perspective, this is a trade-off and cannot completely solv=
e
the problem unless skb_linearize_cow() never fails; otherwise, the driver
cannot parse the message type. The issue raised by Sashiko can indeed occur=
,
but only under memory pressure. Once the memory pressure subsides, PTP
synchronization will return to normal. So there is nothing we can do this i=
ssue,
I would like to leave it as it is.


NXP Confidential

