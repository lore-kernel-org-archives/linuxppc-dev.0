Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2FAC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 02:28:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D80D2085B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 02:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sSiymMOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D80D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WWx16Nw7zF2Dv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 13:28:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="sSiymMOB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe09::623;
 helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=peng.ma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="sSiymMOB"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on0623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WWsB0dMwzF3LC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 13:25:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEPuJYPNk1z0wLpvPnt4NGHi7SZhNYly9jlMcrLja5E=;
 b=sSiymMOBCKcFvA1Uwxrsd/kUoYNRv/CKm93ZWv7TkhdIOZ21a0qYam0OWeBEYwA1176HvdiQ2WrG9atQvYjqaH7e5XZky7hqmEQOzJk8W21mkJuundbR30jy7IXF0PfBHjMZ3SccpCzQN41Pp/7p91kfluyyqP3hE5YVlHFcIVE=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB3069.eurprd04.prod.outlook.com (10.170.228.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Fri, 12 Oct 2018 02:25:25 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::55f:bf59:aa19:6d15]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::55f:bf59:aa19:6d15%5]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 02:25:25 +0000
From: Peng Ma <peng.ma@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
 controller bindings
Thread-Topic: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
 controller bindings
Thread-Index: AQHUYUfnfef79U8+2U+c9ZUjA2cLVaUam2SAgABGYzA=
Date: Fri, 12 Oct 2018 02:25:25 +0000
Message-ID: <VI1PR04MB44310889ACCA73AFB29CAEEFEDE20@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181011094655.45707-1-peng.ma@nxp.com>
 <20181011094655.45707-7-peng.ma@nxp.com> <20181011220845.GA20860@bogus>
In-Reply-To: <20181011220845.GA20860@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB3069;
 6:8dEXN2xEyerHJTuoSNpch7HVorlqiZ8rmJRVFOFk4OlvDPhfxWMMpIgqCD5jiSzo5B8u4mQ1vBplr7FlcEb/UWbe2KZdKtNGWaxC2Ku/kM9fjRLOqPB2p4zCTHZny7qUZ5VyqbrFPHLLyLvulvkUG+DBQvBtUMcinXqsYxqk8EOM6GptMMfU9d1a0+ajpvggJ8RZpAHlnXpb+xb3fT4od9dXlynXsWiWzBfIt6OcHf1s/79MB+uTGW0yDwlUBpsGdbX4o/Pi7jwu5VoG3RPBBPYiW+ivQ+bAgFrWyaF9yY0rsPA25RA3ww1HZghAwWOtNUKtRnZxI/+aACjRvvWI2X9BAIT58k7N0km5vXb0ZoKGd0f2Fgao2qfzz4Ks+VQCTaprgvTnh2XXatp1rchLQmM9sf11LajtJjpjqZXsMAm2/gyy/vkDEI+DeFioaFG3fA6y3T0OJ2AJaL+jdpv3AA==;
 5:Ag/qYl2rWwL6QDzWMzfZ1rAgYK+/3AhVpm3t1lNJi/qjwL30hXXFeF5rl7zOVd2dD8zaf+ve0wNwEg7zztvQEXD99c7waIy6TnUTrVww7wU8Z3qeEqM3OYMFUODDRqoG12rhGurIYYY4F7os5zVdc2QaJLi7krmWjqNcclIWUx0=;
 7:N740wIJrl711C6XQ8Vd3ZD1EuMm+u/nYbF90hW8axUAEtBxnY5AOP/2JnK5bXidrqh2n3oph7WtH+kQhDndA6dzxLv9fKdGSPmgoT+uqHw+BpQSUqLDuQ8Ha65zLu5oYiH7eXr9ZpLklphrACVmC6lwO3ICCRMKtQppB5hWk9tNygO5nbaBqVj0zP6941OWDiZ4ajwRLqjgSFZzu2FGPN5xQp9zr7BuG7CaxljZx6uDaEhSrQma6iN/EyScSvkQU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 162b054a-f9c4-453b-9f95-08d62fe9f84a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB3069; 
x-ms-traffictypediagnostic: VI1PR04MB3069:
x-microsoft-antispam-prvs: <VI1PR04MB306921481739838D81228E27EDE20@VI1PR04MB3069.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(228905959029699)(9452136761055)(258649278758335)(65623756079841)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991067);
 SRVR:VI1PR04MB3069; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB3069; 
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(13464003)(81156014)(229853002)(71190400001)(9686003)(71200400001)(97736004)(6246003)(8936002)(486006)(14454004)(68736007)(305945005)(66066001)(81166006)(86362001)(256004)(26005)(478600001)(53546011)(102836004)(6506007)(186003)(55016002)(7696005)(6436002)(5250100002)(76176011)(106356001)(105586002)(446003)(2900100001)(25786009)(54906003)(53936002)(33656002)(476003)(7736002)(4326008)(8676002)(74316002)(6116002)(2906002)(5660300001)(3846002)(7416002)(316002)(44832011)(6916009)(11346002)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3069;
 H:VI1PR04MB4431.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: azP0XJEi05/VPKapS9CGcCdzLroOOULgXIosAS4nLAkz4M6rU25c0y/ps9C5VHgrQee68Z1Z3GdXxzzCkU+gIBnTx8fXckN4Lr9CvtdD6u4OS3JM7X1y6qbua374T2tMN2GquMh6jrnlx7XsBdvYFHZMC5yVwRVWlueMs6Axx6pjyglZ1hq1o0/c7Snv5A0KsB9N96Oct+3uXuF0PVqBzQpxXCI3YjpyvdqZoUgXk6WSdnTa4A2T/6IgSw1BZBxWII4HphErGp3pE14xXMu0TVfvSIqf3r6MLepEICxqWd663AOae9/pZpep4qAIKYesfFqMf8amoUQVy8LI7AcZbIx3+hZsIg0iuSm+E1egEyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162b054a-f9c4-453b-9f95-08d62fe9f84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 02:25:25.7128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3069
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "zw@zh-kernel.org" <zw@zh-kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Jiafei Pan <jiafei.pan@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm9iLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE4xOoxMNTCMTLI1SA2OjA5
DQo+IFRvOiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+IENjOiB2a291bEBrZXJuZWwub3Jn
OyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBz
aGF3bmd1b0BrZXJuZWwub3JnOyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IHp3QHpoLWtlcm5l
bC5vcmc7DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNy83XSBkdC1iaW5kaW5nczogZnNsLXFkbWE6IEFkZCBOWFAg
TGF5ZXJzY3BhZSBxRE1BDQo+IGNvbnRyb2xsZXIgYmluZGluZ3MNCj4gDQo+IE9uIFRodSwgT2N0
IDExLCAyMDE4IGF0IDA1OjQ2OjU1UE0gKzA4MDAsIFBlbmcgTWEgd3JvdGU6DQo+ID4gRG9jdW1l
bnQgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE5YUCBMYXllcnNjYXBlIHFETUEgY29udHJv
bGxlcg0KPiA+IHdoaWNoIGNvdWxkIGJlIGZvdW5kIG9uIE5YUCBRb3JJUSBMYXllcnNjYXBlIFNv
Q3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+
IA0KPiBXaGF0IGhhcHBlbmVkIHRvIHRoZSB2ZXJzaW9uIGZyb20gV2VuIEhlIHRoYXQgd2FzIG9u
IHY3IGFuZCB0aGF0IEkgYWxyZWFkeQ0KPiBnYXZlIG15IFJldmlld2VkLWJ5IG9uPw0KDQpbUGVu
ZyBNYV0gdGhlIGRtYSBvd25lciBpcyBjaGFuZ2VkIGFuZCBxZG1hIGRyaXZlciBtYWRlIHNvbWUg
Y2hhbmdlcywgc28gSSBuZWVkIHNlbmQgdGhvc2UgcGF0Y2ggYWdhaW4gdG8gcmV2aWV3IQ0KDQpC
ZXN0IHJlZ2FyZHMNCglQZW5nIE1hDQo+IA0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1xZG1hLnR4dCB8ICAgNTMNCj4gKysrKysrKysrKysr
KysrKysrKysNCj4gPiAgMSBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2RtYS9mc2wtcWRtYS50eHQNCg0K
