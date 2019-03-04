Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DCEC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 08:57:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1D020836
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 08:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DzZBt/BA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1D020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CYn910vdzDqDq
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 19:57:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=40.107.15.53; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=haibo.xu@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com
 header.b="DzZBt/BA"; dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150053.outbound.protection.outlook.com [40.107.15.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CXbc3kmhzDqGg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 19:03:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Hf4/om2b/QyB7SjdgsfsNQF9uHbn4M6aQkHr3peRu8=;
 b=DzZBt/BANVF5VQusH6c4Zm/6NhSQ1waCYwJDANYZEWYqyX8DMsczxPeD/dCnIakGXVxJu7iJs0I/B10QVsth9V++9GZvLU+V1dFXdIbll2qdujZ3P7C5tZRT58Oh15HNgnOcq5nVj17BTVnMHAPCSySRU1FZYK0H22aFzpygnxQ=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.190.138) by
 AM4PR08MB0755.eurprd08.prod.outlook.com (10.164.82.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Mon, 4 Mar 2019 08:03:47 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 08:03:47 +0000
From: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/6] ptrace: introduce ptrace_syscall_enter to consolidate
 PTRACE_SYSEMU handling
Thread-Topic: [PATCH 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Thread-Index: AQHUz5P7c5GVx0ww2U2d9460BIWJxqX7ImCA
Date: Mon, 4 Mar 2019 08:03:47 +0000
Message-ID: <f3441e63-c54d-3b9d-2919-8a3955cbee69@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-3-sudeep.holla@arm.com>
In-Reply-To: <20190228183220.15626-3-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To AM4PR08MB2929.eurprd08.prod.outlook.com
 (2603:10a6:205:c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54fe6d66-2831-4015-15e9-08d6a077edf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM4PR08MB0755; 
x-ms-traffictypediagnostic: AM4PR08MB0755:
x-microsoft-exchange-diagnostics: 1; AM4PR08MB0755;
 20:IFYxHqURzaZ2zJ/f2sUDuCpNs8y9UfMbz0uh+nLYBClj3MF7LbXnRvTJQohfeA1NtpNemROu0GTARDPSoXWVKnV7WuRVL8XCRoZwT2PBviLXQsl8XlhIOyQkrfvzKb4c5WSeU2ge83jJ4z8+OusRvnxrlaXaAGgL419y+ORvD60=
x-microsoft-antispam-prvs: <AM4PR08MB075558BD2A3402233CA7420885710@AM4PR08MB0755.eurprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(40434004)(189003)(199004)(4326008)(97736004)(476003)(105586002)(2616005)(106356001)(8936002)(7736002)(71200400001)(5660300002)(2906002)(316002)(54906003)(110136005)(14444005)(446003)(11346002)(5024004)(486006)(256004)(71190400001)(68736007)(31686004)(229853002)(6486002)(6436002)(478600001)(72206003)(186003)(2501003)(26005)(14454004)(6246003)(53936002)(55236004)(386003)(53546011)(6506007)(102836004)(99286004)(6512007)(76176011)(52116002)(66066001)(25786009)(6116002)(81166006)(81156014)(8676002)(36756003)(2201001)(3846002)(7416002)(31696002)(86362001)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR08MB0755;
 H:AM4PR08MB2929.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iXYNy1yxQAFAAmRC1ZvjuXbd3XYppMNtUZM4fAMds+hbbzer8X3QhDPMS+ruExo3mGq/IUTw2xZWP9F9opgKV//JxnmnfV7qJK+/CmvP/d3Jnj2HEulGHDCSyREf7Aek4Uta/Fv/FQG4Mid1xk5c9E2xSO/WWxYZcLIAbbviBqj8R7oW7fB7T60h5gPyu/DblKQUwzIKbyepguJVHkwdV8A1VLDEWUUn2n3XuSfDGBTbj8UxkoLN4Epf0AAA7jXDgSTDx88boe3h5G+rtjn3bt9OXnAKR/GkFWL+nSgY7Hz4wfzG+b2P+Ov8a1BSic7r0mjXP2BD+rtbXtiDX1KA0ohUnawsxtwoKh2j8Ma9QM8BBMB+ksU3OO+7iyV9JzQm7cXTzLUhVIpexRbc1cxNBeekBfFz4mHo7K9rKxuv+tY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1F4E3E3BC2E6743B476ADC1C4C8EFF7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fe6d66-2831-4015-15e9-08d6a077edf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 08:03:47.5968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0755
X-Mailman-Approved-At: Mon, 04 Mar 2019 19:55:40 +1100
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
Cc: Steve Capper <Steve.Capper@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "jdike@addtoit.com" <jdike@addtoit.com>, Will Deacon <Will.Deacon@arm.com>,
 Oleg Nesterov <oleg@redhat.com>,
 "Bin Lu \(Arm Technology China\)" <Bin.Lu@arm.com>,
 Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMjAxOS8zLzEgMjozMiwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBDdXJyZW50bHkgZWFjaCBh
cmNoaXRlY3R1cmUgaGFuZGxlcyBQVFJBQ0VfU1lTRU1VIGluIHZlcnkgc2ltaWxhciB3YXkuDQo+
IEl0J3MgY29tcGxldGVseSBhcmNoIGluZGVwZW5kZW50IGFuZCBjYW4gYmUgaGFuZGxlZCBpbiB0
aGUgY29kZSBoZWxwaW5nDQo+IHRvIGNvbnNvbGlkYXRlIFBUUkFDRV9TWVNFTVUgaGFuZGxpbmcu
DQo+DQo+IExldCdzIGludHJvZHVjZSBhIGhvb2sgJ3B0cmFjZV9zeXNjYWxsX2VudGVyJyB0aGF0
IGFyY2ggc3BlY2lmaWMgc3lzY2FsbA0KPiBlbnRyeSBjb2RlIGNhbiBjYWxsLg0KPg0KDQpUaGUg
J3B0cmFjZV9zeXNjYWxsX2VudGVyJyBpcyBkZWRpY2F0ZWQgZm9yIFBUUkFDRV9TWVNFTVUgZmxh
ZywNClNvIEkgc3VnZ2VzdCB0byByZW5hbWUgdGhlIGZ1bmN0aW9uIHRvIHNvbWV0aGluZyBsaWtl
ICdwdHJhY2Vfc3lzY2FsbF9lbXVfZW50ZXIiLg0KDQo+ICsvKg0KPiArICogSG9vayB0byBjaGVj
ayBhbmQgcmVwb3J0IGZvciBQVFJBQ0VfU1lTRU1VLCBjYW4gYmUgY2FsbGVkIGZyb20gYXJjaA0K
PiArICogYXJjaCBzeXNjYWxsIGVudHJ5IGNvZGUNCj4gKyAqLw0KPiArbG9uZyBwdHJhY2Vfc3lz
Y2FsbF9lbnRlcihzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gK3sNCj4gKyNpZmRlZiBUSUZfU1lT
Q0FMTF9FTVUNCj4gK2lmICh0ZXN0X3RocmVhZF9mbGFnKFRJRl9TWVNDQUxMX0VNVSkpIHsNCj4g
K2lmICh0cmFjZWhvb2tfcmVwb3J0X3N5c2NhbGxfZW50cnkocmVncykpOw0KDQpTaGFsbCB3ZSBy
ZW1vdmUgdGhlIHNlbWktY29sb24gYXQgZW5kIG9mIHRoZSBhYm92ZSBsaW5lPw0KDQo+ICtyZXR1
cm4gLTFMOw0KPiArfQ0KPiArI2VuZGlmDQo+ICtyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgLyoN
Cj4gICAqIERldGFjaCBhbGwgdGFza3Mgd2Ugd2VyZSB1c2luZyBwdHJhY2Ugb24uIENhbGxlZCB3
aXRoIHRhc2tsaXN0IGhlbGQNCj4gICAqIGZvciB3cml0aW5nLg0KPg0KSU1QT1JUQU5UIE5PVElD
RTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29u
ZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkg
YW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNl
IGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4g
YW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
