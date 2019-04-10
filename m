Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 08:28:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DAC2075B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 08:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HJg6xbKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DAC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fHPC5ZGWzDqNf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 18:28:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.67; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="HJg6xbKO"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50067.outbound.protection.outlook.com [40.107.5.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fHMN3tddzDqKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 18:27:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJo06j27WktJK+52OfXyFei+A3ilBuDMAW2BU6jAfvg=;
 b=HJg6xbKOfnO/pu2kxG0/y4Y+RVecYR1uhS/LoKag0jrDEcj+abcj0oP9vYUpKX9wl1k4cz9FCQT0FHFcwOQA6x2bCiy8ygJuXDTJvvEcEVnTZMPc/sy/qq8n4rEJjrG1X5Whu+73QGHvqY4I5ue4nr2jmO/e9uqYLlnVe/YR8Oc=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6653.eurprd04.prod.outlook.com (20.179.235.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Wed, 10 Apr 2019 08:26:59 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 08:26:59 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Thread-Topic: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Thread-Index: AQHU70ukHNhK1tLZLUSA3IU+ZLcz3qY0zJeAgAAu4YCAAAz6gIAABtzA
Date: Wed, 10 Apr 2019 08:26:59 +0000
Message-ID: <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410080052.GA5180@Asurada>
In-Reply-To: <20190410080052.GA5180@Asurada>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05ffb324-4ac4-478a-b781-08d6bd8e4cf7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6653; 
x-ms-traffictypediagnostic: VE1PR04MB6653:
x-microsoft-antispam-prvs: <VE1PR04MB665385146E8B2DB68251B8A5E32E0@VE1PR04MB6653.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(13464003)(53546011)(6506007)(102836004)(86362001)(186003)(76176011)(26005)(6916009)(8676002)(7696005)(508600001)(66066001)(71190400001)(71200400001)(6116002)(2906002)(3846002)(14444005)(5024004)(316002)(256004)(54906003)(99286004)(93886005)(476003)(486006)(446003)(33656002)(6436002)(55016002)(11346002)(1411001)(9686003)(97736004)(229853002)(4326008)(8936002)(68736007)(6246003)(53936002)(81166006)(74316002)(81156014)(25786009)(52536014)(105586002)(305945005)(5660300002)(14454004)(106356001)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6653;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z9MbMCL73gv0JbJIPVj5RvvwL5Q/RTA1W3gkwfjaHQhL+QukAbFvOCtFsK8O34OFlBtTNODnYjZ9M6xJKXpFOJ7bfJNnJgdLD9VhEoYissrP4VRbSM0F6X7zTyoNGbkKbO6XIE3smqsuw6VBin3HFglArxMwYJFGHQPIhFdya79GKhUFN5mEZBzpU4rMrYt8RhQYUVykA5YZKoJ+7e2hDwI0KNl/dPXkmPmTTOz0X6JXn6ePQ/NboIPHAotYS1qxOcfnKa/1hRiJxZgSBANVQLFsXGLoj4Ld1TURnl2mZV3Ta9vnQHIrB11itABaweDLQSMZZgsTUgalDhcW67xcjXf/F9zQBVKxiiy4cZrzsxpqFt0r1YJ5M9RUbQatqhAvtWDiGYQv5oUSRTVYHwCIrKuusOimN41Uplhd0rk+XPM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ffb324-4ac4-478a-b781-08d6bd8e4cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 08:26:59.2721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6653
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



> -----Original Message-----
> From: Nicolin Chen <nicoleotsuka@gmail.com>
> Sent: Wednesday, April 10, 2019 4:01 PM
> To: S.j. Wang <shengjiu.wang@nxp.com>
> Cc: timur@kernel.org; Xiubo.Lee@gmail.com; festevam@gmail.com;
> broonie@kernel.org; alsa-devel@alsa-project.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
> table with function
>=20
> WARNING: This email was created outside of NXP. DO NOT CLICK links or
> attachments unless you recognize the sender and know the content is safe.
>=20
>=20
>=20
> On Wed, Apr 10, 2019 at 07:22:31AM +0000, S.j. Wang wrote:
> > > The table was copied directly from the Reference Manual. We also
> > > have listed all supported input and output sample rates just right be=
hind
> that table.
> > > If there're missing rates, we probably should update those two lists =
also?
> > > Otherwise, how could we have a driver limiting both I/O sample rates
> > > while we still see something not in the table?
> > >
> >
> > Yes,  I plan to send another patch to update the in/out rate list.  Do
> > I need To merge that to this commit?  Actually we want to support 12k
> > and 24KHz
>=20
> Please send separate patches but in one series. And a question:
>=20
> Is it possible to update the table? It'd be way quicker to use lookup tab=
le
> than real-time calculation all the time. I believe you can simply calcula=
te all
> the values out for 12KHz and 24KHz since you have the function. If there =
are
> certain combinations of these two not being supported, then we could mark
> it with a special value and add an if-check to error out.
>=20

Yes,  but I think the function should be more flexible, if someday we need =
to support
Other sample rate, only need to update the list.

> > > > +static int proc_autosel(int Fsin, int Fsout, int *pre_proc, int
> > > > +*post_proc)
> > >
> > > Please add some comments to this function to explain what it does,
> > > and how it works. And better to rename it to something like
> "fsl_asrc_sel_proc".
> > >
> > Yes, some comments should be added, but not so detail, because this
> > function
>=20
> As much comments as possible.
>=20
> > Is get from the design team, but the owner has left.
>=20
> OK...that's sad...
>=20
> > > Another thing confuses me: so we could have supported sample rates
> > > in the list but the hardware might not support some of them because
> > > we couldn't calculate their processing options?
> >
> > No, just want to support 12k, 24KHz, or others as customer like.
>=20
> I was confused because the I/O rate lists not getting updated.
> It makes sense now if you are abort to update them.
