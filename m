Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5525DC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 02:57:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0872145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 02:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZOM8ckWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0872145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x2vq6J7XzF3VH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 13:57:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZOM8ckWL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.68; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZOM8ckWL"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20068.outbound.protection.outlook.com [40.107.2.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x2qQ1chtzF3JT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 13:53:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoduL1bxcjNPhSL4ShAObVyNYI2ERIxmNgSc4rWqosk=;
 b=ZOM8ckWL10h0jPSC+VCm2x9SpuxG1OhNi711Gxu/tR0EfkM55YYkx6LZ4n+xvpE2XNQpPu6lzdp32cYW1SwZ8E+YaWETXhkCTlf4tCN/h7sLlqcOuzaWqdbdVPpwU6yWs+PNvVfo6eSRWARirVJIjEzI+yNkyw18z4u3Cx1NdRU=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB2156.eurprd04.prod.outlook.com (10.166.76.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Fri, 16 Nov 2018 02:53:28 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63%3]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 02:53:28 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCHv2 2/6] ARM: dts: ls1021a: Add the status property disable
 PCIe
Thread-Topic: [PATCHv2 2/6] ARM: dts: ls1021a: Add the status property disable
 PCIe
Thread-Index: AQHUdOS6eWjSmPoiiEaa5mz4E7WpA6VRxKiAgAAAUlA=
Date: Fri, 16 Nov 2018 02:53:27 +0000
Message-ID: <HE1PR04MB14978A52D5F8E15B305EC8E9F5DD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
 <20181105084653.26597-2-xiaowei.bao@nxp.com> <20181116025106.GE5829@dragon>
In-Reply-To: <20181116025106.GE5829@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB2156;
 6:Lg87fK05nSiilPnK4rT27kKmZbhK12rwSsJqITjHlwApodrtpyeTZpUOpGtD39ndO0UsC6dz5mnB66xtZL2anUErbwer6rLM28ziltTNhZfFurwgXYh9gbQBo6uwCKQ7AO/01gBbB6UgulZbuOENV14GGuN6+sqfAFbkIRThDFbaNXrdbR9ziS7TM3gAFsc0asKQYwZLBoF4+5L5bchAAINnGE4xMQT2h5NJfu8P9c7WPrsvH05QlgaWlizFO3til5swl7Fb3ODNJGteJDYYrqVDunKyWJAAtHQtZhus5vMfQFqf2A/dO9WxrhPkYyQA53Qq6d5hY+EObiK2glHqqY6C3VDkXhQqhyd1/9jplvdxG9dWGMvn+h73a8XC+Jf5mESyo8AfPZ0v7Ki1iSucaR4t6FVApkV3sWblwfhExAHwPhmL92K5bSdnfj9By3salfr7nEi7OEFHcf5vhyvqTQ==;
 5:z6+5YW/o8R3ZG5BaWZ29hDPCnpQHQ3LqkIGPIMiLNpQAA3MAyfRNyJ5TLLM8HN3UfLwr5rzj2EIV5zlrCuntN27rpl9gBslc11pMPiImp1cNN9Z/wSSPF4jExVduYY7yudKq4h7g6Ey/yed5VG/tMxJDfaXO4CKu18kXpnZoSEQ=;
 7:YLzFAVvoi1sgO+matr5RLrBw382Vy1IzzzO0w2GbhavFD35G7b0ihBbE+A7BoRL22CN2R0KstUB1QbKKtFcJwLDmiLIXmlDDqDzD7duHlDlcXxCaFHPDzoNWNXc1UXdQJx7tRh933ZVrirNE2I4eag==
x-ms-office365-filtering-correlation-id: 42dc0397-5ef4-47d8-d11c-08d64b6eaf70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB2156; 
x-ms-traffictypediagnostic: HE1PR04MB2156:
x-microsoft-antispam-prvs: <HE1PR04MB2156814C0DD2C607FA1988C7F5DD0@HE1PR04MB2156.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(180628864354917)(31051911155226)(58145275503218)(9452136761055)(258649278758335)(65623756079841)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB2156; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB2156; 
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(13464003)(68736007)(5660300001)(7736002)(6916009)(6436002)(8676002)(7416002)(74316002)(229853002)(105586002)(106356001)(2906002)(305945005)(8936002)(81166006)(81156014)(97736004)(25786009)(4326008)(66066001)(71190400001)(71200400001)(55016002)(478600001)(3846002)(6116002)(6246003)(9686003)(14454004)(33656002)(2900100001)(76176011)(53936002)(256004)(102836004)(7696005)(186003)(99286004)(486006)(44832011)(446003)(26005)(53546011)(476003)(316002)(11346002)(6506007)(86362001)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB2156;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OJrtvjt2HTvdIZkvdk0b4m73TbVBzOAJPPDBVQG1hAGHpO8Ig4lR3DbOs8+IU1zZkC4rF//V1yQYDtqg2mU2YgaiLz4UfkGX0ChX8vG3aqSDyC+hEO0n7eWzF7f5xnZlMgLiVmEUv99miUObUIOPGPNz/V2Yf9rIpyG3SQ5qGOakr/VyctSfftLVyWnSYzlzr5rThBNnswfjRmJ6QIQRePw8GRA/jrwp8CBCjyfgkVVaVhKWBDEtDTSrvlTiEOzm6m7uQRQzsnBv8mNI2pcdiz2NFS1sPwWZNqD524lgTz5Py3anD1ottbb+2FBMm3iTusT4D3df08hw8zYM9LGnfQRAX3nDUgBfM4O7cYk7D58=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc0397-5ef4-47d8-d11c-08d64b6eaf70
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 02:53:27.8863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2156
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Roy Zang <roy.zang@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgU2hhbnduLA0KDQpUaGFua3MgYSBsb3QuDQoNCkJlc3QgcmVnYXJkcw0KWGlhb3dlaQ0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJu
ZWwub3JnPiANClNlbnQ6IDIwMTjE6jEx1MIxNsjVIDEwOjUxDQpUbzogWGlhb3dlaSBCYW8gPHhp
YW93ZWkuYmFvQG54cC5jb20+DQpDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJu
ZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+
OyBraXNob25AdGkuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBhcm5kQGFybmRiLmRl
OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54
cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95Lnph
bmdAbnhwLmNvbT47IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGN5cmlsbGUucGl0Y2hl
bkBmcmVlLWVsZWN0cm9ucy5jb207IHBvbWJyZWRhbm5lQG5leGIuY29tOyBzaGF3bi5saW5Acm9j
ay1jaGlwcy5jb207IG5pa2xhcy5jYXNzZWxAYXhpcy5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBjLWRl
dkBsaXN0cy5vemxhYnMub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIdjIgMi82XSBBUk06IGR0czog
bHMxMDIxYTogQWRkIHRoZSBzdGF0dXMgcHJvcGVydHkgZGlzYWJsZSBQQ0llDQoNCk9uIE1vbiwg
Tm92IDA1LCAyMDE4IGF0IDA0OjQ2OjQ5UE0gKzA4MDAsIFhpYW93ZWkgQmFvIHdyb3RlOg0KPiBB
ZGQgdGhlIHN0YXR1cyBwcm9wZXJ0eSBkaXNhYmxlIHRoZSBQQ0llLCB0aGUgcHJvcGVydHkgd2ls
bCBiZSBlbmFibGUgDQo+IGJ5IGJvb3Rsb2FkZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFv
d2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCg0KQXBwbGllZCwgdGhhbmtzLg0K
