Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D4C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 08:23:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6E4218AD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 08:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NmN5TT5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6E4218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442xh72tMhzDqFG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 19:23:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.43; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="NmN5TT5Y"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00043.outbound.protection.outlook.com [40.107.0.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442xfH3JjBzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 19:21:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YMYZq2EBm6Ugg80DGqS9UQBeIb1Q0NwH4kNVM7OMHY=;
 b=NmN5TT5YJA3V1wNBKd/SAwwWVA7iqWJ3sdc4jjINkOXvMpqNKbD70z37CMKNHHU3wcPIvcWAl8NHW5/t+sw464/n1TmaRWQP6SYgMTIa0fVjObIIblI6e2PHBhfgaB8lxVuFABPAMZS4UaLv1DrFhaDHfLLBwElOmXriKpwgVTA=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3373.eurprd04.prod.outlook.com (52.134.1.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 08:21:17 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 08:21:17 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH V2] ASoC: fsl_esai: fix register setting issue in RIGHT_J
 mode
Thread-Topic: [PATCH V2] ASoC: fsl_esai: fix register setting issue in RIGHT_J
 mode
Thread-Index: AQHUxy7krEjmtZwkZU2ieefZbngvWqXlMpKAgAADJ1A=
Date: Mon, 18 Feb 2019 08:21:17 +0000
Message-ID: <VI1PR0402MB3392FCBB2D654C8AF706F3B0E3630@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <2a1997c2cd213ebfde70a2b325644de51e77d159.1550455620.git.shengjiu.wang@nxp.com>
 <20190218080345.GA27289@kroah.com>
In-Reply-To: <20190218080345.GA27289@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34ec75e4-25fe-48a0-263a-08d6957a0e23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3373; 
x-ms-traffictypediagnostic: VI1PR0402MB3373:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR0402MB3373;
 23:M+5SqBxSET5sYn9S9fDsRXa5nRdcDyls5ytl/jg?=
 =?us-ascii?Q?fln7jflwe2FGc0ou15pjikDr5TLXy7SaaL8ugGw3UzgqSNmWdywJYvvic1Zg?=
 =?us-ascii?Q?2Yzm03Qx5btrNYw1mPdwUmv7PUv0Z8DUAV8GwXLbPwwClMF59ibrGxfIDCA6?=
 =?us-ascii?Q?DESgME79U2NeSl8dVhhDdSFvVtiHdQbvfEWvhAJGlBRkVahoKTeL/KSMgB7/?=
 =?us-ascii?Q?R9Uu4vNMdnle/grTE5LnfpdenRebV1hbt8tIy1GYkqcs1gLlYS/T0IbcTFvN?=
 =?us-ascii?Q?42uhnSo4JbE+15L2x8zn49KLnYb7s4T1cx6M5T849awlTW5LOlH0JEzHOeWo?=
 =?us-ascii?Q?3Pl2JBMSZ95QF8pYToA3eDaJixD1alXX+sSMDbdEuJjEYWSH42NptE2cbhj2?=
 =?us-ascii?Q?5i+EBVI4Pw799Tl8Wa3Ho3DyhUQrbixWm1bxgu31ESdPBXFdjHtr6skDyLa5?=
 =?us-ascii?Q?QvKE5wZXF5ayFXEV0xSPxyCCxFJbwOb5CZgM3v7BAMgS884JFU67qMaHd4h0?=
 =?us-ascii?Q?X1kuokZ1D4HWuGSHvV5uifN3au9ymzr1W4GY4aEQkRtoGxrJlTMGuoVQr50R?=
 =?us-ascii?Q?xxdwMOpcigidy+EHm9RL6yv2LZtikFF6qfR/Q4YeFRaPlgQ6Q+YtjDPWstGv?=
 =?us-ascii?Q?vshEzsd8CznifJeW9sctoYBWvRa7TxKr7Fd+F7OHvHWp2B5FNV3pMZ66X+0Q?=
 =?us-ascii?Q?jDLYLb/hcOTBFdJX9THm4matAel0v7JPC/go/HP9kkj2Zr1nWn+bshfSc018?=
 =?us-ascii?Q?EqguZT0qVEdz6ByrPInzdc9IurUqIF2JGCWtCSaGyQ0FVVHOD68WVfbBM55X?=
 =?us-ascii?Q?9irXteWGYJWiUk7CZvjmFA1lZ1db7mN/vzS/EQOtpWdlVocsnS7N2Oxjw5zK?=
 =?us-ascii?Q?vEpYw9GvMkz+93M88hAZX2nUp5KXzQ5Ch3c1J6ccwa3zquE7OEnte5v69y1v?=
 =?us-ascii?Q?LT+IBHC2CUoIDMBghPa3LmfEabhbUShRh2A4aQYQmm5ihIpNP09xGs//ugO6?=
 =?us-ascii?Q?pvll9Yqq9EUcOvGys4xRywiOBFHD5ykBKM5eoOYV9prpY/HFxgYiBIK6oZrZ?=
 =?us-ascii?Q?6O+/WLTxBjglrz5fOlmnc8aipGfzutTCO7Hqgqjy3YfdF5wzF/ZSx6i8hjKn?=
 =?us-ascii?Q?GMSA92e7YgabubDZon5N83vKjLDC6Jfgv6noLzAfqrl54ygElDTT0hIm63gh?=
 =?us-ascii?Q?F7AEo7ahswP7xDX1p7SEJeZttsgwwzRtU6NHnpqQN8RrrGjS8SMAxtimhJTE?=
 =?us-ascii?Q?1cqCPj/l0feO93nk+VR1zrwMdMXUOG65CPhuBOmLi?=
x-microsoft-antispam-prvs: <VI1PR0402MB3373D254279018E84505C356E3630@VI1PR0402MB3373.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(8936002)(55016002)(6116002)(3846002)(6306002)(8676002)(4744005)(7736002)(229853002)(305945005)(6916009)(7696005)(33656002)(74316002)(6246003)(4326008)(54906003)(6436002)(68736007)(2906002)(81156014)(53936002)(25786009)(9686003)(76176011)(81166006)(256004)(71190400001)(71200400001)(105586002)(66066001)(316002)(99286004)(106356001)(186003)(26005)(486006)(5660300002)(86362001)(45080400002)(478600001)(476003)(446003)(11346002)(966005)(102836004)(6506007)(14454004)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3373;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZB6fIos3ayqsXGi+/ZFcXTdyA8vwfsTWLHceN8keXvI+KQSCPcRFGcRE9rYBZGXM/ITe4SREOVkk0QU9d2JS3xl46HKKx7e1qH+pz4pDV46luxddV393VpuYbGIspl155/G9GNmWqDJtCnhntV1dZzCOhOnAfnjey3fekorAx4q+2fvHnD5Smkqj9dzBO4eygHKA+quifbVorSfAtvAdbkxzfuQM5R2k7IxwYoLVIUYLPViAWXkI4Xet1dKJQAbuWfz8YMbzWs8+1wC8hEYomBFHJFrk0dUoV+pbGd4Z2AYLmT1+ycUqfHunC1gU6Th4YUPEd0iLw4O+WAuWW3eDBqZiLT098NbPb+cbIp5YH5DHPI3CN7RPpPM/C8WrBy2OPSTd+qZztanbyV+6x567nLpMESBuDMJAh1WWX/5cB5M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ec75e4-25fe-48a0-263a-08d6957a0e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 08:21:17.4556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3373
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thanks, will send the patch again.

Best regards
Wang shengjiu
>=20
> On Mon, Feb 18, 2019 at 02:08:52AM +0000, S.j. Wang wrote:
> > Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> >
> > The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
> > wrong register, correct it.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> > Changes in v2
> > - add Fixes tag and cc stable kernel.
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the stable
> kernel tree.  Please read:
>=20
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fstable-kernel-
> rules.html&amp;data=3D02%7C01%7Cshengjiu.wang%40nxp.com%7C16b1bd8
> d2f1c43b82dd108d695779d87%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C636860738312039576&amp;sdata=3Dl5OkD8ToHrcGa4dbXOuHdFTIF
> pVdN9u5AzCZKj2C5Ew%3D&amp;reserved=3D0
> for how to do this properly.
>=20
> </formletter>
