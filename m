Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BFFC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 12:53:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A482120881
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="MAm8W5yH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZFcN0HM8zF3W9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 23:53:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="MAm8W5yH";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=104.47.38.82; helo=nam02-bl2-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="MAm8W5yH";
 dkim-atps=neutral
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0082.outbound.protection.outlook.com [104.47.38.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZFW45K9LzF3Sl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 23:49:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrbHE3Bf9hG7APS2/HK9vC5IOf+GnWPxqqvOnEBYd/g=;
 b=MAm8W5yHm/uG+VhF4mbHnkDBLoDh9xJOrVNMwVP6TYFkNZwNGXferNTDAr924FmJvRtZXzMU7NHUyuCqbbFMTxiREVd2vi5yXk8oc4HgEdXcFLGHwaFR8v3JmUtWhaE9wLNKq09PCJOH+KpsQE5myssTQQdb7yoLaXXntGf+obo=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0400.namprd10.prod.outlook.com (10.162.102.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Tue, 16 Oct 2018 12:49:15 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::b517:3cf8:a1ee:e732]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::b517:3cf8:a1ee:e732%2]) with mapi id 15.20.1250.020; Tue, 16 Oct 2018
 12:49:15 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/io: remove old GCC version implementation
Thread-Topic: [PATCH] powerpc/io: remove old GCC version implementation
Thread-Index: AQHUZUzrSLuQCVp/oEaybjzPZbsXMqUh0qwA
Date: Tue, 16 Oct 2018 12:49:15 +0000
Message-ID: <8eb877e31130aee531409d18e19894d64690163d.camel@infinera.com>
References: <199ae2a28f14f944ee9ae2770a3f1dd030e762bc.1539693039.git.christophe.leroy@c-s.fr>
In-Reply-To: <199ae2a28f14f944ee9ae2770a3f1dd030e762bc.1539693039.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR10MB0400;
 6:6hrmju49xYDb1bneHjcEsMKVK6HfPlAqBtmykp5enP2UZMgdKVo2L0EIz8AtSzZLxi7OoVPkGihJ/r+gYE4ex/B82/4Zv7WrqoA39WV4p8HOkrgOMz1WCgjP11TVOacTy1ccMw7MQ5Pfjtb9zth0Vo3rGLBiUOzGj1QNKScnNbGQ9hdqdlLdfLwqAuZUa+blDrmg2lyJ9r6igQjQppjBcpWJT4VL1YcVKOAiqEZz3Mi64a23kDqKw/wMBvY5e8wlvTV67a6HQlYNXeZz+gMonZYvIt5wF/+SoZACeVHbfs7HhHDgrGnwvIXBiBdHuuk2yyTdGWZBlkMv1HX/rfb4RCUDQGD3VhhTzjeYGi7zf95rC8+BR0s9c55od0UHhLtDDjk+PpUDq6ijvWvvqGShoimNzVOYs7z2dTIHv9xroaJLzrFWQPeHzzmUj4fbbt0sYKidtPYlBlRp0zNfyQxtD4d5xGEllZpKhoSmtFGYJb0=;
 5:OEwUwk2TASg3uPALvobi2lZUOKZ1UyQqVrA1AwvtzR5STx2xQlo4ydkFu2JO4zWePudGzcvxJcvkBd0rUTYzTFARggbTd5Pju+UW1RV/pAg3e5BXR3dJMxMCZIiXZLcEAw96znKioQznwYqT4Zxwx3URB8WUZEHRPYQ8U/033vg=;
 7:Vn1/LVnGQO1CGX8dCX+4Lt3MLJSITcs3fZ8tXiBqGdxcBLFBfwRTtNmQoiEsKas+wCtIkPY7NB2bzqTsIIeOanaqm4M+oQQXHBHJx8ppH6DOtjUZY7fgifOpEZLT9rIcTbNfF/tdj4tETIKxQwtITArZ57EL2aCWJXGy2l4UYSsGEq+1EoXW5odNOsAObjrtHgVNOiLPdgjE8MhGhZUkkwBo9a5f3Q1xhw8wtWiU7YEBsURMdMXjtSqfK9OdD0Yg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: da2a9fc5-c0a8-4d9e-d780-08d63365c7b2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR10MB0400; 
x-ms-traffictypediagnostic: SN1PR10MB0400:
x-microsoft-antispam-prvs: <SN1PR10MB04005E8958C6FF91A43EF984F4FE0@SN1PR10MB0400.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);
 SRVR:SN1PR10MB0400; BCL:0; PCL:0; RULEID:; SRVR:SN1PR10MB0400; 
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(446003)(25786009)(5250100002)(3846002)(486006)(316002)(2900100001)(97736004)(478600001)(6436002)(68736007)(256004)(2201001)(6246003)(106356001)(2501003)(86362001)(4326008)(6116002)(14454004)(71200400001)(71190400001)(36756003)(2616005)(105586002)(4001150100001)(6346003)(118296001)(305945005)(5660300001)(72206003)(186003)(110136005)(229853002)(8676002)(66066001)(476003)(7736002)(558084003)(102836004)(99286004)(81166006)(6506007)(81156014)(54906003)(6512007)(26005)(8936002)(11346002)(2906002)(6486002)(76176011)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR10MB0400;
 H:SN1PR10MB0736.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-microsoft-antispam-message-info: B35dpeJeJz0F/9iTEh9pOQB5sH9VaORfGQDf4wQwAvf++w+VFeniFR0Zq7YxpwghkxhMxRq2TK4kq9339jshKS670eSmUzhJ7IwnMkjrrWrNTz969HEiSQqEDTJwn40Q+Z6j5Dagc+1m1budmU3TiMdvnfCjQm3/NstIrAefwMIglqbKuJlPXM+vhXAKbWVqfyOf6uVOO0LYrjASAPdIW5pIJmea0iXFC88f5AnHkiOu6gOwKIiYElHldKjluFwOIKmGblCYC71NqYi2xkB0wbbfiOIMTV3DkQfBz1uat/wZOM6sAyPFjZY4rh5aRnNM6MhlRLwRIkXfWR0zmmciIhcKxMDnFXEWT0GVN96s6iU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B130CED99D5E6D4AAD2C6506EEBB5C3F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a9fc5-c0a8-4d9e-d780-08d63365c7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 12:49:15.3963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0400
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gVHVlLCAyMDE4LTEwLTE2IGF0IDEyOjMzICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiANCj4gDQo+IEdDQyA0LjYgaXMgdGhlIG1pbmltdW0gc3VwcG9ydGVkIG5vdy4NCg0KT3Vj
aCwgZnJvbSBrZXJuZWwgNC4xOSBvciBlYXJsaWVyIGV2ZW4gPw0KDQogSm9ja2UNCg==
