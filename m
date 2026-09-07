Return-Path: <linuxppc-dev+bounces-26629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411A4C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 02:42:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdWZR3Q9Lz2yvX;
	Mon, 07 Sep 2026 12:42:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788748959;
	cv=pass; b=ivL7mkenAFXzLo2jC38UzMam8ZMrTyleYV5+1X90NMn05+PP53cVoq5Ns26eCSNwzFtWyCQLrh0JWp4ai7qpl5IBTwCasyqG8L8iVO8KZAKjnwNyiJvHlmiYOf1l/ov0Mh1Jtjg8d2fDBiuct+i/rAEYS8n55NMq+NDnBAF2Se0DsMeVI9y7+Yr1bXex7CodTXkB+qM0Wb83V2qrdxro8V3NuEUNUwBSZYDN0V3MlfxQ5zRLmX6mAZOdRr8O1g3FHajMzHrNJFFCQT3xtIdJwqT1/8Ead2YgcWwqaxAtiDsB7N64dpV7IHyUO5a7bl34f/hkh2aZJk0UGITSADV4Ng==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788748959; c=relaxed/relaxed;
	bh=1pNosvd7gREf0nZftU6x3gha25+YFz24vrb7W2LXbvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWniH6KEzB9uYiYGNKdmZ/VJ8Cg8bww34s5qvX+aE+hTYXPStPGa1BDSz54JucVsB7cgNx++Uj7jwgbvtFTaiTsmcLaDnH1PuTwNPlPY02ZeoAZa8t61dSWMOV57/8YBUM+J6Vsh7rlFdCQyeBqVs8TO/Z3nN1AoFbTsKAgypUdEaJx0VpDbjcMrKasPAFenX92wXFaB3+HEYtbXHjCMIM2lTo3v6V4a2ljuDcrenIrfNmkKJzwqz5zZLP6VMO2TNvsCW6VTYoziIVMfEMBnxr3ENSozBd7iqmVMHVBceGmZQcCnVDZLr/m2EjcV2U5clNZTDf9JudpGxJw1Ihbc9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VSmZ5U4O; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VSmZ5U4O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdWZP3WP0z2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 12:42:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDJKE39BILN7ArDYmhIO9LQbhbS55PrzPwyWCr5mStHWWRdZKjlGbv6yTB8L5sinlnh6pRQwvUyQlA6azBgdWVDLjTAu/jFp106hKpqQjcueJ2ls38opOKftoonSNRanreYaVIbXXHVimtbT5FqHeJy1EOa+euKRrnOe03u95dVgRoY40QOFrGtKd+/gXc8slhvi86Zj7QRDXAPxeCrAEA3Ljp8rh7vXT92SbTdxNjbC0xcQdTJHlMZfbRiCWVGGtZTL31O9RtqC2WdBJOm/wP2ppqw9Bl7Tt4WDpiTFb9vpdPKufCWE7wZDE+H1yzk7NLVGJxe+NJw+Zya8/qNiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pNosvd7gREf0nZftU6x3gha25+YFz24vrb7W2LXbvg=;
 b=ax8TrrfwfpSFauAvGG3qs8zzNJI6Jxm1+1rb5E7GcAPfvsd2b9+7Jqzqkt3iLC3Br2w1sATQnGJUHoZ+5eZh93qecjwbujgppmF/gfZmw/2uxR0eiKEpDg223NEBd3Pd8WPAM/KKeDGnXhjhiL5/GxNNgIXyIXB3W0pbcccLDmY0MwdbOQrZeWx7T858icAbgVLIPa8ecnFDjwV4LRaBkMo1QXMRW1t231Da5KuwEyYJ6bBkKmwivWskujSxknvlLJQLK59mKv/8hQPQdcqD7pmQWEt2EYGuIqBJSgeahuoaT/1oF4XnOFxdaMRE96zlPzL/4fTWSK2QZTJnG0ckUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pNosvd7gREf0nZftU6x3gha25+YFz24vrb7W2LXbvg=;
 b=VSmZ5U4OkmkrIdDIQK0H5WmOqfDaQ2+g2/gLJk0THmhqHx+iwRdA627GSKa5A1UEK+xZyZjaQx7ghYBVu5IMt6/h4jBtQ/ZKjaEcy2qyQSsBLTMjNmvDGKKAEgk84JmY3eK2FgpXGuolHYHf9sWjZ7eWYCTH2tkjtezJ9QwDcg2TOPPKInOa00x6WYPn19kcrRpS3dqgZkv1CC+7qz3ACHMOdMPN+8rTZy7vY+Ld7H4KsaNB5/q/SDiDjCHuptCTIlIwnxHNRg92hbhuDOglu/UFW8OZzXP8exnPF4M4+v0Pws9Cl5rIgzmRA6wbEXM1M9s7sc786B3dDZ+JMrJyIg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by MIWPR04MB308196.eurprd04.prod.outlook.com
 (2603:10a6:290:ec::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:42:11 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:42:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>, "Wei Fang
 (OSS)" <wei.fang@oss.nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 net-next 5/8] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
Thread-Topic: [PATCH v3 net-next 5/8] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
Thread-Index: AQHdOSGEODtsg90iuUqZ9aqV9UQZ4ra/BlIAgANda6A=
Date: Mon, 7 Sep 2026 02:42:11 +0000
Message-ID:
 <GV2PR04MB117393777FC28A1F78B3371AD88B22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831082335.1184605-6-wei.fang@oss.nxp.com>
 <178856073082.219967.16628382371770285710@kernel.org>
In-Reply-To: <178856073082.219967.16628382371770285710@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|MIWPR04MB308196:EE_
x-ms-office365-filtering-correlation-id: 37eda541-7359-4bda-9f7a-08df0c899e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 nkFKZ3lXB/LN8o5fLIeBJ8DoniuxQlslAQuoxsNkp61RV9e/bj7YnHQI1Y72CCnjp9iePaMhip19YwUyOD0DjZB5X5ypuq4snPUcVB5hv0wOQTghY+jVGjdjQe7uqWKNKovpXrKm4EdPLUAzPLx22BuNBDnQtOI24NL90UTJkVaECu6OIOIXihrWLZxIDspTIx6B6t/wfux0YhQDxVluTyQmy00eORoEkjENAg9oHS1Tmly7phXYPDzoUSrzvHFIgIpxybEqtU0KBgI2swCUf5LOn/VQQJOLz3r+T5Ol2FXQsqJB7mCpuKcBL0mocVTdQ7wq4Qu3plbnw4YoUJz9jxPBsNTCNDQvHecSXLkC7rnd9JHKkbhtla6mYv/7QWFvZUWw8rJy7uB0V+cwkBS1Gh/JT6jEDxpYfdwv8EsREfczSv0oKmyY43isd0haZOuk1+Tb3iHeEt+7hho/gZIe4x69h0IGqkRYbk8kiNJbocNwBQ1LtbvfB/hQryGODHgeTdedeTs6VWjETtlJVpNGlirMtcycImthcxMWV5d4nmGKTz6oWUdq2Jds9RvDtPud7LaXB2ZWVnk3EBPZvq8rzMamOK34Q1iNeUqOAvRNa8tGaWu01ox4hgnSQ7beZ8Of43nMAxjD8LwAmpLliuVjPJHovMh39ObZSrXWm93jW1b+shVQWQD0EjyUHyqWgzcw35eP+DpZmgxtIQ9N14+lWRd5uf9HuElthKQdFioBVE0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3su0oeFvWarvvBoga+fWCh2QsdMNLTgEu6w0ujLWMPK7CCuLFHfqPjNJo1T+?=
 =?us-ascii?Q?Mo6BMfICdjXs/VslP7k5ueqiMZWFy0MleKJ0dJhheGcuCcg9FCM0KOjrbxSJ?=
 =?us-ascii?Q?78fbVdDEyq8VFj9etqIzPEUpzyUwjn1R02A9ecRKlmsj6eiD9g1tQTIJUxjR?=
 =?us-ascii?Q?G1auTnvQpVMjR9LinC9lOGTvqqT7HNf8tIPNFFGSMOFbA+SvXy5RGV1Ls1KT?=
 =?us-ascii?Q?drBOjMEvIQQxgiSLVMQfY07oyUvUIr8c4/mB/dLHCoznf/4cqyDF6Ge3pzzA?=
 =?us-ascii?Q?R5ytATuTRaS46dQjyl2rwbmL7L2OixznM/lO1lNKqkOiwRMm0Y4K36vu38BU?=
 =?us-ascii?Q?tVMQAPa8VbLs0Eo2UBZ67f0t25XgtbD7XEEE5qNDO1Ybi7zoGZTWiML4H618?=
 =?us-ascii?Q?3nMypLQ0ilPt5+XIqRT/kBRo2i95bajz2hEbBnJFLtuZ2omQA06VdB743rze?=
 =?us-ascii?Q?UawBk1jaPbwWrjQcdgZe6rbh5sqtHJLR5nIeDavQRfZAgU4o4AkWy8itZxVW?=
 =?us-ascii?Q?h0BROLBj9oXCRbJEnvIkM6DKnXCx8i4wfuJ7LkyX8Vu/vu7uza3r3qPIWZf1?=
 =?us-ascii?Q?w71W4ykTqLBQgkAqZ6PASC4U3tgT6RzDo3EJFVozdRnH4rD9QX84raD+Qt3r?=
 =?us-ascii?Q?X6T08qgUCp8UQv+hWEUV5p1+7cW1CgrH3zbbngDWb643EzyaBo4UHlatV9Bc?=
 =?us-ascii?Q?Yzo8QWaQvoHfex9CzLQCTIf5cM4+5GZQKWYGQxtq9shBIXT7rEQAxg5hfkuF?=
 =?us-ascii?Q?3SA4C5kgag04q2jqvMI3f2SZ1RlxVeooQpZeabE2XXaz+MO7buArHwOV2eNW?=
 =?us-ascii?Q?VZ0CNtiq1LTqHrS1eviOWeuq0OdyWI9IO1kLWJXzq9K/gFvZfzDwKcbcxQMX?=
 =?us-ascii?Q?KL+ohvlYKDaa08oPmPKGfyw3YwRjR+aoMprCnuuA9ZnUyf0nd4ZvvdCFAPhV?=
 =?us-ascii?Q?dkgNqA5YNoEeHS4+UwU4lskq92q4l4s4a7nEKd1S33qzdz1kWey/DSf44g2E?=
 =?us-ascii?Q?fhNmSkxhwQVvW/MDF3Qx3nYyN+wU5nVGHiRg6JmYZbJXUGuMJS73tFlYnVjw?=
 =?us-ascii?Q?zFEnGxaKDkYaQcd+jcwABdPyUeLJ1W7YKeTs5fq5zuXBF4CC8jZeUD6bwPf1?=
 =?us-ascii?Q?cS+a45XYzdc92ikTGj1pV1nTy04iGkA2WvOueZnGbFaD19XBIAX0kRlq00pX?=
 =?us-ascii?Q?nu1T41ctP+hRe7YLyKKKULLUZZBc+McVBPWD9NFixIBuDnMwNZ/bfe1gtK47?=
 =?us-ascii?Q?0KWR5pJ19bAft1+lnJp/MYKMQBFnfvJk8SNYi850o9tCFtqi6uqvbOX/m2fO?=
 =?us-ascii?Q?CQ9J0adMDym8e2AwD54MDwC17Iv6VdUBLqdW0IG7mm/kPGsT5mn+jWUM27eM?=
 =?us-ascii?Q?fVMUV4OHbTKMcaD0YTtMj12rRAtzJvuTGykEc41ce1dYIbhAx4ijHjGjAcSZ?=
 =?us-ascii?Q?HAN/sbiMuHWceW5Rb3C9idQfhKdMef2z9i22ZeUMkRqRrxJG1ebqJwcJ/BGG?=
 =?us-ascii?Q?5x4U0N+RekosqZZyXHCmVxAuhcSnflZXvaW+x4WuwzRLpE3SHJ8wBz9mzRfF?=
 =?us-ascii?Q?aCKX6F28oGVhALafcK5VTYDzys4svPBEeMloQY+bXxZc/hAhc0aSEZCgKaGx?=
 =?us-ascii?Q?HYZUBKJS3x6zCIqC5+XjKDhNipVMl9/7ZT0BsxFgknBzhxvCxGq2X6Qm/fYN?=
 =?us-ascii?Q?FM1gpuMxmcHHK+nl7d4wF8SU3vvkF/38ppK3pnmBoeEhO8q7?=
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eda541-7359-4bda-9f7a-08df0c899e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 02:42:11.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6buht7YjGk1wdzzlLPsF420GQiFm2nS1ehk5ckAYjHFF0z0WokMsPGxj3STTv8ZpVb0SFxfE45DT1RbxfZ2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB308196

> > -	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> > +	np->ipft_hf_eid =3D NTMP_NULL_ENTRY_ID;
> > +	np->uc =3D false;
> > +	np->mc =3D false;
> > +	netc_port_wr(np, NETC_PIPFCR, 0);
>=20
> [Severity: Medium]
> Is every error from ntmp_ipft_delete_entry() safe to interpret as "the
> entry is still programmed in hardware"?  The NTMP command path does not
> look transactional:
>=20
> drivers/net/ethernet/freescale/enetc/ntmp.c:netc_xmit_ntmp_cmd() {
> 	...
> 	cbdr->next_to_use =3D i;
> 	netc_write(cbdr->regs.pir, i);
>=20
> 	err =3D read_poll_timeout(netc_read, val, (val & NETC_CBDRCIR_INDEX) =3D=
=3D i,
> 				NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT, true,
> 				cbdr->regs.cir);
> 	if (unlikely(err))
> 		return err;
> 	...
> }
>=20
> The DELETE BD and the producer index are published to hardware before the
> 1 ms completion poll, so -ETIMEDOUT means "completion not observed", not
> "command not executed"; -EIO from the writeback error status is similarly
> indeterminate.  In those cases np->ipft_hf_eid keeps an entry ID the
> hardware may no longer own, and there is no other release path:
> ntmp_ipft_delete_entry() has this single caller and nothing else clears
> np->ipft_hf_eid (this is still the case at the end of the series).

I think this concern is a bit over-cautious.

For a driver-allocated, currently-valid entry ID,
ntmp_ipft_delete_entry() will not return -ETIMEDOUT/-EBUSY/-EIO(error_rr)
on any normal path:

- -ETIMEDOUT: the command BD ring is only accessed while it is enabled
  (between ntmp_init_cbdr() and ntmp_free_cbdr()); nothing disables it
  at runtime. With the ring enabled, 1 ms is far more than enough for a
  single command, so the completion poll cannot time out.

- -EBUSY: commands are issued synchronously and serialized under
  ring_lock (post one BD, poll, return), so in-flight BDs never exceed
  one against a 256-entry ring. A full ring would require the hardware
  to stop advancing CIR, which would already surface as -ETIMEDOUT.

- -EIO(error_rr): the writeback error status is only set for malformed
  request data. Validated interfaces always build correct requests.

These three checks are defensive programming to help locate wrong
configuration or malformed request data when developing a new NTMP
interface; they do not fire for validated ones.

In short: with the CBDR enabled, commands serialized, and a valid,
driver-allocated entry ID, -ETIMEDOUT/-EBUSY/-EIO(error_rr) never occur
on the normal path -- they are defensive checks for new-interface
development. -EIO(SBE) and -ENOMEM are bus/memory-level catastrophic or
transient failures; there the command did not take effect, so keeping
ipft_hf_eid and returning the error is the intended behavior -- the
hardware entry is still present.


