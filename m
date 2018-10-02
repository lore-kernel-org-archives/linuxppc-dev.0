Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D366BC004D2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 09:46:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3434A20878
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 09:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TswmtvV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3434A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PZ6Z0NJlzDrBx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 19:46:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TswmtvV/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.43; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=ioana.ciornei@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="TswmtvV/"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00043.outbound.protection.outlook.com [40.107.0.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PZ3Q07SBzF3DY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 19:43:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBPNFL4IRLp9ozKvdY7RxFmMv8N4is682pl71zVzACo=;
 b=TswmtvV/RrmaGD+6CwDWk4ZPmTEfdpV3NuFASjgwIB2IlVnOh2gJGt+OEY+n+jH9RJmQIP73muMxi9EE4DCn7UBigRifmPl8wyqmOgXiybgEOHdmjueebvmVO/Vg9VGGMK9Co6VUDX45FY99FiyNkW9CTAFHs7NNPrftOaiB8Zs=
Received: from HE1PR0401MB2363.eurprd04.prod.outlook.com (10.168.33.8) by
 HE1PR0401MB2508.eurprd04.prod.outlook.com (10.168.147.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Tue, 2 Oct 2018 09:43:36 +0000
Received: from HE1PR0401MB2363.eurprd04.prod.outlook.com
 ([fe80::10fa:841f:d25c:a565]) by HE1PR0401MB2363.eurprd04.prod.outlook.com
 ([fe80::10fa:841f:d25c:a565%10]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 09:43:36 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] driver core: device: add BUS_ATTR_WO macro
Thread-Topic: [PATCH] driver core: device: add BUS_ATTR_WO macro
Thread-Index: AQHUWZxbI1CVKGkJjk2ecx6zC3HfWaUK4nYAgADLczA=
Date: Tue, 2 Oct 2018 09:43:35 +0000
Message-ID: <HE1PR0401MB236354F325B7A56355068E35E0E80@HE1PR0401MB2363.eurprd04.prod.outlook.com>
References: <1538407972-9340-1-git-send-email-ioana.ciornei@nxp.com>
 <20181001210804.GA24332@kroah.com>
In-Reply-To: <20181001210804.GA24332@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0401MB2508;
 6:zHoZUcXcF8mkm8RQWZ7rKWbwV2bn8rUUvtOyDReYfog6thQG67c3n6y/gZJt1hkY6berU36TuQmk9BEssgD0xq3CLKy0sLZvyN7X8mXbWZHELlmWaAQLEDrlAgipIM6Lfd5U95cD7VS7b0TLvFon/383rYe9dCw060OE29KIEFSxy6BRNa9idmqZMN9baZUFbMMlZVXu8I7iW05pFKssML+Y7eRAFLgUtfwyYyESGNU/rl7JBDp+84zzsHh1dkmB6Z627VtbR0tkrlw1FJ8tAfo0cmaH2JvrEI3iJoHVZ635/eB3W2u5eigoJeJvQ4TzI0p9XBEXrDIazqvB/cOlWIogtDFWkR6NffeXvJhDGaPA0NgOj+HvBTXXaL9niFSz+tXM9Rxpe7pqRcL09zEmuZYPl+NvAHEi7KJZRC1ybo2ma3Etywd7ykLhufOKi8eUveYiBqajeYS+W9mOFsCf7Q==;
 5:xa1U1OZQOxUsG2o565Et2ijNyHaOndo955V2yci39DeZGBJpDdcSSonEcNzPJsjIkI5uxJBs8FGCcq9dAQezk2l7P8D/DCNvJG9w3njqjgxsCjCWPah1RpVijn6+4xrWVvlUXjlVoAejKUpLjs+SP9HWBTeiqp1BsWJuYRzIZdI=;
 7:KjxrDnqymfpUikP91wGrYLb1nYsTM4axiOKWPet9RtOcjNX7B75Y1OXWBtuKUCVEJxPPA81L+sRI6977CWdY9BL5p9O/jlWbKQ1caMdFSd3X0/ISTgDqDt6nLyjlON47CuD+DC4HpAoQhznvypApxSDRnZlcYjQ27D28/MZCbe1l4Wiz1Y+vlZhdqQo+MYTBV2rcLyEZ0kLIQ1ON/8pNbiwA0PGF1FUfoznF51LBipWf+ACoi6WFLKRuP8I1m5QQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 51441aed-eaed-4c46-9d3b-08d6284b864d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0401MB2508; 
x-ms-traffictypediagnostic: HE1PR0401MB2508:
x-microsoft-antispam-prvs: <HE1PR0401MB2508A888110132F1E03C0A89E0E80@HE1PR0401MB2508.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);
 SRVR:HE1PR0401MB2508; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0401MB2508; 
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(86362001)(2900100001)(102836004)(5250100002)(316002)(186003)(26005)(105586002)(106356001)(6506007)(99286004)(478600001)(33656002)(76176011)(14454004)(7696005)(7736002)(966005)(39060400002)(7416002)(74316002)(6246003)(446003)(11346002)(54906003)(305945005)(68736007)(44832011)(486006)(25786009)(476003)(97736004)(53936002)(66066001)(81156014)(8936002)(4326008)(229853002)(5660300001)(6116002)(3846002)(9686003)(6306002)(6436002)(55016002)(256004)(8676002)(2906002)(71200400001)(81166006)(6916009)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0401MB2508;
 H:HE1PR0401MB2363.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5FoqNjsn7vBGoeNb3DQlVHeW3V05jKX7J/rhE+bbkeu0NUVElk94KC4I9CV4Y0VjPI4OyeyobFNQyAkH4hwBqfoqZuxXJ5rubvp9bYJvESsCbb2mdFt/2PUogSS2AyS0zyDuDm1s0/LIA5SteHbbtJJrsBp+KUZbjubXCyqARH+xfIrrq85ND70P+pvO6kdo0wnVViPLlmrip1PYDkJrfUkhn7CiUMST+FGt8iSJNL0ltAqtnGfIe7zhu7RDQcYhui3/Z9ywoJ0NbWY8klM6q6KOyrmlEyFLsOO0txPJwOwklcJOHsvIjRdeXjQYlHawk0dq1thi9He7SlIP51JokYh90KoufcsH4oOWHj64sL0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51441aed-eaed-4c46-9d3b-08d6284b864d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 09:43:35.7739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2508
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
Cc: "elder@kernel.org" <elder@kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "sage@redhat.com" <sage@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "idryomov@gmail.com" <idryomov@gmail.com>, "jth@kernel.org" <jth@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> > Add BUS_ATTR_WO macro to make it easier to add attributes without
> > auditing the mode settings. Also, use the newly added macro where
> > appropriate.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  arch/powerpc/platforms/pseries/ibmebus.c | 12 ++++----
> >  drivers/block/rbd.c                      | 48 ++++++++++++++++--------=
--------
> >  drivers/scsi/fcoe/fcoe_sysfs.c           |  4 +--
> >  drivers/scsi/fcoe/fcoe_transport.c       | 10 +++----
> >  include/linux/device.h                   |  2 ++
> >  include/scsi/libfcoe.h                   |  8 +++---
> >  6 files changed, 43 insertions(+), 41 deletions(-)
>=20
> Nice!  This duplicates a lot of the work I did back in July but have not =
pushed out
> very far due to the other things that ended up happening around that time=
:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/l=
og/?h=3Dbus_cleanup=20
>=20
> As the patch series seen at that link shows, you can do this in more plac=
es than
> just what you did here.
>=20
> Either way, you should break this up into the individual patches, like I =
did or you
> can take my patches if you want.  Getting the BUS_ATTR_WO() macro added i=
s
> good to do now, and then you can go and hit up all of the different subsy=
stems
> that should be converted over to it.

I can of course split my patch into individual ones and resubmit them, but =
as you already have the entire patch set ready, I feel like we can just pus=
h those. I looked through your changes and it seems like you covered all th=
e subsystems. Please let me know if there is something else I should do.

My intention here was to first add the _WO attribute so that afterwards I c=
an add a new bus attribute in the fsl-mc bus.

Ioana

>=20
> thanks,
>=20
> greg k-h
