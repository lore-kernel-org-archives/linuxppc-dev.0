Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11890C282C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 02:35:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8C12083B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 02:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S4WpVi30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8C12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yVHx2NDXzDqMx
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 13:35:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe09::621;
 helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=peng.ma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="S4WpVi30"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on0621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yVFy5MsVzDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 13:33:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cb0k59MVJ4yDFqOMXzLFWHd7Vzqmh+NodLNCSNGq+U=;
 b=S4WpVi306wepg/V8FIHc7budOBIR/crQ6TCYskOVgmmkazbalRjtn7RBY1yyxPYgkjF4Pu8YGns+OJ5VZu2Fn+C9sbEhk4I+tbdfYlmLPf/K/XsI67DXFFllY6TUVOz+9AsOT5gRbOs7HPgf9CBdYApejIX+zRTbJ8AFd7RiOnI=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5615.eurprd04.prod.outlook.com (20.178.125.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 02:33:18 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84%4]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 02:33:18 +0000
From: Peng Ma <peng.ma@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Subject: RE: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Thread-Topic: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Thread-Index: AQHUma+xGuaZ+ksRL0q+1ylDeGrWfKWNQCqggAAThICAAAqV0IApW8SAgAj0qfCAD9QqgIAKrdzA
Date: Mon, 11 Feb 2019 02:33:18 +0000
Message-ID: <VI1PR04MB4431C8A4E3E097E6A161B7ABED640@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181222043445.GA29462@home.buserror.net>
 <VI1PR04MB443154AEE42853B62234075EEDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <193b66f8bcc52c4900144b4cd742cacd001c9830.camel@buserror.net>
 <VI1PR04MB4431C33B5155312CF7035584EDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190119125841.GE4635@vkoul-mobl>
 <VI1PR04MB44311D9A8F8CD3A0143BCC99ED9B0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190204072741.GK4296@vkoul-mobl>
In-Reply-To: <20190204072741.GK4296@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5615;
 6:2vr/rsQG+0zkPwV4SliKOmmuYhEF1GeeUTa0agj3lezXi1jmljgsf6mifeoz+cSbNWM/fkVcZdG9W6bq2jNpZei7dwvsqDiEPsYnCdt+Sza1sZWPpxxMrpf1GVx6/DIjYghYvbJdbPkHdG2W2V8pmvwsLyv2+1yO3YXepff9P0UWjx12yWhu5HS4jk1wBY6gPTb1ing6zolNL8RjrmDOU0kinX4TTSvGjbk6uKPF1GFFO/j9vUcbqVhXamr20rDwxo2S2nw0dyEpXJNszted58Td1srzfb8Z+Jx7wfDGms0W7tsq6ZmHn0jJL7UFCqVGd5RTqFAmxUwfo5Cl5x0BynFD6hjDDoy9j7D9QA1BBu/h9z5afKY9UyTFklgbpTpSUzmHmuTiw9r1JBpulNJSHXvv8XlKFDWmafLEoH1XjhJLZEIkTLpPq4zdN/swSmIiLDBJCn/JchtiLMGkadm1Aw==;
 5:sgsDVu6hSmwIb0VAsPSdW7BLPB1zma8nj44oQ+fCe+NB5hkbquLqWSi0jh/47us3Ql82bCc1ZuKt++FNY8f3fkEKQmcmyV6H5NOqZtXfVtxaXuJ1oEVRatfH6fSoYvzlIig8hswJ9MTcNakOQd78DioumNUdYZ60DfoDqDcD2DuRgTi4mKAZ6Hd30lJIN7XLvUQnUuGGInPewS5EuYMC3Q==;
 7:bMGFlZxwYzHFGF4dejRWAAGBJ7UFTOoWifXG7+ucJObpswIRS86cNIAWckrQiHGdozFSYmD6bA7nS4NOxRuizHSIXserNLvTBPhq9RkSD6EDSLPTDdkoCmu84fMSuZPrINqKigv/P3c0gjPEamILuQ==
x-ms-office365-filtering-correlation-id: fd6bab24-db1c-4b91-46bd-08d68fc94862
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5615; 
x-ms-traffictypediagnostic: VI1PR04MB5615:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB5615A783ACD05E45196E4929ED640@VI1PR04MB5615.eurprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(13464003)(102836004)(6506007)(99286004)(71190400001)(71200400001)(97736004)(3846002)(6246003)(53936002)(6116002)(478600001)(256004)(45080400002)(26005)(229853002)(33656002)(6436002)(9686003)(186003)(7696005)(93886005)(7736002)(55016002)(6306002)(305945005)(76176011)(8676002)(66066001)(486006)(2906002)(81166006)(81156014)(44832011)(68736007)(446003)(476003)(11346002)(106356001)(8936002)(966005)(25786009)(14454004)(6916009)(4326008)(105586002)(86362001)(54906003)(74316002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5615;
 H:VI1PR04MB4431.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Oi+My5gara96D3UytlqPil21lK7elQDkFgEDiWWF4kXQ1Z180wSczfFJJqrtHm0oXoQHx/WZGKLNFcmlkmuYAqMvU9JwfwAlBTg2qILMpnIL4bCMP5lMFaB9hhUW6CDs1nXu/i+otE1UYbND323W4jZVrMLE206sFsmt1rzIOiJRuu92gbNGAlFlJ3ltbXvjEHAMEeEBQg78g67hSm3zx+pwlodKIyEGl6yL1+oOz1GlZbdPH3e9WhxX849KuqnMtu2K8YXumaWzvylGuaFy2R/Y8INyoqNLVLBrCtca5FYcgcfA05eSblJgrpFMpr05JCqSHNHcq8O/IEbgVZq2U2SQMlcBL9kAE08BJXZKGcm+gIfW3zYoivELdFOSPlrnp9sTzs7iPyMKvTDFOvgmohn6x1ZV3VZOSnPW7lTgMR4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6bab24-db1c-4b91-46bd-08d68fc94862
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 02:33:18.4392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5615
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
Cc: Wen He <wen.he_1@nxp.com>, Leo Li <leoyang.li@nxp.com>,
 Scott Wood <oss@buserror.net>, Zhang Wei <zw@zh-kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgVmlub2QsDQoNCkdvdCBpdC4NCg0KQmVzdCBSZWdhcmRzDQpQZW5nDQoNCj4tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+
U2VudDogMjAxOcTqMtTCNMjVIDE1OjI4DQo+VG86IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4N
Cj5DYzogU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD47IExlbyBMaSA8bGVveWFuZy5saUBu
eHAuY29tPjsgWmhhbmcgV2VpDQo+PHp3QHpoLWtlcm5lbC5vcmc+OyBsaW51eHBwYy1kZXZAbGlz
dHMub3psYWJzLm9yZzsNCj5kbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBXZW4gSGUgPHdlbi5o
ZV8xQG54cC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZG1hZW5naW5lOiBmc2xkbWE6IEFk
ZCA2NC1iaXQgSS9PIGFjY2Vzc29ycyBmb3INCj5wb3dlcnBjNjQNCj4NCj5PbiAyNS0wMS0xOSwg
MDU6NTQsIFBlbmcgTWEgd3JvdGU6DQo+PiBIaSBWaW5vZCwNCj4+DQo+PiBTb3JyeSB0byByZXBs
YXkgbGF0ZS4NCj4+IDE6VGhpcyBwYXRjaCBoYXMgYWxyZWFkeSBzZW5kIHRvIHRoZSBwYXRjaHdv
cmsuDQo+PiAJUGxlYXNlIHNlZSB0aGUgcGF0Y2ggbGluazoNCj4+IGh0dHBzOi8vZW1lYTAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXQNCj4+
DQo+Y2h3b3JrLmtlcm5lbC5vcmclMkZwYXRjaCUyRjEwNzQxNTIxJTJGJmFtcDtkYXRhPTAyJTdD
MDElN0NwZW5nLg0KPm1hJTQwbg0KPj4NCj54cC5jb20lN0M1ZDE2OWU5YmM1Njg0YTlkMTRjMDA4
ZDY4YTcyNzU4OSU3QzY4NmVhMWQzYmMyYjRjNmZhOTINCj5jZDk5YzVjDQo+Pg0KPjMwMTYzNSU3
QzAlN0MwJTdDNjM2ODQ4NjIxNTQ2ODMzMDk1JmFtcDtzZGF0YT1xMXNUYUMlMkY0U3FFdE0NCj55
Rnltenl2WGUNCj4+IHFCT2hDbkJqeU1jalB6OEE5UVJJNCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPj4g
MjpJIGhhdmUgYWxyZWFkeSBjb21waWxlIHRoZSBmc2wgcGF0Y2hlcyBvbiBhcm0gYW5kIHBvd2Vy
cGMgYWZ0ZXIgcGF0Y2hlZA0KPmh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjaA0KPndvcmsua2VybmVsLm9yZyUyRnBh
dGNoJTJGMTA3NDE1MjElMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3BlbmcubWENCj4lNDBueHAuY29t
JTdDNWQxNjllOWJjNTY4NGE5ZDE0YzAwOGQ2OGE3Mjc1ODklN0M2ODZlYTFkM2JjMmI0Yw0KPjZm
YTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODQ4NjIxNTQ2ODMzMDk1JmFtcDtzZGF0YT1x
MXNUYQ0KPkMlMkY0U3FFdE15Rnltenl2WGVxQk9oQ25CanlNY2pQejhBOVFSSTQlM0QmYW1wO3Jl
c2VydmVkPTANCj4+IAlUaGUgY29tcGlsZSB3aWxsIHN1Y2Nlc3NmdWwsIHBsZWFzZSBsZXQgbWUg
a25vdyB0aGUgcmVwb3J0ZWQgcmVncmVzc2lvbg0KPnJlc3VsdHMsIHRoYW5rcyB2ZXJ5IG11Y2gu
DQo+DQo+QW5kIEkgdGhvdWdodCB0aGVyZSB3ZXJlIGZ1cnRoZXIgY29tbWVudHMgIG9uIHRoaXMg
cGF0Y2guIEkgaGF2ZSBhcHBsaWVkIHRoaXMsDQo+cGxlYXNlIHdhdGNoIGZvciBmYWlsdXJlcyBy
ZXBvcnRlZCBpZiBhbnkuLg0KPi0tDQo+flZpbm9kDQo=
