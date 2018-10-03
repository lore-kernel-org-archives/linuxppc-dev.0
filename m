Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F81C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 14:29:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449652089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 14:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MFLHsN8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449652089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QJLx28kjzF3BG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 00:29:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MFLHsN8l";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.2.74; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="MFLHsN8l"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0074.outbound.protection.outlook.com [104.47.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QJFs3fmNzF38y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 00:25:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKN+nnUxlq9Xm7N+BtqQbfNO4bCFgs2OLaf2jV5+2oA=;
 b=MFLHsN8l5YTWF/3SnKKvP338SjuoXs23YdqCnu7QqFnJWMgF0IqSF/oqYAO9iQG78WgHotp3i7wr1mzjDX2Vy+uVl9Mqi8TMk7CH5/tFHfwaddTVmBgumGzJ3S3CjnG+yeTg7WBITd7SuX8hsSeS0t2cYAZVXqiIf8wGNS5hfJY=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1SPR01MB330.eurprd04.prod.outlook.com (52.134.123.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Wed, 3 Oct 2018 14:25:11 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::a45f:ad96:edec:a2df]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::a45f:ad96:edec:a2df%3]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 14:25:11 +0000
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
Subject: RE: [PATCH v3 3/6] drivers: clk-qoriq: increase array size of
 cmux_to_group
Thread-Topic: [PATCH v3 3/6] drivers: clk-qoriq: increase array size of
 cmux_to_group
Thread-Index: AQHUVAAjrPmt5eIDZEqRxzptU7o1cKUK/VAAgAKkQbA=
Date: Wed, 3 Oct 2018 14:25:11 +0000
Message-ID: <VI1PR04MB48001B1FBCF455D690ACF58DF3E90@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-4-git-send-email-vabhav.sharma@nxp.com>
 <153843144041.119890.5558230475983572666@swboyd.mtv.corp.google.com>
In-Reply-To: <153843144041.119890.5558230475983572666@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1SPR01MB330;
 6:2QiM4sjSdvwoPs6bUWmeG/DenjxXXXsIXA82UIBZVuZtjXBYl+WNiQ5z+7CxVWjVnSNZWvDsADTDhTkcPtVzrBHbWtogMnyqPRjN0fTiXw2alEqoq65GfjOesVWKUQ+MpnU7cPwAh7RErfek111f1JB936dQzizWW4zXyfpT/3KxUIgdPkBakXYxakUAdnPv2MU5p7/Duwq2gIAa4Ukw/ZfBS2XYYpDkiSjwSgycip49j89iCuAmmpkF/8A07LRRYg1WzEZkw8Cn0lJw1YJzpJozHqZ4W6BuU7pCN+gtlSTSKlXugvy3NS5jA9cDrMfNA/8HDf55X7yjqLV4wX+hRgO8kgqYMiieTNLfxbYvf50zExTwnxCUys5H8HjsxFATM8pBybzlO5pQtfDoHuiFyLmafC2R9rbjXzHC/cu2jfmr8AO3HwiLZA5Vkv3haim/Hj2t+eOJtAlwB4RWVxk7Bg==;
 5:IhXTQqzHVFp4xFgSoVz5QbgffgmVbr86PriXWqUE5FbDdW21iCk/bmXYQUxs+pDThrd5O17oJx+qHSGP2NOCm50IXfUwtpMRzX84MOrVCB7gyCIs8mB0oclFxOTf/OhjlSn+lZBo4z/7r6oytPfeZcPasdemrA8z3vijDH9jcZE=;
 7:ITCIRdRGPKxqNEEoX/j7KNtsd1QMQKrLDbny5qzJQCsKe52OKYDw25ljco6jjOIw1t4kBMJQqA3vE7dQJHJnGyU5dddkcBBHh2mYLph3CeH3MMwQelW5DVMMhQ1d/5gpiOORsDqx6o3Sr08Gx5nOu/XtxEp+1xOJPGLUFEp5Ug3taPQfo7m3qr31SxZfkj0Ve1WVGGOYsrHLtDUaUVzffb6kWnD8IG4VVxGNHSkrNyHGzWCZFLaTkBc/78+K0btE
x-ms-office365-filtering-correlation-id: 8d957cbf-27f1-4c80-d4e6-08d6293c075d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1SPR01MB330; 
x-ms-traffictypediagnostic: VI1SPR01MB330:
x-microsoft-antispam-prvs: <VI1SPR01MB33093332A71AD51C67105A4F3E90@VI1SPR01MB330.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(65623756079841)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051);
 SRVR:VI1SPR01MB330; BCL:0; PCL:0; RULEID:; SRVR:VI1SPR01MB330; 
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(136003)(376002)(39860400002)(13464003)(199004)(189003)(6116002)(68736007)(66066001)(3846002)(14454004)(229853002)(97736004)(74316002)(256004)(86362001)(7416002)(26005)(186003)(2201001)(6506007)(53546011)(55016002)(9686003)(8936002)(5250100002)(25786009)(102836004)(2501003)(478600001)(53936002)(81156014)(81166006)(7736002)(305945005)(105586002)(106356001)(6436002)(446003)(54906003)(11346002)(4326008)(110136005)(2906002)(316002)(99286004)(476003)(8676002)(71200400001)(44832011)(6246003)(71190400001)(33656002)(486006)(76176011)(5660300001)(7696005)(2900100001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1SPR01MB330;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EtxfyytMkSKwJb5Zekojvsg/gPDtRfApopT0TfRk+UPLTxpgHJxoJ/ivgu5yFDA/OS688nU05Fj9CnTN09vSP6F/JCRsMWwVwAaoRi5Qa/6xKRuCcFY/YCM4BlhFy3mKdZ6PVCWMjfZ9oRzb4x7ccvLa+GNhUNhyBzbu/da8uehouw7wRQruSKB5vzPhS/McyHCLmsLtzgVXcnDZmBvvsHmMMY17e9zRu8dZ38ctJwOTb1ifAzM3foywJkcpQzlWoDHicCgpEcIQOW4F/Zvo2wmjAsMQu6HwXgxcarwfY1qNAtbG8tf0Wa6/CM8gJ0ok3Vo4dEKiwKgktESOg7dQOzFpukpj0pnJzHS+q2ijWZc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d957cbf-27f1-4c80-d4e6-08d6293c075d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 14:25:11.5995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB330
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
Cc: Udit Kumar <udit.kumar@nxp.com>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Varun Sethi <V.Sethi@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIsIDIwMTggMzozNCBB
TQ0KPiBUbzogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPjsgYXJuZEBhcm5k
Yi5kZTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOw0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsga3N0ZXdhcnRAbGludXhmb3VuZGF0
aW9uLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IG9zc0BidXNlcnJvci5uZXQ7IHJqd0Byand5
c29ja2kubmV0Ow0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IHN1ZGVlcC5ob2xsYUBhcm0uY29tOyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZzsNCj4gd2lsbC5kZWFjb25AYXJtLmNvbTsgeWFtYWRhLm1h
c2FoaXJvQHNvY2lvbmV4dC5jb20NCj4gQ2M6IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgVmFydW4g
U2V0aGkgPFYuU2V0aGlAbnhwLmNvbT47IFVkaXQgS3VtYXINCj4gPHVkaXQua3VtYXJAbnhwLmNv
bT47IFlvZ2VzaCBOYXJheWFuIEdhdXINCj4gPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPjsg
VmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDMvNl0gZHJpdmVyczogY2xrLXFvcmlxOiBpbmNyZWFzZSBhcnJheSBzaXplIG9mDQo+
IGNtdXhfdG9fZ3JvdXANCj4gDQo+IFN1YmplY3Qgc2hvdWxkIGJlICJjbGs6IHFvcmlxOiBpbmNy
ZWFzZSBhcnJheSBzaXplIC4uLiINCk9rDQoNCg==
