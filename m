Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DBBC4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:50:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F546218A5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="i2y4uR/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F546218A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LF6B0nB3zDqS5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 16:50:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=40.107.6.86; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=haibo.xu@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com
 header.b="i2y4uR/n"; dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60086.outbound.protection.outlook.com [40.107.6.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LF4Q6M24zDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 16:48:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcTHYIwfdzCP1n9Xjf0bawkIDerZavIFTyrWk05MS3g=;
 b=i2y4uR/nkuPG6tRLEA7zp8ecoUpJpOpt0qbDR16w5QNiRcXC5xyIvz3bVueq056haLlW9DUKyFqhtH98IMswXe1IpwYm7k3Gz0J9iTh6noScTtnoaNGjI/LXu7yUcLXYe4o01ffxvENj2zDJMglKxWgNw6gHIb9uujUf5Nw5x5U=
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com (10.171.190.138) by
 AM4PR08MB0738.eurprd08.prod.outlook.com (10.164.82.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 05:48:30 +0000
Received: from AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce]) by AM4PR08MB2929.eurprd08.prod.outlook.com
 ([fe80::e522:c03f:3d0c:f4ce%4]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 05:48:30 +0000
From: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Topic: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Thread-Index: AQHUz5P9ZKULSdDQbEW1h9vbYNE6xaX7KHCAgAAd14CAAQzrgIAKf6aAgAD7mAD//5MRgIAAmEsAgADYE4CAAjbMAIABPY4A
Date: Fri, 15 Mar 2019 05:48:30 +0000
Message-ID: <56f98a87-cc65-bcd7-3b98-606902355eeb@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
 <20190304101205.GA1504@e107155-lin>
 <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
 <20190311183403.GA31062@e107155-lin>
 <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
 <CALCETrWiF5FKUTmt4jOZJxJr6B_66NFj9TaA3Tnv1uorfkwTMg@mail.gmail.com>
 <20190312120944.GB13825@e107155-lin>
 <5750cfac-14a7-8eed-09f4-0d53419bea6b@arm.com>
 <20190314105143.GA15410@e107155-lin>
In-Reply-To: <20190314105143.GA15410@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM4PR08MB2929.eurprd08.prod.outlook.com
 (2603:10a6:205:c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Haibo.Xu@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50397097-73b7-421f-214d-08d6a909da6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM4PR08MB0738; 
x-ms-traffictypediagnostic: AM4PR08MB0738:
x-microsoft-antispam-prvs: <AM4PR08MB0738BA0F786E1CE27FF11D7585440@AM4PR08MB0738.eurprd08.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(376002)(346002)(39850400004)(396003)(189003)(199004)(40434004)(52116002)(76176011)(229853002)(4326008)(81166006)(25786009)(81156014)(8676002)(86362001)(6512007)(7416002)(6246003)(6862004)(305945005)(8936002)(7736002)(36756003)(6436002)(6486002)(93886005)(68736007)(6636002)(2906002)(186003)(53936002)(66066001)(5024004)(14454004)(71200400001)(6116002)(37006003)(54906003)(31696002)(14444005)(316002)(106356001)(105586002)(256004)(72206003)(5660300002)(3846002)(386003)(102836004)(55236004)(476003)(11346002)(31686004)(2616005)(53546011)(6506007)(26005)(478600001)(97736004)(486006)(99286004)(71190400001)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM4PR08MB0738;
 H:AM4PR08MB2929.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DMB0/4DtruBcAEvdmGJbS7ITe717mby6hYnpBtnXtek4kjTiSfNc/Kkp5bnhTHw5J/Sb3aSjfgMkDgfo/eS4R/lhccxYfi25eTWegtPlCGYrc6zE4QA0Pnbh0AoLppgPYfybVElyq0g3VKFhG4Cv5sGEsFZxkxZFDNQbJ0yNB24fEcJjJQYHA/ShhOhYHKlpd32unQaELtCRQSOqNJE+BHSoKrQN/9pudEiLlxXo0DCoQaAm0dZbXB6cDdPoboR5/yhR0Gbhg0NAGWMX7wN36KlgrNEUy9MAoLUViME7DYYhLK9FfXPh5Teeq3f9NDSyoGCqUQir1sNl0GzKY6O6pf2k/ZX835Ptkok/tC88UE57vSDMNuC2JhLVuAQ0HavA3HkdHPbrgJKXQdBncxu2nEHiwR4Nyvm/7A8TNlCNIIw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59661EB54CE9C04A8BAC8995E265776F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50397097-73b7-421f-214d-08d6a909da6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 05:48:30.6999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0738
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

T24gMjAxOS8zLzE0IDE4OjUxLCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+IE9uIFdlZCwgTWFyIDEz
LCAyMDE5IGF0IDAxOjAzOjE4QU0gKzAwMDAsIEhhaWJvIFh1IChBcm0gVGVjaG5vbG9neSBDaGlu
YSkgd3JvdGU6DQo+IFsuLi5dDQo+DQo+PiBTaW5jZSBwdHJhY2UoKSBzeXN0ZW0gY2FsbCBkbyBo
YXZlIHNvIG1hbnkgcmVxdWVzdCB0eXBlLCBJJ20gbm90IHN1cmUNCj4+IHdoZXRoZXIgdGhlIHRl
c3QgY2FzZXMgaGF2ZSBjb3ZlcmVkIGFsbCBvZiB0aGF0LiBCdXQgaGVyZSB3ZSdkIGJldHRlciBt
YWtlDQo+PiBzdXJlIHRoZSBQVFJBQ0VfU1lTRU1VIGFuZCBQVFJBQ0VfU1lTRU1VX1NJTkdMRVNU
RVAgcmVxdWVzdHMgYXJlIHdvcmsNCj4+IGNvcnJlY3RseS4gTWF5IGJlIHlvdSBjYW4gdmVyaWZ5
IHRoZW0gd2l0aCB0ZXN0cyBmcm9tIEJpbiBMdShiaW4ubHVAYXJtLmNvbSkuDQo+DQo+IFN1cmUg
aGFwcHkgdG8gdHJ5IHRoZW0uIENhbiB5b3UgcG9pbnQgbWUgdG8gdGhlbSA/DQo+IEkgZGlkIGVu
ZCB1cCB3cml0aW5nIGZldyBtb3JlIHRlc3RzLg0KPg0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBTdWRl
ZXANCj4NCg0KWW91IGNhbiBnZXQgdGhlbSBmcm9tIFN0ZXZlIENhcHBlci4gQlRXLCBJIGFsc28g
aGF2ZSBhIHByb2dyYW0gdG8gdmVyaWZ5IHRoZQ0KUFRSQUNFX1NZU0VNVSBmdW5jdGlvbiwgYW5k
IHdpbGwgc2VuZCB0byB5b3UgaW4gYSBzZXBhcmF0ZSBlbWFpbCBsb29wLg0KDQpSZWdhcmRzLA0K
SGFpYm8NCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBh
bnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdl
ZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRv
IGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNv
cHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
