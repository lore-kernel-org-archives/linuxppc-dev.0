Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE18DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 08:33:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D077D2085A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 08:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RFb2+3LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D077D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449jPP5GmYzDqSh
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 19:33:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.81; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="RFb2+3LX"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150081.outbound.protection.outlook.com [40.107.15.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449jMZ2TKzzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 19:32:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+83Y0gq/rb6+m60QlIQXlFZuKlNkvVFwWd+RaOXj06c=;
 b=RFb2+3LX7ATj/Tb4mpmlLFr2IRhtl2vM7s/bfjUWHgBmEYeCIPd0G/4K44TGX3wIAWzseh6F/hGGX5YSnDyojud3TvAMitqgIVLgf9ovgp+ye0rV9TyjPgbZ0Ar9MXKifmmBDV1yzSASWd/JlyHiw0h+Ne2u9rtWmYnaRDrFWKU=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB2783.eurprd04.prod.outlook.com (10.172.255.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 08:32:00 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 08:32:00 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older
 version
Thread-Topic: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older
 version
Thread-Index: AQHUz9cJhoJPvCZVnE6C6u5MyrK9cKX2FFmAgABDKNCAABSkAIAABn1g
Date: Fri, 1 Mar 2019 08:32:00 +0000
Message-ID: <VI1PR0402MB3392E628FC3B12F7B04DE20CE3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
 <20190301080812.GA5244@Asurada>
In-Reply-To: <20190301080812.GA5244@Asurada>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2e598f8-4898-4ca7-d4c6-08d69e205fe3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2783; 
x-ms-traffictypediagnostic: VI1PR0402MB2783:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR0402MB2783;
 23:73FsBMqei+kzFbwq+py6atIMQJDJxXKQzwr0avI?=
 =?us-ascii?Q?y1R61Ed299lue57Xh0HtgMyU5+bBYyqKOWNHCIi7uOt8SjHqahqYB4pxiXGC?=
 =?us-ascii?Q?ShXrO4hbzlws3ootAl4iBHPf14JmTyKt7h+7+RjNEM/yKVie3v9z2Zl3zWrT?=
 =?us-ascii?Q?02G3AkGZ3R24CxjG9hy/f2ixGN2In0ESQPbhakcgQHjFCuNGL9rqB/2HrgEs?=
 =?us-ascii?Q?cHTGQyEcvKbaUqz1xUnJSqh2S/e5bG33P5A1E32qKrPG+1PJHaufMvA1dVnX?=
 =?us-ascii?Q?RRxSvH4iaGbc2iEwUl7uLM/ZZGnNh3RKJ/hnFqkSpzLJqD2rIVYfY3ktWLet?=
 =?us-ascii?Q?/6lkc6ZQ9RxDcqMKJwWr8RFMMYxeDyv50LlswZxnNIRg6eC5LmFoS/KvXppx?=
 =?us-ascii?Q?MCrjQFHhTAmd3gLaJ+eoisYdL7TY8KiG6HGLeey8wO18j2PAWdaytSnN+eQB?=
 =?us-ascii?Q?RzOYwwJ+HBHhmSGp5kkek+obBvT8w1QY9U/OfLu3ZRyagqkLOlZwEILDZGzW?=
 =?us-ascii?Q?cVvfaTICtoFBSK9thI+w0jDJSPwWrXa3mTjjwUoouZovCLsjmagze9Wnllqr?=
 =?us-ascii?Q?M5/ySIgeNfk1jgAUGmid9ZsbTdI7/TelxVu2nTAGeAGamy0fZecCoV4w9uV1?=
 =?us-ascii?Q?NySw0RSnZ2O6KyOB86tqobaSEvR+Zo4RDxwy2u/jxRvXtegEFXs2IqV+i4vb?=
 =?us-ascii?Q?1djIPkTL7nkHx2Zli6u7S30jEI7JPhLFYwlJdrFIFvVTwF/UdXedLfbS7Jvr?=
 =?us-ascii?Q?TETsvbV2pX+feF8lLwwr07NSnW1WjzZiRjj0Ki/mtW5S1K2jSAjrWO1wF50h?=
 =?us-ascii?Q?J7wmsKJXGCbsSMPj53DRDslZNqHfcVg2VV8WRkK7IuaXZEbZsDXCaAo+DYR3?=
 =?us-ascii?Q?a3a1Y+wTKMiDz2NPm6dGsguFYW4wsFsmC1U052ZPc7atX+gi6VXvozxtyL8n?=
 =?us-ascii?Q?DdnIgAgfe+008xhDZaynK/ILFZ1W9YWGieWN2xCwoKRupxh5IndQTlbo9nBo?=
 =?us-ascii?Q?pPsCjOewY9gMb9jeHLDsWE/LWfgP5Vqm9DvicdM3ZH2ZReadphLIeAME4/LP?=
 =?us-ascii?Q?Xs2F1qHV0xv4NSvx7tZ4BbxBnLQB1IUkPBn/KwKmgwDiha8n7UxPWvZchPtZ?=
 =?us-ascii?Q?DdlE59efeN33POWH9iM9qjkzcLQJRM9n1rJZUfyODifGt8OjP+VvKoUuzWxc?=
 =?us-ascii?Q?fnvh9vCuwPqdzwBdGfpn8IihRomXRoLI2pQiuPi8ymRDrpgAjEcuFK7k0zpd?=
 =?us-ascii?Q?MAjluyFeEqxtHP0AygPQz40no3Rt3714Sq5scJIywOT9FAPdNQUX94xvjSct?=
 =?us-ascii?Q?UFQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB27836B433B174C60DFC7EF54E3760@VI1PR0402MB2783.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(486006)(74316002)(71190400001)(6246003)(446003)(76176011)(186003)(14454004)(11346002)(54906003)(316002)(99286004)(71200400001)(26005)(66066001)(476003)(256004)(2906002)(6116002)(3846002)(6916009)(14444005)(8676002)(33656002)(8936002)(53936002)(97736004)(4326008)(81166006)(6436002)(9686003)(6506007)(478600001)(93886005)(52536013)(229853002)(25786009)(1411001)(106356001)(305945005)(68736007)(105586002)(4744005)(5660300002)(7736002)(55016002)(102836004)(7696005)(86362001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2783;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eK81rV/DLTtQL4oeWxDU+eNVRf3zGzrvv31e8iUHxlbcUKioQeXjrhGvi7mizu5yu+KrV2qz8v2YUyeze14w/9Eg556nsJcPYnOBqkb1+6I4Y6un9YyvpiqJJCypJ6IGo/gkNdI4MyF6lXzstXMdJ5hnFE0hgzLoKWA/lBjyX+o6iNvBgSbncIRlqOUCtRtlmvz4syX5S2NBMXZIvkdt508Izc+C22EwDecYYZtwtDYwpwFRnQvBpUuabKILcBrOMa9Bh3AjI/BHcrVyQhJbf4psqJWfa8RapCeOowptYdB3YHtu4RABTpE12wQWeQkB2BRccuokivHm6wXc44U4pKiwUvk+SIJfP0pTEmBm//y1GDX+LeSua/d4uJfdzxG69IGig+8SWSnxoQ1gh5INCkz04AObM925RTtZIUN0qZs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e598f8-4898-4ca7-d4c6-08d69e205fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 08:32:00.3321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2783
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
> On Fri, Mar 01, 2019 at 06:55:25AM +0000, S.j. Wang wrote:
>=20
> > > Alternatively, I feel instead of error-out at here, should we add a
> > > HW constraint or at least fence it off at the beginning of the
> > > hw_params()? This is actually nothing specific to the pair-request
> > > function but a hardware constraint.
> >
> > How about add constraint in startup?
> > static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
> >                                struct snd_soc_dai *dai) {
> >        struct fsl_asrc *asrc_priv =3D snd_soc_dai_get_drvdata(dai);
> >
> >        if (asrc_priv->channel_bits =3D=3D 3) {
> >                snd_pcm_hw_constraint_step(substream->runtime, 0,
> >                                           SNDRV_PCM_HW_PARAM_CHANNELS, =
2);
> >        }
> >
> >        return 0;
> > }
>=20
> Yea, that looks good to me. Better to have a line of comments to tell tha=
t
> "bits=3D=3D3" means older version -- maybe we should have something much
> more clear than using channel_bits but it is fine for now since they only
> differ here.

Ok , will send v2.
