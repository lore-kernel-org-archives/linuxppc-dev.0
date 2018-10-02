Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546AFC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:31:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59182089A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rlj8JBWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59182089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PTp251yrzF3HJ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 16:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="rlj8JBWT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1f::621;
 helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="rlj8JBWT"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PTkY2h2BzF3J3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 16:28:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E75jhxHKXv9cG7z1ulJOAPZn5qW2nAxmIWD4xPW3DyE=;
 b=rlj8JBWTW1b3hunf3WCCNces4xRTiwTe3IyKRNrXL4KGV1Kj52yF/PwFR+dTl4eztcAVrlXe3Dcv1LbkIhtSuQmwPJiYVhw9YW8ilHz7WXD758FCLdmahRhvAzcHuSkCXaLIww9d8noq8PmnLNZebzmKMmJYeAm45qWFBTFVn8g=
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) by
 AM6PR04MB4488.eurprd04.prod.outlook.com (20.176.242.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Tue, 2 Oct 2018 06:28:46 +0000
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::2806:3ebb:e234:4123]) by AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::2806:3ebb:e234:4123%2]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 06:28:46 +0000
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
Thread-Topic: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
Thread-Index: AQHUVwdgDacU02VI+UOhvhbmgV0ZkKUK/oSAgACEtrA=
Date: Tue, 2 Oct 2018 06:28:46 +0000
Message-ID: <AM6PR04MB40080234BA68140933F6B733ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com>
In-Reply-To: <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4488;
 6:7ppeGJieCsaSlV7uFWTK7LUkANjs9jJhPq57oeT+c1n2Nl1UtznzOtqyf9C7byOjo9wsNXoAqOSZoejF09gz7n+4wTfG1TDpKJFhHVDhQPQv24PR4Gyj3ilo2Tl6d92/dxY5VA6pIurb4H99iijRP1TnX8BHrPTD5NSxqdjxgIMktzk69C324DXacHfhHbykbnJ8Rqy2/fJ7pmK98c6IM6keSUHLeaeVTial9mXFZG7/w5/Mw0cYkyjbxBE3oBbfwx8q89bglKSwS+H0L0ZGieIL552UX8IextRf4IUeT+PHYSCQdiBUbNu/33Ch8cRVHMjMM0DjE3xbYnnDRya9yg0Na1K7t4ilQlWaiA/O8Tqkl8JMErDw5fTvSMR7sJjLzA/RRdDkbjhg40Kv11JIHqd4R1pVBqk76GP/t//BQyD335jD5zm4PxzvjfdcIi4J7k5Ex2locWheJ/3qSoS6pA==;
 5:O4gdzbzCEoMtwHBKhX+DRUuaMkWlfTf7+4ahJREV1vsEEgCxy7JydR8hgaaVX86YWzbBZyRGLN2CCa9GkzJtfkeuXeLQ6Y8/ZSY51rn47kdw+lc3a3QI6MhSjImpPjW53tEJr/vOKiIzewH900o+srgsV89vzvbFAfoqGLqi0Lg=;
 7:SmxriHax7/durLaJS2yzplaHM791CAAZomtYe59ztKdMHaMLHlxb08XJWU2PhPNfzg1l9j0++GLQisCmsHzejx4tmv0D6yNG/RJfEPXGSnSQ9WMGvF7dyYk+XydXyDt0XJuSEWFVm/g/FEWnI8OriKMldKfqoZBcpQ9U+rAC8+Ge2IMt2ZlZTVXNZOBjOPMo0eN3Wst6TzjFTar3ny6Eo5bPBr7BWu0WMqGywxQuVFf/+FrU8EafHolG9y5vRRvu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f8bfaa69-dc23-4b7e-d6b6-08d628304e9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4488; 
x-ms-traffictypediagnostic: AM6PR04MB4488:
x-microsoft-antispam-prvs: <AM6PR04MB4488B8A78F3C09DBBAF08974ECE80@AM6PR04MB4488.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(180628864354917)(258649278758335)(65623756079841)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);
 SRVR:AM6PR04MB4488; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4488; 
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(13464003)(199004)(189003)(7696005)(54906003)(74316002)(478600001)(99286004)(6506007)(53546011)(2900100001)(316002)(102836004)(229853002)(55016002)(8676002)(25786009)(76176011)(81156014)(5250100002)(33656002)(14454004)(68736007)(8936002)(81166006)(6862004)(86362001)(476003)(66066001)(9686003)(7736002)(5660300001)(6436002)(6246003)(106356001)(2906002)(446003)(6636002)(26005)(71200400001)(97736004)(4326008)(305945005)(3846002)(53936002)(11346002)(71190400001)(6116002)(105586002)(256004)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4488;
 H:AM6PR04MB4008.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KJEWu9FcgIlx7603YspIFhdxjn0Eb3RlEg6hyTUZuyZHvhkG+E9uJBiUriPXlS8J318u/4aapS+Bl1xhsNQCWaCdS7XfncLtItQkMfrUAivh73kEOY7vln9leiX179aitRyHecwqw8VyzmvGjM+MKrLvZrEKeO4ikG18IO3YsbLWXxrikb3sxjmYODEQmNzvt2WMSqPs58PIazD4Pn+h4Ze7UQG9aBxB4nE/sZXwGHphmIaWTaUn/3Qjt+AX4rkFKHr+yy03H2JxzLyntSVpHC5iOirElifwojBOBy7Kgm8V8a7HzIJt/NYisc9CteYFUfC6IXdKxuvEve79DqL60BKSx0pwMxuvTE+WqhBPCug=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bfaa69-dc23-4b7e-d6b6-08d628304e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 06:28:46.0983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4488
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Roy Pledge <roy.pledge@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>, Scott Wood <oss@buserror.net>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaSBZYW5nIFttYWlsdG86bGVv
eWFuZy5saUBueHAuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIsIDIwMTggMTozMCBB
TQ0KPiBUbzogTWFkYWxpbi1jcmlzdGlhbiBCdWN1ciA8bWFkYWxpbi5idWN1ckBueHAuY29tPg0K
PiBDYzogUm95IFBsZWRnZSA8cm95LnBsZWRnZUBueHAuY29tPjsgQ2xhdWRpdSBNYW5vaWwNCj4g
PGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5h
c0Bhcm0uY29tPjsgU2NvdHQNCj4gV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD47IG1vZGVyYXRlZCBs
aXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTQ0KPiBBUkNISVRFQ1RVUkUgPGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4cHBjLWRldg0KPiA8bGludXhwcGMt
ZGV2QGxpc3RzLm96bGFicy5vcmc+OyBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvNV0gc29jL2ZzbC9xYm1hbjogRFBBQSBRQk1h
biBmaXhlcyBhbmQgYWRkaXRpb25zDQo+IA0KPiBPbiBGcmksIFNlcCAyOCwgMjAxOCBhdCAzOjQ0
IEFNIE1hZGFsaW4gQnVjdXIgPG1hZGFsaW4uYnVjdXJAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4N
Cj4gDQo+IEFwcGxpZWQgMS00IHRvIGZvci1uZXh0IHdoaWxlIHdhaXRpbmcgZm9yIGNsYXJpZmlj
YXRpb24gb24gNS81LiAgIEFuZA0KPiB1cGRhdGVkIHRoZSBwcmVmaXggdG8gInNvYzogZnNsOiIg
c3R5bGUgdG8gYmUgYWxpZ25lZCB3aXRoIGFybS1zb2MNCj4gY29udmVudGlvbi4gIFBsZWFzZSB0
cnkgdG8gdXNlIHRoYXQgc3R5bGUgaW4gdGhlIGZ1dHVyZSBmb3Igc29jL2ZzbA0KPiBwYXRjaGVz
Lg0KDQpUaGFuayB5b3UsIEkndmUgc2VudCBhbiBlbWFpbCBhYm91dCB0aGUgQVBJcy4NCkknbSBu
b3Qgc3VyZSB3ZSBuZWVkIHRvIGFsaWduIHRoZSBwcmVmaXggdG8gYXJtLXNvYyBhcyB0aGUgc29j
L2ZzbCBkb2VzIG5vdA0Kc2VydmljZSBvbmx5IEFSTSBidXQgYWxzbyBQUEMgYmFzZWQgU29DcyBh
bmQgaGlzdG9yaWNhbGx5IHdlJ3ZlIGJlZW4gdXNpbmcNCnRoZSBzb2MvKiBmb3JtYXQuDQoNClJl
Z2FyZHMsDQpNYWRhbGluDQo=
