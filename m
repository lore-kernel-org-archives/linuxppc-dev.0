Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F95AC282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 07:25:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C142087F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 07:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pd0zzxxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C142087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mPWj6YxfzDqRP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 17:25:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.42; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="pd0zzxxM"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mPTz5fVRzDqF3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 17:24:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuOClTrSOvNmKqAXD1SuSJVpiyHZUdR7xNusVbm1MKo=;
 b=pd0zzxxMi3iSCP/i99V0t1zebTPkDZzeLwOK6PSjoT+4NnWv2dN9V4nz+AaelydsqE6USPxQxes1qb5No0ow3Fdl5de5pyAEz1qfT8Auc+hCF5id+jijwI050S6KvUHT7mWnFeH6gbOkQQsMaHkoDtBDYES6bFTaK8Pknq2o+do=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.253.81) by
 AM0PR04MB4738.eurprd04.prod.outlook.com (20.177.41.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Sat, 20 Apr 2019 07:23:59 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292%4]) with mapi id 15.20.1813.017; Sat, 20 Apr 2019
 07:23:59 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Thread-Topic: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Thread-Index: AdT3Se/OJCHu/1nQSGmgszexFm3bDw==
Date: Sat, 20 Apr 2019 07:23:59 +0000
Message-ID: <AM0PR04MB646884E539AD85971FD255AEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd501440-ccf8-4ba8-5ed2-08d6c5612866
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AM0PR04MB4738; 
x-ms-traffictypediagnostic: AM0PR04MB4738:
x-microsoft-antispam-prvs: <AM0PR04MB4738D99697511E20576FC879E3200@AM0PR04MB4738.eurprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(68736007)(52536014)(66066001)(71200400001)(71190400001)(55016002)(6436002)(66556008)(64756008)(66446008)(73956011)(66946007)(1411001)(229853002)(66476007)(76116006)(6916009)(9686003)(53936002)(476003)(486006)(25786009)(6246003)(5660300002)(4326008)(102836004)(6506007)(33656002)(86362001)(14454004)(7736002)(26005)(305945005)(74316002)(186003)(478600001)(8676002)(81156014)(8936002)(81166006)(316002)(54906003)(97736004)(7696005)(99286004)(2906002)(6116002)(3846002)(19627235002)(256004)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4738;
 H:AM0PR04MB6468.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 84i5aHXo/BHjM5mA34aau3pxCdwC+XA5i9sGWM/zYBAwRAcIkpIr4u3Njr4UCNrsc2UpbUuLuPfMLWgrVl9ZsiWkwWKNgIQtOXS8bt8TEmP10kEwlllePXJ+Kuf33D2C8iPJnwXQpg7caJ6f5VKlV0A9ilbP1l+2VuItsNiqOpAtACKyuD/nkRXfnaseYKDQWhZYlIou+wFnqNz/sTFJl7oOLW/J8AipeX4R2EKPnja8xveG89JfYTmesD60tlBjPorC55CFUWyfKyiwpzbtkGhy3N65YIyQvX8ZSNhrlvLi5vfAKJV1ypf2kXyPcXFKKy31hlU5xhCWQS2yUc09tCFqqTeZ3MaXmCp5Vu4kUHxkgaFmOHL8TybVBZxZ2gz4E5BdWRmcxgu0XqhXeCawPxd+NEjTcLviAII7vENE8Gg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd501440-ccf8-4ba8-5ed2-08d6c5612866
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 07:23:59.8570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4738
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

Hi.

>=20
> On Fri, Apr 19, 2019 at 10:23:56AM +0000, S.j. Wang wrote:
> > Unify the supported input and output rate, add the 12kHz/24kHz/128kHz
> > to the support list
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c | 32 +++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c index
> > 2c4bbc3499db..0d06e738264a 100644
> > --- a/sound/soc/fsl/fsl_asrc.c
> > +++ b/sound/soc/fsl/fsl_asrc.c
> > @@ -27,13 +27,14 @@
> >       dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index,
> > ##__VA_ARGS__)
> >
> >  /* Corresponding to process_option */ -static int
> > supported_input_rate[] =3D {
> > -     5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 8820=
0,
> > -     96000, 176400, 192000,
> > +static unsigned int supported_asrc_rate[] =3D {
> > +     5512, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 4800=
0,
> > +     64000, 88200, 96000, 128000, 176400, 192000,
> >  };
> >
> > -static int supported_asrc_rate[] =3D {
> > -     8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 960=
00,
> 176400, 192000,
> > +static struct snd_pcm_hw_constraint_list fsl_asrc_rate_constraints =3D=
 {
> > +     .count =3D ARRAY_SIZE(supported_asrc_rate),
> > +     .list =3D supported_asrc_rate,
> >  };
> >
> >  /**
> > @@ -293,11 +294,11 @@ static int fsl_asrc_config_pair(struct
> fsl_asrc_pair *pair)
> >       ideal =3D config->inclk =3D=3D INCLK_NONE;
> >
> >       /* Validate input and output sample rates */
> > -     for (in =3D 0; in < ARRAY_SIZE(supported_input_rate); in++)
> > -             if (inrate =3D=3D supported_input_rate[in])
> > +     for (in =3D 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
> > +             if (inrate =3D=3D supported_asrc_rate[in])
> >                       break;
>=20
> Not sure if we still need it upon having hw_constraint. Maybe m2m needs i=
t?
Yes.
Best regards
Wang shengjiu
