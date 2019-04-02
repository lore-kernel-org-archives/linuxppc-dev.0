Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD4C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 15:23:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137F720830
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 15:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aYXJeLF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137F720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YXyr4GXqzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 02:23:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YXwt5cdvzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 02:21:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="aYXJeLF0"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44YXwt22LGz8tQ0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 02:21:18 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44YXwt1cSTz9sTb; Wed,  3 Apr 2019 02:21:18 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.65; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="aYXJeLF0"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10065.outbound.protection.outlook.com [40.107.1.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44YXws4kjxz9sTY
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 02:21:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D6InYnTytlnQHlPBcTR3k/aa+l9DkgSTwK1dCKlPlk=;
 b=aYXJeLF0GquCAnjdchpUvAUPmB1yE9uy5fOyp70+tkijiA0VtK5RTzfeoA2BwL0Cu1KLHstb0lNWrS+pEGaofCFP7TMeqKqEInZ9LwQpJrLTPhAEJFVEtfDH4jQbSxvUTxiVbDkGKNCQFBMQggkkyoJJSrHEYXJiArO1rGIS5CQ=
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com (10.168.64.146) by
 VI1PR0401MB2253.eurprd04.prod.outlook.com (10.169.133.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Tue, 2 Apr 2019 15:21:09 +0000
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::f0ff:e4cf:6d0d:ea88]) by VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::f0ff:e4cf:6d0d:ea88%3]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 15:21:09 +0000
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable v4.14 00/32] powerpc spectre backports for 4.14
Thread-Topic: [PATCH stable v4.14 00/32] powerpc spectre backports for 4.14
Thread-Index: AQHU5iJE+XDajggcgUe1OnYfZIGbfg==
Date: Tue, 2 Apr 2019 15:21:09 +0000
Message-ID: <VI1PR0401MB246396C22088623F2971A0DCFF560@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
 <20190329145116.GA23019@kroah.com> <20190329150921.GA1002@kroah.com>
 <87v9zzl68u.fsf@concordia.ellerman.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=diana.craciun@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fe1bd17-2ece-4be8-5268-08d6b77ed596
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR0401MB2253; 
x-ms-traffictypediagnostic: VI1PR0401MB2253:
x-microsoft-antispam-prvs: <VI1PR0401MB2253BE06DD8295A2FDF5AD3BFF560@VI1PR0401MB2253.eurprd04.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(54524002)(9686003)(2906002)(229853002)(186003)(305945005)(6116002)(6436002)(99286004)(8936002)(105586002)(478600001)(93886005)(66066001)(33656002)(55016002)(4326008)(316002)(52536014)(486006)(7736002)(3846002)(25786009)(446003)(86362001)(14454004)(5660300002)(106356001)(74316002)(54906003)(97736004)(26005)(81166006)(8676002)(476003)(81156014)(68736007)(6506007)(14444005)(7696005)(4744005)(6246003)(102836004)(53546011)(71200400001)(256004)(71190400001)(76176011)(53936002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2253;
 H:VI1PR0401MB2463.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X6Kg9DPgMf2+Db2u/pDSLrMJUtEPgOHvwmTzSUgC0KwkaYUKWKDkoAk6utV66Rmf1cFPD6/xdYevU4bCea6vR5ZvwhlDopkzxfzspiQbk46jrsM7ggCXtZ8gzHYVt6nhFJwEQpS3AQYrE146Kuv8ryYj9DotB1Sqk8agnxRcmn2YB/4g30n4TodF16rH3GuAUCoGnpHpg9J2gGmq43E9QPEBS8RM+T8Wzvpo8FDqX4q0y0Vb2CBwzqekyHFz1lUQrJJzSRLO4ef0ZNNK/6uA2L6uA/iYZVuzl91cZ69nxWLBTrA2jE3Y+oNEZw8Cp3p6owdyyWuuWqTl5xXzHOnetryeW/R/ukcBsKUs47GD4MbuN49lq+vLOiDZvcaoAmv4iY64Nl2vYS/qfw/5CAywgz00w2kIsTGixfYh842ciYw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe1bd17-2ece-4be8-5268-08d6b77ed596
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 15:21:09.5863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2253
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
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "msuchanek@suse.de" <msuchanek@suse.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/31/2019 12:53 PM, Michael Ellerman wrote:=0A=
> Greg KH <gregkh@linuxfoundation.org> writes:=0A=
>> On Fri, Mar 29, 2019 at 03:51:16PM +0100, Greg KH wrote:=0A=
>>> On Fri, Mar 29, 2019 at 10:25:48PM +1100, Michael Ellerman wrote:=0A=
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1 Hi Greg, Please queue=0A=
>>>> up these powerpc patches for 4.14 if you have no objections. =0A=
>>> Some of these also need to go to 4.19, right? Want me to add them=0A=
>>> there, or are you going to provide a backported series? =0A=
> Yes some of them do, but I wasn't sure if they'd go cleanly.=0A=
>> Nevermind, I've queued up the missing ones to 4.19.y, and one missing=0A=
>> one to 5.0.y. If I've missed anything, please let me know. =0A=
> Thanks. I'll check everything's working as expected.=0A=
=0A=
I have validated on NXP PowerPC and worked as expected on both kernel=0A=
4.14 and kernel 4.19.=0A=
=0A=
Thanks,=0A=
Diana=0A=
=0A=
