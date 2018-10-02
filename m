Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24781C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:16:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9556320684
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kqtRKXjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9556320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PTS43F4VzF3HP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 16:16:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kqtRKXjb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.72; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="kqtRKXjb"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PTGW0MpwzF3Cl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 16:08:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVqEBj0bEC2VbWxWZUq79Ol0BSbwx/ePMYs1oOaiHwE=;
 b=kqtRKXjbooZl3X8OBLddzS/gBnm24CVEWvCZbspyW5IH+wG0TqkEIpW2p3HM1+OgwqVBPZDS/HhtntcuqM6MRpSBhbyPjiZ08OnFXysQ4WwgUerxmMfJmgS3NOnw33sHJe4la6MJVP/zFDCNroevtYSVeGWMW/FwGDH3CH8F1fY=
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) by
 AM6PR04MB4773.eurprd04.prod.outlook.com (20.177.32.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Tue, 2 Oct 2018 06:07:55 +0000
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::2806:3ebb:e234:4123]) by AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::2806:3ebb:e234:4123%2]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 06:07:55 +0000
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
Thread-Topic: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
Thread-Index: AQHUVwddNVPIy9ISJEeSANoy2KAJf6UK83IAgACKSSA=
Date: Tue, 2 Oct 2018 06:07:55 +0000
Message-ID: <AM6PR04MB400877EC0C140A7D919AEF41ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
 <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
In-Reply-To: <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4773;
 6:N7D1i2rfbITvS8Lk4ss3PZ2E+3yS62ACCnuYy+iSf45d4JRSVS5p5eMxtljK+DEp4oC9ijJsrSuUrwxWjhQBjYcltGIGHK4vlqR41luyemsqluelS9k8ORRiLp8FSp5U0GpOCrheFX7jvi57s12WT0lC5eMvThvpffq1mZln6AyTCPxT5HOfQza1EDvYKjkFdLt+6GEMx8/tO/CCll2aDJBYi1UfFm/bi3Ev893iHRiZyaYS+l/z/qMupst96o+60hP9DCc0fcCdTTN36GU/9/Ijt5GXZQqCzpKt5BWTQvUNjCoH7sic90UZXgLWVVfBC3LHDa5TGt2p9WG5CtmzZPBv0a1XirMCxLIzCoC/dlNXJGB/ICR6RSVGoArF7sAvBLpjeH4OV8B4dvapyDJNVqSLs63bIYDcsRu59xyF52iSWYqeMKg6EaB0Mk3oe3sCVyzOXPpX5PBExJK4H7qpng==;
 5:tTFsNNDVMyLWPLvkH4TzdPa4f9WviS+FJXy+F5zRfLFPsIwHa/WHIuYdvpVNMfYF7U/jWHJyN/zGb8DgTQzqqRGkE/IyztCaZWk59qo8tlLvQ0IJL8KukjEOytAYVKEPEhXU1h+BE9eK2rDsHvR1tcqJo2BiwusS3RRtt1Pv2pE=;
 7:4U/8iGJMSIZpFveT9eB6/ZQdPIr65vv2TrsylpX+HKHugCX5b2bNgzKKbOhl+gf/SONBEnNy0ux5dApntgB51WQyEoFlkwUuRwNIDJ+781zTgTlVMCMqIfYW09uU9MJopgr57O9ifs7Cx/fbuwGiREtTkI2N97nkfAkoGSkL+Gget3+9tuLL7uvRnermGoe/NY7CtbNArVmSy/83CLLMNv/c7+jmvyx89T/4IWtTn5esDv6ZzfyT1juKmbhGbhBn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e0b63161-54f6-4661-e315-08d6282d6510
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4773; 
x-ms-traffictypediagnostic: AM6PR04MB4773:
x-microsoft-antispam-prvs: <AM6PR04MB4773B68023CE367C463EACC9ECE80@AM6PR04MB4773.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(275809806118684)(180628864354917)(258649278758335)(65623756079841)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);
 SRVR:AM6PR04MB4773; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4773; 
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(13464003)(199004)(6116002)(8676002)(81166006)(8936002)(476003)(6636002)(106356001)(105586002)(316002)(81156014)(7736002)(478600001)(446003)(305945005)(2906002)(5660300001)(68736007)(66066001)(5250100002)(7696005)(6862004)(4326008)(76176011)(25786009)(97736004)(53546011)(99286004)(74316002)(14454004)(71190400001)(53936002)(71200400001)(6246003)(6436002)(9686003)(55016002)(26005)(54906003)(86362001)(6346003)(256004)(2900100001)(102836004)(229853002)(11346002)(486006)(3846002)(6506007)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4773;
 H:AM6PR04MB4008.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-microsoft-antispam-message-info: 8uXHObppbOVal0tgYLTT96F5afoVhKkeRerkmBfwD88h/cRuPosLG8Jppeg2DyrkqYtV+Eyo+zjg/wGDMuo5Ob7g/UtLQFNmC8TxJlM4I602/m4IR3cgUaHzbbvyV/Lck4KfbuVTp1AvSCoMIQzsnL9k40GxCtC0+uAJ4AbSO7u3O/u3r8D9l9drKIm86kSkYeCLwthNlJCi9N8vICz7Sta/kblGSwdk2afnJp9WZj5f/UCB5gFYkpPHdaV+1ziPm3eSXCQT+n/mxamWSeCPewHkqaq7MEOmtdxP/a8rMoa2Md9JtyTY3dV3UBD3cWR7QLcHR3awwE4guXvxwPouwAFK8JRaAI4+Vii73hkN/x4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b63161-54f6-4661-e315-08d6282d6510
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 06:07:55.2811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4773
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
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaSBZYW5nIFttYWlsdG86bGVv
eWFuZy5saUBueHAuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIsIDIwMTggMTI6NTAg
QU0NCj4gVG86IE1hZGFsaW4tY3Jpc3RpYW4gQnVjdXIgPG1hZGFsaW4uYnVjdXJAbnhwLmNvbT4N
Cj4gQ2M6IFJveSBQbGVkZ2UgPHJveS5wbGVkZ2VAbnhwLmNvbT47IENsYXVkaXUgTWFub2lsDQo+
IDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmlu
YXNAYXJtLmNvbT47IFNjb3R0DQo+IFdvb2QgPG9zc0BidXNlcnJvci5uZXQ+OyBtb2RlcmF0ZWQg
bGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0NCj4gQVJDSElURUNUVVJFIDxsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBsaW51eHBwYy1kZXYNCj4gPGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnPjsgbGttbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzVdIHNvYy9mc2xfcWJtYW46IGV4cG9ydCBj
b2FsZXNjZSBjaGFuZ2UgQVBJDQo+IA0KPiBPbiBGcmksIFNlcCAyOCwgMjAxOCBhdCAzOjQ1IEFN
IE1hZGFsaW4gQnVjdXIgPG1hZGFsaW4uYnVjdXJAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4g
PiBFeHBvcnQgdGhlIEFQSSByZXF1aXJlZCB0byBjb250cm9sIHRoZSBRTWFuIHBvcnRhbCBpbnRl
cnJ1cHQgY29hbGVzY2luZw0KPiA+IHNldHRpbmdzLg0KPiANCj4gVGhlc2UgYXJlIG5ldyBBUElz
IG5vdCBqdXN0IG9sZCBBUElzIGJlaW5nIGV4cG9ydGVkLiAgV2hhdCBpcyB0aGUgdXNlcg0KPiBv
ZiB0aGVzZSBBUElzPyAgSXMgdGhlIHVzZXIgYmVpbmcgc3VibWl0dGVkPyAgV2UgY2Fubm90IGhh
dmUgQVBJcyBpbg0KPiBrZXJuZWwgdGhhdCBoYXMgbm8gdXNlcnMuDQoNCkhpLA0KDQpUaGVzZSBh
cmUgbmV3IEFQSXMgdGhhdCB3aWxsIGJlIHVzZWQgaW4gdGhlIERQQUEgRXRoZXJuZXQgZHJpdmVy
Lg0KQ2hhbmdlcyBmb3IgdGhlIERQQUEgUUJNYW4gYW5kIERQQUEgRXRoZXJuZXQgZm9sbG93IGRp
ZmZlcmVudCBwYXRocyB1cHN0cmVhbQ0Kc28gdGhlIEV0aGVybmV0IGRyaXZlciBwYXRjaCB0aGF0
IG1ha2VzIHVzZSBvZiB0aGVzZSBBUElzIHdpbGwgYmUgc2VudCB3aGVuDQp0aGVzZSBjaGFuZ2Vz
IHJlYWNoIHRoZSBuZXQtbmV4dC9tYXN0ZXIgdHJlZS4NCg0KUmVnYXJkcywNCk1hZGFsaW4NCg==
