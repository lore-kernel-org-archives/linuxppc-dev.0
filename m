Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B313CC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:24:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5F92084B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HyVLESzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5F92084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fFym3j0nzDqN2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:24:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.53; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="HyVLESzV"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fFwx4XTvzDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 17:22:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLh4G7MeVFWY8EtzW7aAEx4Sd8OD6qWaHfFjgMWr06c=;
 b=HyVLESzVbf4XUX/OgmVNuZm4jIGPTIOOVyXehQIv81roRISY+UZt4FRWOhrM8jyTyl8+9dLnQ9rTv9oQ+hes1fw2ZRJvoOw67h7edDERqDQQDFEkK427GFaRBh33QyJpsEvL/z/U7Lb/cMUkLBVY1lQopKEk3zJIZ84IYjPQbw4=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6622.eurprd04.prod.outlook.com (20.179.235.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 07:22:32 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 07:22:32 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Thread-Topic: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Thread-Index: AQHU70ukHNhK1tLZLUSA3IU+ZLcz3qY0zJeAgAAu4YA=
Date: Wed, 10 Apr 2019 07:22:31 +0000
Message-ID: <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
In-Reply-To: <20190410042638.GB3032@Asurada>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2160b4cc-d678-4eb8-ebee-08d6bd854be1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6622; 
x-ms-traffictypediagnostic: VE1PR04MB6622:
x-microsoft-antispam-prvs: <VE1PR04MB66228DCD123C579B9E2553CBE32E0@VE1PR04MB6622.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(396003)(39860400002)(136003)(366004)(376002)(199004)(189003)(97736004)(86362001)(52536014)(256004)(1411001)(14454004)(99286004)(6246003)(26005)(106356001)(14444005)(5660300002)(74316002)(229853002)(9686003)(53936002)(71190400001)(71200400001)(11346002)(66066001)(6436002)(8676002)(68736007)(25786009)(81166006)(486006)(3846002)(55016002)(81156014)(105586002)(4326008)(478600001)(54906003)(2906002)(7736002)(305945005)(7696005)(446003)(6916009)(76176011)(6116002)(8936002)(186003)(316002)(6506007)(476003)(33656002)(102836004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6622;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uyNnLH4ai0ESWyMzqNGkLbtk7+zIO4h5SQHU18YvHYXcoGBGaWEY3vUsZcXeNCpyAli1x2x0yyVpxGBX7P0kC/boMX0WVILaREjUuK9vj3NbsFL/cOWF65vZcp4sXwK1f/U2Vtvqqfa7ZxqYYkZE8wyXjq06WKf1NXsocX8iaYKM1sMgy6OQjNz1eQI/Fqxuqdt1u3bdbIXqnrnbcfYSURKVf0+YbvQBVpxg8YrJpJlB1lqScBz7wIcKpHKOiaiDswnFAq5IcTAHECgFuzSw+84L2S40LU0hsEblb4xC737CmunHIZ91lv8n9Js8d21RjmWiOTm5yrsTXdN4pdO9JZMgRgdQVbmsN0B4RE+5kNkZh6e4bMH6y5Y9W4XiZNeSpWeVK1MDrb+d44iHgbgQyoU7RwEcSlfPkk9fbmRBZM8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2160b4cc-d678-4eb8-ebee-08d6bd854be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 07:22:31.9039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6622
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
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

>=20
> On Wed, Apr 10, 2019 at 03:15:26AM +0000, S.j. Wang wrote:
> > The table is not flexible if supported sample rate is not in the
> > table, so use a function to replace it.
>=20
> Could you please elaborate a bit the special use case here?
>=20
> The table was copied directly from the Reference Manual. We also have
> listed all supported input and output sample rates just right behind that=
 table.
> If there're missing rates, we probably should update those two lists also=
?
> Otherwise, how could we have a driver limiting both I/O sample rates whil=
e
> we still see something not in the table?
>=20

Yes,  I plan to send another patch to update the in/out rate list.  Do I ne=
ed
To merge that to this commit?  Actually we want to support 12k and 24kHz

> > +static int proc_autosel(int Fsin, int Fsout, int *pre_proc, int
> > +*post_proc)
>=20
> Please add some comments to this function to explain what it does, and ho=
w
> it works. And better to rename it to something like "fsl_asrc_sel_proc".
>=20
Yes, some comments should be added, but not so detail, because this functio=
n
Is get from the design team, but the owner has left.

> > +{
> > +     bool det_out_op2_cond;
> > +     bool det_out_op0_cond;
> > +
> > +     det_out_op2_cond =3D (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)=
) |
> > +                                     ((Fsin > 56000) & (Fsout < 56000)=
));
> > +     det_out_op0_cond =3D (Fsin * 23 < Fsout * 8);
>=20
> "detect output option condition"? Please explain a bit or add comments to
> explain.
>=20
> > +
> > +     /*
> > +      * Not supported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.
>=20
> Could be "unsupported". And it should fit within one line:
>         /* Unsupported case: Tsout > 16.125 * Tsin, and Tsout > 8.125 * T=
sin */
>=20
> > +      */
> > +     if (Fsin * 8 > 129 * Fsout)
> > +             *pre_proc =3D 5;
> > +     else if (Fsin * 8 > 65 * Fsout)
> > +             *pre_proc =3D 4;
> > +     else if (Fsin * 8 > 33 * Fsout)
> > +             *pre_proc =3D 2;
> > +     else if (Fsin * 8 > 15 * Fsout) {
> > +             if (Fsin > 152000)
> > +                     *pre_proc =3D 2;
> > +             else
> > +                     *pre_proc =3D 1;
> > +     } else if (Fsin < 76000)
> > +             *pre_proc =3D 0;
> > +     else if (Fsin > 152000)
> > +             *pre_proc =3D 2;
> > +     else
> > +             *pre_proc =3D 1;
> > +
> > +     if (det_out_op2_cond)
> > +             *post_proc =3D 2;
> > +     else if (det_out_op0_cond)
> > +             *post_proc =3D 0;
> > +     else
> > +             *post_proc =3D 1;
> > +
> > +     if (*pre_proc =3D=3D 4 || *pre_proc =3D=3D 5)
> > +             return -EINVAL;
>=20
> I think you'd better add some necessary comments here too.
>=20
> > @@ -377,11 +404,17 @@ static int fsl_asrc_config_pair(struct fsl_asrc_p=
air
> *pair)
> >                          ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(ind=
ex),
> >                          ASRCTR_IDR(index) | ASRCTR_USR(index));
> >
> > +     ret =3D proc_autosel(inrate, outrate, &pre_proc, &post_proc);
> > +     if (ret) {
> > +             pair_err("No supported pre-processing options\n");
> > +             return ret;
> > +     }
>=20
> I think we should do this earlier in this function, once We know the inra=
te
> and outrate, instead of having all register being configured then going f=
or an
> error-out.

Ok.
>=20
> Another thing confuses me: so we could have supported sample rates in the
> list but the hardware might not support some of them because we couldn't
> calculate their processing options?

No, just want to support 12k, 24KHz, or others as customer like.



