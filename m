Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4455C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 08:58:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1887520836
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dMaZRZaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1887520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CYpv0flJzDq9n
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 19:58:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=2a01:111:f400:fe0c::612;
 helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=haibo.xu@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com
 header.b="dMaZRZaP"; dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CY4b4vBGzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 19:25:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G42knV22rQuBviSuP0oTu5AMw04TUJn/7p1XHEjkSxM=;
 b=dMaZRZaPScpEaYZpU8OxGx+uARyZtX1uEAF0uvCrwm22XRgkdwvZvXwP3BN5/dHrWQB6qA1WWwAofZYlIRUSGe4IaVpEJJRt4DZwlLooJ8PS1y4qO4q8IuUQ6+PWL3xxz/tqWbxiMP+mJ5PuQcNHrTDnGj9Te6R3amgOx218m/o=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.190.138) by
 AM4PR08MB2897.eurprd08.prod.outlook.com (10.171.189.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Mon, 4 Mar 2019 08:25:28 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 08:25:28 +0000
From: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Topic: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Index: AQHUz5P9ZKULSdDQbEW1h9vbYNE6xaX7KHCA
Date: Mon, 4 Mar 2019 08:25:28 +0000
Message-ID: <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
In-Reply-To: <20190228183220.15626-4-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To AM4PR08MB2929.eurprd08.prod.outlook.com
 (2603:10a6:205:c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5162d5fa-c730-41f4-d43c-08d6a07af571
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM4PR08MB2897; 
x-ms-traffictypediagnostic: AM4PR08MB2897:
x-microsoft-exchange-diagnostics: 1; AM4PR08MB2897;
 20:K9Zmi+CoTulwrY9u2DwtFdpckhNF127cxbygyJjT2tuvjAJ4QNdVu6vjMqTM/HYlUdc20L2OiExFsfknKSn4e3/8HaK1rYl4gkaBxa4GCR9QXiXmCvTjf5eTr6nmawbmscLlkyrEDIa1MIqBUY9t3ulOr2f/jzHcShZqYecFU44=
x-microsoft-antispam-prvs: <AM4PR08MB28972870BE4B01B990B7A87685710@AM4PR08MB2897.eurprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(136003)(39860400002)(376002)(396003)(189003)(199004)(40434004)(66066001)(68736007)(486006)(2616005)(7416002)(97736004)(26005)(3846002)(31696002)(6116002)(2201001)(6512007)(6436002)(446003)(54906003)(53936002)(71200400001)(110136005)(71190400001)(86362001)(186003)(106356001)(2906002)(11346002)(14444005)(5024004)(305945005)(256004)(5660300002)(229853002)(72206003)(8936002)(31686004)(14454004)(478600001)(7736002)(6486002)(2501003)(76176011)(316002)(52116002)(55236004)(102836004)(25786009)(476003)(36756003)(8676002)(81156014)(81166006)(6246003)(53546011)(6506007)(386003)(99286004)(4326008)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR08MB2897;
 H:AM4PR08MB2929.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iOCZfMetmvDjYQ/RJTFZstQlEduHobJIeNPIDAQWVeb7G0KhFHeE1S49erNc00Am2/7Q74lY6OhzEEmWkjuIH+X7nDRG+3yJNQuhg594q88TWnm6o6RHco5Wc1MKpTGz3wvSRlGfsn9KSk9wvNptjHfxJ007mlnZuH+WlcSHKYW9pd3ORkrxFzQq/hebQPmjshmyF7o+KYYYiw1i1qcWNK17zS+crKG1RvXobfjuzObR6wYt9lyJYWi6NTceGd60fr8LFrt0IYXr5rQfqGuL09G57mnz/9/Bz+jQhbEGB8IjDWHWhWb+W/71HzMjVCtHwuxCbpiQLZBCaXPNYBLFF8LD7rJlYLD8oYAiY5KYlJMIVztVwoglBMZZoiFCQggt9CTiYnaDKYhzBEu3NqxcMDFO+dacSaR29GlONBPHzbY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F90793320B8B26489E40E85FB7D4CB5D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5162d5fa-c730-41f4-d43c-08d6a07af571
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 08:25:28.6267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2897
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
 Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMjAxOS8zLzEgMjozMiwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBOb3cgdGhhdCB3ZSBoYXZl
IGEgbmV3IGhvb2sgcHRyYWNlX3N5c2NhbGxfZW50ZXIgdGhhdCBjYW4gYmUgY2FsbGVkIGZyb20N
Cj4gc3lzY2FsbCBlbnRyeSBjb2RlIGFuZCBpdCBoYW5kbGVzIFBUUkFDRV9TWVNFTVUgaW4gZ2Vu
ZXJpYyBjb2RlLCB3ZQ0KPiBjYW4gZG8gc29tZSBjbGVhbnVwIHVzaW5nIHRoZSBzYW1lIGluIHN5
c2NhbGxfdHJhY2VfZW50ZXIuDQo+DQo+IEZ1cnRoZXIgdGhlIGV4dHJhIGxvZ2ljIHRvIGZpbmQg
c2luZ2xlIHN0ZXBwaW5nIFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUA0KPiBpbiBzeXNjYWxsX3Ns
b3dfZXhpdF93b3JrIHNlZW1zIHVubmVjZXNzYXJ5LiBMZXQncyByZW1vdmUgdGhlIHNhbWUuDQoN
CkkgdGhpbmsgd2Ugc2hvdWxkIG5vdCBjaGFuZ2UgdGhlIGxvZ2ljIGhlcmUuIElzIHNvLCBpdCB3
aWxsIGRvdWJsZSB0aGUgcmVwb3J0IG9mIHN5c2NhbGwNCndoZW4gUFRSQUNFX1NZU0VNVV9TSU5H
TEVTVEVQIGlzIGVuYWJsZWQuDQoNCj4NCj4gQ2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENj
OiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xs
YUBhcm0uY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jIHwgMjIgKysrKy0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTgg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS9jb21tb24uYyBi
L2FyY2gveDg2L2VudHJ5L2NvbW1vbi5jDQo+IGluZGV4IDdiYzEwNWY0N2QyMS4uMzY0NTdjMWY4
N2QyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9lbnRyeS9jb21tb24uYw0KPiArKysgYi9hcmNo
L3g4Ni9lbnRyeS9jb21tb24uYw0KPiBAQCAtNzAsMjIgKzcwLDE2IEBAIHN0YXRpYyBsb25nIHN5
c2NhbGxfdHJhY2VfZW50ZXIoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+DQo+ICBzdHJ1Y3QgdGhy
ZWFkX2luZm8gKnRpID0gY3VycmVudF90aHJlYWRfaW5mbygpOw0KPiAgdW5zaWduZWQgbG9uZyBy
ZXQgPSAwOw0KPiAtYm9vbCBlbXVsYXRlZCA9IGZhbHNlOw0KPiAgdTMyIHdvcms7DQo+DQo+ICBp
ZiAoSVNfRU5BQkxFRChDT05GSUdfREVCVUdfRU5UUlkpKQ0KPiAgQlVHX09OKHJlZ3MgIT0gdGFz
a19wdF9yZWdzKGN1cnJlbnQpKTsNCj4NCj4gLXdvcmsgPSBSRUFEX09OQ0UodGktPmZsYWdzKSAm
IF9USUZfV09SS19TWVNDQUxMX0VOVFJZOw0KPiAtDQo+IC1pZiAodW5saWtlbHkod29yayAmIF9U
SUZfU1lTQ0FMTF9FTVUpKQ0KPiAtZW11bGF0ZWQgPSB0cnVlOw0KPiAtDQo+IC1pZiAoKGVtdWxh
dGVkIHx8ICh3b3JrICYgX1RJRl9TWVNDQUxMX1RSQUNFKSkgJiYNCj4gLSAgICB0cmFjZWhvb2tf
cmVwb3J0X3N5c2NhbGxfZW50cnkocmVncykpDQo+ICtpZiAodW5saWtlbHkocHRyYWNlX3N5c2Nh
bGxfZW50ZXIocmVncykpKQ0KPiAgcmV0dXJuIC0xTDsNCj4NCj4gLWlmIChlbXVsYXRlZCkNCj4g
K3dvcmsgPSBSRUFEX09OQ0UodGktPmZsYWdzKSAmIF9USUZfV09SS19TWVNDQUxMX0VOVFJZOw0K
PiAraWYgKCh3b3JrICYgX1RJRl9TWVNDQUxMX1RSQUNFKSAmJiB0cmFjZWhvb2tfcmVwb3J0X3N5
c2NhbGxfZW50cnkocmVncykpDQo+ICByZXR1cm4gLTFMOw0KPg0KPiAgI2lmZGVmIENPTkZJR19T
RUNDT01QDQo+IEBAIC0yMjcsMTUgKzIyMSw3IEBAIHN0YXRpYyB2b2lkIHN5c2NhbGxfc2xvd19l
eGl0X3dvcmsoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHUzMiBjYWNoZWRfZmxhZ3MpDQo+ICBpZiAo
Y2FjaGVkX2ZsYWdzICYgX1RJRl9TWVNDQUxMX1RSQUNFUE9JTlQpDQo+ICB0cmFjZV9zeXNfZXhp
dChyZWdzLCByZWdzLT5heCk7DQo+DQo+IC0vKg0KPiAtICogSWYgVElGX1NZU0NBTExfRU1VIGlz
IHNldCwgd2Ugb25seSBnZXQgaGVyZSBiZWNhdXNlIG9mDQo+IC0gKiBUSUZfU0lOR0xFU1RFUCAo
aS5lLiB0aGlzIGlzIFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCkuDQo+IC0gKiBXZSBhbHJlYWR5
IHJlcG9ydGVkIHRoaXMgc3lzY2FsbCBpbnN0cnVjdGlvbiBpbg0KPiAtICogc3lzY2FsbF90cmFj
ZV9lbnRlcigpLg0KPiAtICovDQo+IC1zdGVwID0gdW5saWtlbHkoDQo+IC0oY2FjaGVkX2ZsYWdz
ICYgKF9USUZfU0lOR0xFU1RFUCB8IF9USUZfU1lTQ0FMTF9FTVUpKQ0KPiAtPT0gX1RJRl9TSU5H
TEVTVEVQKTsNCj4gK3N0ZXAgPSB1bmxpa2VseSgoY2FjaGVkX2ZsYWdzICYgX1RJRl9TSU5HTEVT
VEVQKSk7DQo+ICBpZiAoc3RlcCB8fCBjYWNoZWRfZmxhZ3MgJiBfVElGX1NZU0NBTExfVFJBQ0Up
DQo+ICB0cmFjZWhvb2tfcmVwb3J0X3N5c2NhbGxfZXhpdChyZWdzLCBzdGVwKTsNCj4gIH0NCj4N
CklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0
YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2Vu
ZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBv
dGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhl
IGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
