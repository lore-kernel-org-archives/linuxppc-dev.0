Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6569AC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 02:37:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1122075D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 02:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FZ17V701"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1122075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42jzKY72JQzDrbV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 13:37:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FZ17V701";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.1.51; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="FZ17V701"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0051.outbound.protection.outlook.com [104.47.1.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42jzGj5PwwzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 13:35:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chsoKbzEC5n5QwckkkjOexrmOQobjFoc3BPsMm2Heqo=;
 b=FZ17V7015Ktgtqcccr6p66h3u/wUIqUXGiXnGxE5iMoEKjreoK9h1PlLS0I5dlYfr1Hqrf4hjKqCk3cwVKrdPvtHIlwzuVSL3eGFSu5cQt3fo2jkQGKH3vJsp4aTWpDP4GVDQZnj7NF3vKkyoSthsmVIBwYILD9PXXkl39+Q0ik=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB1130.eurprd04.prod.outlook.com (10.162.27.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Mon, 29 Oct 2018 02:35:12 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63%2]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 02:35:12 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 3/6] PCI: layerscape: Add the EP mode support
Thread-Topic: [PATCH 3/6] PCI: layerscape: Add the EP mode support
Thread-Index: AQHUbFO/sDtxRLGmJUqv9XRnx7sCWaUwgXkAgABfTVCAADn2gIAABkeQgADbQ4CAA4oHwA==
Date: Mon, 29 Oct 2018 02:35:12 +0000
Message-ID: <HE1PR04MB1497239B4B6F8AA48E284F4FF5F30@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com> <20181025215246.GA14861@bogus>
 <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
 <HE1PR04MB14972C9176E68EEDBD3AD64BF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <CADRPPNRP5RORVr0O59=O-PhRRerirFkPeOmAcKq3pNumf4Mriw@mail.gmail.com>
In-Reply-To: <CADRPPNRP5RORVr0O59=O-PhRRerirFkPeOmAcKq3pNumf4Mriw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB1130;
 6:1cmPCZO9jvM5yQNmXc0wm3EbKV26D8vjU1OWIfspKq/O3ffq+1zzKVuuOUHLwgIFmU8OCgvWkMUwi27+HS8wp/JI5HHMIu+pSDf+jx6egAtvQWDB9YsAf11nI+7bI4oUlKxNb1OcYt+ngkPyFiW5JidlbhymYAF9ktxfTPfeDNDHd59ApjUcBSEYQVhIRjcIADjA4oW397HDAvE2iREm8j3BDJIv3JwZncK2LIKroV/9pLtek2ez6dHNP8gS7bhllgOl9GcWzl1G1K5lfaBAGiTVYbmbjlZM7MPEJV9ulomrrdtwBx6CMx1iPvDCwaORCPcp7YIYNO2NfkQIViS+S2k5UnhC6XrbVWr3Rphj4gwU6wXc7jI36xx/0ag/dPy+WYRXUgIjx1sP6TmjI7eKqhmP7ySW2rlCz1BoU9bnFVlyWt3e6/WSr9eP9uRkY/nAA7UzKBek+3v+FItbBb4jqg==;
 5:/lTuq8XvjWEJIthP+RqMlh4Mh0awsAeC7k41NtP+vnKvAIgoc8NeuckwOMUO9WLaucvD9F3yfyL2L3d+yRp70HlGpx7UOiiZj+9aTVCyyJtHkeHyFNgBmTEYMLluoUiV+o/gvpH+iLa2zY5+q2mvqSZv+CfJDr2Kzt8plqJFXvs=;
 7:v2ec+ZNmnkEYKo99LJJjsYjrGxUQsVFQMaLNF6uZcwuVp6hJFd2hpSrUujlnjRowh9B8UwsnZI1mBZHiUpM7++AnV1VZhnZg1Hk6/jim3TBqSaYsX5WJFrnQoMzLuZ+ly/ZU+2bCnAFXrmh6l3l7GQ==
x-ms-office365-filtering-correlation-id: 5a3471f1-283a-4ad1-23a1-08d63d4726fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB1130; 
x-ms-traffictypediagnostic: HE1PR04MB1130:
x-microsoft-antispam-prvs: <HE1PR04MB1130C1D1FCD1377A8D3F3913F5F30@HE1PR04MB1130.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(180628864354917)(58145275503218)(9452136761055)(85827821059158)(211936372134217)(258649278758335)(65623756079841)(185117386973197)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB1130; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB1130; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(366004)(39860400002)(346002)(136003)(13464003)(189003)(199004)(6246003)(54906003)(6346003)(5660300001)(6116002)(14454004)(33656002)(3846002)(26005)(68736007)(7416002)(97736004)(81156014)(6436002)(8676002)(99286004)(53936002)(81166006)(76176011)(9686003)(7696005)(93886005)(7736002)(8936002)(305945005)(55016002)(102836004)(74316002)(105586002)(106356001)(2906002)(2900100001)(6506007)(316002)(53546011)(25786009)(14444005)(256004)(6862004)(478600001)(476003)(486006)(44832011)(4326008)(229853002)(446003)(11346002)(5250100002)(71200400001)(186003)(66066001)(86362001)(71190400001)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB1130;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-microsoft-antispam-message-info: Vm/mX9yZa5Xq7Oc2JzGQDEhRB6jEPtrzb7nFQGoWrtCk866hijZ1LQzxFD+feAIhReLZt5hGFeijT80NEGHQXpSndFGNKKQqhuv13Id11xIboYQIydAHqnLo529O/YTu8JzFAeCWpe6LoqQKkRn7d/upg38Oo8wdxLop38YwH6fOUF4dwTu9rD7t3kBBxNccA7blb48kD28zIHR8ViLjKmBi9PsiY2DGeNm/V+z+9ddElv8dQiorbnlpReZMy6zQi14xi4OpuqqadwiG4GV9uu2TjyapnyeNw7884GTzW6lxNNhonVf3FfwogljQhj9k7FLINfWi/kG/RKwSKuWgvvNLfaIBFtvPf3jWHYEVgl4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3471f1-283a-4ad1-23a1-08d63d4726fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 02:35:12.0937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1130
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Roy Zang <roy.zang@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, "kishon@ti.com" <kishon@ti.com>,
 "M.h. Lian" <minghuan.lian@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Shawn Guo <shawnguo@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMaSBZYW5nIDxsZW95YW5nLmxp
QG54cC5jb20+IA0KU2VudDogMjAxOOW5tDEw5pyIMjfml6UgNDoyOQ0KVG86IFhpYW93ZWkgQmFv
IDx4aWFvd2VpLmJhb0BueHAuY29tPg0KQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNA
Z29vZ2xlLmNvbT47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBTaGF3biBH
dW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBraXNob25AdGkuY29tOyBsb3JlbnpvLnBpZXJhbGlz
aUBhcm0uY29tOyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
PjsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2Fp
Lmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT47IEthdGUgU3Rld2FydCA8
a3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZz47IGN5cmlsbGUucGl0Y2hlbkBmcmVlLWVsZWN0
cm9ucy5jb207IFBoaWxpcHBlIE9tYnJlZGFubmUgPHBvbWJyZWRhbm5lQG5leGIuY29tPjsgc2hh
d24ubGluQHJvY2stY2hpcHMuY29tOyBuaWtsYXMuY2Fzc2VsQGF4aXMuY29tOyBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERF
VklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxrbWwgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxF
IElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc+OyBsaW51eHBwYy1kZXYgPGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg0K
U3ViamVjdDogUmU6IFtQQVRDSCAzLzZdIFBDSTogbGF5ZXJzY2FwZTogQWRkIHRoZSBFUCBtb2Rl
IHN1cHBvcnQNCg0KT24gRnJpLCBPY3QgMjYsIDIwMTggYXQgMjo0MyBBTSBYaWFvd2VpIEJhbyA8
eGlhb3dlaS5iYW9AbnhwLmNvbT4gd3JvdGU6DQo+DQo+DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IGFybmRiZXJnbWFubkBnbWFpbC5jb20gPGFybmRiZXJnbWFubkBn
bWFpbC5jb20+IE9uIEJlaGFsZiBPZiANCj4gQXJuZCBCZXJnbWFubg0KPiBTZW50OiAyMDE45bm0
MTDmnIgyNuaXpSAxNTowMQ0KPiBUbzogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+
DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgDQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkg
DQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBraXNob25AdGkuY29tOyBsb3JlbnpvLnBpZXJhbGlz
aUBhcm0uY29tOyANCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IE0uaC4gTGlhbiA8bWlu
Z2h1YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSANCj4gSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47
IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsgDQo+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlv
bi5vcmc7IGN5cmlsbGUucGl0Y2hlbkBmcmVlLWVsZWN0cm9ucy5jb207IA0KPiBwb21icmVkYW5u
ZUBuZXhiLmNvbTsgc2hhd24ubGluQHJvY2stY2hpcHMuY29tOyANCj4gbmlrbGFzLmNhc3NlbEBh
eGlzLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgDQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNl0gUENJOiBsYXllcnNjYXBlOiBBZGQgdGhlIEVQIG1v
ZGUgc3VwcG9ydA0KPg0KPiBPbiAxMC8yNi8xOCwgWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54
cC5jb20+IHdyb3RlOg0KPiA+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+
ID4+IE9uIFRodSwgT2N0IDI1LCAyMDE4IGF0IDA3OjA4OjU4UE0gKzA4MDAsIFhpYW93ZWkgQmFv
IHdyb3RlOg0KPiA+Pj4gICAgICAgICAgImZzbCxsczIwODBhLXBjaWUiLCAiZnNsLGxzMjA4NWEt
cGNpZSIsICJzbnBzLGR3LXBjaWUiDQo+ID4+PiAgICAgICAgICAiZnNsLGxzMjA4OGEtcGNpZSIN
Cj4gPj4+ICAgICAgICAgICJmc2wsbHMxMDg4YS1wY2llIg0KPiA+Pj4gICAgICAgICAgImZzbCxs
czEwNDZhLXBjaWUiDQo+ID4+PiAgICAgICAgICAiZnNsLGxzMTAxMmEtcGNpZQ0KPiA+Pj4gKyAg
RVAgbW9kZToNCj4gPj4+ICsgICAgICAgICJmc2wsbHMtcGNpZS1lcCINCj4gPj4NCj4gPiA+IFlv
dSBuZWVkIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlcyBmb3IgdGhlIHNhbWUgcmVhc29ucyBhcyB0
aGUgUkMuDQo+ID4NCj4gPiBbWGlhb3dlaSBCYW9dIEkgd2FudCB0byBjb250YWlucyBhbGwgbGF5
ZXJzY2FwZSBwbGF0Zm9ybSB1c2Ugb25lIA0KPiA+IGNvbXBhdGlibGUgaWYgdGhlIFBDSWUgY29u
dHJvbGxlciB3b3JrIGluIEVQIG1vZGUuDQo+DQo+IERvIHlvdSBtZWFuIG9ubHkgb25lIG9mIHRo
ZSBTb0NzIHRoYXQgc3VwcG9ydCBSQyBtb2RlIGhhcyBFUCBtb2RlPw0KPiBJIHRoaW5rIHlvdSBz
dGlsbCBuZWVkIGEgU29DIHNwZWNpZmljIGNvbXBhdGlibGUgYXMgUm9iIGV4cGxhaW5lZCwgaW4g
Y2FzZSB0aGVyZSB3aWxsIGJlIGEgc2Vjb25kIG9uZSBpbiB0aGUgZnV0dXJlLg0KPg0KPiBJZiB5
b3Ugd2FudCB0byBlbnN1cmUgdGhhdCB5b3UgZG9uJ3QgaGF2ZSB0byB1cGRhdGUgdGhlIGRldmlj
ZSBkcml2ZXIgZm9yIGVhY2ggbmV3IGNoaXAgdGhhdCBjb21lcyBpbiB3aGVuIHRoZSBFUCBtb2Rl
IGlzIGNvbXBhdGlibGUsIHRoZSB3YXkgdGhpcyBpcyBoYW5kbGVkIGlzIHRvIGxpc3QgbXVsdGlw
bGUgdmFsdWVzIGluIHRoZSBjb21wYXRpYmxlIHByb3BlcnR5LCBsaXN0aW5nIHRoZSBmaXJzdCBT
b0MgdGhhdCBpbnRyb2R1Y2VkIHRoZSBzcGVjaWZpYyB2ZXJzaW9uIG9mIHRoYXQgSVAgYmxvY2sg
YXMgdGhlIG1vc3QgZ2VuZXJpYyB0eXBlLCBlLmcuDQo+DQo+ICAgY29wYXRpYmxlID0gImZzbCxs
czIwODhhLXBjaWUtZXAiLCAiZnNsLGxzMTAxMmEtcGNpZS1lcCIsIA0KPiAic25wcyxkdy1wY2ll
LWVwIjsNCj4NCj4gRm9yIGNvbnNpc3RlbmN5LCBpdCBwcm9iYWJseSBpcyBiZXN0IHRvIG1hdGNo
IGVhY2ggUkMgbW9kZSB2YWx1ZSB3aXRoIHRoZSBjb3JyZXNwb25kaW5nIEVQIG1vZGUgc3RyaW5n
IGZvciBlYWNoIGRldmljZSB0aGF0IGNhbiBzdXBwb3J0IGJvdGggKGlmIHRoZXJlIGlzIG1vcmUg
dGhhbiBvbmUpLg0KPg0KPiAgICAgICBBcm5kDQo+IFtYaWFvd2VpIEJhb10gTXkgbWVhbiBpcyB0
aGF0IHRoZSBscy1wY2llLWVwIGNvbXBhdGlibGVzIHdpbGwgY29udGFpbiBhbGwgbGF5ZXJzY2Fw
ZSBTT0NzIG9mIE5YUCwgZS5nOiBsczEwNDZhLXBjaWUtZXAsIGZzbCxsczIwODhhLXBjaWUtZXAs
IGxzMjA4OGEtcGNpZS1lcCBhbmQgc28gb24sIG90aGVyIGxheWVyc2NhcGUgU09DcyBoYXZlIG5v
dCB0ZXN0IGV4Y2VwdCB0aGUgbHMxMDQ2YSwgSSB0aGluayBpdCBpcyBjb21wYXRpYmxlIGlmIHRo
ZSBuZXcgY2hpcCBvciBvdGhlciBTT0NzIHVzZSB0aGUgRFcgY29yZSwgT0ssIEkgd2lsbCBkaXNj
dXNzIHRoaXMgaXNzdWUgaW50ZXJuYWxseSwgYW5kIHJlcGx5IHRvIHlvdSBsYXRlci4NCg0KWW91
IGNhbiBkZWZpbmUgYSBnZW5lcmljIGNvbXBhdGlibGUgc3RyaW5nIGZvciB0aGUgRVAgbW9kZSBv
ZiBhbGwgdGhlc2UgcGxhdGZvcm1zLiAgQnV0IGxpa2UgUm9iIGFuZCBBcm5kIG1lbnRpb25lZCwg
aXQgaXMgZ29vZCB0byBhbHNvIGRlZmluZSB0aGUgU29DIHNwZWNpZmljIGNvbXBhdGlibGUgc3Ry
aW5ncyBqdXN0IGluIGNhc2UgdGhhdCB3ZSBuZWVkIHNwZWNpYWwgdHJlYXRtZW50IGZvciBjZXJ0
YWluIFNvQ3MgaW4gdGhlIGZ1dHVyZS4NCg0KUmVnYXJkcywNCkxlbw0KDQpbWGlhb3dlaSBCYW9d
IEhpIExlbywgT0ssIEkgd2lsbCBhZGQgdGhlIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlIHN0cmlu
Z3MgaW4gcGF0Y2gtdjIsIHRoYW5rcyBhIGxvdC4NCg==
