Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3077FC282DC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 02:38:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662B9217F9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 02:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="COSZw5im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662B9217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l3FT64gbzDqPG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 12:38:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.14.44; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="COSZw5im"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140044.outbound.protection.outlook.com [40.107.14.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l3Ct2Hx6zDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 12:37:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHxfu+2lLbwHeIlygkUdc+reAiscBK3q8wKz6XkrjdU=;
 b=COSZw5im5xuMU3nlyDRChCALWTT9v2niMcU+O7YIpXGr5kfhxP/CbJQCYLHTNzCyeRUzgUpmS862MTbc/o2ejE9TQoGWdvpNc4oZMZoLoSC32LPV3shgVes4/7QGQpfKMz21W3TwWjxfy6zWNTmS8bmYdlBkY2i1mw61y264ODQ=
Received: from AM6PR04MB6470.eurprd04.prod.outlook.com (20.179.245.79) by
 AM6PR04MB6037.eurprd04.prod.outlook.com (20.179.4.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 02:37:03 +0000
Received: from AM6PR04MB6470.eurprd04.prod.outlook.com
 ([fe80::bc8d:21be:2cd6:f549]) by AM6PR04MB6470.eurprd04.prod.outlook.com
 ([fe80::bc8d:21be:2cd6:f549%3]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 02:37:03 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Topic: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AdT1jzb7LgzlzFMpSj6UhpjGM3i6rQ==
Date: Thu, 18 Apr 2019 02:37:03 +0000
Message-ID: <AM6PR04MB647093DB49BB13E09B0F181DE3260@AM6PR04MB6470.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0d8b31d-f7de-4b9c-fa44-08d6c3a6bdd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AM6PR04MB6037; 
x-ms-traffictypediagnostic: AM6PR04MB6037:
x-microsoft-antispam-prvs: <AM6PR04MB60371E6C29F6A7CEC7B279B3E3260@AM6PR04MB6037.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(39850400004)(366004)(376002)(136003)(189003)(199004)(81166006)(81156014)(6246003)(66066001)(8936002)(8676002)(4326008)(6436002)(71200400001)(71190400001)(1411001)(229853002)(2906002)(6916009)(486006)(97736004)(53936002)(316002)(55016002)(476003)(86362001)(9686003)(25786009)(14454004)(6116002)(3846002)(54906003)(7736002)(478600001)(33656002)(305945005)(99286004)(74316002)(68736007)(7696005)(52536014)(256004)(186003)(26005)(6506007)(102836004)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB6037;
 H:AM6PR04MB6470.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oeo3SeJDYz4NMUUIGW9ZTeSgJRgqeTFk4Izbbgw0RHH1YkGvsFpG+nO31uXf0NzAPeui5jfHh3lZsUmswoodwW/TsDFwlXCXpNm2V7lIKNkmIerpnGBOTf4aoYhH/3ZvsNGXrCcUWWbBg8XATLJuF2wmv0Jy7K37NcsPhO+jJoOjafF+Uj8OaVVWyikxiNOItNKt06bdqhoczw4cIMiZeyQID/hzKy+rY4Y3zi+KAxPtqW1fYqWyM/YMATJ/RnSYy+sI/2TUq2zFsovPTf7bm8TFnNXd28wwE8zX9WcRDDDVNV6VG4yyG2NweYI4npXbTn2q71y5DViC7uZTMEJj4mP06bxk0vodEHK/R3X/NZi6A3uicj1qF3EwOwP5Jadin7uZy6aIu8BwUGzelOoU2kvkCYoDJ6+vN20z86TDodI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d8b31d-f7de-4b9c-fa44-08d6c3a6bdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 02:37:03.5274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6037
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
> Hi Shengjiu,
>=20
> This looks better. Just a couple of more small comments inline.
>=20
> On Wed, Apr 17, 2019 at 09:06:18AM +0000, S.j. Wang wrote:
>=20
> > +static int fsl_asrc_sel_proc(int inrate, int outrate, int *pre_proc,
> > +                          int *post_proc)
>=20
> Just a nit: it looks better by grouping them two-two.
>=20
> static int fsl_asrc_sel_proc(int inrate, int outrate,
>                              int *pre_proc, int *post_proc)
>=20
> > +     /* Condition for selection of post-processing */
> > +     post_proc_cond2 =3D (inrate * 15 > outrate * 16 && outrate < 5600=
0) ||
> > +             (inrate > 56000 && outrate < 56000);
>=20
> Could align the indentation:
>         post_proc_cond2 =3D (inrate * 15 > outrate * 16 && outrate < 5600=
0) ||
>                           (inrate > 56000 && outrate < 56000);
>=20
> Here:
> > +     /* Does not support cases: Tsout > 8.125 * Tsin */
> > +     if (inrate * 8 > 65 * outrate)
> > +             return -EINVAL;
> And here:
> > +     ret =3D fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc)=
;
> > +     if (ret) {
> > +             pair_err("No supported pre-processing options\n");
> > +             return ret;
> > +     }
>=20
> Instead of a general message, I was thinking of a more specific one by
> telling users that the ratio between the two rates isn't supported --
> something similar to what I suggested previously:
>=20
>         pair_err("Does not support %d (input) > 8.125 * %d (output)\n",
>                  outrate, inrate);
>=20
In fsl_asrc_sel_proc,  we can't call the pair_err for there is no
struct fsl_asrc_pair *pair in the argument. Do you think we need to
add this argument?

> Thanks
> Nicolin
