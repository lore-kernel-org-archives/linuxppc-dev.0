Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A8C282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 07:18:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3397A2087F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 07:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ltEyw9GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3397A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mPMY3mS4zDqW8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 17:18:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.46; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="ltEyw9GS"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60046.outbound.protection.outlook.com [40.107.6.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mPKn1R8xzDqVH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 17:16:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap4NekQ2+Dr/gUt/4k6TLoDIypV6WuvNvIsovKfwwB8=;
 b=ltEyw9GSvuB+OkNCZc4rnwfD8cANx4ihzz2ZTcbdo2cMKbTwUiQpSoQmQxEQcsUYc2TJ97cISh5mTsKZyY3dka6OXBbzV/JVOb9zrxEU9MRhVxsgmpj7/QmpGzjYd/O1Rgh8AJfH+8X/E9i2vdhK6wadbfwadYNPlcLln739cfc=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.253.81) by
 AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sat, 20 Apr 2019 07:16:50 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292%4]) with mapi id 15.20.1813.017; Sat, 20 Apr 2019
 07:16:50 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [EXT] Re: [PATCH V4 1/3] ASoC: fsl_asrc: Fix the issue about
 unsupported rate
Thread-Topic: [EXT] Re: [PATCH V4 1/3] ASoC: fsl_asrc: Fix the issue about
 unsupported rate
Thread-Index: AQHU9pn6besxYMR+kU6PSL+q5hShdKZDyQSAgADbVPA=
Date: Sat, 20 Apr 2019 07:16:50 +0000
Message-ID: <AM0PR04MB646849E3A8601038312FA9BEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <06c3e420b9fabfbec67becc2f9de009ce79a1d4b.1555669068.git.shengjiu.wang@nxp.com>
 <20190419181003.GA1136@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190419181003.GA1136@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d65ffded-8331-4834-9c0a-08d6c5602870
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AM0PR04MB6434; 
x-ms-traffictypediagnostic: AM0PR04MB6434:
x-microsoft-antispam-prvs: <AM0PR04MB6434957F6DEC74D1023F0B06E3200@AM0PR04MB6434.eurprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(7736002)(305945005)(446003)(476003)(76176011)(74316002)(11346002)(102836004)(6506007)(14454004)(486006)(478600001)(256004)(9686003)(53936002)(4326008)(55016002)(6246003)(26005)(186003)(14444005)(229853002)(6916009)(66446008)(64756008)(66556008)(66476007)(76116006)(86362001)(66946007)(73956011)(99286004)(6436002)(316002)(54906003)(25786009)(81166006)(5660300002)(81156014)(52536014)(3846002)(66066001)(1411001)(2906002)(97736004)(68736007)(71190400001)(71200400001)(33656002)(7696005)(8676002)(6116002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6434;
 H:AM0PR04MB6468.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lDB/tHn9p3+oejZ87+I58YEiiQP0JB3y/HjuydtuBezFg/VUY6rjDge1dB3tzuIBlNXylFwv0meefSELcZ8n9nxgm8GWq8krg2POrzAtrYViVC1DJv2hpiSLjXlHySvke9xT3On3LaeIackiHisHe36OI73cJ1oyjgbqOqD+L4e3AS8TRba2f/fx+axhIRM772kPTh+JqAbqMdgHZS2F06VJLktSDsJCRojO3UqbSmtm82J4ecFOzgMFeVwoiOfqRz6+hqz4EwjBhVo1P8qFQ5GiMRoelbJb/V6BF2ssjAGuw/XNjz7Qk9xuag9HUQjSFiuXWZ7oU4NlGImTujCO9wFR9HgMM1MdwhpBf7NW88F9KDOzrc7Vfkia6ILcmUaqFBx2j3skOt47uCbySY+8ACTZkvwXfQgWU48UoJVg85Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65ffded-8331-4834-9c0a-08d6c5602870
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 07:16:50.3943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6434
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
> On Fri, Apr 19, 2019 at 10:23:50AM +0000, S.j. Wang wrote:
> > When the output sample rate is [8kHz, 30kHz], the limitation of the
> > supported ratio range is (1/24, 8). In the driver we use (8kHz, 30kHz)
> > instead of [8kHz, 30kHz].
> > So this patch is to fix this issue and the potential rounding issue
> > with divider.
> >
> > Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz output
> > sample rate")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c index
> > 0b937924d2e4..5b8adc7fb117 100644
> > --- a/sound/soc/fsl/fsl_asrc.c
> > +++ b/sound/soc/fsl/fsl_asrc.c
> > @@ -282,10 +282,10 @@ static int fsl_asrc_config_pair(struct
> fsl_asrc_pair *pair)
> >               return -EINVAL;
> >       }
> >
> > -     if ((outrate > 8000 && outrate < 30000) &&
> > -         (outrate/inrate > 24 || inrate/outrate > 8)) {
> > -             pair_err("exceed supported ratio range [1/24, 8] for \
> > -                             inrate/outrate: %d/%d\n", inrate, outrate=
);
> > +     if ((outrate >=3D 8000 && outrate <=3D 30000) &&
> > +         (outrate > 24 * inrate || inrate > 8 * outrate)) {
> > +             pair_err("exceed supported ratio range (1/24, 8) for
> > + inrate/outrate: %d/%d\n",
>=20
> Using one of the conditions:
>         if (inrate > 8 * outrate)
>                 pair_err();
>=20
> This means:
>         if (inrate <=3D 8 * outrate)
>                 /* Everything is fine */
>=20
> So the supported ratio range is still [1/24, 8] right?
>=20
Oh, yes,  should still [1/24, 8].

> Thanks
