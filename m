Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F712C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 14:52:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7C5206A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 14:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IDFFvXe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7C5206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JPHy2xC9zDqYq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 01:51:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IDFFvXe8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=nam01-bn3-obe.outbound.protection.outlook.com
 (client-ip=40.107.74.88; helo=nam01-bn3-obe.outbound.protection.outlook.com;
 envelope-from=thomas.lendacky@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amdcloud.onmicrosoft.com
 header.i=@amdcloud.onmicrosoft.com header.b="IDFFvXe8"; 
 dkim-atps=neutral
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740088.outbound.protection.outlook.com [40.107.74.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JPDm2WqfzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 01:49:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKL5tBGkn5Y9r8xqP5e4PG04hWvfwsFkrodT+75IWX0=;
 b=IDFFvXe83emwkUno3lvkdf6Pe2P0XDr3B5e16jY4W/vRybeuaHSjeDX/l2/H8Atn9kI7RWj1jiB+sF3crXdnuzYWCUc3j5TsNKCG5iyJilx/14KZ4I+B46UPtYJibsU/QAR4FDNaI5LRdGm96H/ALK9/U19ZCW2NO7kyMHN1DYA=
Received: from BN8PR12MB3618.namprd12.prod.outlook.com (20.178.212.89) by
 BN8PR12MB3556.namprd12.prod.outlook.com (20.178.212.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.21; Mon, 17 Dec 2018 14:49:00 +0000
Received: from BN8PR12MB3618.namprd12.prod.outlook.com
 ([fe80::ddea:c6fd:f21e:d842]) by BN8PR12MB3618.namprd12.prod.outlook.com
 ([fe80::ddea:c6fd:f21e:d842%5]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:49:00 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Thread-Topic: [PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Thread-Index: AQHUkzZYZbIHsqBVPUqwArkjtx2NOqV/ot4AgAID2ACAAWIkgA==
Date: Mon, 17 Dec 2018 14:49:00 +0000
Message-ID: <1423e1f4-425f-433e-6b85-0240b2f03aa2@amd.com>
References: <20181213225110.6567.69313.stgit@tlendack-t1.amdoffice.net>
 <20181215105510.GA1806@lst.de> <6954879c-90df-b6bd-7925-f0985980ed18@amd.com>
In-Reply-To: <6954879c-90df-b6bd-7925-f0985980ed18@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0073.prod.exchangelabs.com (2603:10b6:800::41) To
 BN8PR12MB3618.namprd12.prod.outlook.com
 (2603:10b6:408:49::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN8PR12MB3556;
 20:vxxu9ZZOHcrHzTpumZg+D40VXYhb+DgWWBiRIfY72NjOBaOuhBnjfGvzo4ONTQbLAYR+M4emQarzKgDCfiNijWFCKQmWmqWFEeSsgaYUEziQG2CMO3/2IKlL43aZprnjaheLsEYtRemC8dErS+ERRLVBSTcivKajemAu4pt3wrtloBwMPosWIWM61UIdJ+LELoTDuNW1WPDfjPvzggVJ7yVhvwMyYl0b1OSm/zqteX8rVZPOts/OdEhN12rLUcw3
x-ms-office365-filtering-correlation-id: c3ad9551-16e9-41bf-66de-08d6642ec792
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:BN8PR12MB3556; 
x-ms-traffictypediagnostic: BN8PR12MB3556:
x-microsoft-antispam-prvs: <BN8PR12MB35568E7C82A37E0ED458C35BECBC0@BN8PR12MB3556.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BN8PR12MB3556; BCL:0; PCL:0; RULEID:; SRVR:BN8PR12MB3556; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(39060400002)(2906002)(25786009)(54906003)(316002)(53546011)(76176011)(68736007)(97736004)(6246003)(26005)(71190400001)(6506007)(71200400001)(386003)(8936002)(36756003)(478600001)(186003)(446003)(6436002)(106356001)(105586002)(5660300001)(4326008)(66066001)(8676002)(81166006)(81156014)(2616005)(102836004)(305945005)(72206003)(14454004)(99286004)(256004)(229853002)(31686004)(486006)(6116002)(86362001)(3846002)(31696002)(52116002)(11346002)(53936002)(6916009)(6512007)(476003)(6486002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3556;
 H:BN8PR12MB3618.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dq0FP9bM8URUTSML2TgWs6cCwjBKYLgTbLHWrUg2i2lJ+0HQs4HeMMDlAedXFgel2EyvTKZRxiqHLo7sMmF8AzOjfFUdSRun9suZAbEbFKLZVFExNMZeXu6OMcChTrtfrN+7PwyGRAcJPTtqWLDJSHf5lOSm5+REY6SwYwn2Snhj0+b03JuIUMiLyY1GdaU2zI0WlyRdWu5CrBgpNhimEUHhM8m0MVYh62WE7KfTMAgW5YeSmZjkgKpQAvVOoXGPN2EigjYyLGNtXe34K7TsB1WB8sFqEVH5Cx04oTf9ddenNqq+bXV239e9BoZBV3r2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABB1DF475B806A40A44904ACA6139D3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ad9551-16e9-41bf-66de-08d6642ec792
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:49:00.2475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3556
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>, Robin Murphy <robin.murphy@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMTIvMTYvMjAxOCAwNTo0MSBQTSwgVG9tIExlbmRhY2t5IHdyb3RlOg0KPiBPbiAxMi8xNS8y
MDE4IDA0OjU1IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IFRoZSBtYWlsIHNlZW1z
IHRvIGJlIHNvIG9kZGx5IGVuY29kZWQgc28gdGhhdCBnaXQtYW0gZmFpbHMgb24gaXQuICBDYW4N
Cj4+IHlvdSByZXNlbmQgYXMgcGxhaW4gdGV4dD8NCj4gDQo+IEhtbW0uLi4gbm90IHN1cmUgd2hh
dCBoYXBwZW5lZCB3aXRoIHRoYXQsIGJ1dCB5ZWFoLCBsb29raW5nIGF0IHRoZSBtZXNzYWdlDQo+
IHNvdXJjZSBzaG93cyBzb21ldGhpbmcgc3RyYW5nZSB3ZW50IG9uLiBMZXQgbWUgdGFrZSBhIGxv
b2sgYW5kIEknbGwgdHJ5IHRvDQo+IGdldCBhIGdvb2QgdmVyc2lvbiB0byB5b3UgdG9tbW9yb3cg
KE1vbmRheSkuDQoNCk11c3QgaGF2ZSBiZWVuIHNvbWV0aGluZyB3aXRoIHN0Z2l0Li4uIGp1c3Qg
cmVzZW50IHVzaW5nIGdpdCBmb3JtYXQtcGF0Y2gNCmFuZCBnaXQgc2VuZC1lbWFpbCBhbmQgaXQg
bG9va3Mgb2suICBMZXQgbWUga25vdyBpZiBpdCdzIHN0aWxsIG5vdCByaWdodA0Kd2hlbiBpdCBn
ZXRzIHRvIHlvdS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+IFRoYW5rcywNCj4gVG9tDQo+IA0K
Pj4NCg==
