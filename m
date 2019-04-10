Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEFEC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 02:41:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086C5206B7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 02:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VOfXFf0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086C5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f7hN5wC0zDqKg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 12:41:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.84; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="VOfXFf0G"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150084.outbound.protection.outlook.com [40.107.15.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f7fW72W8zDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 12:39:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKFHiLjrn+8TtpPZ7mZANkUDHnCiySZbA7PANUvCfEs=;
 b=VOfXFf0G9udGcdTsnwzdGIFpZpvBiGrmvRxXf2dqpSyJ/L1wFqAZtXnXEkbD+KCgGoCkLIjVHYfw9emu5xdID8HSkf3JC0srf9lZTpDGqXAIhWZ3LM/RVC2B1IoWVZnA7bVKhXxgFALAREu3+IYLTKtYxDwSVX/+5XRcxQ/lJ/w=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6672.eurprd04.prod.outlook.com (20.179.235.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 02:39:39 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 02:39:39 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>
Subject: RE: [EXT] Re: [PATCH V1] ASoC: fsl_esai: replace fall-through with
 break
Thread-Topic: [EXT] Re: [PATCH V1] ASoC: fsl_esai: replace fall-through with
 break
Thread-Index: AQHU7e1fLmmYRIJqIECtUR/V3RQ9hKYyaxcAgAC3L4CAAAg3gIAACaAAgAF9IZA=
Date: Wed, 10 Apr 2019 02:39:38 +0000
Message-ID: <VE1PR04MB6479E21639D20833A71F9B57E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
 <38a6d36e-0f8e-fe3d-202b-30371042e248@embeddedor.com>
 <VE1PR04MB6479C16BB1C92E1AE291BB12E32D0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <eba6372b-618c-4633-f0a9-06c034cf2f9c@embeddedor.com>
 <20190409035450.GA8476@Asurada>
In-Reply-To: <20190409035450.GA8476@Asurada>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee38b90f-3d36-4a91-3204-08d6bd5dc72f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6672; 
x-ms-traffictypediagnostic: VE1PR04MB6672:
x-microsoft-antispam-prvs: <VE1PR04MB667221F3D7F7226AECBC2C41E32E0@VE1PR04MB6672.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(81166006)(229853002)(478600001)(81156014)(186003)(2906002)(71190400001)(26005)(8676002)(33656002)(105586002)(93886005)(71200400001)(14454004)(97736004)(6436002)(3846002)(86362001)(68736007)(6116002)(106356001)(256004)(25786009)(316002)(6506007)(4326008)(5660300002)(110136005)(52536014)(7696005)(9686003)(66066001)(486006)(99286004)(54906003)(446003)(476003)(53936002)(305945005)(74316002)(11346002)(7736002)(76176011)(55016002)(6246003)(8936002)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6672;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ftLO+Squh4TD71kZg810gXUIhT/EzvwPVBAmbBtKnKvBS2hJvEMLxxh4tSCYgQW02xjqKDNXPPZqKtnhIxGjiDUXD/YR4T8MrLWz6kDdaX1BuJI4JesADuOC/MUP5Dl76KbOTSJsaeyBQys8q0cO5xtG1Iz2dEhnJYgOBTDmLBhIDxvdYgunAzvK0INdca7yrKiCucZHUYs5x0IwHvPLgpXyue5ehwjXMN3cI96BwvQ1tf8w5u6Ayx8Eh8FHArY3MkuV0MX7jDaEK71STQP92s0YOwoHuEAET2yHPmlU2PkaNR2KWQRB0uqLOsTUeETO0g496uV24TAES3eMSw3WV9LeoR3bel+zH4bWQdsB+KRfF2rWX6DdR41JeJZ/ibqX9E4A0qLbjPRcZrdUmUEDpKiz9wtkZejYYhQ3qO6tZV4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee38b90f-3d36-4a91-3204-08d6bd5dc72f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 02:39:38.9089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6672
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
> Hi Gustavo,
>=20
> On Mon, Apr 08, 2019 at 10:20:25PM -0500, Gustavo A. R. Silva wrote:
> > >>> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> > >>> index
> > >>> c7410bbfd2af..bad0dfed6b68 100644
> > >>> --- a/sound/soc/fsl/fsl_esai.c
> > >>> +++ b/sound/soc/fsl/fsl_esai.c
> > >>> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct
> > >> snd_soc_dai *dai, int clk_id,
> > >>>               break;
> > >>>       case ESAI_HCKT_EXTAL:
> > >>>               ecr |=3D ESAI_ECR_ETI;
> > >>
> > >> Also, you should use a simple assignment operator "=3D" instead of
> > >> "|=3D" in both cases.
> > >
> > > The result is same for "=3D" and "|=3D", because there is "ecr =3D 0"=
 in
> > > beginning of This function.
> > >
> >
> > Following that same logic, then why not use "+=3D" instead?
> >
> > The point is: is "|=3D" or any other assignment operator other than "=
=3D"
> necessary?
> > The answer in this case is: no, it is not.  So, go for the simple one
> > and avoid any unnecessary confusion.
>=20
> I would like to keep "|=3D" here, just in case that someday it'd be easie=
r to
> insert something to ecr before this chunk. So please get easy on this one=
.
>=20
> Thanks
> Nicolin

Thanks for reviewing,  I will send v2.

Best regards
Wang shengjiu
