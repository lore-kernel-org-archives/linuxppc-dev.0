Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F451C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:04:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2E620838
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oZUUOskN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2E620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gdQl3K4yzDrWQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 18:04:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="oZUUOskN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.76; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="oZUUOskN"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00076.outbound.protection.outlook.com [40.107.0.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gdMl0m4QzDrGC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 18:01:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZZu8CrYuWvDottfVRK1TkP81rtTeBx/teN9S0gFtRE=;
 b=oZUUOskNu7PBwvb24M5pb3xinrlIxZ+fQpSKWoTDXDArknlyRlkVNtG7Y4yI7J6uwHqI2ZzwSmftJxeUE+S0BBkA4IUX+vN6JG/O3gsCs35osA77rvGT9PyDMF/utnZaxXPQ6XoUkLlXEBdwLvihKJyA70+2pPdf9khENCVYldM=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB2077.eurprd04.prod.outlook.com (10.166.43.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.20; Thu, 25 Oct 2018 07:01:29 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 07:01:29 +0000
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
Subject: [PATCH v6 0/6] arm64: dts: NXP: add basic dts file for LX2160A SoC
Thread-Topic: [PATCH v6 0/6] arm64: dts: NXP: add basic dts file for LX2160A
 SoC
Thread-Index: AQHUbDCNRgxCmjSoikOHMFhrVo0mjw==
Date: Thu, 25 Oct 2018 07:01:28 +0000
Message-ID: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB2077;
 6:K20oBWlJaW/fOidb7iSm2hxxeFjxS/o8EpX+x9ZduAIPIJ0MVVvDrmIhyFp9D7TkOP5bUSDTTlQ56D9KoyVUUWfOZIkAVgnFy9AoD3ql17QGZOlBGA44ykiBctlsyvZxiVjeJZHObWqIOXP+EkndeeM7jP91NQWJRqnAyvad7WM26hRMSbEiutKRIJe68T/4zLm37okeYLe6f4XaH6uPK02kciuLiYUSnLuiumI/NR2Bmjeci2ZMzWHrkVR4u/u1MDxQTDnd/GDe76OV1/CgGrjDZuYXj5z1BVEdxRjktoDfmEI22HAtbyVNYkZrIRNqsxNUxwkWMQEED8R5zE36aRINkCmbnZu7tGxrBuv8bM5oM5X/iZFIqkyL9arX6oC5Ap7P6treQ2NaSgL+aHPI+q21lzSGmz7Di3mywEaVrARNLJDMAsT9pWBeC7dU8Df+4BaySckfMANwfN/nXtEurA==;
 5:6lBk6Q9DEbefpEaonwiBmJ3/QnUeRmInE8LdDyMNuuAvm3c5UxPrhCRBUI5PPwMRmnydpYuDnrjMf0+P2TZ8apGF6tApVpuEdp6fV7dmdkFVVLyM62yJ9RFiULlFP12cw4O3luD+JOGTMzkV6uThu6pvRfotJmituUdo2qvK7wA=;
 7:e8c1dJkMnOK2lBpd4qAayLIkdzDDgPO6KG7y+GlYUPi02S+UaXZpq0oL+mX6G+e5TqWu+bv49PBMeFWONGAXFjV8j40rUoHxOpK6Jx77PjmI1ufxl6zmw2PBm4x7rYTNlVjkV+sHvfz9wEGWHvIhwQ==
x-ms-office365-filtering-correlation-id: ef9a7e7e-4aa9-4035-ee61-08d63a47af91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB2077; 
x-ms-traffictypediagnostic: VI1PR04MB2077:
x-microsoft-antispam-prvs: <VI1PR04MB2077EC88F7A6DA9786822EA3F3F70@VI1PR04MB2077.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB2077; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB2077; 
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(5250100002)(2201001)(81156014)(476003)(68736007)(97736004)(54906003)(4326008)(86362001)(5660300001)(26005)(102836004)(478600001)(6486002)(81166006)(44832011)(316002)(2616005)(25786009)(486006)(36756003)(7736002)(71190400001)(110136005)(99286004)(52116002)(7416002)(105586002)(14454004)(71200400001)(386003)(55236004)(8936002)(6506007)(2906002)(256004)(106356001)(6436002)(14444005)(186003)(305945005)(6116002)(3846002)(6512007)(8676002)(66066001)(2900100001)(2501003)(53936002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB2077;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Tq83Qp0TRiTS49iE4bI7v09u8bc5FG9L+7LO7gEx9+rVAO4hMe7caewm1T3rl7UNwDc9C5TyKHHd90vciO3xdNf+kLMZ0eyf4SEfyBSOVbEAQRkUSmSgvu4flCut4G8qcV4P1FlGoEkZZKGsfHunkTlGwxt9GsEQFVMF9MS38YdBTcvMhZ/FlDsHfl0HoV+iDCR6m37gRc0Wp4zN9dkt5HJmIprDy5gUAUhXQK5e28hPeTaa1yOBs2ET1RZc4gA+bYuTCMVNZ0CJpMI8qLuZqEJt0oykpyhf5PUDRuyif13cEeY8PV73ROvB3y6rn2tjSzx0hJb3ZGarcgao2yD5D1d4dhRaLFUiya75OEgRhfA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2E91447A74BBE45BDF30797B41516D5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9a7e7e-4aa9-4035-ee61-08d63a47af91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 07:01:28.9513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2077
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

Q2hhbmdlcyBmb3IgdjY6DQotIEFkZGVkIGNvbW1lbnQgZm9yIGNsb2NrIHVuaXQtc3lzY2xrIG5v
ZGUgbmFtZSBpbiBTb0MgZGV2aWNlIHRyZWUgDQoNCkNoYW5nZXMgZm9yIHY1Og0KLSBVcGRhdGVk
IHRlbXBlcmF0dXJlIHNlbnNvciByZWd1bGF0b3IgbmFtZSBpbiBib2FyZCBkZXZpY2UgdHJlZQ0K
LSBTb3J0ZWQgbm9kZXMgYWxwaGFiYXRpY2FsbHkgYW5kIHVuaXQtYWRkcmVzcyBpbiBTb0MvYm9h
cmQgZGV2aWNlIHRyZWUNCi0gSWRlbnRhdGlvbiwgbmV3IGxpbmUgdXBkYXRlIGluIFNvQy9ib2Fy
ZCBkZXZpY2UgdHJlZQ0KLSBVcGRhdGVkIG5vZGVzIG5hbWUgYXMgcGVyIERUIHNwZWMgZ2VuZXJp
YyBuYW1lIHJlY29tbWVuZGF0aW9uIGluIFNvQyBEVA0KLSBVcGRhdGVkIG1hY3JvIGRlZmluZSBm
b3IgaW50ZXJydXB0L2dwaW8gcHJvcGVydHkNCi0gVXBkYXRlZCBpMmMgbm9kZSBwcm9wZXJ0eSBu
YW1lIHNjbC1ncGlvDQotIFJlbW92ZWQgZGV2aWNlX3R5cGUgcHJvcGVydHkgZXhjZXB0IGNwdS9t
ZW1vcnkgbm9kZQ0KLSBBZGRlZCBlc2RoYyBjb250cm9sbGVyIG5vZGVzIGluIFNvQy9SREIgYm9h
cmQgZGV2aWNlIHRyZWUNCi0gQWRkZWQgYWxpYXNlcyBmb3IgdWFydC9jcnlwdG8gbm9kZXMNCi0g
QWRkIFNvQyBkaWUgYXR0cmlidXRlIGRlZmluaXRpb24gZm9yIExYMjE2MEENCg0KQ2hhbmdlcyBm
b3IgdjQ6DQotIFVwZGF0ZWQgYmluZGluZ3MgZm9yIGx4MjE2MGEgY2xvY2tnZW4gYW5kIGRjZmcN
Ci0gTW9kaWZpZWQgY29tbWl0IG1lc3NhZ2UgZm9yIGx4MjE2MGEgY2xvY2tnZW4gY2hhbmdlcw0K
LSBVcGRhdGVkIGludGVycnVwdCBwcm9wZXJ0eSB3aXRoIG1hY3JvIGRlZmluaXRpb24NCi0gQWRk
ZWQgcmVxdWlyZWQgZW5hYmxlLW1ldGhvZCBwcm9wZXJ0eSB0byBlYWNoIGNvcmUgbm9kZSB3aXRo
IHBzY2kgdmFsdWUNCi0gUmVtb3ZlZCB1bnVzZWQgbm9kZSBzeXNjb24gaW4gZGV2aWNlIHRyZWUN
Ci0gUmVtb3ZlZCBibGFuayBsaW5lcyBpbiBkZXZpY2UgdHJlZSBmc2wtbHgyMTYwYS5kdHNpDQot
IFVwZGF0ZWQgdWFydCBub2RlIGNvbXBhdGlibGUgc2JzYS11YXJ0IGZpcnN0DQotIEFkZGVkIGFu
ZCBkZWZpbmVkIHZjYy1zdXBwbHkgcHJvcGVydHkgdG8gdGVtcGVyYXR1cmUgc2Vuc29yIG5vZGUg
aW4NCiAgZGV2aWNlIHRyZWUgZnNsLWx4MjE2MGEtcmRiLmR0cw0KDQpDaGFuZ2VzIGZvciB2MzoN
Ci1TcGxpdCBjbG9ja2dlbiBzdXBwb3J0IHBhdGNoIGludG8gYmVsb3cgdHdvIHBhdGNoZXM6DQot
IGEpVXBkYXRlZCBhcnJheSBzaXplIG9mIGNtdXhfdG9fZ3JvdXBbXSB3aXRoIE5VTV9DTVVYKzEg
dG8gaW5jbHVkZSAtMQ0KIHRlcm1pbmF0b3IgYW5kIHA0MDgwIGNtdXhfdG9fZ3JvdXBbXSBhcnJh
eSB3aXRoIC0xIHRlcm1pbmF0b3INCi0gYilBZGQgY2xvY2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYw
YQ0KDQpDaGFuZ2VzIGZvciB2MjoNCi0gTW9kaWZpZWQgY211eF90b19ncm91cCBhcnJheSB0byBp
bmNsdWRlIC0xIHRlcm1pbmF0b3INCi0gUmV2ZXJ0IE5VTV9DTVVYIHRvIG9yaWdpbmFsIHZhbHVl
IDggZnJvbSAxNg0KLSBSZW1vdmUgw6IgTFgyMTYwQSBpcyAxNiBjb3JlLCBzbyBtb2RpZmllZCB2
YWx1ZSBmb3IgTlVNX0NNVVhYDQogIGluIHBhdGNoICJbUEFUQ0ggMy81XSBkcml2ZXJzOiBjbGst
cW9yaXE6IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGZvcg0KICBseDIxNjBhIiBkZXNjcmlwdGlvbg0K
LSBQb3B1bGF0ZWQgY2FjaGUgcHJvcGVydGllcyBmb3IgTDEgYW5kIEwyIGNhY2hlIGluIGx4MjE2
MGEgZGV2aWNlLXRyZWUuDQotIFJlbW92ZWQgcmVib290IG5vZGUgZnJvbSBseDIxNjBhIGRldmlj
ZS10cmVlIGFzIFBTQ0kgaXMgaW1wbGVtZW50ZWQuDQotIFJlbW92ZWQgaW5jb3JyZWN0IGNvbW1l
bnQgZm9yIHRpbWVyIG5vZGUgaW50ZXJydXB0IHByb3BlcnR5IGluDQogIGx4MjE2MGEgZGV2aWNl
LXRyZWUuDQotIE1vZGlmaWVkIHBtdSBub2RlIGNvbXBhdGlibGUgcHJvcGVydHkgZnJvbSAiYXJt
LGFybXY4LXBtdXYzIiB0bw0KICAiYXJtLGNvcnRleC1hNzItcG11IiBpbiBseDIxNjBhIGRldmlj
ZS10cmVlDQotIE5vbi1zdGFuZGFyZCBhbGlhc2VzIHJlbW92ZWQgaW4gbHgyMTYwYSByZGIgYm9h
cmQgZGV2aWNlLXRyZWUNCi0gVXBkYXRlZCBpMmMgY2hpbGQgbm9kZXMgdG8gZ2VuZXJpYyBuYW1l
IGluIGx4MjE2MGEgcmRiIGRldmljZS10cmVlLg0KDQpDaGFuZ2VzIGZvciB2MToNCi0gQWRkIGNv
bXBhdGlibGUgc3RyaW5nIGZvciBMWDIxNjBBIGNsb2NrZ2VuIHN1cHBvcnQNCi0gQWRkIGNvbXBh
dGlibGUgc3RyaW5nIHRvIGluaXRpYWxpemUgTFgyMTYwQSBndXRzIGRyaXZlcg0KLSBBZGQgY29t
cGF0aWJsZSBzdHJpbmcgZm9yIExYMjE2MEEgc3VwcG9ydCBpbiBkdC1iaW5kaW5ncw0KLSBBZGQg
ZHRzIGZpbGUgdG8gZW5hYmxlIHN1cHBvcnQgZm9yIExYMjE2MEEgU29DIGFuZCBMWDIxNjBBIFJE
Qg0KICAoUmVmZXJlbmNlIGRlc2lnbiBib2FyZCkNCg0KVmFiaGF2IFNoYXJtYSAoNCk6DQogIGR0
LWJpbmRpbmdzOiBhcm02NDogYWRkIGNvbXBhdGlibGUgZm9yIExYMjE2MEENCiAgc29jL2ZzbC9n
dXRzOiBBZGQgZGVmaW5pdGlvbiBmb3IgTFgyMTYwQQ0KICBhcm02NDogZHRzOiBhZGQgUW9ySVEg
TFgyMTYwQSBTb0Mgc3VwcG9ydA0KICBhcm02NDogZHRzOiBhZGQgTFgyMTYwQVJEQiBib2FyZCBz
dXBwb3J0DQoNCllvZ2VzaCBHYXVyICgyKToNCiAgY2xrOiBxb3JpcTogaW5jcmVhc2UgYXJyYXkg
c2l6ZSBvZiBjbXV4X3RvX2dyb3VwDQogIGNsazogcW9yaXE6IEFkZCBjbG9ja2dlbiBzdXBwb3J0
IGZvciBseDIxNjBhDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zz
bC50eHQgICAgICB8ICAxNCArLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3Fvcmlx
LWNsb2NrLnR4dCAgICAgIHwgICAxICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9N
YWtlZmlsZSAgICAgICAgICAgICB8ICAgMSArDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWx4MjE2MGEtcmRiLmR0cyAgfCAxMTkgKysrKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgICAgIHwgNzY2ICsrKysrKysrKysrKysrKysrKysr
Kw0KIGRyaXZlcnMvY2xrL2Nsay1xb3JpcS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDE2ICstDQogZHJpdmVycy9jcHVmcmVxL3FvcmlxLWNwdWZyZXEuYyAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KIGRyaXZlcnMvc29jL2ZzbC9ndXRzLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA2ICsNCiA4IGZpbGVzIGNoYW5nZWQsIDkyMSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCg0KLS0gDQoyLjcuNA0KDQo=
