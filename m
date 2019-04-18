Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A3FC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 10:17:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA6B214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 10:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W8oTxVl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA6B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lFQj2lj5zDqG8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 20:17:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.62; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="W8oTxVl2"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50062.outbound.protection.outlook.com [40.107.5.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lFNj2SQzzDqDl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 20:15:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jixODIW8pw+6ggR18tH9r9emgy79lvO6n1FV43qKY9k=;
 b=W8oTxVl2KkA0I3MmgjE0Gd0S6IS0a0vSTZV+MSxzaZp6N+WUqbIZt2L9bZZ8Q0yhz/PYePFfDQ/C/O77PzRsVmLy3LnVUVbrJQ6yY6l4HUd7cc4i7e1xk8NUEno1GJ4wOVAy8sp8sRCj2BZFPKUjUX8uQAL4mDqp3nPFalWD2tw=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6558.eurprd04.prod.outlook.com (20.179.234.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 10:15:24 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 10:15:24 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Thread-Topic: [PATCH] ASoC: fsl_esai: Add pm runtime function
Thread-Index: AdT1ypcqA/llSPsbRmq55oyxQR4hRA==
Date: Thu, 18 Apr 2019 10:15:24 +0000
Message-ID: <VE1PR04MB6479871F3FC087282D23582DE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3000a2cf-4fa3-490f-bc99-08d6c3e6c5b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6558; 
x-ms-traffictypediagnostic: VE1PR04MB6558:
x-microsoft-antispam-prvs: <VE1PR04MB6558A8C51248156EE59C418DE3260@VE1PR04MB6558.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(39860400002)(366004)(136003)(376002)(199004)(189003)(53936002)(7696005)(7736002)(3846002)(6246003)(6116002)(476003)(305945005)(74316002)(2906002)(99286004)(54906003)(25786009)(71200400001)(110136005)(71190400001)(316002)(14454004)(229853002)(478600001)(86362001)(6506007)(97736004)(5660300002)(26005)(52536014)(186003)(102836004)(4326008)(6436002)(66066001)(9686003)(55016002)(33656002)(8676002)(81166006)(486006)(81156014)(68736007)(14444005)(256004)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6558;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lyAFyVJRNq0GJOHv4igPGNOMd+SSCde7OkwjLGrYIkVp45ZTmjMLvDAuPy7yFfsLODuuSZA0ii0ZPHhAbCOPHtOzyTzjeka8UWkNFhrO2HcJ2poDW2CcIcznC4NykKbCK5p9m5lwGt1aYOPLm0stY/vtDgYPD46G2DKdPjcOR6K1ANwG4D4tXCjAOs88aeuD1L0TnPmCGAHP6K1hCFhQP2SRtAIzjVUz/ZUu05/nI0QHy5K8k3/bYLF0/Bck+swfuV12O/QbkjcpSfVgi3+ifbe9u4zjLy2agd4BF2BvTP0E9aPbBJPIMSkg+olspLRQJl7a33L0/4E3Vw4i8sED/M90MJusVZJvMtG+1PxatJ2lu5DHeHcFIpIdJvsJS+34kalRlCn6+aIALWR4TtCjJsy3J7hTIjwJW7h7KywlfYc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3000a2cf-4fa3-490f-bc99-08d6c3e6c5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 10:15:24.5222 (UTC)
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
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

>=20
> On Thu, Apr 18, 2019 at 02:00:12AM -0700, Nicolin Chen wrote:
> > On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:
>=20
> > > In imx8 when systerm enter suspend state, the power of subsystem
> > > will be off, the clock enable state will be lost and register
> > > configuration
>=20
> > Just for curiosity, we had similar situation on imx6sx, so we added
> > suspend/resume with regcache. Why will the clock enable state be lost
> > too? Does CCM on imx8 (might not be called CCM
> > though) have any difference? What about clock rate settings?
>=20
> That sounds like a bug somewhere else - I'd expect that after resume the
> clocking would be restored to the state it was in before suspend.

There is limitation in our internal design. That is in imx8 the power of
subsystem will be disabled at suspend, include the clock state , clock rate=
.=20

I should not add it in comments,  please ignore them, I will change the
description.

This patch is to enable the pm runtime,  so I think it is better to move th=
e
clock operation to pm runtime,  and close the clock at suspend to reduce
the power.

Best regards
Wang shengjiu


