Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE9EC32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 10:07:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC38F20835
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 10:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkFUDsoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC38F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42W68x4SPtzDr43
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 21:07:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GkFUDsoZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.83; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=horia.geanta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="GkFUDsoZ"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70083.outbound.protection.outlook.com [40.107.7.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42W65T51dgzF3FW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 21:04:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI11Dcb5f6vnFh9HnYzt7OMB/7rcP+3Y3xKUajxg6zw=;
 b=GkFUDsoZMc9qReGiVgzXP53nA+YC2ZiyGmQ42hXOkNyBBZRez+XY7mQRlV+IfatYTAz5TWMrGGkQBhd2RvuaT1CNQvj3KMm/UcRI1yx1tjLOy8AwrUW9RBJJtF3IzzMThXn1KKzs5EoedJLNqynhCLcDz2LT0oTn6IYIdaM/5jc=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3455.eurprd04.prod.outlook.com (52.134.3.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 11 Oct 2018 10:04:32 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::78d5:848c:49af:fbc5]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::78d5:848c:49af:fbc5%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 10:04:32 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Scott Wood <oss@buserror.net>, Rob Herring <robh+dt@kernel.org>, Vabhav
 Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
Thread-Topic: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
Thread-Index: AQHUOLcWZbySF20JhkCNMnXgzjY1nw==
Date: Thu, 11 Oct 2018 10:04:31 +0000
Message-ID: <VI1PR0402MB34852BFA7E8E44E9B867D76F98E10@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
 <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
 <1dd3074eabb496155c4d1abb83c82c52529a656a.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3455;
 6:vcD5y3T6i/5kIAzmUN3P/+UYHecawZERdPSqpW3TbaUz5pYJF3kEDcZ5rwceA9u+JeyL/NW+LwrPhGz3mdLh6uR9Dsm+T4yVKzOtt00SEabGbrsIDZhH6bRPJdDpKplC0G6HjmEJqHZ+QRgyvrFftBAnowte6HsXhDf0KecMUsb5innn2igOWV85rmaiXOO5V5bhZwgXcU9XKmBxF4K7Nt8UY+qiN5Ecqijl6CNSPYsKFVtUUjc5O1MZFCHw/273Li9kgP1DzCcPF6LKKgZ05W83Ay0lg94D+xBYA54peGgSWfWPPSw7ppWkF8wGsyY27o1LvoF/a5B/jD5OKiaky73nm0oc8v/h4QGcItuhMqEunFixk3Fif2weP4n+lNWRdf8eRxR4l48/lXyuw1h6NGKO58WS2akWua+cfsdgNyX+MMeesIymlkOUk8cSYvJdSoi6+29X866zI9LgKWkSaA==;
 5:4QOyYFfPzCih3hZB/PMt3Gixx1UL6FbMXyvVmh3N90IjRLx9B7AzGhqAGq+57puEMcWAKc8w+i1wpSAKkoPjAREQjEX2FDVAmJNJOUbVZUfF8zL1GTbShhsvmlvaPdV/evqGHh8iq5tPuHIp9JS/d/p/G4plXWJpOrjAhoU18u8=;
 7:PNVt/P1P6ybiizxW2TkwQvAiDOZXqjB6CoZOb1h+XqpiJRZnX3NFpjOao2eYTe3UIjZ25NifVMpSJ7QEnrbpeuCLwEWZDj21VEGovUiGtkuTXHBBVdGwrMUMQ455HLqCAfBRenSqJn9pZLLA+Ud5CC9Rs4mwDpgqimeFFETglpmqVJeCPrZP458ewWiYH3MI448fhkk3WrGpibRp1t6zn6G/SBzVe5CXzyxPszuxzokWH0y8mOaXRLv0yzV1KvEv
x-ms-office365-filtering-correlation-id: 8b58e972-3246-4e47-5780-08d62f60f0c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3455; 
x-ms-traffictypediagnostic: VI1PR0402MB3455:
x-microsoft-antispam-prvs: <VI1PR0402MB3455446A8BFD03B91182C29A98E10@VI1PR0402MB3455.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);
 SRVR:VI1PR0402MB3455; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3455; 
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(74316002)(6246003)(305945005)(7736002)(7416002)(106356001)(2900100001)(102836004)(256004)(110136005)(54906003)(105586002)(4326008)(66066001)(71200400001)(71190400001)(5250100002)(6506007)(2906002)(53936002)(93886005)(316002)(53546011)(478600001)(86362001)(486006)(6636002)(9686003)(55016002)(76176011)(7696005)(6436002)(446003)(5660300001)(44832011)(966005)(6306002)(14454004)(476003)(99286004)(68736007)(97736004)(8676002)(561944003)(81156014)(3846002)(6116002)(229853002)(186003)(8936002)(81166006)(33656002)(26005)(25786009)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3455;
 H:VI1PR0402MB3485.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VSDwEGMull0fZTIke25FMnqCwIOu04Mzeq+gE/FiPKVRJ3dwAVn4fa/jA9j70WT3l07dD7ka0oYkc86P36NPOTAWUrFggLi/eQdXKIu3HhLi98UW1mJtByUrOIJyD6kuD/vlKYH9wV30ltPxYCvI1qec491kxFGQyZH4vX2hsqYbuXM4zRNCYai4xiHSoq2f5l+rUmL9tDLsj9spgd5PTA0GEQxMGudLmxy4M+L4gmhXfCm1hoQbqD9eSpuKaxadhYr5B5hLmQfhJKoQLtqBbhszCPdU/m3e0fgwYCNp2FiPO5aZZTxj3Jq14dMmsn1xNhM+QEs1FZ9R6H9Qec7gzitPcBTFGS6y3IFOvuO5Htk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b58e972-3246-4e47-5780-08d62f60f0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 10:04:31.9570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3455
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Will Deacon <will.deacon@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Sriram Dash <sriram.dash@nxp.com>, linux-clk <linux-clk@vger.kernel.org>,
 Udit Kumar <udit.kumar@nxp.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "open
 list:THERMAL" <linux-pm@vger.kernel.org>, Varun Sethi <V.Sethi@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 8/29/2018 3:31 AM, Scott Wood wrote:=0A=
> On Tue, 2018-08-21 at 15:45 -0500, Rob Herring wrote:=0A=
>> On Mon, Aug 20, 2018 at 1:52 PM Vabhav Sharma <vabhav.sharma@nxp.com> wr=
ote:=0A=
>>> +/ {=0A=
>>> +       model =3D "NXP Layerscape LX2160ARDB";=0A=
>>> +       compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";=0A=
>>> +=0A=
>>> +       aliases {=0A=
>>> +               crypto =3D &crypto;=0A=
>>=0A=
>> Drop this. Aliases should be numbered, and this is not a standard=0A=
>> alias name either.=0A=
> =0A=
> Is this a new rule?  In any case, U-Boot looks for a "crypto" alias.=0A=
> =0A=
(Replying here, I did not see a follow-up).=0A=
=0A=
Indeed, U-boot relies on the "crypto" alias.=0A=
This is true for all SoCs with CAAM crypto engine, a pretty lengthy list.=
=0A=
=0A=
Could you please clarify?=0A=
Also: Is numbering needed even when there is a single instance of the block=
?=0A=
=0A=
Looking at a recent discussion=0A=
https://lore.kernel.org/patchwork/patch/991718=0A=
I see the proposal is for the ID to be optional:=0A=
> Alias names are often suffixed with a numeric ID, especially when there m=
ay=0A=
> be multiple instances of the same type. The ID typically corresponds to t=
he=0A=
[...]=0A=
=0A=
Thanks,=0A=
Horia=0A=
