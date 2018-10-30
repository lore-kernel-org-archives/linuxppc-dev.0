Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAE5C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 03:41:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5039020823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 03:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bGplyfTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5039020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kchr2R8GzDrS3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 14:41:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bGplyfTb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.55; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=yinbo.zhu@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="bGplyfTb"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80055.outbound.protection.outlook.com [40.107.8.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kcf9502KzDrS3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 14:39:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbr3M1Nd3MQTC3Wj+osweSfyRkKrQGnZccuj6TlI8Cs=;
 b=bGplyfTbTHqP2hCYdDY/OqhfGDy/NKuIKl9xvft34GSF4FiUPCYGQKM2Mv9YqX4ZaiUbV6SvFXke8D3qsV2LRTwPXP0RpmZSU5biixWTZqXSFV54aGan8i9qs9SDp3ztsHMxAOk9m+mE8x408u08YPHt6CEu42nY7uY72NlwMx8=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB1680.eurprd04.prod.outlook.com (10.164.85.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Tue, 30 Oct 2018 03:39:13 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::58c8:d1aa:bddc:1d00]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::58c8:d1aa:bddc:1d00%3]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 03:39:13 +0000
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: Poonam Aggrwal <poonam.aggrwal@nxp.com>, Vabhav Sharma
 <vabhav.sharma@nxp.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org"
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
Subject: RE: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
Thread-Topic: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
Thread-Index: AQHUb2Vu6PkGjw9WQUyVBNIL+dO1VKU2EOcAgAEI1+A=
Date: Tue, 30 Oct 2018 03:39:13 +0000
Message-ID: <VI1PR04MB41589506EDE16676AB561FBDE9CC0@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
 <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
 <VI1PR04MB4976D4A33E0561D125BE837486F30@VI1PR04MB4976.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4976D4A33E0561D125BE837486F30@VI1PR04MB4976.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1680;
 6:dINl5dNXfLm/qRSbDoPcaB+4UXVNPVJMommJNxDiaYNv98WALMcYvMoH8HkNJnx/CM0ie1yqNLT/VMjw2m15jXglCEvsOXguZqdWu0dXka0graKLDOvYXsh79jdJohWrfMiAMNZ+t+WKo8QsG3q/DdlXLkTFjfScpFJk5s1+uDM1xN7f65OyCRlIvimY0NgFj7ZIqT57pVRd8WJ7KBc/KBZAjOt3aKv6v1Fyle2R6UHQRoFSM2fd1ul/AawpsazRDY4tjkTm+AtcgY+DGymfBZntdJNdLoVyqeks20lnGQuVaj3MGAKk1SjebZfuDSWnDSzAkDIRjCffwWZNaPH/taobxmwl1aobWpzZODUzvp3E0Ms2hzZM9uDarWrjkGBgqja1wU5Tft9uviwKnuV2/YRlhhJOzUjy0Fr3+Uv0nzFQlc/E2j+ii6E7ck54OHq+JH/k3nqVhA80epno0oUFoA==;
 5:yaF5QX7JqQX+sJAucUwkKU6mbiocEdeajHg+RjL5/WM0G/7SLGHj++w1o6RN6wbV7qzymtMT46W1YDXISXZqKfNw6pTXNHdV6P4fFbiLSK6r/HfkrQy7WnzxycW21kF/fMVf5neAjgZTy6xIkAinfAXcYPNqQQtmo6fWnmvX6mw=;
 7:4e5hyBqImyP/c8fOrTTKlWBWXc778ObFLXKA+soAJTi7omW0a5h/T/DH4SsON4GsFZALNRy1xKfoI7HOMbkfvz/e5v4xOvmyWnbdSimx+sQ0InJKM/wRPSUTp8W1A9PJ41AfYwc0OFfbfk1Gih5IZw==
x-ms-office365-filtering-correlation-id: d35ec49f-5ea6-455f-00dc-08d63e1942d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1680; 
x-ms-traffictypediagnostic: VI1PR04MB1680:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR04MB1680A04AEC124CDADBBB743EE9CC0@VI1PR04MB1680.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(258649278758335)(228905959029699)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(4982022)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB1680; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1680; 
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(13464003)(102836004)(229853002)(86362001)(575784001)(6246003)(44832011)(55016002)(4326008)(11346002)(97736004)(74316002)(3846002)(6116002)(53936002)(105586002)(478600001)(106356001)(446003)(486006)(7416002)(8936002)(9686003)(256004)(476003)(2201001)(25786009)(6306002)(8676002)(53546011)(66066001)(6436002)(305945005)(2900100001)(81156014)(7736002)(6506007)(14454004)(81166006)(33656002)(2906002)(99286004)(966005)(71200400001)(68736007)(5250100002)(186003)(45080400002)(2501003)(7696005)(71190400001)(26005)(76176011)(316002)(110136005)(5660300001)(54906003)(921003)(1121003)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1680;
 H:VI1PR04MB4158.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P5dTSUl521E7pexUJvd5LooLvayAgRMBSkEjDDT/EcMJLUTnfSHGDc55wl+ijDkL54K6aWN3TJEwx63Zgsu3OlOU61vQVRPEhXd95zlii7XukjDuttXkWsXo3CZf0lTAOmwPS+xFEG8VF+l0Y1sojOIWYGByRxLGNUUAK6h9OpfpKjOAUa7oLieu1b0m0C3uGUv40wlzLUXILTx8qC5Fi/ja+kh0xNOs0uqxY2+mbPMCeSuP68VxjdkzYpynxacycw4jdx3oHHfE7UeQEXvdS2ADyfLrq5MBg5WcN2iV1yeBQ4XhO5Rz2rLx/AirqYrnEj5QWF32FhMFXSUUYIxOrlxsvnv/SW+aSA9WlGKHghA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35ec49f-5ea6-455f-00dc-08d63e1942d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 03:39:13.3469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1680
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQb29uYW0gQWdncndhbCANClNl
bnQ6IDIwMTjE6jEw1MIyOcjVIDE5OjA5DQpUbzogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJt
YUBueHAuY29tPjsgc3VkZWVwLmhvbGxhQGFybS5jb207IG9zc0BidXNlcnJvci5uZXQ7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eHBwYy1kZXZAbGlzdHMu
b3psYWJzLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBtdHVycXVl
dHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgcmp3QHJqd3lzb2NraS5uZXQ7IHZp
cmVzaC5rdW1hckBsaW5hcm8ub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1w
bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmc7IGNh
dGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZzsgYXJuZEBhcm5kYi5kZTsga3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9y
ZzsgeWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb207IExlbyBMaSA8bGVveWFuZy5saUBueHAu
Y29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZw0KQ2M6IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IFVk
aXQgS3VtYXIgPHVkaXQua3VtYXJAbnhwLmNvbT47IFBhbmthaiBCYW5zYWwgPHBhbmthai5iYW5z
YWxAbnhwLmNvbT47IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgYWRyaWFuLmh1bnRlckBpbnRlbC5j
b207IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+OyBWYWJoYXYgU2hhcm1hIDx2YWJoYXYu
c2hhcm1hQG54cC5jb20+OyBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KU3ViamVjdDog
UkU6IFtQQVRDSCB2NyAyLzZdIHNvYy9mc2wvZ3V0czogQWRkIGRlZmluaXRpb24gZm9yIExYMjE2
MEENCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYXJt
LWtlcm5lbCANCj4gW21haWx0bzpsaW51eC1hcm0ta2VybmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFk
ZWFkLm9yZ10NCj4gT24gQmVoYWxmIE9mIFZhYmhhdiBTaGFybWENCj4gU2VudDogTW9uZGF5LCBP
Y3RvYmVyIDI5LCAyMDE4IDI6MjggUE0NCj4gVG86IHN1ZGVlcC5ob2xsYUBhcm0uY29tOyBvc3NA
YnVzZXJyb3IubmV0OyANCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IA0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBh
cm0uY29tOyANCj4gbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNib3lk
QGtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyANCj4gdmlyZXNoLmt1bWFyQGxpbmFyby5v
cmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IA0KPiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBjYXRhbGluLm1hcmlu
YXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgDQo+IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOyBhcm5kQGFybmRiLmRlOyANCj4ga3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZzsg
eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb207IExlbyBMaSANCj4gPGxlb3lhbmcubGlAbnhw
LmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmcNCj4gQ2M6IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7
IFVkaXQgS3VtYXIgPHVkaXQua3VtYXJAbnhwLmNvbT47IFBhbmthaiANCj4gQmFuc2FsIDxwYW5r
YWouYmFuc2FsQG54cC5jb20+OyBsaW51eEBhcm1saW51eC5vcmcudWs7IA0KPiBhZHJpYW4uaHVu
dGVyQGludGVsLmNvbTsgVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT47IFZhYmhhdiBTaGFy
bWEgDQo+IDx2YWJoYXYuc2hhcm1hQG54cC5jb20+OyBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjcgMi82XSBzb2MvZnNsL2d1dHM6IEFkZCBkZWZpbml0
aW9uIGZvciBMWDIxNjBBDQo+IA0KPiBBZGRpbmcgY29tcGF0aWJsZSBzdHJpbmcgImx4MjE2MGEt
ZGNmZyIgdG8gaW5pdGlhbGl6ZSBndXRzIGRyaXZlciBmb3IgDQo+IGx4MjE2MCBhbmQgU29DIGRp
ZSBhdHRyaWJ1dGUgZGVmaW5pdGlvbiBmb3IgTFgyMTYwQQ0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZ
aW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KPiBBY2tlZC1ieTogTGkgWWFuZyA8bGVveWFu
Zy5saUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL2ZzbC9ndXRzLmMgfCA2ICsrKysr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc29jL2ZzbC9ndXRzLmMgYi9kcml2ZXJzL3NvYy9mc2wvZ3V0cy5jIGluZGV4IA0K
PiAzMDJlMGM4Li5iY2FiMWVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9mc2wvZ3V0cy5j
DQo+ICsrKyBiL2RyaXZlcnMvc29jL2ZzbC9ndXRzLmMNCj4gQEAgLTEwMCw2ICsxMDAsMTEgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBmc2xfc29jX2RpZV9hdHRyIGZzbF9zb2NfZGllW10gPSB7DQo+
ICAJICAuc3ZyCQk9IDB4ODcwMDAwMDAsDQo+ICAJICAubWFzawkJPSAweGZmZjcwMDAwLA0KPiAg
CX0sDQo+ICsJLyogRGllOiBMWDIxNjBBLCBTb0M6IExYMjE2MEEvTFgyMTIwQS9MWDIwODBBICov
DQo+ICsJeyAuZGllICAgICAgICAgID0gIkxYMjE2MEEiLA0KPiArCSAgLnN2ciAgICAgICAgICA9
IDB4ODczNjAwMDAsDQo+RG8gYWxsICB0aGUgdGhyZWV2YXJpYW50cyAiIExYMjE2MEEvTFgyMTIw
QS9MWDIwODBBIiAgaGF2ZSBzYW1lIFNWUj8NCkRlYXIgUG9vbmFtIEFnZ3J3YWwsDQoNCk5vLCBi
dXQgdGhlIHRocmVldmFyaWFudHMgIiBMWDIxNjBBL0xYMjEyMEEvTFgyMDgwQSIgaGFzIHNhbWUg
c3ZyIHZhbHVlIGluIHRoaXMgc3RydWN0LA0KQmVjYXVzZSB0aGV5IGFsbCBhcmUgdmFyaWFudHMg
b2YgbHgyMTYwLCB0aGUgc3ZyIHZhbHVlIGluIHRoaXMgc3RydWN0IGlzIGVxdWFsIHRoZSBzb2Mg
c3ZyICYmIG1hc2sNCg0KQmVzdCBSZWdhcmRzLA0KWWluYm8gWmh1Lg0KDQo+ICsJICAubWFzayAg
ICAgICAgID0gMHhmZjNmMDAwMCwNCj4gKwl9LA0KPiAgCXsgfSwNCj4gIH07DQo+IA0KPiBAQCAt
MjIyLDYgKzIyNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGZzbF9ndXRz
X29mX21hdGNoW10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDg4YS1kY2ZnIiwg
fSwNCj4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxsczEwMTJhLWRjZmciLCB9LA0KPiAgCXsgLmNv
bXBhdGlibGUgPSAiZnNsLGxzMTA0NmEtZGNmZyIsIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJm
c2wsbHgyMTYwYS1kY2ZnIiwgfSwNCj4gIAl7fQ0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFC
TEUob2YsIGZzbF9ndXRzX29mX21hdGNoKTsNCj4gLS0NCj4gMi43LjQNCj4gDQo+IA0KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwJTNBJTJGJTJGbGlzdA0KPiBzLmluZnINCj4gYWRlYWQub3JnJTJGbWFpbG1hbiUyRmxp
c3RpbmZvJTJGbGludXgtYXJtLQ0KPiBrZXJuZWwmYW1wO2RhdGE9MDIlN0MwMSU3Q3Bvb25hbS5h
Z2dyd2FsJTQwbnhwLmNvbSU3Q2Q5YjdjMzZjNzg2DQo+IDU0Y2Q2ZGM0MDA4ZDYzZDdmZWU2MyU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzANCj4gJTdDNjM2NzY0MDE3
MDAxNTA0Mjg4JmFtcDtzZGF0YT1wcUZNbHc2eVZySHJ2bjRZUmhxaiUyRm1vT25Tc2NyWnUNCj4g
dGNvWW4zSW44T0pjJTNEJmFtcDtyZXNlcnZlZD0wDQo=
