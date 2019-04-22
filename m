Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE2FC10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 15:29:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE942064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 15:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="onZwJjdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE942064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nr9G0yvfzDqPn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 01:29:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nr7V17kZzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 01:28:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="onZwJjdB"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44nr7S17TYz8tGc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 01:28:04 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44nr7S0PLCz9s3q; Tue, 23 Apr 2019 01:28:04 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.81; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="onZwJjdB"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44nr7R3cm9z9s5c
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Apr 2019 01:28:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkeucdniBHtARbNDaFXSzNsbvnL7m1aRkyuDrdMvQtQ=;
 b=onZwJjdBObqkJFkWy5EBDsAeaVwn0+l+sswTP5Nnkhz1mTX1LOMBs4LKWEPSh7DBtvq4EnNUJOX9sKqNUgsFWdIVpRosD4vg/cG/6qpdDbJx6Jn54FoydVxGM+2oMugE/EAuHKNgrKi9s60XCBuIYlIXMp1T4yxGv4tQuci/384=
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com (10.168.64.146) by
 VI1PR0401MB2511.eurprd04.prod.outlook.com (10.168.65.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 15:27:56 +0000
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::2cba:efb0:12d5:243c]) by VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::2cba:efb0:12d5:243c%8]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 15:27:56 +0000
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH stable v4.4 00/52] powerpc spectre backports for 4.4
Thread-Topic: [PATCH stable v4.4 00/52] powerpc spectre backports for 4.4
Thread-Index: AQHU+E1z2mBCCSiQTEOS/sCRx65mjA==
Date: Mon, 22 Apr 2019 15:27:56 +0000
Message-ID: <VI1PR0401MB24639DFFA532DF374BB86070FF220@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
 <20190421163421.GA8449@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=diana.craciun@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55b6917c-2ca1-48db-c49a-08d6c737186c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0401MB2511; 
x-ms-traffictypediagnostic: VI1PR0401MB2511:
x-microsoft-antispam-prvs: <VI1PR0401MB251185F9C3DF09A1180F38E2FF220@VI1PR0401MB2511.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(54524002)(199004)(71190400001)(66066001)(478600001)(9686003)(486006)(229853002)(2906002)(76116006)(97736004)(446003)(55016002)(4744005)(256004)(71200400001)(26005)(476003)(73956011)(64756008)(66556008)(53936002)(66446008)(66476007)(66946007)(25786009)(54906003)(52536014)(102836004)(7736002)(74316002)(7696005)(76176011)(305945005)(8676002)(6246003)(5660300002)(81156014)(86362001)(186003)(4326008)(6436002)(33656002)(6116002)(316002)(53546011)(6506007)(99286004)(8936002)(14454004)(81166006)(68736007)(3846002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2511;
 H:VI1PR0401MB2463.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pfIa32Ev01uIczev8xFpaHJgh2/V7SVV7ZnYGnyYRG6FRrqdn5UByY/GIVLbcjIszZDSNxqbE9n985xk6LDKSLL8NkXMPWWYBipsbS/OyAzidUhLkDVcyBl28lTozai8GgGpItMLcz52s698aV73Lf/02qAnPedD3naSvanMWzgbMTrbQsgxZrWGhc//guIBEBE5GC/Ad9sSUFdyK+F2ccMKdqx+HrHGmkBs9NcWHTh+sKoA2fsNfAwvyleDvDLpmZHdQeIupiLRn0x6zHhnRccGzHaS3bq6P4l5/kwiqv8pJiBUmryjjcSDqnj9wTS7YKN7kisjEa4VAfneqE+Jw4/LaV00zCJp6tIrGkryWc5sU8AxU9BfHmRsntbfQ9mvhrQPqOxeWbOZkKX6yZ/jDhxLBhOSKzZKXmBEhZvNZ5I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b6917c-2ca1-48db-c49a-08d6c737186c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 15:27:56.4922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2511
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
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/21/2019 7:34 PM, Greg KH wrote:=0A=
> On Mon, Apr 22, 2019 at 12:19:45AM +1000, Michael Ellerman wrote:=0A=
>> -----BEGIN PGP SIGNED MESSAGE-----=0A=
>> Hash: SHA1=0A=
>>=0A=
>> Hi Greg/Sasha,=0A=
>>=0A=
>> Please queue up these powerpc patches for 4.4 if you have no objections.=
=0A=
> why?  Do you, or someone else, really care about spectre issues in 4.4?=
=0A=
> Who is using ppc for 4.4 becides a specific enterprise distro (and they=
=0A=
> don't seem to be pulling in my stable updates anyway...)?=0A=
=0A=
We (NXP) received questions from customers regarding Spectre mitigations=0A=
on kernel 4.4. Not sure if they really need them as some systems are=0A=
enclosed embedded ones, but they asked for them.=0A=
=0A=
Thanks,=0A=
Diana=0A=
=0A=
> I'll be glad to take these, just want to make sure that someone actually=
=0A=
> will use them :)=0A=
>=0A=
> thanks,=0A=
>=0A=
> greg k-h=0A=
>=0A=
=0A=
