Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D2C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 03:28:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B137B20850
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 03:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="L1xfs/td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B137B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ndn92VqnzDqLD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 14:28:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=2a01:111:f400:fe06::61c;
 helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=haibo.xu@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com
 header.b="L1xfs/td"; dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02on061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe06::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NdlG0f8mzDq5t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 14:27:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GoJDfoJfQDz/iILM8IrdJq4uWn0lQw79UWAEKpEBn0=;
 b=L1xfs/tdn5tNCLjiRGcU4YHT+jao5UxQ97pJ8Igu0BBwadh2xORJ0HKzmH6752TXI8wmWM/Q07HtncycBNUC8Z+NhtnLJe2WaK//2t57RtSKEMm9kvUbJM/AyIXYK88Eeyb5qqTP1erLkR9Xd1VrxsfRkYUHR3uQC5uqnqot2Qk=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.190.138) by
 AM4PR08MB2788.eurprd08.prod.outlook.com (10.170.126.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 03:26:55 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce%4]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 03:26:55 +0000
From: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 6/6] arm64: ptrace: add support for syscall emulation
Thread-Topic: [PATCH v2 6/6] arm64: ptrace: add support for syscall emulation
Thread-Index: AQHU3XhULdk58bsEV0aU5OxJLBF6T6YSTDMA
Date: Tue, 19 Mar 2019 03:26:55 +0000
Message-ID: <14635968-ccb9-874b-4e41-2881c19be679@arm.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-7-sudeep.holla@arm.com>
In-Reply-To: <20190318104925.16600-7-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To AM4PR08MB2929.eurprd08.prod.outlook.com
 (2603:10a6:205:c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cc99957-55da-4e20-7b60-08d6ac1abc5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM4PR08MB2788; 
x-ms-traffictypediagnostic: AM4PR08MB2788:
x-microsoft-antispam-prvs: <AM4PR08MB278869B15643D7859DAC074D85400@AM4PR08MB2788.eurprd08.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(40434004)(5660300002)(7416002)(53546011)(36756003)(52116002)(386003)(26005)(186003)(76176011)(102836004)(6512007)(6506007)(53936002)(3846002)(6246003)(55236004)(25786009)(229853002)(8936002)(6116002)(4326008)(71190400001)(71200400001)(81156014)(81166006)(8676002)(6486002)(2616005)(106356001)(2201001)(6436002)(7736002)(110136005)(54906003)(68736007)(446003)(97736004)(305945005)(316002)(2501003)(486006)(256004)(14444005)(2906002)(5024004)(99286004)(476003)(31686004)(66066001)(14454004)(31696002)(478600001)(86362001)(11346002)(72206003)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR08MB2788;
 H:AM4PR08MB2929.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: msrUDis69p8Eae1Iyb3T4zx+Jhn5iuDa5gAq+s51ut0Jsx5qJ8u4Xy/Df9QZT0Qx4CVSBAkWmr1Yv0PfwVq18YgZqWbJT6wREAOb3Ao8WU+Md1+n9Lgt0PWouWLqqsb640YfFciH5eHis3rNBbt6ygHXJ1XhYXASw2VU0mafCM9dtuwn1JOj9frSOfNM1payy/6yatIY3JstzUyFcaTmQ3YZSf62mJ4XrW0/5KZu4FW8rI4XfjQbTOWAvmsgCNqdH2Tbom47hphzcetf7h+IkeWgTBmaUOO/Tkct7uSfdMkWqXIr3WoIjaAi1N3ysc30M5AqWsc9wXZQwlC+512cAJHqKPHZb2aUawFjpFffBqC1tZClN4pDzC0O+slwxl8pMM1mzoQ/hiRMr35DaZUqe6bmo/81nb8HKHeHyBIFM4w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94D74379531EE54985D3D9F0A9DB8386@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc99957-55da-4e20-7b60-08d6ac1abc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 03:26:55.1607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2788
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
 Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMjAxOS8zLzE4IDE4OjQ5LCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+IEFkZCBQVFJBQ0VfU1lT
RU1VIGFuZCBQVFJBQ0VfU1lTRU1VX1NJTkdMRVNURVAgc3VwcG9ydCBvbiBhcm02NC4NCj4gV2Ug
Y2FuIGp1c3QgbWFrZSBzdXJlIG9mIHRoZSBnZW5lcmljIHB0cmFjZV9zeXNjYWxsX2VudGVyIGhv
b2sgdG8NCj4gc3VwcG9ydCBQVFJBQ0VfU1lTRU1VLiBXZSBkb24ndCBuZWVkIGFueSBzcGVjaWFs
IGhhbmRsaW5nIGZvcg0KPiBQVFJBQ0VfU1lTRU1VX1NJTkdMRVNURVAuDQoNClRoaXMgbG9va3Mg
Z29vZCB0byBtZS4gQnV0IGl0J2QgYmUgYmV0dGVyIHRvIGFkZCB0aGUgc2FtZSBsb2dpYyB0byBo
YW5kbGUNClBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCBhcyB0aGF0IG9mIHg4NiBpbiBjYXNlIHdl
IG1heSBuZWVkIGVuYWJsZSB0aGUgc2luZ2xlDQpzdGVwIHRyYWNlIGZ1bmN0aW9uIGluIHRoZSBm
dXR1cmUuDQoNCj4NCj4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5j
b20+DQo+IENjOiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4gLS0tDQo+ICBhcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmggfCA1ICsrKystDQo+ICBhcmNoL2FybTY0
L2tlcm5lbC9wdHJhY2UuYyAgICAgICAgICAgfCAzICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vdGhy
ZWFkX2luZm8uaA0KPiBpbmRleCBlYjNlZjczZTA3Y2YuLmMyODVkMWNlNzE4NiAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oDQo+ICsrKyBiL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaA0KPiBAQCAtNzUsNiArNzUsNyBAQCB2b2lk
IGFyY2hfcmVsZWFzZV90YXNrX3N0cnVjdChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzayk7DQo+ICAg
KiAgVElGX1NZU0NBTExfVFJBQ0UtIHN5c2NhbGwgdHJhY2UgYWN0aXZlDQo+ICAgKiAgVElGX1NZ
U0NBTExfVFJBQ0VQT0lOVCAtIHN5c2NhbGwgdHJhY2Vwb2ludCBmb3IgZnRyYWNlDQo+ICAgKiAg
VElGX1NZU0NBTExfQVVESVQtIHN5c2NhbGwgYXVkaXRpbmcNCj4gKyAqICBUSUZfU1lTQ0FMTF9F
TVUgICAgIC0gc3lzY2FsbCBlbXVsYXRpb24gYWN0aXZlDQo+ICAgKiAgVElGX1NFQ09NUC0gc3lz
Y2FsbCBzZWN1cmUgY29tcHV0aW5nDQo+ICAgKiAgVElGX1NJR1BFTkRJTkctIHNpZ25hbCBwZW5k
aW5nDQo+ICAgKiAgVElGX05FRURfUkVTQ0hFRC0gcmVzY2hlZHVsaW5nIG5lY2Vzc2FyeQ0KPiBA
QCAtOTEsNiArOTIsNyBAQCB2b2lkIGFyY2hfcmVsZWFzZV90YXNrX3N0cnVjdChzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnRzayk7DQo+ICAjZGVmaW5lIFRJRl9TWVNDQUxMX0FVRElUOQ0KPiAgI2RlZmlu
ZSBUSUZfU1lTQ0FMTF9UUkFDRVBPSU5UMTANCj4gICNkZWZpbmUgVElGX1NFQ0NPTVAxMQ0KPiAr
I2RlZmluZSBUSUZfU1lTQ0FMTF9FTVUxMg0KPiAgI2RlZmluZSBUSUZfTUVNRElFMTgvKiBpcyB0
ZXJtaW5hdGluZyBkdWUgdG8gT09NIGtpbGxlciAqLw0KPiAgI2RlZmluZSBUSUZfRlJFRVpFMTkN
Cj4gICNkZWZpbmUgVElGX1JFU1RPUkVfU0lHTUFTSzIwDQo+IEBAIC0xMDksNiArMTExLDcgQEAg
dm9pZCBhcmNoX3JlbGVhc2VfdGFza19zdHJ1Y3Qoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spOw0K
PiAgI2RlZmluZSBfVElGX1NZU0NBTExfQVVESVQoMSA8PCBUSUZfU1lTQ0FMTF9BVURJVCkNCj4g
ICNkZWZpbmUgX1RJRl9TWVNDQUxMX1RSQUNFUE9JTlQoMSA8PCBUSUZfU1lTQ0FMTF9UUkFDRVBP
SU5UKQ0KPiAgI2RlZmluZSBfVElGX1NFQ0NPTVAoMSA8PCBUSUZfU0VDQ09NUCkNCj4gKyNkZWZp
bmUgX1RJRl9TWVNDQUxMX0VNVSgxIDw8IFRJRl9TWVNDQUxMX0VNVSkNCj4gICNkZWZpbmUgX1RJ
Rl9VUFJPQkUoMSA8PCBUSUZfVVBST0JFKQ0KPiAgI2RlZmluZSBfVElGX0ZTQ0hFQ0soMSA8PCBU
SUZfRlNDSEVDSykNCj4gICNkZWZpbmUgX1RJRl8zMkJJVCgxIDw8IFRJRl8zMkJJVCkNCj4gQEAg
LTEyMCw3ICsxMjMsNyBAQCB2b2lkIGFyY2hfcmVsZWFzZV90YXNrX3N0cnVjdChzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnRzayk7DQo+DQo+ICAjZGVmaW5lIF9USUZfU1lTQ0FMTF9XT1JLKF9USUZfU1lT
Q0FMTF9UUkFDRSB8IF9USUZfU1lTQ0FMTF9BVURJVCB8IFwNCj4gICBfVElGX1NZU0NBTExfVFJB
Q0VQT0lOVCB8IF9USUZfU0VDQ09NUCB8IFwNCj4gLSBfVElGX05PSFopDQo+ICsgX1RJRl9OT0ha
IHwgX1RJRl9TWVNDQUxMX0VNVSkNCj4NCj4gICNkZWZpbmUgSU5JVF9USFJFQURfSU5GTyh0c2sp
XA0KPiAge1wNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL3B0cmFjZS5jIGIvYXJj
aC9hcm02NC9rZXJuZWwvcHRyYWNlLmMNCj4gaW5kZXggYjgyZTBhOWIzZGEzLi5jZjI5Mjc1Y2Q0
ZDkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL3B0cmFjZS5jDQo+ICsrKyBiL2Fy
Y2gvYXJtNjQva2VybmVsL3B0cmFjZS5jDQo+IEBAIC0xODE5LDYgKzE4MTksOSBAQCBzdGF0aWMg
dm9pZCB0cmFjZWhvb2tfcmVwb3J0X3N5c2NhbGwoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+DQo+
ICBpbnQgc3lzY2FsbF90cmFjZV9lbnRlcihzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gIHsNCj4g
K2lmICh1bmxpa2VseShwdHJhY2Vfc3lzY2FsbF9lbnRlcihyZWdzKSkpDQo+ICtyZXR1cm4gLTE7
DQo+ICsNCj4gIGlmICh0ZXN0X3RocmVhZF9mbGFnKFRJRl9TWVNDQUxMX1RSQUNFKSkNCj4gIHRy
YWNlaG9va19yZXBvcnRfc3lzY2FsbChyZWdzLCBQVFJBQ0VfU1lTQ0FMTF9FTlRFUik7DQo+DQo+
DQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNl
bmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkg
b3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRo
ZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
