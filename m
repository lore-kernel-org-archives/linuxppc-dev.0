Return-Path: <linuxppc-dev+bounces-19493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139151073C99
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 11:09:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frL1W5Hp3z2yd7;
	Wed, 08 Apr 2026 21:09:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775646575;
	cv=pass; b=THVHaYwqyalO/9t2n7jknHyTLf/0YVmoXoF8gKRYzBsTtB7szKwIpitlrxcbOaVpDpxzmaaz+FLWws5CpmTvnvE6kvu5UyWkMi5icU2pNSTARLifwiEPcMyA+2gjdjb6L7TIBBnWuV65DGEkZ+zM1kiBc10dSZ0Thi1eNX1XT/x5X5JkcP2BNkhpdup3kJdrJBmt3eAClx9P/VYXErCsx7H0kfdxolMPWk7v94dc6asHv9ng2LtYO+5T4GG5m+/4pQFq7+wqgR49mpxqprQEcKudNEeBIIbXHGwhaIrxTKx8upbUWOymQ/8XVxAb/AqjMi9za+WpKhPpXKnIrPGs7A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775646575; c=relaxed/relaxed;
	bh=c/1MhOJcKFUmRW9u7fKfEjRgUGCIko9OA+snDYkLJ4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rexu/GQCFqii1hcfzCjP1PuJ1GCU0g7A5DOVjdW5RD8bAuIPUPqZ/JPAOrl6HjZe8Ij5b6TLrSPJrgSE3bY0/1auFwZC0E4DKeRQzX+KnCKy0COT2HseWW+RbuA7rVINZ/BMsCRucRSId9a40PgSu//r+7ZT9OFHz2QX6uTPK0LbvXkDHljHIATjVTGEouv6SnGj05j4mfSEJLZk+OoARDKpOpI+L29iP6WokOFbI2FfqfLW9JF+2ihaadnXUUDsdmMkuVUwKBf9Ya4vUa1Ur5+6i0Ob1M7Vvccijx48WYUsFVWLWyUTHCJpwZNYUjdgErpLUvio6DaU5pOGsu6VKg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ls2ZvLRQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ls2ZvLRQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frL1T6M03z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 21:09:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9r4g5s6u30Tuw4zohYSOawhRc+1hbdboCmpqvRJmCOX+jlPJNgtjp5i2usAOMaKt8fi1Mnkc9DEfwjuMtBPndhEf7kRpmOFfwJrkvpOvfhcROeHiVzqcFXyNvnd5YxRicipx5b+WBy1jbo5lHAh4ANnXuinjWCdSPVwyURPwyDtpX4he4wZQammueUReXYSjuOh/ex1okqzLR4pN534xv5Mz9RVoYIyh5jz3PTqmPk6mrfBKdpEcQgv7oaP1TxOJJ6QVvhxwYm6l7gx8mxoD0afVyY9tSx5fszt+quEMzlnKFfTW+iiFwXN+ZoCSic78rABeGC5/aocofoA5Obc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/1MhOJcKFUmRW9u7fKfEjRgUGCIko9OA+snDYkLJ4s=;
 b=vFchqL8mYPzIk5e9Ph/bahoN+ZFvpVLDIAnPqwUedGwSeBjttkSJHll8y/dMDxhbqJX5ij3jdlQlTxWhP4VrbBzUJ3oRbx7rYvDiIbZUH63ZgEqCXn72doD0S6ubzYMpQ3rPZXAKXZ6Eei7DjNLPMGvqtt1nXuiHDExck9xnaKpXlZaXcZoUieVzMoD+N8SUWXbUYLeX0S5kC/jaK9dXBLk8TIXDQhLxHHGY0vsUzL2QeHwKuUrx5b508EHFDJrPZUozlpkufuLkJqBAgZGxMDT2vSIUU6hg26au/QFLuvshCRxYZu4cwV7vHliPxkdYRKwVrAzkWiFMBRW6NndDjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/1MhOJcKFUmRW9u7fKfEjRgUGCIko9OA+snDYkLJ4s=;
 b=ls2ZvLRQD4j1wrac7qeQexam4xGr5q7HEkNLVxZJ/ps0ELns2ad98tiPo18OlnXZtDh10TKgMDdLvLADq5RCBQwTU/QvJfvT1r4h1ZFp9OEoKiYHeFyhhqwCGTjP8pEMoPZL4Z80m88Dn3fNyCdyr25+vksz54njiL+rtUGZahoXN7LvO7ko/k2tQDzvH/Lax327vFjbHS6G3Uict/8Rrsex3nME5KYjgpA14Xjb0quOfVTBmqWYgFQH/dSLt4EYgNm96GeaT4Rnsb4VtVmrQhruvoCbHEZgZdzGHxgrPZP2H4cGR0vfSqa+vvVVggU5KFjyiWwpBpBGwh8FTojbKg==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by VI0PR04MB12077.eurprd04.prod.outlook.com (2603:10a6:800:317::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 11:09:08 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 11:09:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank
 Li <frank.li@nxp.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v4 net-next 12/14] net: dsa: netc: add more basic
 functions support
Thread-Topic: [PATCH v4 net-next 12/14] net: dsa: netc: add more basic
 functions support
Thread-Index: AQHcwQGzRXF+4+m1mE+150E6Qq+367XMjVSAgAhyPOA=
Date: Wed, 8 Apr 2026 11:09:08 +0000
Message-ID:
 <AM8PR04MB72846ADE8D4BF97337ED2E85885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-13-wei.fang@nxp.com>
 <20260403011743.1795726-1-kuba@kernel.org>
In-Reply-To: <20260403011743.1795726-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|VI0PR04MB12077:EE_
x-ms-office365-filtering-correlation-id: 9dda764b-2c9b-4d64-d63d-08de955f4174
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 LA6/x0R3e3ySWr0mj7zjghCeAnpmGL3F5UHWtXhvKbwQDUr6iJAifaZNIFioZAdjmSQyh5e8/BPIjNNZQqtXiuGUoF2lkeCpWOeWswQKHCInc4hp4EeHvYZ3I6QRVPa/fL6HkyALKP12GgBfZRKyhhGVsBxObXJ0n4P8Ga7vHvUqNlt8QN7Y4fQ2hoEQaMAh/ErmrMoAZH2CRpmeVyXaC+WTB6MWmgFSz+pNGTfYiGPe2mpzYgkD56cyqgxW+fvjFbcf5hWk+27OaS+D6g73txxZCPqTbneYr/jyMdYNYDZ3qrxryBatxrGwdMkTs9MNZtg/euJfMQZov8O0ir6sgsGG0cTsIQeAuNuopPwILZlC/4faxvPCWuv5E4g6mDF+4nnSnvkTU/s0PwejdAzHV42iRJsH9iRNe395sDLNTmEY9WJE2KdHlSDsfs3ywneOMaVp3dR/grL+rXEfRCLmFzj2//E1BNPbYe8+jjmtX8YdiZNUxaGDzrJFfoTtQkqIuidm9WRyHWYVQovzAhC+5hHacEtMO2CSV5PlpOhxP3czvlGeyNdbN7BTT5avvrXACkqDBkoenwEi2/lLoLTyD0Xul53h/2R0shph9ia6uGOli9pjcO08/01rg5puiNaiIbL2Zm5C4euaHhUM7lHT5q7tkeaxHH0iFLZ4CUSLXLY4yp0eqKBrHaizU8DDmtXlVI2Zfi3GHIZwQDVpzvxspxjdv3rmbnK2k5ZqdHLI8i+ZdlNqFDl0Et6RN4yz01zuCrDFfIAf4iAvQeAL92PxoFzqKzdrmcju+cxIa153f34=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ilOlcLCIlAH2eFh20RTEQiloWfqe1eltHrrftpq/fCsppw4nt7B+xZbe9PiZ?=
 =?us-ascii?Q?8cxfzSZ+zo5yDgTLguJfn77gtBqeVVmJg5rbjrFOIxAhzSsNYZZo92ftpcqQ?=
 =?us-ascii?Q?mdS9/bAejuIFcjJpav6xiR8mMI21kJIsRf0pMz1+zEMvGj+LrtjvtEVsRw9x?=
 =?us-ascii?Q?gCvUjQT02OeG9n2+6XbxHY/aVg5HoGeq0ZcF7D7aLu3U0FkFblY9b1H7NkWq?=
 =?us-ascii?Q?EKjlImFXZnPVN4VdDoRg1OZeoMFNky6b0SUP8Gt3P8F4ZsdDzOphTKpY+xyW?=
 =?us-ascii?Q?qz+BG43qtOwx2NE1FnrIXwWF+ISuB+3EGXfNIuFcBXmk0WIoBps1MxggmK9X?=
 =?us-ascii?Q?wiyDAGTnJ9AeanIHKpOB5dJ9pd8ceVMXc927wew3jScYYz8aXYSdTAWhBjif?=
 =?us-ascii?Q?mhmQOekI3IGuM9wGEvkDYJv7saQLjxD9eWRE35EVQwFkgnBM+HQgt8aJwsJM?=
 =?us-ascii?Q?GnICawkxo4YmRBbipjP0jT5MJxtKJN48mA225o46BPfVHpBDuF2qE29bvcIx?=
 =?us-ascii?Q?aSoSj4YFnKsKQzla/EQnFlhCwF2kOYzt22QY0rd9wsBqfPRIYrv24WKQ/bsm?=
 =?us-ascii?Q?IJXuCSGQHmuWcoaj11mjX3ATVnSXvRNDPAJXPEH+ddjItA92F0nbqOS9oxZV?=
 =?us-ascii?Q?F1Chd3vEtN2GtrG9joujy4XNBjMLJakMCTfpqiT5I0X7HAkHiu3J9BYbU0Nl?=
 =?us-ascii?Q?5HEXzyXVD6Jr9otTCcLgiURPvKJT2Nwb0eQQM1/kD8kM8SCbc4YgD/BfeC1j?=
 =?us-ascii?Q?9Wha26w9N5oFuwNJDFbPRVe3Ru6BdAIXWFmTJ68o6k77eA4chvD5/a+Xk7jR?=
 =?us-ascii?Q?BuPCiNoia7OaZPIFIGSdmkXXOddJerb/VUdORjZQEYmf2qJvTEkCWwQT2To0?=
 =?us-ascii?Q?AzLVRuzCOOKnNN4fy43nrlKeRZMzD5kUtGFKttB1mDijMO3ezRC3SudgsJpZ?=
 =?us-ascii?Q?pxLHYh21lf5qVwmey34f/NjcPHjN5gqJ+TPbmTwxUHk1ELYHeyYz97MH6MDz?=
 =?us-ascii?Q?QjjHEKcf2LhR8bXQch5wQqltuolj2pWKR5xP5DKElKCet/Bg2ryQelwqlCDP?=
 =?us-ascii?Q?5WHSaSrTjhum+8g6QTOmP2Il46BPFZ5nivrHW1g7RXQbdDX2s6PbF7DYz+qa?=
 =?us-ascii?Q?CiV6MJeDSAuHqOVDKptsRGN/a8V4e6BmX02DRhZ1uAJRxXnF64mx0J/e934U?=
 =?us-ascii?Q?tX1RVng6B8hQiYrBGbyxL4KBaV2W1FFS4nrRrh7muIljiHGD59GFOEJ/fpKW?=
 =?us-ascii?Q?p2uOIL2nbca6znSdthW2yE1R2Xrd0JVGtOOtdQbZIh8VphXgcxSS8vZZ4M3Q?=
 =?us-ascii?Q?qWmg8Teadaatn0S6PsEYKT1N69Ib9jKIucXLwAKfkzRAKEV4VImRXfKPTsKn?=
 =?us-ascii?Q?XyZHG9ugNFlJR69cn4hylvVCUg1JMPCAqQJrn5Bdo0yS1ocMEah5EZG/NerC?=
 =?us-ascii?Q?I0VBdaRGTdzYFujlBqL+QDssRXViMA8GEleuPQanHX0kz0BFIgwv2yMgUYRt?=
 =?us-ascii?Q?cysZFBd0iSC+HRHmTib+2bdhU8l1xyFiONjwaPT6xcoV+/Oor/5rOupNXE+g?=
 =?us-ascii?Q?82rhAXOv4bXaD1NsxvJiuj/OnNHpClSESf/CoyDiwaopk2Ey+azbZdGlID5R?=
 =?us-ascii?Q?JbjW1WUdQv4Ca3xzob4diPbD8n5zfgkTby+rcI54c7IA58exfUG60Q5dHVH8?=
 =?us-ascii?Q?O+sS9TvMFXMjwNjeivF5Ji0WESA4LqfB4HEap0vm6bHP93kD?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dda764b-2c9b-4d64-d63d-08de955f4174
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 11:09:08.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tuYBw6hp+SVAUC/IVLxzRJsr6vz3/pf96YbtUsm/Spckf7+d+1DjEHwjGmqmWowS8Xa2RNdaAyuHjCtKctr3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12077

> > +static int netc_add_standalone_vlan_entry(struct netc_switch *priv)
> > +{
> > +	u32 bitmap_stg =3D VFT_STG_ID(0) | netc_available_port_bitmap(priv);
>=20
> Does putting all standalone ports into a single shared VLAN 0 break the D=
SA
> isolation requirements?
>=20
> If a user manually adds a static FDB entry to a standalone port, it is
> programmed into VLAN 0. Because all standalone ports reside in this VLAN,=
 a
> frame arriving on one standalone port with a matching destination MAC mig=
ht
> be hardware-switched directly to another standalone port, bypassing the C=
PU.

I think the FDB entry can only be added to the CPU port if the port is a
standalone port not a bridge port. So this case will not be true.

>=20
> [ ... ]
>=20
> > +static int netc_port_set_fdb_entry(struct netc_port *np,
> > +				   const unsigned char *addr, u16 vid)
> > +{
>=20
> [ ... ]
>=20
> > +	/* If the entry already exists, but not on this port, we need to
> > +	 * update the port bitmap. In general, it should only be valid
> > +	 * for multicast or broadcast address.
> > +	 */
> > +	port_bitmap ^=3D BIT(port);
> > +	entry->cfge.port_bitmap =3D cpu_to_le32(port_bitmap);
>=20
> Can this XOR operation cause multi-port floods during unicast MAC migrati=
ons?
>=20
> When a unicast MAC address moves to a new port, the bridging layer issues=
 an
> ADD for the new port. The XOR operation leaves the old port bit set along=
side
> the new port bit. Does the driver need to differentiate between unicast a=
nd
> multicast addresses and explicitly overwrite the bitmap for unicast entri=
es?

I think the old FDB entry should be removed first when a unicast MAC addres=
s
moves to a new port rather than only adding a new entry. If AI refers to ad=
ding
before deleting, then this problem will indeed occur, and it is unavoidable=
.

>=20
> [ ... ]
>=20
> > +static int netc_port_del_fdb_entry(struct netc_port *np,
> > +				   const unsigned char *addr, u16 vid)
> > +{
> > +	struct netc_switch *priv =3D np->switch_priv;
> > +	struct ntmp_user *ntmp =3D &priv->ntmp;
> > +	struct netc_fdb_entry *entry;
> > +	int port =3D np->dp->index;
> > +	u32 port_bitmap;
> > +	int err =3D 0;
> > +
> > +	mutex_lock(&priv->fdbt_lock);
> > +
> > +	entry =3D netc_lookup_fdb_entry(priv, addr, vid);
> > +	if (unlikely(!entry))
> > +		goto unlock_fdbt;
>=20
> Will this prevent dynamically learned FDB entries from being deleted?
>=20
> Since the CPU port is configured with MLO_HW, the switch hardware

Currently we only support single port mode, so only support static FDB
entry. The MLO_HW should be removed from the code, I will improve
the logic.

> dynamically
> learns MAC addresses, but they are not added to the software priv->fdb_li=
st.
> If a user attempts to delete a dynamic entry, the software lookup will fa=
il
> here and return 0 (success), leaving the stale dynamically learned entry
> active in hardware.
>=20
> [ ... ]
>=20
> > +static int netc_port_change_mtu(struct dsa_switch *ds,
> > +				int port, int mtu)
> > +{
> > +	u32 max_frame_size =3D mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
> > +	struct netc_port *np =3D NETC_PORT(ds, port);
> > +
> > +	if (dsa_is_cpu_port(ds, port))
> > +		max_frame_size +=3D NETC_TAG_MAX_LEN;
>=20
> Does this double-count the DSA tag overhead for the CPU port?
>=20
> The DSA core computes the CPU port's MTU by adding the tagger overhead
> before
> calling the switch's .port_change_mtu() function. If the maximum MTU of 9=
582
> bytes is requested, the CPU port receives an MTU of 9596. Adding
> NETC_TAG_MAX_LEN again here results in 9628 bytes, which exceeds the
> hardware limit of 9600 (NETC_MAX_FRAME_LEN) and might lead to truncation.

It seems a bug, I will fix it.

>=20
> [ ... ]
>=20
> > +static int netc_port_fdb_add(struct dsa_switch *ds, int port,
> > +			     const unsigned char *addr, u16 vid,
> > +			     struct dsa_db db)
> > +{
> > +	struct netc_port *np =3D NETC_PORT(ds, port);
> > +
> > +	/* Currently, we only support standalone port mode, so all VLANs
> > +	 * should be converted to NETC_STANDALONE_PVID.
> > +	 */
> > +	return netc_port_set_fdb_entry(np, addr, NETC_STANDALONE_PVID);
> > +}
>=20
> Is it safe to silently override user-requested VLAN IDs to VLAN 0?
>=20
> If a user explicitly attempts to configure a MAC address for a specific V=
LAN,
> the hardware is programmed for VLAN 0 and returns success. Should this
> instead check if the requested vid is not 0 and not NETC_STANDALONE_PVID,
> and return -EOPNOTSUPP to inform the networking stack?

Okay, I will add a check.

>=20
> [ ... ]
>=20
> > +static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
> > +				     bool uc, bool mc)
> > +{
> > +	struct netc_port *np =3D NETC_PORT(ds, port);
> > +
> > +	if (np->uc =3D=3D uc && np->mc =3D=3D mc)
> > +		return;
> > +
> > +	/* IPFT does not support in-place updates to the KEYE element,
> > +	 * so we need to delete the old IPFT entry and then add a new
> > +	 * one.
> > +	 */
> > +	if (np->host_flood)
> > +		netc_port_remove_host_flood(np);
> > +
> > +	if (netc_port_add_host_flood_rule(np, uc, mc))
> > +		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
> > +			port);
> > +}
>=20
> Could this permanently lose the host flood configuration if the new rule
> addition fails?
>=20
> If the call to netc_port_add_host_flood_rule() fails (for example, due to
> -ENOMEM), the function logs an error and returns, leaving the port entire=
ly
> without a host flood rule. Should the driver revert to the previous
> configuration on failure to avoid blackholing traffic meant for the CPU?

Okay, I will improve it.


