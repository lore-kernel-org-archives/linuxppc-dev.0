Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BD7C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 21:34:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5252084C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 21:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/+1KKNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5252084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bx370CpCzDr4h
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 08:34:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.71; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=leoyang.li@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="K/+1KKNm"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70071.outbound.protection.outlook.com [40.107.7.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bx1D6xBDzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 08:33:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSbj7h4nkJbVGydsaUAJL8p9rD32TqGoPj0E/sidZ18=;
 b=K/+1KKNmTvP+SxCdp9JtWp8P33LwbnQ/pxxjWoe70i7TqZ0MlVL0MEvClhrUCThNiBJlP/T3Y5fVlFvxke8E4CuN/6SeVHc0QFuvqbdiorZT4UrCYjKtMvSq992SPICaK6Vwc/EvTPntzX//UeYlI8zoY1mXR9Mql13t1abECM4=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB4968.eurprd04.prod.outlook.com (20.177.33.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 21:32:54 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::b800:e18:108b:416d]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::b800:e18:108b:416d%4]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 21:32:54 +0000
From: Leo Li <leoyang.li@nxp.com>
To: Nicholas Mc Guire <der.herr@hofr.at>
Subject: RE: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Thread-Topic: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Thread-Index: AQHUjgbZUE8xlzjs0UWEhi0bkgMBrqWKIGYAgABcJQCAHxZfi4ABOyQw
Date: Fri, 11 Jan 2019 21:32:53 +0000
Message-ID: <AM6PR04MB5863821216050C13EBED68AA8F850@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
 <20181222075944.GA26155@osadl.at>
 <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
 <20190111024334.GA12140@osadl.at>
In-Reply-To: <20190111024334.GA12140@osadl.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4968;
 6:dxTleWQqCJEDQycJ/CmOqbYq5a08FuJgaCyloMHe1OJzfF9iZb6CkvMDU/gd/OgCWB6ov2YNq2Y9uJgQojoFYRa2dc/1Sa1tl/+enKVe45AuXeZ64U2QsA1LB4H9Y9MmVH8ZeAPHeqv4KQYmFKEHoyoV9pe42QDs1AhdR75fZyRdYeN9XNM1tpVbG1i0GSomrx5Lnv32FWBWSyGB5dMLQhVpt0SNqUrA/VIBZhePTka82DikrEe6/3ZgRZ/AVdmVQnjSOquLbKnp34Z9VQsAu43qNHSrBq2yIKbQb0fwLBMYjXmkGceCUi/9824Th4BehIyfw9rOwRgCoEElxnHx1z32L8Auo1JDRTx53eHOdsxZhU2+xFSe+j4cNsCCATWgTyfX2bGsi/lnAgZd7CE2MBUj8eQzcc9EyLr+zRz1rme81K9nI6WoskNQSENzb3ckodQwtcroOs64dzCZH7cgUA==;
 5:fYh2aBHJtPJs702gyO1RRNulPvOiPd/yo6zJPSf7Te2Kk1ZQRWN3rG9An8v12R4IS4ZsvDgMQ0iUJgtHp8YdUGKp3lmdqt9NaAbrCA8exCiPJ+vMUIaCzR6DYwwTPCeCGhDsEldsdZOVBnywyjvIHyzEPMM33642qZy1ycRL29k1GV9TrkQZXOxXzIKIAhcIcDc7KEyLLB1K5OM3CGuajA==;
 7:IUa7zTWLdNvQ0bgmzJzqSxJzYjcnHQcRUJWLmSlGyd41FlXoFalGKUcyTfd7F9oz8b06ODcMiRkm56rIaKc5D++eFjZLYhcz/BpGrRX4Hz/35NHsnW+oNdEBGX8uUTjMp3lFaSrOtmantIpXv+zZNQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9518c160-c1c0-4c79-3380-08d6780c588d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4968; 
x-ms-traffictypediagnostic: AM6PR04MB4968:
x-microsoft-antispam-prvs: <AM6PR04MB4968AA4BA850233A49BA8AC88F850@AM6PR04MB4968.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(366004)(13464003)(189003)(199004)(51444003)(51914003)(26005)(476003)(186003)(11346002)(14454004)(102836004)(6916009)(575784001)(446003)(8936002)(86362001)(5660300001)(74316002)(93886005)(256004)(6116002)(6506007)(53546011)(14444005)(76176011)(66066001)(3846002)(316002)(478600001)(966005)(45080400002)(71190400001)(71200400001)(54906003)(7696005)(486006)(97736004)(99286004)(2906002)(33656002)(6436002)(229853002)(25786009)(81156014)(6246003)(9686003)(55016002)(305945005)(6306002)(81166006)(7736002)(53936002)(8676002)(105586002)(106356001)(68736007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4968;
 H:AM6PR04MB5863.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VrU3keiidlUC4fXmuE9JvN7bP/GeF03Wprrw6ARyOPwUoGPhTjNyIcpqB+X80A5/Qg3azq8FTCHoURZHgPbn2X/pCaLd4foZzePZRoNYnWdtNLArh3XH5rbDYW6D0m5/H6N7/JbMh6shbUuLJmEwC4Au1PdaZgZEX8MQJB7+9LUOUIfeEaRwZGOtBIjBtm2mvEuDvKh6RohIfGXqf6UpV1dktnQl29M5/LT8qjulFlQ/DDi6lfAgeb6cavPwZP90U/K9Au8MzOzu0pHKdV5cXFp3V6b+FFAqJouYxwrZDNj0o9VqqW4Z5x9bcSXZlYydl4atseOpnikn4ojGQFpIYiXKo6/McBFsgogjH4THAvBU+b6MSdZAixuf4XkIywu1CLY0IE1VEHddLNIMFo3B77+YBGo+gBO5dx8d81NZIu0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9518c160-c1c0-4c79-3380-08d6780c588d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 21:32:53.9622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4968
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
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Nicholas Mc Guire <hofrat@osadl.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> -----Original Message-----
> From: Nicholas Mc Guire <der.herr@hofr.at>
> Sent: Thursday, January 10, 2019 8:44 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Scott Wood <oss@buserror.net>; linuxppc-dev <linuxppc-
> dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel@lists.infradead.org>; Nicholas Mc Guire <hofrat@osadl.org>
> Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
>=20
> On Thu, Jan 10, 2019 at 01:43:01PM -0600, Li Yang wrote:
> > On Sat, Dec 22, 2018 at 2:02 AM Nicholas Mc Guire <der.herr@hofr.at>
> wrote:
> > >
> > > On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> > > > On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > > > > devm_kstrdup() may return NULL if internal allocation failed,
> > > > > but as  machine  is from the device tree, and thus RO,
> > > > > devm_kstrdup_const() can be used here, which will only copy the
> reference.
> > > >
> > > > Is it really going to only copy the reference?  That would require
> > > > that
> > > > is_kernel_rodata(machine) be true, which it shouldn't be since
> > > > it's not part of the kernel image.
> > > >
> > > I had tried to figure out what is RO and what not but was not able
> > > to determine that - from the discussion it seemed that the
> > > assumption of RO is correct though I did not ask if it would satisfy
> > > is_kernel_rodata() so that explains the incorrect assertion.
> > > see
> > >
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl
> > >
> kml.org%2Flkml%2F2018%2F12%2F6%2F42&amp;data=3D02%7C01%7Cleoyang.l
> i%40
> > >
> nxp.com%7Cf72d70a65d1b47f6883808d6776e9d58%7C686ea1d3bc2b4c6fa92c
> d99
> > >
> c5c301635%7C0%7C1%7C636827714307963102&amp;sdata=3DxnaO0Y7q%2Byad
> Yv8sF
> > > VPFtkfllgnwpEIkkTIgw0K%2Fovg%3D&amp;reserved=3D0
> > > So then the only option is to check the return and cleanup on
> > > allocation failure as the orriginal patch proposed.
> >
> > Thanks for the good discussion. I will drop the previous patch. But
> > would it also be good to just have "soc_dev_attr.machine =3D machine"
> > directly?
> >
> I think that the intent is to switch to managed devm API so that the clea=
nup is
> handled properly currently you would get "machine" from
> of_property_read_string_index
>   -> of_property_read_string_helper
>    -> of_find_property
> which does not do any allocation - so there would actually not be anythin=
g to
> cleanup here - don=B4t see why your solution would not be suitable given =
the
> current API. the only advantage of the devm_kstrdup() is that underlying
> APIs internal changes would have no effect.

Thanks.  I will sent out a new version.

Regards,
Leo
