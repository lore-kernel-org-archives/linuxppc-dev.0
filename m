Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 03:47:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C6E20838
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 03:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kMCvWJky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C6E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449b2Y4Zd0zDqRy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 14:47:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.74; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="kMCvWJky"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449b0h2SjHzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 14:45:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoZggR4dsaoCtJNZtxC8WX32ahY/HZ9p1vut7sERVR0=;
 b=kMCvWJkyEjaO86fD0uF+eJ1ckcqmNT5yTSC106Buo093GeuFeXOsWNfkNCI/kSipYo0cPu1m2KIqIZW89vbtnHdR/3K2I1gKJ5d++/arXdVDdC1j73jfy9E0UAkijxokc5a5f0o9ZopIwXuOUuxhwVzltn7In9VK8iMI6Es+8mA=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3903.eurprd04.prod.outlook.com (52.134.17.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Fri, 1 Mar 2019 03:45:13 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 03:45:13 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Timur Tabi <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: RE: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Thread-Topic: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Thread-Index: AQHUzypa4n8NriEugUOXybmAqJXINqX1RtmAgADav5A=
Date: Fri, 1 Mar 2019 03:45:13 +0000
Message-ID: <VI1PR0402MB33925A2019ADC89B89BF3E91E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
 <ab0a0d6c-4905-328c-0e22-931c045ed8d9@kernel.org>
In-Reply-To: <ab0a0d6c-4905-328c-0e22-931c045ed8d9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 585b4424-62d2-4dde-bef5-08d69df84fe9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3903; 
x-ms-traffictypediagnostic: VI1PR0402MB3903:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjM5MDM7MjM6WVlpSHdVcmM4QkJKek9xNDMxKzE0Z3Fl?=
 =?utf-8?B?VXZ3TnBaQ1JwOWRUS2xZK0tHWVdiTjdTS05FL0tXSWRZSXhRWWZkZ1BaNmJO?=
 =?utf-8?B?eGVNZkFxOS9FOGJuTTN2Qis4MDJLR3RncDFhWUhqajZTcGlPTHRrTW96MlBn?=
 =?utf-8?B?bjlwOCtZNk16ZmxOM0dJeVZaNkdZalJ6RGM3UzN2eHJqazhSaE0zVkpVRFpZ?=
 =?utf-8?B?RndhemVhWVB5dVhrTUtUYm5TMnROQXBsNHo3VlV1MEtyWkJLN3RrQnBVT01j?=
 =?utf-8?B?ditNbVM1TjVTSnFrc0FxazhuMG1JVCtyazIwdjRSWUl0aklaNmZWb1kwNHdw?=
 =?utf-8?B?aSsxNkxFaVdkVVowa1NZbzVxWDJ0OUxUdnhKbmxuVDBOMWFFcnQyQTRkWDh5?=
 =?utf-8?B?RnFwOTd5NTVkTzMxMnRNWThyU3NVeU83VzBUWXQ4d3EwSXQrZ0Qyd2E2b2ps?=
 =?utf-8?B?YVdJVVR5cE0vb3h1OVRWZkVRMkZUUXIrY3p0YldCUE1tUktOOEZuSGx0Wld3?=
 =?utf-8?B?bFdDdTUveUJIYXRVS1ZPclRWMzBHbE1MdzRXVWNwV2gySDdoQnNnREkxVXlF?=
 =?utf-8?B?Mm9DOGozYXV2aW5EOUtweFkvbVoxd2ExTmxvU2RwQ1ZZNExkbUR3d2xaZ2FZ?=
 =?utf-8?B?cnQ3WXYwZ1VRNFNpYnl3d25Ia0xVdDdPdmtXaUx6dXp2VEU0Z0luMk1OdU9u?=
 =?utf-8?B?d21Mb0xCNkVBSjNka2xXbHNEbVRCUTg1MmtNNEJNZlBQcnZLTndaRDR5Q3Er?=
 =?utf-8?B?SVF0cXRmSk5OM3FCTUdCVDlQWXdXeURDSmRVbUdST04waTB3OFJtY3ZuTkxt?=
 =?utf-8?B?dGNLT3FWZnhFRjhnRnVpN05tam5QYmFwSXk3ZVhlcy9VbE00blFDYVZHdTV6?=
 =?utf-8?B?TmlaSGlINXAvdXRwN2EzQTZ4aFlCK1BHMDNLcFVJdXl6Ky85cmdVTHk0MnVS?=
 =?utf-8?B?QUhHSzJjOUg4SHZxQ0VWYmxEVXJNaWlZODhCck5jOG05Uk1jaG1pMTl2Y0Fy?=
 =?utf-8?B?TGwzS0ptb0xIeEw0NlZWODFZYjJKWE1hcVRTeUJ4Q3NOM3hURjlkdnljZWpN?=
 =?utf-8?B?KzYvN2p1OTRzQVM1SnJjKzhIOGFHSmdKZzA5Z2JBTUY4a2E4Zk5DVXBYaFM4?=
 =?utf-8?B?b2dMREk2T2xNMkZRaTFmODl6UzNPcjZQcmNLVjNOMnFuc2JtaHBkVGFrSm1n?=
 =?utf-8?B?ZDU2eE45OGJvQ2xKZmhBNXBtdmdUOU45QXp4SFdSNzdrL0VxUE5zRWhLc0xa?=
 =?utf-8?B?T04wU0NlMk96Rm45c0xDN3VHN0JUSWhPZ0QzVEVTT2U0ZmpIT1hNeCt0WEFJ?=
 =?utf-8?B?WW9jR2IwQ2NUUDV5OW1wOEtsY09YSWdBcGM2ZkVhdVEyQU5TcnVMeXNrSnRW?=
 =?utf-8?B?VkVLUHNLWDkyWkYwN0VkVUNoZ1ZXYkNSTkJVZWdrUyt6TzM5ckw1UTA2TThG?=
 =?utf-8?B?bmFCYkVoSWZaa3hBcG5FV2VHNnF6UWc4a0RIb0VRd29NellGS0gxN0pPUUdm?=
 =?utf-8?B?WUlycncxVUJwejZXWWVBV2llR0ZlZE1sSUJrMlFvK1pKaUZSTU02bHdJOEtZ?=
 =?utf-8?B?amRrNVY1V2VQQ3haU0hvOXpBdkszME0xK1FDSTk1WDZKMmZTeFhUYXltQTdj?=
 =?utf-8?B?MGRkRXhNOUhQZTU1NnRCNjJmNk9KRUluMzkyenI1cVh6bURzamVYa3E3aUZz?=
 =?utf-8?Q?WEJHFuQyFCrLDRiqgfTE=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3903E0BDEF75900AB30C03B0E3760@VI1PR0402MB3903.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(199004)(189003)(2201001)(105586002)(97736004)(26005)(110136005)(71200400001)(71190400001)(66066001)(52536013)(478600001)(2906002)(33656002)(5660300002)(6506007)(99286004)(76176011)(68736007)(53936002)(2501003)(7696005)(102836004)(316002)(55016002)(9686003)(8936002)(86362001)(6436002)(4744005)(81156014)(305945005)(486006)(186003)(476003)(8676002)(6116002)(81166006)(446003)(3846002)(229853002)(14454004)(256004)(106356001)(4326008)(74316002)(11346002)(6246003)(25786009)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3903;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mxtQftBPz2tqnbIWrm1HTjRaBrqH1yA5SJyJR1zGhoR+LeaZ+HPiFE6lFgFVFmrYSfn8V4etYZ0mWLHqHojRIMY5FUQJJT5uVURlp6gz39mMUFParQ0kZlxv7ZpkDi2t5rtFLcVA2hzV9ig+7jdeI4nGCHBafeBzaar0ykiIFc9wZkkFoi3Fj8H1nzzcyQYBwr6u2/WphQn/K3Dw+WwRVpJlaF1c5m1suQ6N4XhTREfy8BJdXxpnQWN/jz24TGuzCSRC51Som4x5YfW9JxMDINGwBNCmzPpsYhxa/CpZ3JGCExeuubPk5iBOIZPYKDdaa120mU2l0x8j9X0Oz6uzp8QbAmGxQqtJNVPGkjL2pxnv1EW0jIYYvKvEuKe69+wGu4g7QZ8G19faMteKPT0lhri+kAZGMZK4K+i9SkZPT+I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585b4424-62d2-4dde-bef5-08d69df84fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 03:45:13.6542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3903
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkNCg0KPiA+IGNzNDJ4eDggaXMgYSAyNC1iaXQgQS9EIGFuZCAyNC1iaXQgRC9BIGRldmljZSwg
c28gdGhlIFMzMl9MRSBzaG91bGQNCj4gPiBub3QgYmUgaW4gdGhlIHN1cHBvcnRlZCBmb3JtYXQg
bGlzdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmc8c2hlbmdqaXUud2Fu
Z0BueHAuY29tPg0KPiANCj4gSXMgdGhlIGRldmljZSBjYXBhYmxlIG9mIGFjY2VwdGluZyAzMi1i
aXQgc2FtcGxlcywgZXZlbiBpZiBpdCBkb3duZ3JhZGVzIGl0IHRvDQo+IDI0LWJpdCBpbnRlcm5h
bGx5PyAgSWYgc28sIHRoZW4gbWF5YmUgU05EUlZfUENNX0ZNVEJJVF9TMzJfTEUgc2hvdWxkDQo+
IHN0YXkuDQpZZXMsICB0aGUgUzMyX0xFIGNhbiBiZSBhY2NlcHRlZCBieSBkZXZpY2UsIGl0IHNl
ZW1zIGxpa2UgdGhhdCB0aGUgZGV2aWNlIG9ubHkNClVzZSB0aGUgdXBwZXIgMjRiaXQsIHNvIHRo
ZSBTMzJfTEUgcmVzdWx0IGlzIHNhbWUgYXMgUzI0X0xFLCAgZG8geW91IHRoaW5rIHRoZQ0KUzMy
X0xFIHNob3VsZCBiZSByZW1haW5lZD8NCg0KQmVzdCByZWdhcmRzDQpXYW5nIHNoZW5naml1DQoN
Cg0K
