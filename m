Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91129C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 10:22:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C939214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 10:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NQArxpMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C939214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lFY06mY2zDqHV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 20:22:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.59; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="NQArxpMu"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lFWN48BzzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 20:21:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvrZKE6oqhTtG7dz6vO8lh782qKBDVIXZzlmyB4ujA8=;
 b=NQArxpMuYMRIM1JjHEvw+zPxj4i9UOZLYTngypUpGaXraSOo4qs8mVc+ABTA81DGRygNyBX57AIYUiX78S2+gzf2pRLSgFZDGMRUwMoMUi1OfY/nbO7VB5HOdt4tqXg+K82m4Md73m//d5NFPxMmwUdMDHbQ8yCvpZpm2SoNDog=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6558.eurprd04.prod.outlook.com (20.179.234.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 10:21:11 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 10:21:11 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Thread-Topic: [PATCH] ASoC: fsl_esai: Add pm runtime function
Thread-Index: AdT1z8in+mpZLskHQHWuJHAthNAolw==
Date: Thu, 18 Apr 2019 10:21:11 +0000
Message-ID: <VE1PR04MB64798FB86DFEBD85E1784DF2E3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cde20c3-fb2b-4eb9-a447-08d6c3e7947f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6558; 
x-ms-traffictypediagnostic: VE1PR04MB6558:
x-microsoft-antispam-prvs: <VE1PR04MB655830039B36F63A69F04608E3260@VE1PR04MB6558.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(189003)(199004)(186003)(66066001)(102836004)(6436002)(4326008)(5660300002)(97736004)(6506007)(52536014)(26005)(68736007)(81156014)(8936002)(256004)(14444005)(55016002)(33656002)(9686003)(486006)(81166006)(8676002)(1411001)(476003)(2906002)(305945005)(74316002)(7696005)(53936002)(6116002)(3846002)(7736002)(6916009)(6246003)(14454004)(229853002)(316002)(86362001)(478600001)(99286004)(54906003)(71200400001)(71190400001)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6558;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VPMKpp/waRZjgsbiUpm3v8NVZl8fp6TUE2B2995UFy35scXPgXEAFGqM4gD+rPfSc2rLQ0j6Mt7ZWzNFiLfr/mv1f3n1RcfYv+R1HTL+eaHFk4/IYtHEBTmNC/Cv/5Lo5P2ASYJmDUHo1Ec8+X9/IK4lOt05GSkP63mJ+k07JTLQKYVNCHmnCbd3f0qDH8iJijayp1lUqoiEX9Q5WpX0DBJBV0VxZlNmkW9c0IrgAIRvteqCWUFX+7homsIUQs2m0/3Rfisva1nmUJEpFn7q5zpe1IE4U1CQfGjS8B4Gps4OrP5sN9XI4rSncQqV1aCSUc6ph03aMDMSM11BS2X+hz9UPecwTvl75ci5QWhiDMAozGKHfaeZxVtgHVK8cKWLM+op7unBlp4Q2SOW4ebORirT0oJM+2MJEVLw4XzNWyY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cde20c3-fb2b-4eb9-a447-08d6c3e7947f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 10:21:11.5218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6558
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
> On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:
> > In imx8 when systerm enter suspend state, the power of subsystem will
> > be off, the clock enable state will be lost and register configuration
>=20
> Just for curiosity, we had similar situation on imx6sx, so we added
> suspend/resume with regcache. Why will the clock enable state be lost too=
?
> Does CCM on imx8 (might not be called CCM
> though) have any difference? What about clock rate settings?
>=20
> > will be lost. So the driver need to enter runtime suspend state in
> > suspend.
>=20
> > With this implementation the suspend function almost same as runtime
> > suspend function, so remove the suspend function, just use
> > pm_runtime_force_suspend instead, and same for the resume function.
> >
> > And also need to move clock enablement to runtime resume and clock
> > disablement to runtime suspend.
>=20
>=20
> > -static int fsl_esai_suspend(struct device *dev)
> > -     regcache_cache_only(esai->regmap, true);
> > -     regcache_mark_dirty(esai->regmap);
>=20
> > +static int fsl_esai_runtime_resume(struct device *dev)
> >       regcache_cache_only(esai->regmap, false);
> > +     regcache_mark_dirty(esai->regmap);
>=20
> Why move the regcache_mark_dirty from suspend to resume?
> (I am not saying it's wrong but wondering if this is the  preferable way.=
)

Seems I should not do this change.
I will remain regcache_mark_dirty(esai->regmap); at its old place.

Best regards
Wang shengjiu=20


