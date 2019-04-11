Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CBC282CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:11:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A294217F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EwsuVBsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A294217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fmJb0fJYzDqFZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:11:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.73; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="EwsuVBsX"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70073.outbound.protection.outlook.com [40.107.7.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fmGk04lxzDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:09:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2QZvMtZZdJZSMXeBbT8zVwJW8rDu7JucbA/es/lqgo=;
 b=EwsuVBsXsaRq5uvJkN/44rzhu0U/SGjuFlYuslmy6PFnyrfb5CppQjbLSOzCD6u5X+XtR8wXzmvOMnZYwRfW+4fr8x2UakRjtW5Abj79h/duLN7Wm0QmL8s0DvJRlHbBckztCM8nSEuc0HWlUhiXH0Ok8AmK0Jvw2c5kNe0fD9U=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Thu, 11 Apr 2019 03:09:41 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 03:09:41 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [EXT] Re: [PATCH V2] ASoC: fsl_esai: replace fall-through with
 break
Thread-Topic: [EXT] Re: [PATCH V2] ASoC: fsl_esai: replace fall-through with
 break
Thread-Index: AQHU70cTwow3EQ3buU2LP9490KzdXqY1QmmAgAECoeA=
Date: Thu, 11 Apr 2019 03:09:41 +0000
Message-ID: <VE1PR04MB6479BBD94E90632DB3374555E32F0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
 <20190410112813.GL6106@sirena.org.uk>
In-Reply-To: <20190410112813.GL6106@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17adda8c-61c8-4355-2506-08d6be2b2415
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6638; 
x-ms-traffictypediagnostic: VE1PR04MB6638:
x-microsoft-antispam-prvs: <VE1PR04MB6638E79611C3BF66C6CE1520E32F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(346002)(136003)(396003)(39860400002)(189003)(199004)(14444005)(486006)(4744005)(3846002)(54906003)(97736004)(305945005)(446003)(2906002)(81156014)(6116002)(71190400001)(5660300002)(55016002)(256004)(8936002)(476003)(8676002)(71200400001)(14454004)(66066001)(81166006)(7736002)(11346002)(6246003)(508600001)(25786009)(6506007)(86362001)(53936002)(26005)(68736007)(99286004)(229853002)(6916009)(33656002)(76176011)(52536014)(102836004)(186003)(9686003)(316002)(74316002)(7696005)(106356001)(6436002)(4326008)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6638;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9j0F+cPYb3aTlvMEc/CROaP+e4TEZ63C4iHR+EzCBG8dBS1VI2vI1uQAE0GgvqM+KlFYh4PE41vsCz+WziFWI8sSgQb0n/ONYF2lzdFdEPWkoZnO2cdxSFFlhYepG0fbD2DIGJXqyhzZIm78qdPDicB8fTYuor0NMFhL28LiLZOxaQT0czVMkX2yjRX9jcsIflIhQAEac8Vci28CVZdsvTcluvn/ZHnqsmhLOOnVxoRS8DAo5ZLbRPV1gSICz+3+ka90PuFXXcZplhcd2iCT51atK2OcG4VZtbHtGi1PQWSkfInKOVLBq16Xvkq92s9pthnNNLLDT4ROsajKRF7WcY5N2W0l/28L5+fl5+2WrJXPTwgbkkyqPDvtV4rIkveSvnyfeKGK9Ofr5RbLaG8wA+WOW+8eMWsUoeXHqaQDb7A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17adda8c-61c8-4355-2506-08d6be2b2415
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 03:09:41.5959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6638
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
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mark

>=20
> On Wed, Apr 10, 2019 at 02:42:45AM +0000, S.j. Wang wrote:
> > case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent
> of
> > each other, so replace fall-through with break.
>=20
> This doesn't apply against current code, please check and resend.

Thanks, have sent v4 for update subject according to Gustavo's comments.

[PATCH V4] ASoC: fsl_esai: Fix missing break in switch statement

Best regards
Wang shengjiu
