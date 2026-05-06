Return-Path: <linuxppc-dev+bounces-20516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CE2CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 09:35:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Vc13Wryz30T2;
	Wed, 06 May 2026 19:35:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778060129;
	cv=pass; b=fYZBpnKV8qqFH73PKUhiYyz38BErjiyaGFG9EZkURi1c+77IPyffrB82R/csHFujK7vxmDISfmY0EBg0N5nPdd5SpTOWpRWcJLuXgwowMPUhspDND1z/XQaDIMjFJ+u69jI6RsjywwiZ2R4q+ZXaDwhdMf1iqIRHNIL4D6BS5XooXOHe7IHwtXIvjKeHnqpmnowZWLtIm0LR4e93t2XeO5KO2xATzFW7argNohf7M+j/E2fsE7Jt+xIuOcn2AhbIyUOiFAaoqN7CCzLz7Li4Cepwmu5wL6uFKWbQ8MTPtqjFRhgw/6+3YPewzW5JET9lTFs4J8tlSNX0ZIjdb2eweA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778060129; c=relaxed/relaxed;
	bh=T5DFOEgzkajHzrQnOuNsTIpLksQ1yWSUc91YP9MeET8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRNinMD3Bltl8KgS3r966bfmEcyYdO95O/WeicXaKdOF0Pm8nXBAjxGvjdNGfku+jwZ6xml0B4wnL8cj8GgWcTLG1BxAcQnTgwAEjCoQ78Ub//vttip3SfcaiF3eS8Nfpvk85oWAvjeYNGXU9x6X6B/utYmr3gy81RXMCZgbFclhBNFulk8pIcTon2O3EqspLzr+1CrUBnRW8fd4Fce+9Uk6lhTSf1evXr3OxeG/m2h+ES/7GkXsIbVJI8HxeTJztdT8QwDKbKYTuQNhD4hEqLWnMJHhGg0FQFBo/hEK0/KsQ2AZUWrbhu/TQB42d6Z1EzoAsXZSutdRHgSP7m9SGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=kicslCip; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=kicslCip;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Vbz5rRGz30Sx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 19:35:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3rY3/5AMd1E3xtz8ZFD0WlfvfLHI7yckBNDn3uWgDQpIZ4FLjHhp90eE3KkFbBEMkUlQN6NEzswP2iRCzxu9DJ8CS3w+TloWqz36vJH2FiwEvY8uIl4D7KnLf9FWfcvSLCJmx2+FBH3CTvLr6k/NlZRzolGVChbHdbbs4R3HjJSIzyg5KmlXI7DmgDbAPwrnoMpUepeZzw+X3OmdfKYCu6Nf6dO6FQvUs67QNtkTqTxNjcvRJzJJaqP8d+Ya3gOtKXYTfQJDEYX+jFXWvCikEWJwN98QYhGYLtDZEY5Ao3K4jq3pbEeSkIG47UkJ0XaON0JMp1D/uuhr4xOMSM/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5DFOEgzkajHzrQnOuNsTIpLksQ1yWSUc91YP9MeET8=;
 b=MzxuGL8ruU4CtaffiIrM1V1ZzuZd1sVWRaRHXdwQqIK1jirh4d9AXw+VG/AcQQtePYwRgVeS48VB40LTMXhKeVyoEue7ksxGVOjy9b/fle0YMX/bL+FNVM1YVMKVFMU9tJ7RXehjNz/oBtgIetKtTbievGv52cbRlyVSZKHLC6rFPhHXitcGCcVhahkiTdFBqd4J+8Z/XXuZ3bsAFO2fFb4EQS1GsOvhCSm+mr2UGKetBr2mvp8r2UdnPcwt1XEn6Z49Cvh3jBkeXtaookFi/qhXomeUqfLQQvENNkruPnNlaV2X+cMVm1KK/NBZouO+7md/qFNR/naYtH/K8JWDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5DFOEgzkajHzrQnOuNsTIpLksQ1yWSUc91YP9MeET8=;
 b=kicslCip740HWh/HRbFJzw7g8i3g9bIj5sUbgaM4OqIkpJ+6WrGuS+lcUJT8IVCf34TQ+c3DvBmw0t3qV5f1dM4uAb3iBm8A+UEfPO+SwAilgOV7TVpWLA4fw5tEYF1vOANlPdfgWaVD7cf4+Mu/2Y17FRRMJMQuTbIwhemdVuljbzTJ1uGOLuF71xvwt2Z3N+OUqn8LcONRr5zefa1BawS8YjVEb+IYcCIyj5U+ekwtvN/h9wrx3THAI5Op3flGzL2DjBhVpJeaF/ENfS7YxD7hBOid4SRNtoaKb4j0aqpKnjmJ8JOnMeifxne7K/MnDStHAZFd2xopaL9cCFw2rw==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by VE1PR06MB7117.eurprd06.prod.outlook.com (2603:10a6:800:1b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:35:00 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 09:35:00 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "chleroy@kernel.org"
	<chleroy@kernel.org>, "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] net: wan: fsl_ucc_hdlc: return NETDEV_TX_OK if skb
 was freed
Thread-Topic: [PATCH net] net: wan: fsl_ucc_hdlc: return NETDEV_TX_OK if skb
 was freed
Thread-Index: AQHc2+2kUJ9y/iAyiU6X8I8cSH4SI7YANbUAgAB26uA=
Date: Wed, 6 May 2026 09:35:00 +0000
Message-ID:
 <AM0PR06MB1039608A8965FE12520901515F73F2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
 <20260505182220.29e5f34e@kernel.org>
In-Reply-To: <20260505182220.29e5f34e@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|VE1PR06MB7117:EE_
x-ms-office365-filtering-correlation-id: 00ab12b9-b81a-4fa6-d23b-08deab52be99
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 2tlsVLgTczGoaJWenQjyKnBqwg9+0TTYUlyfyl8pAL9EZUpqYg+Y3jrJPSA7TC4t3burHGTgKnG0UDmgvbCAls17+Cr6IglYtuycucqwuaaGmAdKXbuQKDAr3LstJ1UOaWdo3TFxpJlHlt8ibEcBc6Kj2IUQPQZQaj6+NStsjWoh2UNGNiGrofTVXOCTVhNAXKwTv5BHaHilgvMJcBTz3zyk3ek3ORSQirPN3QNWHZCIi0viGWmsw1Ke+C3B2/otpyd6bFaFXNFIh+/5Rra9snOXd6LGtJ3wHZcgqNnXZfENpWAhxavMwSglcGWRAJzxJiuFsuV/lmCgSJPx66ejMlJvTFotmcobzQ3b41xv7PholWkrsLZlh0/wqrBdPd7YUKhUDkWOvKr+CHzAbfPLKCi3eijLeKYh28hYrTGz1uhZN2VMK8JH0EbeCXfOGdo3YMb1987G/e4lNYQcKDB+GYaD6dgWQPArEN7WV9zzpBXgljftqVqlh5rtf3ErtylckYhfZeksdn9M4np4DPifK6dzoQsxGnJ/bsi+kRHRpeNV81MiYRDVd0I5AtZr+4l8bf5Fjs6tL6hDVAK7+oxICaTncQq9eEPCcdSPiNEQepU3WEjq1JEVrH1EWyHeuqMJToL7ZNYZA3HKmO+aPoutxdip75LP0KkMqSKdLhjCE4cphz6xPrVYHjM1/tIY+MLqnB+iKVy9mqno3LE6M4t6m/A4+zRECY9OEqxI8nAGChloFjNP8v0QEct6Ih+EkQsp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XjClNRTo/saq44eZGC0FjWZIyUZnjbnIIZpSwgz4IqoDR6C0/Gll5+etFk+g?=
 =?us-ascii?Q?HzdZFaDxpAWaeYt0UclwFnlno+v6RTUDpPtmNpfZcvJfOM8smVAtFyqpFJoJ?=
 =?us-ascii?Q?AXq85KyM8yQAGSLNDuR9ylD4vz6kHhl2x0qMzn7WhCxR10EMQaXoiXpXwIBb?=
 =?us-ascii?Q?xbCvRg+lAFij1NvRSpgyXQWUhQTIAHMAy384UvBtWD4aGYq6By84TOg/uG3H?=
 =?us-ascii?Q?fniJQvRIHKx8Fl/7kGV48DtTfmZMLm/Xmnfm1/oMJyrA76pNhlgpZNJaDYzV?=
 =?us-ascii?Q?fAVHwmV5cBbOELNhm374wuCBcWDOgBGqdjzoMJjQt8npfRIkokwN5rNAdl60?=
 =?us-ascii?Q?kuTyqMFW2jLR9ULrzr7kpW+yWFGWmuBiAsCQXDxQPhOAs2WJ49CUbVtsbl0A?=
 =?us-ascii?Q?1TnyGA7q20jgVKv57oDSd1qe6+DIg7t5B+VWbNHRccYTdh4r6gaudLUCV+in?=
 =?us-ascii?Q?JcuiXf19vj8QB5c1FVrUcTxGVlWDkksyJcaxCnroEjpro0lR1ri5OfVlimc/?=
 =?us-ascii?Q?qrVsVN6dPBKST0DFY63P9WT5xP1rP9M+85AQg6kKztoQtDjugMrb+B31Y294?=
 =?us-ascii?Q?8wY3SCOA+fUCq4b4elu5IJi88WWtJmcAu+DvGEkBVFY9OBC1HBuv4yAPwKv9?=
 =?us-ascii?Q?bux8FqnzX80o6//od4eF+za/x7YRH8zt1uEjSIaJ2gWi/6eLq1+Bp2Q79PFb?=
 =?us-ascii?Q?4uZ68Cxq8pNeQcUzb9HmZ7+mvr48pSb5OJ5ciZX/IiRJE/3gxGxhWlU9iK2J?=
 =?us-ascii?Q?eBPCqLwmYQRTxI6gXDoOGN908Xac3brh+F6hwqzlNzrjyt5auXcVl3WPlnBh?=
 =?us-ascii?Q?285CPtWXE6zMv6WRYHBn9SHBOqIsBBOkUgMIccPXQig5uXN0looKsbo8htv3?=
 =?us-ascii?Q?eLmHHOLjoHAn5mUXpIco3AYgrzYuAqLx+tl/pcYfZrcNDH/9C92ubm9/DB30?=
 =?us-ascii?Q?iscmE2Y+6oA/f3Qfj2JpzFLhBbOreHxRR+ivQmpDYgupTIn8lHjVTxspLyIj?=
 =?us-ascii?Q?mNhi2DObYsP0AOr+VHCGW5HtvUW1yDnX9SFZ+OPJ8Fnnw64Paw8CpiLSYmEp?=
 =?us-ascii?Q?HVQLkSSJJsogiDgbFBy1BBt5qY3VFb6YGCLwAFWFlwZkRgjosMRmZ7AdKHx5?=
 =?us-ascii?Q?GCmMl7hb/qVvZIZ8BrQjemjF/WZXszCvTJkZ7iT/pPlGDO6GcpRjPX7tGJjH?=
 =?us-ascii?Q?dpIHiVu1sj7iWwZWijCCN8FLrDPfEVtKEJpbyshuoDqrHv6huvJeyHokiC8I?=
 =?us-ascii?Q?UR+8rEw2oVfEuCmDpOhZ5sPZRu5itIQAIwdXuRkHEokQN4+MGlitlsBmNca9?=
 =?us-ascii?Q?RUP9zP83RT1BpRkGaeiVLhaZkxbqN0jtshD4zKA+u4pGZUXAD707zvpHUdrK?=
 =?us-ascii?Q?13LtmbZKGLMfeH7w9+HxD5qeLgOe1PLRT4A9MDc466rr4Z1aWgwbHU8Are8E?=
 =?us-ascii?Q?9Jh4Kb3DQlI2T5TZH8Pw01Qu/6NgbzKBySnTrYqBFF7nM9ssuzxnpx4foIMp?=
 =?us-ascii?Q?BKvJkq37reFQWuD8IQFZg54KDhgFZ2mWd2omIXRvxZSxDqGxkDlzgmU/loQg?=
 =?us-ascii?Q?rf5rsFmgnBuY+pwKE3S7fmWeK0a7oxRVGn1rC0XX26WBbo+81z1MuM2JHgDg?=
 =?us-ascii?Q?ebtS7WcdUGXe5upWx6yJrNwMKmZ0uo8g+twjw7MM//D2mOxNjUWokqO7IVB0?=
 =?us-ascii?Q?Ig3oLcGsO8MF8blGFlYcZUbDDO4uYd5xvPSdZvEm8vl0d3sNJqi10jJ8ycyk?=
 =?us-ascii?Q?Bvl2Faaqp6PmnwFQEqQC3k3knF29DhM=3D?=
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
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ab12b9-b81a-4fa6-d23b-08deab52be99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 09:35:00.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XxWVLtbSPjyd3SDwyVdgSmhOP7miLyy3BLrd0UEZenCLLtjURonFEa4wTeYBWXtNWvHUR/QUHRcaWgoQZIdsUoxpJP3PXEj5yxmSsGXq7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7117

>=20
> On Mon,  4 May 2026 19:44:06 +0200 Holger Brunck wrote:
> > If the skb was freed in the ucc_hdlc_tx function and the packet marked
> > as dropped we need to return NETDEV_TX_OK. Otherwise the above layer
> > will try to requeue an already freed skb.
>=20
> Is this really true? I thought negative returns mean drop.

the API suggest to only use NETDEV_TX_OK or NETDEV_TX_BUSY as return value.
I checked several drivers and they are usually returning NETDEV_TX_OK if an
error occurred and the driver consumed the packet. But you are right
dev_xmit_complete will also return true if the return code is smaller than =
zero
and the packet is not requeued. Should I update the commit message or shoul=
d
the patch be dropped?

Best regards
Holger

