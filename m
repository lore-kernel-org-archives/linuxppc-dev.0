Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57367C6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 13:02:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861E720824
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 13:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="Z1AKCjkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861E720824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hPL51vYLzF3J3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 00:02:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="Z1AKCjkJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=104.47.40.85; helo=nam03-co1-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="Z1AKCjkJ";
 dkim-atps=neutral
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0085.outbound.protection.outlook.com [104.47.40.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hPGy3Pd7zF3H1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 00:00:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxY1LuFZKVsgcWt8pKMW3lUWa2ENbEbGDxFVr68b9fM=;
 b=Z1AKCjkJp5u5joqDBeHf7umplQ6CVpu1QyBWgiSm1qITvhptnkB+iXdmP1dEon0OHQEJi3V38hd4W6vG6EwJgUEaeEwKkq1J5OvwMndfCHWoD1J8vRYODhPyqLSVxABtuZfAHuJDTP9ABsVZLi45muh1GnV2DAGRBbVUMziBXPI=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0511.namprd10.prod.outlook.com (10.162.103.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 13:00:03 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055%3]) with mapi id 15.20.1273.022; Fri, 26 Oct 2018
 13:00:03 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "msuchanek@suse.de"
 <msuchanek@suse.de>
Subject: Re: ethernet "bus" number in DTS ?
Thread-Topic: ethernet "bus" number in DTS ?
Thread-Index: AQHUavBvzf0FONUzZkq6koorQ03jUaUtDssAgAAQjQCAAAT2AIAAycyAgAOTBwA=
Date: Fri, 26 Oct 2018 13:00:03 +0000
Message-ID: <06a88421f9ae95c3bc110f8096e11642f60ea1d1.camel@infinera.com>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
 <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
 <694b6f4f6b66eb35176e3eb48bbec474c9647007.camel@infinera.com>
 <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
 <20181024082239.5ee41017@naga.suse.cz>
In-Reply-To: <20181024082239.5ee41017@naga.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR10MB0511;
 6:ThwtPX4kjR/G/cPXgY7S/JdmrXg558KzkC9DGkSO3ZyKZUAGgCiaMLSZbbtMhdk27I1wBnu4zxbEH726ekqNID29PratAAjsz1yXhyEomvVQdXMXeuvTWj4gm+YuvAWFdS5s8b9gAc3cOL1A97WUdJMZYxwwEmUsL0JwbpfkanwG9i1kRj0jsBmEwaYXBXg1SWK206woMgyvhqOgwrluOD8TFXFhMlecslKodpCLh1qHCV4QjJOFN2Sz/tjCJ5MDqFRhuS3NvXqEaDMyIKM2aDVvKKNz9+5wGWH9pEMvh4TgXI8/fY5gWB1TgUFJFOcxgAxBSiOGz3IBh3D6/93dAmyiDBv7vgu2p4166WvI7toFoFkwYWpOijEIRRJMCbJWfhY0b8DjV9CWO4eYptqcb0THUryhDEwQP5DP8D5UogUiWY3f1+0xPvKJUIFEUvjq5P62MWuT9cgfhqqEJtEQ3Q==;
 5:xN7S22ogVf0QNq5pu0L1V7BIZorHlgjII8QgrgWZdpi6eQIKnfQaeXiJ846mBUjx5Ld1JCM8FZMWBBi+pa9NAbWaA6SbxbnnzLhA/laoAkWLHp8XCjVxk8ela7ln+4X3DR56kL14O6dnXjjxi5m4ffs6li7G1GrYyUz26Eb/NR8=;
 7:1sqmwKLC0DdKh8L9uV+vj69xczHLVDyk0eBrXO6cghXUBikm6fZH7ez7hVgq3TAdTXPHku9bCqjqzQX6ilVT+E8Gpsqx5Wt46qkYrJWDkawOaeUSU7PESR8zwsMTxjfuluJwVWLahdsKXkmj3tEcXTecilVViCcar2Ai/m0pc/XZbFDsMu4sZzod42vhFButvpmtOvFdUT0tb1MhNIwMxqPNm1tF+4KMAlQNP+cgbY4MU8Id4XBpm868PHQ2rKsE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a1a23552-a80e-479b-d3d9-08d63b42f236
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR10MB0511; 
x-ms-traffictypediagnostic: SN1PR10MB0511:
x-microsoft-antispam-prvs: <SN1PR10MB0511B3A322EC5AF2DA8E7367F4F00@SN1PR10MB0511.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:SN1PR10MB0511; BCL:0; PCL:0; RULEID:; SRVR:SN1PR10MB0511; 
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(8936002)(81156014)(93886005)(8676002)(229853002)(7736002)(81166006)(106356001)(6306002)(6512007)(53936002)(5660300001)(105586002)(68736007)(6246003)(6486002)(2906002)(6436002)(5250100002)(14454004)(305945005)(4326008)(39060400002)(25786009)(478600001)(966005)(72206003)(6116002)(3846002)(71190400001)(66574009)(71200400001)(2900100001)(36756003)(118296001)(2616005)(4001150100001)(476003)(446003)(97736004)(11346002)(256004)(486006)(14444005)(86362001)(54906003)(110136005)(76176011)(316002)(6506007)(53546011)(99286004)(5024004)(66066001)(186003)(26005)(2501003)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR10MB0511;
 H:SN1PR10MB0736.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OKaGXL8CZOqxRdgoLf9WhhRZ44yWs+e/CKxdCCNvdqbdD2qM05T12BqXKDH+bXU2k2AP0iA35Xb+EysaylAVOLtg94VIjjBdCkhG4+4FS3diqb9juHCFHtXuCbguAJ1cAbwbew15/+9L6fazr+1dCOdV9yAmhPLbchIo5KECbk6xOKH8kFWZcMV4vypIz7z4L3FYMrS+cig5hT/xTedLVL6jm2KVbWido33mENNhrB5MGMr6rGftlH7mQGPe1Kq+uR4T2vXyplR+lWnionwuFgq0msBok+X4w2eF7fBguP+3yrJkNF92+UezZRpbMPko9TEPp/d7x9Lw9pRmakDzWmHldiHuhziUxRjA1O+SkU8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <17CAFB22B725CD4C9161D5344B9647A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a23552-a80e-479b-d3d9-08d63b42f236
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 13:00:03.6282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0511
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gV2VkLCAyMDE4LTEwLTI0IGF0IDA4OjIyICswMjAwLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3Rl
Og0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBv
cmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IA0KPiBPbiBUdWUsIDIzIE9jdCAyMDE4IDExOjIwOjM2IC0wNzAwDQo+IEZsb3JpYW4g
RmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+ID4gT24gMTAvMjMv
MTggMTE6MDIgQU0sIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMTgt
MTAtMjMgYXQgMTA6MDMgLTA3MDAsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6DQo+ID4gPiBJIGFs
c28gbm90ZWQgdGhhdCB1c2luZyBzdGF0dXMgPSAiZGlzYWJsZWQiIGRpZG4ndCB3b3JrIGVpdGhl
ciB0bw0KPiA+ID4gY3JlYXRlIGEgZml4IG5hbWUgc2NoZW1lLiBFdmVuIHdvcnNlLCBhbGwgdGhl
IGV0aCBJL0YgYWZ0ZXIgZ2V0cw0KPiA+ID4gcmVudW1iZXJlZC4gSXQgc2VlbXMgdG8gbWUgdGhl
cmUgaXMgdmFsdWUgaW4gaGF2aW5nIHN0YWJpbGl0eSBpbg0KPiA+ID4gZXRoIEkvRiBuYW1pbmcg
YXQgYm9vdC4gVGhlbiB1c2Vyc3BhY2UodWRldikgY2FuIHJlbmFtZSBpZiBuZWVkIGJlLg0KPiA+
ID4gDQo+ID4gPiBTdXJlIHdvdWxkIGxpa2UgdG8ga25vd24gbW9yZSBhYm91dCB3aHkgdGhpcyBm
ZWF0dXJlIGlzIG5vdCB3YW50ZWQgPw0KPiA+ID4gDQo+ID4gPiBJIGZvdW5kDQo+ID4gPiAgIGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvNDEyMjQ0MS8NCj4gPiA+IFlvdSBxdW90
ZSBwb2xpY3kgYXMgcmVhc29uIGJ1dCBzdXJlbHkgaXQgbXVzdCBiZSBiZXR0ZXIgdG8NCj4gPiA+
IGhhdmUgc29tZXRoaW5nIHN0YWJsZSwgY29ubmVjdGVkIHRvIHRoZSBoYXJkd2FyZSBuYW1lLCB0
aGFuDQo+ID4gPiBzZW1pcmFuZG9tIG5hbWluZz8NCj4gPiANCj4gPiBJZiB0aGUgRGV2aWNlIFRy
ZWUgbm9kZXMgYXJlIG9yZGVyZWQgYnkgYXNjZW5kaW5nIGJhc2UgcmVnaXN0ZXINCj4gPiBhZGRy
ZXNzLCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgeW91IGdldCB0aGUgc2FtZSBvcmRlciBhcyBm
YXIgYXMNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgY3JlYXRpb24gZ29lcywgdGhpcyBtYXkgbm90IGJl
IHRydWUgaW4gdGhlIGZ1dHVyZSBpZg0KPiA+IFJvYiBkZWNpZGVzIHRvIHJhbmRvbWl6ZSB0aGF0
LCBidXQgQUZBSUNUIHRoaXMgaXMgc3RpbGwgdHJ1ZS4gVGhpcw0KPiA+IG1heSBub3Qgd29yayB3
ZWxsIHdpdGggc3RhdHVzID0gZGlzYWJsZWQgcHJvcGVydGllcyBiZWluZyBpbnNlcnRlZA0KPiA+
IGhlcmUgYW5kIHRoZXJlLCBidXQgd2UgaGF2ZSB1c2VkIHRoYXQgaGVyZSBhbmQgaXQgaGFzIHdv
cmtlZCBmb3IgYXMNCj4gPiBmYXIgYXMgSSBjYW4gcmVtZW1iZXIgZG9pbmcgaXQuDQo+IA0KPiBT
byB0aGlzIGlzIHVuc3RhYmxlIGluIHNldmVyYWwgcmVzcGVjdHMuIEZpcnN0IGlzIGNoYW5naW5n
IHRoZQ0KPiBlbmFibGVkL2Rpc2FibGVkIHN0YXR1cyBpbiB0aGUgZGVpdmVjZXRyZWVzIHByb3Zp
ZGVkIGJ5IHRoZSBrZXJuZWwuDQo+IA0KPiBTZWNvbmQgaXMgaWYgeW91IGhhdmUgaGFyZHdhcmUg
aG90cGx1ZyBtZWNoYW5pc20gZWl0aGVyIGJ5IGZpcm13YXJlIG9yDQo+IGJ5IGxvYWRpbmcgZGV2
aWNlIG92ZXJsYXlzLg0KPiANCj4gVGhpcmQgaXMgdGhlIGNhc2Ugd2hlbiB0aGUgZGV2aWNldHJl
ZSBpcyBub3QgYnVpbHQgYXMgcGFydCBvZiB0aGUNCj4ga2VybmVsIGJ1dCBpcyBpbnN0ZWFkIHBy
b3ZpZGVkIGJ5IGZpcm13YXJlIHRoYXQgaW5pdGlhbGl6ZXMgdGhlDQo+IGxvdy1sZXZlbCBoYXJk
d2FyZSBkZXRhaWxzLiBUaGVuIHRoZSBvcmRlcmluZyBieSBhZGRyZXNzIGlzIG5vdA0KPiBndWFy
YW50ZWVkIG5vciBpcyB0aGF0IHRoZSBzYW1lIGFkZHJlc3Mgd2lsbCBiZSB1c2VkIHRvIGFjY2Vz
cyB0aGUgc2FtZQ0KPiBpbnRlcmZhY2UgZXZlcnkgdGltZS4gVGhlcmUgbWlnaHQgYmUgbXVsdGlw
bGUgd2F5cyB0byBjb25maWd1cmUgdGhlDQo+IGhhcmR3YXJlIGRlcGVuZGluZyBvbiBmaXJtd2Fy
ZSBjb25maWd1cmF0aW9uIGFuZC9vciB2ZXJzaW9uLg0KPiANCj4gDQo+ID4gU2Vjb25kLCB5b3Ug
bWlnaHQgd2FudCB0byBuYW1lIG5ldHdvcmsgZGV2aWNlcyBldGhYLCBidXQgd2hhdCBpZiBJDQo+
ID4gd2FudCB0byBuYW1lIHRoZW0gZXRoZXJuZXRYIG9yIGZvb1ggb3IgYmFyWD8gU2hvdWxkIHdl
IGJlIGFjY2VwdGluZyBhDQo+ID4gbWVjaGFuaXNtIGluIHRoZSBrZXJuZWwgdGhhdCB3b3VsZCBh
bGxvdyBzb21lb25lIHRvIG5hbWUgdGhlDQo+ID4gaW50ZXJmYWNlcyB0aGUgd2F5IHRoZXkgd2Fu
dCBzdHJhaWdodCBmcm9tIGEgbmFtZSBiZWluZyBwcm92aWRlZCBpbg0KPiA+IERldmljZSBUcmVl
Pw0KDQpKdXN0IHRvIGJlIGNsZWFyLCBJIGFtIHNheWluZyB0aGF0IHdlIGRvbid0IG5lZWQgdG8g
Y29udHJvbCB0aGUgZnVsbA0KbmFtZSBvZiB0aGUgRXRoZXJuZXQgZGV2aWNlLCBqdXN0IHRoZSBu
dW1lcmljYWwgaWQgc28gb25lIGNhbiB0aWUgZXRoMA0KdG8gYSBmaXhlZCBwaHlzaWNhbCBkZXZp
Y2UuDQoNCj4gDQo+IENsZWFybHkgaWYgdGhlcmUgaXMgdGV4dCBFdGhlcm5ldDEgcHJpbnRlZCBh
Ym92ZSB0aGUgRXRoZXJuZXQgcG9ydCB3ZQ0KPiBzaG91bGQgcHJvdmlkZSBhIG1lY2hhbmlzbSB0
byBuYW1lIHRoZSBwb3J0IEV0aGVybmV0MSBieSBkZWZhdWx0Lg0KPiANCj4gPiBBbGlhc2VzIGFy
ZSBmaW5lIGZvciBwcm92aWRpbmcgcmVsYXRpdmUgc3RhYmlsaXR5IHdpdGhpbiB0aGUgRGV2aWNl
DQo+ID4gVHJlZSBpdHNlbGYgYW5kIGJvb3QgcHJvZ3JhbXMgdGhhdCBtaWdodCBuZWVkIHRvIG1v
ZGlmeSB0aGUgRGV2aWNlDQo+ID4gVHJlZSAoZS5nOiBpbnNlcnRpbmcgTUFDIGFkZHJlc3Nlcykg
c3VjaCB0aGF0IHlvdSBkb24ndCBoYXZlIHRvDQo+ID4gZW5jb2RlIGxvZ2ljIHRvIHNlYXJjaCBm
b3Igbm9kZXMgYnkgY29tcGF0aWJsZSBzdHJpbmdzIGV0Yy4gYnV0DQo+ID4gb3V0c2lkZSBvZiB0
aGF0IHVzZSBjYXNlLCBpdCBzZWVtcyB0byBtZSB0aGF0IHlvdSBjYW4gcmVzb2x2ZSBldmVyeQ0K
PiA+IG5hbWluZyBkZWNpc2lvbiBpbiB1c2VyLXNwYWNlLg0KPiANCj4gSG93ZXZlciwgdGhpcyBp
cyBwdXNoaW5nIHBsYXRmb3JtLXNwZWNpZmljIGtub3dsZWRnZSB0byB1c2Vyc3BhY2UuIFRoZQ0K
PiB3YXkgdGhlIEV0aGVybmV0IGludGVyZmFjZSBpcyBhdHRhY2hlZCBhbmQgaGVuY2UgdGhlIGRl
dmljZSBwcm9wZXJ0aWVzDQo+IHVzYWJsZSBmb3IgaWRlbnRpZnlpbmcgdGhlIGRldmljZSB1bmlx
dWVseSBhcmUgcGxhdGZvcm0tc3BlY2lmaWMuDQo+IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgYWxp
YXNlcyBhcmUgdW5pdmVyc2FsIHdoZW4gcHJvdmlkZWQuIElmIHRoZXkgYXJlDQo+IGdvb2QgZW5v
dWdoIHRvIGFzc2lnbiBhIE1BQyBhZGRyZXNzIHRoZXkgYXJlIGdvb2QgZW5vdWdoIHRvIHByb3Zp
ZGUgYQ0KPiBzdGFibGUgZGVmYXVsdCBuYW1lLg0KPiANCj4gSSB0aGluayB0aGlzIGlzIGluZGVl
ZCBmb3JjaW5nIHRoZSB1c2Vyc3BhY2UgdG8gcmVpbnZlbnQgc2V2ZXJhbCB3aGVlbHMNCj4gZm9y
IG5vIGdvb2QgcmVhc29uLg0KPiANCj4gV2hhdCBpcyB0aGUgcHJvYmxlbSB3aXRoIGFkZGluZyB0
aGUgYWxpYXNlcz8NCg0KV2VsbCBwdXQgYWJvdmUsIHRoYW5rcy4NCg0KICAgSm9ja2UNCg==
