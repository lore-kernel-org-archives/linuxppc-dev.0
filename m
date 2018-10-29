Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A9C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:02:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F682084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lIGZP7bP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F682084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42k7sM12cszDrPx
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 20:02:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lIGZP7bP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.1.40; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="lIGZP7bP"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0040.outbound.protection.outlook.com [104.47.1.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42k7lZ4x1mzDrMC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 19:57:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tny9F4H5G680oRcTYoEjFHfPs4KZdLMC7oNeSRFy4VU=;
 b=lIGZP7bP5/ZUs5pHOzCgDHlNpkFJIAWoGNKpXJ3EWnLqjmNDDZlE58r+LU2lYxeidDfWX0Wy0Ccvakjmj7ex+tk7nPBzgOEp5AXbvuMZ00+BOU0xyPTPEkRuehX6rIAIU6KK59xOcSb8mFBOffuRmTibIKvLF0odYlIbxtw2pR8=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5149.eurprd04.prod.outlook.com (20.177.50.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Mon, 29 Oct 2018 08:57:22 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 08:57:22 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net"
 <oss@buserror.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH v7 0/6] arm64: dts: NXP: add basic dts file for LX2160A SoC
Thread-Topic: [PATCH v7 0/6] arm64: dts: NXP: add basic dts file for LX2160A
 SoC
Thread-Index: AQHUb2VnlnLjFrrFHE2R0YjBMEJITA==
Date: Mon, 29 Oct 2018 08:57:22 +0000
Message-ID: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5149;
 6:U/AOdidcxH0Cntiud/jnGbbr7ZM7EpijWSa8826wCqBofplXheN1DU63asgroNv+csjOI9TWmOZ/Jw4vptSqG7e/+wjzXLZgEyA7hhdGWFXhnUhxx/w/PT3RKgygxrHQdXRvdFlg67I9iqbbtTMyRXRTHUdEdBE2IPogm4PAF2aGhKDhMwjG1tkjXYOjgn2JJ3F5gskzG/k9QcK35Rb+vAcGfDFxBNMnYfBGfvrwN+BFl0wZcvNlUzr2+tGS3sTESVixHCz1spOOuSFckdngFUIAhuNALm6ZOyUvFQr6z5vxLVFZmO5uN2wprLENxw2HGkVqadnb7VzUXpJaYRMaum+7bqs62TOu9bnwQ294deOSkhjO8yi9wWKftRxHxEFiUhuvJB753afOVeUiaCOhcmQ+Qs22MZk2+Ulg3AAQHVJXfwwEw929BSDgqOKw0SNsFNe/FsdSMo8Zya/7nOPxeA==;
 5:/eUUT/VOZfrP61su53FqdZkzjqrDYu0khIm8pjRCP/k3pPf/TvQpNbomcKQfwf97l3Kbt2ReAo/clTu0w6ircD/sSlRdtgrNaUsZ4MYj12LO3OuCAyFw5IAhraHzu9FEsJFc8rHHhiQIm1EoB0P03u9LiZpoQ9z52PNXD/aaosw=;
 7:dBSozIE9nHQpC7VU29SRbRmIRsTTwQJtEgLK7YathbCoGxacB8TsRmzn+5aoMUS1zikVOAb/IyHqa01KaKoyt/ydxcBRwHdnC0KlZlWa7hvNmQvwPAJAAufvpH3oG23NsVm2+3CLqcqKKR4w+cUdmQ==
x-ms-office365-filtering-correlation-id: da80a16e-9b03-43a7-cc62-08d63d7c8a06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5149; 
x-ms-traffictypediagnostic: VI1PR04MB5149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR04MB5149B0FE4521E435EF532996F3F30@VI1PR04MB5149.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5149; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5149; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(86362001)(186003)(54906003)(14444005)(44832011)(486006)(102836004)(2900100001)(256004)(2201001)(55236004)(386003)(6506007)(7736002)(478600001)(4326008)(97736004)(26005)(105586002)(110136005)(99286004)(2616005)(52116002)(14454004)(476003)(106356001)(2501003)(6512007)(5660300001)(316002)(8936002)(5250100002)(68736007)(71190400001)(71200400001)(7416002)(53936002)(6486002)(25786009)(3846002)(6116002)(8676002)(81156014)(81166006)(305945005)(36756003)(2906002)(6436002)(66066001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5149;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aWcBCLnQaUfL6aW7X6YMNp6wETHgIPI9hnbaBqZpMe1VkGv51Vh5lQAEPcs8vZWaw8f1bolm9gYerFYbqUfF/Z1egDnXmYqsZWD3Du+vwOYrGD9gc3kNW5neZXNPSw22iE31Y/o6CcMXH8bwEOfFBChAF6fRWrnm+xtr/i82KLX/pki2LqMqg7v9iB25zqK6jrikMUQsYukhL1w0Rz+f6qTBVtKe9GuA/sN8CW4d3MXno6MkNFCbMo30pEwnoOmToKrhXUJE5G1MxiNctU8TK1KBMFrOkrJivQCIjlMw0sbTGLv2EZ8nLTF8ziIavKVNqd1TE16v20MHFT06hUWdbDYqgfnqqHyGsGcLZcAqXx8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F33E4F94D80D6045B879D3B3D08757E6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da80a16e-9b03-43a7-cc62-08d63d7c8a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 08:57:22.5287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5149
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Udit Kumar <udit.kumar@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Q2hhbmdlcyBmb3Igdjc6DQotIENvbW1lbnQgZm9yIGNsb2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eSBm
aXhlZCBieSBib290bG9hZGVyICAgICANCg0KQ2hhbmdlcyBmb3IgdjY6DQotIEFkZGVkIGNvbW1l
bnQgZm9yIGNsb2NrIHVuaXQtc3lzY2xrIG5vZGUgbmFtZSBpbiBTb0MgZGV2aWNlIHRyZWUNCg0K
Q2hhbmdlcyBmb3IgdjU6DQotIFVwZGF0ZWQgdGVtcGVyYXR1cmUgc2Vuc29yIHJlZ3VsYXRvciBu
YW1lIGluIGJvYXJkIGRldmljZSB0cmVlDQotIFNvcnRlZCBub2RlcyBhbHBoYWJhdGljYWxseSBh
bmQgdW5pdC1hZGRyZXNzIGluIFNvQy9ib2FyZCBkZXZpY2UgdHJlZQ0KLSBJZGVudGF0aW9uLCBu
ZXcgbGluZSB1cGRhdGUgaW4gU29DL2JvYXJkIGRldmljZSB0cmVlDQotIFVwZGF0ZWQgbm9kZXMg
bmFtZSBhcyBwZXIgRFQgc3BlYyBnZW5lcmljIG5hbWUgcmVjb21tZW5kYXRpb24gaW4gU29DIERU
DQotIFVwZGF0ZWQgbWFjcm8gZGVmaW5lIGZvciBpbnRlcnJ1cHQvZ3BpbyBwcm9wZXJ0eQ0KLSBV
cGRhdGVkIGkyYyBub2RlIHByb3BlcnR5IG5hbWUgc2NsLWdwaW8NCi0gUmVtb3ZlZCBkZXZpY2Vf
dHlwZSBwcm9wZXJ0eSBleGNlcHQgY3B1L21lbW9yeSBub2RlDQotIEFkZGVkIGVzZGhjIGNvbnRy
b2xsZXIgbm9kZXMgaW4gU29DL1JEQiBib2FyZCBkZXZpY2UgdHJlZQ0KLSBBZGRlZCBhbGlhc2Vz
IGZvciB1YXJ0L2NyeXB0byBub2Rlcw0KLSBBZGQgU29DIGRpZSBhdHRyaWJ1dGUgZGVmaW5pdGlv
biBmb3IgTFgyMTYwQQ0KDQpDaGFuZ2VzIGZvciB2NDoNCi0gVXBkYXRlZCBiaW5kaW5ncyBmb3Ig
bHgyMTYwYSBjbG9ja2dlbiBhbmQgZGNmZw0KLSBNb2RpZmllZCBjb21taXQgbWVzc2FnZSBmb3Ig
bHgyMTYwYSBjbG9ja2dlbiBjaGFuZ2VzDQotIFVwZGF0ZWQgaW50ZXJydXB0IHByb3BlcnR5IHdp
dGggbWFjcm8gZGVmaW5pdGlvbg0KLSBBZGRlZCByZXF1aXJlZCBlbmFibGUtbWV0aG9kIHByb3Bl
cnR5IHRvIGVhY2ggY29yZSBub2RlIHdpdGggcHNjaSB2YWx1ZQ0KLSBSZW1vdmVkIHVudXNlZCBu
b2RlIHN5c2NvbiBpbiBkZXZpY2UgdHJlZQ0KLSBSZW1vdmVkIGJsYW5rIGxpbmVzIGluIGRldmlj
ZSB0cmVlIGZzbC1seDIxNjBhLmR0c2kNCi0gVXBkYXRlZCB1YXJ0IG5vZGUgY29tcGF0aWJsZSBz
YnNhLXVhcnQgZmlyc3QNCi0gQWRkZWQgYW5kIGRlZmluZWQgdmNjLXN1cHBseSBwcm9wZXJ0eSB0
byB0ZW1wZXJhdHVyZSBzZW5zb3Igbm9kZSBpbg0KICBkZXZpY2UgdHJlZSBmc2wtbHgyMTYwYS1y
ZGIuZHRzDQoNCkNoYW5nZXMgZm9yIHYzOg0KLVNwbGl0IGNsb2NrZ2VuIHN1cHBvcnQgcGF0Y2gg
aW50byBiZWxvdyB0d28gcGF0Y2hlczoNCi0gYSlVcGRhdGVkIGFycmF5IHNpemUgb2YgY211eF90
b19ncm91cFtdIHdpdGggTlVNX0NNVVgrMSB0byBpbmNsdWRlIC0xDQogdGVybWluYXRvciBhbmQg
cDQwODAgY211eF90b19ncm91cFtdIGFycmF5IHdpdGggLTEgdGVybWluYXRvcg0KLSBiKUFkZCBj
bG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBhDQoNCkNoYW5nZXMgZm9yIHYyOg0KLSBNb2RpZmll
ZCBjbXV4X3RvX2dyb3VwIGFycmF5IHRvIGluY2x1ZGUgLTEgdGVybWluYXRvcg0KLSBSZXZlcnQg
TlVNX0NNVVggdG8gb3JpZ2luYWwgdmFsdWUgOCBmcm9tIDE2DQotIFJlbW92ZSDDoiBMWDIxNjBB
IGlzIDE2IGNvcmUsIHNvIG1vZGlmaWVkIHZhbHVlIGZvciBOVU1fQ01VWFgNCiAgaW4gcGF0Y2gg
IltQQVRDSCAzLzVdIGRyaXZlcnM6IGNsay1xb3JpcTogQWRkIGNsb2NrZ2VuIHN1cHBvcnQgZm9y
DQogIGx4MjE2MGEiIGRlc2NyaXB0aW9uDQotIFBvcHVsYXRlZCBjYWNoZSBwcm9wZXJ0aWVzIGZv
ciBMMSBhbmQgTDIgY2FjaGUgaW4gbHgyMTYwYSBkZXZpY2UtdHJlZS4NCi0gUmVtb3ZlZCByZWJv
b3Qgbm9kZSBmcm9tIGx4MjE2MGEgZGV2aWNlLXRyZWUgYXMgUFNDSSBpcyBpbXBsZW1lbnRlZC4N
Ci0gUmVtb3ZlZCBpbmNvcnJlY3QgY29tbWVudCBmb3IgdGltZXIgbm9kZSBpbnRlcnJ1cHQgcHJv
cGVydHkgaW4NCiAgbHgyMTYwYSBkZXZpY2UtdHJlZS4NCi0gTW9kaWZpZWQgcG11IG5vZGUgY29t
cGF0aWJsZSBwcm9wZXJ0eSBmcm9tICJhcm0sYXJtdjgtcG11djMiIHRvDQogICJhcm0sY29ydGV4
LWE3Mi1wbXUiIGluIGx4MjE2MGEgZGV2aWNlLXRyZWUNCi0gTm9uLXN0YW5kYXJkIGFsaWFzZXMg
cmVtb3ZlZCBpbiBseDIxNjBhIHJkYiBib2FyZCBkZXZpY2UtdHJlZQ0KLSBVcGRhdGVkIGkyYyBj
aGlsZCBub2RlcyB0byBnZW5lcmljIG5hbWUgaW4gbHgyMTYwYSByZGIgZGV2aWNlLXRyZWUuDQoN
CkNoYW5nZXMgZm9yIHYxOg0KLSBBZGQgY29tcGF0aWJsZSBzdHJpbmcgZm9yIExYMjE2MEEgY2xv
Y2tnZW4gc3VwcG9ydA0KLSBBZGQgY29tcGF0aWJsZSBzdHJpbmcgdG8gaW5pdGlhbGl6ZSBMWDIx
NjBBIGd1dHMgZHJpdmVyDQotIEFkZCBjb21wYXRpYmxlIHN0cmluZyBmb3IgTFgyMTYwQSBzdXBw
b3J0IGluIGR0LWJpbmRpbmdzDQotIEFkZCBkdHMgZmlsZSB0byBlbmFibGUgc3VwcG9ydCBmb3Ig
TFgyMTYwQSBTb0MgYW5kIExYMjE2MEEgUkRCDQogIChSZWZlcmVuY2UgZGVzaWduIGJvYXJkKQ0K
DQpWYWJoYXYgU2hhcm1hICg0KToNCiAgZHQtYmluZGluZ3M6IGFybTY0OiBhZGQgY29tcGF0aWJs
ZSBmb3IgTFgyMTYwQQ0KICBzb2MvZnNsL2d1dHM6IEFkZCBkZWZpbml0aW9uIGZvciBMWDIxNjBB
DQogIGFybTY0OiBkdHM6IGFkZCBRb3JJUSBMWDIxNjBBIFNvQyBzdXBwb3J0DQogIGFybTY0OiBk
dHM6IGFkZCBMWDIxNjBBUkRCIGJvYXJkIHN1cHBvcnQNCg0KWW9nZXNoIEdhdXIgKDIpOg0KICBj
bGs6IHFvcmlxOiBpbmNyZWFzZSBhcnJheSBzaXplIG9mIGNtdXhfdG9fZ3JvdXANCiAgY2xrOiBx
b3JpcTogQWRkIGNsb2NrZ2VuIHN1cHBvcnQgZm9yIGx4MjE2MGENCg0KIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnR4dCAgICAgIHwgIDE0ICstDQogLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvY2xvY2svcW9yaXEtY2xvY2sudHh0ICAgICAgfCAgIDEgKw0KIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlICAgICAgICAgICAgIHwgICAxICsNCiBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzICB8IDExOSAr
KysrDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSAgICAg
fCA3NjYgKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTYgKy0NCiBkcml2ZXJzL2NwdWZyZXEvcW9yaXEt
Y3B1ZnJlcS5jICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9zb2MvZnNsL2d1
dHMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KIDggZmlsZXMgY2hhbmdl
ZCwgOTIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEu
ZHRzaQ0KDQotLSANCjIuNy40DQoNCg==
