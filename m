Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E551C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:26:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC3B2173C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="zF0AzaeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC3B2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W6Z16kHRzDqcD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 03:26:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W6Sx1VPHzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 03:22:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="zF0AzaeO";
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44W6Sw6v4Tz8tDh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 03:22:08 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44W6Sw683bz9sPx; Sat, 30 Mar 2019 03:22:08 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=40.107.74.89; helo=nam01-bn3-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="zF0AzaeO";
 dkim-atps=neutral
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740089.outbound.protection.outlook.com [40.107.74.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44W6Sw3dFyz9sPv
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Mar 2019 03:22:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWsYNUa+cKDBdEPJi29qapH/XwwBlLAXi6J6ufybcYw=;
 b=zF0AzaeOJjGMOH89jNiIaEO7nhQz/sExd68ITtoRhFdiiMikc9+w6Ck3GDCo6XMTb4uh4z5aZxlXYBKPpfFE+yut1p4mmaZH3Kb/q5lLBtv+i70DKty2s335vThomNJEGfnpkWhK8QubC3MIUd5y7Bxr0RXPHhrYkYs2vhTC0Xw=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3331.namprd10.prod.outlook.com (20.179.139.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Fri, 29 Mar 2019 16:22:03 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f%5]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 16:22:03 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec
 implementation for NXP PowerPC Book3E
Thread-Topic: [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec
 implementation for NXP PowerPC Book3E
Thread-Index: AQHU5iX/fml8VT6UTEqawEqVHaOCaKYiysYA
Date: Fri, 29 Mar 2019 16:22:03 +0000
Message-ID: <763028d666042f5642104b42aaa416c2867baa31.camel@infinera.com>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
 <20190329112620.14489-14-mpe@ellerman.id.au>
In-Reply-To: <20190329112620.14489-14-mpe@ellerman.id.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a38cb30-ed98-4b86-2d35-08d6b462ae0f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN8PR10MB3331; 
x-ms-traffictypediagnostic: BN8PR10MB3331:
x-microsoft-antispam-prvs: <BN8PR10MB3331822D212B5D87B274E3B6F45A0@BN8PR10MB3331.namprd10.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(68736007)(99286004)(25786009)(6512007)(6116002)(118296001)(256004)(3846002)(4326008)(186003)(26005)(14454004)(6506007)(86362001)(2616005)(76176011)(71200400001)(5660300002)(105586002)(71190400001)(102836004)(4744005)(316002)(446003)(7736002)(110136005)(97736004)(8936002)(53936002)(486006)(476003)(2501003)(6246003)(36756003)(81156014)(305945005)(11346002)(81166006)(6486002)(8676002)(229853002)(106356001)(478600001)(72206003)(54906003)(2906002)(6436002)(66066001)(2201001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3331;
 H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OsnycZFD+q7u8T+k0HBQ1I1jb9DZQ4TGhumK62sZksSkiYrb3L5w+mWhhVbjSvdk8FZ9HXaURouAcPy7PwfviM4Gsx5F67Ggk+U8+bZZIbsXNhq+mrECcSgLOMSf4lqvjbkymvr7uKyZgGOuuK94iH/WHHyzmpjHMtSyGHu7uTj2y2d1ftPZuayCSkqflX5ZIYoNCbL7ZPDRuNtE+UYiaj3PYVr7q/j5+IksRyO/dyU3f6JqSX6LFf3mYEhhGaCcWL+EsTsJn339osJtwSdoa6geOSUXN8s8dYJfSQo6u2dNW8aKzPnIgulZ62LSzUhGav7qWGHE7RPTIPv4SkJApymlgV4EuaKwqkO7vw3vHvNr30teL2pg6bQ1tWIXl5xnwHcQoFP8/NxPKOybjr0we7jymRiFZEftykTXN4FRU04=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85FCA49757B3134497CB334C852346FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a38cb30-ed98-4b86-2d35-08d6b462ae0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 16:22:03.8167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3331
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
Cc: "diana.craciun@nxp.com" <diana.craciun@nxp.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "msuchanek@suse.de" <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gRnJpLCAyMDE5LTAzLTI5IGF0IDIyOjI2ICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiANCj4gRnJvbTogRGlhbmEgQ3JhY2l1biA8ZGlhbmEuY3JhY2l1bkBueHAuY29tPg0KPiAN
Cj4gY29tbWl0IGViY2QxYmZjMzNjN2E5MGRmOTQxZGY2OGE2ZTVkNDAxOGMwMjJmYmEgdXBzdHJl
YW0uDQo+IA0KPiBJbXBsZW1lbnQgdGhlIGJhcnJpZXJfbm9zcGVjIGFzIGEgaXN5bmM7c3luYyBp
bnN0cnVjdGlvbiBzZXF1ZW5jZS4NCj4gVGhlIGltcGxlbWVudGF0aW9uIHVzZXMgdGhlIGluZnJh
c3RydWN0dXJlIGJ1aWx0IGZvciBCT09LM1MgNjQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEaWFu
YSBDcmFjaXVuIDxkaWFuYS5jcmFjaXVuQG54cC5jb20+DQo+IFttcGU6IFNwbGl0IG91dCBvZiBs
YXJnZXIgcGF0Y2hdDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxl
cm1hbi5pZC5hdT4NCg0KV2hhdCBpcyB0aGUgcGVyZm9ybWFuYyBpbXBhY3Qgb2YgdGhlc2Ugc3Bl
Y3RyZSBmaXhlcz8NCkNhbiBJIGNvbXBpbGUgaXQgYXdheT8NCg0KICBKb2NrZQ0K
