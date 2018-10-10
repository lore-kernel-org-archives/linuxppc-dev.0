Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C6C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 09:37:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A3520835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 09:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A3520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VTX04ngJzF1S0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 20:37:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=st.com
 (client-ip=62.209.51.94; helo=mx07-00178001.pphosted.com;
 envelope-from=patrice.chotard@st.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=st.com
X-Greylist: delayed 876 seconds by postgrey-1.36 at bilbo;
 Wed, 10 Oct 2018 20:34:45 AEDT
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VTTK5qv1zF1QC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 20:34:44 +1100 (AEDT)
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9A9FHkl000534;
 Wed, 10 Oct 2018 11:19:16 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2n0se6p1h4-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 10 Oct 2018 11:19:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 17ECA3A;
 Wed, 10 Oct 2018 09:19:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C1B7A2A21;
 Wed, 10 Oct 2018 09:19:14 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Oct
 2018 11:19:14 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 10 Oct 2018 11:19:14 +0200
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Rob Herring <robh@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 32/36] dt-bindings: arm: Convert ST STi board/soc bindings
 to json-schema
Thread-Topic: [PATCH 32/36] dt-bindings: arm: Convert ST STi board/soc
 bindings to json-schema
Thread-Index: AQHUXMzM1NtcA3SB1EW1oq/y0cRgRKUYGX2A
Date: Wed, 10 Oct 2018 09:19:14 +0000
Message-ID: <34e8ddcb-4b33-9082-b242-9ab2dee8eb7c@st.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-33-robh@kernel.org>
In-Reply-To: <20181005165848.3474-33-robh@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FC3997611AF2B40B01C81BF1D93C36E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-10_07:, , signatures=0
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm9iDQoNCk9uIDEwLzA1LzIwMTggMDY6NTggUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBD
b252ZXJ0IFNUIFNUaSBTb0MgYmluZGluZ3MgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29u
LXNjaGVtYS4NCj4gDQo+IENjOiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5j
b20+DQo+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiBDYzogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL3N0aS50eHQgfCAyMyAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vc3RpLnlhbWwgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0K
PiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vc3RpLnR4dA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vc3RpLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3N0aS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL3N0aS50eHQNCj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGlu
ZGV4IDhkMjdmNmIwODRjNy4uMDAwMDAwMDAwMDAwDQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vc3RpLnR4dA0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDIz
ICswLDAgQEANCj4gLVNUIFNUaSBQbGF0Zm9ybXMgRGV2aWNlIFRyZWUgQmluZGluZ3MNCj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtDQo+IC1Cb2FyZHMgd2l0
aCB0aGUgU1QgU1RpSDQxNSBTb0Mgc2hhbGwgaGF2ZSB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6
DQo+IC1SZXF1aXJlZCByb290IG5vZGUgcHJvcGVydHk6DQo+IC1jb21wYXRpYmxlID0gInN0LHN0
aWg0MTUiOw0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0aGUgU1QgU1RpSDQxNiBTb0Mgc2hhbGwgaGF2
ZSB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6DQo+IC1SZXF1aXJlZCByb290IG5vZGUgcHJvcGVy
dHk6DQo+IC1jb21wYXRpYmxlID0gInN0LHN0aWg0MTYiOw0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0
aGUgU1QgU1RpSDQwNyBTb0Mgc2hhbGwgaGF2ZSB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6DQo+
IC1SZXF1aXJlZCByb290IG5vZGUgcHJvcGVydHk6DQo+IC1jb21wYXRpYmxlID0gInN0LHN0aWg0
MDciOw0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0aGUgU1QgU1RpSDQxMCBTb0Mgc2hhbGwgaGF2ZSB0
aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6DQo+IC1SZXF1aXJlZCByb290IG5vZGUgcHJvcGVydHk6
DQo+IC1jb21wYXRpYmxlID0gInN0LHN0aWg0MTAiOw0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0aGUg
U1QgU1RpSDQxOCBTb0Mgc2hhbGwgaGF2ZSB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6DQo+IC1S
ZXF1aXJlZCByb290IG5vZGUgcHJvcGVydHk6DQo+IC1jb21wYXRpYmxlID0gInN0LHN0aWg0MTgi
Ow0KPiAtDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL3N0aS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9zdGku
eWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjEwODE0
MzM0Y2ZjOQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vc3RpLnlhbWwNCj4gQEAgLTAsMCArMSwyMyBAQA0KPiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogTm9uZQ0KPiArJVlBTUwgMS4yDQo+ICstLS0NCj4gKyRpZDogaHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYmluZGluZ3MvYXJtL3N0aS55YW1sIw0KPiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsN
Cj4gK3RpdGxlOiBTVCBTVGkgUGxhdGZvcm1zIERldmljZSBUcmVlIEJpbmRpbmdzDQo+ICsNCj4g
K21haW50YWluZXJzOg0KPiArICAtIE1heGltZSBDb3F1ZWxpbiA8bWF4aW1lLmNvcXVlbGluQHN0
LmNvbT4NCg0KTWF4aW1lIGhhcyBsZWZ0IFNUTWljcm9lbGVjdHJvbmljcywgeW91IGNhbiByZXBs
YWNlIGl0cyBlbWFpbCBieSBtaW5lDQpQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBz
dC5jb20+DQoNCg0KVGhhbmtzDQoNClBhdHJpY2UNCg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiAr
ICAkbm9kZW5hbWU6DQo+ICsgICAgY29uc3Q6ICcvJw0KPiArICBjb21wYXRpYmxlOg0KPiArICAg
IGl0ZW1zOg0KPiArICAgICAgLSBlbnVtOg0KPiArICAgICAgICAgIC0gc3Qsc3RpaDQxNQ0KPiAr
ICAgICAgICAgIC0gc3Qsc3RpaDQxNg0KPiArICAgICAgICAgIC0gc3Qsc3RpaDQwNw0KPiArICAg
ICAgICAgIC0gc3Qsc3RpaDQxMA0KPiArICAgICAgICAgIC0gc3Qsc3RpaDQxOA0KPiArLi4uDQo+
IA==
