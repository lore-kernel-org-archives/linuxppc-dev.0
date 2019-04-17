Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A7C10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:05:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3275206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="knZ9o+0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3275206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kbtn6KDGzDqKq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 19:05:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe05::614;
 helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="knZ9o+0b"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02on0614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe05::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kbrt57fCzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 19:04:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwjob00YzK3C4sOi8ZTHvHprXhem2LA70B5tKlraN4w=;
 b=knZ9o+0bic10Cuzbs6aFDZ4o0E0w3Eq3tdwVaR6A/FYSJBFEErVYqlI5wOOE4t+NA8ZbjmNDFEK1133PDbnjZLWrsLN7WugIYG6jXCejd6bjuLMYaCZlOQT2+p7UKhfVkkhteQlws+pqj05VLwCsyd7BUMJPTPW+iFqrC2ZwIeM=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6431.eurprd04.prod.outlook.com (20.179.232.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Wed, 17 Apr 2019 09:04:01 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 09:04:01 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Topic: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AdT0/GcG100TVa/MRHKfxlkKyc55XQ==
Date: Wed, 17 Apr 2019 09:04:01 +0000
Message-ID: <VE1PR04MB6479AF6501388845572EC268E3250@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e61cf4a-46e4-40d0-56e2-08d6c313a281
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6431; 
x-ms-traffictypediagnostic: VE1PR04MB6431:
x-microsoft-antispam-prvs: <VE1PR04MB64310E63D68F5E6923919DCAE3250@VE1PR04MB6431.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(136003)(366004)(396003)(346002)(39860400002)(376002)(199004)(189003)(102836004)(8936002)(81156014)(81166006)(26005)(68736007)(486006)(186003)(8676002)(14454004)(476003)(86362001)(74316002)(5660300002)(97736004)(52536014)(71190400001)(71200400001)(2906002)(7736002)(305945005)(6116002)(25786009)(3846002)(6506007)(316002)(6436002)(4326008)(33656002)(256004)(54906003)(229853002)(6916009)(7696005)(1411001)(99286004)(6246003)(9686003)(55016002)(106356001)(66066001)(53936002)(105586002)(478600001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6431;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BGeDk0WtkgJGtj10SgrE/dGsE5K5h0kdsTVt2k9PoRpIsZals+W/CbmwZUjZN8/7cU1F/20YLAAys2hWCSwEaoeMGxOxU7xNsUJLKMqrXgdqAwS2bbWCpudvpmYuZjYMa6BXkiG7mLgj+MxxqcXYbqUJKw05Lnd2Y3jph2l9gcYgmh2NntFf62JWObvo1UxbGHbHa1ho2dR6FNLRbMzIzgFzY4VClD/75BZc+tG4lOczL8CzArifMyHjs+wyInqlmr26WYJGfxUI62d6Qnade3YXUbRbXxuspX5qlit7evNVKyB3jyu31fzVn6KlelNalacHoJYjKFc/yTrWuSr6p0ItM+MhZYyed8rE1jcz0QkQ7G6J6KdvP1bBWWBjm/DrbSLeINuDdJ2xpAcogRAn7i+0c4iX18XurHwTKWV+sUc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e61cf4a-46e4-40d0-56e2-08d6c313a281
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 09:04:01.6423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6431
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

>=20
>=20
> On Thu, Apr 11, 2019 at 09:39:06AM +0000, S.j. Wang wrote:
>=20
> > +/*
> > + * Select the pre-processing and post-processing options
>=20
> By aligning with other function comments:
> /**
>  * Select the pre-processing and post-processing options
>=20
> > + *
> > + * Fsin: input sample rate
> > + * Fsout: output sample rate
>=20
> I would suggest to use inrate and outrate to keep naming consistent.
>=20
> > + * pre_proc: return value for pre-processing option
> > + * post_proc: return value for post-processing option  */ static int
> > +fsl_asrc_sel_proc(int Fsin, int Fsout, int *pre_proc, int *post_proc)
> > +{
> > +     bool det_out_op2_cond;
> > +     bool det_out_op0_cond;
>=20
> By looking at the comments below. Probably better to rename them
>         bool post_proc_cond2, post_proc_cond0;
>=20
> > +     /* Codition for selection of post-processing */
>=20
> "Codition" -> "Conditions"
>=20
> > +     det_out_op2_cond =3D (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)=
) |
> > +                                     ((Fsin > 56000) & (Fsout <
> > + 56000)));
>=20
> Combining Daniel's comments + indentation alignment:
>         det_out_op2_cond =3D (Fsin * 15 > Fsout * 16 && Fsout < 56000) ||
>                            (Fsin > 56000 && Fsout < 56000);
>=20
> > +     det_out_op0_cond =3D (Fsin * 23 < Fsout * 8);
> > +
> > +     /*
> > +      * unsupported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.
>=20
> Funny thing is that there'd be no point in checking the 16.125, if Tsout =
is
> bigger than 8.125 times of Tsin, i.e. only one condition:
>         Tsout > 8.125 * Tsin
>=20
> > +      * Tsout>16.125*Tsin -> Fsin * 8 > 129 * Fsout
> > +      * Tsout>8.125*Tsin  -> Fsin * 8 > 65 * Fsout
> > +      * Tsout>4.125*Tsin  -> Fsin * 8 > 33 * Fsout
> > +      * Tsout>1.875*Tsin  -> Fsin * 8 > 15 * Fsout
>=20
> Took me a while to understand what it is saying....
>=20
> Better to write like this:
>         /* Does not support cases: Tsout > 8.125 * Tsin */
>         if (Fsin * 8 > 65 * Fsout) {
>                 pair_err("Does not support %d > 8.125 * %d\n", Fsout, Fsi=
n);
>                 return -EINVAL;
>         }
>=20
>         /* Otherwise, select pre_proc between [0, 2] */
>         if (Fsin * 8 > 33 * Fsout)
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
>=20
> <=3D=3D Would look better by moving post_cond calculations here.
>=20
> > +     if (det_out_op2_cond)
> > +             *post_proc =3D 2;
> > +     else if (det_out_op0_cond)
> > +             *post_proc =3D 0;
> > +     else
> > +             *post_proc =3D 1;
>=20
> And we could remove this check below:
> > +     /* unsupported options */
> > +     if (*pre_proc =3D=3D 4 || *pre_proc =3D=3D 5)
> > +             return -EINVAL;
>=20
> So basically we are doing:
>         1) Error out unsupported cases
>         2) Select pre_proc
>         3) Calculate conditions for post_proc
>         4) Select post_proc
>=20
> Thanks

Thanks for reviewing, will send v3.

