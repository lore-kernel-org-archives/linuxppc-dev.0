Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9591C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 02:16:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C06206B8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 02:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LmJAOqSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C06206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44D0rd3qSczDqFH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 13:16:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=40.107.13.48; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=haibo.xu@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com
 header.b="LmJAOqSm"; dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130048.outbound.protection.outlook.com [40.107.13.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44D0pR13n9zDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 13:14:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYcxCBdsHjG1vMeGCzuGTn2kYlKozvKDHqJn8Sst4Jo=;
 b=LmJAOqSm1N2eWAMrGHZsUt1XcB3eb0v46grqAxg3AA/Y0DpZrosGE8B9Q4SuLb0ySvCG3FXE4564tz0HKDfYGQ9U4foi34WD+mnpKIONkMqJQj2Pg5DWKlVcUF/ARfJ+waXMT5Z2QuY/8Fhfrd8eeKnxAYmMSVmRP6EUu2qWkos=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.190.138) by
 AM4PR08MB1233.eurprd08.prod.outlook.com (10.167.92.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 02:14:47 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce%4]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 02:14:47 +0000
From: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Topic: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Index: AQHUz5P9ZKULSdDQbEW1h9vbYNE6xaX7KHCAgAAd14CAAQzrgA==
Date: Tue, 5 Mar 2019 02:14:47 +0000
Message-ID: <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
 <20190304101205.GA1504@e107155-lin>
In-Reply-To: <20190304101205.GA1504@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::19) To AM4PR08MB2929.eurprd08.prod.outlook.com
 (2603:10a6:205:c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9eb89f9-86d9-476c-520b-08d6a1105712
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM4PR08MB1233; 
x-ms-traffictypediagnostic: AM4PR08MB1233:
x-microsoft-exchange-diagnostics: 1; AM4PR08MB1233;
 20:MJditFq3MlIdGxq7d4s3xdvbXB4p0S+K3ivSkGcFUM0NvKi1NkaY/q6A9AH/UmsPFUAoR/tsicars5a2XG5FZHF1bSLrNx4/z/MmGgC7DmPgoKsOZXwqIQE5WCdLEGS7pL1eZgkuXxIxDpojuK1/iG7Be4jpntJXoX3fiW5se3E=
x-microsoft-antispam-prvs: <AM4PR08MB1233A9031EB0C0E126F824E485720@AM4PR08MB1233.eurprd08.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(40434004)(76176011)(97736004)(7736002)(6862004)(229853002)(102836004)(55236004)(6486002)(186003)(52116002)(305945005)(66066001)(72206003)(71190400001)(6512007)(53546011)(6246003)(26005)(386003)(6506007)(8676002)(71200400001)(4326008)(6436002)(53936002)(81166006)(93886005)(81156014)(5660300002)(36756003)(446003)(6636002)(8936002)(478600001)(14454004)(7416002)(2906002)(105586002)(31686004)(5024004)(14444005)(31696002)(6116002)(256004)(54906003)(486006)(316002)(86362001)(106356001)(476003)(25786009)(11346002)(3846002)(99286004)(37006003)(2616005)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR08MB1233;
 H:AM4PR08MB2929.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lpq3QGKD/d+Nl3LL4LEP3XUuw5I2c8ApRLpvttCWev8x9vKjFOKZ4ENxt0YJveNpobls07/K/6ZaQF6QOG+x3Mh3I7veUjmv8S/iMI4th6+1jhkv4J9gVsfeob+ucAql+X+hXBrjWMoI2xcxGAkT3pfTE7BVkk0W1yCTVXv/uMCnUEJrIylM/fFT4NnKPTeslBA7wjFyav0OyQ7l2OpTWw8gGx1O7EsOeedaQZwzoyuQGU2MxqfykF+LmysotqsVxYdD5tDCwF77eSHgVviNhmSRjRL/yyB0YfDkR3JzDG0P6XFZDSTR2lnYBmYcCJg+jtStBVoTuVkr34o4vBtzkP6Q1uxejb31jj3/YyX49zCtWBi/8531e4UY8low7u7FW2fnLeo8kITCF91nM63aImZRiSiP99om+upWL/L+94I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12D581F16842104093AC565798259132@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eb89f9-86d9-476c-520b-08d6a1105712
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 02:14:47.4652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB1233
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

T24gMjAxOS8zLzQgMTg6MTIsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gTW9uLCBNYXIgMDQs
IDIwMTkgYXQgMDg6MjU6MjhBTSArMDAwMCwgSGFpYm8gWHUgKEFybSBUZWNobm9sb2d5IENoaW5h
KSB3cm90ZToNCj4+IE9uIDIwMTkvMy8xIDI6MzIsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+PiBO
b3cgdGhhdCB3ZSBoYXZlIGEgbmV3IGhvb2sgcHRyYWNlX3N5c2NhbGxfZW50ZXIgdGhhdCBjYW4g
YmUgY2FsbGVkIGZyb20NCj4+PiBzeXNjYWxsIGVudHJ5IGNvZGUgYW5kIGl0IGhhbmRsZXMgUFRS
QUNFX1NZU0VNVSBpbiBnZW5lcmljIGNvZGUsIHdlDQo+Pj4gY2FuIGRvIHNvbWUgY2xlYW51cCB1
c2luZyB0aGUgc2FtZSBpbiBzeXNjYWxsX3RyYWNlX2VudGVyLg0KPj4+DQo+Pj4gRnVydGhlciB0
aGUgZXh0cmEgbG9naWMgdG8gZmluZCBzaW5nbGUgc3RlcHBpbmcgUFRSQUNFX1NZU0VNVV9TSU5H
TEVTVEVQDQo+Pj4gaW4gc3lzY2FsbF9zbG93X2V4aXRfd29yayBzZWVtcyB1bm5lY2Vzc2FyeS4g
TGV0J3MgcmVtb3ZlIHRoZSBzYW1lLg0KPj4NCj4+IEkgdGhpbmsgd2Ugc2hvdWxkIG5vdCBjaGFu
Z2UgdGhlIGxvZ2ljIGhlcmUuIElzIHNvLCBpdCB3aWxsIGRvdWJsZSB0aGUgcmVwb3J0IG9mIHN5
c2NhbGwNCj4+IHdoZW4gUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIGlzIGVuYWJsZWQuDQo+Pg0K
Pg0KPiBJIGRvbid0IHRoaW5rIHRoYXQgc2hvdWxkIGhhcHBlbiwgYnV0IEkgbWF5IGJlIG1pc3Np
bmcgc29tZXRoaW5nLg0KPiBDYW4geW91IGV4cGxhaW4gaG93ID8NCj4NCj4gLS0NCj4gUmVnYXJk
cywNCj4gU3VkZWVwDQo+DQoNCldoZW4gUFRSQUNFX1NZU0VNVV9TSU5HTEVTVEVQIGlzIGVuYWJs
ZWQsIGJvdGggdGhlIF9USUZfU1lTQ0FMTF9FTVUgYW5kIF9USUZfU0lOR0xFU1RFUA0KZmxhZ3Mg
YXJlIHNldCwgYnV0IHB0cmFjZSBvbmx5IG5lZWQgdG8gcmVwb3J0KHNlbmQgU0lHVFJBUCkgYXQg
dGhlIGVudHJ5IG9mIGEgc3lzdGVtIGNhbGwsDQpubyBuZWVkIHRvIHJlcG9ydCBhdCB0aGUgZXhp
dCBvZiBhIHN5c3RlbSBjYWxsLg0KDQpSZWdhcmRzLA0KSGFpYm8NCklNUE9SVEFOVCBOT1RJQ0U6
IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZp
ZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFu
ZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBp
dCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFu
eSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
