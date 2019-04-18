Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2BCC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 08:52:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1622083D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 08:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B82lOyt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1622083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lCXq3npczDqQk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 18:52:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.80; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="B82lOyt4"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00080.outbound.protection.outlook.com [40.107.0.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lCW72tshzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 18:50:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDH8Gs9gOI6Nt3wZaAXnUE98uF9FNVdZ2DMPgSDXiJk=;
 b=B82lOyt4rFgDQuakCtiMFvTVE1f5JHMwBMa+V1Xy/OKEkGyCruAldKQ90uzpCgK/QIsqNUZeOWTzrFcmWSavTZwZ7vt0DBlXb1mfBBN3OnwFNa0q2ycK8NpE+lOmQC0dPcIwZuSNvfiKY4PsvchKvMlcgxx33tdNj5klh2mCgao=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6717.eurprd04.prod.outlook.com (20.179.235.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 08:50:49 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 08:50:49 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Topic: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AdT1wt4f0LfTMAkAQai/jI2p7SWJLw==
Date: Thu, 18 Apr 2019 08:50:48 +0000
Message-ID: <VE1PR04MB647965FEAF3506E1775397AEE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 081fec1e-0255-40e5-2686-08d6c3daf470
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6717; 
x-ms-traffictypediagnostic: VE1PR04MB6717:
x-microsoft-antispam-prvs: <VE1PR04MB67175017C40BB87EA0F3CFB3E3260@VE1PR04MB6717.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(51444003)(55016002)(9686003)(53936002)(68736007)(1411001)(476003)(486006)(186003)(6916009)(97736004)(54906003)(99286004)(7696005)(6436002)(316002)(2906002)(3846002)(6116002)(33656002)(86362001)(102836004)(6506007)(26005)(81166006)(8936002)(81156014)(8676002)(229853002)(4326008)(5660300002)(66066001)(52536014)(305945005)(14444005)(74316002)(478600001)(25786009)(7736002)(14454004)(256004)(71200400001)(71190400001)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6717;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LZOk+NPwfNw5giji0Rstr12bzxoDrqDfFRE2vHjppUSx4llq/zsim0YpkhMthMRmVFR5qbvLGutHhS6HlZH+8FKAJecxww5hb62uQ71N+guf8MxNQl95LJw0js385uDf2on0toMsHVtmsSf5YGYl7JwDaXIssorwho9yz25n6RBPXTH76lUFMqkhz4JQihLjspmEX5FiU24S6mB46T/BqQUJfBMMD95aep1ZetFWRsq1pFzl0TQ4oea59X+ASm4ayK2WUlufrxqtocRyHBYyH+xA5NRK8YUzgt9toJ+pxZm4KzB8OF8aR4dkMcQi2cjUgG5+4MSfV3LIHcZWWObAK1ap0YxZWDEFEZygopykccNfRuM9StZvjHnhAHX+pzC/7hamHU7ub+v72kNE0C4yZjipMobH9XI78MetiibYEwU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081fec1e-0255-40e5-2686-08d6c3daf470
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 08:50:48.9570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6717
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
> On Thu, Apr 18, 2019 at 02:37:03AM +0000, S.j. Wang wrote:
> > > Here:
> > > > +     /* Does not support cases: Tsout > 8.125 * Tsin */
> > > > +     if (inrate * 8 > 65 * outrate)
>=20
> Though it might not matter any more (see my last comments), it should be
> "inrate > 8.125 * outrate" in the comments.
>=20
> > > > +             return -EINVAL;
> > > And here:
> > > > +     ret =3D fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_p=
roc);
> > > > +     if (ret) {
> > > > +             pair_err("No supported pre-processing options\n");
> > > > +             return ret;
> > > > +     }
> > >
> > > Instead of a general message, I was thinking of a more specific one
> > > by telling users that the ratio between the two rates isn't
> > > supported -- something similar to what I suggested previously:
> > >
> > >         pair_err("Does not support %d (input) > 8.125 * %d (output)\n=
",
> > >                  outrate, inrate);
> > >
>=20
> > In fsl_asrc_sel_proc,  we can't call the pair_err for there is no
> > struct fsl_asrc_pair *pair in the argument. Do you think we need to
> > add this argument?
>=20
> I's thinking of adding it to the top of fsl_asrc_config_pair() as a part =
of
> inrate-outrate-validation, however, I found that actually we already have=
 a
> similar check in the early routine:
>         if ((outrate > 8000 && outrate < 30000) &&
>             (outrate/inrate > 24 || inrate/outrate > 8)) {
>                 pair_err("exceed supported ratio range [1/24, 8] for \
>                          inrate/outrate: %d/%d\n", inrate, outrate);
>                 return -EINVAL;
>         }
>=20
> And this is according to IMX6DQRM:
>     Limited support for the case when output sampling rates is
>     between 8kHz and 30kHz. The limitation is the supported ratio
>     (Fsin/Fsout) range as between 1/24 to 8
>=20
> This should cover your 8.125 condition already, even if having an outrate
> range between [8KHz, 30KHz] check, since an outrate above 30KHz will not
> have an inrate bigger than 8.125 times of it, given the maximum input rat=
e
> is 192KHz.
>=20
> So I think that we can just drop that 8.125 condition from your change an=
d
> there's no need to error out any more.
>=20
No, if outrate=3D8kHz,  inrate > 88.2kHz, these cases are not supported.=20
This is not covered by

        if ((outrate > 8000 && outrate < 30000) &&
            (outrate/inrate > 24 || inrate/outrate > 8)) {

> However, we do need a patch to fix a potential rounding issue:
> -           (outrate/inrate > 24 || inrate/outrate > 8)) {
> +           (outrate > 24 * inrate || inrate > 8 * outrate)) {
>=20
> Should fix the missing whitespace also. And it will be needed to send to
> stable kernel too. Will you help submit a change?
>=20
> Thanks
