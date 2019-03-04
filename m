Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73965C4360F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 09:38:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA626208E4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 09:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="N5xrQSqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA626208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CZhV2P5tzDqGh
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 20:38:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=40.107.14.71; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=haibo.xu@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com
 header.b="N5xrQSqv"; dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140071.outbound.protection.outlook.com [40.107.14.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CZfZ03flzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 20:36:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix6PL2RLxmEElZZBfefBkcCi+qQCg4mBO8ebmVZgUZs=;
 b=N5xrQSqvEFIhIyFgOxGoWURhivJaHKOAKtzrymRkh9A9SThssEhp+Gdhenm1T5cno1CoMd/O3GmIAUC2nCnqgNARGx6RFiGfadpm9b9GVrEqpvFVeEgr9+XkfXvS7pWxIp0Eh//5jnrPhXonPOhDMSvYKJsD0vh5mAhLrQwYBrY=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.190.138) by
 AM4PR08MB0914.eurprd08.prod.outlook.com (10.166.133.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Mon, 4 Mar 2019 09:36:27 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 09:36:27 +0000
From: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Thread-Topic: [PATCH 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Thread-Index: AQHUz5QAshJAlHpcr0CXdooSV3Nef6X7PESA
Date: Mon, 4 Mar 2019 09:36:27 +0000
Message-ID: <247371ae-3360-95e2-bf1d-21eb9332c31c@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-5-sudeep.holla@arm.com>
In-Reply-To: <20190228183220.15626-5-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To AM4PR08MB2929.eurprd08.prod.outlook.com
 (2603:10a6:205:c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 927f047c-9517-4e2b-da14-08d6a084dfe7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM4PR08MB0914; 
x-ms-traffictypediagnostic: AM4PR08MB0914:
x-microsoft-exchange-diagnostics: 1; AM4PR08MB0914;
 20:ZDpqkHrYV8lc9DYu9Fm3nQ3CRk/Ppv/PAhrSDMWoA5ad7zMKWa6CyPiqNyCBJz/WCt6xF3f50vrrLDUdk64pTsZK16lJ+z1YXO+TYYnWWjjb2Xer7HjnfsWylBLl5Un5CtB4oS3VtQBZwWCjHX0kkzTSJjzddxMbHScXet3VIN0=
x-microsoft-antispam-prvs: <AM4PR08MB0914E074B2F2605E969B041B85710@AM4PR08MB0914.eurprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(376002)(366004)(39860400002)(199004)(189003)(40434004)(76176011)(6346003)(81156014)(305945005)(81166006)(8676002)(31696002)(97736004)(7736002)(52116002)(105586002)(386003)(6506007)(53546011)(4326008)(31686004)(106356001)(229853002)(2616005)(316002)(68736007)(55236004)(86362001)(102836004)(486006)(11346002)(476003)(446003)(2201001)(8936002)(25786009)(66066001)(7416002)(186003)(6486002)(6436002)(14444005)(5024004)(6246003)(71200400001)(71190400001)(54906003)(110136005)(2906002)(6116002)(3846002)(256004)(5660300002)(99286004)(478600001)(36756003)(2501003)(6512007)(72206003)(14454004)(53936002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR08MB0914;
 H:AM4PR08MB2929.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EMZVIm1a3RqedGhTxr8HaLe5WM81CLwLfiQwns/c2+8fwcsGF+0a1lv98hdsJ1Z2NtStjBQHuCMVrq+9wUCV1LyVHWayFlHO+GOy4fe34ESEZj98Ssm8BCq89D+znNfBpCCx0jRXC/L6+uk2J15ro6hwRN/51NUpO8aapQdoRveh/bmqRt/HhKl2z7mw/o+th6KR9SOQFlVgq/2qgFKLKuhFxR/pIcIvyblNYX6WXM38MeCkWme9dK10eNBUo8kbZ0KINelgCwzRA5eh3thDFsQ+mQSb66TJcbD/kaxQQFGmWSCdIqBlAc0r0sBjeJfFEy91lPGeCVNkXAFNk2YUCL676Y84OHr+AKSdMkJzpbxFe5V2t8lVchO78i9/h05PCWbFkYbAwMUIBKIqit89JiMSZaMWUGrqhUc6QXbY7hE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64CA2990D7904E4A9DCD3B1E0C8401F3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927f047c-9517-4e2b-da14-08d6a084dfe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 09:36:27.7278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0914
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

T24gMjAxOS8zLzEgMjozMiwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBOb3cgdGhhdCB3ZSBoYXZl
IGEgbmV3IGhvb2sgcHRyYWNlX3N5c2NhbGxfZW50ZXIgdGhhdCBjYW4gYmUgY2FsbGVkIGZyb20N
Cj4gc3lzY2FsbCBlbnRyeSBjb2RlIGFuZCBpdCBoYW5kbGVzIFBUUkFDRV9TWVNFTVUgaW4gZ2Vu
ZXJpYyBjb2RlLCB3ZQ0KPiBjYW4gZG8gc29tZSBjbGVhbnVwIHVzaW5nIHRoZSBzYW1lIGluIGRv
X3N5c2NhbGxfdHJhY2VfZW50ZXIuDQo+DQo+IENjOiBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhh
dC5jb20+DQo+IENjOiBQYXVsIE1hY2tlcnJhcyA8cGF1bHVzQHNhbWJhLm9yZz4NCj4gQ2M6IE1p
Y2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4NCj4gU2lnbmVkLW9mZi1ieTogU3Vk
ZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3Bvd2VycGMv
a2VybmVsL3B0cmFjZS5jIHwgNTAgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMva2VybmVsL3B0cmFjZS5jIGIvYXJjaC9wb3dl
cnBjL2tlcm5lbC9wdHJhY2UuYw0KPiBpbmRleCBjYjdlMTQzOWNhZmIuLjk3OGNkMmFhYzI5ZSAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9wdHJhY2UuYw0KPiArKysgYi9hcmNo
L3Bvd2VycGMva2VybmVsL3B0cmFjZS5jDQo+IEBAIC0zMjY0LDM3ICszMjY0LDMxIEBAIGxvbmcg
ZG9fc3lzY2FsbF90cmFjZV9lbnRlcihzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gIHsNCj4gIHUz
MiBmbGFnczsNCj4NCj4gLXVzZXJfZXhpdCgpOw0KDQpXZSdkIGJldHRlciBrZWVwIHRoZSB1c2Vy
X2V4aXQoKSBhdCBoZXJlIGluIGNhc2UgYm90aCBjb250ZXh0IHRyYWNraW5nIGFuZCBTWVNDQUxM
X0VNVQ0KYXJlIGVuYWJsZWQuDQoNCj4gLQ0KPiAtZmxhZ3MgPSBSRUFEX09OQ0UoY3VycmVudF90
aHJlYWRfaW5mbygpLT5mbGFncykgJg0KPiAtKF9USUZfU1lTQ0FMTF9FTVUgfCBfVElGX1NZU0NB
TExfVFJBQ0UpOw0KPiAraWYgKHVubGlrZWx5KHB0cmFjZV9zeXNjYWxsX2VudGVyKHJlZ3MpKSkg
ew0KPiArLyoNCj4gKyAqIEEgbm9uemVybyByZXR1cm4gY29kZSBmcm9tIHRyYWNlaG9va19yZXBv
cnRfc3lzY2FsbF9lbnRyeSgpDQo+ICsgKiB0ZWxscyB1cyB0byBwcmV2ZW50IHRoZSBzeXNjYWxs
IGV4ZWN1dGlvbiwgYnV0IHdlIGFyZSBub3QNCj4gKyAqIGdvaW5nIHRvIGV4ZWN1dGUgaXQgYW55
d2F5Lg0KPiArICoNCj4gKyAqIFJldHVybmluZyAtMSB3aWxsIHNraXAgdGhlIHN5c2NhbGwgZXhl
Y3V0aW9uLiBXZSB3YW50IHRvDQo+ICsgKiBhdm9pZCBjbG9iYmVyaW5nIGFueSByZWdpc3RlcnMs
IHNvIHdlIGRvbid0IGdvdG8gdGhlIHNraXANCj4gKyAqIGxhYmVsIGJlbG93Lg0KPiArICovDQo+
ICtyZXR1cm4gLTE7DQo+ICt9DQo+DQo+IC1pZiAoZmxhZ3MpIHsNCj4gLWludCByYyA9IHRyYWNl
aG9va19yZXBvcnRfc3lzY2FsbF9lbnRyeShyZWdzKTsNCj4gK3VzZXJfZXhpdCgpOw0KPg0KPiAt
aWYgKHVubGlrZWx5KGZsYWdzICYgX1RJRl9TWVNDQUxMX0VNVSkpIHsNCj4gLS8qDQo+IC0gKiBB
IG5vbnplcm8gcmV0dXJuIGNvZGUgZnJvbQ0KPiAtICogdHJhY2Vob29rX3JlcG9ydF9zeXNjYWxs
X2VudHJ5KCkgdGVsbHMgdXMgdG8gcHJldmVudA0KPiAtICogdGhlIHN5c2NhbGwgZXhlY3V0aW9u
LCBidXQgd2UgYXJlIG5vdCBnb2luZyB0bw0KPiAtICogZXhlY3V0ZSBpdCBhbnl3YXkuDQo+IC0g
Kg0KPiAtICogUmV0dXJuaW5nIC0xIHdpbGwgc2tpcCB0aGUgc3lzY2FsbCBleGVjdXRpb24uIFdl
IHdhbnQNCj4gLSAqIHRvIGF2b2lkIGNsb2JiZXJpbmcgYW55IHJlZ2lzdGVycywgc28gd2UgZG9u
J3QgZ290bw0KPiAtICogdGhlIHNraXAgbGFiZWwgYmVsb3cuDQo+IC0gKi8NCj4gLXJldHVybiAt
MTsNCj4gLX0NCj4gK2ZsYWdzID0gUkVBRF9PTkNFKGN1cnJlbnRfdGhyZWFkX2luZm8oKS0+Zmxh
Z3MpICYgX1RJRl9TWVNDQUxMX1RSQUNFOw0KPg0KPiAtaWYgKHJjKSB7DQo+IC0vKg0KPiAtICog
VGhlIHRyYWNlciBkZWNpZGVkIHRvIGFib3J0IHRoZSBzeXNjYWxsLiBOb3RlIHRoYXQNCj4gLSAq
IHRoZSB0cmFjZXIgbWF5IGFsc28ganVzdCBjaGFuZ2UgcmVncy0+Z3ByWzBdIHRvIGFuDQo+IC0g
KiBpbnZhbGlkIHN5c2NhbGwgbnVtYmVyLCB0aGF0IGlzIGhhbmRsZWQgYmVsb3cgb24gdGhlDQo+
IC0gKiBleGl0IHBhdGguDQo+IC0gKi8NCj4gLWdvdG8gc2tpcDsNCj4gLX0NCj4gK2lmIChmbGFn
cyAmJiB0cmFjZWhvb2tfcmVwb3J0X3N5c2NhbGxfZW50cnkocmVncykpIHsNCj4gKy8qDQo+ICsg
KiBUaGUgdHJhY2VyIGRlY2lkZWQgdG8gYWJvcnQgdGhlIHN5c2NhbGwuIE5vdGUgdGhhdA0KPiAr
ICogdGhlIHRyYWNlciBtYXkgYWxzbyBqdXN0IGNoYW5nZSByZWdzLT5ncHJbMF0gdG8gYW4NCj4g
KyAqIGludmFsaWQgc3lzY2FsbCBudW1iZXIsIHRoYXQgaXMgaGFuZGxlZCBiZWxvdyBvbiB0aGUN
Cj4gKyAqIGV4aXQgcGF0aC4NCj4gKyAqLw0KPiArZ290byBza2lwOw0KPiAgfQ0KPg0KPiAgLyog
UnVuIHNlY2NvbXAgYWZ0ZXIgcHRyYWNlOyBhbGxvdyBpdCB0byBzZXQgZ3ByWzNdLiAqLw0KPg0K
SU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5
b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90
aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUg
aW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
