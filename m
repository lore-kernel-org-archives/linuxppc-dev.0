Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAC5C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:36:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696982084F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DPU9JSEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696982084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JHdP24PyzDqGT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 12:36:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=40.107.0.78; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=haibo.xu@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com
 header.b="DPU9JSEW"; dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00078.outbound.protection.outlook.com [40.107.0.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JHbM2M5xzDq6J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 12:35:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtxqqtMg0mtNwODkrTI4yLRXkpzI+Ahn54L9/mLVH28=;
 b=DPU9JSEWJMq3Zf0F/9XWBz7+QoBMHffDk0O1VPiRmgm7nCyO8vwTL/raDXLRQD8Rg3P6rU+//1jBH1j/fWdN75t90J0PnwDjsUOFWLkvaKZo06D2Y82CsYVgymPswS8+YzJQ01D7mfUeDgmUGtEjcQf/uRMf/Nfw+OWNCzOAjNM=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.190.138) by
 AM4PR08MB0755.eurprd08.prod.outlook.com (10.164.82.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 01:34:44 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce%4]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 01:34:44 +0000
From: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Topic: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Index: AQHUz5P9ZKULSdDQbEW1h9vbYNE6xaX7KHCAgAAd14CAAQzrgIAKf6aAgAB1ewA=
Date: Tue, 12 Mar 2019 01:34:44 +0000
Message-ID: <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
 <20190304101205.GA1504@e107155-lin>
 <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
 <20190311183403.GA31062@e107155-lin>
In-Reply-To: <20190311183403.GA31062@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0011.apcprd03.prod.outlook.com
 (2603:1096:202::21) To AM4PR08MB2929.eurprd08.prod.outlook.com
 (2603:10a6:205:c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fef0931c-6e28-422a-8e2a-08d6a68ae7b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM4PR08MB0755; 
x-ms-traffictypediagnostic: AM4PR08MB0755:
x-microsoft-exchange-diagnostics: 1; AM4PR08MB0755;
 20:sa024CKCUP9ygamxCffnfnGzSUtIY6f71NbBS4cbExAALXdZzTEpUU3Jitcezf+FfwuyPYzDTZSK4GN3ZxKURSyQPZCBUYwPcsbg5NXGw71hzJtEV5FwMexLVgPh584dZJyHQ7uRvse+zsef87zDGz9FJVKv2pgDm/HAnl1Nnh8=
x-microsoft-antispam-prvs: <AM4PR08MB07550371EA02A78BD313F3BE85490@AM4PR08MB0755.eurprd08.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(40434004)(52116002)(6506007)(386003)(71200400001)(99286004)(6636002)(76176011)(71190400001)(8936002)(53936002)(31686004)(229853002)(186003)(53546011)(6486002)(478600001)(72206003)(6436002)(6512007)(14454004)(256004)(26005)(55236004)(5024004)(14444005)(102836004)(7736002)(305945005)(25786009)(36756003)(4326008)(81156014)(81166006)(31696002)(8676002)(3846002)(6862004)(7416002)(68736007)(86362001)(5660300002)(106356001)(486006)(2616005)(11346002)(316002)(446003)(6116002)(105586002)(6246003)(476003)(37006003)(97736004)(54906003)(93886005)(2906002)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR08MB0755;
 H:AM4PR08MB2929.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pEbiBfy7XcTMnKLK49xK9k03MxcDh+YzEFQsi4oQMddSssaIJp8zO2sb9H4KfM/KY5nC2SPtKVi4PBGkqWLIUW5PhP2oDqU2fJrPGJRLI7Mzd/hLwLqxO/Fcx3Qge7O8UQ3z3UyvJpEjglEdb+WiJUjPcEFLL7dG65Mx3um2d5bacDhDYQ1S5ZFqqq9wWd7xJNvTmUf6796hOlIoEJbUdsyR41MPz7eOtt+piXppZ4j3qmjrXokeZw1Oj5e506F90pAromPcgwy+h7jOMTNzdsF6PCjEjvhn9E3YZLUy781TgLOsllt6WKJ/hOKcVE6zlB5Uib3qnEg4G5hKZvbviXauGomKzBSAoRTPm8PGsFLGghf0ajj0mZ9KygXHrxZbdGvnigmpCruw4YZKD4uZKqB2aZVqr1zkufLB2RuysdQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57866709C2BE224FA97105DAF41E7E6A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef0931c-6e28-422a-8e2a-08d6a68ae7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 01:34:44.4617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0755
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
 "jdike@addtoit.com" <jdike@addtoit.com>, "x86@kernel.org" <x86@kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bin Lu \(Arm Technology China\)" <Bin.Lu@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMjAxOS8zLzEyIDI6MzQsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gKEkgdGhvdWdodCBJIGhh
ZCBzZW50IHRoaXMgZW1haWwsIGxhc3QgVHVlc2RheSBpdHNlbGYsIGJ1dCBzYXcgdGhpcyBpbiBt
eQ0KPiBkcmFmdCB0b2RheSwgc29tZXRoaW5nIHdlbnQgd3JvbmcsIHNvcnJ5IGZvciB0aGUgZGVs
YXkpDQo+DQo+IE9uIFR1ZSwgTWFyIDA1LCAyMDE5IGF0IDAyOjE0OjQ3QU0gKzAwMDAsIEhhaWJv
IFh1IChBcm0gVGVjaG5vbG9neSBDaGluYSkgd3JvdGU6DQo+PiBPbiAyMDE5LzMvNCAxODoxMiwg
U3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+IE9uIE1vbiwgTWFyIDA0LCAyMDE5IGF0IDA4OjI1OjI4
QU0gKzAwMDAsIEhhaWJvIFh1IChBcm0gVGVjaG5vbG9neSBDaGluYSkgd3JvdGU6DQo+Pj4+IE9u
IDIwMTkvMy8xIDI6MzIsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+Pj4+IE5vdyB0aGF0IHdlIGhh
dmUgYSBuZXcgaG9vayBwdHJhY2Vfc3lzY2FsbF9lbnRlciB0aGF0IGNhbiBiZSBjYWxsZWQgZnJv
bQ0KPj4+Pj4gc3lzY2FsbCBlbnRyeSBjb2RlIGFuZCBpdCBoYW5kbGVzIFBUUkFDRV9TWVNFTVUg
aW4gZ2VuZXJpYyBjb2RlLCB3ZQ0KPj4+Pj4gY2FuIGRvIHNvbWUgY2xlYW51cCB1c2luZyB0aGUg
c2FtZSBpbiBzeXNjYWxsX3RyYWNlX2VudGVyLg0KPj4+Pj4NCj4+Pj4+IEZ1cnRoZXIgdGhlIGV4
dHJhIGxvZ2ljIHRvIGZpbmQgc2luZ2xlIHN0ZXBwaW5nIFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RF
UA0KPj4+Pj4gaW4gc3lzY2FsbF9zbG93X2V4aXRfd29yayBzZWVtcyB1bm5lY2Vzc2FyeS4gTGV0
J3MgcmVtb3ZlIHRoZSBzYW1lLg0KPj4+Pg0KPj4+PiBJIHRoaW5rIHdlIHNob3VsZCBub3QgY2hh
bmdlIHRoZSBsb2dpYyBoZXJlLiBJcyBzbywgaXQgd2lsbCBkb3VibGUgdGhlIHJlcG9ydCBvZiBz
eXNjYWxsDQo+Pj4+IHdoZW4gUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIGlzIGVuYWJsZWQuDQo+
Pj4+DQo+Pj4NCj4+PiBJIGRvbid0IHRoaW5rIHRoYXQgc2hvdWxkIGhhcHBlbiwgYnV0IEkgbWF5
IGJlIG1pc3Npbmcgc29tZXRoaW5nLg0KPj4+IENhbiB5b3UgZXhwbGFpbiBob3cgPw0KPj4+DQo+
Pg0KPj4gV2hlbiBQVFJBQ0VfU1lTRU1VX1NJTkdMRVNURVAgaXMgZW5hYmxlZCwgYm90aCB0aGUg
X1RJRl9TWVNDQUxMX0VNVSBhbmQNCj4+IF9USUZfU0lOR0xFU1RFUCBmbGFncyBhcmUgc2V0LCBi
dXQgcHRyYWNlIG9ubHkgbmVlZCB0byByZXBvcnQoc2VuZCBTSUdUUkFQKQ0KPj4gYXQgdGhlIGVu
dHJ5IG9mIGEgc3lzdGVtIGNhbGwsIG5vIG5lZWQgdG8gcmVwb3J0IGF0IHRoZSBleGl0IG9mIGEg
c3lzdGVtDQo+PiBjYWxsLg0KPj4NCj4gU29ycnksIGJ1dCBJIHN0aWxsIG5vdCBnZXQgaXQsIHdl
IGhhdmU6DQo+DQo+IHN0ZXAgPSAoKGZsYWdzICYgKF9USUZfU0lOR0xFU1RFUCB8IF9USUZfU1lT
Q0FMTF9FTVUpKSA9PSBfVElGX1NJTkdMRVNURVApOw0KPg0KPiBGb3IgbWUsIHRoaXMgaXMgc2Ft
ZSBhczoNCj4gc3RlcCA9ICgoZmxhZ3MgJiBfVElGX1NJTkdMRVNURVApID09IF9USUZfU0lOR0xF
U1RFUCkNCj4gb3INCj4gaWYgKGZsYWdzICYgX1RJRl9TSU5HTEVTVEVQKQ0KPiBzdGVwID0gdHJ1
ZTsNCj4NCg0KSSBkb24ndCB0aGluayBzbyEgQXMgSSBtZW50aW9uZWQgaW4gdGhlIGxhc3QgZW1h
aWwgbG9vcCwgd2hlbiBQVFJBQ0VfU1lTRU1VX1NJTkdMRVNURVANCmlzIGVuYWJsZWQsIGJvdGgg
dGhlIF9USUZfU1lTQ0FMTF9FTVUgYW5kIF9USUZfU0lOR0xFU1RFUCBmbGFncyBhcmUgc2V0LCBp
biB3aGljaCBjYXNlDQp0aGUgc3RlcCBzaG91bGQgYmUgImZhbHNlIiBmb3IgdGhlIG9sZCBsb2dp
Yy4gQnV0IHdpdGggdGhlIG5ldyBsb2dpYywgdGhlIHN0ZXAgaXMgInRydWUiLg0KDQo+IFNvIHdo
ZW4gUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQLCBfVElGX1NZU0NBTExfRU1VIGFuZCBfVElGX1NJ
TkdMRVNURVANCj4gYXJlIHNldCBhbmQgc3RlcCBldmFsdWF0ZXMgdG8gdHJ1ZS4NCj4NCj4gU28g
ZHJvcHBpbmcgX1RJRl9TWVNDQUxMX0VNVSBoZXJlIHNob3VsZCBiZSBmaW5lLiBBbSBJIHN0aWxs
IG1pc3NpbmcNCj4gc29tZXRoaW5nID8NCj4NCj4gLS0NCj4gUmVnYXJkcywNCj4gU3VkZWVwDQo+
DQoNCkZvciB0aGUgUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIHJlcXVlc3QsIHB0cmFjZSBvbmx5
IG5lZWQgdG8gcmVwb3J0KHNlbmQgU0lHVFJBUCkNCmF0IHRoZSBlbnRyeSBvZiBhIHN5c3RlbSBj
YWxsLCBubyBuZWVkIHRvIHJlcG9ydCBhdCB0aGUgZXhpdCBvZiBhIHN5c3RlbSBjYWxsLlRoYXQn
cw0Kd2h5IHRoZSBvbGQgbG9naWMte3N0ZXAgPSAoKGZsYWdzICYgKF9USUZfU0lOR0xFU1RFUCB8
IF9USUZfU1lTQ0FMTF9FTVUpKSA9PSBfVElGX1NJTkdMRVNURVApfQ0KaGVyZSB0cnkgdG8gZmls
dGVyIG91dCB0aGUgc3BlY2lhbCBjYXNlKFBUUkFDRV9TWVNFTVVfU0lOR0xFU1RFUCkuDQoNCkFu
b3RoZXIgd2F5IHRvIG1ha2Ugc3VyZSB0aGUgbG9naWMgaXMgZmluZSwgeW91IGNhbiBydW4gc29t
ZSB0ZXN0cyB3aXRoIHJlc3BlY3QgdG8gYm90aCBsb2dpYywNCmFuZCB0byBjaGVjayB3aGV0aGVy
IHRoZXkgaGF2ZSB0aGUgc2FtZSBiZWhhdmlvci4NCg0KUmVnYXJkcywNCg0KSGFpYm8NCklNUE9S
VEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVu
dHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGlt
bWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBw
ZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9y
bWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
