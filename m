Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C9C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:20:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CFF218A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="a2XFDX74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CFF218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W6R304GdzDqXD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 03:20:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=40.107.77.72; helo=nam02-sn1-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="a2XFDX74";
 dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770072.outbound.protection.outlook.com [40.107.77.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W5CZ3LK5zDqXN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 02:25:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NagBQEDrwbpYWitxtUcH21B16aMN44njs4xptlM5EX8=;
 b=a2XFDX749R7n2Gw0A35wZyp4zs3ieaxP3RAXq1eQCrd5tn400Wd3u7A36HDv22M1tAXEAwZKgsA0P3mBdSZthjVToI53CygbziuDvz3xevCb4ITfnNCvrxkFAWnNlYWiNkQaRpcTMKP1MJLV8BA6Zz8BYpalaoPCxDbZ5qDSWdo=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3123.namprd10.prod.outlook.com (20.179.136.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Fri, 29 Mar 2019 15:25:22 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f%5]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 15:25:22 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madalin.bucur@nxp.com"
 <madalin.bucur@nxp.com>, "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
 "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>, "roy.pledge@nxp.com"
 <roy.pledge@nxp.com>, "camelia.groza@nxp.com" <camelia.groza@nxp.com>
Subject: Re: [PATCH 13/13] dpaa_eth: fix SG frame cleanup
Thread-Topic: [PATCH 13/13] dpaa_eth: fix SG frame cleanup
Thread-Index: AQHU5jmYHjJyXyhV/ESlu9VKUsHArqYiusiA
Date: Fri, 29 Mar 2019 15:25:22 +0000
Message-ID: <702d2baba6c2c131c1ae59607943eb8f8813d250.camel@infinera.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-14-laurentiu.tudor@nxp.com>
In-Reply-To: <20190329140014.8126-14-laurentiu.tudor@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd4fac9a-b986-402a-7a67-08d6b45ac27b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:BN8PR10MB3123; 
x-ms-traffictypediagnostic: BN8PR10MB3123:
x-microsoft-antispam-prvs: <BN8PR10MB312340C22D8E3AFF1C3A85ABF45A0@BN8PR10MB3123.namprd10.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(8936002)(6486002)(86362001)(7736002)(6436002)(8676002)(102836004)(186003)(7416002)(81166006)(36756003)(2906002)(97736004)(106356001)(54906003)(5660300002)(6246003)(6512007)(110136005)(316002)(71190400001)(2201001)(71200400001)(2501003)(53936002)(229853002)(118296001)(99286004)(76176011)(446003)(256004)(6506007)(305945005)(14444005)(81156014)(14454004)(72206003)(476003)(11346002)(66066001)(6116002)(4326008)(25786009)(3846002)(105586002)(68736007)(2616005)(486006)(26005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3123;
 H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sdQSWa+K8zfptSfMx6eD6t8S0OO3T+TkFCE+6vWZvrekRx8dlzcIzH5cHsPFR3/sfO5nycTuetHRNhmhfR4WQVbUPmNZIPo2X7/wRrXvks2fSj7SIQR+E4YyQdDfbtlUw1C/vS7+SP4fbmNGFCEBFXCo9JfDA3Oz3Mn8VVavrI7GiHNykcHOxURCTaeQe5gLd9mIpampJfRPF7hS7EBFMemw7K5oHbxEEfTFR0Yc6FOjS2ygU/30XANsMvPVhiSpfllKDLsIV9Sypp8j7YFhnkleegRqMuzrMvVSvey/NU8cGBZzgFo4ocw/KoKbJnlcPJRYV/L3OcbXx9zecEaUaK1aF4kPy7lq17KI+h3Ze6uHzSK5nNwgSI9AGjCPtDtxkKOQK/nEyfb+LOXERC7Zz0M6ZUmZgsoFrhNU2CWJcME=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9880E2E7CACB754F879567570CD6CEF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4fac9a-b986-402a-7a67-08d6b45ac27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 15:25:22.1111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3123
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
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQpTaG91bGQgdGhpcyBvbmUgZ28gc3RhYmxlIDQuMTQvNC4xOSB0b28/DQoNCk9uIEZyaSwgMjAx
OS0wMy0yOSBhdCAxNjowMCArMDIwMCwgbGF1cmVudGl1LnR1ZG9yQG54cC5jb20gd3JvdGU6DQo+
IA0KPiBGcm9tOiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPiAN
Cj4gRml4IGlzc3VlIHdpdGggdGhlIGVudHJ5IGluZGV4aW5nIGluIHRoZSBzZyBmcmFtZSBjbGVh
bnVwIGNvZGUgYmVpbmcNCj4gb2ZmLWJ5LTEuIFRoaXMgcHJvYmxlbSBzaG93ZWQgdXAgd2hlbiBk
b2luZyBzb21lIGJhc2ljIGlwZXJmIHRlc3RzIGFuZA0KPiBtYW5pZmVzdGVkIGluIHRyYWZmaWMg
Y29taW5nIHRvIGEgaGFsdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBUdWRvciA8
bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+IEFja2VkLWJ5OiBNYWRhbGluIEJ1Y3VyIDxtYWRh
bGluLmJ1Y3VyQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2RwYWEvZHBhYV9ldGguYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9kcGFhL2RwYWFfZXRoLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZHBhYS9kcGFhX2V0aC5jDQo+IGluZGV4IGRhZWRlNzI3Mjc2OC4uNDA0MjBlZGM5Y2U2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYS9kcGFh
X2V0aC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhL2RwYWFf
ZXRoLmMNCj4gQEAgLTE2NjMsNyArMTY2Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqZHBh
YV9jbGVhbnVwX3R4X2ZkKGNvbnN0IHN0cnVjdCBkcGFhX3ByaXYgKnByaXYsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHFtX3NnX2VudHJ5X2dldF9sZW4oJnNndFswXSksIGRt
YV9kaXIpOw0KPiANCj4gICAgICAgICAgICAgICAgIC8qIHJlbWFpbmluZyBwYWdlcyB3ZXJlIG1h
cHBlZCB3aXRoIHNrYl9mcmFnX2RtYV9tYXAoKSAqLw0KPiAtICAgICAgICAgICAgICAgZm9yIChp
ID0gMTsgaSA8IG5yX2ZyYWdzOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIGZvciAoaSA9IDE7
IGkgPD0gbnJfZnJhZ3M7IGkrKykgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBXQVJOX09O
KHFtX3NnX2VudHJ5X2lzX2V4dCgmc2d0W2ldKSk7DQo+IA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBkbWFfdW5tYXBfcGFnZShkZXYsIHFtX3NnX2FkZHIoJnNndFtpXSksDQo+IC0tDQo+IDIu
MTcuMQ0KPiANCg0K
