Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E2C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 10:53:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997D5206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 10:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jc14yonO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997D5206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r9r91PCFzDqjH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 20:52:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.54; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="jc14yonO"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00054.outbound.protection.outlook.com [40.107.0.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r9pP1grHzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 20:51:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kpa4DZFjHApjeOq5Uyop56mHymAHoyJKTKyHdALSlY=;
 b=jc14yonO59sM9GFWZ4L9qrWifLkg2y4wyZOigc36ADpXsmpqQSUAI41EKqDqOI7SsrV+DqhFzZKCNuFC7EXIQwOo7M+u5TzrWL16NFKzpwIKpken8cB4zUw0iWzLKLSQFyJTOcCUu2sZe3GOOQMmpZq3ygvDDB+WyVdNWELIM6M=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6608.eurprd04.prod.outlook.com (20.179.235.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 26 Apr 2019 10:51:16 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 10:51:16 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Thread-Topic: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Thread-Index: AdT8HbMvSOaQ4ZXUSdmDjif4uXLhnQ==
Date: Fri, 26 Apr 2019 10:51:15 +0000
Message-ID: <VE1PR04MB64797233B0BFE833550094C3E33E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95928519-81a2-4eee-2700-08d6ca351b5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6608; 
x-ms-traffictypediagnostic: VE1PR04MB6608:
x-microsoft-antispam-prvs: <VE1PR04MB660838539FCF74606343F858E33E0@VE1PR04MB6608.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(6506007)(7696005)(9686003)(186003)(5660300002)(66066001)(4744005)(97736004)(71200400001)(102836004)(71190400001)(6916009)(53936002)(316002)(66556008)(99286004)(64756008)(66946007)(81156014)(76116006)(14454004)(26005)(6116002)(66446008)(3846002)(486006)(81166006)(476003)(66476007)(73956011)(7736002)(478600001)(8936002)(6436002)(14444005)(4326008)(68736007)(74316002)(54906003)(6246003)(86362001)(55016002)(2906002)(33656002)(25786009)(229853002)(52536014)(8676002)(256004)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6608;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jJQ+nwNUQTF9eLCHITHHfWob7Z+Y22VTqM2Wp9DjqUQKpJ36VYzOo5PoSuajdsRFC8dSZ6JO4Kw7sci1vvLpR03Q0e35ysP3unh/ip2RL0wXq+D2ByR5kmymNib3+mwEe2KbK7CssdTNE93jFkCvY6w9/heJNOOmuRn3idc8M8PTkAflr6AaNqhGHQCUchKwOgh+GaynrF5x1Pb912DEGd7H2J9bfrdXf5iTga74KEN9LXduTNE8BTV7zIKQgM6eHkdo52JMJoKcPl/0O1ai0c06x+F5L+iVycZKajGQR+sGah2X/TS4e5NV583SjC0ljwtt6KYDutZLVijqbeVKBAWc72xmdxPyyn1wn3RFaW7SGRYFyhbLubiAtpgrYLPZQ1jJwKOi3prAS7FvtcTeL46kt1f19SHWl4XH8dRhFbY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95928519-81a2-4eee-2700-08d6ca351b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 10:51:15.9945 (UTC)
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
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mark

>=20
> On Mon, Apr 22, 2019 at 02:31:55AM +0000, S.j. Wang wrote:
> > Add pm runtime support and move clock handling there.
> > Close the clocks at suspend to reduce the power consumption.
> >
> > fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> > fsl_esai_resume is replaced by pm_runtime_force_resume.
>=20
> This doesn't apply against current code, please check and resend.

Which branch are you using?  I tried for-next and for-linus, both
Are successful applied.

Best regards
Wang shengjiu
