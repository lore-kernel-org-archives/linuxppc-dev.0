Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2979C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:23:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1964217FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IdT1+mKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1964217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lsWd0vN2zDqST
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 20:23:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.82; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="IdT1+mKS"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130082.outbound.protection.outlook.com [40.107.13.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lsTq0QqCzDqRS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 20:22:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTfWfKMRGxgWjQyPOI/DrsZ1lk71+rq7TWlhbOlgWfw=;
 b=IdT1+mKS7dh5fwKmeqPq+CFdikks85hDMO8Fdt9h6CSBtcVo/Pk42gP1KPULTENp88gPIfv0ARhJOAOz8Rf6Me9OlcLy10/oTX20qbbfuUDg8xEijojyJ9vjhegI8kuUDqTCtzmk4Wm0qRHaXvUbvXawkuiTNUh5PaBWA6mBi6I=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6608.eurprd04.prod.outlook.com (20.179.235.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 19 Apr 2019 10:21:58 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 10:21:58 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Topic: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AdT2mahGPYHg/GcGR3ixSkMFXKSUJg==
Date: Fri, 19 Apr 2019 10:21:58 +0000
Message-ID: <VE1PR04MB64791A6A54CBBA9897E67B50E3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b508a2c2-4012-4d87-b648-08d6c4b0dafa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6608; 
x-ms-traffictypediagnostic: VE1PR04MB6608:
x-microsoft-antispam-prvs: <VE1PR04MB66084EF1C8160A39DCFEEF20E3270@VE1PR04MB6608.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(51444003)(73956011)(4326008)(478600001)(186003)(53936002)(6506007)(25786009)(229853002)(6246003)(68736007)(14454004)(33656002)(66446008)(5660300002)(64756008)(7736002)(66946007)(6116002)(26005)(76116006)(102836004)(66476007)(476003)(1411001)(8936002)(6436002)(52536014)(74316002)(81166006)(6916009)(86362001)(55016002)(486006)(305945005)(8676002)(9686003)(54906003)(316002)(81156014)(256004)(97736004)(3846002)(71200400001)(2906002)(66556008)(71190400001)(99286004)(66066001)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6608;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: llUebqW5LrhuVAZZlt5g56xGYhw2R5TVm7vmWDgK0fkTorYdKy4fi0vnl6zmqjnYusxv/Ck6o3zpyzmW6LhNi3kyan+tj7kw+HtzhGQeroUQRRLtsjBcMjPJBAj7MPLU3MKefo6j/xd40V58sppl0pxos0MAAjbj3bHY11SOszeui6HLQLpvSoWL8E0EsSH4a/9tYOIQUJ9A5fIiFxJ3HsJKzQf7iNYg0hsvsJH4awhsa9NS51nliFYWf5fkLNNtH5nv6tdFJB+StEnGN+HYOY+Sm1VFfrtQGuqm6xmlvWe539nZccsWLdsry7xHJGR8BD9LRnqSEx/ycX0kqB6aBhuyo+Aq6rtGolScCdOBeN8NMVxn1o0VQ/bSDifJLVIseddzBD5JN+nvtvdD28ZnfWszD248FyNk6ZqdTWdKa+A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b508a2c2-4012-4d87-b648-08d6c4b0dafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 10:21:58.5104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6608
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
> On Thu, Apr 18, 2019 at 09:37:06AM +0000, S.j. Wang wrote:
> > > > > And this is according to IMX6DQRM:
> > > > >     Limited support for the case when output sampling rates is
> > > > >     between 8kHz and 30kHz. The limitation is the supported ratio
> > > > >     (Fsin/Fsout) range as between 1/24 to 8
> > > > >
> > > > > This should cover your 8.125 condition already, even if having
> > > > > an outrate range between [8KHz, 30KHz] check, since an outrate
> > > > > above 30KHz will not have an inrate bigger than 8.125 times of
> > > > > it, given the maximum input rate is 192KHz.
> > > > >
> > > > > So I think that we can just drop that 8.125 condition from your
> > > > > change and there's no need to error out any more.
> > > > >
> > > > No, if outrate=3D8kHz,  inrate > 88.2kHz, these cases are not suppo=
rted.
> > > > This is not covered by
> > > >
> > > >         if ((outrate > 8000 && outrate < 30000) &&
> > > >             (outrate/inrate > 24 || inrate/outrate > 8)) {
> > >
> > > Good catch. The range should be [8KHz, 30KHz] vs. (8KHz, 32KHz) in
> > > the code. Then I think the fix should be at both lines:
> > >
> > > -         if ((outrate > 8000 && outrate < 30000) &&
> > > -             (outrate/inrate > 24 || inrate/outrate > 8)) {
> > > +         if ((outrate >=3D 8000 && outrate =3D< 30000) &&
> > > +             (outrate > 24 * inrate || inrate > 8 * outrate)) {
> > >
> > > Overall, I think we should fix this instead of adding an extra one,
> > > since it is very likely saying the same thing.
> >
> > Actually if outrate < 8kHz, there will be issue too.
>=20
> Here is the thing, the RM doesn't explicitly state that ASRC can support =
a
> lower output sample rate than 8KHz. And I actually had a concern when
> reviewing your PATCH-2, as the table of supported output sample rate no
> longer matches RM.
>=20
> If you've verified a lower output sample rate working solid with the
> process_option function, that means our driver can go beyond the
> limitation mentioned in the RM, then I believe [8KHz, 32KHz] should be
> updated too -- that says we can do:
> -       if ((outrate > 8000 && outrate < 30000) &&
> -           (outrate/inrate > 24 || inrate/outrate > 8)) {
> +       if ((outrate >=3D 5512 && outrate =3D< 30000) &&
> +           (outrate > 24 * inrate || inrate > 8 * outrate)) {
>=20
> Actually "ourate > 24 * inrate" is kind of pointless for range [5KHz, 32K=
Hz]
> but we can keep it since it matches RM.

Ok, will send v4.

Best regards
Wang shengjiu
