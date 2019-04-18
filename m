Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CFBC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:39:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD7B214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="paJn9PWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD7B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lDZc2spczDqRs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:39:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.52; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="paJn9PWN"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10052.outbound.protection.outlook.com [40.107.1.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lDXY7414zDqR2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 19:37:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YHjxUNBgMXBbG0jmqUwKUXuBu/lrO2z7nNJ23zeaZg=;
 b=paJn9PWNVKD7TKo1gUn/7spApbqMqndRZQWbzXm1ZCRxfKy+bQ9AqHIFeJLd8vqinyHOitMZUbaYtq4xF9sUzlIX+VPw6+Yan896d9znjLf16gs+JMlqZ+hBGM4G3ulq52tLvFx23re9NeMugc5YrcWJ+cGEWD6w5QjcY03F5pA=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6431.eurprd04.prod.outlook.com (20.179.232.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Thu, 18 Apr 2019 09:37:07 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 09:37:07 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Topic: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AdT1ygSoHCmReGuZQEy0/qItfl4BNQ==
Date: Thu, 18 Apr 2019 09:37:06 +0000
Message-ID: <VE1PR04MB6479228E9CAE2A432D904BC7E3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 903b7bda-cde2-47fd-72cb-08d6c3e16c3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VE1PR04MB6431; 
x-ms-traffictypediagnostic: VE1PR04MB6431:
x-microsoft-antispam-prvs: <VE1PR04MB643166C840E94A2007F761A1E3260@VE1PR04MB6431.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(51444003)(81156014)(81166006)(8676002)(26005)(8936002)(102836004)(486006)(6506007)(186003)(68736007)(86362001)(97736004)(74316002)(5660300002)(71190400001)(52536014)(71200400001)(2906002)(316002)(25786009)(305945005)(6116002)(3846002)(7736002)(6436002)(4326008)(33656002)(54906003)(229853002)(99286004)(6916009)(7696005)(256004)(1411001)(6246003)(55016002)(9686003)(66066001)(53936002)(478600001)(14454004)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6431;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z2RJ2yQgkLdOu4sBl6dANVry+3q4PV+2eYYx9K7jKBmoznHkPE/MHM0btW42JvSt2FtRcmUj1hKxrKr1SPN8TiX0HP7Z+6+krEHJfIsSisMJijP8aw89MpDBQ2Xai8sXMEcHnSR0McXpYGoO6Y14/sVXag+23J2MUMk9z1rrk8hrmhD4mJ3o41X3IvQGH27Rgmfb6i3CpM3bEHaNA7xcI8BYtqMLw5ibqT8G+mchuX7mduChKWhYQbniuT7Es/UnZImgO8nY2PeS9GMk78pKnrwsy0wuzFFdJ4YskjIQq8K5Nhno7sQokpORO4lkZTxNYyBpaDf7rcGZcmB84qwWTI+G8LUX5bOQldFLlUP/ihNVvXXyFuYf5Sem0WD1u2PkryJ0Xoi8EyEy4zm2uoowjslpcwnLIeSgrIsaQbnwkpo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903b7bda-cde2-47fd-72cb-08d6c3e16c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 09:37:07.0086 (UTC)
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
> On Thu, Apr 18, 2019 at 08:50:48AM +0000, S.j. Wang wrote:
> > > And this is according to IMX6DQRM:
> > >     Limited support for the case when output sampling rates is
> > >     between 8kHz and 30kHz. The limitation is the supported ratio
> > >     (Fsin/Fsout) range as between 1/24 to 8
> > >
> > > This should cover your 8.125 condition already, even if having an
> > > outrate range between [8KHz, 30KHz] check, since an outrate above
> > > 30KHz will not have an inrate bigger than 8.125 times of it, given
> > > the maximum input rate is 192KHz.
> > >
> > > So I think that we can just drop that 8.125 condition from your
> > > change and there's no need to error out any more.
> > >
> > No, if outrate=3D8kHz,  inrate > 88.2kHz, these cases are not supported=
.
> > This is not covered by
> >
> >         if ((outrate > 8000 && outrate < 30000) &&
> >             (outrate/inrate > 24 || inrate/outrate > 8)) {
>=20
> Good catch. The range should be [8KHz, 30KHz] vs. (8KHz, 32KHz) in the
> code. Then I think the fix should be at both lines:
>=20
> -         if ((outrate > 8000 && outrate < 30000) &&
> -             (outrate/inrate > 24 || inrate/outrate > 8)) {
> +         if ((outrate >=3D 8000 && outrate =3D< 30000) &&
> +             (outrate > 24 * inrate || inrate > 8 * outrate)) {
>=20
> Overall, I think we should fix this instead of adding an extra one, since=
 it is
> very likely saying the same thing.

Actually if outrate < 8kHz, there will be issue too.

Best regards
Wang shengjiu
