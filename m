Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6B8C282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 07:22:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AC22087F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 07:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sO3myiiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AC22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mPSc1m6gzDqWW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 17:22:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.45; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="sO3myiiI"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50045.outbound.protection.outlook.com [40.107.5.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mPQx47frzDqVD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 17:21:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4Kmrrp+vGD4w3K3HdsZQ2YSAVFPIC7rQZC6bvcIoE0=;
 b=sO3myiiIwK5c0ai3Kja+SwghSNbSGN40igiH0GxVLglNYb3Bd7kZiAIw9nD3ZDj4PmBzPEsrJflwa9Qze4GwgtSv8jlnO+iOguHADW1WP+c4mx22NMAKeBJzWISB5qMYNpGdzQDqJjM1kj4eNNK/jgE5RYfWl9ooh11OSKGT1UY=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.253.81) by
 AM0PR04MB4738.eurprd04.prod.outlook.com (20.177.41.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Sat, 20 Apr 2019 07:21:22 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292%4]) with mapi id 15.20.1813.017; Sat, 20 Apr 2019
 07:21:22 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V4 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Topic: [PATCH V4 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AdT3SZ7klP33S4s3Sf6ybjWjIglRMg==
Date: Sat, 20 Apr 2019 07:21:22 +0000
Message-ID: <AM0PR04MB6468C972CEBB98BC6E3AD73BE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 719e0c8a-550b-42d1-bdc5-08d6c560ca76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AM0PR04MB4738; 
x-ms-traffictypediagnostic: AM0PR04MB4738:
x-microsoft-antispam-prvs: <AM0PR04MB473830AC3B9F4EC111C04583E3200@AM0PR04MB4738.eurprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(68736007)(52536014)(66066001)(71200400001)(71190400001)(55016002)(6436002)(66556008)(64756008)(66446008)(73956011)(66946007)(1411001)(229853002)(66476007)(76116006)(6916009)(9686003)(53936002)(476003)(486006)(25786009)(6246003)(5660300002)(4326008)(102836004)(6506007)(33656002)(86362001)(14454004)(7736002)(26005)(305945005)(74316002)(186003)(478600001)(8676002)(81156014)(8936002)(81166006)(316002)(54906003)(97736004)(7696005)(99286004)(2906002)(6116002)(3846002)(256004)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4738;
 H:AM0PR04MB6468.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /SHSBOu8+zlwShL0NUSyWvhIOxSXHrue5/Cbufoynxc76EIPud7p5BmFDQ/Zoqivp5DULC51v6l7ZgVgnxEsNZTgOMvMvFphRX7azDilNYmmP31MpJnKzxr2lDVnhhR2yCE2+twikgaeKauEb+e6UfVQNrDT0YyJj3Otg7V5T8bVkZqbDP2tb2lgEIVFh+TbKEFw61L6z7TkFdcK+bI+MzkStc187RF45BA38bw+OYljikTAnOpYv3fA2pf3wcOIH7dN4tUvDgdYw15b478+fQJM/+Cp4erWSu0bmpTXZsMaOtF6DkqKS/gxCPhflSLon3OVcrKXTOPV6VDOdDRGm4jqa8M0mR6MqqGoZeUhycV/7SRM/cydgwdoXzEyJT50RiSgzI1zCHAmxLZfQAGN2bqhRJjuVO92R/wt3oTTfJI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719e0c8a-550b-42d1-bdc5-08d6c560ca76
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 07:21:22.2114 (UTC)
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

Hi

>=20
>=20
> On Fri, Apr 19, 2019 at 10:23:53AM +0000, S.j. Wang wrote:
>=20
> > @@ -289,6 +318,12 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pa=
ir
> *pair)
> >               return -EINVAL;
> >       }
> >
> > +     ret =3D fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc)=
;
>=20
> Since the function always return 0, I am thinking of treating this functi=
on as
> a lookup function, and then moving this call right before the register
> settings -- as we have already made sure that both inrate and outrate are
> supported.

Ok.

>=20
> > +     if (ret) {
> > +             pair_err("No supported pre-processing options\n");
> > +             return ret;
> > +     }
>=20
> And probably no longer need this error-out. If there's a new limitation
> related to this function, I believe we can add it to the rate validation
> section as we are doing now -- better to have rate validation code at one
> place.
>=20
Ok.

> > @@ -380,8 +415,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pai=
r
> *pair)
> >       /* Apply configurations for pre- and post-processing */
>=20
> Here:
> -       /* Apply configurations for pre- and post-processing */
> +       /* Select and apply configurations for pre- and post-processing *=
/
> +       fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> >       regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
> >                          ASRCFG_PREMODi_MASK(index) |
> ASRCFG_POSTMODi_MASK(index),
> > -                        ASRCFG_PREMOD(index, process_option[in][out][0=
]) |
> > -                        ASRCFG_POSTMOD(index, process_option[in][out][=
1]));
> > +                        ASRCFG_PREMOD(index, pre_proc) |
> > +                        ASRCFG_POSTMOD(index, post_proc));
