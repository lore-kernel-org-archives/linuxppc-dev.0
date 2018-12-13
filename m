Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FA0C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 22:53:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE392086D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 22:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JS7zdCGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE392086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43G89p1fXyzDqSB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 09:53:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JS7zdCGC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=nam04-sn1-obe.outbound.protection.outlook.com
 (client-ip=40.107.70.48; helo=nam04-sn1-obe.outbound.protection.outlook.com;
 envelope-from=thomas.lendacky@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amdcloud.onmicrosoft.com
 header.i=@amdcloud.onmicrosoft.com header.b="JS7zdCGC"; 
 dkim-atps=neutral
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43G86x5bmMzDr1X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 09:51:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ13NgBdxOnFKX1ViClP+b8HpgQ0r6BC0pmboxTEr2w=;
 b=JS7zdCGCVctBw1voClXgr2pFzsxZ2WYRGCwM+rKujIhxdTi0wbNJkaQnDBxZYsQr4Fm2xt1jRdW00aBLtcT+asVau+D45F9v165ihyEZEWLV1WraqWPp1gMEFGYOZXpZDnxb25DfKri201PWXz6pFJ8MJ56uzeTsjtBLOXQ0X8k=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0767.namprd12.prod.outlook.com (10.164.26.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 13 Dec 2018 22:51:12 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 22:51:12 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Thread-Topic: [PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Thread-Index: AQHUkzZYZbIHsqBVPUqwArkjtx2NOg==
Date: Thu, 13 Dec 2018 22:51:12 +0000
Message-ID: <20181213225110.6567.69313.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:803:20::15) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR12MB0767;
 20:I0ZpezcbJNdqj30zr2Uk8wzlqMd6lYFagxzTY8CoEbD1S9cp7PavofUTKOzamIsgTa5fEiYaJPeccZP/HVsEgYsZbfs+j6I137MwwAfYmthmllRTHuA4ciAIB8DFxxjN79OyQ9TPWAMER7qmoYh+/3tLamhKuZhfmxNMp7mrxIEJg2UEJ0oqlBVjeBI0eyH/3Ui/8+218yf3gxGzKl1Cy2WrT1XVNv2i6lqZk+gy4jNfUOU7TkGYvTFVckfXVO20
x-ms-office365-filtering-correlation-id: afb0eaa0-c299-4a0f-5dc0-08d6614d7aee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR12MB0767; 
x-ms-traffictypediagnostic: SN1PR12MB0767:
x-microsoft-antispam-prvs: <SN1PR12MB076713C09A51434CF0A31E2FECA00@SN1PR12MB0767.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:SN1PR12MB0767; BCL:0; PCL:0; RULEID:; SRVR:SN1PR12MB0767; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(3846002)(6116002)(97746001)(1076002)(5660300001)(6436002)(2906002)(316002)(6916009)(106356001)(478600001)(476003)(66066001)(68736007)(97736004)(103116003)(14444005)(256004)(71190400001)(71200400001)(486006)(99286004)(33896004)(5640700003)(575784001)(86362001)(6512007)(8936002)(53936002)(186003)(9686003)(305945005)(7736002)(2351001)(25786009)(2501003)(6506007)(386003)(26005)(54906003)(8676002)(39060400002)(4326008)(81166006)(1730700003)(81156014)(52116002)(14454004)(102836004)(105586002)(6486002)(72206003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB0767;
 H:SN1PR12MB0175.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6zkrdLhunDhEwPYdxiqOZJI2zTutKZEe0qlQtWotPx63GixHJdVs+EyBXKcP67Pa47VUZhkHFOD4aKI0lrs1hAzqP7n6+uotfWfd35R1SwLwn7VonJlt0J9eRSqZ/YTEsfDv1iv99SuyvXlA8LYbobSteteBFFoIRj7qk3QjX0fii9d5GIa8LU5Ux2Xoan5aegrNmJEKA5hdiAAqcLaz1f3Q81s+ikUgCOZvPoEYBZKtOnFQwMjUlLNq3Vcy+KgOJETKDLC6iLZTI9cQ3g7p2YgAABujBy7mxZb1qBVV+o+sav1980yiiLoY0m9eWwuv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D87B982A8810C41AD4B5C04C918B735@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb0eaa0-c299-4a0f-5dc0-08d6614d7aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 22:51:12.7435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0767
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
 Alexander Duyck <alexander.duyck@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

VGhlIGRtYV9kaXJlY3Rfc3VwcG9ydGVkKCkgZnVuY3Rpb24gaW50ZW5kcyB0byBjaGVjayB0aGUg
RE1BIG1hc2sgYWdhaW5zdA0Kc3BlY2lmaWMgdmFsdWVzLiBIb3dldmVyLCB0aGUgcGh5c190b19k
bWEoKSBmdW5jdGlvbiBpbmNsdWRlcyB0aGUgU01FDQplbmNyeXB0aW9uIG1hc2ssIHdoaWNoIGRl
ZmVhdHMgdGhlIGludGVuZGVkIHB1cnBvc2Ugb2YgdGhlIGNoZWNrLiBUaGlzDQpyZXN1bHRzIGlu
IGRyaXZlcnMgdGhhdCBzdXBwb3J0IGxlc3MgdGhhbiA0OC1iaXQgRE1BIChTTUUgZW5jcnlwdGlv
biBtYXNrDQppcyBiaXQgNDcpIGZyb20gYmVpbmcgYWJsZSB0byBzZXQgdGhlIERNQSBtYXNrIHN1
Y2Nlc3NmdWxseSB3aGVuIFNNRSBpcw0KYWN0aXZlLCB3aGljaCByZXN1bHRzIGluIHRoZSBkcml2
ZXIgZmFpbGluZyB0byBpbml0aWFsaXplLg0KDQpDaGFuZ2UgdGhlIGZ1bmN0aW9uIHVzZWQgdG8g
Y2hlY2sgdGhlIG1hc2sgZnJvbSBwaHlzX3RvX2RtYSgpIHRvDQpfX3BoeXNfdG9fZG1hKCkgc28g
dGhhdCB0aGUgU01FIGVuY3J5cHRpb24gbWFzayBpcyBub3QgcGFydCBvZiB0aGUgY2hlY2suDQoN
CkZpeGVzOiBjMWQwYWYxYTFkNWQgKCJrZXJuZWwvZG1hL2RpcmVjdDogdGFrZSBETUEgb2Zmc2V0
IGludG8gYWNjb3VudCBpbiBkbWFfZGlyZWN0X3N1cHBvcnRlZCIpDQpTaWduZWQtb2ZmLWJ5OiBU
b20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KLS0tDQoga2VybmVsL2RtYS9k
aXJlY3QuYyB8ICAgIDcgKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvZGlyZWN0LmMgYi9rZXJu
ZWwvZG1hL2RpcmVjdC5jDQppbmRleCAyMmExMmFiLi4zNzVjNzdlIDEwMDY0NA0KLS0tIGEva2Vy
bmVsL2RtYS9kaXJlY3QuYw0KKysrIGIva2VybmVsL2RtYS9kaXJlY3QuYw0KQEAgLTMwOSw3ICsz
MDksMTIgQEAgaW50IGRtYV9kaXJlY3Rfc3VwcG9ydGVkKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0
IG1hc2spDQogDQogCW1pbl9tYXNrID0gbWluX3QodTY0LCBtaW5fbWFzaywgKG1heF9wZm4gLSAx
KSA8PCBQQUdFX1NISUZUKTsNCiANCi0JcmV0dXJuIG1hc2sgPj0gcGh5c190b19kbWEoZGV2LCBt
aW5fbWFzayk7DQorCS8qDQorCSAqIFRoaXMgY2hlY2sgbmVlZHMgdG8gYmUgYWdhaW5zdCB0aGUg
YWN0dWFsIGJpdCBtYXNrIHZhbHVlLCBzbw0KKwkgKiB1c2UgX19waHlzX3RvX2RtYSgpIGhlcmUg
c28gdGhhdCB0aGUgU01FIGVuY3J5cHRpb24gbWFzayBpc24ndA0KKwkgKiBwYXJ0IG9mIHRoZSBj
aGVjay4NCisJICovDQorCXJldHVybiBtYXNrID49IF9fcGh5c190b19kbWEoZGV2LCBtaW5fbWFz
ayk7DQogfQ0KIA0KIGludCBkbWFfZGlyZWN0X21hcHBpbmdfZXJyb3Ioc3RydWN0IGRldmljZSAq
ZGV2LCBkbWFfYWRkcl90IGRtYV9hZGRyKQ0KDQo=
