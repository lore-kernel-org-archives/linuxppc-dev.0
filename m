Return-Path: <SRS0=6H9d=RF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19434C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 05:44:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3315520838
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 05:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HNUZ6nYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3315520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44BFbg2WZzzDqSy
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 16:44:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.42; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="HNUZ6nYx"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20042.outbound.protection.outlook.com [40.107.2.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44BFYl4q0dzDqN6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 16:42:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2kDrv2pfSsa7u7hkNHIbBl5rdPBsvHyWZQvjuiEDCU=;
 b=HNUZ6nYx9XY/yk/R1TfFIViJbv2H4g7rXsj4JY/7jcZFHIu4eeNRSzHqG9/hfv4kYIPtjePcJtfRljK+EA1yTPIF9x8u4uk3W1cpYMq+7EPSIt9D9aAlAT7Wvt3PoJVK31fRIzqtKzdUy+el4ltRHNSxBrsbRejPBHWDK85WJwE=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3373.eurprd04.prod.outlook.com (52.134.1.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Sat, 2 Mar 2019 05:42:39 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Sat, 2 Mar 2019
 05:42:39 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Timur Tabi <timur@kernel.org>, Matt Flax <flatmax@flatmax.org>, Nicolin
 Chen <nicoleotsuka@gmail.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Thread-Topic: [alsa-devel] [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Thread-Index: AQHUzypa4n8NriEugUOXybmAqJXINqX2NlEAgAAD5gCAABfc4IAAhtuAgAD9+nA=
Date: Sat, 2 Mar 2019 05:42:39 +0000
Message-ID: <VI1PR0402MB3392FB4321D229EC2F857FB5E3770@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301045041.GA5064@Asurada>
 <5c60b8c7-cb85-dec8-0358-6773251d3f2c@flatmax.org>
 <VI1PR0402MB3392CCF09FE75CE856C6174EE3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
 <de5ebabd-52a5-dedb-6710-8f09e1a4e380@kernel.org>
In-Reply-To: <de5ebabd-52a5-dedb-6710-8f09e1a4e380@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67914ae2-32b5-46a1-db4b-08d69ed1e211
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3373; 
x-ms-traffictypediagnostic: VI1PR0402MB3373:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjMzNzM7MjM6WHZuYVhhVjJRU1M0QTlpUVRTTHJqczk4?=
 =?utf-8?B?NUlKYTQ2Wjl2S0UwVFJ6UmU4NXZOSDhlaU5IeXlDQjNHQldCL3lNS2ovQXY5?=
 =?utf-8?B?ZW1OZmIveVdMNWp4Vmk0OUZNSEtCSkVGbzhTU1M0UlZSV2xqMmtIUC8wZ1V4?=
 =?utf-8?B?K0R4L1VSVWxHOU50dWxnRStjNktqeE5yOUwyS1Z5NEdJQ1ZraWQ4NllGUzlV?=
 =?utf-8?B?MFlZNFM4cmdhZnBsdUsxMC9XRVNIaW5BZXFsN2k3WGlRaVNJZlFQbm5xT3ps?=
 =?utf-8?B?ZGU5c3lDYzI3NEcyNitzUGNYVWdkclBPMDd1bGl4VzFzSk5ueHBVc2ljbXJC?=
 =?utf-8?B?ZWlIb21RMWcwdjBwVk9kckJZdDlYUkUzaGp5MlVZL3hHMEVrUW5Ta2hsWmhr?=
 =?utf-8?B?aFRpOXF6QUZMWVBkV0llM0IvZTNNczA1SmZMeFl4RVd4VklzV1gxOFN2cTQz?=
 =?utf-8?B?NndaeW8zMmtvSFBGa3dvZ3FJcGlpTXRJaDV2QVoxUDFwbkVDQ24rYjh1aXZK?=
 =?utf-8?B?azlJeTZDYUsvdkhmWmw3VWx2dzd3TUFoV2VScDZTakJKSTRiTXoxQXJ4LzBE?=
 =?utf-8?B?bHFHdjY0eEtvMFFJc1MzNFpQMGVCR2ZIYXNNUHQvMDl6TVpMTnZkNmVGenIz?=
 =?utf-8?B?V0NTWGtTclpiM3pveVFCbWw5VW5ISC84ejdWM0xTRnREWFBzRm9kTWJBMTdX?=
 =?utf-8?B?VlVpQTFacnY1akllQzZmajlwVTRENWVzODl3VllDYzBWaHJtajVrUHVldy9L?=
 =?utf-8?B?NjNVQWZWUWhxdU45WVZOYWJTRWFOcTNuQnpSb1Q4eTRqK0p6aDJIbkozUHZo?=
 =?utf-8?B?aEZqRUxESDliTW0rNktRd3dsRGllcFFVYmpvU1lCNXMvY2ZJYThRQU1WeVlZ?=
 =?utf-8?B?aUdCNmQ2R3QrS29oeStrZDQxa0tyQ3NXSWlDWG1LcW9MejdlQ1piYzhTRGgz?=
 =?utf-8?B?TS9xN2xZQmJZOHhSMkhXV0NSLzVKM1lzYlQrZ3MwdElkb0VXdUhnNlR4Sk9G?=
 =?utf-8?B?ejdwdVVUVTJZWDhxMGtVbGR5aFVUb096bDEwWDBOZ3RlWWxyRHVoRWJXOHBu?=
 =?utf-8?B?WnNreXhKRTNqVkV0cDd4OTBDMzhlcmJyWU5Wd2oyVFkvZExVTjh3WWp1Mk1m?=
 =?utf-8?B?WnhHd0JzSlBXejVxVGdZMEZlK29CLzFSWU1HZjhSRTFhdDU0M29BK1hWQkI2?=
 =?utf-8?B?d1lwU0RsK3pEazZVTjFnMkFKVG91V1JGeFdRcStYdUQzMTJOQ05Fek1DcVha?=
 =?utf-8?B?MTVRTFVhUE9wYnFxVVJsMGRRZGxkLzU1WkUxTFF5UXFNMnFTcGhrUlBjVzlK?=
 =?utf-8?B?aHMvWmt2Zlh1YnpRdEhVOW15emtSUjRMakdtZXVxOEhDcDQ4K2NCVnE4K1JP?=
 =?utf-8?B?Z3h6RXloU1RHclpRRmtZRW5EWmVQV1NHMzBEN0FmSUFVN0w1bExjWFVoRCs5?=
 =?utf-8?B?RTZvbFAybFhaL0ZYYlcrOStBWU55NkVkSFQrWE1ZU2NBL0o3U2hITHFiWXpF?=
 =?utf-8?B?Z28zM1htdEZYa2VvY3dtSnM4SmdXdkFHRnBKUW1tSlZYTVN6a0Fha1M0N1dx?=
 =?utf-8?B?OFVRb1E1RjRsMXQrNitLMUdyMnoyTFV3c3l1eCtaYXBvRE1FTllsMDFCemla?=
 =?utf-8?B?WUJYZWhBM1pwL29kYjJOc0Q1QXdWMTRrTXdMSDNkcTZqalQvQ1F2Mm02WGEy?=
 =?utf-8?Q?JQUlShqfEi4nyViRLoNp+4u+QrX0+t3Q4JPdxSnZk?=
x-microsoft-antispam-prvs: <VI1PR0402MB3373A19E9388C25EC44BA787E3770@VI1PR0402MB3373.eurprd04.prod.outlook.com>
x-forefront-prvs: 09645BAC66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(199004)(11346002)(446003)(4326008)(66066001)(486006)(476003)(25786009)(229853002)(2906002)(33656002)(93886005)(110136005)(54906003)(316002)(7696005)(102836004)(53546011)(6506007)(76176011)(99286004)(7736002)(97736004)(305945005)(81156014)(6116002)(8676002)(74316002)(81166006)(3846002)(186003)(26005)(86362001)(14454004)(9686003)(55016002)(478600001)(4744005)(53936002)(8936002)(68736007)(105586002)(106356001)(52536013)(6246003)(71190400001)(71200400001)(5660300002)(6436002)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3373;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cT7DLTShyNhP0yvYTdc/m+0PB4kjDqgvsBUOkuxS5rFd4BbCYdSKCj4l6HwebvtIM64IurNt1ftPASQ48koz5zV52TjAuaRuBWmnbpHiqy6iVHSoiI+It9po10aWgrC4rPG9jcYoSn5bRmtba13SgYcwMgnKI2I7VgSqgHRokbRi3dEDqWjvQde/2uXyzZC3DzMOmYJxT/ARmE9t8Qgrl8CYwEGK+ApIBOeSyaJSvcN60ZtT6NtvhqILwc5QBdvML7tYoRgTfRNsc81ph7Y1wUIunRLMN2iqY0n1QR6Na+5dl297z9UFbG1NDplGtTAXLk64TQIeANfbcnzGH8ZYDUjGEJOdDXq+I5elH9YkbjLfwKJMdnQWpfkwyDFJNNWwTIZzGuytaW5SC795Kw673DWvShnPbtdZylxXxaGXbuA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67914ae2-32b5-46a1-db4b-08d69ed1e211
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 05:42:39.6477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3373
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkNCg0KPiBPbiAzLzEvMTkgMTI6MzIgQU0sIFMuai4gV2FuZyB3cm90ZToNCj4gPiBUaGlzIGNh
c2UgaXMgY292ZXJlZCBieSBTMjRfTEUgSSB0aGluay4gIFRoZSBTMzJfTEUgbWVhbnMgdGhlIGRh
dGEgaXMNCj4gPiAzMmJpdCBhbmQgc2xvdCB3aWR0aCBJcyAzMmJpdCwgdGhpcyBpcyBub3QgaW4g
ZGF0YSBzaGVldC4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgaWYgeW91IGhhdmUgMzItYml0
IHNhbXBsZXMgaW4geW91ciBhdWRpbyBmaWxlLCBhbmQgeW91DQo+IHdhbnQgdG8gcGxheSB0aGVt
LCB0aGVuIHNvZnR3YXJlIChlLmcuIGFsc2FsaWIpIHdpbGwgbmVlZCB0byBjb252ZXJ0IHRoZQ0K
PiBhdWRpbyB0byAyNC1iaXQgYmVmb3JlIHNlbmRpbmcgaXQgdG8gaGFyZHdhcmUuICBUaGlzIGlz
IHVubmVjZXNzYXJ5IGJlY2F1c2UNCj4gdGhlIGhhcmR3YXJlIGNhbiAiY29udmVydCIgdGhlIHNh
bXBsZSB0byAyNC1iaXQgYXV0b21hdGljYWxseSBieSBpZ25vcmluZw0KPiB0aGUgbG93ZXIgOCBi
aXRzLg0KPiANCj4gSSB0aGluayBhIGxvdCBvZiBjb2RlY3MgZG8gdGhpcyBhbHJlYWR5Lg0KDQpP
ay4gVGhhbmtzIGZvciByZXZpZXdpbmcsIEkgd2lsbCBkcm9wIHRoaXMgcGF0Y2guDQoNCkJlc3Qg
cmVnYXJkcw0KV2FuZyBzaGVuZ2ppdQ0K
