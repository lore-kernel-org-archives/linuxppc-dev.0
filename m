Return-Path: <SRS0=6+SE=TF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E031C04AAA
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 May 2019 03:30:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE77720675
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 May 2019 03:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LQbv4AHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE77720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44xWbT4l4PzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 May 2019 13:30:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.46; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="LQbv4AHV"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50046.outbound.protection.outlook.com [40.107.5.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44xWYx4rDWzDqLr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 May 2019 13:29:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+tljZtVu06rTmo4X+5PKfW+eDQuCuqojMnU0wQhHDM=;
 b=LQbv4AHV+khrX+EBIn8UG3sFRH4rEJIXRQ7NfVycLYetYT5AXX8xkAlG3SofX6YJtl4KdF82koZKg3zqCHC6mcLAuTRC5/QYsKycyThf7ZrbpisHs2OwwqPAvv0k+g3vuwvlRPr+CyrlS8iOEdgByB96t42b4JMlIf/fK9VfoJM=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6719.eurprd04.prod.outlook.com (20.179.235.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 03:29:00 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 03:29:00 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Thread-Topic: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Thread-Index: AdUC8g8sAZRwmKXuSBumrMDEaku+fQ==
Date: Sun, 5 May 2019 03:28:59 +0000
Message-ID: <VE1PR04MB64794DF2979F3AD350A9EB3DE3370@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b09723a-9f23-4f29-0baf-08d6d109d066
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6719; 
x-ms-traffictypediagnostic: VE1PR04MB6719:
x-microsoft-antispam-prvs: <VE1PR04MB6719997B0B4422596A7297ABE3370@VE1PR04MB6719.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(81156014)(81166006)(6436002)(52536014)(55016002)(8936002)(102836004)(6506007)(64756008)(76116006)(66446008)(33656002)(68736007)(66946007)(73956011)(25786009)(66476007)(66556008)(316002)(4326008)(229853002)(53936002)(6246003)(54906003)(110136005)(86362001)(476003)(6116002)(74316002)(486006)(3846002)(9686003)(66066001)(71190400001)(71200400001)(5660300002)(2906002)(256004)(99286004)(7736002)(305945005)(14454004)(26005)(186003)(7696005)(8676002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6719;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xYc9LyiNoBa7D9I4MSEASCMNe7ohTs8T/fS8mLetELoflYQLAIa7QA2Fm6962xBu3YtnKzp9qWPK4x94bzDA0i7DobEXgMjUhpAybjxY7OhpHsi9dMWtp1Q/Qkxharwm7XGZjpTTmTjw8fWTJdT5gyBtU7wGCf3TvowL2vEw6T8j0Jje30OsmvhfMM0w3IzGg70+19rlI1aXBGiSO+vcbEL1FXhTsD0EPq0g312GDzXw4/evMwzuJUeVCo+PTx4YLa0dqWPXG0QfllokgBCPsHOEmd5jmjisb6cArVWNhFt8URws/nFCEL+rE26TEiaYwUasTI84+uhE/E/jA+2gdaSp8ZjAyt86TyUqo+aea8S1apqr+GUy9Qxn6eE+iT4fG893qKXI3JP8UmxAU/Hh4xMKAo0BqPxXV3ldyjIdLlM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b09723a-9f23-4f29-0baf-08d6d109d066
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 03:28:59.9792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6719
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

> Hi Mark,
> On Fri, May 03, 2019 at 01:27:31PM +0900, Mark Brown wrote:
> > On Thu, May 02, 2019 at 09:13:58AM +0000, S.j. Wang wrote:
> >
> > > I am checking, but I don't know why this patch failed in your side.
> > > I Tried to apply this patch on for-5.1, for 5.2,  for-linus  and
> > > for-next, all are Successful.  The git is
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.
> >
> > > I can't reproduce your problem. Is there any my operation wrong?
> >
> > The error message I got was:
> >
> > Applying: ASoC: fsl_esai: Add pm runtime function
> > error: patch failed: sound/soc/fsl/fsl_esai.c:9
> > error: sound/soc/fsl/fsl_esai.c: patch does not apply Patch failed at
> > 0001 ASoC: fsl_esai: Add pm runtime function
> >
> > which is the header addition.  I can't spot any obvious issues
> > visually looking at the patch, only thing I can think is some kind of
> > whitespace damage somewhere.
>=20
> I downloaded this v4 from patchwork and resubmitted a v5 for a test.
> Would you please try to apply that one?
>=20
> If my v5 works vs. having merge conflict at v4, maybe something wrong wit=
h
> Git version of Shengjiu's? I compared my v5 and his
> v4 using vimdiff, there is no much difference of whitespace.
>=20
> Thanks
> Nicolin

We find that maybe it is caused by the Transfer-Encoding format.
We sent the patch by the  --transfer-encoding=3D8bit, but in the receiver s=
ide
it shows:

Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: base64

It may be caused by our company's mail server. We are checking...

Best regards
Wang shengjiu


