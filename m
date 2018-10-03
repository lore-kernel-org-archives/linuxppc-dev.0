Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7F0C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 14:32:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBD02089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 14:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jDl4ZXOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBD02089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QJPj4JFBzF3Jb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 00:32:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jDl4ZXOg";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.52; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="jDl4ZXOg"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QJGP6C1nzF3Bp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 00:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYldc+NVQvFZze/pOtOVpevxr1wYg9JZoWt7521A6bo=;
 b=jDl4ZXOgfCEnt7BKPo6fKiyIqQDSBONM78XeFBFcl+mUhSqXAjeSFnMHpy6ZWhuWh/1JsUE4As+jkfjkFfIjA55TEyu2E28rzfOzwpZvJSW/KuZQjrZ0uQsscedKdmYN1A9+/uo4IJ222j/toPevLMEk/BBiiTIVZ+kt2YdrR+g=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB1438.eurprd04.prod.outlook.com (10.163.166.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Wed, 3 Oct 2018 14:25:41 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::a45f:ad96:edec:a2df]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::a45f:ad96:edec:a2df%3]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 14:25:41 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "oss@buserror.net" <oss@buserror.net>, "rjw@rjwysocki.net"
 <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: RE: [PATCH v3 4/6] drivers: clk-qoriq: Add clockgen support for
 lx2160a
Thread-Topic: [PATCH v3 4/6] drivers: clk-qoriq: Add clockgen support for
 lx2160a
Thread-Index: AQHUVAAm1gYYBo78LEiziDkOWcA876UK/WwAgAKkcsA=
Date: Wed, 3 Oct 2018 14:25:41 +0000
Message-ID: <VI1PR04MB48006A2701212ADAF1977D94F3E90@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-5-git-send-email-vabhav.sharma@nxp.com>
 <153843146463.119890.6551025813220021124@swboyd.mtv.corp.google.com>
In-Reply-To: <153843146463.119890.6551025813220021124@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1438;
 6:UZ17tSG/CQz2TyVC+FENJ65EdWGqXrgizr9uNIQsoKR8CnutU6rAiWNRgmDBqpCKW+PVQe2pkgZzzQU7wEB7O5rCmfgxA7ncuJgwy8ku5hCEtX8Qtr8ckdoxM2gfYbfj6w+DZ2NofZwYeg8mmmOL7uJGS+o1b4IxjE2poySZliwpgKQS5rIBwzGvHFrkESC+Q6wk6P1MrNGYsOOs+IKLVyef5ZktBLRKS/Fl1j58iLeYVQZDa4CEuB+/Bpgzl+04vwqDyrV0rPrt+Cf1wjrH+3stWPranGmTGplMinBMZqhmfGNWp9tZ8ZIatGZE74K0K7WY01hMnlHDjppUu+sGFy12LZzFREQ57MyhUsaeIwjlBxLtx4J1sgLUwCnBipHl8iEmCO63ru2PCH1jGgIyYfYYAbqO2HqRRTfD67sDnABUONxlqduCFcvdpnVO11NmgVwSxZIZEuQxLVPNkWEXGQ==;
 5:z6GrDtJ3gH4zdRfZC1ajU3o7mcNqWiW0wHHAoA722kZfRv+DE7xWRB+1U3ZbPFayheW2tTqw0qFpFp/bLLkuC8WYrXLIrynR7o0FuFFTl+3s374Xn/9nO/VfqSnw0UEaFsQxf5wihioxk90DqmPRpDlNDx/nN61AH+H5JB5Z/5E=;
 7:Lv5as/keNpggSua9toHSvb5Vm7Ur0lo7kZm9I7PFpQVbiElfpwM7AunimNBSRGF9ZXDdFHnjluR8A8/RUEDtIDgnX+2DgdmEzznY9DebzQRfvy+ZCp0jbLlFt5XtZBD+iq6dkC7YzhKGkQc+3c0kURnaqQrSKWvDoGalAie5BVOMUwJZ1qlKzvfutI8pHzGp1bb4JFCD3FDf3aWmJEzXBvht8dKNKgLXLmiTKZXDZF3PbfIQxdQsunTr1mvE2GF2
x-ms-office365-filtering-correlation-id: eb6a7389-1afd-419e-bad3-08d6293c1938
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1438; 
x-ms-traffictypediagnostic: VI1PR04MB1438:
x-microsoft-antispam-prvs: <VI1PR04MB143889C7C04A1E24721367A4F3E90@VI1PR04MB1438.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(180628864354917)(258649278758335)(65623756079841)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);
 SRVR:VI1PR04MB1438; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1438; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(13464003)(7416002)(81156014)(71190400001)(53546011)(102836004)(26005)(71200400001)(74316002)(2201001)(54906003)(110136005)(316002)(14454004)(4326008)(66066001)(86362001)(2501003)(5250100002)(6246003)(8936002)(186003)(6116002)(478600001)(3846002)(2906002)(76176011)(6506007)(7696005)(105586002)(44832011)(53936002)(97736004)(5660300001)(256004)(106356001)(68736007)(99286004)(6436002)(9686003)(25786009)(305945005)(55016002)(2900100001)(8676002)(446003)(11346002)(33656002)(81166006)(229853002)(486006)(476003)(7736002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1438;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8JmBbjO+a5KTRRIBrRipub0TimsfcDbBO+1EkPzt9trzAQ2+MIwq9yyxYPM9PS8VJHaHHnF32gn0QVitu1MaKsQ4bOvXbyZtttEUNS+VgUDQVnH/PqiJmYSXy7KnPtC0e6sH5+BLa4VCBMewSrDo4RdM3NO8fPfRZK9IUUUmQ5ZlBx12zkVq1+I5mEi81jNiHK6JjRYnBsuVXGbDrYyef/sO5VqGJCRYTMJwH9myA+uuG+6qVaNmPD4VXY6kntvx8pUy8OPBfn8jjuN7Mw14tD4jZBkzTQX2rFQFZoxVNEO9aviNG2kdLQYcoSoNzApAiHLUZyqgkK3yDJmmML1YVMKF8a01CGSb8IJXo1LkEDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6a7389-1afd-419e-bad3-08d6293c1938
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 14:25:41.5397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1438
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
Cc: Andy Tang <andy.tang@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Varun Sethi <V.Sethi@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZGV2aWNldHJlZS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGRldmljZXRyZWUtb3duZXJAdmdlci5rZXJuZWwub3JnPg0KPiBP
biBCZWhhbGYgT2YgU3RlcGhlbiBCb3lkDQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMiwgMjAx
OCAzOjM0IEFNDQo+IFRvOiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+OyBh
cm5kQGFybmRiLmRlOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBrc3Rld2FydEBsaW51
eGZvdW5kYXRpb24ub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWwtDQo+IG93bmVyQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgb3NzQGJ1c2Vycm9yLm5ldDsg
cmp3QHJqd3lzb2NraS5uZXQ7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgc3VkZWVwLmhvbGxhQGFy
bS5jb207IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyB5
YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbQ0KPiBDYzogbGludXhAYXJtbGludXgub3JnLnVr
OyBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPjsgVWRpdCBLdW1hcg0KPiA8dWRpdC5rdW1h
ckBueHAuY29tPjsgWW9nZXNoIE5hcmF5YW4gR2F1cg0KPiA8eW9nZXNobmFyYXlhbi5nYXVyQG54
cC5jb20+OyBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPjsgVmFiaGF2DQo+IFNoYXJtYSA8
dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDQvNl0gZHJp
dmVyczogY2xrLXFvcmlxOiBBZGQgY2xvY2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYQ0KPiANCj4g
U2FtZSBzdWJqZWN0IGNvbW1lbnQuDQpPaw0KPiANCj4gUXVvdGluZyBWYWJoYXYgU2hhcm1hICgy
MDE4LTA5LTIzIDE3OjA4OjU5KQ0KPiA+IEZyb206IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFu
LmdhdXJAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBh
Lg0K
