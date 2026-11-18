Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E2606A325
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 04:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=U+vYH3kX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTpQh6sP2z2xqv;
	Wed, 18 Nov 2026 15:24:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794975868;
	cv=pass; b=kcyFoz7FWjAuC7MGgx//xRFOAraeIgRcaHTLDRDvdXxGvlnSCLlYHDhF62nXVFssC03plbvwqaj+SldFlqPxbf6t21wQFvtauiiWmDb9XZB4fxNrGSznl/5hSSLhO3YUnHmzsTS9Se7nxi4RX138nDS5YCUdwrH8IPlbY/6UtenrfUa8jAfhsD5VbT3A9WIU/2ES9RSNqflq6PGeU8QkwK/RHFVeVbXXTf/uiqMzCpWFjIv0S4AinmiKynlGO5cGef1aoPZjQ8GXZOAfSfn0I9NctUyMpkG38Uga/YmvLcGfIHvc+ChIeZ7fg80O8IYs94xOxhbvVV89BOCmy8P3cw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794975868; c=relaxed/relaxed;
	bh=4MjRG3TLW1v4YlU9r5k7pH4O2XZ1LNGrs34K2EFdv5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZdhB0qrbYPllz2p8mPf+kgjeuHERiIS6e/7/TgCL1Y19u+I5svPIaynjetvhM1wUvpwFgpg4e6Zw1nF4oIEn+xBpcHtRqii0zCaAw+CD0t+qPhEgdXCphlnezr65gHO7qj+dRkaV1n7ur86b4Dy4XYzM16w1bpsL9X295s+TzNF92NcGQAGyjgsm4eB1BcUUE0LDxfEdtnX37GhrVLDx9Qd3KqkOoKZibwY4m+3dqUK4JxX/EZA89AVvhGZUJhtrBNNHJXr5xYqNCM4vXRWP4kz0bnNNtE/mnup2+IDGRSc83Ad8JJBffpXcc2qrzm32EwCBSx2ZZa9Pzp35OKPEA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=U+vYH3kX; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=U+vYH3kX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTpQg4xsVz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 15:24:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3ZMOxNIils3A9mbWeVaHvyZHpoM2K90pgNBnqHBZfT95eoebcx+RLMBHFDrDoFtLoVdcWsvyKdCVXvMS4xQiN3v7NPfy2/pci4Q5lVpuN3eiRYA7cwRsfE7I7wW0uudkqHdHjA5+fOQ1inYWzjFy0rzGToAWdLub7W9LqZUkC6YFGGR6pCIJv+uVvy7t5oLM+g+mRLSb/B4JOt6UKCdnUsCvNsSJEVoryZdPi57+6h49FjPUS/zXCjVGgG6lBjytiYwOWTi1UNXjsNiN9V3GZpYLCs4XMp7zaMJt5ULUxoCxavMY0wbnW9oO6SWwkWLBcdlywJM5o6j/dfN3GRepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MjRG3TLW1v4YlU9r5k7pH4O2XZ1LNGrs34K2EFdv5I=;
 b=dzCzHLwmp1bCsyzmEnkhpIFhhmV0arVlWRL2J5mzaj/hH9xxpj722vhoWSmM0zaFYNuK9UfMD9kuPJ9Yb9pNFzB7Tvr+8q2RpZUVBwMIshFa4LDt8jyq+gO9DCVir3k42AIQRj9b1f6F4S/4lkIOCqgtmvMFVcb9HO57GmxWkTlDukBjGKit4I+/kkIIcEcPSlWPsc4krhY1D7xy0WWe8Hzw5UBSSkny4JiEmteZO8TAWSNi1mWpIGqqq5CP5w9cE4MWC1DaHuyZ/f8YODX/AaM5uayQ1bzjk5lMEfWp2rqQlF9uBSaVjl4CNUpv2TWQf0IDLKUNsgUxBR5bmVmfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MjRG3TLW1v4YlU9r5k7pH4O2XZ1LNGrs34K2EFdv5I=;
 b=U+vYH3kXUI2SSqLHkl8yIMiqsn+LA8yRTYQkPBkfAEngmlByWZp65EdfDsxXR8NKK5VBGiWXuToDi+8+eV+IPHDZOIT297J0RVStC15SnGOZKqoE0Zn6xIoWWjBs7BAETHTzTkDL1hLZbHr8C36Q8m2fgtcLz4etoxMAey2ojpNNTScaFtqU3Qix6p/DH16hk2Q8NptKY47dMs0MV1CzMoDttRPWCvOooYSGlCzbJC3BCSnqfSo4I8w3IzEwf7tTN5M8Mpd7vHcU7V8V44X9UoRqQHKbf4EIYtuq0NiX7lgNwdpDnBZrLrzjKkTeIEMgceUBB7iPQVv7W7NBUsmUzA==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by VI0PR04MB11940.eurprd04.prod.outlook.com (2603:10a6:800:307::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 04:24:00 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 04:24:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 net-next 0/9] net: dsa: netc: add PTP support for NETC
 switch
Thread-Topic: [PATCH v7 net-next 0/9] net: dsa: netc: add PTP support for NETC
 switch
Thread-Index: AQHdcaUbCEw420b0TEa1e67jj7Uo/bczROnQ
Date: Wed, 18 Nov 2026 04:24:00 +0000
Message-ID:
 <AS4PR04MB93388587139E3C5D7240A030887A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|VI0PR04MB11940:EE_
x-ms-office365-filtering-correlation-id: 47ada314-79ea-4414-8d01-08df452bc53d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|921020|38070700021|10067099003|56012099006|261102130727099003|261026140227099003|11063799006|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 3dEfdYumt6V4nqukBeThCt5MEfqBgsb97vLL+xc12gDbxL8tC2cPoNbbPtM1rTFUi+27hjKZHGWNOaCDUyTfnuocyPJuSYD+KUaPwEODqxLlj/iY5KPh1Z5haL8c3fetV7ken+Gt/R+yqOHh/d3dEcv0l46eu+jsgygityB8QlPRUeqmsmjTb1CcU/2HnwfimgSInGQMAsFWZ8bF/BqyfpXoSL5cx+Ymj0AFz4oWrftTcu2IAmagW4AWVUV0f0JkO0HQEIm1i1Q20x3JwdrieWAVZr4Sdp+LaqG/+0BvRZdwpo0hmXqVGycCmxVfUWi7pR5hPRgGHORgoMp5LvoBOgYyP8b0txssVc+NFy07qmwp2nxz7w6QhqMpYGrPJGkajR4EIVKbkLOZt+k6TzK8eCx3vf2c9KAEGGjh4Dkq0oX6DnR79psjb4w/WBz13490XTF1OlatH4N/uWmKuPaOQ6g+rYD7iWXI9ocQwRxZkeV1N6CYx003dMDQ1BnXEqCb6WOc3Ey7XDS8beERw43/z2Mi8wqg4Xwspgez8JBr/CauccwLHaVtmXcBm6LFfeHRDj3+K3+iVjUXlWoseuC/PY5NuyZkHN5oz/JVujwY3v5D4EjGQsxYlMgUdksTnydnBvUSKFdzuzYFdIJcCO/lUzGpqoH2LuDH1qJ2TRetnbM43uyGMVBWWfe+R5A9+G0d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(921020)(38070700021)(10067099003)(56012099006)(261102130727099003)(261026140227099003)(11063799006)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XUXeajxnYKMK/gxtq+rSA7koZEDHH9e2tjWnvWEphkpJ+0VJKXIiDjncCAHA?=
 =?us-ascii?Q?Zn7jjEYykOURccAW1YDmdn8v+IeE6igiGVgwnKYRXNetSA4cv0TqQovkX45y?=
 =?us-ascii?Q?EEOljMWJYV7zaBU8z0K939fAtJSspOMrJGbKcd+2qbbufLD+9DTPLkIPS9nW?=
 =?us-ascii?Q?g/guE0YucieeYKZECXgzEWL2Yq2OOB/Nv44sD5kvHdjyfG2xRIQyMMNvPA4x?=
 =?us-ascii?Q?4H8tz9e36vmXEIv11YdGmqP9+zf4yqEmeyvb7BSoxx6zAq6eWfBCPd+/C4/z?=
 =?us-ascii?Q?bcUsUTBSw/or/Q1+vcR9J9RIg48z3dYBCVD1jW408jD7QuICdzJCtEESzIrO?=
 =?us-ascii?Q?pOpU83hSqkjuAu8dt1LmfJfLzMrQHnnuOYBzRzy9DBbDD1AFM1vvb24mEn9c?=
 =?us-ascii?Q?58ebvnRjivdCqzINMKL5dzpmMN1Z0A+1vxbRrbb3SV0WqD9ANkZ9bcJt3V4J?=
 =?us-ascii?Q?WzrqYEGJe8N0/DfvDskQQkzr8pZkZ+84B7ylPHw2aG1URMQCPTyir4nPcLRE?=
 =?us-ascii?Q?+iwTd8VYW2FXSUftA8TCjzOdWdN0R0cGvOJS4fsA4765KSNRPAZNo14RU3yQ?=
 =?us-ascii?Q?31xwyyOcj7BAU5OeAfHNxmfpGLzIQhi1N8CAnwtOkFukizeMa4kSv71cNAF0?=
 =?us-ascii?Q?NcU8qIgQD+N035TqDO7lS3RqjEfvLeQXSqQoRdYR5XYGes10bDwL9iFoBoLu?=
 =?us-ascii?Q?Fw610HIwPxU9FoekCrY3Vy1yMbpyOCKhm0OwvO4TyZ/nXrwO9yTekWVjKyGj?=
 =?us-ascii?Q?wA2nVbwWuzph7cQkFtZ3KsxPdaom0uP8oP2cXuMlgKjeH2thwOur5R5cdc9c?=
 =?us-ascii?Q?jZEFF0coKqHbsvfwKO57vfS9ZVKDBHch2/YIZuk3F0m3WCYVJwNrQJvYTqX1?=
 =?us-ascii?Q?dQHTIZ/rDKVSnZyUAnOzpJDuU8Be5RE/iuOjplzGtlUE6r+m3vP7Gmn/ZyF3?=
 =?us-ascii?Q?18EcyMibhJbDU0/qtJfU4UHOqxgRVf4ljv1IOXHaFvwWr5eoaztpgG7tScPV?=
 =?us-ascii?Q?0uXvWbmr2HVHLHBWA4LIMirNuFe2A5dmlaSjz8yDhPyiu4y0w0IryBHLPkMW?=
 =?us-ascii?Q?7y9OBSFAfPa8A2/Tcc5+obZXRGLJVOVfjZ9GVxKuWtPEhnRFrn0lhYsTEyoW?=
 =?us-ascii?Q?7EFT+z0u2DmuemKmkcYEUSoN2uc+2d1YCSpaq2qEFnvUQ0dVbZY0hcCcKF9t?=
 =?us-ascii?Q?XAUNo6GyLO6GoWj/TbmuLI2P/ZaMk0WVcSVfQ7eXURZ2HrQU0jdrFtgZLXeI?=
 =?us-ascii?Q?ef3j/2GAGTrYlX1hmV3nbIT1t5YJWK4PFAk5OV229tMLyG2tT75gYmGfRtgo?=
 =?us-ascii?Q?LJiLrBSAwWMDV/un0tPBHgbwW85y4DlfqvTwSpl+KY0VDFNjeG+x+g3ufXAX?=
 =?us-ascii?Q?v9hXWnoCA0jCbZtdIrLOcqgawyCzvPoLucHlgWayaCy8ALi98BWxfkW36/Aq?=
 =?us-ascii?Q?46cgqEBD32M1+pn4nKeTouat87QqoRYhj9Qct2zqFFsZO9DLEWp/mHjUJb11?=
 =?us-ascii?Q?qzEEf8HS0oQ7SdrJkW1dKV0tKzZ6/Ar6CKFE34Xl8NnD+Mbsud9lzm7mzo2W?=
 =?us-ascii?Q?Mk4zp8hO1UYzU1nfo/fShZfXy40o6hFbfHICjqYFSPpdZrG6L0A9ZExyXjUd?=
 =?us-ascii?Q?8TI4aqkVyFUW9BQ17IykHiKojBAOW5qYWAmTUgkJw6Fv09Bglys1paSaqmWY?=
 =?us-ascii?Q?NhujGHISDN4idXOTytngEg5tYcw083vOqBs0qq4n82tcHpok?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ada314-79ea-4414-8d01-08df452bc53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 04:24:00.4362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04H1MQE2yxfMkEdL5dK2igc6UiDZ0WxXCFrqHXiDuOUJXdIxpJG1IXUpT3JgKh/eNEuJwg+eWOS9AwAWGcy2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11940
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This patch set adds PTP timestamping support to the NETC switch, so that
> the switch ports can be used for IEEE 1588 PTP synchronization.
>=20
> The NETC switch has no time registers of its own and instead shares the
> PTP time of the NETC Timer, which is a separate PCIe function driven by
> its own driver. The first 3 patches prepare the Timer driver for this
> role: tidy up its 64-bit register access, drop an ineffective reset, and
> export netc_timer_get_current_time() so the switch driver can read the
> current PTP time across the driver boundary in a race-free way.
>=20
> The switch redirects PTP frames to the CPU through the ingress port
> filter table (IPFT). A few patches harden and simplify the existing IPFT
> and host flood handling first, then enable the ingress port filtering
> lookup by default so PTP filter rules take effect without extra software
> tracking.
>=20
> On top of that groundwork, the switch driver gains RX timestamping and
> both flavours of TX timestamping. Timestamps are carried between the
> hardware and the driver through dedicated switch tags: the ingress and
> transmit timestamps ride in To_Host tags, and per-frame requests ride in
> To_Port tags. Two-step TX matches a queued skb clone against the
> timestamp response echoed back by the hardware. One-step TX defers the
> Sync frame to a per-port work, where the driver reads a fresh PTP time
> and writes it into the Sync frame's timestamp field, then programs the
> single-step register and transmits the frame so the hardware can add the
> residence time to the correction field on the wire.
>=20
> Together these changes let standard user-space PTP stacks drive hardware
> timestamping on the NETC switch ports.
>=20
> ---
> v7 changes:
> 1. Rename in_probe to configured in struct netc_switch
> 2. ptp_ipft_eid[] is initialized for every port, next to ipft_hf_eid
> 3. Return -EOPNOTSUPP when netc_get_phc_index() is negative in
>    netc_port_hwtstamp_get()
> 4. Initialize onestep_state to NETC_ONESTEP_PORT_INACTIVE in
>    netc_port_ptp_init()
> 5. Drop the netc_port_enable_onestep() call from netc_port_enable()
> 6. When the frame is not known to be a one-step Sync, set *twostep to
>    true instead of dropping it
> v6 link: https://lore.kernel.org/imx/20261103021024.3121936-1-
> wei.fang@oss.nxp.com/
> v5 link: https://lore.kernel.org/imx/20261012095924.1129312-1-
> wei.fang@oss.nxp.com/
> v4 link: https://lore.kernel.org/imx/20260918072852.501420-1-
> wei.fang@oss.nxp.com/
> v3 link: https://lore.kernel.org/imx/20260831082335.1184605-1-
> wei.fang@oss.nxp.com/
> v2 link: https://lore.kernel.org/imx/20260808032146.2335723-1-
> wei.fang@oss.nxp.com/
> v1 link: https://lore.kernel.org/imx/20260728104548.3301214-1-
> wei.fang@oss.nxp.com/
> ---
>=20
> Wei Fang (9):
>   ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register
>     access
>   ptp: netc: remove unnecessary pcie_flr() call in probe
>   ptp: netc: export netc_timer_get_current_time() for cross-driver use
>   net: dsa: netc: tie setup resources and reset to DSA setup/teardown
>   net: dsa: netc: use entry ID instead of pointer to track host flood
>     rule
>   net: dsa: netc: check return value of ntmp_ipft_delete_entry()
>   net: dsa: netc: enable ingress port filtering lookup by default
>   net: dsa: netc: add PTP two-step timestamping support
>   net: dsa: netc: add PTP one-step timestamping support
>=20
>  drivers/net/dsa/netc/Kconfig          |   2 +
>  drivers/net/dsa/netc/Makefile         |   3 +-
>  drivers/net/dsa/netc/netc_main.c      | 404 +++++++++---
>  drivers/net/dsa/netc/netc_platform.c  |   1 +
>  drivers/net/dsa/netc/netc_ptp.c       | 895 ++++++++++++++++++++++++++
>  drivers/net/dsa/netc/netc_switch.h    |  67 +-
>  drivers/net/dsa/netc/netc_switch_hw.h |   5 +
>  drivers/ptp/ptp_netc.c                | 136 ++--
>  include/linux/dsa/tag_netc.h          |  38 ++
>  include/linux/fsl/netc_global.h       |  10 +
>  net/dsa/tag_netc.c                    | 228 ++++++-
>  11 files changed, 1619 insertions(+), 170 deletions(-)
>  create mode 100644 drivers/net/dsa/netc/netc_ptp.c
>=20
> --
> 2.34.1

The code base of the switch driver has been updated, so this series
needs to be rebased as well.

--
pw-bot: cr



