Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LAvV9Egm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXx9F2q5Bz2xqv;
	Mon, 23 Nov 2026 17:38:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795415921;
	cv=pass; b=KzOUzSeHQHW6KcCEnNVZjUGQqLwZ1uMahxj3KhBfyh/cveaCJ0At3W1+HUmHmM7yUg+50J615Bl8BMeBZ9zPLIBum2FK5NAnvkxisMPyUsxIFH1QhWfFtJbNO1GMWGeZ11Qeh2r95cl9c/EUF1tfu9RTbqOVVdhyErVkJhOolP2cnc5xY5WPkWLat0TQ0ntrFnbzTn/lgPw0ASqYoAi9umpJbKz4kW18CAAfGsn2TvCQjXaO4NoQKxr2M32HnBUctj1b0fGcUQNwYQEh9dHOdw2uWXPIbilmr0R/sX0jkK+OxDu9bvhaZefctR/FoEGv/jwQdlsAYXNZ1olTimw7nA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795415921; c=relaxed/relaxed;
	bh=kVEBj/OyEAp99ErMEz3ErQ6TttANznsYWFxVX5CjnwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xw/Lf2vvjybsC0xGJulcDQdblEZ3SjKi2xZPDaGD3RnBxkU454VEmwGAMwkzlNHRrXyolQBxCY6PDC8L6AInQsaBwy474vlqzCLEmUq89chhXIjHI/VaKZnYZRCH8dyaU9o2RE5dDLHyurQYsrl2MLq9XiOyu7AdbyN1C6z7ClY/F10W2D/mOn1mOdNfpFIL/CbyqHZo75bBhTb4Adc2zi+hcoA3zBQTzWN2DY6Xku1CDMKIC7Ajg6KmBWONYuWcJXE+SS5KqkQsXqa7eBCr5XlUjnMkvU1FDHCrdIU0I4m/bZrgHe1tW+NQpkkUBZ2GppcTwuFXfktb+o51NIDbpQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LAvV9Egm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LAvV9Egm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXx9D14QTz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 17:38:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZwKg9QSOx6WItTWpLLgAwXRW2ganJe+wg6yBoy8EIRJvHaA9NU23JCo0PoHyVVK5RCLiN6BYbMnyn03ywCoub4PLnyFVtIL0zstLEYFsgPD7fsegBJsYjlAZ4aGi8YYnDgoyoGpUmLWxKLE9Rb1WTtPPbtKwWuUKAqbal1p/Zhcd90aWqxwzSQd3c/wGrDUopWAJiwix0Z93HV2OpnfkwYfInfVzsyxYWDJwKpqcL+P/q4UMHoZqABUSjRhJZpypuX2q1BtZ8TT2G6TS/a9UH6D5FWISgLBmFIMAB0cxcIUwO3uZlIjVRs61t7r7CKRG2+IKLTOacAC1XWw7/BYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVEBj/OyEAp99ErMEz3ErQ6TttANznsYWFxVX5CjnwE=;
 b=s8Q36y5zDeOLqUFubKMirwQHwMC3knQysTi2RS/uC0V1KYlIzniQGuskI2ehQ8tuN3+BXqozc3E4xuR1wkLiupjEn9TNgcwsOp2qwDBQJDtihLh6a+fV0AG2tjG4yHdewTMjPl19LSU0j4lABP0XTnIp6zU16XE8Y2QKQHiAydxHNk6zQgWhKvxk30ptC/p7E8nb6dE+f8FEZ+YcSqlnKwqKuq5VZYcCp25htPKVfiT7QEjPu+OYfy3F4kw4AByMvCxgfCdvad8qYrL6vL95OAyHPLTibsaukgZdO9WV/TUPgPzZwOAvRXJ7T/YOlh7bVRJzXFHgypouDVniKAHfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVEBj/OyEAp99ErMEz3ErQ6TttANznsYWFxVX5CjnwE=;
 b=LAvV9EgmP3XKZ7iW641UPg3A9o09CEpLvvfqCxOlwkpuqXlanePIzBBzCZ/oqciE5MQnYMhDGeMbWoJz7viaDUzLl877kxJF79kr/5N8soVxBjJS+nhNnshAmBDg4drV4U6y2I+gBrSQ5o9whlmEi48pHk/c5mAUHEbcr9eI4mMCYl8HYmzcrc4AVQTG9j0XfnmdrAg+84I4TYQ9O9ktCBknYAuAnfxdwGmozd4zk4RgBDdx3ZA/bjvfVYw0+SjIGrdKh5drHSUy5nsRK2oBOcQ+DZEo3YnlTT35BjO4cp5AvZEGDZ8RM97lN7+NUOTmkDEPTysbUylUA9rFpziBCQ==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 06:38:21 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 06:38:21 +0000
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
Subject: RE: [PATCH v8 net-next 9/9] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Topic: [PATCH v8 net-next 9/9] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Index: AQHdd9JIdl+/U/SmjUCoTA9XHTJLv7c7IOwAgAAYPaA=
Date: Mon, 23 Nov 2026 06:38:21 +0000
Message-ID:
 <AS4PR04MB93381D265BF5C51D8B320A9988452@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261119030534.1892935-10-wei.fang@oss.nxp.com>
 <179541034095.3135.13496206683389250613@kernel.org>
In-Reply-To: <179541034095.3135.13496206683389250613@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|VI2PR04MB10594:EE_
x-ms-office365-filtering-correlation-id: 5a272205-22b6-46e0-8b2d-08df492c5e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|261009223027099003|4143699003|10067099003|5023799004|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info:
 blbp+uSgdgy1VwLRZHpwCYiq75/kQCyKzQAQoCa2F80mWYRouNF4/B1Hm+ECAbh93oWeZekZCFo0XU59dKDURhKPnxkcVGTilfLtZGNkl2l9p8yPtI3k+2TD9Ip8iLOMN5/5rQ32JGA+GUeVF23coHYT8x97e5nehE1gb9zL77gRPBlIKbTT20bBwi1Cbp4paNIbgXw2lUUmh27LDz4Kt4jhLhiPM7I2pDVaG6cHnjh+oGCS+J7utA7nRF8UMXRdI1d4cguVPJ1R2SO3FAywe9uN4xZm/oRJuF7Rn89LezOqp/Rs/02CdxYdenxJ56kHCKdoNuZvGj9z2wp9qiy5jEMSKryetUJ+Vm5dUmlfe6PcPhN/LFrKKAVmg9UhGGKJ4ideBJwE/pIRY7pJYk+aIqjBh90ZB7e36HcnorEhd0LdNHIbvO4G7nqRghCqMpgkcIqBV/vPqETgntDfkDfauXFFBk9SEQ4bH3DhxHApJUKixJzO32rXDl6CxOLNJPt2Daiz0AN+O/vV3AIzqzg6NhVIUynkLhggRbePzppVg9BdJ6ORzc13sOpx2hMORJkisYudAla81x1M0IGxny6qh1L1/or21DHrdKKiFII8oJMW6yXPYLXHrbFJvmjoLdv55akBqYVLXD3S1TfsxkhJhRTN60cchWvkxeZ2x/kigQ4P0gIZas+YXd0RtryujVNgmkCLuuyBoxveiki+a7n+MsI4cG5dGEwTcWAVU+maGi8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(261009223027099003)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bu/Ql7mZEAxzJXUQ68BKmLnukQRGEXs5dBGDRmN7IjZA/MVYR9U4zSzqQgEq?=
 =?us-ascii?Q?HvWTfYe8GEczcqup4pu3VlmgKkB2r1qhg9DAZzjAjk/1AQMPWD0+75sVj3Jf?=
 =?us-ascii?Q?OGC4MMgKa8T91SRVTmmpaO5BTboHoOtFe32vGlv7SY2TpTaGeXXf3+H4mEQf?=
 =?us-ascii?Q?VN9pyIDaFYPC/fNasVJ+5IQmffi8Mqir7G4svW5Swt4AUAiaFwthsUmoSrZ7?=
 =?us-ascii?Q?9BOieum8QAbSnyOqO9oV6cTHi+2S3nERApeA65ksWVIx3ysrc2GjT/S2kq87?=
 =?us-ascii?Q?SbMhh6RZzplMJJjifKpyZnIoV9vVNraOjE2oTlLysXwz7uwj0pONdnnDtzE7?=
 =?us-ascii?Q?MLmmwdpHiBl8KeKi0AVUDc4sIyc/PHw+48MX9MyEfGEwdHmBbsVroEEbgbbt?=
 =?us-ascii?Q?FymaKl8DFnO+OLXCmm/iSl2sYROI5MHNZ7B12fA5h5tErn05zNwPuFPvOeFO?=
 =?us-ascii?Q?6BWQ0FhzVCX0VqaKzKRhZP51LYbHzKqDOXijVJ5z0mS/pS39D8mwIMxW87oF?=
 =?us-ascii?Q?5dmFqC6bylT08zEHjXTwdZebxz/VIlbuig6HZTxTp8UpnggcgdNdYDNJoSoA?=
 =?us-ascii?Q?qOTwmo+pxiKEVEA/cHRy2oaNpAji5oBDUdZns3R7Fs28PVkUU2pY81vXmq4v?=
 =?us-ascii?Q?EY4FBzsEthuYqD7NznCwWMtH0jFUn1eQz3coQSW2dLHTViSvCc/lxQa+nyvH?=
 =?us-ascii?Q?JDEVuWBumGcOZvwOlFoaHnAuTIgGR8I1b9MtKykUOMdO2JL+j27qOoIrfZrc?=
 =?us-ascii?Q?qeIVnkMiy1dUGyo1uXV36nZZyBQM7JXNhV1zLQimsuPVC+xXjJHun2V+e5av?=
 =?us-ascii?Q?O7Sgt3gU4Bvw2uu8QdXyVGWVLHtfQJUlNmWIhbg5SWBAZJRRrTxr7jv3SRXe?=
 =?us-ascii?Q?67n/ei4lN6s5Bwv2+CAqsqXdMSDUmWk54jp71gBsyhh4RMgophTH8SbpjSKz?=
 =?us-ascii?Q?OE9xMusAa43vSLn3JmQN1t58aiG9I4wqgu1eLJbevfPiyt9tlJcxcjrM+Whw?=
 =?us-ascii?Q?yfjAU2ZuTO4YUnT/fe+0iHMXFmPWzIEfND+UyCrkeyliPBDby2qEbUDXMMrf?=
 =?us-ascii?Q?57nztLxrSK7LCbenizuVc5xfzPknFrpanGDQUqoydirRT6XYBSwzYJYPV8hx?=
 =?us-ascii?Q?/8g2l4e7pxY8KsmD8Fga9Q9v/P13Z2TgY0alNN82dwTGDQfzaxSiKB/A70EV?=
 =?us-ascii?Q?XZcWfbSeZarEq9QvfWYnz4KWkaq/iKjwRmaZQYf9PzGKEDm7fCCdGJq4k4mC?=
 =?us-ascii?Q?CoaQA3qk2+V5zxWtXIzBI6CXB+9iPAKxxKf27OqTBordZOSJflpG6VC1QwWz?=
 =?us-ascii?Q?p2jYeAcx/YNHeUwuSNdjVInAqzH0zsHsLo1Eqlr2yHKQEG1LmwWOMx8T9I1U?=
 =?us-ascii?Q?ALJ2CpsMsga00olpGdhT4NrJXRgzFNrJDn3UylPffFr+h5sYDg3V9mSGQZjJ?=
 =?us-ascii?Q?MyQywppuvr9ORAMklmBwTwxY/et0deSi/ShQlYEGPD72tXFHY5QhpeazRfuN?=
 =?us-ascii?Q?j9Pm4AoERTuRL09tgSO4toUkYCHsPeG1EkT/9L3ZN9MWRfBb86vy63ViZNoY?=
 =?us-ascii?Q?8USPdTrAJ5AVfJ8FozMYUxzMI5DMbAJCkU+mMrOXTSZUDVpA51vsFCS8nFHH?=
 =?us-ascii?Q?bCVnq/BcJj3f/+4Bj+xm4cJNDEf36Fc9hSw7mlcIQvzBiZvJrd11YR2vWLss?=
 =?us-ascii?Q?vYuRhBVAMHha5l2QORCmVaNYbPIolrGGbCqKERTT0RrsVq3H?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a272205-22b6-46e0-8b2d-08df492c5e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 06:38:21.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9JNcS8alanoyppKFEIn9Qhj1zuw31bobX/n+GYxelEnPYuTYjUYoi9TZNP2yewnYxXaN8Disq+V8GJKhW0vlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > +static void netc_port_prepare_onestep_sync(struct netc_port *np,
> > +					   struct sk_buff *skb,
> > +					   u32 ptp_class, bool *twostep)
> > +{
>=20
> [ ... ]
>=20
> > +	/* Ensure the buffer is linear and writable so the packet can be
> > +	 * parsed and updated in place. Otherwise, fall back to two-step.
> > +	 */
> > +	if (unlikely(skb_linearize_cow(skb))) {
> > +		*twostep =3D true;
> > +		return;
> > +	}
>=20
> [Severity: Medium]
> What happens here if the frame is a one-step Sync and skb_linearize_cow()
> fails?
>=20
> skb_linearize_cow() runs before the message type is checked. It can retur=
n
> -ENOMEM under GFP_ATOMIC pressure for any nonlinear or cloned skb, for
> example one cloned by dev_queue_xmit_nit() while a packet tap is attached=
.
> When that happens, the Sync goes down the two-step path:
>=20
> dsa_user_xmit()
>   dsa_skb_tx_timestamp()
>     netc_port_txtstamp()
>       netc_port_prepare_onestep_sync()
>         skb_linearize_cow() fails -> *twostep =3D true
>       netc_port_prepare_twostep()
>=20
> The frame gets a To_Port subtype 2 tag, or a subtype 0 tag if
> skb_clone_sk() also fails. Its twoStepFlag is still 0, but PM_SINGLE_STEP
> is never programmed, and originTimestamp and correctionField are never
> updated. Would the peer then accept a one-step Sync carrying whatever
> originTimestamp software put there?
>=20
> netc_port_txtstamp_handler() would also later deliver a hardware TX
> timestamp for this Sync through skb_complete_tx_timestamp(). Doesn't that
> conflict with the HWTSTAMP_TX_ONESTEP_SYNC description in
> include/uapi/linux/net_tstamp.h:
>=20
>     In this case, transmitted Sync packets will not received a time
>     stamp via the socket error queue.
>=20
> The commit message also says:
>=20
>     If the originTimestamp field of the sync frame is not in the linear
>     buffer of the skb or the correction offset exceeds the hardware
>     capability, the frame will be dropped.
>=20
> skb_linearize_cow() runs first, so the later check:
>=20
>     if (unlikely(tstamp_offset + 10 > skb_headlen(skb) ||
>                  correction_offset > NETC_MAX_STEP_OFFSET)) {
>             NETC_SKB_CB(skb)->ptp_flag =3D NETC_PTP_FLAG_DROP;
>=20
> only catches truncated frames. The "not linear" case falls back to
> two-step and is not dropped.
>=20
> Should a linearize failure on a Sync frame be handled the same way as the
> other error paths in this function, with NETC_PTP_FLAG_DROP and a
> tx_dropped increment?

From a software perspective, this is a trade-off and cannot completely solv=
e
the problem unless skb_linearize_cow() never fails; otherwise, the driver
cannot parse the message type. Therefore, we cannot discard it, as it could
be another two-step packet, such as Delay_Req, Pdelay_Req, or Pdelay_Res.
The issue raised by Sashiko can indeed occur, but only under memory pressur=
e.
Once the memory pressure subsides, PTP synchronization will return to norma=
l.
So there is nothing we can do for this issue, I would like to leave it as i=
t is.


